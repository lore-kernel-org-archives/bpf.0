Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6B3E1CEF;
	Fri, 17 Jul 2026 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292857; cv=none; b=ADb9bFnXL7wi/dQ66igHtLDnoYh6B8Q3VneT+sv+FZOpgM7YWMip50i5J7GYyzCPCRBZ2h2hCvzLz22CRfiPp4k4T0FyPN7YdF27h3W49Ok6yGobyIHzrCX9bIJWuYsuJaBQMCiFqE1Txxl4j10dUaF1ETgoEU+37dXERflO9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292857; c=relaxed/simple;
	bh=GsNjtOzEtpfYQr754hqRJlqmpZDW1+0T3geCNbKwdZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W3qfqP1rvbMynRy3KEipOR7FWy4vnhaEFX3gEqB1Arx1PA0DHdDsdYOeo90HR4FQbMhxXiOM44Iw3Zaz/zMDHs6NXmbjqW9xY84qdIXaza3+YaitWYAgWgH0NVUR3gIMtAiZvyPm9Ym+4343/IwlHMX6NN4FMXIjbnF9l+fIlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ZbE592zy; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ZbE592zy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=KvBE6
	w7iPBhyaQ2qmkua2gCM+8n6qaD69gXol9+z+zk=; b=ZbE592zyM0SoYrL9EKqWD
	qrLmE7Mo9gG5vtTha/DeegruBuvr1MB0505JzJiJdMeEVHtpvbKEmVJkxZbq4BRb
	gFIEY+ZxIM/Los7aIRZbu+zXiYUCaj4fTF3eP59wr7Yh0FRxBDZnj2UslHDwLhB5
	AekqXMx93QrCf5iQOIg5mw=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQDntRTdJVpqswkQAA--.23244S2;
	Fri, 17 Jul 2026 20:53:59 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf: Reject arena frees below the arena base
Date: Fri, 17 Jul 2026 12:53:46 +0000
Message-Id: <20260717-c10-031-public-bpf-next-v2-b4-v2-0-54b555443a7c@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQDntRTdJVpqswkQAA--.23244S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw43XFyrZr47XF1xZFWUArb_yoWkGrb_Wr
	48Ka4DGr4DWFnI9a4Ykr1fZrW8CrWUKry3Ar40gFW7Xry5ZF17GFs3ArnIvryxGa1Ygr95
	JF1akFn7ArZ3ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r
	yUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbqXdUUUUUU=
	=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_arena_free_pages() can be called with a scalar arena address. The
runtime reconstructs a full user address from the arena base and the low
32 bits before returning the range to the arena free tree. A scalar one
page below the arena base can otherwise produce an out-of-domain free-tree
offset and make a later allocation return an address below the arena
mapping.

Patch 1 rejects frees whose reconstructed full user address is below
user_vm_start. Patch 2 adds verifier_arena coverage for the
scalar-below-base case.

Changes in v2:
- Add Reviewed-by tags from Emil Tsalapatis.
- Remove the empty inline asm from the selftest.

v1: https://lore.kernel.org/bpf/cover.1782813442.git.chenyy23@mails.tsinghua.edu.cn/

Yiyang Chen (2):
  bpf: Reject arena frees below the arena base
  selftests/bpf: Cover scalar arena frees below the base

 kernel/bpf/arena.c                                 |  2 ++
 tools/testing/selftests/bpf/progs/verifier_arena.c | 40 +++++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d
-- 
2.34.1

