Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504165;
	b=Yo60jasz1/AcdC12dGibR3UBfpfrIBNMx5s38gk3Iejg+nZI4Nf0K6g2owVsvx26v3xK
	 Y47BFXsIa89YcBPzGR5FBSzcprbrjZx7g77g/CfctKMQzlVncJszjYqT9Any6vkoq1JK2
	 lfaOzKR7gSGMXuFDH7Hm+ot26v79Mpluo4N30GddSKU78E/V8MN5dZoBvtSN2P9IMYXPt
	 rBi57TtlR+EjHLmO2JBXG1XrsZOSbUKEb0tSU1Zgeb2iWqoGAXnMdfXPnvUFOpKNDeDgt
	 o4sMCJ3E8EXn2dDiKrNiCzrRf6Gdz+vawaf3x7e8N+BGnuuwQiJmzSBKONH54sEqDPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504165;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=LCC/vg1ecR3WvSMMw3LKgHbNwLJI6QBkt/+ylsV9MQY=;
	b=X/FrfH40Q3NqznzkhCSmWRxZ9jGHol5NWPCbHuMSGB0BOsT+HcgNAyeyfZa23vaHx5QM
	 0z8cINz5L49T7AGespjFVKQCE2wN6IQm0cCRmtqa/rl56s+DDW/3TKwOVl2fDxP7eiP8n
	 3UDg32wEx0+d5DoFA0gqQRZlFS+EPziVART3obVCYfmayOuP5NOhuFiXxWGKsiF1h2ltq
	 GTWS3UjlJ1/Clq0jJKa5/0FyvJoEqX9HV0WpGhbUg6Vc3Hk3pxmnCb4aKoTCllJNwZTdk
	 knvRZ3e48XCQWXtOFvsGj+szlUPIOouyXmPGAIreO4FfHJNxBYmaeEm1nFSllPYnGpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442A606B648;
	Tue, 20 Oct 2026 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B442A606B648
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKd5ttrzKHMZk;
	Tue, 20 Oct 2026 21:49:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id BD6C6409D1;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S17;
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
Subject: [PATCH bpf-next 15/16] selftests/bpf: Add test for mixed arena percpu object
Date: Tue, 20 Oct 2026 13:23:00 +0000
Message-ID: <a36e6a008493b367af5d9c338cf707fadfc8a632.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S17
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW5uF18ArykXr47GFy7Awb_yoW7Xw48pa
	4xGr15Kr4fZrWqk3s5u3WUGrWFgr4rZry8Jwn0gr1rAr13ZrnrXFWIk3W5AF15KrZagr1Y
	ka4SqFy2ga9rJrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r
	43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1KFAJUU
	UUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add a test object that mixes percpu variables and a regular global in
one arena.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/arena_percpu.c   | 96 +++++++++++++++++++
 .../selftests/bpf/progs/arena_percpu_mixed.c  | 29 ++++++
 2 files changed, 125 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_percpu_mixed.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
index 27d4721c7ae9..b450be5f2b36 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
@@ -6,6 +6,7 @@
 #include <sys/mman.h>
 #include "bpf/libbpf_internal.h"
 #include "arena_percpu_only.skel.h"
+#include "arena_percpu_mixed.skel.h"
 
 static cpu_set_t affinity_save;
 
@@ -137,6 +138,99 @@ static void test_arena_percpu_only(void)
 	restore_affinity();
 }
 
+static void test_arena_percpu_mixed(void)
+{
+	struct arena_percpu_mixed *skel;
+	struct bpf_map *arena, *bss_map;
+	bool *possible = NULL, *online = NULL, *written = NULL;
+	int possible_cpus, online_cpus, nr_written = 0, cpu, err;
+
+	if (save_affinity())
+		return;
+
+	skel = arena_percpu_mixed__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	if (parse_possible_cpus(&possible, &possible_cpus))
+		goto out;
+
+	/* size the arena for the per-cpu chunks and load the object */
+	if (!ASSERT_OK(bpf_map__set_max_entries(skel->maps.arena, possible_cpus + 16),
+		       "set_max_entries"))
+		goto out;
+	if (!ASSERT_OK(arena_percpu_mixed__load(skel), "load"))
+		goto out;
+	arena = skel->maps.arena;
+
+	for (cpu = 0; cpu < possible_cpus; cpu++) {
+		if (!possible[cpu])
+			continue;
+
+		check_percpu_value(arena, &skel->arena_percpu->data1, cpu,
+				   0x123456789, "data1_init");
+		check_percpu_value(arena, &skel->arena_percpu->data2, cpu,
+				   0x987654321, "data2_init");
+	}
+
+	if (!ASSERT_OK(parse_cpu_mask_file("/sys/devices/system/cpu/online",
+					   &online, &online_cpus),
+		       "parse_online"))
+		goto out;
+
+	written = calloc(online_cpus, sizeof(*written));
+	if (!ASSERT_OK_PTR(written, "written_alloc"))
+		goto out;
+
+	for (cpu = 0; cpu < online_cpus; cpu++) {
+		if (!online[cpu] || cpu >= CPU_SETSIZE || !CPU_ISSET(cpu, &affinity_save))
+			continue;
+
+		err = run_on_cpu(cpu, skel->progs.arena_percpu_mixed_write, "write");
+		if (err < 0)
+			goto out;
+		if (err > 0)
+			continue;
+		written[cpu] = true;
+		nr_written++;
+	}
+	if (!ASSERT_GE(nr_written, 1, "cpus_exercised"))
+		goto out;
+
+	/* check every written chunk from user space */
+	for (cpu = 0; cpu < online_cpus; cpu++) {
+		if (!written[cpu])
+			continue;
+
+		check_percpu_value(arena, &skel->arena_percpu->data1, cpu,
+				   cpu, "data1_written");
+		check_percpu_value(arena, &skel->arena_percpu->data2, cpu,
+				   cpu << 2, "data2_written");
+	}
+
+	/* the __arena global should not be touched */
+	ASSERT_EQ(skel->arena->arena_global, 0x5a5ba5a5c0dec0de, "arena_global_intact");
+
+	/* api error paths: cpu out of range, pointer outside cpu 0's chunk */
+	ASSERT_ERR_PTR(bpf_map__arena_percpu_ptr(arena, &skel->arena_percpu->data1,
+						 possible_cpus), "api_cpu_range");
+	ASSERT_ERR_PTR(bpf_map__arena_percpu_ptr(arena, possible, 0),
+		       "api_not_in_chunk");
+
+	/* a non-ARENA map has no per-cpu chunks to index */
+	bss_map = bpf_object__find_map_by_name(skel->obj, ".bss");
+	if (ASSERT_OK_PTR(bss_map, "bss_map"))
+		ASSERT_EQ(libbpf_get_error(bpf_map__arena_percpu_ptr(bss_map, &cpu, 0)),
+			  -EINVAL, "api_not_arena");
+
+out:
+	free(written);
+	free(online);
+	free(possible);
+	arena_percpu_mixed__destroy(skel);
+	restore_affinity();
+}
+
 void test_arena_percpu(void)
 {
 	if (!feat_supported(NULL, FEAT_ARENA_PERCPU_DATA)) {
@@ -145,4 +239,6 @@ void test_arena_percpu(void)
 	}
 	if (test__start_subtest("percpu_only"))
 		test_arena_percpu_only();
+	if (test__start_subtest("percpu_mixed"))
+		test_arena_percpu_mixed();
 }
diff --git a/tools/testing/selftests/bpf/progs/arena_percpu_mixed.c b/tools/testing/selftests/bpf/progs/arena_percpu_mixed.c
new file mode 100644
index 000000000000..9bc199e86031
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_percpu_mixed.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Huawei Technologies Inc. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+} arena SEC(".maps");
+
+__u64 __arena_percpu data1 = 0x123456789;
+__u64 __arena_percpu data2 = 0x987654321;
+
+__u64 __arena_global arena_global = 0x5a5ba5a5c0dec0de;
+
+int bss_var;
+
+SEC("syscall")
+int arena_percpu_mixed_write(void *ctx)
+{
+	u32 cpu = bpf_get_smp_processor_id();
+
+	data1 = cpu;
+	data2 = cpu << 2;
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.47.3

