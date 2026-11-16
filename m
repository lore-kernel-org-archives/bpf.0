Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794801553;
	b=siCwlLthUB74ufP93TUwmYR9bXpgrDe988T2yl/gWyUovNUzvf1IEM9wuTMgu//3YCHs
	 Tb60WGlSDDwVAEy5mCSpA/bMYxqhFC9WdUyQVluKm8n2m2vCIQkOA8zBrBx8IYdt/NybH
	 1wUb5MtfBA25Z2Xc/qKPGG5qu4CvNVs54G381kdBHRWSsz39G6JrnugPD7wZOlmzCfMwy
	 NiH2n2l77C5QcwoLD4YIzTlVHXvYsebD+mZmG5XxAVqLpt5am1qRK2eHoGXviVC9NU2nF
	 01nMmrAizf76YuTpjtySyUSr4PsWyy0UQQpgRuSJoqwBw1gQ+xIdtbz073zoYBWXkjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801553;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=u/9HiJ1D6J/bSIpqYllMpqKapDFD/PBU/bx4yvfHXM8=;
	b=stEAlbrFSwYEoc905/bbhzKtjvKTuVyB2mnYqC4pGh4QUbyR6xp2JYzyikAbhYe5q2do
	 nIkzFLMxbDZSN20t8Yir6dASvx9Hc3ciEXxAIF/J1M3YEsiE8ja+05pRm3gOsSnsfNv04
	 RAQZQ5p+kLGMve/grlTKDMJ/Y619aQyIp07L4FXGXhIAxgpg1izVIkTr18Bnw3Uu2eykM
	 kIt6sVAhCdaORTG4eo+1mAQ3TsHT1junuZiO7EwuPLiUkdGv7LqGsmiToqw7PrCc+lN5X
	 /WfUR0GJ6dqxHh9GIarN8lQp/zoZlJygYaWztHfpj2g6GgkrafM65ctJbgjRzYNPV+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E64D606A31F;
	Mon, 16 Nov 2026 03:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E64D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxUNGOf_pqOgAgAA--.27227S3;
	Mon, 16 Nov 2026 11:59:10 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs2Mf_pqKNE0AA--.64529S2;
	Mon, 16 Nov 2026 11:59:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/4] selftests/bpf: Handle unexpected failures on unsupported hardware
Date: Mon, 16 Nov 2026 11:59:03 +0800
Message-ID: <20261116035907.4215-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJBxJs2Mf_pqKNE0AA--.64529S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF1kZw4xCFWxXFykGr4DAwc_yoWftrXE9r
	48trykXFWDAF90kF1Fg3WkCrWqkw4ru348tFyDWa47Jw15ZF15XF4vyryFva48W393t342
	vFs8Ja9Ykr47WosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

v3:
  - Introduce SKIP_TESTS() as a generic utility to avoid fragile
    hardcoded string arrays in test runners.
  - Add missing Fixes tag to the fexit_bpf2bpf alignment fix patch.
  - Add a new patch (PATCH 4) to handle another unaligned access
    failure encountered in jit_insns/tail_call.

Tiezhu Yang (4):
  selftests/bpf: Add SKIP_TESTS() helper for test_loader
  selftests/bpf: Skip jit_insns_arena tests if not supported
  selftests/bpf: Fix unaligned access failure in fexit_bpf2bpf
  selftests/bpf: Allow unaligned access in jit_insns/tail_call

 tools/testing/selftests/bpf/prog_tests/jit_insns.c  | 7 ++++++-
 tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c   | 1 +
 tools/testing/selftests/bpf/progs/test_pkt_access.c | 1 +
 tools/testing/selftests/bpf/test_loader.c           | 5 +++++
 tools/testing/selftests/bpf/test_progs.h            | 8 ++++++++
 5 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.42.0

