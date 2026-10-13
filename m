Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA964F68AD;
	Tue, 13 Oct 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893412; cv=none; b=cASCeCt6EpN3y3uKyQJvrLw4953/l068kEqF5g1X73GBhooI/Hlawems9ULFprQ1WlMiEpbcNAPQ1J4uAi5NCVUYS36GjSZ98RFYsKOdERRnJ4/ZAfN3hcSfXaNuK081WXlpU+OUaAUcaqLl7lRDU3kLOEe7NV7nkw1y79VNkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893412; c=relaxed/simple;
	bh=3ZDh12HlIZeRsw2Me7s6uLva2PNxu30fAuHVP8cAURI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SERsWr9iBm5l8bzlu7/MXVWE/7CP6EbQQ2NNrfOyV1KqnHv1Cc+dN2yIZwFIzfkvyaYQjja3k+6aeYsB1egJpcfPLyj9s90nIUIKD/Xt1k7jiID8lxXSyV+6PZFLCH6u3tCwHROAYnjjE0r73E8wNZP0WYGfm5euZLP9CgxKbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxXdKfH85qGVgVAA--.62396S3;
	Tue, 13 Oct 2026 20:10:07 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxg8yeH85q+M4rAA--.64620S2;
	Tue, 13 Oct 2026 20:10:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] LoongArch: BPF: Refine move_imm() and optimize 32-bit operations
Date: Tue, 13 Oct 2026 20:10:03 +0800
Message-ID: <20261013121005.626-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxg8yeH85q+M4rAA--.64620S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Wr18ur1xXF1UCrW7Ww1rGrX_yoWfWwb_ua
	4xAFWkGw1jvFW3JFsF9r1rJr9rCFW7KF1jgFnFqrW8C3y7Ars8JF4kKa15u3yq9rsxZrZI
	qr42kr95Zw1q9osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==

This version is based on v7.3-rc7 and has been tested on a Loongson-3A6000
physical machine.

All of the testcases of test_bpf passed, here are the test results:

$ sudo modprobe test_bpf
$ dmesg -t | grep Summary
test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

For the BPF selftests test_verifier and test_progs, there are no any
regressions.

Tiezhu Yang (2):
  LoongArch: BPF: Clean up and decouple is32 parameter from move_imm()
  LoongArch: BPF: Optimize 32-bit operations using native instructions

 arch/loongarch/include/asm/inst.h |   6 +
 arch/loongarch/net/bpf_jit.c      | 365 ++++++++++++++++--------------
 arch/loongarch/net/bpf_jit.h      |  25 +-
 3 files changed, 208 insertions(+), 188 deletions(-)

-- 
2.42.0

