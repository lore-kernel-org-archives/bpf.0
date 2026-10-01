Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FC52E064;
	Thu,  1 Oct 2026 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886177; cv=none; b=apKBQXn8rszxM1XUpSW4zqt6OS/Zd/DREEbzUcTGMFp1b/lTBl14/AWWr7uWJAfmMonBeOmIcMFl2TzeDQqGredYLezjYoq4G60gDv73SOmDl2DsODiOSgObVcJit02cpfIY4nQ02cyLpqBIiZ0NpRB0PKPbIa3J1NGr/Vk64o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886177; c=relaxed/simple;
	bh=SJuvjX+Aa0S6X378ikrwaMLUJOHGlvkQhEaltv/urzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZED5xOHE2C/5aY31XW1XfRHQkC65h+jso0Aa9vNU4T3RZRfjfydMCi6OvF80CclMAHXZJ68ru3Ism9QL6desAkS4Gw/XILLnMcgNRKgsTykugZXmgeXqnaf26QKbl1mtje/qDQbvIth+4SYOONqjpX1/AbZKQiEVJIBCHmYRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqoAQH/7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqoAQH/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886170; x=1822422170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJuvjX+Aa0S6X378ikrwaMLUJOHGlvkQhEaltv/urzE=;
  b=MqoAQH/7MMI70iOBUVdZr5o9aoBPPZ5lfKE5sOZhjosDsBr5rBryIi70
   gmt0ACCcqJWxC0cf0dtgBJWXuwCiy+d+xO9NO5CUyEy8lTCJm/Bpnp78j
   5G/v588hGXgxN+4cXmwO0gD6LXzJB+v+hwyl3QJtmQ6e20cmZ3bQ3/4ZZ
   H5vHCQ3YcBwY1yT10/2qqzQ4F+g39sgTyXTOzLWpyIN5Zm195ojzqNAxW
   bYNfTZ8yCbFU7oNWTnEMXpUWLvduuz9+v+4mHmLGArIL1i3/Aqx3lGkXs
   K7mXNGGa9a1GemGDQCwhcVwjA6WuMCvmnu1ko6vn267fIdyNdA9grtKH2
   Q==;
X-CSE-ConnectionGUID: 0f9OApoCTNeflx3y6kNyrw==
X-CSE-MsgGUID: atGOqZgOT4CNWv78fU4wDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95466829"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95466829"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:22:43 -0700
X-CSE-ConnectionGUID: kVSZ+v6JSKGh02uuJK/bzg==
X-CSE-MsgGUID: nSy427BoQSuQW6epUMyJ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275636720"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 01 Oct 2026 13:22:41 -0700
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
Subject: [PATCH net-next 08/13] selftests: xsk: run one test case per xskxceiver invocation
Date: Thu,  1 Oct 2026 22:21:19 +0200
Message-Id: <20261001202124.692591-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
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

