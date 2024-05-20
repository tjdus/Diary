package com.example.demo.controller;


import com.example.demo.domain.Post;
import com.example.demo.domain.dto.PostRequestDTO;
import com.example.demo.domain.dto.PostResponseDTO;
import com.example.demo.repository.PostRepository;
import com.example.demo.service.PostService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.junit4.SpringRunner;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;


@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
@AutoConfigureMockMvc
public class PostControllerTest {
    @Autowired
    public MockMvc mockMvc;
    @Autowired
    public PostService postService;
    public static void main(String[] args) {

    }

    @Test
    public void createQuestion() {
        PostRequestDTO postRequestDTO = PostRequestDTO.builder()
                .title("title")
                .content("content")
                .build();
        PostResponseDTO createdPost = postService.createPost(postRequestDTO);
        assertEquals("title", createdPost.getTitle());
        assertEquals("content", createdPost.getContent());
    }

    @Test
    public void updateQuestion() {
        PostRequestDTO initialRequestDTO = PostRequestDTO.builder()
                .title("title")
                .content("content")
                .build();
        PostResponseDTO initialPost = postService.createPost(initialRequestDTO);

        // Update the created post
        Long postId = initialPost.getId(); // Assuming the response contains an ID
        PostRequestDTO updateRequestDTO = PostRequestDTO.builder()
                .title("updated title")
                .content("updated content")
                .build();
        PostResponseDTO updatedPost = postService.updatePost(postId, updateRequestDTO);

        // Assert that the updated post's title and content match the updated values
        assertEquals("updated title", updatedPost.getTitle());
        assertEquals("updated content", updatedPost.getContent());
    }

    @Test
    public void deleteQuestion() {
        PostRequestDTO postRequestDTO = PostRequestDTO.builder()
                .title("title")
                .content("content")
                .build();
        PostResponseDTO createdPost = postService.createPost(postRequestDTO);

        Long id = createdPost.getId();

        postService.deletePost(id);
    }

    @Test
    public void getQuestion() {
        PostRequestDTO postRequestDTO = PostRequestDTO.builder()
                .title("title")
                .content("content")
                .build();
        PostResponseDTO createdPost = postService.createPost(postRequestDTO);

        Long id = createdPost.getId();

        PostResponseDTO post = postService.findPostById(id);
        assertEquals("title", post.getTitle());
        assertEquals("content", post.getContent());
    }


}
