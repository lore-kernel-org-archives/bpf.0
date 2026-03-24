Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C8170818;
	Tue, 24 Mar 2026 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325141; cv=none; b=PIJCB0v9UEK0HG+knsSkYZFfL/7sjutCURTIt5rk5dVHmABBF4GLebmaKThsoXGvv1nA2cCwDxALZpxj/63bKQ96YIG+Q8qprOmomv5+Hsqa/icL1D9XYb/b09axuzddXvr/EIuD4yQmQILrobgd2ILUyZXkEezxzvUlC7OKdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325141; c=relaxed/simple;
	bh=mbDDm1zReRj3CD4GxvHAUMT8iSVZINzYULyqBvGF4F8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tUcpgea6qeoS+N++J9WrnuoGzNx2x0cqK9KF4oIOPUWDOeZ3Q0ZvkJSxsD/vlD+1mcYVwgv8xNZ3IuMsfRu3+peFJvEBvbENmJB4uFXsOPsFG2KDXFhozYSWhiICfDeK7Iv/BUnZ8eKY8TBhfVJmqHEssTJAdCTg41WFeqkVSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLORA2Le; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLORA2Le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391C9C19424;
	Tue, 24 Mar 2026 04:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774325141;
	bh=mbDDm1zReRj3CD4GxvHAUMT8iSVZINzYULyqBvGF4F8=;
	h=From:To:Cc:Subject:Date:From;
	b=PLORA2LeifuSU3BpnoFHhnRKOmWDiLWeBQw0+1bc0EvXehVF24a1A1D5jWSif7ykQ
	 ADGoPFtXBSyr6zRDdtXakyAt8U8ZsbHzVxsHtT4jrCe712dXeZ1lWORwQQ/Yy04np9
	 egqsqEC4Luy+rdf7Zic3MRsSOGiPj9kOCVtgOALXpGl9hsFG+5pq8no6XNX5PXsfly
	 gfcFXzfyKFmmdC3vP+kU2YDye5//BF219CGx7YnFgQ6wjm+epbCww6FGoQxU3VWUy1
	 aZ5LFzB1nHXZ+N96FUx+Fdob+Zokniwzt98oYaCp9CaZPZ960PODQh1ZqbFp652aaI
	 z4G9xr74cxVCg==
From: Kees Cook <kees@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
Date: Mon, 23 Mar 2026 21:05:39 -0700
Message-Id: <20260324040535.work.851-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; i=kees@kernel.org; h=from:subject:message-id; bh=mbDDm1zReRj3CD4GxvHAUMT8iSVZINzYULyqBvGF4F8=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmHeCcbul3+k8kw6Udlp9qGtcyNdlYnf+xOFNEVEfv2u SuvP/p3RwkLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETMVRm++/nuKt4rfrPxRs/D zYKKocePLCu8z2r5Ze6L2smi87OkGf4XnnKMqTh/aYHJr//Kn5S/RFgHm0+ttmha9L/lQ7+J3D5 +AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] strncpy() with strnlen() on the source
followed by memcpy(). Normally strscpy() would be used in this case,
but skel_internal.h is shared between kernel and userspace tools, and
strscpy() is not available in the userspace build context.

The source map_name is a NUL-terminated C string (the only caller
passes a 12 character string literal). The destination attr.map_name is
char[BPF_OBJ_NAME_LEN] (16 bytes) in union bpf_attr, passed to the bpf()
syscall. The kernel's bpf_obj_name_cpy() requires a NUL terminator within
the 16-byte field, rejecting names that use all 16 bytes. Valid names
are therefore at most 15 characters.

The attr is pre-zeroed with memset() at the top of the function,
so the byte at position 15 is always NUL. The copy is bounded to
sizeof(attr.map_name) - 1 (15 bytes) to guarantee NUL-termination is
preserved. This is safe because the kernel would reject a 16-byte
unterminated name anyway, and the only in-tree caller passes
"__loader.map" (12 characters).

While the original strncpy() would have copied a full 16 bytes from an
overlong name (producing an unterminated field that the syscall rejects),
but this wasn't a reachable state. This replacement will instead always
truncate to 15 bytes and keeps the NUL terminator, which should have no
behavioral changes with the present code and avoids potential issues
with future over-long string literals.

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: <bpf@vger.kernel.org>
---
 tools/lib/bpf/skel_internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 6a8f5c7a02eb..137da935f478 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -243,7 +243,8 @@ static inline int skel_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash = (unsigned long) excl_prog_hash;
 	attr.excl_prog_hash_size = excl_prog_hash_sz;
 
-	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
+	memcpy(attr.map_name, map_name,
+	       strnlen(map_name, sizeof(attr.map_name) - 1));
 	attr.key_size = key_size;
 	attr.value_size = value_size;
 	attr.max_entries = max_entries;
-- 
2.34.1

