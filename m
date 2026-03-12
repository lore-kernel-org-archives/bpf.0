Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061834C9AB;
	Thu, 12 Mar 2026 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333440; cv=none; b=IcXapR+9P3u5Jb1Wg7m5o7Bupod10NiZ7KFEzhHFbt/PTiqNEVw5MyAlJbYzbs1Zz01GmCFLjhOvLbnyJ6twL1gM0sX8mMPOUYK59aB9Vvc4PkQwbdh+P0ceTg2gaPU3stmhKVz03ZPeZCxT1ybyRGVc+N8BVbAbunrI720kZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333440; c=relaxed/simple;
	bh=mE55RNw7NfYQ/u3EEwQHOmpYYJu10KJvCBY6+ef2LwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKYoGC1+U3V7rgr6JaaPKqoN8z8G2F9kxX3DFxFkzebSJWiz5z6GijJXv3xJy1cqieiFRxebjKZLdgpKvm7ksVCXG0ROxlDrgmEos9Z+7X+AIhd0XnsfwnQMc+ixkDl8LVzwocmAR7wvO5bvkOIayxvHGNuK5gDPYwGjTaIzMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fWtYh6WyHzKHMXP;
	Fri, 13 Mar 2026 00:36:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8AF0B4058D;
	Fri, 13 Mar 2026 00:37:15 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgBnadm667JpWQmhAg--.17334S2;
	Fri, 13 Mar 2026 00:37:15 +0800 (CST)
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
Subject: [bpf-next v9 0/5] emit ENDBR/BTI instructions for indirect jump targets
Date: Fri, 13 Mar 2026 01:03:58 +0800
Message-ID: <20260312170358.3427846-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnadm667JpWQmhAg--.17334S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrZF47Ar17Kr15Zw48tFb_yoWrCryfpF
	savw13ur4kKr4fXr1fJF40kryaqw48J3W7ZFnxK3yxA3Z09rnruF4Sgw4FvF98Ary0k34Y
	qr4a9r95G34DX37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07j-qXdUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On architectures with CFI protection enabled that require landing pad
instructions at indirect jump targets, such as x86 with CET/IBT enabled
and arm64 with BTI enabled, kernel panics when an indirect jump lands on
a target without landing pad. Therefore, the JIT must emit landing pad
instructions for indirect jump targets.

The verifier already recognizes which instructions are indirect jump
targets during the verification phase. So we can store this information
in env->insn_aux_data and pass it to the JIT as new parameter, so the JIT
knows which instructions are indirect jump targets.

During JIT, constants blinding is performed. It rewrites the private copy
of instructions for the JITed program, but it does not adjust the global
env->insn_aux_data array. As a result, after constants blinding, the
instruction indexes used by JIT may no longer match the indexes in
env->insn_aux_data, so the JIT can not lookup env->insn_aux_data directly.

To avoid this mismatch, and considering that all existing arch-specific JITs
already implement constants blinding with largely duplicated code, move
constants blinding from JIT to generic code.

v9:
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
- Switch to pass env to JIT directly to get rid of coping private insn_aux_data for
  each prog

v4: https://lore.kernel.org/all/20260114093914.2403982-1-xukuohai@huaweicloud.com/
- Switch to the approach proposed by Eduard, using insn_aux_data to indentify indirect
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

 arch/arc/net/bpf_jit_core.c      |  41 ++++-------
 arch/arm/net/bpf_jit_32.c        |  43 +++--------
 arch/arm64/net/bpf_jit_comp.c    |  87 ++++++++---------------
 arch/loongarch/net/bpf_jit.c     |  61 +++++-----------
 arch/mips/net/bpf_jit_comp.c     |  22 +-----
 arch/parisc/net/bpf_jit_core.c   |  75 ++++++++------------
 arch/powerpc/net/bpf_jit_comp.c  |  70 +++++++-----------
 arch/riscv/net/bpf_jit_core.c    |  63 ++++++-----------
 arch/s390/net/bpf_jit_comp.c     |  61 ++++++----------
 arch/sparc/net/bpf_jit_comp_64.c |  63 ++++++-----------
 arch/x86/net/bpf_jit_comp.c      |  71 ++++++-------------
 arch/x86/net/bpf_jit_comp32.c    |  35 ++-------
 include/linux/bpf.h              |   2 +
 include/linux/bpf_verifier.h     |   9 +--
 include/linux/filter.h           |  15 +++-
 kernel/bpf/core.c                | 118 +++++++++++++++++++++----------
 kernel/bpf/syscall.c             |   4 --
 kernel/bpf/verifier.c            |  66 ++++++++++++-----
 18 files changed, 372 insertions(+), 534 deletions(-)

-- 
2.47.3

