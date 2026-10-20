Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504168;
	b=vM/Q6htHBOb6AhKCSbgBhQ3tdprpZskhTJxnw+RBL5apSg7AxY+UbTracz1uvUQna0CZ
	 DRVyYbwt6NsPfAMsN4XRz9Kg/E5B5B9jNkQ8DuKUHjg69zdcS2m+oR5CSjfH+3SFwvDh/
	 YPPEwDHA8XeUbQKMKwwS0yx1h0MaAlB42VaLSPbHaHYD7Lt2wsbuifahjEuFRVCvYY8Cx
	 JeMKCVfExs7p2THR/QNQOA1fS49aIJPxkG72uX8jBo8Ks98fOVSqqAWopqFdFnIvP0GKp
	 Lyt5QLcw4T3FioQJktXgwEurAUFOJBdrGvDrdTEPMdqR6XHPhWCCA2W2klPic18vdvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504168;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=25etgdT/4v7Oc6NtYHj8/jYPhw3pNBo8MFbsJaOWIHw=;
	b=oKnwZsl5DM6f0DaIBIaYACBNM/UVuVP63HYC5snoKSvTan6UWY3Ws2TXJpPh+Xf0VB65
	 Fbk6WuHUuCuy8w19IJ9fwD6t7ZZUvVrgp+hpS0JQbUONvOPPZT+yJnHfvAm9PmMLoeSNn
	 F4o7wKfP3Hcx2IONxHx9V+Augk4l/9bIM6gpa5Hc8FCr+5OT6vNSJFaYvcFUQZWVjVjBJ
	 27vHeOz2nzhFuaSmg67AR8Lmw9/8Pb+bYiT+vbmGJ22ZRyLxnz1rqUBfJzuND01VrKsn6
	 FXfyUh/deKGEuhQbaHF987DRn5myH5dLxCLGIeby5DTO7ngjFC7fnOWvJZMD1jUbUWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575160A260A;
	Tue, 20 Oct 2026 13:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0575160A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn54SpzYQtwY;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B11E64056F;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S16;
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
Subject: [PATCH bpf-next 14/16] selftests/bpf: Add test for arena percpu-only object
Date: Tue, 20 Oct 2026 13:22:59 +0000
Message-ID: <f7f725d0057be520ec5fb417f3f7d3a1e2c765fe.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S16
X-Coremail-Antispam: 1UD129KBjvJXoWxKFy3WF18Kr15Aw43Zr4kCrg_yoWxArWUp3
	W8KFyYkr47JrnrCws5ua13WFWYgrs5ZFyxG34fWw1rAr17ZFn7Xr4Ik3W5JF13GrZ3Xr1Y
	kFySgFWagFW7Xr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add the __arena_percpu macro to bpf_arena_common.h and a test object
with only a arena percpu variable.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../bpf/libarena/include/bpf_arena_common.h   |   2 +
 .../selftests/bpf/prog_tests/arena_percpu.c   | 148 ++++++++++++++++++
 .../selftests/bpf/progs/arena_percpu_only.c   |  21 +++
 3 files changed, 171 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_percpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_percpu_only.c

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
index 82aafe879fae..7cdee141764e 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
@@ -35,11 +35,13 @@
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
 #define __arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
 #define __arena_global __attribute__((address_space(1)))
+#define __arena_percpu __attribute__((address_space(1))) __attribute__((section(".arena.percpu")))
 #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
 #define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
 #else
 #define __arena __attribute__((btf_type_tag("arena")))
 #define __arena_global SEC(".addr_space.1")
+#define __arena_percpu SEC(".arena.percpu")
 #define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
 #define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_percpu.c b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
new file mode 100644
index 000000000000..27d4721c7ae9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_percpu.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Huawei Technologies Inc. */
+#include <test_progs.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/mman.h>
+#include "bpf/libbpf_internal.h"
+#include "arena_percpu_only.skel.h"
+
+static cpu_set_t affinity_save;
+
+static int pin_to(int cpu)
+{
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+	return sched_setaffinity(0, sizeof(cpuset), &cpuset);
+}
+
+static int run_on_cpu(int cpu, struct bpf_program *prog, const char *name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	if (pin_to(cpu))
+		return -1;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+
+	if (!ASSERT_OK(err, name))
+		return -1;
+	if (!ASSERT_OK(opts.retval, name))
+		return -1;
+	return 0;
+}
+
+static int save_affinity(void)
+{
+	if (!ASSERT_OK(sched_getaffinity(0, sizeof(affinity_save), &affinity_save),
+		       "save_affinity"))
+		return -1;
+	return 0;
+}
+
+static void restore_affinity(void)
+{
+	sched_setaffinity(0, sizeof(affinity_save), &affinity_save);
+}
+
+static int parse_possible_cpus(bool **possible, int *nr_possible)
+{
+	if (!ASSERT_OK(parse_cpu_mask_file("/sys/devices/system/cpu/possible",
+					   possible, nr_possible),
+		       "parse_possible"))
+		return -1;
+	return 0;
+}
+
+/* check one cpu's copy of a per-cpu global */
+static void check_percpu_value(struct bpf_map *arena, void *var, int cpu,
+			       __u64 expected, const char *name)
+{
+	__u64 *p = bpf_map__arena_percpu_ptr(arena, var, cpu);
+
+	if (!ASSERT_OK_PTR(p, name))
+		return;
+	ASSERT_EQ(*p, expected, name);
+}
+
+static void test_arena_percpu_only(void)
+{
+	struct arena_percpu_only *skel;
+	struct bpf_map *arena;
+	bool *possible = NULL;
+	int possible_cpus, cpu, picked_cpu = -1, i, err;
+
+	if (save_affinity())
+		return;
+
+	skel = arena_percpu_only__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	if (parse_possible_cpus(&possible, &possible_cpus))
+		goto out;
+
+	/* size the arena for the per-cpu chunks and load the object */
+	if (!ASSERT_OK(bpf_map__set_max_entries(skel->maps.arena, possible_cpus),
+		       "set_max_entries"))
+		goto out;
+	if (!ASSERT_OK(arena_percpu_only__load(skel), "load"))
+		goto out;
+	arena = skel->maps.arena;
+
+	if (!ASSERT_OK_PTR(skel->arena_percpu, "arena_percpu"))
+		goto out;
+
+	/* every chunk starts as a copy of the initialized section */
+	for (cpu = 0; cpu < possible_cpus; cpu++) {
+		if (!possible[cpu])
+			continue;
+		check_percpu_value(arena, &skel->arena_percpu->counter, cpu,
+				   0x123456, "counter_init");
+	}
+
+	/* pick one cpu to pin */
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (CPU_ISSET(i, &affinity_save)) {
+			picked_cpu = i;
+			break;
+		}
+	}
+	if (!ASSERT_GE(picked_cpu, 0, "pick_cpu"))
+		goto out;
+
+	err = run_on_cpu(picked_cpu, skel->progs.arena_percpu_only_write, "run on cpu");
+	if (err < 0)
+		goto out;
+
+	/* only the cpu the program ran on got written */
+	for (cpu = 0; cpu < possible_cpus; cpu++) {
+		if (!possible[cpu])
+			continue;
+
+		if (cpu == picked_cpu)
+			check_percpu_value(arena, &skel->arena_percpu->counter,
+					   cpu, picked_cpu, "counter_written");
+		else
+			check_percpu_value(arena, &skel->arena_percpu->counter,
+					   cpu, 0x123456, "counter_untouched");
+	}
+
+out:
+	free(possible);
+	arena_percpu_only__destroy(skel);
+	restore_affinity();
+}
+
+void test_arena_percpu(void)
+{
+	if (!feat_supported(NULL, FEAT_ARENA_PERCPU_DATA)) {
+		test__skip();
+		return;
+	}
+	if (test__start_subtest("percpu_only"))
+		test_arena_percpu_only();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_percpu_only.c b/tools/testing/selftests/bpf/progs/arena_percpu_only.c
new file mode 100644
index 000000000000..35e4ff983e65
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_percpu_only.c
@@ -0,0 +1,21 @@
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
+__u64 __arena_percpu counter = 0x123456;
+
+SEC("syscall")
+int arena_percpu_only_write(void *ctx)
+{
+	counter = bpf_get_smp_processor_id();
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.47.3

