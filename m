Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6423A984;
	Wed, 13 May 2026 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648891; cv=none; b=aJy5Z0eBWLQuWAiR+dy25PVdr4t/7XgfBRVlNcZ895mTVAyRERdCr0FzCl0RweszTenqIUGMFXOQVea3Y9kEFHQ0HGtK9gZwc4A1AkmiKKwYblcUeTiytSrXFPRfUzItQ9oz6WMwMEWTYzAl/RPPS5h6RmJjgXLriZ20Kh7DYlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648891; c=relaxed/simple;
	bh=sj3BxPV/5T76DEvHwVTxrjMQ54iMlh7U178nn3AGLvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hTG7tq0ySx1wxVFI34gnHmfBOpyA3VT5fvbEzAem5cWLjSB8Pceo68zKWMCPDHmAzSvm61wU5iHFyJVoNYUV9LELg1H1SmvnBNH543jJGqzLe4gmCfokwEqhoKvvm4kShN5RlEQ6Hmes4cT1b9cFOB7ev0HAzvf2/U5fy9HTVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntt+83b2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntt+83b2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2640EC2BCB7;
	Wed, 13 May 2026 05:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778648891;
	bh=sj3BxPV/5T76DEvHwVTxrjMQ54iMlh7U178nn3AGLvI=;
	h=From:To:Cc:Subject:Date:From;
	b=ntt+83b2ME63skqOmYoDvslFeUhUbfg7eQTY3hhkcZ6U3gR3c+JYCMzYxit2FLEft
	 Woc7hTCxmPhVKGpFsHqm7MxyXfEROzDzpj6YUXuVQO3R+9tTR60Eu4h8XqyVra2QoX
	 XwWMyphZyFIi+jX1G7eOqwpSrzQF+9Nf1TQV4vdSSPMWB8iDJc6zIyGrSIRlDFG3hI
	 3QPSOS2ossDCd6+m1wLLLb40cmDKzISWP0f1PK2Pq3s68Lehp2zlsGmQ/00X/PbBKx
	 WXT7/TEgx115juf56/wnwjl1x71JrCMXUkbvhfUCDLSU0lpOl08sXRQ5jVBOHxaq5X
	 T++vvOlbRieTg==
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5] libbpf: Use strscpy() in kernel code for skel_map_create()
Date: Tue, 12 May 2026 22:08:07 -0700
Message-Id: <20260513050806.do.620-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2004; i=kees@kernel.org; h=from:subject:message-id; bh=sj3BxPV/5T76DEvHwVTxrjMQ54iMlh7U178nn3AGLvI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFks7OadU42tml5c1uZ0teVYv+69xs2HGex83+sbPtXOD AyU/X2oo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJV+xgZ9p2Vmf3uhbC82ZMr pu9XvG4PnfdMoXib7qb0K79fhgi8cWL4nyNm8sx486Mnnw4cK0qefO7YbIebBZ7JDuFnVh+J5Wj zZQEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Linux has deprecated[1] strncpy(), and the use in skel_map_create()
is best replaced with strscpy(). Since we still need to build this
file in userspace, leave the strncpy() in place in that case. This
is the last use of strncpy() in the kernel.

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v5: Just ifdef for the kernel and use strscpy() there (Alexei)
 v4: https://lore.kernel.org/lkml/20260401001130.it.781-kees@kernel.org/
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
 tools/lib/bpf/skel_internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 6a8f5c7a02eb..74503d358bc8 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -243,7 +243,12 @@ static inline int skel_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash = (unsigned long) excl_prog_hash;
 	attr.excl_prog_hash_size = excl_prog_hash_sz;
 
+#ifdef __KERNEL__
+	if (strscpy(attr.map_name, map_name) < 0)
+		return -EINVAL;
+#else
 	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
+#endif
 	attr.key_size = key_size;
 	attr.value_size = value_size;
 	attr.max_entries = max_entries;
-- 
2.34.1

