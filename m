Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9062D97BB
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284045; cv=none; b=MSbdUC9FLNsmTSZfzQewn50nQRtbj/YB0lOuA1SGKPBTtu5DobAtK8pw0vdfTQk6HJpUyIRL1tlgCdusLcnKFFpkCqVp7VN62nBpsT9uMt+9sydJ3RyssKQhtETHa20V//sBPIHI6txVA9OcVrz8nqDAV639EdXSYHcgfrXboX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284045; c=relaxed/simple;
	bh=VrA/CYx8uq9p4SGa/cvXzpbt3nQEt/HZ5/4h61xFSZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I69f/BDLnBJwChFngfcNToTtdsBwlZIUfGwkG21DbMyaGiV0hBtfaOCWcMZSsdujcfdhH4CnLraSqrm2s/t2IAvlfX7gyM3PXPi9mUkc8bfw1FN32bTvDVHKIOYmbW3iQV7RbsDbxwg8tcYbUsC88BpDtWqW6KjUNjM/ObgOivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOJ/JBPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOJ/JBPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA121F000E9;
	Wed, 20 May 2026 13:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779284044;
	bh=DNi0LGta7gymhnZzqYT89QoJEKneM5Nafscyw+odQ5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XOJ/JBPzTlBkVLbARoA5Z5ryHRlOEE4hVoLzX/rwMxUDLWPXlLjNGFNgckLnoODuO
	 mc2JOTSc5u0YMccTfARC77+NflHGr/jjowrxwLe3APtlnFil200o8PekTYtb5TiE2R
	 +1ryQvdc7leX98j/vaUgDoDZZtECGADWAZllczTKapZiflyifxM1B9uzfM0BHzpgWG
	 +qhTGijbQ8ubrh2Xdh4F5l5rYkrGHskmuauNW1yBjeiQlQpBvPiOEe713/aOTzraRa
	 UTELvN9onrYNTuTXQOKJFzeY3whWYqz8AF+GCl1Oj6c193GsQSOw6RvRB1db4+3ci3
	 epHKQE6K59bDw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Fei Chen <feichen@meta.com>,
	Taruna Agrawal <taragrawal@meta.com>,
	Nikhil Dixit Limaye <ndixit@meta.com>,
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Fix expired UDP LRU entries in XDP LB benchmark
Date: Wed, 20 May 2026 06:33:31 -0700
Message-ID: <20260520133338.3392667-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133338.3392667-1-puranjay@kernel.org>
References: <20260520133338.3392667-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

populate_lru() zero-initializes atime:

    struct real_pos_lru lru = { .pos = real_idx };

connection_table_lookup() treats UDP entries with
cur_time - atime > 30s as expired, so every pre-populated entry
expires immediately.  Calibration masks this on the CPU it runs on,
but if validation migrates to another CPU:

    [udp-v4-lru-hit] COUNTER FAIL: LRU misses=1, expected 0

Initialize atime from CLOCK_MONOTONIC for UDP flows.

Fixes: a4b5ba8187cb ("selftests/bpf: Add XDP load-balancer benchmark driver")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/benchs/bench_xdp_lb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c b/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
index 0b6709a2b03c..8e25bccbde92 100644
--- a/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
+++ b/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
@@ -563,12 +563,23 @@ static void create_per_cpu_lru_maps(struct xdp_lb_bench *skel)
 	nr_inner_maps = nr_cpus;
 }
 
+static __u64 ktime_get_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return (__u64)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
 static void populate_lru(const struct test_scenario *sc, __u32 real_idx)
 {
 	struct real_pos_lru lru = { .pos = real_idx };
 	struct flow_key fk;
 	int i, err;
 
+	if (sc->ip_proto == IPPROTO_UDP)
+		lru.atime = ktime_get_ns();
+
 	build_flow_key(&fk, sc);
 
 	/* Insert into every per-CPU inner LRU so the entry is found
-- 
2.53.0-Meta

