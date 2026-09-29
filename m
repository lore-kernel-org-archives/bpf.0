Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB10471405;
	Tue, 29 Sep 2026 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670931; cv=none; b=OjlWdaU2OYd7JLNNAqIBTguDB0F+8Lhhc1h7TV3H549DTdnpHVuLlwiMLu8FOvxwvcDhbk2yx+etackQX3rFhUTJUyU8Zba7aYRE1Htvrq68N0JL0FaFmUqcz/0Hoi7hr3HvkRFVIcHTjYlc5DLFNMPhVpm5gIQxgwYSfkqCT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670931; c=relaxed/simple;
	bh=tdqcXEm1KNek15oq8p1jfywD5Pjtv+ruq/Zo9sdZAPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2fh++5xXIM6GkNupG4q57eEcleI1ZtJa2NKa7SeBIkU587AWzAbV5LtZpnqz+EmD+bQ7ntg9jvtOpyf7GPUbcf+gww/oriy/p0iJitxWtekMgszFwm74x/+J/BhIZ3IxrY1tupjbQa8wasj8rJEBc5MzqMqAAeHGYoxjudxG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hvBLf3kLczYQv1l;
	Tue, 29 Sep 2026 16:34:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 63C5A40C27;
	Tue, 29 Sep 2026 16:35:17 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBXdShEeLtqhxloCA--.42471S4;
	Tue, 29 Sep 2026 16:35:17 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 2/5] selftests/bpf: Set CONFIG_HZ_100 for riscv64
Date: Tue, 29 Sep 2026 08:39:21 +0000
Message-Id: <20260929083924.1851840-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929083924.1851840-1-pulehui@huaweicloud.com>
References: <20260929083924.1851840-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXdShEeLtqhxloCA--.42471S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1kuF4kGF47Zw17tr45trb_yoW8XF17pF
	4rJw1DKas5XF1fu39rCFWUWFWrKanrGrW7GF1ftr15A348KrZ7JFyIka1rtF9xua9rWr4S
	vasagF1a9F4DX37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	xeHqDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

The setget_sockopt selftest fails on riscv64, specifically in the
TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN sub-tests.

The test sets a socket option value in microseconds using
bpf_setsockopt() and immediately reads it back via bpf_getsockopt() to
verify that it matches. However, the kernel converts the value to
jiffies internally for storage, and converts it back to microseconds
upon retrieval. On riscv64, the default timer frequency is HZ=250 (4000
us per jiffy). When a value cannot be divided evenly (e.g. 30000 us),
quantization error occurs during these conversions:

  usecs_to_jiffies(30000) -> 8 jiffies
  jiffies_to_usecs(8)     -> 32000 us (!= 30000 us)

This mismatch triggers an assertion failure.

Let's set CONFIG_HZ_100=y in config.riscv64 to align with other archs
and fix this issue.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/config.riscv64 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config.riscv64 b/tools/testing/selftests/bpf/config.riscv64
index 655cb05a7689..de45a76fdbcd 100644
--- a/tools/testing/selftests/bpf/config.riscv64
+++ b/tools/testing/selftests/bpf/config.riscv64
@@ -29,6 +29,7 @@ CONFIG_FRAME_POINTER=y
 CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HUGETLBFS=y
+CONFIG_HZ_100=y
 CONFIG_INET=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTICAST=y
-- 
2.34.1

