Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A213CC7EA
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316317; cv=none; b=m7wKsGaGn/Q3QQIz8aIMkrdkeiW08ez/10DrBywvifjJk/y0/Fq/6HBXYWEpLXtxvMh5UzZwEdN9r1mW18O9QROnEJwXQkAc9b3lkKF+kT+77HHwSFg4NoPfEIRbDbg/5z6YCbNolEwgaskNz57iUJfeliWLNPDPMscU9c2a4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316317; c=relaxed/simple;
	bh=ACgMkvfmEc1Du6kXBxMo7LXKK2kfropLYMu+Tc5Qzy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx3DCP0JIvRvarHHPMJh7QCcDwkCAFTELg9XIa6d6H4EE9/9aoMc2/oTlFI4HH1mizCcows4UYs0D+t9N0nXtexXyGK9AHO6hBbcciQxKRQoJvwwI9ln2Pfabc42NvXeJRs31OBVh4N5CDbhfHH0ayzK47ON8BO/h5bkelE8S1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VHN57J/v; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VHN57J/v"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782316312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ze9qZ3a8YugA2kBDoxW5t8vr06YezliA5Bf3Xo9qEE=;
	b=VHN57J/vF0VmW5RHyeHhuJiO5BGWUpAU2ieMfTf5sy0M1HUI5UaaX6GTmCdtyligsu7l4t
	jIPpDhC+CkErSciwCz0LFFkrF3wUpsOdmEgBoNBDtt81VuZ+az24OYtcWfNtOoR4dIFhF2
	yp7p7SG0Yg076096GI53CjLtl83P5Vw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf 2/2] selftests/bpf: Verify no non-zeroed kernel heap memory exposure
Date: Wed, 24 Jun 2026 23:51:15 +0800
Message-ID: <20260624155115.85196-3-leon.hwang@linux.dev>
In-Reply-To: <20260624155115.85196-1-leon.hwang@linux.dev>
References: <20260624155115.85196-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When lookup element from those per-CPU maps, which have special field
in their values and their value size is not equal to roundup(value_sz, 8),
the padding size of temporary non-zeroed kernel heap memory allocated by
kvmalloc should not be exposed to user space.

Without the fix:

test_map_uninit_mem_exposure:FAIL:zeroed tail bytes unexpected memory mismatch
actual:
	2B 2B 2B 2B
expected:
	00 00 00 00

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/test_map_uninit.c          | 68 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 12 ++++
 2 files changed, 80 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_map_uninit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_map_uninit.c b/tools/testing/selftests/bpf/prog_tests/test_map_uninit.c
new file mode 100644
index 000000000000..d0ba2ca587b0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_map_uninit.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "map_kptr.skel.h"
+
+void test_map_uninit_mem_exposure(void)
+{
+	size_t value_sz, slot_sz, lookup_sz, tail_sz;
+	int err, key, nr_cpus, cpu, map_fd;
+	__u8 *value = NULL, *zero = NULL;
+	struct bpf_program *prog;
+	struct map_kptr *skel;
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	skel = map_kptr__open();
+	if (!ASSERT_OK_PTR(skel, "map_kptr__open"))
+		return;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		err = bpf_program__set_autoload(prog, false);
+		if (!ASSERT_OK(err, "bpf_program__set_autoload"))
+			goto out;
+	}
+
+	err = map_kptr__load(skel);
+	if (!ASSERT_OK(err, "map_kptr__load"))
+		goto out;
+
+	value_sz = bpf_map__value_size((skel)->maps.pcpu_array);
+	slot_sz = roundup(value_sz, 8);
+	tail_sz = slot_sz - value_sz;
+	if (!ASSERT_NEQ(tail_sz, 0, "tail_sz"))
+		goto out;
+
+	lookup_sz = slot_sz * nr_cpus;
+	map_fd = bpf_map__fd(skel->maps.pcpu_array);
+
+	value = malloc(lookup_sz);
+	zero = calloc(1, tail_sz);
+	if (!ASSERT_OK_PTR(value, "malloc value") || !ASSERT_OK_PTR(zero, "calloc zero"))
+		goto out;
+
+	key = 0;
+	memset(value, 0x2B, lookup_sz);
+	err = bpf_map_update_elem(map_fd, &key, value, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	memset(value, 0xFF, lookup_sz);
+	err = bpf_map_lookup_elem(map_fd, &key, value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		__u8 *tail = value + cpu * slot_sz + value_sz;
+
+		if (!ASSERT_MEMEQ(tail, zero, tail_sz, "zeroed tail bytes"))
+			goto out;
+	}
+
+out:
+	free(zero);
+	free(value);
+	map_kptr__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index 3fbefc568e0a..0d87c97dac99 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -4,6 +4,18 @@
 #include <bpf/bpf_helpers.h>
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+struct map_uninit_value {
+	struct prog_test_ref_kfunc __kptr_untrusted *unref_ptr;
+	__u32 data;
+} __attribute__((packed));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, int);
+	__type(value, struct map_uninit_value);
+	__uint(max_entries, 1);
+} pcpu_array SEC(".maps");
+
 struct map_value {
 	struct prog_test_ref_kfunc __kptr_untrusted *unref_ptr;
 	struct prog_test_ref_kfunc __kptr *ref_ptr;
-- 
2.54.0

