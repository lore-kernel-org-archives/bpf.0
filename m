Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA3D3ED13E;
	Tue, 30 Jun 2026 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814390; cv=none; b=M8o3edt7zecUFrWrfStn2l78QXOe/MlryX6tzGbcI3OUFbEUZUewH7rl36dhHyWSVjGSXkiSEskNYQiLWrrJ2oRD63SSKpxfx51ooFGJTj3L8l0TZ3KVI3FqvfMfBy3VTjQqkFMMWSrknCO+OxVeG9qKgVsnctebzWgSco/TaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814390; c=relaxed/simple;
	bh=zc1xQmsmBHsJi4ZFND+KX9b4FpFMT+MbuJwV7MHnugY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Upq1nnLuo3nedX+T/I6v79nSsCCamPAIYJBONxHkj43acdbKIBSwXK3ZsbP4jOCOiyOTToNlYLMl9TA+6JW8CsuBXqjBUXrktT5X8hq4STVVqAjelUzrZ3zlwvT07GFOv5Ie05gVUK+NLbfnbU+s5aJ1Lmpd/GOUX8dFVsSDWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ObWX+cqS; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ObWX+cqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=oL/C1uCD3DxHjdBVwzs2ZTvbPEkHoXdCkC
	gsaeoqEdw=; b=ObWX+cqS/GunePXwqRRqbnsgtKwIRZ2B4kX3OS+CT85IWnHBPf
	qVP6ATPe9sOFAmraRtDFZNnCS3SJDw//6srJaXHrn7Hk2fER7T94vNUywCd2G7lZ
	NuKuAPdhr9ZoYfgzHBqjcclswl8qo+ODXMmCkXcsPfSDasYeE8cldAc5w=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQD3z5eGlkNqxZukAg--.37667S4;
	Tue, 30 Jun 2026 18:12:49 +0800 (CST)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover scalar arena frees below the base
Date: Tue, 30 Jun 2026 10:12:20 +0000
Message-Id: <e4226ac143315bb584dfedc79693ccf813ac56b0.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782813442.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQD3z5eGlkNqxZukAg--.37667S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47uFWfXryrJr1fXr1rtFb_yoW5JF4xpa
	yIg3s0yayrJry7urWfCa4DuF1ruanavr4Uua1j934IvrsxXr97tr4IkF15JF13WrZ8ZFWF
	gr42qa1fCF4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOo7NUUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a verifier_arena case that fills a two-page arena, calls
bpf_arena_free_pages() with a scalar address one page below the arena
base, and then verifies that another allocation is still rejected.

Before the runtime guard, the invalid free can repopulate the free
tree with an out-of-domain offset and the final allocation succeeds.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/verifier_arena.c      | 41 ++++++++++++++++---
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 62e282f4448aa..b4bd134646607 100644
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
@@ -93,6 +95,35 @@ int basic_alloc1(void *ctx)
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
+	asm volatile("" : "+r"(bad_addr));
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

