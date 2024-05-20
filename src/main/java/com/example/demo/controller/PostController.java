package com.example.demo.controller;

import com.example.demo.domain.dto.PostRequestDTO;
import com.example.demo.domain.dto.PostResponseDTO;
import com.example.demo.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;

    @PostMapping("/post")
    public ResponseEntity<PostResponseDTO> createPost(@ModelAttribute PostRequestDTO postRequestDTO) {
        PostResponseDTO createdPost = postService.createPost(postRequestDTO);
        return ResponseEntity.ok(createdPost);
    }
    @GetMapping("/post/{postId}")
    public ResponseEntity<PostResponseDTO> getPost(@PathVariable Long postId) {
        PostResponseDTO post = postService.findPostById(postId);
        return ResponseEntity.ok(post);
    }

    @PatchMapping("/post/{postId}")
    public ResponseEntity<PostResponseDTO> updatePost(@PathVariable Long postId, @ModelAttribute PostRequestDTO requestDTO) {
        PostResponseDTO updatedPost = postService.updatePost(postId, requestDTO);
        return ResponseEntity.ok(updatedPost);
    }

    @DeleteMapping("/post/{postId}")
    public ResponseEntity<String> deletePost(@PathVariable Long postId) {
        postService.deletePost(postId);
        return ResponseEntity.ok().build();
    }
}
