Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D840DFC5;
	Wed,  1 Apr 2026 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775002296; cv=none; b=HegZd28fNwlxKQ75iMq1hfQaBmNNKAavqJ2/3ckZQnMEBtGU/1kfIH9R9wEMk1eQF3L2CV0/dBzCDBhM08WQHhLdGPiMyqjlHS/Hg3OwZU8d5RJiBSLspHgYvbosIDGgvOPBKjiI9nvBze5t+lRhuaXsDnn946nQTojX1bYAo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775002296; c=relaxed/simple;
	bh=HVNXu9Usi5qdDEbn2j9WggrU/Vy8Vy+O6o+xCAH1Ke0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hiY6C4FW4rD7qYYEIRwf6B5qeyR/g3yU5j8mGVeOZCResT0HMknVY7Z1NH8PyKYNw6po+NxaEWSwm7xcd7QbBOBVgZc+71HHSiEOFcaqfc7qxpXr2+znXdDxdtTWmu8qnFBVPBT5c4LHeoy08kfmPA9P6nviED++r4auIMjX2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmuM8Pwl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmuM8Pwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCAAC19423;
	Wed,  1 Apr 2026 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775002296;
	bh=HVNXu9Usi5qdDEbn2j9WggrU/Vy8Vy+O6o+xCAH1Ke0=;
	h=From:To:Cc:Subject:Date:From;
	b=qmuM8Pwly8KE3iAVlWKUS6Q5wnmoCMMcvRTyUamezhqGhPjCDoVHVf1rRlktV0p6a
	 PTWAGZJ/5rLeVIT+vAtxAGRUnbZrBkdi5B/PJF3g9YS71K15lsjWhFOYtjcRan8C0x
	 Q4FhxdqMfon0pd9CF6NSxoC6g86e5nScLBpP7m1E7rBACT4xXNfZMWV5YWM4f7LJu+
	 0gqueRyTk08PczMlsYnTRCPej95Sz6syiHevVF1KTYtZzKAdAvazVig7A65xbp5SDR
	 5nY8j6KRofhOqCtOVZ1ciG00Sq9QmC9wHirB5hqpOw7Srl1ftDDaSqb4GsfPhLxAWi
	 tReR+CFUP2Ezw==
From: Kees Cook <kees@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
Date: Tue, 31 Mar 2026 17:11:34 -0700
Message-Id: <20260401001130.it.781-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367; i=kees@kernel.org; h=from:subject:message-id; bh=HVNXu9Usi5qdDEbn2j9WggrU/Vy8Vy+O6o+xCAH1Ke0=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlnkrY1WBbOS5n9RO9d22WVB1+4N1p8PrRxUfyVyIBru lbhza1xHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABO5/Ibhn4nUx3PvNOxPVfE1 77PaW39k1UH1/hPPZtkxPu40dpzta8LI0Po3LELKVKo6P9s7fMum9MD/W34/3tz4QfJ2xh3JnWq pXAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

BPF is the last user of the deprecated[1] strncpy() in the kernel.
Replace it with a length check via strnlen() on the source followed
by memcpy(). Normally strscpy() would be used in this case, but
skel_internal.h is shared between kernel and userspace tools, and
strscpy() is not available in the userspace build context.

The source map_name is a NUL-terminated C string (the only caller
passes the "__loader.map" 12 character string literal). The destination
attr.map_name is char[BPF_OBJ_NAME_LEN] (16 bytes) in union bpf_attr,
ultimately passed to the bpf() syscall.

The bpf(BPF_MAP_CREATE) syscall, through bpf_obj_name_cpy(), requires a
NUL terminator within this 16-byte array, rejecting names that use all 16
bytes. Valid names are therefore at most 15 characters, but this wasn't
being checked via the skel_map_create() path. Add a matching check and
refuse 16+ character strings early, as they would be refused later by
bpf_obj_name_cpy().

The attr is pre-zeroed with memset() at the top of the function, so
the last byte of attr.map_name is always NUL, meaning the memcpy()
of just the non-NUL characters from the source will always produce a
NUL-terminated destination string.

Link: https://github.com/KSPP/linux/issues/90 [1]
Suggested-by: Sun Jian <sun.jian.kdev@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v4: Reformat commit log slightly, confirm last user of strnlen in -next
 v3: https://lore.kernel.org/lkml/20260324161605.make.168-kees@kernel.org/
 v2: https://lore.kernel.org/lkml/20260324053036.it.906-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20260324040535.work.851-kees@kernel.org/
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: sun jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: <bpf@vger.kernel.org>
---
 tools/lib/bpf/skel_internal.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 6a8f5c7a02eb..2d38c387f43c 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -236,6 +236,7 @@ static inline int skel_map_create(enum bpf_map_type map_type,
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
 	union bpf_attr attr;
+	size_t map_name_len;
 
 	memset(&attr, 0, attr_sz);
 
@@ -243,7 +244,12 @@ static inline int skel_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash = (unsigned long) excl_prog_hash;
 	attr.excl_prog_hash_size = excl_prog_hash_sz;
 
-	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
+	/* attr.map_name must be NUL-terminated, like bpf_obj_name_cpy() */
+	map_name_len = strnlen(map_name, sizeof(attr.map_name));
+	if (map_name_len == sizeof(attr.map_name))
+		return -EINVAL;
+	memcpy(attr.map_name, map_name, map_name_len);
+
 	attr.key_size = key_size;
 	attr.value_size = value_size;
 	attr.max_entries = max_entries;
-- 
2.34.1

