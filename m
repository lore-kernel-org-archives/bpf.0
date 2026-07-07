Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A03426410;
	Tue,  7 Jul 2026 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433891; cv=none; b=DAxmwp2YYXP1HggtMroBg9z1HvZ3I6KOcd4O8In1B4wzF+AreIdhTuyJzDQTj6kp5PByyv/aQZ8t3UkCQywq3yhOB5ljCLRdRC0aJ2SV1u/tUwhULNQhep5AvclKvt3LkHedUAdvEaNIUZseFOmAznQEshJbrpQ/FLAN59Nq2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433891; c=relaxed/simple;
	bh=AWb2eKQQWxvqpahf1IcQJuvcnQTf8V7jtGaehW42/Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zag4leMPXQLuH7jlNWLik+alFFo27Psd0aIZn22/M3xQRTpNLez1cBoCSFnCjoGpBFSkiEbLqa4NTAi5HPa7qnf85RnN3TnAHvwADhAa84K62v559htpssC/PiWEUPN2sJi8shn0WLXUX1UPqx6DlmHoKSVYzUFF1wfIECzhJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gvjxK5MwlzYQtjP;
	Tue,  7 Jul 2026 22:17:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2DFFA40937;
	Tue,  7 Jul 2026 22:18:01 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBnd3OXCk1qwUWNAQ--.43005S2;
	Tue, 07 Jul 2026 22:18:00 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v5 0/6] Mixing bpf2bpf and tailcalls for RV64
Date: Tue,  7 Jul 2026 14:22:13 +0000
Message-Id: <20260707142219.2871758-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnd3OXCk1qwUWNAQ--.43005S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4fCFW3WrWUAr45Zw17trb_yoW5Ar1Upa
	yfuw13Wryvgr42yanrGa18Xa4rGFsY93W3Cr17Jr1rAa1Y9FyvgF1xKFWFvas8AFZag34Y
	vr1qvFn5Cay8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

In the current RV64 JIT, if we just don't initialize the TCC in subprog,
the TCC can be propagated from the parent process to the subprocess, but
the updated TCC of the parent process cannot be restored when the
subprocess exits. Since the RV64 TCC is initialized before saving the
callee saved registers into the stack, we cannot use the callee saved
register to pass the TCC, otherwise the original value of the callee
saved register will be destroyed. So we implemented mixing bpf2bpf and
tailcalls similar to x86_64, i.e. using a non-callee saved register to
transfer the TCC between functions, and saving that register to the
stack to protect the TCC value. As for the tailcall hierarchy issue,
inspired by the s390's low-overhead approach, we store TCC from
RV_REG_TCC back to stack after calling bpf2bpf call or calling orig bpf
func in bpf trampoline.

In addition, some code cleans are also attached to this patchset.

Tests test_bpf.ko and test_verifier have passed, as well as the relative
testcases of test_progs*.

v5:
- Fix TCC value was not restored to RV_REG_TCC upon trampoline exit,
  resulting in an infinite tail call. (Sashiko)
- Fix epilogue not restored TCC value to RV_REG_TCC, resulting in
  leaf tailcall callee may clobbered RV_REG_TCC. (Sashiko)
- Remove patch of `Remove ctx->offset initialization` as it would hit
  some corner case. (Sashiko)
- Fix double-count kcfi insn when tailcall to target. (Sashiko)
- Add detail for selftest commit message. (BPF BOT)

v4: https://lore.kernel.org/all/20260629140048.733346-1-pulehui@huaweicloud.com
- Fix tailcall hierarchy issue.
- use is_struct_ops_tramp helper in bpf trampoline

v3: https://lore.kernel.org/bpf/20240201083351.943121-1-pulehui@huaweicloud.com
- Remove duplicate RV_REG_TCC load in epiloguei. (Björn Töpel)

v2: https://lore.kernel.org/bpf/20240130040958.230673-1-pulehui@huaweicloud.com
- Fix emit restore RV_REG_TCC double times when `flags &
  BPF_TRAMP_F_CALL_ORIG`
- Use bpf_is_subprog helper

v1: https://lore.kernel.org/bpf/20230919035711.3297256-1-pulehui@huaweicloud.com

Pu Lehui (6):
  bpf: Extract the is_struct_ops_tramp helper
  riscv, bpf: Using kvzalloc_objs to allocate cache buffer
  riscv, bpf: Fix kernel stack corruption in tailcall with CFI
  riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
  riscv, bpf: Mixing bpf2bpf and tailcalls
  selftests/bpf: Remove tailcalls tests from DENYLIST.riscv64

 arch/arm64/net/bpf_jit_comp.c                |   6 -
 arch/loongarch/net/bpf_jit.c                 |   2 +-
 arch/riscv/net/bpf_jit.h                     |   1 +
 arch/riscv/net/bpf_jit_comp64.c              | 125 +++++++++----------
 arch/riscv/net/bpf_jit_core.c                |   4 +-
 include/linux/bpf.h                          |   6 +
 tools/testing/selftests/bpf/DENYLIST.riscv64 |   1 -
 7 files changed, 72 insertions(+), 73 deletions(-)

-- 
2.34.1

