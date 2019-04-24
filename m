Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53A3C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA7A208E4
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GCVsAzk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDXWkL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:40:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbfDXWkK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Apr 2019 18:40:10 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OMTscb032678
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 15:40:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=MEH8BN6liaXGIPt6AFl+S8PmN/Ofy8lmLZgcD5BjGSw=;
 b=GCVsAzk1gKyKqwJ2Qw3EcEXFhpL7Jd3GoXrl4C96DBIzjam9/avwnczaZ948CyYbeRaq
 yhBfU3rC8lOloVJUD6REiMDSFD6CLZFTd4nBJY/B0mxv5td9jx2a9fqrRtMODVof5lPc
 eRARCl3qnERKXOa6L+fyFUzt1If/2nUR4MQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2x8e8xp2-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 15:40:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 24 Apr 2019 15:40:01 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 06C2729421BD; Wed, 24 Apr 2019 15:40:00 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 6/6] bpf: Add ene-to-end test for bpf_sk_storage_* helpers
Date:   Wed, 24 Apr 2019 15:40:00 -0700
Message-ID: <20190424224000.517514-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424223948.516788-1-kafai@fb.com>
References: <20190424223948.516788-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch rides on an existing BPF_PROG_TYPE_CGROUP_SKB test
(test_sock_fields.c) to do a TCP end-to-end test on the new
bpf_sk_storage_* helpers.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h     |   5 +
 .../bpf/progs/test_sock_fields_kern.c         |  49 ++++++++
 .../testing/selftests/bpf/test_sock_fields.c  | 115 +++++++++++++++---
 3 files changed, 153 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index 59e221586cf7..6e80b66d7fb1 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -211,6 +211,11 @@ static int (*bpf_strtol)(const char *buf, unsigned long long buf_len,
 static int (*bpf_strtoul)(const char *buf, unsigned long long buf_len,
 			  unsigned long long flags, unsigned long *res) =
 	(void *) BPF_FUNC_strtoul;
+static void *(*bpf_sk_storage_get)(void *map, struct bpf_sock *sk,
+				   void *value, __u64 flags) =
+	(void *) BPF_FUNC_sk_storage_get;
+static int (*bpf_sk_storage_delete)(void *map, struct bpf_sock *sk) =
+	(void *)BPF_FUNC_sk_storage_delete;
 
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c b/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c
index 37328f148538..93ef3e039da3 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields_kern.c
@@ -55,6 +55,31 @@ struct bpf_map_def SEC("maps") linum_map = {
 	.max_entries = __NR_BPF_LINUM_ARRAY_IDX,
 };
 
+struct bpf_spinlock_cnt {
+	struct bpf_spin_lock lock;
+	__u32 cnt;
+};
+
+struct bpf_map_def SEC("maps") sk_pkt_out_cnt = {
+	.type = BPF_MAP_TYPE_SK_STORAGE,
+	.key_size = sizeof(int),
+	.value_size = sizeof(struct bpf_spinlock_cnt),
+	.max_entries = 0,
+	.map_flags = BPF_F_NO_PREALLOC,
+};
+
+BPF_ANNOTATE_KV_PAIR(sk_pkt_out_cnt, int, struct bpf_spinlock_cnt);
+
+struct bpf_map_def SEC("maps") sk_pkt_out_cnt10 = {
+	.type = BPF_MAP_TYPE_SK_STORAGE,
+	.key_size = sizeof(int),
+	.value_size = sizeof(struct bpf_spinlock_cnt),
+	.max_entries = 0,
+	.map_flags = BPF_F_NO_PREALLOC,
+};
+
+BPF_ANNOTATE_KV_PAIR(sk_pkt_out_cnt10, int, struct bpf_spinlock_cnt);
+
 static bool is_loopback6(__u32 *a6)
 {
 	return !a6[0] && !a6[1] && !a6[2] && a6[3] == bpf_htonl(1);
@@ -120,7 +145,9 @@ static void tpcpy(struct bpf_tcp_sock *dst,
 SEC("cgroup_skb/egress")
 int egress_read_sock_fields(struct __sk_buff *skb)
 {
+	struct bpf_spinlock_cnt cli_cnt_init = { .lock = 0, .cnt = 0xeB9F };
 	__u32 srv_idx = ADDR_SRV_IDX, cli_idx = ADDR_CLI_IDX, result_idx;
+	struct bpf_spinlock_cnt *pkt_out_cnt, *pkt_out_cnt10;
 	struct sockaddr_in6 *srv_sa6, *cli_sa6;
 	struct bpf_tcp_sock *tp, *tp_ret;
 	struct bpf_sock *sk, *sk_ret;
@@ -161,6 +188,28 @@ int egress_read_sock_fields(struct __sk_buff *skb)
 	skcpy(sk_ret, sk);
 	tpcpy(tp_ret, tp);
 
+	if (result_idx == EGRESS_SRV_IDX) {
+		/* The userspace has created it for srv sk */
+		pkt_out_cnt = bpf_sk_storage_get(&sk_pkt_out_cnt, sk, 0, 0);
+		pkt_out_cnt10 = bpf_sk_storage_get(&sk_pkt_out_cnt10, sk,
+						   0, 0);
+	} else {
+		pkt_out_cnt = bpf_sk_storage_get(&sk_pkt_out_cnt, sk,
+						 &cli_cnt_init,
+						 BPF_SK_STORAGE_GET_F_CREATE);
+		pkt_out_cnt10 = bpf_sk_storage_get(&sk_pkt_out_cnt10,
+						   sk, &cli_cnt_init,
+						   BPF_SK_STORAGE_GET_F_CREATE);
+	}
+
+	if (!pkt_out_cnt || !pkt_out_cnt10)
+		RETURN;
+
+	pkt_out_cnt->cnt += 1;
+	bpf_spin_lock(&pkt_out_cnt10->lock);
+	pkt_out_cnt10->cnt += 10;
+	bpf_spin_unlock(&pkt_out_cnt10->lock);
+
 	RETURN;
 }
 
diff --git a/tools/testing/selftests/bpf/test_sock_fields.c b/tools/testing/selftests/bpf/test_sock_fields.c
index dcae7f664dce..550baf8aa1ca 100644
--- a/tools/testing/selftests/bpf/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/test_sock_fields.c
@@ -35,6 +35,11 @@ enum bpf_linum_array_idx {
 	__NR_BPF_LINUM_ARRAY_IDX,
 };
 
+struct bpf_spinlock_cnt {
+	struct bpf_spin_lock lock;
+	__u32 cnt;
+};
+
 #define CHECK(condition, tag, format...) ({				\
 	int __ret = !!(condition);					\
 	if (__ret) {							\
@@ -50,6 +55,8 @@ enum bpf_linum_array_idx {
 #define DATA_LEN sizeof(DATA)
 
 static struct sockaddr_in6 srv_sa6, cli_sa6;
+static int sk_pkt_out_cnt10_fd;
+static int sk_pkt_out_cnt_fd;
 static int linum_map_fd;
 static int addr_map_fd;
 static int tp_map_fd;
@@ -220,28 +227,90 @@ static void check_result(void)
 	      "Unexpected listen_tp", "Check listen_tp output. ingress_linum:%u",
 	      ingress_linum);
 
-	CHECK(srv_tp.data_segs_out != 1 ||
+	CHECK(srv_tp.data_segs_out != 2 ||
 	      srv_tp.data_segs_in ||
 	      srv_tp.snd_cwnd != 10 ||
 	      srv_tp.total_retrans ||
-	      srv_tp.bytes_acked != DATA_LEN,
+	      srv_tp.bytes_acked != 2 * DATA_LEN,
 	      "Unexpected srv_tp", "Check srv_tp output. egress_linum:%u",
 	      egress_linum);
 
 	CHECK(cli_tp.data_segs_out ||
-	      cli_tp.data_segs_in != 1 ||
+	      cli_tp.data_segs_in != 2 ||
 	      cli_tp.snd_cwnd != 10 ||
 	      cli_tp.total_retrans ||
-	      cli_tp.bytes_received != DATA_LEN,
+	      cli_tp.bytes_received != 2 * DATA_LEN,
 	      "Unexpected cli_tp", "Check cli_tp output. egress_linum:%u",
 	      egress_linum);
 }
 
+static void check_sk_pkt_out_cnt(int accept_fd, int cli_fd)
+{
+	struct bpf_spinlock_cnt pkt_out_cnt = {} , pkt_out_cnt10 = {};
+	int err;
+
+	pkt_out_cnt.cnt = ~0;
+	pkt_out_cnt10.cnt = ~0;
+	err = bpf_map_lookup_elem(sk_pkt_out_cnt_fd, &accept_fd, &pkt_out_cnt);
+	if (!err)
+		err = bpf_map_lookup_elem(sk_pkt_out_cnt10_fd, &accept_fd,
+					  &pkt_out_cnt10);
+
+	/* The bpf prog only counts for fullsock and
+	 * passive conneciton did not become fullsock until 3WHS
+	 * had been finished.
+	 * The bpf prog only counted two data packet out but we
+	 * specially init accept_fd's pkt_out_cnt by 2 in
+	 * init_sk_storage().  Hence, 4 here.
+	 */
+	CHECK(err || pkt_out_cnt.cnt != 4 || pkt_out_cnt10.cnt != 40,
+	      "bpf_map_lookup_elem(sk_pkt_out_cnt, &accept_fd)",
+	      "err:%d errno:%d pkt_out_cnt:%u pkt_out_cnt10:%u",
+	      err, errno, pkt_out_cnt.cnt, pkt_out_cnt10.cnt);
+
+	pkt_out_cnt.cnt = ~0;
+	pkt_out_cnt10.cnt = ~0;
+	err = bpf_map_lookup_elem(sk_pkt_out_cnt_fd, &cli_fd, &pkt_out_cnt);
+	if (!err)
+		err = bpf_map_lookup_elem(sk_pkt_out_cnt10_fd, &cli_fd,
+					  &pkt_out_cnt10);
+	/* Active connection is fullsock from the beginning.
+	 * 1 SYN and 1 ACK during 3WHS
+	 * 2 Acks on data packet.
+	 *
+	 * The bpf_prog initialized it to 0xeB9F.
+	 */
+	CHECK(err || pkt_out_cnt.cnt != 0xeB9F + 4 ||
+	      pkt_out_cnt10.cnt != 0xeB9F + 40,
+	      "bpf_map_lookup_elem(sk_pkt_out_cnt, &cli_fd)",
+	      "err:%d errno:%d pkt_out_cnt:%u pkt_out_cnt10:%u",
+	      err, errno, pkt_out_cnt.cnt, pkt_out_cnt10.cnt);
+}
+
+static void init_sk_storage(int sk_fd, __u32 pkt_out_cnt)
+{
+	struct bpf_spinlock_cnt scnt = {};
+	int err;
+
+	scnt.cnt = pkt_out_cnt;
+	err = bpf_map_update_elem(sk_pkt_out_cnt_fd, &sk_fd, &scnt,
+				  BPF_NOEXIST);
+	CHECK(err, "bpf_map_update_elem(sk_pkt_out_cnt_fd)",
+	      "err:%d errno:%d", err, errno);
+
+	scnt.cnt *= 10;
+	err = bpf_map_update_elem(sk_pkt_out_cnt10_fd, &sk_fd, &scnt,
+				  BPF_NOEXIST);
+	CHECK(err, "bpf_map_update_elem(sk_pkt_out_cnt10_fd)",
+	      "err:%d errno:%d", err, errno);
+}
+
 static void test(void)
 {
 	int listen_fd, cli_fd, accept_fd, epfd, err;
 	struct epoll_event ev;
 	socklen_t addrlen;
+	int i;
 
 	addrlen = sizeof(struct sockaddr_in6);
 	ev.events = EPOLLIN;
@@ -308,24 +377,30 @@ static void test(void)
 	      accept_fd, errno);
 	close(listen_fd);
 
-	/* Send some data from accept_fd to cli_fd */
-	err = send(accept_fd, DATA, DATA_LEN, 0);
-	CHECK(err != DATA_LEN, "send(accept_fd)", "err:%d errno:%d",
-	      err, errno);
-
-	/* Have some timeout in recv(cli_fd). Just in case. */
 	ev.data.fd = cli_fd;
 	err = epoll_ctl(epfd, EPOLL_CTL_ADD, cli_fd, &ev);
 	CHECK(err, "epoll_ctl(EPOLL_CTL_ADD, cli_fd)", "err:%d errno:%d",
 	      err, errno);
 
-	err = epoll_wait(epfd, &ev, 1, 1000);
-	CHECK(err != 1 || ev.data.fd != cli_fd,
-	      "epoll_wait(cli_fd)", "err:%d errno:%d ev.data.fd:%d cli_fd:%d",
-	      err, errno, ev.data.fd, cli_fd);
+	init_sk_storage(accept_fd, 2);
 
-	err = recv(cli_fd, NULL, 0, MSG_TRUNC);
-	CHECK(err, "recv(cli_fd)", "err:%d errno:%d", err, errno);
+	for (i = 0; i < 2; i++) {
+		/* Send some data from accept_fd to cli_fd */
+		err = send(accept_fd, DATA, DATA_LEN, 0);
+		CHECK(err != DATA_LEN, "send(accept_fd)", "err:%d errno:%d",
+		      err, errno);
+
+		/* Have some timeout in recv(cli_fd). Just in case. */
+		err = epoll_wait(epfd, &ev, 1, 1000);
+		CHECK(err != 1 || ev.data.fd != cli_fd,
+		      "epoll_wait(cli_fd)", "err:%d errno:%d ev.data.fd:%d cli_fd:%d",
+		      err, errno, ev.data.fd, cli_fd);
+
+		err = recv(cli_fd, NULL, 0, MSG_TRUNC);
+		CHECK(err, "recv(cli_fd)", "err:%d errno:%d", err, errno);
+	}
+
+	check_sk_pkt_out_cnt(accept_fd, cli_fd);
 
 	close(epfd);
 	close(accept_fd);
@@ -395,6 +470,14 @@ int main(int argc, char **argv)
 	CHECK(!map, "cannot find linum_map", "(null)");
 	linum_map_fd = bpf_map__fd(map);
 
+	map = bpf_object__find_map_by_name(obj, "sk_pkt_out_cnt");
+	CHECK(!map, "cannot find sk_pkt_out_cnt", "(null)");
+	sk_pkt_out_cnt_fd = bpf_map__fd(map);
+
+	map = bpf_object__find_map_by_name(obj, "sk_pkt_out_cnt10");
+	CHECK(!map, "cannot find sk_pkt_out_cnt10", "(null)");
+	sk_pkt_out_cnt10_fd = bpf_map__fd(map);
+
 	test();
 
 	bpf_object__close(obj);
-- 
2.17.1

