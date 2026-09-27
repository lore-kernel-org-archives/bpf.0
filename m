Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9613E0C67
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510729; cv=none; b=LRhZSx2pCDT2iCygJl//1nGy/PZr9i8N8SFP8ac1GvRdglMjuTk3FgE/1+Q7cGQWoriPMvHOTsZBzmQg2PQnK+ewt/8lLtW/5bIlUGU7qm+Nzkj41nc1+wwRkL314SSDgrz1e1qNP33HBs/vd0oBspqGpugtdUhzP4tjHs6dgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510729; c=relaxed/simple;
	bh=NR12pIiFLzl9SaDqagngnqXXH9hxvaOytPOxADGcMRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEWIw02wOM/xKmAiK3Hut312Ru2aN45sPnUaLVhoBsMLscMnKyDQ6Pur6a/oDQK3ca+8NV786bgi21HkTR9UC+f4kv7vZdifQb4JcGni73h1+4qnYCovsgqtCo/HEkENvJi4aZTJADNXCdEcS7On3XtGPecpD/IQywlnRrEGOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=s5HWUTu4; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="s5HWUTu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=z80D5rliOJ
	mbwI/psBN4lrRrXlh9Su1Csu3p1WEYfpE=; b=s5HWUTu4z3BfzLEiO8H7pGuKic
	Pk4JQoD5895zpC0uY9izQC88xE4IgwrFYNr5E4fvW1vPxhG9q9cdswGzCF0ranZw
	DsZsIVVR4kSRNpQWlFe7QZYyEqwFq9BqE1FURnUQWQE0wfHxBuseKOGL2UzGcQ2O
	VKSHRLlJfdLx70DLk=
Received: from localhost (unknown [222.195.81.76])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBX1jJIBrlqJolqAQ--.1502S2;
	Sun, 27 Sep 2026 20:04:24 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next v6 0/2] bpf: Destroy callee-local dynptrs on subprog return
Date: Sun, 27 Sep 2026 20:04:20 +0800
Message-ID: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBX1jJIBrlqJolqAQ--.1502S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1ftr4kAr1DuF17Xr45Awb_yoW5uw4fpa
	n3C34YvFWrtF12kF47Cr47uFyFkrs3XF43GFnay34rZw4ktrykAF47K3W2qF9xKr1xX3y3
	Zr17XFn8ua48A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07brOz-UUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

A dynptr data slice is valid only while the specific dynptr that produced
it remains valid. Apply normal dynptr stack-slot teardown before a callee
frame disappears, so its descendants are invalidated and its last
release-capable referenced dynptr cannot be lost.

Patch 1 adds a helper to destroy dynptrs in an inclusive range of stack
slots and reuses it for initialization, variable-offset writes and
subprogram returns. The callback diagnostic expectation changes in that
same commit. Patch 2 tests callee-local slices, last-holder rejection and
caller-owned slice compatibility.

Changes in v6, following Amery's review:
  - Replace destroy_dynptrs_on_func_exit() with the generic
    destroy_dynptrs_in_stack_slots() and use it at all three call sites.
  - Add the requested blank line before return-time teardown.
  - Clarify callee-local clone comments and rename the rejection test to
    callee_dynptr_slice_invalid_after_return().
  - Rebase onto bpf-next ea9358e1270ab.

v5:
https://lore.kernel.org/r/20260920210438.345847-1-xyx2021@mail.ustc.edu.cn
Review:
https://lore.kernel.org/r/CAMB2axMmrTb+UZ84UD48MwMtXbk1s9bWtreU3AOfjzU0fPT0BA@mail.gmail.com
https://lore.kernel.org/r/CAMB2axOEZjRV1K4Yxb4=1f2jvPHiD2rVy-+byXbvs3G0qat63g@mail.gmail.com

Validation on the rebased candidate with a matching bpf_testmod:
  - W=1 verifier, full kernel and modules builds passed.
  - Changed BPF objects and required fixtures compiled strictly.
  - dynptr: 2/137 passed; 0 skipped.
  - file_reader: 1/8 passed; 0 skipped.
  - ns_bpf_qdisc/invalid_dynptr_returned_slice: 1/1 passed; 0 skipped.
  - global_func: 3/29 passed; 3 skipped.
  - cb_refs: 1/4 passed; 0 skipped.
  - subprogs: 5/34 passed; 0 skipped.
  - verifier_var_off: 1/24 passed; 1 skipped.

No selected test failed. The VM used panic_on_warn and panic_on_oops;
no WARN_ON report, Oops or panic was found. Unprivileged BPF was
enabled only in the isolated guest; the kernel printed the expected
Spectre-v2 notice when enabling that sysctl.

The broad test_progs build used BPF_STRICT_BUILD=0 for unselected
objects requiring unavailable kernel features. The changed objects
and required fixtures were also compiled in strict mode. Annotated
lifetime tests check loading and diagnostics. The unfiltered full
suite, sanitizer and architecture matrices, and new unmodified-base
differential probes were not run in this rebase validation.

Three 512-byte stack-limit variants skip on this 2 KiB-stack kernel;
their large-stack counterparts passed. ctx_arg_rewrite skips because
the kernel supports native context-argument tags.

Please queue the verifier fix for stable after it reaches the BPF tree.

Xu Yunxiang (2):
  bpf: Destroy callee-local dynptrs on subprog return
  selftests/bpf: Test dynptr teardown on subprog return

 kernel/bpf/verifier.c                         | 40 +++++---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ...disc_fail__invalid_dynptr_returned_slice.c | 76 ++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 99 ++++++++++++++++++-
 4 files changed, 202 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c


base-commit: ea9358e1270ab2c3ba6f36bd9bdda68617665516
-- 
2.43.0

