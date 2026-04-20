Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DA39B483
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682716; cv=none; b=mr9WeLfqCu/KLfvny2YtuRwvh98iq+8gkSvW+GMbYGalvS0/uOc/uuf8B5oYuJ9NFfCg+PP5tDHB0uYIc//Vx20UCmNaT1bKiokiYb2lrMxeKRxM6dnRI91FG/mg+BAj0QoebPpmY3In4x/dX3ef5eSwFF6LnAukSH4t17MG93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682716; c=relaxed/simple;
	bh=CaSk3WjxQ4BTCU8oH0q4f4ER0ZZvGK9z0YdkAWP2Vf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4jOxLZcXXCwWwIVZ8SALELNeBC489lTtONLo0mSTLnAHhbAegyQqXnwVzM33sLuJtu8aob1CCQbfVnfIyviDrbCwQl/TgAqu9j/yrI5vu9Tu4nQ0nfnNsssQEL9Xp528WcIuc8s80nUVHS0981GymL1gnzkmtiPzwFeJ/u3B/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p29QGp/J; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p29QGp/J"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so6530295e9.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682712; x=1777287512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/eX958hSrcjpsF7S2eDJscZseiSjiPgSY/nig0UcIA=;
        b=p29QGp/JYk+dKQ8znasXmu7odw3VjChsFme1N8GkIi7H+UAIAbSnzlgUBsBF5uz3vA
         xBgdLaiL0JlCSMIHw+EOKrUtLSP5oT0NIkbVxa0UYBkxWtrqfx4sTLi5/XnIKzzCLPm7
         daB7Fc0svmn7Awk6N/0QLwBagatq95/NfMcUJZi/3hBTix7ki5domDUalwlfnLOECBnh
         IUD8Fc5kbGaEVif+dHjE8P2i9bg4crEsbopt6wiRUphN6BgVMkCC9o7RcmGmHmE04tTU
         H9+pAMP1LKVlji+/qh5zlJik7Pk9/sLz08jx2qwkNH3WXW3hEYLPUBhCl7Xl84E908Qy
         hYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682712; x=1777287512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/eX958hSrcjpsF7S2eDJscZseiSjiPgSY/nig0UcIA=;
        b=gUtdqd1fjFSKJmNGjUMBTe6plg5FSoBtoyGSUuhSNWGzJCmci1ZSKAV8s8zaDzjpD0
         WBWsUK5x09L//A5JIHi0t8t7S+6L8h/+j5N6E3BheE28UPYqTt9rl3HGl/dFGABKGmoC
         eK/AWedvgLF4NeN37rBhIIHIzDkUgHXxyVyB7A//hU4V6Z43eCMUqdKXWpCjsHF1HtJL
         1DC0jrsY8FGFT3eLwhqnoyG7OoZOjKmdR25N4ma+tA5Um6osEn3XwTXr78KXyeUNXq2Y
         F03Geap/qUrt7ZOoZkGzrR4n/M2mCfCY8+FJGIi0n9qupTEMHEqweCE4Xkw0ktMrWyzf
         faQA==
X-Forwarded-Encrypted: i=1; AFNElJ+isqCm4DJEU4N4wApJ/9DiSVwAJdsGSKXuOcWHo5SYGT1wUdZGSS9dN16K0ufLnN/ios8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Mfas7Ca+o1UAHGQXIMxzP/zbI13J6BaPuOmZh3AVVBoJU9sY
	nQx5ZyROasKZTgXYMsFjSNdpQ9jg9w/ZHieaiQy1MbRKgTVsto1GwpQG
X-Gm-Gg: AeBDiev7bwa+CXZA8EgDHOrcTzRvP34U2zG4fiMoZ+zl9YhyDS3WpyaThtZq2LqswD9
	spe3Ws2Af1/3SrQpSlj8g1GeCPqsNmQe+hy+UMMhtQFqzrhSBlPxnwxf2SNOwGBAIUwu9tL3N9o
	slmZ1apTPOTBV7oqAeFwIsjJNMMalFy0e779+IqZEMO+LU2h1MTZpbj+XhxvSArthUUhOpAmSSi
	AuvtITAM22SMoRUw/X+Vlv1QKTvAvTi4A2J85Ne/dYTvhraRExovHi0fn5rKVQmAxNblt9I0nTv
	MkL3nnag6ZwqM/JFwuEbnjfFFGX1V8mWvlAdRpYHC5TmR0XLM6jJwQHO7yGN/8PfaBetkMEDfEh
	h2RZ5r2ncU865Floi1jzISdYSiPvMa7mIjcNcgQmdwGCM+YDn39jz7yMgDCoPdQq2Hk3KFfpV7q
	Qb7jr8txUVnMhS3qdlx2oyizhIVqweLi3t7Aw+OQ==
X-Received: by 2002:a05:600c:a318:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-488fb746a0cmr146403945e9.5.1776682712449;
        Mon, 20 Apr 2026 03:58:32 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm290929495e9.15.2026.04.20.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:58:32 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: mahe.tardy@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	lkp@intel.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v4 4/6] selftests/bpf: add icmp_send_unreach kfunc tests
Date: Mon, 20 Apr 2026 10:58:14 +0000
Message-Id: <20260420105816.72168-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420105816.72168-1-mahe.tardy@gmail.com>
References: <aI0MkNvWlE4FXMV8@gmail.com>
 <20260420105816.72168-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test opens a server and client, enters a new cgroup, attach a
cgroup_skb program on egress and calls the icmp_send_unreach function
from the client egress so that an ICMP unreach control message is sent
back to the client.  It then fetches the message from the error queue to
confirm the correct ICMP unreach code has been sent.

Note that, for the client, we have to connect in non-blocking mode to
let the test execute faster. Otherwise, we need to wait for the TCP
three-way handshake to timeout in the kernel before reading the errno.

Also note that we don't set IP_RECVERR on the socket in
connect_to_fd_nonblock since the error will be transferred anyway in our
test because the connection is rejected at the beginning of the TCP
handshake. See in net/ipv4/tcp_ipv4.c:tcp_v4_err line 615 to 655 for
more details.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_unreach_kfunc.c  | 136 ++++++++++++++++++
 .../selftests/bpf/progs/icmp_send_unreach.c   |  36 +++++
 2 files changed, 172 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send_unreach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
new file mode 100644
index 000000000000..24d5e01cfe80
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <linux/errqueue.h>
+#include "icmp_send_unreach.skel.h"
+
+#define TIMEOUT_MS 1000
+#define SRV_PORT 54321
+
+#define ICMP_DEST_UNREACH 3
+
+#define ICMP_FRAG_NEEDED 4
+#define NR_ICMP_UNREACH 15
+
+static int connect_to_fd_nonblock(int server_fd)
+{
+	struct sockaddr_storage addr;
+	socklen_t len = sizeof(addr);
+	int fd, err;
+
+	if (getsockname(server_fd, (struct sockaddr *)&addr, &len))
+		return -1;
+
+	fd = socket(addr.ss_family, SOCK_STREAM | SOCK_NONBLOCK, 0);
+	if (fd < 0)
+		return -1;
+
+	err = connect(fd, (struct sockaddr *)&addr, len);
+	if (err < 0 && errno != EINPROGRESS) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+static void read_icmp_errqueue(int sockfd, int expected_code)
+{
+	ssize_t n;
+	struct sock_extended_err *sock_err;
+	struct cmsghdr *cm;
+	char ctrl_buf[512];
+	struct msghdr msg = {
+		.msg_control = ctrl_buf,
+		.msg_controllen = sizeof(ctrl_buf),
+	};
+
+	n = recvmsg(sockfd, &msg, MSG_ERRQUEUE);
+	if (!ASSERT_GE(n, 0, "recvmsg_errqueue"))
+		return;
+
+	cm = CMSG_FIRSTHDR(&msg);
+	if (!ASSERT_NEQ(cm, NULL, "cm_firsthdr_null"))
+		return;
+
+	for (; cm; cm = CMSG_NXTHDR(&msg, cm)) {
+		if (!ASSERT_EQ(cm->cmsg_level, IPPROTO_IP, "cmsg_type") ||
+		    !ASSERT_EQ(cm->cmsg_type, IP_RECVERR, "cmsg_level"))
+			continue;
+
+		sock_err = (struct sock_extended_err *)CMSG_DATA(cm);
+
+		if (!ASSERT_EQ(sock_err->ee_origin, SO_EE_ORIGIN_ICMP,
+			       "sock_err_origin_icmp"))
+			return;
+		if (!ASSERT_EQ(sock_err->ee_type, ICMP_DEST_UNREACH,
+			       "sock_err_type_dest_unreach"))
+			return;
+		ASSERT_EQ(sock_err->ee_code, expected_code, "sock_err_code");
+	}
+}
+
+static void trigger_prog_read_icmp_errqueue(int *code)
+{
+	int srv_fd = -1, client_fd = -1;
+
+	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", SRV_PORT,
+			      TIMEOUT_MS);
+	if (!ASSERT_GE(srv_fd, 0, "start_server"))
+		return;
+
+	client_fd = connect_to_fd_nonblock(srv_fd);
+	if (!ASSERT_GE(client_fd, 0, "client_connect_nonblock")) {
+		close(srv_fd);
+		return;
+	}
+
+	/* Skip reading ICMP error queue if code is invalid */
+	if (*code >= 0 && *code <= NR_ICMP_UNREACH)
+		read_icmp_errqueue(client_fd, *code);
+
+	close(srv_fd);
+	close(client_fd);
+}
+
+void test_icmp_send_unreach_kfunc(void)
+{
+	struct icmp_send_unreach *skel;
+	int cgroup_fd = -1;
+	int *code;
+
+	skel = icmp_send_unreach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	cgroup_fd = test__join_cgroup("/icmp_send_unreach_cgroup");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	skel->links.egress =
+		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
+		goto cleanup;
+
+	code = &skel->bss->unreach_code;
+
+	for (*code = 0; *code <= NR_ICMP_UNREACH; (*code)++) {
+		/* The TCP stack reacts differently when asking for
+		 * fragmentation, let's ignore it for now.
+		 */
+		if (*code == ICMP_FRAG_NEEDED)
+			continue;
+
+		trigger_prog_read_icmp_errqueue(code);
+		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
+	}
+
+	/* Test an invalid code */
+	*code = -1;
+	trigger_prog_read_icmp_errqueue(code);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+cleanup:
+	icmp_send_unreach__destroy(skel);
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send_unreach.c b/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
new file mode 100644
index 000000000000..6fc5595f08aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define SERVER_PORT 54321
+/* 127.0.0.1 in network byte order */
+#define SERVER_IP 0x7F000001
+
+int unreach_code = 0;
+int kfunc_ret = -1;
+
+SEC("cgroup_skb/egress")
+int egress(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct iphdr *iph;
+	struct tcphdr *tcph;
+
+	iph = data;
+	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
+	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
+		return SK_PASS;
+
+	tcph = (void *)iph + iph->ihl * 4;
+	if ((void *)(tcph + 1) > data_end ||
+	    tcph->dest != bpf_htons(SERVER_PORT))
+		return SK_PASS;
+
+	kfunc_ret = bpf_icmp_send_unreach(skb, unreach_code);
+
+	return SK_DROP;
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
--
2.34.1

