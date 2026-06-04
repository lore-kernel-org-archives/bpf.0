Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308B18CC13
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596471; cv=none; b=hX0Hy+ZxYf4NBMdPsJwl8Ka/3jy0qNk+cDrhZCF7XvyFU+q/8ChcrC+l3Zqp+1eL3KfbwwJEdCaF834jeEwJVEPtEncvRtCenswZibjXVgqtv0vhhJQkdn+otm6+FGma04h3lt8jaTxihZ6xUe4AK7sPr5HBV8wwd2qpoxtFei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596471; c=relaxed/simple;
	bh=RHGeyDqQ7BmZegVzHy9q8dF9SY0+8a62IY2HwHKWkXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KV7ug2JjQu9Vo52dUMyQFDMESmoDAb1fRkB7g0IDtGQRO0J7fSDzt1o97auCLzDkQtGVIqa1KEnx6DsAdFzSoT+foJSV1SeNt69ruNbEIL5MnmySBvEl8O9X6JkbGGLyv4Eyk5w/WZpAyVKDcoCKJ3SMl2c7VkTH2fHAri1ZQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=YhWy9LTB; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="YhWy9LTB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=zn+Z/
	GdV8nv6tBbjFVnAeUmHe9nVGoftrExnb2vaPrA=; b=YhWy9LTBX7oazqCrci9XO
	DmxbmjAoDiuPjCawYOrJprY8xJtwi7cUdemRSklvu7P3AFRjWN2U+LIts27D4EEb
	OQeA/NhVft5e+TAqfQQu9+8VuneOoNYoBqC065Pv+URheTyvj7CslQYqSqCbca3T
	grLbhJM7XHpMz89jrGPvkU=
Received: from dumpling.. (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQDHn5fnviFqazoNAg--.16320S2;
	Fri, 05 Jun 2026 02:07:35 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf, verifier: fix PTR_TO_FLOW_KEYS constant-offset OOB
Date: Fri,  5 Jun 2026 02:07:28 +0800
Message-Id: <20260604180730.2518088-1-gnq25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQDHn5fnviFqazoNAg--.16320S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xJFW3ZF47Cw1UGw1UAwb_yoW5JrWkpF
	ZYk3WavF4DtF42ga17AF4IvFy5Kws3ua1YkF1UAw1rAa4DX3W8GrW2gr42kryakr98Gw4j
	vFyrW39a9a1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262
	IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx2
	6r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_XwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x0JjepBfUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEIA2ohcr9yWAABsm

A constant offset added to a PTR_TO_FLOW_KEYS register lands in
reg->var_off, but check_flow_keys_access() bounds-checks only insn->off
and never folds reg->var_off.value.  A BPF_PROG_TYPE_FLOW_DISSECTOR
program can therefore do "flow_keys += 0x1000; *(flow_keys + 0)" and have
it accepted, then read/write kernel stack past struct bpf_flow_keys at
runtime.  Patch 1 folds reg->var_off.value into the offset (and rejects
non-constant offsets), mirroring check_ctx_access(); patch 2 adds verifier
selftests.

This is a regression introduced in the 7.1 development cycle by commit
022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers"),
which moved the constant offset from reg->off (folded generically before
022ac0750883) into reg->var_off without updating the flow_keys path.  No
released kernel is affected: v7.0.x rejects the program above, and the bug
reproduces only on v7.1-rc1..rc5, so no stable backport is needed.

It was first reported privately to security@kernel.org; per their guidance
it is handled in the open as a normal regression fix.  Found by manual
verifier audit and confirmed dynamically in a disposable QEMU/KVM guest:
the load above is accepted, a runtime read leaked a kernel-stack pointer
0x1000 past bpf_flow_keys, and a runtime write of a marker faulted the
guest in net_rx_action.

An alternative -- forbidding pointer arithmetic on PTR_TO_FLOW_KEYS
outright by dropping "if (known) break;" in adjust_ptr_min_max_vals() --
was rejected because v7.0.x accepted (and correctly bounds-checked)
constant arithmetic on the keys pointer; restoring the fold preserves that
behaviour while closing the divergence.

v1 -> v2:
 - Target bpf-next instead of bpf (per reviewer feedback).
 - Base-commit updated to bpf-next/master.

v1: https://lore.kernel.org/bpf/20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn/

Nuoqi Gui (2):
  bpf, verifier: fold reg->var_off into PTR_TO_FLOW_KEYS bounds check
  selftests/bpf: add tests for PTR_TO_FLOW_KEYS constant offset bounds

 kernel/bpf/verifier.c                         | 19 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_flow_keys.c  | 77 +++++++++++++++++++
 3 files changed, 95 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_flow_keys.c

base-commit: bf29346fc393981ec9be607c2d0c0f38d63c9b73
-- 
2.34.1

