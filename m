Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10ED3AC00;
	Tue, 24 Mar 2026 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774330241; cv=none; b=Qblb1cTS8jks+E75pOkc9Hk4lTyv9yUhFXbR0TLeU3TYjh/mMzGT0vN+dUh2vzun/RHAHQ574NZy1qTJGOJEK6Ti3+onlZgKdf3f6en5ro6XQnuDnOht2RW7oZbjW5/saWY0BzNs5MqimzK3qv25wb2KNRw23qJxmF7j/W/Y4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774330241; c=relaxed/simple;
	bh=DXN6Fy71AEWMNuO9A/AYX0zuwOwYFvtLrV1K8oEuuuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SCmM2L39y5Tz1b5vIkm1m1GohUedAtmIF8Pa47wL6NJADAKDnISX6TLkQ4WugAGL36G0G7tpkIuTavUUQygErQwg6a+dVjtCEQn+ex5uI9wKRY71nAaS4G5UbtxIJyKp6uBoIzmcEjSuoABOOG8+voUq514k4uypVUvysrCd1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQfBKVHf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQfBKVHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B488C19424;
	Tue, 24 Mar 2026 05:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774330241;
	bh=DXN6Fy71AEWMNuO9A/AYX0zuwOwYFvtLrV1K8oEuuuM=;
	h=From:To:Cc:Subject:Date:From;
	b=nQfBKVHfbZ3LMblZ1yWQ14JQVe//h4WQwemh/BXJRVkeBAdu/+R6fHfhYP//IvbS6
	 aK0/nWFqc08R803zvLNLLLmG0VCDEBhJRCIdRVOmRFvot8uOdCMuuEI+Z8XGP0NZ9/
	 jvZHBDsxZO7B34omKy1Fej6Woj6BWxfed6If9fNsQzIqxRZukTIlRwivAD+5vXMY4o
	 iYGw8XK4cpRPAe1sep0TGeRBxf84CwsQpyjS01QjyPUdaUSEKh0wXxY2BDAIkrCfDR
	 OheD3UEM5/Zmy+WVqRYBKiTKqwhgLZUjYfZPx+TangBZj6DpuQTU2aVurUWzoLUji9
	 lKgsgMHgTQVkg==
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
Subject: [PATCH v2] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
Date: Mon, 23 Mar 2026 22:30:37 -0700
Message-Id: <20260324053036.it.906-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2993; i=kees@kernel.org; h=from:subject:message-id; bh=DXN6Fy71AEWMNuO9A/AYX0zuwOwYFvtLrV1K8oEuuuM=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmHFGtjT25qVCreFLGCZ8Wt6/KvniSt+8Y0JUhm/bHQT bcOdxxY0lHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCRWcsYGQ6xrevb1JLe7nrW 6+mHxZEnrqrJv4nu2uNm8jRsh7JT3ypGhhtXr14N65y8gVXv52P+JUcZLn6ZcDtw64e8rV8n/y+ a4MwPAA==
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
but this shouldn't be a reachable state. Forcing truncation to 15 bytes,
however, seemed to induce a (unrelated?) BPF selftest failure:
https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/68300440546

Allow the literal to exceed 15 characters and exactly reproduce the
original strncpy() behavior (potentially lacking a NUL termination).

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: don't force truncation
 v1: https://lore.kernel.org/lkml/20260324040535.work.851-kees@kernel.org/
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
index 6a8f5c7a02eb..8702d6612978 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -243,7 +243,8 @@ static inline int skel_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash = (unsigned long) excl_prog_hash;
 	attr.excl_prog_hash_size = excl_prog_hash_sz;
 
-	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
+	memcpy(attr.map_name, map_name,
+	       strnlen(map_name, sizeof(attr.map_name)));
 	attr.key_size = key_size;
 	attr.value_size = value_size;
 	attr.max_entries = max_entries;
-- 
2.34.1

