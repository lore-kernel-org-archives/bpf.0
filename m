Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795857022;
	b=V7S9o0cIwNMwEurSjhMaQXCJwqFr7nD7FYYIrzNZK+R1nnAKZlmIFvHNzjDKdxW0kTh9
	 SvroWOAn8aNAxFCmmklXta/fNLGS+/e5WiVzwue64sLRlGAONsLylskWHA/DFNcrhkm96
	 XM9zQ3RKRlvSo8FgzRzKNUc+0/sGRnysOfhS7ybXSoWjLO/PMwDz3EqsN5+9NdnB9b6Hk
	 /FQsx66Sy1MjprFJMxAmqewCwF1T2oQkAJRQQ7/pexizX4X4qxFfHbEGuuL8yYV1KJt03
	 c8B1bx+wsLWVpm75+yB1Ft8VLtmyYcupr5tiNAn56rOKkVeSiCumoI1X63bKeWGX+4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795857022;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=RTnzyFnlH0n6VkFyzvU0eN9sd7NO/y5UXvFcLdOosig=;
	b=HHvJOGE1gLW97qLvLgZYbI9eSfCmM+8akOPJMJyBuQmj20xXDUmHs5cNXo2sj4nGZEIQ
	 EpKnW9sYI2Bym1fpa6pm0gUYUT+LhHALI/Fn1cnas2EmPRcMyGikOwjFTBEydViA4U96r
	 vtRcP2qIu9tdac7XYyer+HdaKcUoEBOAG87UPLt5K+RTXV/YPIgLzZkSIdbgMg5Doh64f
	 7zEms2uQHuz7WP+2X/VZE4MwaLH2ekni2UFb1VFTflFp54K1h3v2TtxPYqqV9Xw8tDcPh
	 cwM5/aitXm3L8M778+Om7kf5Jzu+l3Qn8reCeh45LRFoVhGNqgqY0GndjLFeu+SHB1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669CD606A31C;
	Sat, 28 Nov 2026 09:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 669CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Bx69FymgprAsMjAA--.35435S3;
	Sat, 28 Nov 2026 17:10:10 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx1cxxmgprh_I3AA--.16824S2;
	Sat, 28 Nov 2026 17:10:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: Fix uprobe_autoattach test
Date: Sat, 28 Nov 2026 17:10:05 +0800
Message-ID: <20261128091007.25084-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx1cxxmgprh_I3AA--.16824S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Wr1xJF1xAFWkCryUtr4fZwc_yoWDXrgE9F
	ZFqFykXayDZFy7CFW29r1rGFZ8JanxGr4xAFWUXay3Jr15Xr4UtF4kGr4UZ34vgrW5Grya
	qF1kZFWfur4aqosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUUUUU==

Changes in v2:
- Move the definitions of FUNC_REG_ARG_CNT into a new shared
  header bpf_arch_regs.h instead of including progs/bpf_misc.h
  from user-space, and add bpf_arch_regs.h as a dependency of
  test_uprobe_autoattach.bpf.o in Makefile.skel.
- Name it bpf_arch_regs.h rather than uprobe_autoattach.h for
  better generality, even though it is currently only used by
  uprobe_autoattach.

Tiezhu Yang (2):
  selftests/bpf: Move FUNC_REG_ARG_CNT to bpf_arch_regs.h
  selftests/bpf: Define FUNC_REG_ARG_CNT for LoongArch

 tools/testing/selftests/bpf/Makefile.skel     |  2 ++
 tools/testing/selftests/bpf/bpf_arch_regs.h   | 31 +++++++++++++++++++
 .../bpf/prog_tests/uprobe_autoattach.c        |  1 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 24 --------------
 .../bpf/progs/test_uprobe_autoattach.c        |  2 +-
 5 files changed, 35 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_arch_regs.h

-- 
2.42.0

