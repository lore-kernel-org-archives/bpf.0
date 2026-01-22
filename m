Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B1492187
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097725; cv=none; b=tvJYqMH3mZclYypLJcEH02X6wZr4qDQbkg114c+81U8OPu4YnUlQvgdhw0e4EMJA09Liz3xdjO3rrZIR/xQeKxVDo0oHzKlhw2SnObHknCXlDDxmas78q9NJj/B3fhwwl65zKdDufD8q0zDp6Wq7ODeprfTXPNOfsC/LMu5paG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097725; c=relaxed/simple;
	bh=6LbNK3lhh/8fNDhfgC+naoT5OLhxQtTvRBd32bbAwqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/f/KDMP3kxFMmmXWYWx0HO67kEUJUd77kS/5RDsPsSAaCL6qYFSUmVw95GsUseTGXJNYTGDPh2gJqQLreYrnqcQwZPTcKYhfM9RFHwDw8whooiMOQW8FtfdneKkRWqhhhffmQcnNvWMShK8NwhpHDf94LjylwqVD6tZfjuYdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AR8+PnKf; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AR8+PnKf"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M9UKQA2028054
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=h0BBHYseSe/oI8+lJjDDd9VjmkGBPTqyj/7oLPXv+3Y=; b=AR8+PnKfcT0+
	C9uaKWcawtdDTag0LuhFCCYsONZ4Tfj3ZcuglBp475I+qDhQZv7l/1BBy+L81Pqg
	G+CxpispvOw7a/BiBof+t8AqTlZYaDXxFiv6Qrtd3R1T0Q+s/y94sIFehnq1a0/3
	e+4OTNZ+UBGfRjaRJzFik2Fiy3aUtdiVTWRV6E6EzD9rYmGYYYMKtWNRMvWx0coM
	Mf48o+cdfqi0MYv6FS2xrZqGIt6Ja8bQmqJeNJIulnQIlXGD4SVVrz1AaeN7f0m9
	2HACi9lhzr4tmais1suvaaheNL/0zrI49ZtStYeTTN8hS9xtPXgC2HDryPgfZ3e9
	12bXj6JpiA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4buhas2g0b-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:56 -0800 (PST)
Received: from twshared6524.02.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:53 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 6411A10A69EB4; Thu, 22 Jan 2026 08:01:46 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 08/13] selftest: bpf: Add bump allocator for libarena
Date: Thu, 22 Jan 2026 08:01:26 -0800
Message-ID: <20260122160131.2238331-9-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122160131.2238331-1-etsal@meta.com>
References: <20260122160131.2238331-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3lmUFg_ZOQNHYwPX9gvuM9Ix1ZHFDsif
X-Authority-Analysis: v=2.4 cv=c6qmgB9l c=1 sm=1 tr=0 ts=697249f4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=5F0bxZLHKh7b0-dXYm8A:9 a=I-g_0vLIplkVOQ0FYkeP:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 3lmUFg_ZOQNHYwPX9gvuM9Ix1ZHFDsif
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfXwle88PR0kcsQ
 MVOQBxmhsL775bXlW76Ixofvjkpb9dfmfBptavM+E/p56KuaklcoBiq57EsliRIq+ibiFc6O8jq
 9W1VQGvnmkQYxq4t3tAcOKrlBrHLk+E2/Ipbpvq+niEmaRa4GP4WaPfH4XsHZAexSDXi/cSZng3
 CF/FZlEwodRn4Aicrac2PpvFuZrj52Eleu+aon3U/JHZMq5GYS9Q+60FwZlW2RC/KXDj/3d7yfF
 +0G9xwtCzUauHckYlOKr7lrZcDC3vKGjW/LduFBVJQJaErUgQsNWXRFmxfx7Yf7YgMUqaxJX1Fu
 IlPIIBfRUPHEJKdBsdRDfVkzK9Dtv+htJqclBCliORs6U07Tyly3iWCGjVUKzLhvOM20g0vNiPG
 fAHKVVhbxUN/rwF0yP2Phkv3bq7mMkztjcH/wLmXqJeMFmnF7xTXUiECuuSMB1CNgtSd2ybs+h5
 m0tXG5ojqGMMKbGSJHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Add an arena-based bump allocator to the arenalib. The allocator
is aimed towards data allocated at program startup whose lifetime
is that of the BPF program. An example is CPU-related information
for sched-ext scheduler.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/bump.h     |  20 ++
 .../selftests/bpf/libarena/src/bump.bpf.c     | 212 ++++++++++++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/bump.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bump.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/bump.h b/tools/=
testing/selftests/bpf/libarena/include/bump.h
new file mode 100644
index 000000000000..e41a7045c56f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/bump.h
@@ -0,0 +1,20 @@
+#pragma once
+
+#ifdef __BPF__
+
+u64 bump_alloc_internal(size_t bytes, size_t alignment);
+#define bump_alloc(bytes, alignment) ((void __arena *)bump_alloc_interna=
l((bytes), (alignment)))
+int bump_init(size_t max_alloc_pages);
+int bump_destroy(void);
+int bump_memlimit(u64 lim_memusage);
+
+#endif /* __BPF__ */
+
+struct bump {
+	size_t max_contig_bytes;
+	void __arena *memory;
+	size_t off;
+	size_t lim_memusage;
+	size_t cur_memusage;
+};
+
diff --git a/tools/testing/selftests/bpf/libarena/src/bump.bpf.c b/tools/=
testing/selftests/bpf/libarena/src/bump.bpf.c
new file mode 100644
index 000000000000..7c0c5d9052ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/bump.bpf.c
@@ -0,0 +1,212 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024-2025 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2024-2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+/*
+ * Static allocation module used to allocate arena memory for
+ * whose lifetime is that of the BPF program. Data is rarely
+ * allocated, mostly at program init, and never freed. The
+ * memory returned by this code is typeless so it avoids us
+ * having to define an allocator for each type.
+ */
+
+#include <common.h>
+#include <asan.h>
+#include <bump.h>
+
+/* Maximum memory that can be allocated by the arena. */
+#define ARENA_MAX_MEMORY (1ULL << 20)
+
+private(STATIC_ALLOC_LOCK) struct bpf_spin_lock static_lock;
+
+private(STATIC_ALLOC) struct bump bump;
+
+const s8 STATIC_POISON_UNINIT =3D 0xff;
+
+struct bump_ll;
+struct bump_ll {
+	struct bump_ll __arena *next;
+};
+typedef struct bump_ll __arena bump_ll_t;
+
+__weak u64 bump_alloc_internal(size_t bytes, size_t alignment)
+{
+	void __arena *memory, *old;
+	bump_ll_t *oldll, *newll;
+	size_t	alloc_bytes;
+	size_t	alloc_pages;
+	void __arena *ptr;
+	size_t padding;
+	u64 addr;
+
+	/*=20
+	 * Allocated addresses must be aligned to the nearest granule,
+	 * and since we're stack allocating this implies that allocations
+	 * sizes are also aligned.
+	 */
+	alignment =3D round_up(alignment, 1 << ASAN_SHADOW_SHIFT);
+
+	bpf_spin_lock(&static_lock);
+
+	/* Round up the current offset. */
+	addr =3D (__u64)bump.memory + bump.off;
+
+	padding	=3D round_up(addr, alignment) - addr;
+	alloc_bytes =3D bytes + padding;
+
+	if (alloc_bytes > bump.max_contig_bytes) {
+		bpf_spin_unlock(&static_lock);
+		bpf_printk("invalid request %ld, max is %ld\n", alloc_bytes,
+			   bump.max_contig_bytes);
+		return (u64)NULL;
+	}
+
+	/*
+	 * The code assumes that the maximum static allocation
+	 * size is significantly larger than the typical allocation
+	 * size, so it does not attempt to alleviate memory
+	 * fragmentation.
+	 */
+	if (bump.off + alloc_bytes > bump.max_contig_bytes) {
+		if (bump.cur_memusage + bump.max_contig_bytes >
+		    bump.lim_memusage) {
+			bpf_spin_unlock(&static_lock);
+			bpf_printk("allocator memory limit exceeded");
+			return (u64)NULL;
+		}
+
+		old =3D bump.memory;
+
+		alloc_pages =3D bump.max_contig_bytes / __PAGE_SIZE;
+
+		memory =3D bpf_arena_alloc_pages(&arena, NULL, alloc_pages,
+						    NUMA_NO_NODE, 0);
+		if (!memory) {
+			bpf_spin_unlock(&static_lock);
+			bpf_printk("failed to allocate memory");
+			return (u64)NULL;
+		}
+
+		asan_poison(memory, STATIC_POISON_UNINIT,
+			    bump.max_contig_bytes);
+
+		/* Keep a list of allocated blocks to free on allocator destruction. *=
/
+		oldll =3D (bump_ll_t *)old;
+		newll =3D (bump_ll_t *)memory;
+		asan_unpoison(newll, sizeof(*newll));
+		newll->next =3D oldll;
+
+		/*
+		 * Switch to new memory block, reset offset,
+		 * and recalculate base address.
+		 */
+		bump.memory =3D memory;
+		bump.off =3D sizeof(*newll);
+		addr =3D (__u64)bump.memory + bump.off;
+
+		/*
+		 * We changed the base address. Recompute the padding.
+		 */
+		padding	=3D round_up(addr, alignment) - addr;
+		alloc_bytes =3D bytes + padding;
+
+		bump.cur_memusage +=3D bump.max_contig_bytes;
+	}
+
+	ptr =3D (void __arena *)(addr + padding);
+	asan_unpoison(ptr, bytes);
+
+	bump.off +=3D alloc_bytes;
+
+	bpf_spin_unlock(&static_lock);
+
+	return (u64)ptr;
+}
+
+__weak int bump_destroy(void)
+{
+	size_t alloc_pages =3D bump.max_contig_bytes / __PAGE_SIZE;
+	bump_ll_t *ll, *llnext;
+	int i;
+
+	for (ll =3D bump.memory; ll && can_loop; ll =3D llnext) {
+		llnext =3D ll->next;
+		asan_unpoison(ll, bump.max_contig_bytes);
+		bpf_arena_free_pages(&arena, ll, alloc_pages);
+	}
+
+	for (i =3D 0; i < sizeof(bump) && can_loop; i++) {
+		((u8 *)&bump)[i] =3D 0;
+	}
+
+	return 0;
+}
+
+__weak int bump_init(size_t alloc_pages)
+{
+	size_t max_bytes =3D alloc_pages * __PAGE_SIZE;
+	void __arena *memory;
+	bump_ll_t *ll;
+	int ret;
+
+	memory =3D bpf_arena_alloc_pages(&arena, NULL, alloc_pages, NUMA_NO_NOD=
E,
+				       0);
+	if (!memory) {
+		bpf_printk("Failed to allocate %d pages", alloc_pages);
+		return -ENOMEM;
+	}
+
+	ret =3D asan_poison(memory, STATIC_POISON_UNINIT, max_bytes);
+	if (ret)
+		bpf_printk("Error %d: by poisoning", ret);
+
+	ret =3D asan_unpoison(memory, sizeof(*ll));
+	if (ret)
+		bpf_printk("Error %d: by poisoning", ret);
+
+	ll =3D (bump_ll_t *)memory;
+	ll->next =3D NULL;
+
+	/* We reserve sizeof(*ll) for the embedded linked list. */
+	bump =3D (struct bump){
+		.max_contig_bytes =3D max_bytes,
+		.off =3D sizeof(*ll),
+		.memory	=3D memory,
+		.lim_memusage =3D ARENA_MAX_MEMORY,
+		.cur_memusage =3D max_bytes,
+	};
+
+	return 0;
+}
+
+__weak int bump_memlimit(u64 lim_memusage)
+{
+	bpf_spin_lock(&static_lock);
+
+	if (lim_memusage > ARENA_MAX_MEMORY)
+		goto error;
+
+	/* We always allocate at a page granularity. */
+	if (lim_memusage % __PAGE_SIZE)
+		goto error;
+
+	/* Have we already overshot the limit? */
+	if (lim_memusage < bump.cur_memusage)
+		goto error;
+
+	bump.lim_memusage =3D lim_memusage;
+
+	bpf_spin_unlock(&static_lock);
+
+	return 0;
+
+error:
+	bpf_spin_unlock(&static_lock);
+
+	return -EINVAL;
+}
+
+__weak char _license[] SEC("license") =3D "GPL";
--=20
2.47.3

