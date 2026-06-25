Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3173AEF4E
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385415; cv=none; b=dgEydLK1xDXXja/pDIUYUTIAzJHWyqzxcSu1xqtCJQbAsH26ck+etGQ1Or9nohCafFGthvJrIF+61S3RqtirxVqMFuvhs1kRQgqPnRIwDTh0n6+P/ldUXjmqD0oCiaXsROX1t+tCtnoeCC2unqh2ATgA8KFtIVQSP6fV11jMzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385415; c=relaxed/simple;
	bh=9FQXYwGmt4FioywMikvgYSN1ECAwaMBHImy48XF5uQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uacCEpvWaahmcjeBPtKiafsnEQG0tQvTgZ61Or+EkqbgRSQtAWfOsCNKKRYb49dR74wyFPC79JYYB8NeZFRl1EB2S+AIr67gEHSfBySoT70dmjDfAEW70x8D55XpRfdWLaFRczZlFUV2+4VaOseincFDmTnrWcMEHOjAaGQA32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4H/GSPT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4H/GSPT"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46cbf263113so1575653f8f.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385409; x=1782990209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6GY6GroFbI4q5Pmm52+Yi7RBYaKaWgF3VvzfzdyKcY=;
        b=W4H/GSPT3I75EG7mI4u2sCNe8AUiz1/D3U7wE0Xemex7djtmwHGJ2pemhFsshPEimk
         YXb3OzTPk0RIC0kBDNMzLXhjklLSzM9BNHEzstdn+SW6is53grtkyb4/Rftw+S01T1J7
         pi5yj3Djf4r92CAS69FpA0hjorudnQeQkBgK/CJNUZ2hbvZ3QWXkzhQKaa+mbsFTnSoy
         fKQmUtDpCQH3ko3j0Vcl6A5TsxrKF3W+WlEcq2eg3+gP0mf8WehqUE2e6c1V9hQM11ua
         YeGJHbWSVuR2JJurwkK9GqtGjcbgmPKnNamPFZxOe1dAhCNPfK7kVpfGuIx+uehcrOTe
         kivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385409; x=1782990209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q6GY6GroFbI4q5Pmm52+Yi7RBYaKaWgF3VvzfzdyKcY=;
        b=kO0x1lzT+FGb/DC/MisQOUtdfg+f4LQDtX1/Tnrc0Ma3lRCHEic9uMrU0ZtLvy1U5j
         Up4UOlLokNThT/TH5401zObMFstSLvE98GM1fnadH0LSUpJcWzfJFeRilpouylYKK1i9
         kwqoYadlz7H2kScluT6E45ikfwX+4GOqyfbfwwKul68tj0ts5qTm+TgRbwhHzHl90H1c
         lURYDHVO3YXb3zf9+pTdjKyRwS212gxCF0Rsc9z01XruBamJ25bB3rwcGI5nwDOI3jcg
         pISJPQiSw+I1k1Qb3BbmHtPUBBdIIy4H550fAc47E2hSe6DVRo7bTh6a+71NOKj6gEyk
         46YA==
X-Gm-Message-State: AOJu0YwqDZr2RLYoHI53r3MF6WBRCf9FCsAALADrptPUFAJA4AzrP+fM
	YA9YNjCfwdCse8K1+yoAqPrFRthu8A7Qz1UjD6lzxD2/LodW6yt8yazpY1JUKe9sdKE=
X-Gm-Gg: AfdE7ckVnSRvx22+3zOFH8vVCzHBSYo1vTqVIzHmuuPMdLofYuqEe8iJju510HsnOOe
	tPNZR+CzwNNCwtH2iYO55nFw1sGL6cAZPEjnsQZnHGrqg2ITYBZeshp4TlLlqHsTjVoJYTivYrX
	UrJxkedbizRQUDVcDCxVy7vxLzI8Nqb6GsAr5C+dSvciFjau7N1BbTalPXPlox9SqKMiBdl73cd
	2gh2T8ONhD0aVC2IFEdHS+6vM1OXNjiXP7fhFOvyLwidUDN2Xqhu9NG0MR4Ry9pSYtxeHXqiP3j
	DA36BJdv1M05xD3obc+M4oNfhIPZFFgV3K+zJ1GVYC4vN6Yfuyl4dHEboNR/qpeppORWg7avlKf
	6IDSWvVkIb8xfPN0SeeGHwK/4Hjqi4yLKQtXVRFsB6Q91vx774d3jAdOt7Xs1rL9lhDvK3PGs5+
	gijDZ20sAtcy6VTdhM
X-Received: by 2002:a5d:5d83:0:b0:462:2636:2b39 with SMTP id ffacd0b85a97d-46dbf6db3eemr3088402f8f.14.1782385409332;
        Thu, 25 Jun 2026 04:03:29 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46c9ed7491esm11071917f8f.37.2026.06.25.04.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:03:29 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v10 2/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
Date: Thu, 25 Jun 2026 11:03:18 +0000
Message-Id: <20260625110321.28236-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625110321.28236-1-mahe.tardy@gmail.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
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

Reviewed-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 164 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c |  38 ++++
 2 files changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
new file mode 100644
index 000000000000..b8a98c90053e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -0,0 +1,164 @@
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
+#define KFUNC_RET_UNSET -1
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
+	struct sock_extended_err *sock_err;
+	char ctrl_buf[512];
+	struct msghdr msg = {
+		.msg_control = ctrl_buf,
+		.msg_controllen = sizeof(ctrl_buf),
+	};
+	struct pollfd pfd = {
+		.fd = sockfd,
+		.events = POLLERR,
+	};
+	struct cmsghdr *cm;
+	ssize_t n;
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
+		if (cm->cmsg_level != IPPROTO_IP || cm->cmsg_type != IP_RECVERR)
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
+		return;
+	}
+
+	ASSERT_FAIL("no IP_RECVERR control message found");
+}
+
+static bool valid_unreach_code(int code)
+{
+	if (code < 0)
+		return false;
+
+	return code <= NR_ICMP_UNREACH && code != ICMP_FRAG_NEEDED;
+}
+
+static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
+{
+	int srv_fd = -1, client_fd = -1;
+	int port;
+
+	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_MS);
+	if (!ASSERT_OK_FD(srv_fd, "start_server"))
+		return;
+
+	port = get_socket_local_port(srv_fd);
+	if (!ASSERT_GE(port, 0, "get_socket_local_port")) {
+		close(srv_fd);
+		return;
+	}
+
+	skel->bss->server_port = ntohs(port);
+	skel->bss->unreach_code = code;
+	skel->data->kfunc_ret = KFUNC_RET_UNSET;
+
+	client_fd = connect_to_fd_nonblock(srv_fd);
+	if (!ASSERT_OK_FD(client_fd, "client_connect_nonblock")) {
+		close(srv_fd);
+		return;
+	}
+
+	if (valid_unreach_code(code))
+		read_icmp_errqueue(client_fd, code);
+
+	close(client_fd);
+	close(srv_fd);
+}
+
+void test_icmp_send_unreach_cgroup(void)
+{
+	struct icmp_send *skel;
+	int cgroup_fd = -1;
+
+	skel = icmp_send__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	cgroup_fd = test__join_cgroup("/icmp_send_unreach_cgroup");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
+		goto cleanup;
+
+	skel->links.egress =
+		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
+		goto cleanup;
+
+	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
+		if (code == ICMP_FRAG_NEEDED)
+			continue;
+
+		trigger_prog_read_icmp_errqueue(skel, code);
+		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
+	}
+
+	/* Test invalid codes */
+	trigger_prog_read_icmp_errqueue(skel, -1);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+	trigger_prog_read_icmp_errqueue(skel, NR_ICMP_UNREACH + 1);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+	trigger_prog_read_icmp_errqueue(skel, ICMP_FRAG_NEEDED);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+cleanup:
+	icmp_send__destroy(skel);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
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

