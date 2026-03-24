Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19052391E4B;
	Tue, 24 Mar 2026 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368974; cv=none; b=Wd1mlmx/wjPqGieybB9dFQvQxy3j+lGceH8AnEdZsDR4v+5fLWZCvqKtlhxl3Ty1Tn44aaLEA1RTVUGLXrfNTHiG7gjvGE0cxV0vgVXbooFk+0uazJxTC8N/lDdvrNDvswpyoCs+DKD3YnKlGFcqJt0ps46YcF0ifwkxrCKA7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368974; c=relaxed/simple;
	bh=8mE/hk4JeconWD2CxN0hrl6k/Bs3a/bHP5M+/Wb+Nqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SNy6ZQC7pzpI4wykejWCKbYeiG4avtA5HmsprVXj9Nyo5mfW49eebNCTeeN6rHeChWREBzirWRZRvrkB2aL4I8TMW1lnH3MWA9MzIJx8aZMAmIAoOsu0X3tgfkXAvjZ7ICws2BNwdq3uQsIGXAzIV3Ga8XYKWlRZDvES9337Kkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5hnkLMW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5hnkLMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7408C19424;
	Tue, 24 Mar 2026 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774368973;
	bh=8mE/hk4JeconWD2CxN0hrl6k/Bs3a/bHP5M+/Wb+Nqo=;
	h=From:To:Cc:Subject:Date:From;
	b=J5hnkLMWBHFYljVWnrj80NbDVCKVmKeGqKKw2iceQXK+GvQL6sA8L966X02lluQuB
	 FmaDZHkDe9Nzwn/e3fxdptX3iIFBGmZDzgU2Y/vCPmCX6Ir40ZUZkfnINQMZg8ylrt
	 uFKNNQiCO76ZrxZhLEbMREHbqK14CCXzWOqmcpT70kwutnjzt3vsVQk6MyHh3Uce2q
	 5EGzhwAetFPRy4rT4UWVWnTb3/sdRk0emCICZV6wWigLepKTM+M717w3g9kSpk/tB2
	 XbpYutddsk+CkWRvpBz7/qgtiFGBaDnceGcQZCrY0nggTslBcj6P898LyfsoXf8+CR
	 BFEMIIaHyb+rg==
From: Kees Cook <kees@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	sun jian <sun.jian.kdev@gmail.com>,
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
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
Date: Tue, 24 Mar 2026 09:16:09 -0700
Message-Id: <20260324161605.make.168-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3193; i=kees@kernel.org; h=from:subject:message-id; bh=8mE/hk4JeconWD2CxN0hrl6k/Bs3a/bHP5M+/Wb+Nqo=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmHdpxknszs8fJUZ9/a/ccF1DqPVom+/jjJOPvZN6HaT 1Vf4s+UdZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEykbTUjw8w/uxSfS2/ueWIq qfo/c99zLqX7F37vkNf28478va40czMjw51anXO287+W2St6/r7+MchVg2ctHw/P0qVLnf2jeg4 84QAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] strncpy() with strnlen() on the source
followed by memcpy(). Normally strscpy() would be used in this case,
but skel_internal.h is shared between kernel and userspace tools, and
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
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v3: instead of truncation, refuse the long length (test appears to have been a flake)
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

