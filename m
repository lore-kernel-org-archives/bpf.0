Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34C4C33DA;
	Wed, 30 Sep 2026 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812376; cv=none; b=sunWThTtV3w/AGhVpQfCB/FXyZoVC8rgif5yh44KiwnyVFEGSdbrhpnMebnW8reovbdZsGh60Vk40e2Gi3iBbaWtRkOm0om/mXCJxcOM49Li05ez/B+vEB6iiSDjgD8wGvj90nONYMkJ5qiVVJ/IDvX+5SfhH0QMw5PhTwpfjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812376; c=relaxed/simple;
	bh=4gl3LbGuDWFoS+qEyhKobzVHDMjbjlCeqYLGgDMVGr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7dz8eLVxr9K2uTUD2y0rj3PhrIGlL9TW7QgE0oQ+PyNvzUA45F6Kf7duCJf1Rvm8sCdGIPcYgglGAydCNxtfTsqhjcYptKkPtdKTMOFe5Bzfos7Bcm97BzdXGbSmqr2kypYYv+c8tzeOnIhXzOw7jRl59fHve82Qi20xyB12mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe933Xc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe933Xc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1E01F008A1;
	Wed, 30 Sep 2026 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812371;
	bh=wWIn/mwGh/YcEVfjMOEb/3cECAhyOJprLyEH9Khta9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fe933Xc+5ySZ7XBtLwhIg2mdFH540Bn0AW6Lfop4pQCZBoaTrmNhxSUa+LqyVtM5n
	 FmLEhQ2X4szmUnYDGewrcAa8dO0B9HQwdz8KRHEJ59QYAaZ5tE0uGAl8HXAd0jim45
	 f0LVNcZC3Zee0dSsy1GR/k7CVsgpoewmrRCz1kzsQ4BMejaTi7k0WmoWe4PfpETMXW
	 +ubzKq05URrAepYrd6weXA7wNSGMvve+wPR0A7EDXmBhcOAUZ3Wzi0ascs/b6Fc17O
	 duz90uHJQJIDb5gmFlXKI5bYaTHY5F8DqInIpibQTk4nk1R14aDB0XK6YAhd5el1qj
	 F57LtMLtMoqeQ==
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
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 07/11] bpf: Remove dead newline stripping from format_disasm_line()
Date: Wed, 30 Sep 2026 16:52:35 -0700
Message-Id: <20260930235247.157921-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930235231.out.387-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=kees@kernel.org; h=from:subject; bh=4gl3LbGuDWFoS+qEyhKobzVHDMjbjlCeqYLGgDMVGr4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7FxzNL6u89S8yP0cj6nWVc27yq+k/Xj4R+ijp8LvF8 hWD/gaVjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIns/c7IcH6JKWP5meyzC2au +n/XwS7q9n+Rz1prGH5ph8hHKc3LmMHIsEGkYqta3v50M9aFfOWqDf1PFnU3XNv7wTjGUqZDcKk GAwA=
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
2.34.1

