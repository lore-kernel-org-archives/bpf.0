Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409416;
	b=Ao9+suIoQPqEMa7bpp9PW9cU1wjvJoWYMGbpkz+7+LHrKiUL9MC+cSOu0ZUmDxCRgtJH
	 nDHiC0j8N70ILkfSBOWwR/uVP/McYLR/pLiQjvWmMfX0NY3nRtg8DBjjE3y8Fs2rPNdCu
	 yyI3rOhv70+i88Hb1J2wmt/ur+JEWgWQjLHoq6kDkmKoqIgRNKsm7xaAC0zegIewQ8Qqm
	 SePaUIF1iGb/sNNhNrM1SAbZdxMOr9B4yLis34ow6KeqbtpEUb5JPSC3KLvZWNU0AbD9F
	 7e/76c3qTj+vatkr/U9qucG821D4KkAI8mll22QLPat2u1y0p8kFS7gdi8c/CriCvtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409416;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=YyXLF78KCettZXiSKq1HR6wyzPidcEExzxdLrgHUJkw=;
	b=tiHrd99fF7e7dEla03eFQDdbZQ+FHpJy2TclANwzUgIZWVy7Z+6w2BNQjU704ubI/Z4m
	 OjEDxEONuhOZhieKHhn/IunoCIgungbdpCwMpvMMRXSsGA5OuMLCc6pBmjfMulcLmajTy
	 pLp8SulTqBur6YRuo0F8aE3i8xY7FToROBH3ACeLe7tvAn9P+V34h5w7A9nYSp7oQmgXH
	 xfpIh9zq6eR4LPsusQeQv4WyBZGXOZOew+k7R7SAYH1bYOn+AzSX8/M5N+tK2fuxZXLkT
	 HDB9CSW+U7+OSN9nAAwn5ohU0lSYeQQ0JsR/XB54MBFoAwPMrAJ2z1SUVXkRfckzbCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC4606AE3F;
	Mon, 23 Nov 2026 04:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2CC4606AE3F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxuLUCxgNr7R0iAA--.3878S3;
	Mon, 23 Nov 2026 12:50:10 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxX88AxgNrIsw2AA--.43924S3;
	Mon, 23 Nov 2026 12:50:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 1/3] selftests/bpf: Enable instruction array test for LoongArch
Date: Mon, 23 Nov 2026 12:50:06 +0800
Message-ID: <20261123045008.23691-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261123045008.23691-1-yangtiezhu@loongson.cn>
References: <20261123045008.23691-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxX88AxgNrIsw2AA--.43924S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtr1fWw17CFykCFWftr43Jwc_yoWkXFX_Ka
	12qrs7ZFWkCFyqq3W8uFySgFW8ur4rurs7Crn8Wry7J3WYgay5WFs5C3s8Aas8W39xJFW3
	tF4kX3y3Cr4rCosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4OzVUUUUU

As the LoongArch JIT supports instruction array (gotox jump tables),
enable the corresponding BPF selftest for LoongArch.

With this patch:
  $ sudo ./test_progs -t bpf_insn_array | tail -1
  Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 4ffe4fe6b78e..6b1a426aa4cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -5,7 +5,7 @@
 #include <test_progs.h>
 
 #if defined(__x86_64__) || defined(__powerpc__) || defined(__aarch64__) || \
-	(defined(__riscv) && __riscv_xlen == 64)
+	(defined(__riscv) && __riscv_xlen == 64) || defined(__loongarch__)
 static int map_create(__u32 map_type, __u32 max_entries)
 {
 	const char *map_name = "insn_array";
-- 
2.42.0

