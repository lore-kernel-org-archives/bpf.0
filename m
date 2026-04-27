Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A52370D5C
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332240; cv=none; b=p8/eV7SxPxAQH1jOpjMrGi/BsBFreiesxU9FTE1nOYCn0ZktZ4AsjCQJSf9ekoPLEpxCV1lTpGKSlyj+XzF/WR2Ry9tZjKyXT8l7AMMAgYTJJOSNAxygQ0z7vMkW+gW9IFH1PiV49nu/E+vAqoKegP/BEtewwplnZtFPtxor4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332240; c=relaxed/simple;
	bh=/koWvIaKxg45QZD0Nx3o2i2c9valNyy8bZFlKztRbkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN5xIa3r9SLOPd9rtJ2RKHM2+X4jaTAhIscXsjQZBxL7eI43/3oqorO0tHBNOvMOKOS+OrbTDzRGPd1Mkrb/OKitQsyqNINHJe+jS+RhG0v/tPZ/eVzW33YNlO7npu6UcFKBVGCZm3jnb3N11ei60Z+sfCtOwKumN0PFgW2uaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkSndlrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkSndlrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC2EC19425;
	Mon, 27 Apr 2026 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332240;
	bh=/koWvIaKxg45QZD0Nx3o2i2c9valNyy8bZFlKztRbkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkSndlrsNu18tzMBTRtDRgRqhJr5UXYsqTn7+Kwgq3StMblYuk3E2u9siREgECEKp
	 7Tggx/gKwUhhQ8op9BpPWZZbN5DwE5PcDe6TvwyKRlMgkXp8gMsHtpaT0eq8d6SkB/
	 gsWUsVUgzTlryB78xBzeXf8U/aWU/oT+lfYSSP2IUBFeDPIFQdtclewsQ/pcQ4r1WQ
	 pZrpwnvl83FfbvpI1IojjZ4ZfvJ53QxKKXEhsRkEyLTCebjt7zDpztQA6NiFBiC7zQ
	 DosCRWVkU90JuWQVphSSzNqMQuZGzG0i1Uu7I4k9zVFon+tnMQ3Qp5Lr2on6PWAFSL
	 my1CJBGmC2U8g==
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
Subject: [PATCH bpf-next 7/7] selftests/bpf: Add XDP load-balancer benchmark run script
Date: Mon, 27 Apr 2026 16:23:04 -0700
Message-ID: <20260427232313.1582588-8-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427232313.1582588-1-puranjay@kernel.org>
References: <20260427232313.1582588-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a convenience script that runs all 24 XDP load-balancer scenarios
and formats the results as a table with median, stddev, and p99
columns.

  ./benchs/run_bench_xdp_lb.sh

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/benchs/run_bench_xdp_lb.sh  | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh

diff --git a/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh b/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
new file mode 100755
index 000000000000..f65cf46214a3
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
@@ -0,0 +1,79 @@
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
+SEP="  +----------------------------------+----------+---------+----------+"
+HDR="  | %-32s | %8s | %7s | %8s |\n"
+ROW="  | %-32s | %8s | %7s | %8s |\n"
+
+function group_header()
+{
+	printf "%s\n" "$SEP"
+	printf "$HDR" "$1" "p50" "stddev" "p99"
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
+	output=$($RUN --scenario "$sc" "$@" 2>&1) || true
+	rline=$(echo "$output" | grep '^RESULT ' || true)
+
+	if [ -z "$rline" ]; then
+		printf "$ROW" "$sc" "ERR" "-" "-"
+		return
+	fi
+
+	printf "$ROW" "$sc" \
+		"$(rval "$rline" median)" \
+		"$(rval "$rline" stddev)" \
+		"$(rval "$rline" p99)"
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
+for sc in pass-v4-no-vip pass-v6-no-vip pass-v4-icmp pass-non-ip drop-v4-frag drop-v4-options \
+	  drop-v6-frag; do
+	run_scenario "$sc"
+done
+printf "%s\n" "$SEP"
-- 
2.52.0

