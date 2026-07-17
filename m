Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5A3FBB47;
	Fri, 17 Jul 2026 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292862; cv=none; b=HjFjPt3O4+eDDkEMSzr0FwRY4Qxjwh08Jp1wLMFszy7DuOKCwb26SbkL/eaSA5XZ6nyIX/OmiiyP0v7QdZ883XKjrTkbtRNn1cryNawbN94xSFQxQKaD4Pwi2otA/2Yx36YmtH1Tlnzye4T3+qgcFvl8kRKr690VCJbcD70KZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292862; c=relaxed/simple;
	bh=eavWMg8Tv+sJzXf/iqyawMt9vC2nmRKNYPCbEqs9e5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQT/p/SDOoyxZDaajXFb7fOIqUTjV8kUjg6kQCqWs/0gsGuzN4IppWQtFmUWJASZcFCG+a91PKu4GYDOQvR9iB6KYP0/l1S85RoFcCJW6xwDc4BrV8+n7nHlOQ9Dy6pMWZnsCw5RR25r8i17u2U5yoTqPlIaQDls3wRPocZpbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=PcT54msm; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="PcT54msm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=M+/zi6pdCLxE8TVRGh8kVNzJeiJZ8ZxazV
	L1kIRJq9U=; b=PcT54msmyCpRzenTMchL0+NS1NPuJ7+fFFc/9DUrwK8t8HOW9p
	lwCuugcsu3KKLWOAdavwaQwNHpCZ5zEkb4D4WrJghci7GwrwuY8u9rh/Nep3C0zx
	PhgfrodXzV5n9PBYwqj1tUSkrK/vNWxQPB8yacWtl4Qbq5exxeD63for0=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQDntRTdJVpqswkQAA--.23244S3;
	Fri, 17 Jul 2026 20:54:02 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Reject arena frees below the arena base
Date: Fri, 17 Jul 2026 12:53:47 +0000
Message-Id: <20260717-c10-031-public-bpf-next-v2-b4-v2-1-54b555443a7c@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717-c10-031-public-bpf-next-v2-b4-v2-0-54b555443a7c@mails.tsinghua.edu.cn>
References: <20260717-c10-031-public-bpf-next-v2-b4-v2-0-54b555443a7c@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQDntRTdJVpqswkQAA--.23244S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw47WF1ftrWfKr1UXrW3trb_yoW8GF1Dpr
	40qas0yr4Fqr1UZ3yDJF1DCryruFs3Aw4rGF48C3sYkry5ZwnFvF48WF1UWa4Y9r4vvrWa
	vr1SqayY9wn0937anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkE
	FVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
	8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
	s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFI
	xGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6ryUMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUU_WrtUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_arena_free_pages() accepts scalar arena addresses. The runtime
masks the address to the low 32 bits and reconstructs a full user
address from the arena base before returning the range to the arena
free tree.

When the scalar value is below the low 32 bits of the arena base,
full_uaddr falls below user_vm_start. The existing upper-end clipping
then turns this into an out-of-range free-tree offset. A later
allocation can reuse that offset and return an address below the arena
mapping.

Reject such frees before computing the clipped range.

Fixes: 317460317a02a ("bpf: Introduce bpf_arena.")
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/arena.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 80b7b8a694464..97a5d8d212955 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -853,6 +853,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	uaddr &= PAGE_MASK;
 	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
 	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
+	if (full_uaddr < arena->user_vm_start)
+		return;
 	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
 	if (full_uaddr >= uaddr_end)
 		return;
-- 
2.34.1

