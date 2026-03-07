Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC433B6D9;
	Sat,  7 Mar 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772878401; cv=none; b=L2CUmxzBs+9g0ba4dwfSKk6iY3mfAYrukHMzXzZvxO5n47em2yOVXmG/CzFqGJZyyPEYyG/SUgEE9fXFl7xAgfTg/X6SXZXI3gOMNrcWKiShyQINjDIMumBkfPp/XnVIOiNaGy9jX3tlQ0xxcayrpF4ObcRRr5bd4lRkHy5BIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772878401; c=relaxed/simple;
	bh=O+mulSeeMZEN97sEHYfVop+OCIuez4a60edqBj2BT3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jjf9HsLo6XwASr8xsMfW8oKjwT44wL1YuJXqoIeHxb3yvTCQ0iYVefsmOh7xX30GbrLiImrrYBDCSNOtpTaB0h5KrJOIAlOKzqAX44tzcXu4aFBvVqpGcjD73cJPflKqSE0Pyt4Iwybmp0Bv7W/tupKLihQ4hS6VUX7JOFEFVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fSfGN0HQqzYQtyq;
	Sat,  7 Mar 2026 18:12:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8228A40575;
	Sat,  7 Mar 2026 18:13:08 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCngEsw+qtppX4jAA--.3809S2;
	Sat, 07 Mar 2026 18:13:06 +0800 (CST)
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
Subject: [bpf-next v7 0/5] emit ENDBR/BTI instructions for indirect jump targets
Date: Sat,  7 Mar 2026 18:39:44 +0800
Message-ID: <20260307103949.2340104-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngEsw+qtppX4jAA--.3809S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrZF47WFW8Cr4xCF4Uurg_yoW5Kw18pF
	s3ur1a9r4v9rZ5Xr1xJF40gryaqw4UJ3W7ZFn8K3yfA3WY9rn7uF4Sgw4fXF98try0k34F
	qF4a9r98G34DX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07jxCztUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On architectures with CFI protection enabled that require landing pad
instructions at indirect jump targets, such as x86 with CET/IBT eanbled
and arm64 with BTI enabled, kernel panics when an indirect jump lands on
a target witout landing pad. Therefore, the JIT must emit landing pad
instructions for indirect jump targets.

The verifier already recognizes which instructions are indirect jump
targets during the verification phase. So we can stores this information
in env->insn_aux_data and pass it to the JIT as new parameter, so the JIT
knows which instructions are indirect jump targets.

During JIT, constants blinding is performed. It rewrites the private copy
of instructions for the JITed program, but it does not adjust the global
env->insn_aux_data array. As a result, after constants blinding, the
instruction indexes used by JIT may no longer match the indexes in
env->insn_aux_data, so the JIT can not lookup env->insn_aux_data directly.

To avoid this mistach, and considering that all existing arch-specific JITs
already implement constants blinding with largely duplicated code, move
constants blinding from JIT to generic code, before copying instructions
for each subprog.

v7:
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
  bpf: Move constants blinding from JIT to verifier
  bpf: Pass bpf_verifier_env to JIT
  bpf: Add helper to detect indirect jump targets
  bpf, x86: Emit ENDBR for indirect jump targets
  bpf, arm64: Emit BTI for indirect jump target

 arch/arc/net/bpf_jit_core.c      |  37 ++------
 arch/arm/net/bpf_jit_32.c        |  43 ++-------
 arch/arm64/net/bpf_jit_comp.c    |  86 ++++++-----------
 arch/loongarch/net/bpf_jit.c     |  58 ++++--------
 arch/mips/net/bpf_jit_comp.c     |  22 +----
 arch/parisc/net/bpf_jit_core.c   |  40 ++------
 arch/powerpc/net/bpf_jit_comp.c  |  47 +++-------
 arch/riscv/net/bpf_jit_core.c    |  47 +++-------
 arch/s390/net/bpf_jit_comp.c     |  43 ++-------
 arch/sparc/net/bpf_jit_comp_64.c |  43 ++-------
 arch/x86/net/bpf_jit_comp.c      |  68 +++++---------
 arch/x86/net/bpf_jit_comp32.c    |  35 +------
 include/linux/bpf.h              |   2 +
 include/linux/bpf_verifier.h     |   9 +-
 include/linux/filter.h           |  11 ++-
 kernel/bpf/core.c                | 152 +++++++++++--------------------
 kernel/bpf/syscall.c             |   4 -
 kernel/bpf/verifier.c            |  34 ++++---
 18 files changed, 228 insertions(+), 553 deletions(-)

-- 
2.47.3

