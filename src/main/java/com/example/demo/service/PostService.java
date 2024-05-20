package com.example.demo.service;

import com.example.demo.domain.Post;
import com.example.demo.domain.dto.PostRequestDTO;
import com.example.demo.domain.dto.PostResponseDTO;
import com.example.demo.repository.PostRepository;
import lombok.Builder;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Builder
@RequiredArgsConstructor
@Service
public class PostService {
    private final PostRepository postRepository;

    public PostResponseDTO createPost(PostRequestDTO postRequestDTO) {
        Post post = Post.builder()
                .title(postRequestDTO.getTitle())
                .content(postRequestDTO.getContent())
                .build();
        postRepository.save(post);
        return post.toDTO();

    }

    public PostResponseDTO findPostById(Long id) {
        Post post = postRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        return post.toDTO();
    }

    public PostResponseDTO updatePost(Long id, PostRequestDTO postRequestDTO) {
        Post post = postRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        post.setTitle(postRequestDTO.getTitle());
        post.setContent(postRequestDTO.getContent());
        return post.toDTO();
    }

    public void deletePost(Long id) {
        Post post = postRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        postRepository.delete(post);
    }
}
