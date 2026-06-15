Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1613DA7E1
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517919; cv=none; b=Bch0gIpKoAQTUiNvbzJdwY7o2B2yqXkvVH0VNn+rTL0x/WY/jSv1IHTJl84Ld5mLmoxV/TNwYMB7cwTuVR2FlCH8A0l6nZwqZ7IqVTxuJwAOOuVOzqHEi7sK5rOobl57Ls4b2Ll3PX/90wyAWfO7Neq9UzLN1nPj9XYMJvZNz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517919; c=relaxed/simple;
	bh=IJSRc1DoJsMLba6ZQkwYNE6uOEsii/z9yqLMuK0Nbzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o42+H4+VWQzN3CIwHJkP2FWivjOzgCuYhyDvitWeYGXsl7vss8gk1FJtdBpUEWVRR6tCKBtU64Z+6QVQXM4eeXCmeleeR9T92r20cxPJrzio6l9RKi72zQJ0ccgEzsQdkGtyf4Y9whpEKTYQl8yxNauyMuHyRfztdc/MEb6AMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx4epXzi9qLU0UAA--.53460S3;
	Mon, 15 Jun 2026 18:05:11 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxzsJTzi9qlgOnAA--.55069S2;
	Mon, 15 Jun 2026 18:05:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: Add some tests for LoongArch
Date: Mon, 15 Jun 2026 18:05:02 +0800
Message-ID: <20260615100506.19558-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsJTzi9qlgOnAA--.55069S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1DKrW3Kw1DJr18Cr1ruFX_yoW8JFyDpa
	y09FnxKr18XFy7X3W3C39xWF1aqrn3urW8A3WfKr909rsrXryUJryxKFW3Xwn8CryrurWF
	v34xtwnxG3W8JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYSoJUUUUU=

This series is based on the latest master branch of bpf-next tree.
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/

Dependency Note:
================
This series strictly depends on the following LoongArch core series,
which moves thread_info into task_struct:

"Move thread_info into task_struct for LoongArch"
https://lore.kernel.org/loongarch/20260612011616.27771-1-yangtiezhu@loongson.cn/

Because of this cross-tree dependency, these patches are based on the
bpf-next tree for review, but the actual merge timing and routing are
left to the discretion of the BPF and LoongArch maintainers.

Tiezhu Yang (4):
  selftests/bpf: Add get_preempt_count() support for LoongArch
  selftests/bpf: Add __arch_loongarch to limit test cases for LoongArch
  selftests/bpf: Test jited inline of bpf_get_current_task() for
    LoongArch
  selftests/bpf: Test jited inline of bpf_get_smp_processor_id() for
    LoongArch

 .../testing/selftests/bpf/bpf_experimental.h  | 23 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
 .../selftests/bpf/progs/verifier_jit_inline.c | 13 +++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  5 ++++
 4 files changed, 42 insertions(+)

-- 
2.42.0

