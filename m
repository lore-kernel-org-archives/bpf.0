Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EC395D8C;
	Mon,  2 Mar 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445718; cv=none; b=di6cF/G6/rtAjnu4wXUEDZo9nNqtL3ZskIfpi8af+KdO/9xxq184lpdR9mQPTr23IgfAntJ/3KEUpqUfIR4RWlt1y4F0ASPhCCgvyMxsCYSRqTpVPuYk+X9lvLNrrCUX/61xhbAlHOOiZQiD87PL30YY/6qLbWXbXid/TojkJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445718; c=relaxed/simple;
	bh=1lgHYZ37HVsa+X3agiTgjFACRsvvXvQxXnWxr9TxKlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B80/ugmwKaTB4dP1NkkpkjLdsM71BydC0do0gLwCuureTLvpIFq0MFojT9SWUlf82OnSIk+er8G2rfQiQmD+8BUHaC+bWje2V8wXWyBKx0vboyI8KPc7FnrKBYBXbjn47tjV2tZQ9j38NukXM1BgMdrRG0qHMcYUIYhIVRa2AJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fPZFn27whzYQv92;
	Mon,  2 Mar 2026 18:01:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49ABA40576;
	Mon,  2 Mar 2026 18:01:49 +0800 (CST)
Received: from k01.k01 (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCXQvMKYKVpfu0vJQ--.22492S2;
	Mon, 02 Mar 2026 18:01:47 +0800 (CST)
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
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v5 0/5] emit ENDBR/BTI instructions for indirect jump targets
Date: Mon,  2 Mar 2026 18:27:21 +0800
Message-ID: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXQvMKYKVpfu0vJQ--.22492S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw17Wryftr18Cw4UZF4Utwb_yoW8uF1xpF
	4kCr1a9r4v9rWfZr1fCa17ury3tw48Ww17WFnrC3yrAa4YqasrWF43Kw43XFZ0yry0ka45
	ZFWa9r9YkrykX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jeLvtUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On x86 CPUs with CET/IBT and arm64 CPUs with BTI, missing landing pad instructions
at indirect jump targets triggers kernel panic. So emit ENDBR instructions for
indirect jump targets on x86 and BTI on arm64. Indirect jump targets are identified
based on the insn_aux_data created by the verifier.

v5:
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
  bpf: Move JIT for single-subprog programs to verifier
  bpf: Pass bpf_verifier_env to jit
  bpf: Add helper to detect indirect jump targets
  bpf, x86: Emit ENDBR for indirect jump targets
  bpf, arm64: Emit BTI for indirect jump target

 arch/arc/net/bpf_jit_core.c      | 19 +++----
 arch/arm/net/bpf_jit_32.c        |  4 +-
 arch/arm64/net/bpf_jit_comp.c    | 21 ++++----
 arch/loongarch/net/bpf_jit.c     |  4 +-
 arch/mips/net/bpf_jit_comp.c     |  4 +-
 arch/parisc/net/bpf_jit_core.c   |  4 +-
 arch/powerpc/net/bpf_jit_comp.c  |  4 +-
 arch/riscv/net/bpf_jit_core.c    |  4 +-
 arch/s390/net/bpf_jit_comp.c     |  4 +-
 arch/sparc/net/bpf_jit_comp_64.c |  4 +-
 arch/x86/net/bpf_jit_comp.c      | 25 +++++----
 arch/x86/net/bpf_jit_comp32.c    |  4 +-
 include/linux/bpf.h              |  2 +
 include/linux/bpf_verifier.h     | 10 ++--
 include/linux/filter.h           |  6 ++-
 kernel/bpf/core.c                | 93 ++++++++++++++++++++++++--------
 kernel/bpf/syscall.c             |  2 +-
 kernel/bpf/verifier.c            | 22 ++++++--
 18 files changed, 157 insertions(+), 79 deletions(-)

-- 
2.47.3

