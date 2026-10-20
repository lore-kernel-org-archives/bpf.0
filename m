Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504168;
	b=arKKkiBAGuj5MIW6F3NvGqhWZe1z1PahLe/88IAMlNDx1FTVxWNb6ePk9tYKKeOAqYeA
	 cqHgGKPVj1IN4pjPI8zxEYIB3N/o9XdcI5C98VtGm6/MlVVkZyMqYj5Lc4iPFMqovctBw
	 L4jIUCRPwrY29tm3qffmGNyEVFT6TDbyy0x55lTyESoqJmeXnF6JbhX40VbStIpr/+Yv2
	 0ye91N85yX/aL8/JLy50xFE1/3zu7jhMeAY315sl0m75VAj+4GqKdWvuKY6KfNBBIex6r
	 WqUJB6bCqTK6KXCeD10l19lOLhQoFQTU7q27fkMv9xxgDlAjQ0HD7GE7oVxqeIxSGmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504168;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=rEuqmVe0UdrPOEYTsBTVYnI8Ull2mdKoKm8v1xeXXKs=;
	b=0XLn2fbyADEPTBcfrSVsYNRFABtqZUeLh+O8blUnBf4ZdsnO+yohpbr8IKjJcv8j8LB/
	 ihP3xi5FnDkL5qP8NfU7ITSsJSUVGxAiMN5gUtJ1YIIUrHut2F79+3Ex7pNwOycl3I1Vs
	 XIQ5RnEGHRF5FxuBGWM4t0YAMRVcLCvY4VRSEQ9VEQRTUucjntf9BXOeIgz+L2hiesY3l
	 GCWF8KtfLh5zGCqIm5KUlLduTGFWZNVhK4S1nPPVTLmjlioGe6r8bgaD8LvoYKEdOhvaQ
	 Vx+PClR2emU5K1td84aY8cqJzG1KQAMydtJH8vauDx2O34XhEl5wi9J2rC2K8rxk4hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=none smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEF60A2609;
	Tue, 20 Oct 2026 13:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02EEF60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn5jy8zYQtwj;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C5B14409D5;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S18;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 16/16] selftests/bpf: Add test for arena percpu bounds
Date: Tue, 20 Oct 2026 13:23:01 +0000
Message-ID: <ad35a4e7b9ff044a63d7903ae6509c68ea05d6d5.1792503001.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S18
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4ktryftr43Ary8tw15twb_yoW7XF4rp3
	Z7tryqkr4UXFZI9ws8K3WUur45uFs8XrW8KwsxW34rArnIqr13XrW0kayayF17WrZ5Xw4S
	9343AFn7XFy2qFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aLvJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add a raw insn test. It loads a hand built arena percpu pseudo
instruction against an arena map with a one page chunk to test in
range accesses and out of range failures.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/arena_percpu.c   | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
index b450be5f2b36..1f9a22cc9730 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
@@ -8,6 +8,7 @@
 #include "arena_percpu_only.skel.h"
 #include "arena_percpu_mixed.skel.h"
 
+static char log_buf[16384];
 static cpu_set_t affinity_save;
 
 static int pin_to(int cpu)
@@ -231,6 +232,120 @@ static void test_arena_percpu_mixed(void)
 	restore_affinity();
 }
 
+/* check out of range pseudo instructions and accesses */
+static void test_arena_percpu_percpu_bounds(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_ARENA_PERCPU, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	bool *possible = NULL;
+	__u32 page_sz = getpagesize();
+	__u32 bad_offs[2];
+	char expected[128];
+	void *arena = MAP_FAILED;
+	int possible_cpus, nr_pages, map_fd, prog_fd, i;
+
+	if (parse_possible_cpus(&possible, &possible_cpus))
+		return;
+
+	/* a one-page per-cpu chunk at page 1 of the arena */
+	map_opts.map_flags = BPF_F_MMAPABLE;
+	map_opts.arena_percpu_chunk_off = page_sz;
+	map_opts.arena_percpu_chunk_sz = page_sz;
+
+	prog_opts.log_buf = log_buf;
+	prog_opts.log_size = sizeof(log_buf);
+	prog_opts.log_level = 1;
+
+	/* one page per possible cpu plus one for the chunk offset */
+	nr_pages = possible_cpus + 1;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_percpu_ref",
+				0, 0, nr_pages, &map_opts);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		goto out;
+
+	arena = mmap(NULL, nr_pages * page_sz, PROT_READ | PROT_WRITE,
+		     MAP_SHARED, map_fd, 0);
+	if (!ASSERT_NEQ(arena, MAP_FAILED, "arena_mmap"))
+		goto out;
+
+	insns[0].imm = map_fd;
+
+	/* a reference at the start of the chunk loads */
+	insns[1].imm = page_sz;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
+				"arena_percpu_ref", "GPL", insns,
+				ARRAY_SIZE(insns), &prog_opts);
+	if (!ASSERT_GE(prog_fd, 0, "in_range_load"))
+		goto out;
+	close(prog_fd);
+
+	/* the first u64 below the chunk and one past its end are rejected */
+	bad_offs[0] = page_sz - 8;
+	bad_offs[1] = page_sz + page_sz;
+
+	for (i = 0; i < ARRAY_SIZE(bad_offs); i++) {
+		insns[1].imm = bad_offs[i];
+		prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
+					"arena_percpu_ref", "GPL", insns,
+					ARRAY_SIZE(insns), &prog_opts);
+		if (!ASSERT_LT(prog_fd, 0, "out_of_range_load"))
+			close(prog_fd);
+		snprintf(expected, sizeof(expected),
+			 "per-cpu arena reference at offset %u "
+			 "outside cpu 0's chunk", bad_offs[i]);
+		ASSERT_HAS_SUBSTR(log_buf, expected, "out_of_range_log");
+	}
+
+	/* the last u64 of the chunk is in range and loads */
+	insns[1].imm = page_sz + page_sz - 8;
+	insns[2].off = 0;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
+				"arena_percpu_ref", "GPL", insns,
+				ARRAY_SIZE(insns), &prog_opts);
+	if (!ASSERT_GE(prog_fd, 0, "last_u64_load"))
+		goto out;
+	close(prog_fd);
+
+	/* one u64 past the chunk end is rejected */
+	insns[2].off = 8;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
+				"arena_percpu_ref", "GPL", insns,
+				ARRAY_SIZE(insns), &prog_opts);
+	if (!ASSERT_LT(prog_fd, 0, "out_of_range_access"))
+		close(prog_fd);
+	snprintf(expected, sizeof(expected),
+		 "per-cpu arena access at offset %d size 8 "
+		 "outside cpu 0's chunk", (int)page_sz);
+	ASSERT_HAS_SUBSTR(log_buf, expected, "out_of_range_access_log");
+
+	/* an access below the chunk start is rejected */
+	insns[1].imm = page_sz;
+	insns[2].off = -8;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
+				"arena_percpu_ref", "GPL", insns,
+				ARRAY_SIZE(insns), &prog_opts);
+	if (!ASSERT_LT(prog_fd, 0, "below_chunk_access"))
+		close(prog_fd);
+	snprintf(expected, sizeof(expected),
+		 "per-cpu arena access at offset -8 size 8 "
+		 "outside cpu 0's chunk");
+	ASSERT_HAS_SUBSTR(log_buf, expected, "below_chunk_access_log");
+
+out:
+	if (arena != MAP_FAILED)
+		munmap(arena, nr_pages * page_sz);
+	if (map_fd >= 0)
+		close(map_fd);
+	free(possible);
+}
+
 void test_arena_percpu(void)
 {
 	if (!feat_supported(NULL, FEAT_ARENA_PERCPU_DATA)) {
@@ -241,4 +356,6 @@ void test_arena_percpu(void)
 		test_arena_percpu_only();
 	if (test__start_subtest("percpu_mixed"))
 		test_arena_percpu_mixed();
+	if (test__start_subtest("percpu_bounds"))
+		test_arena_percpu_percpu_bounds();
 }
-- 
2.47.3

