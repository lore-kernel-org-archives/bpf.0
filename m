Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C993F4852;
	Mon,  6 Jul 2026 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353155; cv=none; b=HC4pHcEfoURBw1LcM+aDgNMfNCB3wPCHxHMKxFjtkH220iWz/NfbeXOKNlDJk2uQ1pYZhbDHtHT6EUjTSP2JjxTShZuBs7osPSpkImAyMKdUwJm1Tsm0/kLUs+8Ljmz+ZbuA5YBauMfmkVuxbe9rrP5Gpq6o1NoDndYcLeL1Xgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353155; c=relaxed/simple;
	bh=NahC9lTNHyBH9udO/CJg8gfBgvCFk9f4bc3Gjzg+0v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jGr/p2LeCasiaX0hhnulBXrBsdGl76UxScbLjBtr/1KzLGibcSujUwLmk/dqqbCLj0/yzK8XWVVrpr9xB+5cB7q/WgOuRhD/30Xx9B77/MNF16tGOmyllyWQa++obSj59Xapms0iFsA1fxMeVVXMoPWxI05Z/IqdlJbQ1x8m8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=lkARGJ6n; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="lkARGJ6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=Xst/KaapphKvDe7MM8HqlJhNeVz8eTp
	rqdK7gceHzAA=; b=lkARGJ6n5RT27hsdA4K/tt8bKVJM1XaytYOWJj1t6WEfwVE
	E1/rD37v3LILLH0mG1ir5DbfDHYrHdQBNFXifHMsOrpbtyCjmUjBNuBi+gpCVqGL
	JzHLRuCyhY61kqHLldBffl41mZEpLj46t8K7qdZcS3zR+pz6OKUJ36PRpVxE=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQC3bb0sz0tqPl8AAw--.17381S4;
	Mon, 06 Jul 2026 23:52:12 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Mon, 06 Jul 2026 23:52:11 +0800
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover out-of-range arena free
 addresses
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-f01-31-arena-free-bpf-next-v1-2-3ad6e7384285@mails.tsinghua.edu.cn>
References: <20260706-f01-31-arena-free-bpf-next-v1-0-3ad6e7384285@mails.tsinghua.edu.cn>
In-Reply-To: <20260706-f01-31-arena-free-bpf-next-v1-0-3ad6e7384285@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783353134; l=1951;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=NahC9lTNHyBH9udO/CJg8gfBgvCFk9f4bc3Gjzg+0v8=;
 b=NmwEGPWF/sspU3LQThZ5+Upw9YuGafkx4Q/LhubY0HoKjW3QmuuW2cfIUuOMheBsWXIYHFkX9
 CyypD9iGZp5AgQc0w7BKPbtUlTs25ybNM+Lgb5YR1xyC257GZOyNsvD
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQC3bb0sz0tqPl8AAw--.17381S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1kCr45KrWxGw45CFyDWrg_yoW8ZF1xpa
	y8KasIy3yrJr17Cr4fAFyDua4rursavr4UGF48tr97ZF1fJrZ3tr4Ik3WUWr1Ykrs5u39I
	vF4jqa10kFs8Z3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxE
	wVAFwVW5WwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbPxhJUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEAA2pLXR+fowAAsc

Add a verifier selftest that fills a two-page arena, frees the page below
the arena start through a scalar value, and checks that a third allocation
is still unavailable.

Without the arena free range check, the out-of-range free can be inserted
into the free range tree and then allocated again, so the test returns 3.
With the fix, the out-of-range free is ignored and the focused test passes.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/progs/verifier_arena.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index df0e22d1a29b..b21a8895804f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -11,6 +11,7 @@
 #include <bpf_arena_common.h>
 
 #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+#define ARENA_VM_START_L32 (~0u - __PAGE_SIZE * 2 + 1)
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
@@ -93,6 +94,31 @@ int basic_alloc1(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
+int free_pages_out_of_bounds(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	__u64 page1, page2, no_page;
+	__u64 below_start = (__u32)(ARENA_VM_START_L32 - __PAGE_SIZE);
+
+	page1 = (__u64)bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page1)
+		return 1;
+	page2 = (__u64)bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page2)
+		return 2;
+
+	asm volatile("" : "+r"(below_start));
+	bpf_arena_free_pages(&arena, (void __arena *)below_start, 1);
+
+	no_page = (__u64)bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (no_page)
+		return 3;
+#endif
+	return 0;
+}
+
 SEC("socket")
 __success __retval(0)
 int basic_alloc2_nosleep(void *ctx)

-- 
2.34.1

