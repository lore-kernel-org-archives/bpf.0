Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB99111A3
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712026505; cv=none; b=hy+PmX4hQAVoqIkZX0QuZAhR7TirgfDbx3+FjhMB0xfSsnP1ixHKocj55EIL0BrIfN+ocGh0Xj1SV9atOCK2KB7yQK+7ceaVxSYBRAEZyNaABp+L3CUd5BCcXg+j28nyS3fB+syML4im8VRuhzYzm0WqX3/JqFlfpmQg3xLN1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712026505; c=relaxed/simple;
	bh=a0CwOPtMY5PCyjxZFTb4n0/chBY/Gw5BXa26WcHkIyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNP001gyB4axZ9EYBlCn9NimbyPQ94KC3X67PVrsiruxDaWie+5qN8S1pHtU0DooEtpC9oCrXAXbUKheuN2Leh3lVe7zV32QdzYhctkp8f92NNGBQBH4myAHtcUkny+/M4wCh7x7QKLFJPGZ02w1XZIVJ3Hf6LXnMFUsN4M/Wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EC61D289B9E1; Mon,  1 Apr 2024 19:54:46 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Using llvm may_goto inline asm for cond_break macro
Date: Mon,  1 Apr 2024 19:54:46 -0700
Message-ID: <20240402025446.3215182-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, cond_break macro uses bytes to encode the may_goto insn.
Patch [1] in llvm implemented may_goto insn in BPF backend.
Replace byte-level encoding with llvm inline asm for better usability.
Using llvm may_goto insn is controlled by macro __BPF_FEATURE_MAY_GOTO.

  [1] https://github.com/llvm/llvm-project/commit/0e0bfacff71859d1f921220=
5f8f873d47029d3fb

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
index a5b9df38c162..3329ea080865 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -326,6 +326,16 @@ l_true:												\
        })
 #endif
=20
+#ifdef __BPF_FEATURE_MAY_GOTO
+#define cond_break					\
+	({ __label__ l_break, l_continue;		\
+	 asm volatile goto("may_goto %l[l_break]"	\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: break;					\
+	l_continue:;					\
+	})
+#else
 #define cond_break					\
 	({ __label__ l_break, l_continue;		\
 	 asm volatile goto("1:.byte 0xe5;			\
@@ -337,6 +347,7 @@ l_true:												\
 	l_break: break;					\
 	l_continue:;					\
 	})
+#endif
=20
 #ifndef bpf_nop_mov
 #define bpf_nop_mov(var) \
--=20
2.43.0

