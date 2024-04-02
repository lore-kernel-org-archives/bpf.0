Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8043161
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712098226; cv=none; b=kkyWRZiep0mPr8X/l3oORIPJR/4VSlKp+kl4SqqUDzYTHr05AbDfVyrWFnCJrob5Tu4/xhBIs3giRvxZ/kvAXumoGFooXSBmBONLy6I959+7IhDM9xUKNax8dl3zId9desWUmtl5uGkd66Ejhb5a+MJHpDlfHZ53kgWxWUsVTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712098226; c=relaxed/simple;
	bh=f0Esjquh9A6pAwWfas23wgCwzBF6H6szZuzaeY+Wb/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSxJwAs/ekM97YgVJg5bjzMyZ1Oo58qjsUkHFKaLPnddherQreQ69G8IADusybZ92mtcketDx0FNmKMtmfzbfotxMGdZlDm57WEEfoN9xzm6VXEB/PiqnJ9oiV+52bX7EsLDkqdRnQNeItMQ0RyyDRQ5A3klZKnmk9p4TN6NtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFHJaAMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFHJaAMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA356C43394;
	Tue,  2 Apr 2024 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712098225;
	bh=f0Esjquh9A6pAwWfas23wgCwzBF6H6szZuzaeY+Wb/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFHJaAMyoSWC3FCH7ek6SelvFUcgVE7SM1yu5uktTjYSlNcdA9PQaEBBclL6fkPh/
	 5u24iXvbXJ1m9hbZ/QTomumnceN+h704216GavZe5L1rSnFHQIfMsewBMaHsybglr7
	 KIrK+aGUH2YpmUKwHJmfSuetLTHMx85rrzAQpn/NwHEAehlPrNu24kCtGZPlFgilLg
	 UlC3jbnzy5BQpm0AbEQGIarzdCkCj/SAZYMzi6oJWR9tkvFeAMtuhBYvRKoBMpaMfq
	 FQexlYyyAYamSQBOvR+Et1xT6DDwa7zfMDY2SbgkRfD1Ldud8H8rgNj+4mKz7eDqkY
	 42C8r6YXJPTbA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: add fp-leaking precise subprog result tests
Date: Tue,  2 Apr 2024 15:50:20 -0700
Message-ID: <20240402225020.2582397-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402225020.2582397-1-andrii@kernel.org>
References: <20240402225020.2582397-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests validating that BPF verifier handles precision marking
for SCALAR registers derived from r10 (fp) register correctly.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/verifier_subprog_precision.c    | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 6f5d19665cf6..e1a8f107f0a7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -76,6 +76,92 @@ __naked int subprog_result_precise(void)
 	);
 }
 
+__naked __noinline __used
+static unsigned long fp_leaking_subprog()
+{
+	asm volatile (
+		"r0 = (s8)r10;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long sneaky_fp_leaking_subprog()
+{
+	asm volatile (
+		"r1 = r10;"
+		"r0 = (s8)r1;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("6: (0f) r1 += r0")
+__msg("mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
+__msg("mark_precise: frame0: regs=r0 stack= before 3: (57) r0 &= 3")
+__msg("mark_precise: frame0: regs=r0 stack= before 10: (95) exit")
+__msg("mark_precise: frame1: regs=r0 stack= before 9: (bf) r0 = (s8)r10")
+__msg("7: R0_w=scalar")
+__naked int fp_precise_subprog_result(void)
+{
+	asm volatile (
+		"call fp_leaking_subprog;"
+		/* use subprog's returned value (which is derived from r10=fp
+		 * register), as index into vals array, forcing all of that to
+		 * be known precisely
+		 */
+		"r0 &= 3;"
+		"r0 *= 4;"
+		"r1 = %[vals];"
+		/* force precision marking */
+		"r1 += r0;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("6: (0f) r1 += r0")
+__msg("mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
+__msg("mark_precise: frame0: regs=r0 stack= before 3: (57) r0 &= 3")
+__msg("mark_precise: frame0: regs=r0 stack= before 11: (95) exit")
+__msg("mark_precise: frame1: regs=r0 stack= before 10: (bf) r0 = (s8)r1")
+/* here r1 is marked precise, even though it's fp register, but that's fine
+ * because by the time we get out of subprogram it has to be derived from r10
+ * anyways, at which point we'll break precision chain
+ */
+__msg("mark_precise: frame1: regs=r1 stack= before 9: (bf) r1 = r10")
+__msg("7: R0_w=scalar")
+__naked int sneaky_fp_precise_subprog_result(void)
+{
+	asm volatile (
+		"call sneaky_fp_leaking_subprog;"
+		/* use subprog's returned value (which is derived from r10=fp
+		 * register), as index into vals array, forcing all of that to
+		 * be known precisely
+		 */
+		"r0 &= 3;"
+		"r0 *= 4;"
+		"r1 = %[vals];"
+		/* force precision marking */
+		"r1 += r0;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common
+	);
+}
+
 SEC("?raw_tp")
 __success __log_level(2)
 __msg("9: (0f) r1 += r0")
-- 
2.43.0

