Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0052FE34;
	Wed, 14 Oct 2026 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003563; cv=none; b=Hu7pScATPA9IIZtLGoGf1FYFQk0rldZ/F6g6bt6vSUzlBTJo/4maL35fGn4RyvCjpKDLKmVDMHdt9k6j4wpMyDRc9kDOeSVX5AmxFEKNNSQOH7suzo+sd+GlTuruSPyufZQTt2aEuSP+U8ZVNZvP2qzM8OgGe1PpDg/qRX+mYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003563; c=relaxed/simple;
	bh=KkuHlaM5e+/mdtDhS/8N1oV+qNJdvfFx5YVwseTKOBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2VYwG8CQZzd+utSC0g4+mAE8hJDZ2dfGY/3q2vlQ7N8kiXrmyO0fBdv6NZtzVwne3NdGwEWTAGHXYkZYt2sEnRZB25Kp0QPPBQs+4GGkS7bYaT57x/8YpIHAsZZALqIv6E7Lr3FOSUgkW0vqbV/A9tldeLnelimghUO5tuHIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n75S7TZS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n75S7TZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003561; x=1823539561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KkuHlaM5e+/mdtDhS/8N1oV+qNJdvfFx5YVwseTKOBk=;
  b=n75S7TZShw6/bqCWosHnHcrFbbU0hhNwtfJrrvqmpxcrBW8JFhhrDELP
   ltFUeHilqtWI8UQyMVeIPRYL8il2Z37WKtDt50HunOOGRbDCGuWZSdwlW
   JH7U3kpJocJHI5xHnhQCuZO1hlJ4EKKuuB2DBxbovRJL4SjktXpVDAanQ
   JQSxCr4Jj0ptTWklJbb+EQiTUfqkxF79yIbGo3a26tium/0PHDYE/yybs
   lCspEmG1HjdcgKu3lpYx7UGKqs9XN2i5aqfNV9x35TLxmHm08sUAkp6Q+
   eguUzvgruPzsFhWL6UoTLqXUsto2m97sdAenVmXVHKEnJACFnUyKlP4q/
   Q==;
X-CSE-ConnectionGUID: iXSCpBqeTg+yaFL8Zy5SBQ==
X-CSE-MsgGUID: IXkYr1nURUaIBPTEdSXYcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767269"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767269"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:46:01 -0700
X-CSE-ConnectionGUID: DaNhgoKYSZ2AT0V9EeQnpQ==
X-CSE-MsgGUID: cs+32q30R+6RZ8qchV2Oug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420694"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:45:58 -0700
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
Subject: [PATCH v3 net-next 03/15] selftests: xsk: drop the single-interface loopback mode
Date: Wed, 14 Oct 2026 20:45:27 +0200
Message-Id: <20261014184539.774708-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xskxceiver -i ethX -i ethX, used for HW tests, bound both sockets to
queue 0 of one interface, which the kernel only allows with a shared
UMEM. With the endpoints about to become separate processes, they would
have to share the UMEM mapping and the socket fd.

The mode also relied on the interface being set up by hand with a
single queue and promiscuous mode, which does not suit CI. The hardware
test added later in this series steers its traffic with ntuple and RSS
configuration instead.

Remove the shared-UMEM TX setup, the split UMEM addressing and the
POLL_TXQ_FULL workaround it needed, and drop the -i IFACE option of
test_xsk.sh that used it. XDP_SHARED_UMEM (two sockets of one endpoint)
is unaffected.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 97 ++++---------------
 .../selftests/bpf/prog_tests/test_xsk.h       |  3 -
 tools/testing/selftests/bpf/prog_tests/xsk.c  |  4 -
 tools/testing/selftests/bpf/test_xsk.sh       | 49 +++-------
 tools/testing/selftests/bpf/xsk_prereqs.sh    |  7 --
 tools/testing/selftests/bpf/xskxceiver.c      |  5 -
 6 files changed, 33 insertions(+), 132 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 16fe32e5afc0..78600ed79522 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -101,10 +101,6 @@ int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem, void
 		return ret;
 
 	umem->buffer = buffer;
-	if (ifobj->shared_umem && ifobj->rx_on) {
-		umem->base_addr = umem_size(umem);
-		umem->next_buffer = umem_size(umem);
-	}
 
 	return 0;
 }
@@ -115,8 +111,8 @@ static u64 umem_alloc_buffer(struct xsk_umem_info *umem)
 
 	addr = umem->next_buffer;
 	umem->next_buffer += umem->frame_size;
-	if (umem->next_buffer >= umem->base_addr + umem_size(umem))
-		umem->next_buffer = umem->base_addr;
+	if (umem->next_buffer >= umem_size(umem))
+		umem->next_buffer = 0;
 
 	return addr;
 }
@@ -207,7 +203,7 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 
 	for (i = 0; i < MAX_INTERFACES; i++) {
 		struct ifobject *ifobj = i ? ifobj_rx : ifobj_tx;
-		struct xsk_umem_info *umem_real;
+		struct xsk_umem_info *umem;
 
 		ifobj->xsk = &ifobj->xsk_arr[0];
 		ifobj->use_poll = false;
@@ -224,16 +220,14 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			ifobj->tx_on = false;
 		}
 
-		umem_real = ifobj->xsk_arr[0].umem_real;
-		memset(umem_real, 0, sizeof(*umem_real));
+		umem = ifobj->xsk_arr[0].umem;
+		memset(umem, 0, sizeof(*umem));
 		for (j = 0; j < MAX_SOCKETS; j++) {
 			struct xsk_socket_info *xsk = &ifobj->xsk_arr[j];
 
 			memset(xsk, 0, sizeof(*xsk));
 			xsk->rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
-			if (j == 0)
-				xsk->umem_real = umem_real;
-			xsk->umem = umem_real;
+			xsk->umem = umem;
 			xsk->batch_size = DEFAULT_BATCH_SIZE;
 			if (i == 0)
 				xsk->pkt_stream = test->tx_pkt_stream_default;
@@ -825,8 +819,6 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 	void *data = xsk_umem__get_data(umem->buffer, addr);
 	u64 umem_sz = umem_size(umem);
 
-	addr -= umem->base_addr;
-
 	if (addr >= umem_sz || addr + len > umem_sz) {
 		ksft_print_msg("Frag invalid addr: %llx len: %u\n",
 			       (unsigned long long)addr, len);
@@ -1164,7 +1156,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 		       bool test_timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
-	struct xsk_umem_info *umem = ifobject->xsk_arr[0].umem_real;
+	struct xsk_umem_info *umem = ifobject->xsk_arr[0].umem;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
 	bool use_poll = ifobject->use_poll;
 	struct pollfd fds = { };
@@ -1468,12 +1460,12 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 }
 
 static int xsk_configure(struct test_spec *test, struct ifobject *ifobject,
-			  struct xsk_umem_info *umem, bool tx)
+			  struct xsk_umem_info *umem)
 {
 	int i, ret;
 
 	for (i = 0; i < test->nb_sockets; i++) {
-		bool shared = (ifobject->shared_umem && tx) ? true : !!i;
+		bool shared = !!i;
 		u32 ctr = 0;
 
 		while (ctr++ < SOCK_RECONF_CTR) {
@@ -1497,31 +1489,6 @@ static int xsk_configure(struct test_spec *test, struct ifobject *ifobject,
 	return 0;
 }
 
-static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobject)
-{
-	struct xsk_umem_info *umem_rx, *umem_tx;
-	int ret;
-
-	if (!test->ifobj_rx || !test->ifobj_rx->xsk_arr[0].umem->umem) {
-		ksft_print_msg("Error: RX UMEM is not initialized before shared-UMEM TX setup\n");
-		return -EINVAL;
-	}
-
-	umem_rx = test->ifobj_rx->xsk_arr[0].umem;
-	umem_tx = ifobject->xsk_arr[0].umem_real;
-	memcpy(umem_tx, umem_rx, sizeof(*umem_tx));
-	umem_tx->base_addr = 0;
-	umem_tx->next_buffer = 0;
-
-	ret = xsk_configure(test, ifobject, umem_rx, true);
-	if (ret)
-		return ret;
-	ifobject->xsk = &ifobject->xsk_arr[0];
-	ifobject->xskmap = test->ifobj_rx->xskmap;
-
-	return 0;
-}
-
 static int xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream *pkt_stream,
 				   bool fill_up)
 {
@@ -1547,7 +1514,7 @@ static int xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
 			if (!pkt) {
 				if (!fill_up)
 					break;
-				addr = filled * umem->frame_size + umem->base_addr;
+				addr = filled * umem->frame_size;
 			} else if (pkt->offset >= 0) {
 				addr = pkt->offset % umem->frame_size + umem_alloc_buffer(umem);
 			} else {
@@ -1584,9 +1551,6 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB;
 
-	if (ifobject->shared_umem)
-		umem_sz *= 2;
-
 	mmap_sz = umem->unaligned_mode ?
 		ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE : umem_sz;
 
@@ -1600,7 +1564,7 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (ret)
 		return ret;
 
-	ret = xsk_configure(test, ifobject, umem, false);
+	ret = xsk_configure(test, ifobject, umem);
 	if (ret)
 		return ret;
 
@@ -1629,10 +1593,7 @@ static int testapp_validate_tx_endpoint(struct test_spec *test,
 	int err;
 
 	if (test->current_step == 1) {
-		if (!ifobject->shared_umem)
-			err = thread_common_ops(test, ifobject);
-		else
-			err = thread_common_ops_tx(test, ifobject);
+		err = thread_common_ops(test, ifobject);
 		if (err)
 			return err;
 	}
@@ -1779,7 +1740,7 @@ static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_r
 			return err;
 	}
 
-	if (!ifobj_tx || ifobj_tx->shared_umem)
+	if (!ifobj_tx)
 		return 0;
 
 	if (xdp_prog_changed_tx(test))
@@ -1805,7 +1766,7 @@ static void clean_umem(struct test_spec *test, struct ifobject *ifobj1, struct i
 		return;
 
 	testapp_clean_xsk_umem(ifobj1);
-	if (ifobj2 && !ifobj2->shared_umem)
+	if (ifobj2)
 		testapp_clean_xsk_umem(ifobj2);
 }
 
@@ -2184,12 +2145,6 @@ int testapp_invalid_desc(struct test_spec *test)
 		pkts[8].valid = false;
 	}
 
-	if (test->ifobj_tx->shared_umem) {
-		pkts[4].offset += umem_sz;
-		pkts[5].offset += umem_sz;
-		pkts[6].offset += umem_sz;
-	}
-
 	if (pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts)))
 		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
@@ -2248,28 +2203,14 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 
 int testapp_poll_txq_tmout(struct test_spec *test)
 {
-	bool shared_umem = test->ifobj_tx->shared_umem;
-	int ret;
-
 	test->poll_tmout = true;
-	/*
-	 * POLL_TXQ_FULL exercises TX timeout setup in isolation.
-	 * Keep TX out of shared-UMEM mode here so TX setup does not require
-	 * RX UMEM to be initialized first.
-	 */
-	test->ifobj_tx->shared_umem = false;
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
 	test->ifobj_tx->xsk->umem->frame_size = 2048;
-	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048)) {
-		test->ifobj_tx->shared_umem = shared_umem;
+	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048))
 		return TEST_FAILURE;
-	}
-
-	ret = testapp_validate_traffic_single_thread(test, test->ifobj_tx);
-	test->ifobj_tx->shared_umem = shared_umem;
 
-	return ret;
+	return testapp_validate_traffic_single_thread(test, test->ifobj_tx);
 }
 
 int testapp_poll_rxq_tmout(struct test_spec *test)
@@ -2656,8 +2597,8 @@ struct ifobject *ifobject_create(void)
 	if (!ifobj->xsk_arr)
 		goto out_xsk_arr;
 
-	ifobj->xsk_arr[0].umem_real = calloc(1, sizeof(struct xsk_umem_info));
-	if (!ifobj->xsk_arr[0].umem_real)
+	ifobj->xsk_arr[0].umem = calloc(1, sizeof(struct xsk_umem_info));
+	if (!ifobj->xsk_arr[0].umem)
 		goto out_umem;
 
 	return ifobj;
@@ -2672,7 +2613,7 @@ struct ifobject *ifobject_create(void)
 void ifobject_delete(struct ifobject *ifobj)
 {
 	if (ifobj->xsk_arr)
-		free(ifobj->xsk_arr[0].umem_real);
+		free(ifobj->xsk_arr[0].umem);
 
 	free(ifobj->xsk_arr);
 	free(ifobj);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 03753ddc5dcd..379be8481079 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -83,7 +83,6 @@ typedef int (*test_func_t)(struct test_spec *test);
 struct xsk_socket_info {
 	struct xsk_ring_cons rx;
 	struct xsk_ring_prod tx;
-	struct xsk_umem_info *umem_real;
 	struct xsk_umem_info *umem;
 	struct xsk_socket *xsk;
 	struct pkt_stream *pkt_stream;
@@ -108,7 +107,6 @@ struct xsk_umem_info {
 	u32 frame_headroom;
 	void *buffer;
 	u32 frame_size;
-	u32 base_addr;
 	u32 fill_size;
 	u32 comp_size;
 	bool unaligned_mode;
@@ -145,7 +143,6 @@ struct ifobject {
 	bool busy_poll;
 	bool use_fill_ring;
 	bool release_rx;
-	bool shared_umem;
 	bool use_metadata;
 	bool unaligned_supp;
 	bool multi_buff_supp;
diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
index 6e2f63ee2a6c..e191f84d819c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
@@ -53,10 +53,6 @@ int configure_ifobj(struct ifobject *tx, struct ifobject *rx)
 	if (!ASSERT_OK_FD(tx->ifindex, "get TX ifindex"))
 		return -1;
 
-	tx->shared_umem = false;
-	rx->shared_umem = false;
-
-
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index 62db060298a4..69fac65f073c 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -71,9 +71,6 @@
 # Set up veth interfaces and leave them up so xskxceiver can be launched in a debugger:
 #   sudo ./test_xsk.sh -d
 #
-# Run test suite for physical device in loopback mode
-#   sudo ./test_xsk.sh -i IFACE
-#
 # Run test suite in a specific mode only [skb,drv,zc]
 #   sudo ./test_xsk.sh -m MODE
 #
@@ -88,14 +85,11 @@
 
 . xsk_prereqs.sh
 
-ETH=""
-
-while getopts "vi:dm:lt:h" flag
+while getopts "vdm:lt:h" flag
 do
 	case "${flag}" in
 		v) verbose=1;;
 		d) debug=1;;
-		i) ETH=${OPTARG};;
 		m) MODE=${OPTARG};;
 		l) list=1;;
 		t) TEST=${OPTARG};;
@@ -157,21 +151,16 @@ if [[ $help -eq 1 ]]; then
         exit
 fi
 
-if [ ! -z $ETH ]; then
-	VETH0=${ETH}
-	VETH1=${ETH}
-else
-	validate_root_exec
-	validate_veth_support ${VETH0}
-	validate_ip_utility
-	setup_vethPairs
-
-	retval=$?
-	if [ $retval -ne 0 ]; then
-		test_status $retval "${TEST_NAME}"
-		cleanup_exit ${VETH0} ${VETH1}
-		exit $retval
-	fi
+validate_root_exec
+validate_veth_support ${VETH0}
+validate_ip_utility
+setup_vethPairs
+
+retval=$?
+if [ $retval -ne 0 ]; then
+	test_status $retval "${TEST_NAME}"
+	cleanup_exit ${VETH0} ${VETH1}
+	exit $retval
 fi
 
 
@@ -203,11 +192,7 @@ fi
 
 exec_xskxceiver
 
-if [ -z $ETH ]; then
-	cleanup_exit ${VETH0} ${VETH1}
-else
-	cleanup_iface ${ETH} ${MTU}
-fi
+cleanup_exit ${VETH0} ${VETH1}
 
 if [[ $list -eq 1 ]]; then
     exit
@@ -216,18 +201,12 @@ fi
 TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
 busy_poll=1
 
-if [ -z $ETH ]; then
-	setup_vethPairs
-fi
+setup_vethPairs
 exec_xskxceiver
 
 ## END TESTS
 
-if [ -z $ETH ]; then
-	cleanup_exit ${VETH0} ${VETH1}
-else
-	cleanup_iface ${ETH} ${MTU}
-fi
+cleanup_exit ${VETH0} ${VETH1}
 
 failures=0
 echo -e "\nSummary:"
diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/bpf/xsk_prereqs.sh
index 47c7b8064f38..ebff0f95d14b 100755
--- a/tools/testing/selftests/bpf/xsk_prereqs.sh
+++ b/tools/testing/selftests/bpf/xsk_prereqs.sh
@@ -53,13 +53,6 @@ test_exit()
 	exit 1
 }
 
-cleanup_iface()
-{
-	ip link set $1 mtu $2
-	ip link set $1 xdp off
-	ip link set $1 xdpgeneric off
-}
-
 clear_configs()
 {
 	[ $(ip link show $1 &>/dev/null; echo $?;) == 0 ] &&
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 7dad8556a722..24109dd7264e 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -341,7 +341,6 @@ int main(int argc, char **argv)
 	u32 i, j, failed_tests = 0, nb_tests;
 	int modes = TEST_MODE_SKB + 1;
 	struct test_spec test;
-	bool shared_netdev;
 	int ret;
 
 	/* Use libbpf 1.0 API mode */
@@ -388,10 +387,6 @@ int main(int argc, char **argv)
 		ksft_exit_xfail();
 	}
 
-	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
-	ifobj_tx->shared_umem = shared_netdev;
-	ifobj_rx->shared_umem = shared_netdev;
-
 	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx))
 		print_usage(argv);
 
-- 
2.43.0

