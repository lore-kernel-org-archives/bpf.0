Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01037F019
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874489; cv=none; b=kqyL5g5J/cOphtYPxlIAm44dnIBBktgdr2cBk0S2NssJNEqb2UFMHgMAMTiXwQq8LEEx1diyKtA1K7OWRWUXuZ5hlmGmXWghn2cy2bh6Meraric91RVrkCA2RnawUlNIGaliUpfgZ+S4x+C6m1BdRdU5nO6II7rsxHXpzeLtZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874489; c=relaxed/simple;
	bh=4EgKrLxF4WPJNIfHF5MUJNpLvsmT4mqXcW+SLVaIF3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/mW9n/6RicfaXNayG00GRKHKab7PLiRiYN5OscO3os5mtx6XEnt3rnAMIoaeq2MlXWFoomZrTdshQmxu7UqUC0XXWsriwb6vIsXJ+kZygz1zTkyaB/ZqapfPcAtNji+JLi409WAEYIbbbTkmLeeMtKhdnaFPEbB0cDnnYI9Jt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I584yRWp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I584yRWp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso2220985e9.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874479; x=1779479279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkRXjPWiRTaGPqrUkjG1pn63cPwqeHFEoZeFTf5nQFo=;
        b=I584yRWp27LbZaK2EUn1FlOg1U1gCS1ZHvcpsYIydINmNhT3TozVdL/MCrN23GqVzT
         7ydAdyRBoMRDGJXmbE8q/lq2KGDr69GWTcIBPKDcckPO2MXVHTHLH76YvMqkhXX0ibBz
         DXfH84+Yu9knU0RIE8ciB+2aAEDDsK6xqNgaPDdzQ14P2vRpTzJfgXvOOYiAYxvDtFWx
         RYYHwpjarjNHo7BGOLgFJZaS2QfGmjBnNsXOHUdEFLwgb4apVpV8zO05F61TEcYkCMR0
         47+csdtRvmEGOtbiJdxnbFKB8c4za7gf8TGvxqGbxWkAdZ2TItG6YdxyOu+/TbvKWBEt
         f54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874479; x=1779479279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkRXjPWiRTaGPqrUkjG1pn63cPwqeHFEoZeFTf5nQFo=;
        b=NjjYbYHSrOi9f6at9MmLD4/GaRl6ANmw9Ak6GjKyLosu4e5uyjgpcYeEqx2kdgEen5
         TiSwZ+JI+hI+Qo2gRk1yCK//HyGu0RpzAEzvYM6a4VTsPnDYJ4lPEK31gB4SJyp57UFy
         pCDwyr3C8HDROrqVIR5mhzKaVx32f/Spnh68w+6mIc6PG1NJVavw+fomX/fP4kvvoU1z
         LkAhrh0riy7XgPSp3+pdP51PHR12+Q0ubcnhv1qUUdr0I01q6ZvatTxY/UmUpp+HM1+B
         nJUmL/RP76m1+KUq5GcOIT1DZwgU+buvFKouoDCrukv7HECcTzHVSZ3pPBALq1NAwYQ3
         0UJQ==
X-Gm-Message-State: AOJu0Yy7USxl70zCk2Evn/IUa9deZdmQDNyG7B5dSM/9j/7FrPJFtz/P
	RlZIg370Cb9hbl5sFvIQLzzG5RfhZCiJBzzelXgJ6dzjlwsFi12hthO2V9J9S4bX
X-Gm-Gg: Acq92OGGG6IWY7C53ETJTuNXoXEYQeD0CkuzV0oS3qwQq35mDfZKNU0sRxRg2Lvuufd
	V0At1mWY4pN0bH5lsW/OlpV2SWREy5p4P3lb9ctaNJ3A7yqAGM6gwtu+YSQR5vkbhQzLxFy2u94
	nWoGqgvC+E1AMg023LPJzxEYKxc1pRYg+KT0w5sqQHAnjsfc6lwgLPY6p+gPAoZnsTMKhmxus9/
	ro/cIfsGf5Skzp9tSol3A4fRfmlKeFA7uCkUxA+59oz7W1D8nCTaquxQTxaCZmPT5qLa5xsi+BN
	fSkyGXx65I8DrcRuNczPthYggx7nwhgtKkTwP9em4T2bzrD4B6yPwfgxNM5FHH/FjHQpkHgsy/H
	9d5w6VryCUx7TAm1H+zFruGpKMKntpFtTZxUfqMXj+TH2JDLlOPojCE9ZG0zNuJiW7h1Cxf6lPU
	E4ejMEY0QW5/iUvRzrKRNALt5Nwh2IKneOXkmFbg==
X-Received: by 2002:a05:600c:1389:b0:48f:de5a:4c1 with SMTP id 5b1f17b1804b1-48fe60e4dd4mr76062845e9.5.1778874479326;
        Fri, 15 May 2026 12:47:59 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm77509945e9.2.2026.05.15.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 12:47:58 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 2/4] selftests/bpf: add bpf_icmp_send kfunc tests
Date: Fri, 15 May 2026 19:47:44 +0000
Message-Id: <20260515194746.50920-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515194746.50920-1-mahe.tardy@gmail.com>
References: <20260515194746.50920-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test opens a server and client, enters a new cgroup, attach a
cgroup_skb program on egress and calls the bpf_icmp_send function from
the client egress so that an ICMP unreach control message is sent back
to the client. It then fetches the message from the error queue to
confirm the correct ICMP unreach code has been sent.

Note that, for the client, we have to connect in non-blocking mode to
let the test execute faster. Otherwise, we need to wait for the TCP
three-way handshake to timeout in the kernel before reading the errno.

Also note that we don't set IP_RECVERR on the socket in
connect_to_fd_nonblock since the error will be transferred anyway in our
test because the connection is rejected at the beginning of the TCP
handshake. See in net/ipv4/tcp_ipv4.c:tcp_v4_err for more details.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 149 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c |  38 +++++
 2 files changed, 187 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
new file mode 100644
index 000000000000..b98c0312adad
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <linux/errqueue.h>
+#include <poll.h>
+#include "icmp_send.skel.h"
+
+#define TIMEOUT_MS 1000
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
+	struct pollfd pfd = {
+		.fd = sockfd,
+		.events = POLLERR,
+	};
+
+	if (!ASSERT_GE(poll(&pfd, 1, TIMEOUT_MS), 1, "poll_errqueue"))
+		return;
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
+		if (cm->cmsg_level != IPPROTO_IP ||
+		    cm->cmsg_type != IP_RECVERR)
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
+static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
+					    int code)
+{
+	int srv_fd = -1, client_fd = -1;
+	struct sockaddr_in addr;
+	socklen_t len = sizeof(addr);
+
+	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,
+			      TIMEOUT_MS);
+	if (!ASSERT_GE(srv_fd, 0, "start_server"))
+		return;
+
+	if (getsockname(srv_fd, (struct sockaddr *)&addr, &len)) {
+		close(srv_fd);
+		return;
+	}
+	skel->bss->server_port = ntohs(addr.sin_port);
+	skel->bss->unreach_code = code;
+
+	client_fd = connect_to_fd_nonblock(srv_fd);
+	if (!ASSERT_GE(client_fd, 0, "client_connect_nonblock")) {
+		close(srv_fd);
+		return;
+	}
+
+	/* Skip reading ICMP error queue if code is invalid */
+	if (code >= 0 && code <= NR_ICMP_UNREACH)
+		read_icmp_errqueue(client_fd, code);
+
+	close(client_fd);
+	close(srv_fd);
+}
+
+void test_icmp_send_unreach(void)
+{
+	struct icmp_send *skel;
+	int cgroup_fd = -1;
+
+	skel = icmp_send__open_and_load();
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
+	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
+		/* The TCP stack reacts differently when asking for
+		 * fragmentation, let's ignore it for now.
+		 */
+		if (code == ICMP_FRAG_NEEDED)
+			continue;
+
+		trigger_prog_read_icmp_errqueue(skel, code);
+		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
+	}
+
+	/* Test an invalid code */
+	trigger_prog_read_icmp_errqueue(skel, -1);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+cleanup:
+	icmp_send__destroy(skel);
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
new file mode 100644
index 000000000000..6d0be0a9afe1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+/* 127.0.0.1 in host byte order */
+#define SERVER_IP 0x7F000001
+
+#define ICMP_DEST_UNREACH 3
+
+__u16 server_port = 0;
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
+	    tcph->dest != bpf_htons(server_port))
+		return SK_PASS;
+
+	kfunc_ret = bpf_icmp_send(skb, ICMP_DEST_UNREACH, unreach_code);
+
+	return SK_DROP;
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
--
2.34.1

