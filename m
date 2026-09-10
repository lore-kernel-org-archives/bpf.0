Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFDF3A6EF1
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015238; cv=none; b=ITOQxmGoqbZ5kq9gemFQ0TyE1/2CnrEbRSBPTEALuYDNRo5Ux/SAbTfSpY5/L5amyLc+ZdJ1ja5U2cZ2S3gBE61jYJd+tP4jqfhonMNJpwCS8aOaWM7KMN+ajLYl/9B10wm6vU/Oo1jAuI4KRh4WFRh/JoS0US6ubNJb5KOhVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015238; c=relaxed/simple;
	bh=BMgcfucH66c3aS6WcibnEW5tMnd5j4J+OLUKop+2PiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzO37P8dOr4eCoktSCN6zLy+abdxOQg0OrkVgsSF6OzsuPdPfpk17eSJ/iL7UcTiP3FlsQ3r6QaHw7wt/czaQKX8dv6m4/IvvXE5DNKDlykGqEejWVDQPYC1okI0QMW4tyiVYwtaR0GNRpr29TR8ywvgw7J+kPugPErdxb6AvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=Q2NQjJBU; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="Q2NQjJBU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=m8ExUu6Vh8
	0qCWw6DsvGf1itZpAWrDbmPZB8O7iAn4w=; b=Q2NQjJBUWMEaZait+bl853VlQn
	6bVPy6H92qk/3XT5HLy/bdmiYhj5i7pjk7yyWKVVywzcpnj774ImIZxHQxgR5krL
	g/CRoMr4GCXIKw5/ZL0rGDTg/jgBauJAgaU++KgrXOP1gzYQkcgY8pLf+LxE/6rN
	HQWogzeLPhhDVRkp4=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgA3MCe0NKJqsTL_AA--.338S2;
	Thu, 10 Sep 2026 12:40:20 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf v2 0/2] bpf: Invalidate iterator-owned BTF pointers
Date: Thu, 10 Sep 2026 12:40:19 +0800
Message-ID: <20260910044021.2279628-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgA3MCe0NKJqsTL_AA--.338S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4rurW3Gr4fAFWrGF1kAFb_yoW5tFykpF
	Z5W3y5Krs5Ca15CrnrA3Wj93WS9FZ3JF45ur18t34rurnxCF1jya4Igr15ZFyvkFn5Ww1q
	vr4F939Y9FWDJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5AUU5UUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

bpf_iter_task_vma_next() returns an interior pointer to an
iterator-owned VMA snapshot. The PTR_TO_BTF_ID result lacks the iterator
reference as its parent, so destroying the iterator releases the backing
allocation without invalidating the returned pointer. The verifier then
permits a read through that stale pointer.

Pointers loaded from the snapshot's trusted vm_file and vm_mm fields must
carry the same lifetime relationship when their lifetime remains tied to
the snapshot. Otherwise, destroying the iterator invalidates the snapshot
register while leaving a derived trusted pointer usable after the
destructor drops its file or mm reference.

Patch 1 associates non-RCU PTR_TO_BTF_ID results from iterator next kfuncs
with the iterator reference. It preserves that parent across
pointer-valued BTF field loads only when the result remains fully trusted
and tied to its parent. MEM_RCU, MEM_PERCPU, MEM_USER, and untrusted field
results keep their existing lifetime or access-domain rules. Patch 2 adds
stale direct and vm_file-derived tests, plus direct and derived MEM_RCU
controls after iterator destruction.

On the exact unpatched base, 98 iterator subtests pass and the two stale
tests fail because they unexpectedly load. The v1 fix rejects the direct
snapshot access but still allows the vm_file-derived access, leaving 99
passing subtests and one unexpected load. With v2, all 100 iterator
subtests pass. Both MEM_RCU controls pass on the baseline, v1, and v2
kernels.

An external triplet also loads all three programs on the unpatched kernel,
and BPF_PROG_TEST_RUN succeeds for each. The patched kernel rejects the
stale program at verification, while the live and destroy-then-reacquire
controls still load and complete BPF_PROG_TEST_RUN. The probe's return
value establishes successful program execution but does not prove that
every conditional access executed. This series is submitted as a verifier
correctness fix.

---
Please queue the verifier fix for stable after it reaches the BPF tree.

Tests:
  - W=1 make O=<build> kernel/bpf/verifier.o
  - make O=<build> -j12 bzImage modules
  - strict clang-20 build of iters_testmod.bpf.o
  - test_progs -t iters -v --watchdog-timeout 180 --workers=1
    (Summary: 1/100 PASSED, 0 SKIPPED, 0/0 FAILED)
  - baseline/v1/v2 verifier differential for direct and vm_file-derived
    stale accesses and both MEM_RCU controls
  - external live, stale, and destroy-then-reacquire load/test-run
    differential

The full unfiltered BPF selftest suite was not run.

Changes in v2:
  - Preserve the iterator parent only across fully trusted pointer-valued
    BTF field loads whose lifetime remains tied to the parent.
  - Retain v1's direct MEM_RCU exclusion; exclude MEM_RCU, MEM_PERCPU,
    MEM_USER, and untrusted results from field parent propagation.
  - Add a vm_file-derived stale-access test and an exe_file MEM_RCU
    control.
  - Use one iterator destroy in the direct MEM_RCU control.

v1: https://lore.kernel.org/r/20260909042907.1734153-1-xyx2021@mail.ustc.edu.cn

Xu Yunxiang (2):
  bpf: Invalidate iterator-owned BTF pointers on destroy
  selftests/bpf: Reject task VMA snapshot use after destroy

 kernel/bpf/verifier.c                         | 12 ++-
 .../selftests/bpf/progs/iters_testmod.c       | 91 +++++++++++++++++++
 2 files changed, 102 insertions(+), 1 deletion(-)


base-commit: 15e2565f1c43771af0bc5324971cabaad79ac286
-- 
2.43.0

