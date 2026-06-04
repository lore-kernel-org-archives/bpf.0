Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDE52F7EFC
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585695; cv=none; b=BlI4AZl7Of7n0JVEUJ3F9PUfxcurQgKg4erO1X/0zh7lTGSUeXrHZ+FnSm83tagnMHPqwQEVzSLS7hcIY3R7VNHF5lHZCSCE61ovcvZo6NYkOWe+5Z6sA+NFjBQe9RXgwHxiCC780cKHe9pE7goj48atuHAH+hpUHs4iWLFrqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585695; c=relaxed/simple;
	bh=/GRCw8kRIpgaj1zndI+BHvXDagUBaHwkppzORrJY0B8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Btviczx8GfWAYLeghuUKOGCD+K8uZQDIHkF2SDerHTmegqmaVk2pwAXoXpSMm4yhR03V4x+LphAQqePu5mEdY4Nu5zdzZ23vBw7+J/8mXjVctAF1C2FeQAXte1729r868U20dCYsUc6ww/66B2moZyGe1WOikTKVmZbudzyVry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=e1urvHcn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="e1urvHcn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=fqXUa
	EVMQFR2qtSZ++SPKEiUiKyXbemiOvPwBOUtboI=; b=e1urvHcnVMFO/0w+7lMu5
	qgbjA4ebRNxZiThfDsDcXNy1HUdHbAzsSoGFHNGvU4OZ36ZN1lqg4elvdlGG5ja9
	UfrmL+i8Q8kcYO/HDok+d5SkTQqYE03FqyWXDYIepO9o9M5KN3rbwyQ3y/OivjHm
	V3jGU4bi/T82OCP8iIMPaA=
Received: from dumpling.. (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQDHE5HQlCFqqyQrAg--.52018S2;
	Thu, 04 Jun 2026 23:08:00 +0800 (CST)
From: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>,
	bpf@vger.kernel.org
Subject: [PATCH bpf 0/2] bpf, verifier: fix PTR_TO_FLOW_KEYS constant-offset OOB
Date: Thu,  4 Jun 2026 23:07:53 +0800
Message-Id: <20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQDHE5HQlCFqqyQrAg--.52018S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xJFW3ZF47Cw1UGw1UAwb_yoW8tFy5pF
	sYk3Wavr4DK3W7Wa17AF1IyFy5Krs3uF45CF1UAr1rAa4DXw18KrW2gr42kFyakr98Jw40
	vFWrW39a9a1qyaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwV
	AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6x8ErcxFaVAv8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ryr
	MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0Jj5R6wUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQQIA2ohcr8y2AABsj

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

Nuiqi Gui (2):
  bpf, verifier: fold reg->var_off into PTR_TO_FLOW_KEYS bounds check
  selftests/bpf: add tests for PTR_TO_FLOW_KEYS constant offset bounds

 kernel/bpf/verifier.c                         | 19 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_flow_keys.c  | 77 +++++++++++++++++++
 3 files changed, 95 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_flow_keys.c


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.34.1

