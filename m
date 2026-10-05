Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704E4CDDED;
	Mon,  5 Oct 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215841; cv=none; b=Sfn80+xlJ5bO7eC6u0QoFi6rRCRCS2E/5JMtSWXok50rkPV8Lm/Sodiuphp8CkgL23QgnGWCkHkpwZWBDpxRDvQoreaCJWmwoPtahoE/SZNDIq5Y8yUHnX1+oKdCRco42suDgT2QNZfjyPLJvn4NCGme1gVWtspW1fBDS4jcJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215841; c=relaxed/simple;
	bh=l6cew/KOU7gD3rWT9yc9Bx/5dEviQJaYBYFB4u3fj3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/atZ3DRRoME3ccB2jD5qT5Yf1MFM4nXHIwQGMGceJp0Zel2PmwEjwWLyf7YQjOdPc6BQYA3XRSqt19xES1wa7RH2NY18Jg2a/DjLJ5poSEju+Tc7wvGuVJng9KBw7bUXEnj6T5p0wZow/kx+q+tA/suhMl82Ju8+RbekPo4xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8s0LWxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8s0LWxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D419D1F008A1;
	Mon,  5 Oct 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215838;
	bh=fquF+jcVX+IjgkYWGMIdx1jtR3zyMnnbKsmdnEA/ans=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8s0LWxj7VEVnu4N/RoA3yrgOsng3Xbm0V4iL20TNa88wZ7RJEDYpGBgTchWx4VxX
	 FAX0HNC2fwbY4IVNAxpmUYXX/qxcGZE4l5BFAq78kxZj11qMcvLbDOECmGVvUuVf/6
	 zRNiV1BGj/LD6QZU9om4CXVemVYcvGbagE5I0Jirl5ZW9WCfqvVTv51LsWfP7tfLKJ
	 WvSyRd+j5ZjWW4pDLejdHJDfrXKCs1+PRwVdy9AvwNZTj9wXNzrLjQBlXbWX2epi4G
	 X+I3J5Lp8TYBfmJumubxPBjjLR0cvR31ahdedKNGZaXdQH+HqHOGYb5gYzzhIfvlnG
	 1J6yjT0UlpmEw==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 08/12] bpf: Remove dead newline stripping from format_disasm_line()
Date: Mon,  5 Oct 2026 08:56:58 -0700
Message-ID: <20261005155708.1471260-8-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005155653.late.426-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=kees@kernel.org; h=from:subject; bh=l6cew/KOU7gD3rWT9yc9Bx/5dEviQJaYBYFB4u3fj3A=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHT5yxfbVjUYPz8Vnrmg+ybyiL2PzyB+v3vZ15XwPW3 P+uduJcTkcpC4MYF4OsmCJLkJ17nIvH2/Zw97mKMHNYmUCGMHBxCsBEDkxh+J/y7m/0o/ePX+UH 3FKboqPlf75+Y65nZdWmuWtKfkyr9FNiZOiqjE0+5CVgtjir41eN3K/zO3eXzbm8VHz2RImajC/ ll/gA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

format_disasm_line() strips trailing newlines from the disassembly it
stores, as diag_print_insn_context() adds its own. Since
commit 483a1bb0b6cf8 ("bpf: Do not print a newline after disassembly in
bpf_verbose_insn()"), print_bpf_insn() does not emit one, so there is
nothing left to strip.

The strnlen() resync of the seq_buf length only existed so the loop
could index the buffer safely after an overflow, and the second
termination only restored the NUL that seq_buf_pop() does not write.
Remove all of it, keeping a single seq_buf_terminate().

Build tested ARCH=x86_64 defconfig with GCC 16.2.0 and
CONFIG_BPF_SYSCALL=y.

Assisted-by: LLM
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 kernel/bpf/diagnostics.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 594cf3c8b74c..8f64bfd9afee 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -632,10 +632,6 @@ static void format_disasm_line(struct bpf_verifier_env *env, int insn_idx,
 
 	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 	seq_buf_terminate(&ctx.seq);
-	ctx.seq.len = strnlen(line->text, sizeof(line->text));
-	while (ctx.seq.len && line->text[ctx.seq.len - 1] == '\n')
-		seq_buf_pop(&ctx.seq);
-	seq_buf_terminate(&ctx.seq);
 
 	line->valid = true;
 }
-- 
2.55.0

