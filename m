Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8C226D18
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063143; cv=none; b=W9jQhX0amT1Ic+KPQu7zTHJaWoysaTQYnISznr9KV5+Uai5OScenXl1moqYrmle/hmgoIv6c1Uv+8dEvifX3owk6fBVP7TP9M8/XBy6H7D+G35V/cE0RDfE3hr8ON6oGw6V/Ks3GCRAaXWEgOo0wJn0DCDdakEt2xlNc/upG5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063143; c=relaxed/simple;
	bh=aUM92AgbauHV4QyBzFMhML/6iVhA0DCdmumoaxdeZqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2RmfW8hI0gIP4WYnSEecywH4MNcvz8ceHneFVTrwbLlKQeI1MbIReRosGaWbPc+coaDD5TcurgD9eAHhmH/0RLFhawiPqlAvO7MZRq8uXZ5vDg0nTCXsrAhyGaxKoQ9D1BO9FxEsJLbO35mVfYl2FyEl1wYI1Lfbg/xansQ31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsm/PWVd; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsm/PWVd"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137dd4cc208so2919778c88.1
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782063141; x=1782667941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpjCT8M88BJGwAnD5H4rYxvEvus9dyd0UVGo/IMCVqw=;
        b=Wsm/PWVdSw5Tv62M7IOace2yqLPmtr0nMXALquGEpdNxSZG8HIoShvD0DO05ijkm0Z
         R+0DcT9RopJO27HZeTRPou4O1cnWvE8UJaAvqeXNeN4l37KR9K5Hmf6nuW7zMImnYT5A
         2ATeRRwlJW+PYVyPD8etfwwLSMhOv/ploVEKHIGByj1ewizslATm2vH7iEAC4SRPSECF
         Rwb8PZhRD/5zODJKllBaBoISAcgsiBA6UV9kqLppl79obUSad8Fui/aMnb2O0Vm8K0qE
         rR4uEue9mm+tzdNr+ZS799V9YKXHNjdqcGCnAW4UppiPduG0VO+xJYqzyX+WA4C6egXn
         MDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782063141; x=1782667941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpjCT8M88BJGwAnD5H4rYxvEvus9dyd0UVGo/IMCVqw=;
        b=J/KM4m6tB7so+U7eZIwbY8i3XLr/k0M7e+Cicfg41i2ruONuRtQSfDpuToos3CsMgr
         D5wYBy2qVlTgxwlkqikrFTJlk1jW1sw76kaG/eBAyBjVBXJ1+8XZ1ubm5ToDXD9yH8sA
         aI/Rm5IZqKUfzuRJQ2Su9b+U9jWzzNREmc8pp3G8FZoiGn92UlDVuk27FpAYP8EDHX3b
         nw+G1CD4ltFdauB2OP4dQxwzmLLjJabfm9ldT+RZ2mUBQvHNatAPb2uEcDLQEIfZ6PuC
         cd6OHD6TLZgbujjc3I/aeoHvCHRClX84vtbkWi1PBTpzhkgWsvTpPARK2dPTADS/7Csc
         mt6g==
X-Gm-Message-State: AOJu0YyszCN3WKWmtJxxd9gXAMNBEzLYIvb+2sOFvXVk4dp3FfAetQQM
	SG4K8VOK8ZeBN66PXmnHL6MRiMOj9MxE+2meKmmHhKPWpR7TKzkddr3NaGY0H6WAAco=
X-Gm-Gg: AfdE7clT8rr1ONcuK6MYvJTF0OWT+UGAmXLE7xtO3uXqdihLk56hhIvtmv+mis+Jn8K
	osxYWVdE4Rra8BYmfYESetIHARHibCa0W8Pb+80liHCjcqsZQeDMeSxFnejRpX4aHZ+tkfdEUra
	rdvuJy9T+PzVU93zVl5Kn07fUkxU0sLDdCl/J/P+4vS/PrhVir9rq/vgkVEKO+tIXl/8HEuI4dH
	NhL+mcatA/qLqMM4kLaOlKseRIvfgQr+BXWTAwB2fcP/D91DZ1VXuMs0lHDhaq7WrPM5NdGuTux
	eTykSde75XwgjshDdO7JDEnL2eVfJexsFN96ecjWLqy9x+FEXrHWkZiWDn7doL3K7T/pwGh1TpX
	PfpgLfzeOIWKqyqqcIEPgG1WR8ZrbQ+biE1bO6mzPgZ4hBw1b0DLpks6LdNW8UBh2rb22SHCY5f
	1wj4Ftx5YZ8D+PmjaKWZAcmMytJDv5Qs3zeQ==
X-Received: by 2002:a05:7022:626:b0:136:8b76:14eb with SMTP id a92af1059eb24-139a31185f4mr6140349c88.14.1782063141014;
        Sun, 21 Jun 2026 10:32:21 -0700 (PDT)
Received: from localhost.localdomain ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add6d76dsm5495591c88.12.2026.06.21.10.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 10:32:20 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v4 3/4] selftests/bpf: Tests for per-insn sync_linked_regs() precision tracking
Date: Mon, 22 Jun 2026 01:27:34 +0800
Message-ID: <20260621172735.409355-4-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621172735.409355-1-jt26wzz@gmail.com>
References: <20260621172735.409355-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit bebc17b1c03b224a0b4aec6a171815e39f8ba9bc ]

Add a few test cases to verify precision tracking for scalars gaining
range because of sync_linked_regs():
- check what happens when more than 6 registers might gain range in
  sync_linked_regs();
- check if precision is propagated correctly when operand of
  conditional jump gained range in sync_linked_regs() and one of
  linked registers is marked precise;
- check if precision is propagated correctly when operand of
  conditional jump gained range in sync_linked_regs() and a
  other-linked operand of the conditional jump is marked precise;
- add a minimized reproducer for precision tracking bug reported in [0];
- Check that mark_chain_precision() for one of the conditional jump
  operands does not trigger equal scalars precision propagation.

[0] https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240718202357.1746514-4-eddyz87@gmail.com
[ zhenzhong: keep the linked_regs_broken_link_2 reject check, but
  drop the mark_precise log expectations because 6.6.y does not derive
  the scalar-vs-scalar range for that non-constant JMP_X comparison. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index f70392bf696c..2eb85eb3a06c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -47,6 +47,72 @@ __naked void linked_regs_bpf_k(void)
 	: __clobber_all);
 }
 
+/* Registers r{0,1,2} share same ID when 'if r1 > ...' insn is processed,
+ * check that verifier marks r{1,2} as precise while backtracking
+ * 'if r1 > ...' with r0 already marked.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame0: regs=r0 stack= before 5: (2d) if r1 > r3 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
+__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__naked void linked_regs_bpf_x_src(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = 7;"
+	"if r1 > r3 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r4 = r10;"
+	"r4 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed,
+ * check that verifier marks r{0,1,2} as precise while backtracking
+ * 'if r1 > r3' with r3 already marked.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame0: regs=r3 stack= before 5: (2d) if r1 > r3 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
+__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__naked void linked_regs_bpf_x_dst(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = 7;"
+	"if r1 > r3 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r4 = r10;"
+	"r4 += r3;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 /* Same as linked_regs_bpf_k, but break one of the
  * links, note that r1 is absent from regs=... in __msg below.
  */
@@ -280,6 +346,102 @@ __naked void precision_two_ids(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+/* check thar r0 and r6 have different IDs after 'if',
+ * collect_linked_regs() can't tie more than 6 registers for a single insn.
+ */
+__msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
+__msg("9: (bf) r6 = r6                       ; R6_w=scalar(id=2")
+/* check that r{0-5} are marked precise after 'if' */
+__msg("frame0: regs=r0 stack= before 8: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3,r4,r5 stack=:")
+__naked void linked_regs_too_many_regs(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r{0-6} IDs */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = r0;"
+	"r4 = r0;"
+	"r5 = r0;"
+	"r6 = r0;"
+	/* propagate range for r{0-6} */
+	"if r0 > 7 goto +0;"
+	/* make r6 appear in the log */
+	"r6 = r6;"
+	/* force r0 to be precise,
+	 * this would cause r{0-4} to be precise because of shared IDs
+	 */
+	"r7 = r10;"
+	"r7 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("div by zero")
+__naked void linked_regs_broken_link_2(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r8 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 > 1 goto +0;"
+	/* r7.id == r8.id,
+	 * thus r7 precision implies r8 precision,
+	 * which implies r0 precision because of the conditional below.
+	 */
+	"if r8 >= r0 goto 1f;"
+	/* break id relation between r7 and r8 */
+	"r8 += r8;"
+	/* make r7 precise */
+	"if r7 == 0 goto 1f;"
+	"r0 /= 0;"
+"1:"
+	"r0 = 42;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Check that mark_chain_precision() for one of the conditional jump
+ * operands does not trigger equal scalars precision propagation.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("3: (25) if r1 > 0x100 goto pc+0")
+__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
+__naked void cjmp_no_linked_regs_trigger(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id */
+	"r1 = r0;"
+	/* the jump below would be predicted, thus r1 would be marked precise,
+	 * this should not imply precision mark for r0
+	 */
+	"if r1 > 256 goto +0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 /* Verify that check_ids() is used by regsafe() for scalars.
  *
  * r9 = ... some pointer with range X ...
-- 
2.43.0
