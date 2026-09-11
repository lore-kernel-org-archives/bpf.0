Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C346982C
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116199; cv=none; b=OyJrT20JNQa1Q3UKqkO3Dik9m9sCUv1v+CZjZg2GUwaaDurF4mga9lkIpVuAi0pzq/j29Ub8fKamA7/Rj2pSRE7GoAqQvT7mVbk/jAzIv0oh5ndQposfXA1XR+uWWmM6HAVpwPJqosWEcv+cwgKaag5wyJTuKPoMJAZr9ClfGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116199; c=relaxed/simple;
	bh=oY1Gh/4hBJwdMgG1aZUk1FTPHRzZVxxboNqtDMnrgec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmkKS6kMByckTH1YVB/O4Jh9QLCOo1o0PIBIymCGeXle6rhr6sdzih/97ba0HIqFNXtyF1fAvpvYI3qcIuz1FwfLl8s+Uz2l/HWnEjR6cJ060EJr4G5UmWWEeG/d3Kh4pEzdjk4+5K1JVR3jdm5H1Pk2WK/9f2uSNQxTyCUvnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=um1ayfYY; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="um1ayfYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=EJPZ15IX1+
	cJB/ubZCOfecqBE/c2bERhC32abN6Sv3A=; b=um1ayfYY2QqOxoMVwNg8k92KT+
	fAFTcTi7mbJ20fkK4Z25aiKJqzAsxyjeKbjfc8YtTabpqr7VX8wzy6KvUQnrndRF
	x+VCS+pJyMZ74AGLOMz1wfiftJ2y7I7k8NGvP25v63ks2vM4zgitVpBOJ2uruwfJ
	vPeHqQT0cYyOzfxoU=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHSTAjv6NqMfAGAQ--.3778S2;
	Fri, 11 Sep 2026 16:43:15 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf] bpf: Reject non-negative offsets in stack_slot_obj_get_spi()
Date: Fri, 11 Sep 2026 16:43:14 +0800
Message-ID: <20260911084314.3481637-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBHSTAjv6NqMfAGAQ--.3778S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kZry8AFyDurW3uFyxAFb_yoW5KFWrpF
	Z7ua43KrykKF42vrsrAa12ga4rK3WkGayUCFWkZ34FyF1rJr1DWr40kF98XasxtrWrZw1S
	v3WY9anxt3yUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUkS__UUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

bpf_get_spi() computes (-off - 1) / BPF_REG_SIZE using C division,
which truncates toward zero. For off == 0, this produces spi 0, the
same index used by the valid stack slot at fp-8.

stack_slot_obj_get_spi() currently checks alignment and the resulting
spi bounds, but does not reject the non-negative offset itself. It can
therefore validate a PTR_TO_STACK register holding fp+0 against an
iterator stored at fp-8 even though the runtime receives the actual fp+0
pointer. An effectful iterator kfunc can then interpret memory outside
the BPF stack as iterator state.

Reject non-negative offsets before converting the offset to an spi. All
valid stack objects begin at a negative offset from the frame pointer.
Add a verifier test that initializes an iterator at fp-8 and attempts to
destroy it through fp+0.

Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
Please queue this fix for stable after it reaches the BPF tree.

Tests:
  - W=1 make O=<build> kernel/bpf/verifier.o (15071f-based candidate)
  - make O=<build> -j12 bzImage modules (f77d212 baseline and candidate)
  - strict clang-20 build of iters_state_safety.bpf.o (f77d212 candidate)
  - test_progs -t iters -v --watchdog-timeout 180 --workers=1
    - f77d212 baseline: 96 subtests pass; destroy_fp0_fail unexpectedly loads
    - f77d212 patched: 97/97 subtests pass
  - panic_on_warn=1 and panic_on_oops=1; no warning, Oops, or BUG

The four commits from f77d212 to this base only change sock-destroy networking
code and its selftests; the patch applies without conflict and verifier.c is
unchanged across that interval.

A separate effectful reproducer is available privately on request.
It was not rerun in this validation round.
The full unfiltered BPF selftest suite was not run.

 kernel/bpf/verifier.c                         |  2 +-
 .../selftests/bpf/progs/iters_state_safety.c  | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b0b1fb628786..efbb446998848 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -567,7 +567,7 @@ static int stack_slot_obj_get_spi(struct bpf_verifier_env *env, struct bpf_reg_s
 	}
 
 	off = reg->var_off.value;
-	if (off % BPF_REG_SIZE) {
+	if (off >= 0 || off % BPF_REG_SIZE) {
 		verbose(env, "cannot pass in %s at an offset=%d\n", obj_kind, off);
 		return -EINVAL;
 	}
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index 646026430e9b5..e5bb9fe6d5e53 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -52,6 +52,28 @@ int create_and_destroy(void *ctx)
 	return 0;
 }
 
+/* fp+0 is not a stack slot. bpf_get_spi(0) used to alias spi 0 (fp-8). */
+SEC("?raw_tp")
+__failure __msg("cannot pass in iter at an offset=0")
+int destroy_fp0_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile ("r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		/* r10 is fp+0, one byte above the top of the BPF stack */
+		"r1 = r10;"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
 SEC("?raw_tp")
 __failure __msg("Unreleased reference id=1")
 int create_and_forget_to_destroy_fail(void *ctx)

base-commit: 15071f2a1263e82150c77eeb1e94dbfc31950a8e
-- 
2.43.0

