Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E22309AA
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683907; cv=none; b=iXPx7X/zv6F2Wty9v6Rdfc6OmmYEaEds5l6FCNkTXdkmXtFPix5NH+VnR8oTtHvD7uThFPSrhRqIcavUbS7xBUr5V+TM6UpaZLSen/ZiqLayQk6mNAUZ/ODb8loOYpCcGctfP2Rv4N3swB9e8QOLwNZbkAvV/3k7ixORyoG5Efg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683907; c=relaxed/simple;
	bh=epKX+mSM+AKHUFolElU3kLRFLAoRINK4wzos0S8UVM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPTpbFVHqHlOXOIPupVlESIEUjB+vwI8f0351zQ8L0c9SVIzp0mK+I1LjfadfFLnb7HH+kAIydGFYNnlhXmIbnwOOCtfqDEDvAx8261cc3aQFSuqttD6C7A5YJqjquFvARPseevLEgwrDTf39xMJPRpwxX/Kl7feFQEtTjar76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdzunCeL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdzunCeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11F4C2BCB4;
	Mon, 20 Apr 2026 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776683907;
	bh=epKX+mSM+AKHUFolElU3kLRFLAoRINK4wzos0S8UVM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdzunCeL6SNn4kOdceTzhyrbkwseCHcXFVa3icyMkg7Q8UnVdGARPKYKV38NKX1Jz
	 8e4ADyIG8dBKTnuZi4bux2rd3qkpt2kVXzS2I12fHETZo9Yj/gzhnDVcHbG36V8PAW
	 S9s+bClCjziy4tsOrWOX+ERAbqlFMsIYcLhfhPMKw2igKNi3dVaIkUmHP0aUy1Gos3
	 6g8VC0WoO5l3DqZr5TPEh7y09F9zmq/MD3hISYDPNWMN6YeOTreDTbznhJYq4RYd7j
	 MTBbVnqoWScixJH62xkSBpQEAEL9rH67s2tAkaVyHIBaTScBtLS5sUuYUPcWs5tilY
	 Vt28Y4cuhqWtQ==
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
Subject: [RFC PATCH bpf-next 6/6] selftests/bpf: Add XDP load-balancer benchmark run script
Date: Mon, 20 Apr 2026 04:17:06 -0700
Message-ID: <20260420111726.2118636-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420111726.2118636-1-puranjay@kernel.org>
References: <20260420111726.2118636-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a convenience script that runs all 24 XDP load-balancer scenarios
and formats the results as a table with median, stddev, CV, and
percentile columns.

  ./benchs/run_bench_xdp_lb.sh

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/benchs/run_bench_xdp_lb.sh  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh

diff --git a/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh b/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
new file mode 100755
index 000000000000..1bde3898dfb6
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
@@ -0,0 +1,84 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+WARMUP=${WARMUP:-3}
+
+RUN="sudo ./bench -q -w${WARMUP} -a xdp-lb --machine-readable"
+
+SEP="  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+"
+HDR="  | %-32s | %4s | %8s | %7s | %6s | %8s | %8s | %8s | %8s |\n"
+ROW="  | %-32s | %4s | %8s | %7s | %6s | %8s | %8s | %8s | %8s |\n"
+
+function group_header()
+{
+	printf "%s\n" "$SEP"
+	printf "$HDR" "$1" "n" "p50" "stddev" "CV" "min" "p90" "p99" "max"
+	printf "%s\n" "$SEP"
+}
+
+function rval()
+{
+	echo "$1" | sed -nE "s/.*$2=([^ ]+).*/\1/p"
+}
+
+function run_scenario()
+{
+	local sc="$1"
+	shift
+	local output rline
+
+	output=$($RUN --scenario "$sc" "$@" 2>&1)
+	rline=$(echo "$output" | grep '^RESULT ' || true)
+
+	if [ -z "$rline" ]; then
+		printf "$ROW" "$sc" "ERR" "-" "-" "-" "-" "-" "-" "-"
+		return
+	fi
+
+	printf "$ROW" "$sc" \
+		"$(rval "$rline" samples)" \
+		"$(rval "$rline" median)" \
+		"$(rval "$rline" stddev)" \
+		"$(rval "$rline" cv)%" \
+		"$(rval "$rline" min)" \
+		"$(rval "$rline" p90)" \
+		"$(rval "$rline" p99)" \
+		"$(rval "$rline" max)"
+}
+
+header "XDP load-balancer benchmark"
+
+group_header "Single-flow baseline"
+for sc in tcp-v4-lru-hit tcp-v4-ch \
+	  tcp-v6-lru-hit tcp-v6-ch \
+	  udp-v4-lru-hit udp-v6-lru-hit \
+	  tcp-v4v6-lru-hit; do
+	run_scenario "$sc"
+done
+
+group_header "Diverse flows (4K src addrs)"
+for sc in tcp-v4-lru-diverse tcp-v4-ch-diverse \
+	  tcp-v6-lru-diverse tcp-v6-ch-diverse \
+	  udp-v4-lru-diverse; do
+	run_scenario "$sc"
+done
+
+group_header "TCP flags"
+run_scenario tcp-v4-syn
+run_scenario tcp-v4-rst-miss
+
+group_header "LRU stress"
+run_scenario tcp-v4-lru-miss
+run_scenario udp-v4-lru-miss
+run_scenario tcp-v4-lru-warmup
+
+group_header "Early exits"
+for sc in pass-v4-no-vip pass-v6-no-vip pass-v4-icmp pass-non-ip \
+	  drop-v4-frag drop-v4-options drop-v6-frag; do
+	run_scenario "$sc"
+done
+printf "%s\n" "$SEP"
-- 
2.52.0

