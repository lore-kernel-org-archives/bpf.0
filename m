Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577542;
	b=zkxgOLhplTzHACk/cBcYilaO8dzI1EYvWTY6HcezcLF5P1Dh6QjAGjcNbn9pJk/b0Bmg
	 rpdBGjTSoKdMxElkk9qCyL3027ks/ZfQ6sXJAvk8VPR7WypKX9vVdVOp1q1kyXTjGup5g
	 uwj+fCq6hv8f55ds32zbssAtYjzoRh3PaOqdJr72IISemx9vHkxnISrkqXyFzyrJmY3EU
	 crDWqolBzt8VJ89YgBgij7p1WuBgYnV0IiUrS2MaUQHPN+UFregmtLafFn3vvbs0hEkce
	 Plzf4cgZICe0Yl7meed/gRXsmME8sxzamItxQvCH4rJfxRLf1Au/32ij7AJws/5VHxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xYsRKNoP8UvWd5Vx02OL8oCTtfZVWSb6iHzy3vKxxGI=;
	b=CIDE+cO7bFAxzOpqD9AAul6w7YnB0W5yJGaW2RDGcLgP+muSOyDu4k0fw6HVtbCn3W46
	 gpobYtIdWEvkn2f7DoXoO7+MHLDoXWuJOJfWg9hQ4qioF9wgSvfQwS3BhtnmjocZCOKn0
	 B75Rh0hUPDY0OFLN5HJks+kjp30aGEiLIRuY5cY19iW7ZMXWmMGPsxWq8Rtyo7k+pW3vC
	 9PRrR7FGXa9YIqaUQBESOhNoOQEEqnIlAOfidO+jN9Ku9hWGZoTA0wsFzimK1EhuQrHhY
	 RjCLd00pb9B8MBgCmnPVxVawPiFxrMxp9lfiDH+aJ3Z/ihd8HmrL2rLFnUWYuvnGzTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5+ltDcp;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6E606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F6E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5+ltDcp
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so2818280a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577541; x=1796182341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYsRKNoP8UvWd5Vx02OL8oCTtfZVWSb6iHzy3vKxxGI=;
        b=p5+ltDcpFBqJOT8kzeLoqN4iIJ5PzTvg74RL/Kfuge/J+KsyZKOFcrDNNpgyPXIGIy
         5r6aH3kFibO/ebQI7sdK8OJh/yX3gvTFyeGNoP/VyFfAmrJNVcFbWyrkSGEqZ5q/Ffao
         c32G0EsvJCrPcpUHNi2kGYd3fvwBACprgNL4oHO8El5o+D3QL3xiF57KtxOmzxZAB7nQ
         BHfA4KgsdweiOy8huw7gEKwBhbY/yjGQsjJNOFHtKMvecRq1K8/MU1otuLvsQnwhUR8f
         pvjBiYM5VxtvzpSj6R05kZjbUEesrJINZsqfLwnI0RwXsDrflS5Rqbpfz6bfuQxdU+Ph
         fQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577541; x=1796182341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYsRKNoP8UvWd5Vx02OL8oCTtfZVWSb6iHzy3vKxxGI=;
        b=z+3zuVaomfd+uPsB2i+Q6vzjIHUKP2qW9zMV6kxDE7s8sc2BtYxykc2QTgqm0eTTbg
         RSCXzzq559c1UBhrtmqf1AFfPwSWw15C8lzHCVnb/Z4FIGKbtPOrDXNazyQTPuGji6iS
         pCViy5hp7jm12JJjb1vebvTyJOwg3JJyoGSkGSlCcAIH8Ln844iVyzDE060WBNeRVrQQ
         M/l00Lh0jUyGIT0Q/veCLfm8yVHIJkac50WjM7WGMQCIXh6MA4V/oz4OEP9hlBK7B3JR
         oQQZxYDnETAyj8NdZByPAFHfq5/bueqR0cc8ZLwAxCkKYrUUQl4cCOyGx0RdevY9Ka3t
         T5yw==
X-Gm-Message-State: APuU4Z9Zcp6XPwdINZppRP4t9NAcSVTp63ZzFfH5eeo4iezscD1h2E1i
	VPSLra+e46ztMLKoewPz80ILRqLwPG+rwNpcXO8rwnLQCaXxZMZbcGSRjSokY2eQ
X-Gm-Gg: AZFdTZdUGBguk+GIvxwxSWmHukXPNqhNaAIQ7qneq9PBYnKn311DqAwSeYWhjUUeeiZ
	BJtU1zmP2JOG7hX8w91yzv3aJ97xz5jnmvP4VVa+7xWY5llzE5j9CBdbeoE5Qyx4+1TsLPV9uLt
	wKH0Z/p+tNSCR0grIzZ6Z3IW92xD9JEvCVGkq6PYkILoO5i4H1AqpwOE5ALOmGoGPZg6dNX2VDk
	1P1ZiRuHhsZyxAnPrDrI/12wHe5RGJyMK4RZ54K8pEc+dQN7UT5RFVGyjGK1iOJCIKrj3MIa3fs
	S8oE1QIX/wz4BnHHdH9uB2gV1cQ3dHD9AsViV/0jUuwxHZ4mpc13Hjc/MywakQiVmcy4zce9MhE
	y9R1aYo6dRIjX4UeEM9/RjS8uCoRy9sO+eCt6bVR/6DwpLhZYnghxGvQbloS3dblZV+No0oRqlj
	z4cJ/Xw1hDrh6g3d40Ez5zO6cp0cv2Uu8S9KSa9Y8s9yq0SqMtP2SKOf4fEhnr9TXnEFgitzw5T
	z1tA4DzoitBy7z4W1bwFe8+J/3D0EMomHcEjEjftvD+o6+ehTuAVLGJATVyolK2FCcXOWh7SnVL
	DcyQs+9LtlxBl4zgH+GUS1aLFmbhmgWOsL57E6V2ViXy7TKUHRGwc6pZ53O2qaRtBQl/8uoASB2
	jPaRtYMwytU9EIGoTfGKmGd8/xUb6iQrHOzpf7hhSb3F9F0wTi6KHzPdfWUWDE7gexRZFIaxXAg
	==
X-Received: by 2002:a17:90b:4a48:b0:3b3:b5b4:e4a9 with SMTP id 98e67ed59e1d1-3b41c7ac07amr15550147a91.3.1795577541169;
        Tue, 24 Nov 2026 19:32:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8ef99sm26163009a91.12.2026.11.24.19.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 27/47] bpf: Require CAP_PERFMON to read streams
Date: Wed, 25 Nov 2026 03:29:18 +0000
Message-ID: <20261125032938.670542-28-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A loader that has CAP_BPF only can read the streams of its program.
Reports of the kernel have addresses in them: those of locks after a
deadlock, and of code that has no symbol in call traces.

Require CAP_PERFMON for BPF_PROG_STREAM_READ_BY_FD and
BPF_PROG_STREAM_OPEN, through the token of the program if it has one.

Fixes: ecec5b5743bf ("bpf: Report rqspinlock deadlocks/timeout to BPF stderr")
Fixes: d7c431cafcb4 ("bpf: Add dump_stack() analogue to print to BPF stderr")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/uapi/linux/bpf.h       | 3 ++-
 kernel/bpf/stream.c            | 4 ++++
 tools/include/uapi/linux/bpf.h | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8d7228834305..6840ca5b923b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -934,6 +934,7 @@ union bpf_iter_link_info {
  *		by *prog_fd*, and the stream is identified by the *stream_id*.
  *		The data is copied to a buffer pointed to by *stream_buf*, and
  *		filled less than or equal to *stream_buf_len* bytes.
+ *		The caller needs **CAP_PERFMON**.
  *
  *	Return
  *		Number of bytes read from the stream on success, or -1 if an
@@ -953,7 +954,7 @@ union bpf_iter_link_info {
  *	Description
  *		Open a file descriptor for one of the BPF streams associated
  *		with the program identified by *prog_fd*. The stream is selected
- *		by *stream_id*.
+ *		by *stream_id*. The caller needs **CAP_PERFMON**.
  *
  *		The returned file descriptor supports **read**\ (2) and
  *		**poll**\ (2). Reads block while the stream is empty unless
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 65f65876afdb..53519a17bf26 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -268,6 +268,8 @@ int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, vo
 {
 	struct bpf_stream *stream;
 
+	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
+		return -EPERM;
 	stream = bpf_stream_get(stream_id, prog->aux);
 	if (!stream)
 		return -ENOENT;
@@ -368,6 +370,8 @@ int bpf_prog_stream_new_fd(struct bpf_prog *prog, enum bpf_stream_id stream_id,
 	int fd_flags = O_RDONLY | O_CLOEXEC;
 	int fd;
 
+	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
+		return -EPERM;
 	stream = bpf_stream_get(stream_id, prog->aux);
 	if (!stream)
 		return -ENOENT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8d7228834305..6840ca5b923b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -934,6 +934,7 @@ union bpf_iter_link_info {
  *		by *prog_fd*, and the stream is identified by the *stream_id*.
  *		The data is copied to a buffer pointed to by *stream_buf*, and
  *		filled less than or equal to *stream_buf_len* bytes.
+ *		The caller needs **CAP_PERFMON**.
  *
  *	Return
  *		Number of bytes read from the stream on success, or -1 if an
@@ -953,7 +954,7 @@ union bpf_iter_link_info {
  *	Description
  *		Open a file descriptor for one of the BPF streams associated
  *		with the program identified by *prog_fd*. The stream is selected
- *		by *stream_id*.
+ *		by *stream_id*. The caller needs **CAP_PERFMON**.
  *
  *		The returned file descriptor supports **read**\ (2) and
  *		**poll**\ (2). Reads block while the stream is empty unless
-- 
2.55.0

