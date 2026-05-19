Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CAD33A00C
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208609; cv=none; b=Xpg0wbnIHm3GRsGb3Wlq2TCH3g212hI7y+IFpnh7Z8yz0ZVYKwJ58lWu80C+by8t4EqvWN+vwbfL9s0S8hgcDd4J/ElrfxBpogsp2SI7XmDW99fOp6nVQJp7Njqkf/10+sPpFMQnc0ud5bg6XfiKWQ2qe+TDD0hQPQtNOFOslTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208609; c=relaxed/simple;
	bh=p+w+3FjMjZKhT8HGZWLNCfsKqyhq+w7CfaLJrFPTttI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijgHDRv5yulB6QduWCQqBAVy6KhDgKuuCsx0EnYIs9luS2aPJazr4MC457JOt9Ha4Qjqcu1eHcMlHt2qxDEhwpZZbUOaaqXwgZE1XeBGS/dun/RLfTa2FRh77hZ461EjdKo1bSX36uIblnQnkU1ZGVtWoAe0r2SdkOC2cg/cc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/wU9eVo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/wU9eVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF36C2BCB3;
	Tue, 19 May 2026 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208609;
	bh=p+w+3FjMjZKhT8HGZWLNCfsKqyhq+w7CfaLJrFPTttI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/wU9eVo94HeX4ebdSqfx07cXZFflTZTlgIweUmFleX1Q/BJKdgYMD7RFQyCb4pdy
	 jXp2Ta7MDQv+tsQbpXHeHLMkJhJRDdJ9+ndwUwVVcMxEPbyLjq/irl6iPytABbB0cE
	 643QocPN661huItKoB9KPxClfkcPKWTMQPVdFePMXtiuiVWSkJQOu0hYMxGdzEC+f8
	 kbBBYNfKKamuK5lpNtJZwBLYUJlcy5xm2rreWEAydEY5E0fH+ELCSM42q7kGsDxbrT
	 +jrsy4Wtc+8hYMH1o9wm/IrT1zB9gJVRd5NdZp9itYxRxopqZJTpozIWftHnScSKsW
	 l9MSfjP3IVaXw==
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
Subject: [PATCH bpf-next 2/4] selftests/bpf: Fix expired UDP LRU entries in XDP LB benchmark
Date: Tue, 19 May 2026 09:36:30 -0700
Message-ID: <20260519163632.2220753-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519163632.2220753-1-puranjay@kernel.org>
References: <20260519163632.2220753-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

populate_lru() inserts LRU entries with atime zero-initialized:

    struct real_pos_lru lru = { .pos = real_idx };

The BPF program's connection_table_lookup() enforces a 30-second timeout
for UDP flows:

    if (cur_time - dst_lru->atime > LRU_UDP_TIMEOUT)
        return NULL;

Since cur_time (system uptime) is always much larger than 30 seconds,
every pre-populated UDP entry is treated as expired on first access.
The lookup returns NULL, counting as an LRU miss.

This is masked by calibration: the BPF program runs during calibration
on one CPU, misses the expired entry, and re-inserts it with a fresh
atime.  But if the scheduler moves the thread to a different CPU for
validation, that CPU still has the atime=0 entry from populate_lru(),
causing intermittent validation failures for UDP LRU-hit scenarios:

    [udp-v4-lru-hit] COUNTER FAIL: LRU misses=1, expected 0

Fix by initializing atime with the current CLOCK_MONOTONIC time for UDP
flows, matching the clock source used by bpf_ktime_get_ns() in the BPF
program.

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

