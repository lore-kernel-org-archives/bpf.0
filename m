Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384080;
	b=S3TKbb4hVQ49zVkkJgvzTsv5CZ1Rxp/Xqwy07MvXYadsW56Ty4wrCO2JaxIuyCx48Nc1
	 K8AD4QH7ExBTSF44Mr67S8QVIaYVuxToRkmo4XWcr10ACvN+9v2fjKHONJYHSvcpgtNdF
	 spia1VLZ4MI5LBS7ZtOWACPXu3g02Aq6vF261unCAju6qDJW5IEyWky+vC8ezlqcdxoVI
	 etIm2zMFlIHc2HvZAZ9rYWWI7YSFuHtWF3IjpXWxTv7H3zSMICfc4Rswe+cVZblXVZejQ
	 83j+2h7qW+2FrCkDr6IBQt3WaIdN8b/3h0kS46J0IhHUTWZj5Ub8o8l3mUfEZKh3vmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384080;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-B4-Tracking:X-Change-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=XauGCChzOkT4Lzvx2Lh+z/UKMAlrTOSpwUdfYUCdd3s=;
	b=Pvl+lawbQZq+Qh7jF0QPwVfXX1WIjCRY9vryPfxkPSF7KTQSAxNj7IygTjQVHav/Dj6I
	 1hRqbbO9LE2HCvgIeQX4iQopjykKDM0CnLX5qsq9vHVZVjOwnXHH51fZTQ6jqlliS7zkW
	 mM223HI2HYlGJKrDH9E/iW/zuLfJnB0Flm6tdXQiuH+nIlY0iAeqFJYdNrdelv6TffhmZ
	 5Dlnm7bY2yyZi5tkHzUz5ShnAripUuTECE2h439cS3+hxfQQmp51VEJS9c0Sr7igJyEkT
	 xWaajIKVsRU1qyuzYg1FqjPsFbuYLRAdfFaR5sK4xVHz38MkEmMXcr8yhqvwSQmRU+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sAk9vhac;
	arc=none smtp.remote-ip=91.218.175.187
Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE122606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE122606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sAk9vhac
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+TY283G1borHAZaLlZTGzy3/NR1BKFVZwd1ZnwDzwwY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793384071; v=1; x=1793988871;
 b=sAk9vhacnCG4G0BRbv+RUr2STznQC/GMNOMR1Pa7jqMuFDS603ChwiDIe2Z21sE7+l5vQO1z
 GdB+cDbOx05Byd5LomnCRmaAncX4+m/KXDKwa9Wehsupvt9geNIo8SQCHDZFnji9CzQuo/WQ3Qk
 e0aVKgxMFdiAmRSlVND1Wz5Y=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f6094ec407c97bfb;
	Fri, 30 Oct 2026 18:14:31 +0000
X-Mizu-Trace-ID: f6094ec407c97bfb
X-Migadu-Flow: FLOW_OUT
Date: Fri, 30 Oct 2026 18:14:22 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	John Fastabend <john.fastabend@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Peter Zijlstra <peterz@infradead.org>, 
	Puranjay Mohan <puranjay@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Maxwell Bland <mbland@motorola.com>, Will Deacon <will@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Pu Lehui <pulehui@huawei.com>, 
	Sashiko <sashiko-bot@kernel.org>, "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: [PATCH bpf v2] bpf: Fix jited line info off by the CFI preamble
Message-ID: <20261030-b4-arm64-bpf-linfo-cfi-v2-1-4eac83435d4b@linux.dev>
X-B4-Tracking: v=1; b=H4sIAA/c5GoC/yWM0QrCMBAEf6XsswchprX1V8SH5rzTE01LoiKU/
 rtRH2fZmQVFsknBvlmQ5WXFplTBbxrwZUxnITtVhne+c4NvKQYa870LFGelmyWdiNVIW972w06
 C6xlVnrOovX/hA+oVx/9YnvEq/Pgmsa4fd/SC6X8AAAA=
X-Change-ID: 20260925-b4-arm64-bpf-linfo-cfi-f5c3897e408c
X-Mailer: b4 0.15.2
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With CONFIG_CFI=y, every jited line info entry after a function's
first is cfi_get_offset() bytes too high on x86-64, riscv64 and arm64,
so tools that use it show the wrong source line.

The JITs count the insn_to_jit_off[] offsets from the start of the
image. Since the CFI commits below, prog->bpf_func starts
cfi_get_offset() bytes into the image, and bpf_prog_fill_jited_linfo()
adds the offsets to prog->bpf_func. s390 corrects its offsets before
the call, the other three JITs do not.

Subtract cfi_get_offset() once in bpf_prog_fill_jited_linfo() and drop
the s390 correction. jited_linfo[0] stays prog->bpf_func, the
function's ksym address. Without CONFIG_CFI, cfi_get_offset() is 0 and
nothing changes.

Fixes: 4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call")
Fixes: e63985ecd226 ("bpf, riscv64/cfi: Support kCFI + BPF on riscv64")
Fixes: 710618c760c0 ("arm64/cfi,bpf: Support kCFI + BPF on arm64")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260904014748.C04AA1F000E9@smtp.kernel.org/
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/all/DLNXZ2WK7TPD.2RZBUNRS4FA4L@gmail.com/
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
Changes in v2:
- Fix it once in bpf_prog_fill_jited_linfo() instead of in the arm64
  JIT, which covers x86-64 and riscv64 too, and drop the s390
  correction loop.
- Link to v1: https://lore.kernel.org/r/20260925-b4-arm64-bpf-linfo-cfi-v1-1-e930ab335170@linux.dev

Stable trees that do not have commit 227b4e108adc ("s390/bpf: Add
kCFI support") take this without the s390 hunk.

Drafted with the help of an AI assistant and reviewed by the sender.
---
 arch/s390/net/bpf_jit_comp.c | 2 --
 kernel/bpf/core.c            | 8 +++++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 56ec49894dda..83da3a00db7e 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2428,8 +2428,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	fp->jited_len = jit.size - cfi_get_offset();
 
 	if (!fp->is_func || extra_pass) {
-		for (int i = 0; i < fp->len; i++)
-			jit.addrs[i] -= cfi_get_offset();
 		bpf_prog_fill_jited_linfo(fp, jit.addrs + 1);
 free_addrs:
 		kvfree(jit.addrs);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7cf37690d41f..b9709e3b7656 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -206,7 +206,9 @@ void bpf_prog_jit_attempt_done(struct bpf_prog *prog)
  * here is relative to the prog itself instead of the main prog.
  * This array has one entry for each xlated bpf insn.
  *
- * jited_off is the byte off to the end of the jited insn.
+ * jited_off is the byte off to the end of the jited insn, counted from
+ * the start of the jited image, which is cfi_get_offset() bytes before
+ * prog->bpf_func.
  *
  * Hence, with
  * insn_start:
@@ -220,7 +222,7 @@ void bpf_prog_jit_attempt_done(struct bpf_prog *prog)
  *
  * For i > linfo_idx,
  *
- * jited_linfo[i] = prog->bpf_func +
+ * jited_linfo[i] = prog->bpf_func - cfi_get_offset() +
  *	insn_to_jit_off[linfo[i].insn_off - insn_start - 1]
  */
 void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
@@ -248,7 +250,7 @@ void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
 		/* The verifier ensures that linfo[i].insn_off is
 		 * strictly increasing
 		 */
-		jited_linfo[i] = prog->bpf_func +
+		jited_linfo[i] = prog->bpf_func - cfi_get_offset() +
 			insn_to_jit_off[linfo[i].insn_off - insn_start - 1];
 }
 

---
base-commit: fb7bd3a2aad70a76232a7168a505386d0a1396af
change-id: 20260925-b4-arm64-bpf-linfo-cfi-f5c3897e408c

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

