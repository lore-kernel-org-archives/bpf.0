Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19B242D67
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327380; cv=none; b=EnHJkLLONNe2xQYIIbcRSW2JVAJYc1AlN8jAIQdPLRsjB3c1br13oOJtFf7JUw0y82vU6935BpFFsZ5V4XYTUYigFyE7j4wi4WnNUIP0MR6KVeWKRfwSwaJE/0OooLz+qdbnPnUTmMc29xGBMaL2DqHW7rqx4ny8YrqgJlgMqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327380; c=relaxed/simple;
	bh=9FQXYwGmt4FioywMikvgYSN1ECAwaMBHImy48XF5uQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BtUTVwXISdAhUZx6ih50Ot1JZzPZrX7bhQoIztXIwxZoefGCxbQBWNv85+AixtLucmtpDkumDTUllauPfN80aepoRzn7/fQSlTTWIwDeHKjs1mPohH8APEqKfmtMoqBb4SAg0JSsLz5q6yk2hgLfuLxiMPJo7Igot69En7WpBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0dBG3jI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0dBG3jI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49222b6e871so8978405e9.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782327377; x=1782932177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6GY6GroFbI4q5Pmm52+Yi7RBYaKaWgF3VvzfzdyKcY=;
        b=G0dBG3jIPN513c42y0B8NQvye9fXoBPxTYAonLrv7Z68hX2rzWkgENKlvHthBbmy8d
         DUNeeEDsaK0M0/xiL2JRtdV0bNW4vXIKFNufEi248+TJFKjv9kBgz1gTJntjpfngvk3P
         D5XCUz3xo87g8vqPRABADBbcqMk6s7oFYukyt0QqP7qBMhibT+aAtQHSiWmWQWoWUZcE
         /U4172hxox3/rg8ZlcjZj/IQCR8XdmaQatdokEgLbRGBsNloRygPTUeTEJbWEEALA0mn
         ASztlgWuBM64cFowGH5ZpPo4sdiOmfAFF7r+7it87dg/Z9CoPt9QYS85qGue8Xx4jDGX
         Xc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327377; x=1782932177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q6GY6GroFbI4q5Pmm52+Yi7RBYaKaWgF3VvzfzdyKcY=;
        b=gohx4tRsgQkG7Srhr8C2W744RnkdYqepKCfg+v7DUtugMlVYvE9124qXljkyvWnI7x
         teEtMUOAAhZtFbvjcj3TDfY+P+fMtIB8pt833eTasw2VIFpMZAkaNEEY7rkQClHxUqAN
         BzaOYQHe5ZKtzlmlNu9CJlcOd99oRYN2XfdoTc+5Pjuqzq0FalnOQIX2L3o8s6T5sNN3
         lR+Rl6kJu/UozTFBDuUJh4W3bEE60fz+ho6+/RIJTHvgjeTSaNuOT0Ux0JS5anJBk5xW
         OTThI8Z9brgR9oNLMO4q1iYP1UEDyFD2s66Wbm2GoU/Sa1HqUCzViYSe3rwc+IJgB7/C
         FYiQ==
X-Gm-Message-State: AOJu0YypBqxdXBA5iqbDxqFziUfjaW74IBrTZMxDcAULm05LmYtsvLCv
	5enmNkw9oXO571rRUVjtkn6XxPuBsxvXInAbhuKmr1fRrg2Bd+euE42qCi2TZfXw
X-Gm-Gg: AfdE7ckCcfCx70ggM+57Vpb9bn2po3EFjaExr4/uVLArF/2ijqDegWTYGQwxDpx131W
	NgHwPr+hYFpuWRquMXwpeUKd/GgR/7lX9z4qCplK8hzQ0/YcNrJIJ4B027K5ojlGIVAfFFPThQY
	Ou6Gxpmprxo4FNgaUq//Bw6L6LfSehrgFHVPEXh9PfA89+ZqjvfAw5DqXoXic7u1+GhWvDbrIO/
	kWz2jMKxcdPRdqnBjDz2buLBhXkAk+9zTYk+DsUFZQJ43WDxgKLpNApYTr0qbyi0ADn6Z/F5S4X
	psDOpy0Ke9BR5Kr6Dny/uX/UDyyHW7Dt32UG7RkQFNA5ZByqNPOiDk+i9bREUkNx/aYAbefsatU
	p5c6zs6JIT2+qkmCWQNDrjG20kNyfmnMne+HbbveAzQGGCzLd7Mt22LseFrKVB1pD+XFgWrTRqZ
	bvbfkiVS5T9qy6dwPp
X-Received: by 2002:a05:600c:8b71:b0:492:59a0:4a65 with SMTP id 5b1f17b1804b1-4925b3802a0mr134505025e9.27.1782327376963;
        Wed, 24 Jun 2026 11:56:16 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4926417f0c7sm9847805e9.14.2026.06.24.11.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:56:16 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v9 2/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
Date: Wed, 24 Jun 2026 18:55:51 +0000
Message-Id: <20260624185554.362555-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624185554.362555-1-mahe.tardy@gmail.com>
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
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

