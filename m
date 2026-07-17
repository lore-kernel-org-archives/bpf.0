Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE23ACA49;
	Fri, 17 Jul 2026 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292859; cv=none; b=SpzOOg2OqMRmDLiDUc4QIyfM/zq9vbqOhPLKDSq9+4FlcWLIS/SFJnZOZapUbDYQ7iyA5ei8/uPFGW+87H2I6FzgJ+99H0f6T605jV377m6uGhagJ04Ib8AqpAc0cfmsEaQHF8EJiapDPPFjccnjOgw5Rbb2CgYQTDLt1ZTMU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292859; c=relaxed/simple;
	bh=6p3U0cYKupLSdp9+h1BJF6vIITYYmrl2/PZnJfl+OY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mkj/DusM0xgmN9c0LdYikjoUxg5RdvDWvHj4PgC0G9CNfbskDvgOWQh8wccobvX5igEP+5Pqmqz52wZYB7vMrY/Neoqdqtn2a8h4xyPDF6qNNxF2vNQJvuy9Syxe+5t1aX9r3PiOit32pNztSR+6eQfjaZeZr3iXhQD0Qm675Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=DNfcHRgX; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="DNfcHRgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=mfOilf5Oizm7dJtrcb+HOckmggeAshiznJ
	gfi6hN2zg=; b=DNfcHRgXXCTBBBf0wyMwwWT+3YAPsVakSl1dJhU48bwiZayZ67
	isaWIjtrO/p8tRcUpHpzXCv4RUgsZEya6yOhslUbh1DaaoEeY+IE60f7+aoUSEDG
	iMnD0S2lX509BHh2f+Wr2w+c0MQk42Uct1bhZNB8dscC9kiCAb7wahDNw=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQDntRTdJVpqswkQAA--.23244S4;
	Fri, 17 Jul 2026 20:54:04 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover scalar arena frees below the base
Date: Fri, 17 Jul 2026 12:53:48 +0000
Message-Id: <20260717-c10-031-public-bpf-next-v2-b4-v2-2-54b555443a7c@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:ygQGZQDntRTdJVpqswkQAA--.23244S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXry3AFWrZr4kCr1kGw1kGrg_yoW5Jw17p3
	y0gas0yayrJry7CrWfCa4DuF1ruFsaqr4Uua1j9ryxZrsxXr97tr4IkF15JF13WrZ8ZFWF
	gr42qa1fCF4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5JwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9AwsUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a verifier_arena case that fills a two-page arena, calls
bpf_arena_free_pages() with a scalar address one page below the arena
base, and then verifies that another allocation is still rejected.

Before the runtime guard, the invalid free can repopulate the free
tree with an out-of-domain offset and the final allocation succeeds.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/progs/verifier_arena.c | 40 +++++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index df0e22d1a29b1..b241bbcf54a8a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -12,15 +12,17 @@
 
 #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
 
+#ifdef __TARGET_ARCH_arm64
+#define ARENA_VM_START ((1ull << 32) | (~0u - __PAGE_SIZE * 2 + 1))
+#else
+#define ARENA_VM_START ((1ull << 44) | (~0u - __PAGE_SIZE * 2 + 1))
+#endif
+
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
 	__uint(map_flags, BPF_F_MMAPABLE);
 	__uint(max_entries, 2); /* arena of two pages close to 32-bit boundary*/
-#ifdef __TARGET_ARCH_arm64
-        __ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * 2 + 1)); /* start of mmap() region */
-#else
-        __ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * 2 + 1)); /* start of mmap() region */
-#endif
+	__ulong(map_extra, ARENA_VM_START); /* start of mmap() region */
 } arena SEC(".maps");
 
 SEC("socket")
@@ -93,6 +95,34 @@ int basic_alloc1(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
+int free_scalar_below_arena(void *ctx)
+{
+	void __arena *page1, *page2, *page3;
+	__u64 bad_addr = ARENA_VM_START - __PAGE_SIZE;
+
+	page1 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page1)
+		return 1;
+
+	page2 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page2)
+		return 2;
+
+	page3 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (page3)
+		return 3;
+
+	bpf_arena_free_pages(&arena, (void __arena *)bad_addr, 1);
+
+	page3 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (page3)
+		return 4;
+
+	return 0;
+}
+
 SEC("socket")
 __success __retval(0)
 int basic_alloc2_nosleep(void *ctx)
-- 
2.34.1

