Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133B2749DF;
	Fri,  3 Apr 2026 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224174; cv=none; b=PMgF5R0eykoFfhBn3viIBVFvNejMpBJJUOSgHj9pP/ocSkdFC5KJghYpOIe5/aMT61uAn+gZ2riyJYAEYd7VstpJDHON+1xAoiQBfwgqZwkiKoejhlOvZMWXJVoueTQbpsu+dWFLxfUYk6Z6yiPHnwmBS5OEbWTWGZ+tumcURvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224174; c=relaxed/simple;
	bh=jOg3t3SNlLgTtvws3ndxMaPYPDJJKH4V3Nk6firhC3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y45WwOefvHMmVCVifGdoVFTthcqH1ftfZ1tPVCkYdD7jwBTcMIF1bAns3ugNeIuzPHVE6AKLISxx73wkUnGti4AWFMiiaJMXp5Sx0o/DLqz1EeGtPU7LiATV8zWojtuk4giA5e4CdBKX6vF0s7l9XyL26deuFcP2MuKlsWfKzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnKnn46tzzYQtqN;
	Fri,  3 Apr 2026 21:49:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4B8F64057D;
	Fri,  3 Apr 2026 21:49:27 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1Rjxc9pPbfoDA--.34698S2;
	Fri, 03 Apr 2026 21:49:24 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: [PATCH bpf-next v12 0/5] emit ENDBR/BTI instructions for indirect jump targets
Date: Fri,  3 Apr 2026 13:28:06 +0000
Message-ID: <20260403132811.753894-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnB1Rjxc9pPbfoDA--.34698S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF43Kr4xCF1DAr4DXryfXrb_yoW7XF47pF
	s3Zw1a9r4qgr4fXr4xJF48GrWaqw4rJ3W7ZF13K3yfC3WY9Fn7uF4S9w4F9F98Ary0k34a
	qr4a9ryku34DX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU04xRDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On architectures with CFI protection enabled that require landing pad
instructions at indirect jump targets, such as x86 with CET/IBT enabled
and arm64 with BTI enabled, kernel panics when an indirect jump lands on
a target without landing pad. Therefore, the JIT must emit landing pad
instructions for indirect jump targets.

The verifier already recognizes which instructions are indirect jump
targets during the verification phase. So we can store this information
in env->insn_aux_data and pass it to the JIT as new parameter, allowing
the JIT to consult env->insn_aux_data to determine which instructions are
indirect jump targets.

During JIT, constants blinding is performed. It rewrites the private copy
of instructions for the JITed program, but it does not adjust the global
env->insn_aux_data array. As a result, after constants blinding, the
instruction indexes used by JIT may no longer match the indexes in
env->insn_aux_data, so the JIT can not use env->insn_aux_data directly.

To avoid this mismatch, and given that all existing arch-specific JITs
already implement constants blinding with largely duplicated code, move
constants blinding from JIT to generic code.

v12:
- Restore env->insn_aux_data on JIT failure
- Fix incorrect error code sign (-EFAULT vs EFAULT)
- Fix incorrect prog used in the restore path

v11: https://lore.kernel.org/bpf/20260403090915.473493-1-xukuohai@huaweicloud.com/
- Restore env->subprog_info after jit_subprogs() fails
- Clear prog->jit_requested and prog->blinding_requested on failure
- Use the actual env->insn_aux_data size in clear_insn_aux_data() on failure 

v10: https://lore.kernel.org/bpf/20260324122052.342751-1-xukuohai@huaweicloud.com
- Fix the incorrect call_imm restore in jit_subprogs 
- Define a dummy void version of bpf_jit_prog_release_other and
  bpf_patch_insn_data when the corresponding config is not set
- Remove the unnecessary #ifdef in x86_64 JIT (Leon Hwang)

v9: https://lore.kernel.org/bpf/20260312170255.3427799-1-xukuohai@huaweicloud.com/
- Make constant blinding available for classic bpf (Eduard)
- Clear prog->bpf_func, prog->jited ... on the error path of extra pass (Eduard)
- Fix spelling errors and remove unused parameter (Anton Protopopov)

v8: https://lore.kernel.org/bpf/20260309140044.2652538-1-xukuohai@huaweicloud.com/
- Define void bpf_jit_blind_constants() function when CONFIG_BPF_JIT is not set 
- Move indirect_target fixup for insn patching from bpf_jit_blind_constants()
  to adjust_insn_aux_data()

v7: https://lore.kernel.org/bpf/20260307103949.2340104-1-xukuohai@huaweicloud.com
- Move constants blinding logic back to bpf/core.c
- Compute ip address before switch statement in x86 JIT
- Clear JIT state from error path on arm64 and loongarch 

v6: https://lore.kernel.org/bpf/20260306102329.2056216-1-xukuohai@huaweicloud.com/
- Move constants blinding from JIT to verifier
- Move call to bpf_prog_select_runtime from bpf_prog_load to verifier

v5: https://lore.kernel.org/bpf/20260302102726.1126019-1-xukuohai@huaweicloud.com/
- Switch to pass env to JIT directly to get rid of copying private insn_aux_data for
  each prog

v4: https://lore.kernel.org/all/20260114093914.2403982-1-xukuohai@huaweicloud.com/
- Switch to the approach proposed by Eduard, using insn_aux_data to identify indirect
  jump targets, and emit ENDBR on x86

v3: https://lore.kernel.org/bpf/20251227081033.240336-1-xukuohai@huaweicloud.com/
- Get rid of unnecessary enum definition (Yonghong Song, Anton Protopopov)

v2: https://lore.kernel.org/bpf/20251223085447.139301-1-xukuohai@huaweicloud.com/
- Exclude instruction arrays not used for indirect jumps (Anton Protopopov)

v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/


Xu Kuohai (5):
  bpf: Move constants blinding out of arch-specific JITs
  bpf: Pass bpf_verifier_env to JIT
  bpf: Add helper to detect indirect jump targets
  bpf, x86: Emit ENDBR for indirect jump targets
  bpf, arm64: Emit BTI for indirect jump target

 arch/arc/net/bpf_jit_core.c      |  41 +++-----
 arch/arm/net/bpf_jit_32.c        |  43 ++------
 arch/arm64/net/bpf_jit_comp.c    |  87 ++++++----------
 arch/loongarch/net/bpf_jit.c     |  61 ++++-------
 arch/mips/net/bpf_jit_comp.c     |  22 +---
 arch/parisc/net/bpf_jit_core.c   |  75 ++++++--------
 arch/powerpc/net/bpf_jit_comp.c  |  70 +++++--------
 arch/riscv/net/bpf_jit_core.c    |  63 +++++------
 arch/s390/net/bpf_jit_comp.c     |  61 ++++-------
 arch/sparc/net/bpf_jit_comp_64.c |  63 ++++-------
 arch/x86/net/bpf_jit_comp.c      |  73 +++++--------
 arch/x86/net/bpf_jit_comp32.c    |  35 +------
 include/linux/bpf.h              |   2 +
 include/linux/bpf_verifier.h     |   9 +-
 include/linux/filter.h           |  50 ++++++++-
 kernel/bpf/core.c                | 145 +++++++++++++++++++-------
 kernel/bpf/syscall.c             |   4 -
 kernel/bpf/verifier.c            | 172 +++++++++++++++++++++++++------
 18 files changed, 524 insertions(+), 552 deletions(-)

-- 
2.43.0

