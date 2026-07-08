Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E43D3CF4;
	Wed,  8 Jul 2026 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492824; cv=none; b=SfqcfHnuWP7OMIZsMZrvymudjqX7hK2LbH0/eIVrjjsSqTjLTHFDRQ4D2I88xNKt2ARsN+tUu9mFWAfcR2yOP3TRRPQc4PHm5OsQhZ/N5AB9iYa/iDy5vR58Yxr6aT+nZxJgRZyCDHDS5QBUbudmZyfl2K3bNu52sNbJoa1XI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492824; c=relaxed/simple;
	bh=oc7Lfz2ZWwrXU+zFgwi2wLx+sBIofhLxH0j2BKDDX7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AvZGDqo7vJaRRd5boXKQ/h2DBSf3+ZUoELhP3xx2Z9t2LJFPwjHKB6A2n8Wl1DdK/IqkVOnJbtqS1V6H6TA/9ETO5i0DADo+M53EvQ6FnTQ6sOZjXEWe+DIkCwV8XKEL8/StWQt/4p91m5JrSueZE6Cf7GXJVUdaSm39wD69pVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gw7kN1P4FzKHML3;
	Wed,  8 Jul 2026 14:39:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BC98F4056F;
	Wed,  8 Jul 2026 14:40:16 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgD32yfQ8E1qblLgAQ--.30661S2;
	Wed, 08 Jul 2026 14:40:16 +0800 (CST)
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
Subject: [PATCH bpf-next v6 0/7] Mixing bpf2bpf and tailcalls for RV64
Date: Wed,  8 Jul 2026 06:44:29 +0000
Message-Id: <20260708064436.2971933-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD32yfQ8E1qblLgAQ--.30661S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWDuFyUZr1fCFyktF1rXrb_yoW5Cr1rpa
	yfuw13Wryvgr40yan7Ga18Ja4rJan5u3W5Cr17Jw1rAa15uFyqgF1xGFWFva45AFZag34Y
	vr1qqF15C3y8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07j7l19UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

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

v6:
- Add new patch to fix memory leak in bpf_jit_free. (Sashiko)

v5: https://lore.kernel.org/bpf/20260707142219.2871758-1-pulehui@huaweicloud.com
- Fix TCC value was not restored to RV_REG_TCC upon trampoline exit,
  resulting in an infinite tail call. (Sashiko)
- Fix epilogue not restored TCC value to RV_REG_TCC, resulting in
  leaf tailcall callee may clobbered RV_REG_TCC. (Sashiko)
- Remove patch of `Remove ctx->offset initialization` as it would hit
  some corner case. (Sashiko)
- Fix double-count kcfi insn when tailcall to target. (Sashiko)
- Add detail for selftest commit message. (BPF BOT)

v4: https://lore.kernel.org/bpf/20260629140048.733346-1-pulehui@huaweicloud.com
- Fix tailcall hierarchy issue.
- use is_struct_ops_tramp helper in bpf trampoline

v3: https://lore.kernel.org/bpf/20240201083351.943121-1-pulehui@huaweicloud.com
- Remove duplicate RV_REG_TCC load in epiloguei. (Björn Töpel)

v2: https://lore.kernel.org/bpf/20240130040958.230673-1-pulehui@huaweicloud.com
- Fix emit restore RV_REG_TCC double times when `flags &
  BPF_TRAMP_F_CALL_ORIG`
- Use bpf_is_subprog helper

v1: https://lore.kernel.org/bpf/20230919035711.3297256-1-pulehui@huaweicloud.com

Pu Lehui (7):
  bpf: Extract the is_struct_ops_tramp helper
  riscv, bpf: Fix memory leak in bpf_jit_free
  riscv, bpf: Using kvzalloc_objs to allocate cache buffer
  riscv, bpf: Fix kernel stack corruption in tailcall with CFI
  riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
  riscv, bpf: Mixing bpf2bpf and tailcalls
  selftests/bpf: Remove tailcalls tests from DENYLIST.riscv64

 arch/arm64/net/bpf_jit_comp.c                |   6 -
 arch/riscv/net/bpf_jit.h                     |   1 +
 arch/riscv/net/bpf_jit_comp64.c              | 125 +++++++++----------
 arch/riscv/net/bpf_jit_core.c                |   5 +-
 include/linux/bpf.h                          |   6 +
 tools/testing/selftests/bpf/DENYLIST.riscv64 |   1 -
 6 files changed, 72 insertions(+), 72 deletions(-)

-- 
2.34.1

