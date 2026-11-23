Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409414;
	b=5feXQK9pghFOtKs1BXI1YIYRLMZFjhrtyDD4PA6XUpzbKUfUW06beFvdF96VjuHF8bp7
	 9FqGMxtv0jPvk8UUmLNT7k98dvFemqwvXLS+FeyQlcpApwrtDAkzCXBPZe4n5oEJfLBhQ
	 NRH9LfxANPqEgQpx4r3ChtEFijHf18kEoX9cbshpO90GXC76EHIEK8UFKjs8fXMYvWjpc
	 LA6lujo21qFAXqW3vbl4EjaHo5Ls/waK/5TB6TBebyWCs8aWmXbZ4wUVtyiSIhd5TLeBP
	 xjbRBP4GgUjgqoxq45ZQKAWuvWs2Ez8batFx3o/vUdsd6sT8TH9L46kfrnWBHp0gV9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409414;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=wshZGIamaXiDv2OhiVIV+Y6IvMShKptZ5P4qM6iglCY=;
	b=UnPbCnNAtF/NsOm9L84/xETAk7J6Gx5V0qWcXdGkdaNct/5LN8viWdtyMOnMlT/JmzUt
	 fLn+V3r/DpAMt8YSlvo8ogwalmNwp3vSk90JbYfaOnN2QPSOWeYkpIv57O05Sb/7JJWv+
	 Gl13b1txKWPQpjAJFDsR+MGd2LTZCKzz+Vvmc4W1G6HPyxzs4i0G5MISszbUSko/VaD2R
	 Yrl0JcJ6kSvw/72hCOZYnD0YgHTkLMPHPznWQCHGzJ0PuNPNXkBqBmBurzrxp56Slv4Jv
	 u0dSbHtnxeLN/6cbJobfiLfiGzs8ZSJbEyFeDXbDJKeYH0rei9TVuTxzrd8tEsEkQ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CD8606A6A5;
	Mon, 23 Nov 2026 04:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3CD8606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxPNACxgNr5x0iAA--.3985S3;
	Mon, 23 Nov 2026 12:50:10 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxX88AxgNrIsw2AA--.43924S2;
	Mon, 23 Nov 2026 12:50:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 0/3] selftests/bpf: Enable instructions array, indirect calls tests for LoongArch
Date: Mon, 23 Nov 2026 12:50:05 +0800
Message-ID: <20261123045008.23691-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxX88AxgNrIsw2AA--.43924S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gw4UAF47AFyrZw4kKr4xXwc_yoWkZrbE9F
	4Fqrn7XFZ7AF12yF1I93WrAFZxC3y5WryxCrWkXFyfJw15Zrs5ZF4kCwn5Za4rWrW3JrWa
	qF4q93yFvr4avosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

Tested on the following unmerged JIT patches:

LoongArch: BPF: Support instructions array, indirect jumps and calls
https://lore.kernel.org/loongarch/20261123043907.20225-1-yangtiezhu@loongson.cn/T/#u

here are the test results:

$ sudo ./test_progs -t bpf_insn_array | tail -1
Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED

$ sudo ./test_progs-cpuv4 -t gotox | tail -1
Summary: 2/14 PASSED, 0 SKIPPED, 0/0 FAILED

$ sudo ./test_progs -t callx | tail -1
Summary: 6/89 PASSED, 6 SKIPPED, 0/0 FAILED

Tiezhu Yang (3):
  selftests/bpf: Enable instruction array test for LoongArch
  selftests/bpf: Allow unaligned access in callx_rodata_misaligned_read
  selftests/bpf: Enable callx related testcases for LoongArch

 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c     | 2 +-
 tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c | 2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h                | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_callx_rodata.c   | 1 +
 5 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.42.0

