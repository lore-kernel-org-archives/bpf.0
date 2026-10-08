Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20022492196;
	Thu,  8 Oct 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460184; cv=none; b=h0leZIBnbOuro/GVvwwsVRzIAT1NqSZcntT+l8HaAUDSQEFl8au9jpuHRsaNZ9cqgc1rHP489tqnIqDCsy4Dcf/O6T14HdBpxKGxJn+whP6uhqHkIUimPTUHvgvyX2+PQLJq0jnhyhTSDDOb4y/Bx+jyukHcz1ZoF/0jNuQ9bJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460184; c=relaxed/simple;
	bh=SJuvjX+Aa0S6X378ikrwaMLUJOHGlvkQhEaltv/urzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iM5n+/fyf6pQbd4BP+gAM7n4xsqpeJJl84Q+wPHK5sn+iQMb/EWn2mHtLwgf2MATsdm6IR+izu0kNuGYSRYJxEJGmNg0ZCFVDcvxVh2/h7FsncNsOozZZBpgMbsBTFYvwPb5EZw9SZ3daIYiqPudoKoxLGrAz/LoHYytBk6t8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYUKPT8T; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYUKPT8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791460182; x=1822996182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJuvjX+Aa0S6X378ikrwaMLUJOHGlvkQhEaltv/urzE=;
  b=IYUKPT8TKhp1lu65RYUmjqFc7DdJyJlB96HmrHdxXJCd7xyxVVdE2LC8
   fXAse+pIVuAxtT9R7nFSXpQL0rrtraxThTBd2AugKxqjxSTRdShlroxVU
   RlfrfmHa1E8sSxBSWHelipU/o5X24zcjPt7NhBaxtztPpFLm/TUyaoy2l
   +GJbUjr/CAxZjohkwdqXOk2iVZmssQvHaXIM6lS4lWojm+fyzndFoaoBx
   en6XIHGPPT7G8CBABGMIXxD4Tr3Dpq6/yjcjU4csqE0fYRYcj4g++sFUy
   zdhC43fOwg1U+0Qv/H/09I8bBtp//p+2mXT6tg/3g/yrj+WJo4oWEW6Fv
   w==;
X-CSE-ConnectionGUID: /YYqOl94SgO+Jo5xp00Xnw==
X-CSE-MsgGUID: UH86htrgQ0e+fgAacZMp6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="124967"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="124967"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 04:49:42 -0700
X-CSE-ConnectionGUID: nnXgDRvXTBKStCMOs2DOPg==
X-CSE-MsgGUID: 6MHwC3u2RYShzwm0BiZz5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="467158"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 08 Oct 2026 04:49:40 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net-next 08/14] selftests: xsk: run one test case per xskxceiver invocation
Date: Thu,  8 Oct 2026 13:49:03 +0200
Message-Id: <20261008114909.734364-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make test_xsk.sh own the mode x case matrix and run xskxceiver once per
case, so that every case starts from a fresh process and a case that
crashes fails only itself. A single case is also the unit that the next
patch splits into separate RX and TX endpoint processes.

xskxceiver now requires -m and -t and runs exactly that case. It
reports one KTAP result and exits with its verdict. An unsupported mode
skips the case instead of exiting with XFAIL.

test_xsk.sh runs every case in the skb and drv modes, or in the one
given with -m, in both the softirq and the busy-poll pass, and prints a
summary of the passed, skipped and failed cases. -t also accepts a test
name, which is resolved through xskxceiver -l. Only skb and drv modes
are accepted, as veth has no zero-copy support, and the script skips
when xskxceiver was not built. As ARGS is now rebuilt for every case,
exec_xskxceiver() adds -b to a local copy of it.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/net/lib/xsk/xskxceiver.c        |  52 ++++-----
 tools/testing/selftests/net/test_xsk.sh       | 102 ++++++++++++++----
 tools/testing/selftests/net/xsk_prereqs.sh    |   6 +-
 3 files changed, 103 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index afd6b242aa0d..b8a52846eaf8 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -169,7 +169,7 @@ static struct option long_options[] = {
 static void print_usage(char **argv)
 {
 	const char *str =
-		"  Usage: xskxceiver [OPTIONS]\n"
+		"  Usage: xskxceiver -i TX_IFACE -i RX_IFACE -m MODE -t TEST [OPTIONS]\n"
 		"  Options:\n"
 		"  -i, --interface      Use interface\n"
 		"  -v, --verbose        Verbose output\n"
@@ -267,6 +267,9 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 		}
 	}
 
+	if (opt_run_test == RUN_ALL_TESTS || opt_mode == TEST_MODE_ALL)
+		print_usage(argv);
+
 	bind_iface(ifobj_tx, ifname[0], worker_testapp_validate_tx, argv);
 	bind_iface(ifobj_rx, ifname[1], worker_testapp_validate_rx, argv);
 }
@@ -368,10 +371,9 @@ int main(int argc, char **argv)
 	u32 cache_line_size, max_frags, umem_tailroom;
 	const size_t total_tests = ARRAY_SIZE(tests);
 	struct ifobject *ifobj_tx, *ifobj_rx;
-	u32 i, j, failed_tests = 0, nb_tests;
 	struct test_spec test = {};
 	int ret = TEST_FAILURE;
-	u32 caps, modes = 0;
+	u32 caps;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -420,42 +422,20 @@ int main(int argc, char **argv)
 
 	caps = detect_mode_caps(ifobj_tx);
 
-	if (opt_mode != TEST_MODE_ALL && !mode_supported(opt_mode, caps)) {
+	if (!mode_supported(opt_mode, caps)) {
 		if (opt_mode == TEST_MODE_DRV)
-			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
+			ksft_print_msg("XDP_DRV mode not supported.\n");
 		else
-			ksft_print_msg("Error: zero-copy mode not supported.\n");
-		ksft_exit_xfail();
+			ksft_print_msg("zero-copy mode not supported.\n");
+		ret = TEST_SKIP;
+		goto out;
 	}
 
-	for (i = TEST_MODE_SKB; i <= TEST_MODE_ZC; i++)
-		if ((opt_mode == TEST_MODE_ALL || i == opt_mode) && mode_supported(i, caps))
-			modes++;
-	if (opt_run_test == RUN_ALL_TESTS)
-		nb_tests = total_tests;
-	else
-		nb_tests = 1;
 	/* Line-buffer stdout so verdicts reach a capturing launcher live. */
 	ksft_print_header();
-	ksft_set_plan(modes * nb_tests);
-
-	for (i = TEST_MODE_SKB; i <= TEST_MODE_ZC; i++) {
-		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
-			continue;
-		if (!mode_supported(i, caps))
-			continue;
-
-		for (j = 0; j < total_tests; j++) {
-			if (opt_run_test != RUN_ALL_TESTS && j != opt_run_test)
-				continue;
-
-			test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
-			if (run_pkt_test(&test) == TEST_FAILURE)
-				failed_tests++;
-			usleep(USLEEP_MAX);
-		}
-	}
-	ret = failed_tests ? TEST_FAILURE : TEST_PASS;
+	ksft_set_plan(1);
+	test_init(&test, ifobj_tx, ifobj_rx, opt_mode, &tests[opt_run_test]);
+	ret = run_pkt_test(&test);
 
 out:
 	cleanup_iface(ifobj_tx);
@@ -465,6 +445,12 @@ int main(int argc, char **argv)
 	ifobject_delete(ifobj_tx);
 	ifobject_delete(ifobj_rx);
 
+	if (ret == TEST_SKIP && ksft_test_num()) {
+		ksft_print_cnts();
+		return KSFT_SKIP;
+	}
+	if (ret == TEST_SKIP)
+		ksft_exit_skip("mode not supported\n");
 	if (ret)
 		ksft_exit_fail();
 	else
diff --git a/tools/testing/selftests/net/test_xsk.sh b/tools/testing/selftests/net/test_xsk.sh
index 69fac65f073c..e476556eb05b 100755
--- a/tools/testing/selftests/net/test_xsk.sh
+++ b/tools/testing/selftests/net/test_xsk.sh
@@ -71,7 +71,7 @@
 # Set up veth interfaces and leave them up so xskxceiver can be launched in a debugger:
 #   sudo ./test_xsk.sh -d
 #
-# Run test suite in a specific mode only [skb,drv,zc]
+# Run test suite in a specific mode only [skb,drv]
 #   sudo ./test_xsk.sh -m MODE
 #
 # List available tests
@@ -85,6 +85,11 @@
 
 . xsk_prereqs.sh
 
+if [ ! -x "./${XSKOBJ}" ]; then
+	echo "xskxceiver was not built; skipping"
+	exit $ksft_skip
+fi
+
 while getopts "vdm:lt:h" flag
 do
 	case "${flag}" in
@@ -151,6 +156,31 @@ if [[ $help -eq 1 ]]; then
         exit
 fi
 
+if [ -n "$MODE" ]; then
+	case "$MODE" in
+		skb|drv) MODES=("$MODE");;
+		*) echo "Unsupported veth mode: $MODE (expected skb or drv)" >&2
+		   exit 1;;
+	esac
+else
+	MODES=(skb drv)
+fi
+
+if [ -n "$TEST" ]; then
+	if [[ "$TEST" =~ ^[0-9]+$ ]]; then
+		CASES=("$TEST")
+	else
+		mapfile -t CASES < <(./${XSKOBJ} -l |
+			awk -F ': ' -v name="$TEST" '$2 == name {print $1}')
+	fi
+else
+	mapfile -t CASES < <(./${XSKOBJ} -l | awk -F ': ' '/^[0-9]+: / {print $1}')
+fi
+if [ ${#CASES[@]} -eq 0 ]; then
+	echo "Unknown AF_XDP test: $TEST" >&2
+	exit 1
+fi
+
 validate_root_exec
 validate_veth_support ${VETH0}
 validate_ip_utility
@@ -168,29 +198,38 @@ if [[ $verbose -eq 1 ]]; then
 	ARGS+="-v "
 fi
 
-if [ -n "$MODE" ]; then
-	ARGS+="-m ${MODE} "
-fi
-
-if [ -n "$TEST" ]; then
-	ARGS+="-t ${TEST} "
-fi
-
 retval=$?
 test_status $retval "${TEST_NAME}"
 
 ## START TESTS
 
 statusList=()
+nameList=()
+
+run_matrix()
+{
+	local mode case_id
+
+	for mode in "${MODES[@]}"; do
+		for case_id in "${CASES[@]}"; do
+			ARGS="${BASE_ARGS} -m ${mode} -t ${case_id}"
+			TEST_NAME="XSK_${mode}_${case_id}_${RUN_VARIANT}_${VETH0}"
+			exec_xskxceiver
+		done
+	done
+}
+
+BASE_ARGS="${ARGS}"
 
-TEST_NAME="XSK_SELFTESTS_${VETH0}_SOFTIRQ"
+RUN_VARIANT=SOFTIRQ
 
 if [[ $debug -eq 1 ]]; then
-    echo "-i" ${VETH0} "-i" ${VETH1}
+    ARGS="${BASE_ARGS} -m ${MODES[0]} -t ${CASES[0]}"
+    echo "./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}"
     exit
 fi
 
-exec_xskxceiver
+run_matrix
 
 cleanup_exit ${VETH0} ${VETH1}
 
@@ -198,28 +237,47 @@ if [[ $list -eq 1 ]]; then
     exit
 fi
 
-TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
+RUN_VARIANT=BUSY_POLL
 busy_poll=1
 
 setup_vethPairs
-exec_xskxceiver
+run_matrix
 
 ## END TESTS
 
 cleanup_exit ${VETH0} ${VETH1}
 
+passes=0
+skips=0
 failures=0
-echo -e "\nSummary:"
+failed_tests=()
 for i in "${!statusList[@]}"
 do
-	if [ ${statusList[$i]} -ne 0 ]; then
-	        test_status ${statusList[$i]} ${nameList[$i]}
-		failures=1
-	fi
+	case ${statusList[$i]} in
+		$ksft_pass)
+			passes=$((passes + 1))
+			;;
+		$ksft_skip)
+			skips=$((skips + 1))
+			;;
+		*)
+			failures=$((failures + 1))
+			failed_tests+=("${nameList[$i]}")
+			;;
+	esac
 done
 
-if [ $failures -eq 0 ]; then
-        echo "All tests successful!"
-else
+echo
+echo "Summary:"
+printf "  Tests:   %d\n" "${#statusList[@]}"
+printf "  Passed:  %d\n" "$passes"
+printf "  Skipped: %d\n" "$skips"
+printf "  Failed:  %d\n" "$failures"
+
+if [ $failures -ne 0 ]; then
+	echo "Failed tests:"
+	for TEST_NAME in "${failed_tests[@]}"; do
+		echo "  $TEST_NAME"
+	done
 	exit 1
 fi
diff --git a/tools/testing/selftests/net/xsk_prereqs.sh b/tools/testing/selftests/net/xsk_prereqs.sh
index 5e5c8ef3fff2..30173db12c56 100755
--- a/tools/testing/selftests/net/xsk_prereqs.sh
+++ b/tools/testing/selftests/net/xsk_prereqs.sh
@@ -71,11 +71,13 @@ validate_ip_utility()
 
 exec_xskxceiver()
 {
+	local run_args="${ARGS}"
+
         if [[ $busy_poll -eq 1 ]]; then
-	        ARGS+="-b "
+		run_args+=" -b"
 	fi
 
-	./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}
+	./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${run_args}
 	retval=$?
 
 	if [[ $list -ne 1 ]]; then
-- 
2.43.0

