Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66C3EAC68
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092686; cv=none; b=GJ778lW3If2F5+oyG/96ENWr1oEAlrDgnKhVvxvx+4VmiPIsqlzILMGREEM56Umhe/DaJepxrfb8pZmfgseS/Icf3BGEB5+OTKBgymGo2dQ2aQeB2R7UjjueeWzX66gCf3Oou7KZTlQPdIwLspEjajCsGqQaWHMm+nLYQUky0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092686; c=relaxed/simple;
	bh=YunP5JV5Tn6ACZbMb4h5mvr2CvedpcArCmq2xF3W3go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RMk5lwMEUlXAOederStxvf0xNtodPW3dIz4tpJx9PR1XoTE3Bn3PKoiG5s3y4YWlcIJ0zmUB9W2dPnyQYSLi8nF2zk4EwEMo0prdGgzfS1Ux8kTDgE7vpdGpj4UPiYDIq/NN89g7vKe8Ha2aSVxkVAkYEONyQv/3reFa8hc7HCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaIabLYr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaIabLYr"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36974217d4eso989685a91.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 01:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092685; x=1779697485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PIwPLcCeOC0NWb/rVd+8epgttcNSCL32RwHPIPB81w=;
        b=QaIabLYrqZeg6FVkfqG9VSwPTQ86P5dHX2hX1bXgyID7Ss/p2F3syIMv4+BeVtWO2l
         M7Os1YzEDgojVePNvrpQNVs0vD6a/lspebEDNWJBVN0bl32uSrLs5IPnhWmgWowLuOMG
         3AzF/8oKmCtrMpiO4IHnYmvlXE7UPiCq2HKHXuaiNwS6OXLOEuAaGwQ5ZjVoua5lwaJZ
         EuYhnbCjA/NYmO6MsLtSMzyip3x2IQ+b6QUcogb0A1LROnUKDgmwIeu+B5C18FSjSFmI
         7FJI8UShSR74WLPumo0/GN1JMn170RJZBAveYnWJ2nNpQ4YV16WyXs1+tTUXOyJP04LI
         jYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092685; x=1779697485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PIwPLcCeOC0NWb/rVd+8epgttcNSCL32RwHPIPB81w=;
        b=fNI6rLb+duPgzr0VplXrp/5AeP1Q/+xDDnp9evIxRWVB/4xJXqT5tp1YcVtq+7kvLf
         StMaUegQUi1xNhcxeEXVjCO1niO6gAs/6ir2WxiC4ibx2JYeao2qbXFxj+Ea5pHl7R5D
         l7WIYYhBnsA1WZP4SCeiLK5y8FUtNwE5/BEgOg2pc0WnNDNRJOyjh7ghMwnDZgRJJGpY
         5y6dtQd/BqexDcRe3Csi8fY++N3Zu54/gqbBDfpE7ujLXMHqAtYh3KKfmtPgRKFZwcbL
         cI706dMUv4QkylhS1i1QfQladRS2sI/Ek06z/yo2qBynTC8t+osfAbOrlOG7OuFUEfrx
         ke5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/1UvMJAu2FnEJvQxaU91sg0gyrLBVmly08GbQFhgiPOFD5VSAtL7iDo1bI9L9AXbo0IZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZyKmzI4Bwx/ftEY/MFbl1gOha6tjZobSLyzuBKZohPVlxj/kl
	TgK8vGgxAdffH5xax20CuLdGtS0MjNOYVrWFLVullzI503n/kkTHrKLJ
X-Gm-Gg: Acq92OEA5ZDsnUheSX1RDgC2PSVZ3kVff5JUps834/i+1C5SSJ/c4/U3U79fIW2+nX/
	lzCP4fdUjfYgysPPBNzQ3DcUWAKsTai72OQbFGPtmTZBFwebxhh2q4SISYnfxvMf4lGSrMj27kE
	QW+RPt38t33nEYGhIWlmzXOnZN3VrgkP5aXcncEXiEapleqxb5KeP/S4Hth8AD8CSIVURq7v84f
	AvTZbGU5xlbH3sAKIIxLoaSnMt3IQdNdVjCSiz8CIavhkRccXKaZ2J9XWL7QUyUWVHdpPc+Zq3M
	xuvZx/z0WrNtbdobBYCaDDtMrMFYBoryYlJm2n7OBwM5N9kANgDe5Wkf9wSxi0eT7hVO8OPqE64
	UFo3v7aND+8fvHXlQkNrk+VOd0NTCS0Rytctmk1kexhCOSdR5YgFZzgpTahnaEchSXhmIfob4mJ
	ZbH5xKXsId+gC3Rjpme2RUxl9o+RRQOjh4uLeTRV/h9kWUDORKT4CgnNzvnLrf2hDvoWSKkl2QI
	DMKRxK8qrX0tUvAUVd1p4u8xLe4qt8nj7YIUXfv
X-Received: by 2002:a17:90a:c42:b0:369:7421:6d2b with SMTP id 98e67ed59e1d1-3697421b9e8mr4789963a91.19.1779092684697;
        Mon, 18 May 2026 01:24:44 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 6/6] selftests/bpf: Add RX latency tests for bpf timestamping
Date: Mon, 18 May 2026 16:23:44 +0800
Message-Id: <20260518082344.96647-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The client sends data, and the server reads it via read(), which
triggers tcp_recvmsg() internally. And then the computation is done
in the BPF_SOCK_OPS_TSTAMP_RCV_CB callback. Extend test_tcp() to cover
the new BPF RX timestamping path.

One more crucial thing is to add usleep to allow the delay of workqueue
turning on global time record of each skb in recv path, or else the test
might fail due to no timestamp in the skb.

Verify that SO_TIMESTAMPING RX (software) and BPF RX timestamping can
work simultaneously on the same socket without conflict. When
enable_socket_timestamping is set, enable SOF_TIMESTAMPING_SOFTWARE |
SOF_TIMESTAMPING_RX_SOFTWARE on afd and use recvmsg() to verify the
SCM_TIMESTAMPING cmsg contains a valid software RX timestamp.

This exercises the mixed mode where all 4 timestamping paths (SO TX on
cfd, SO RX on afd, BPF TX on cfd, BPF RX on afd) run together. The
standalone mode (enable_socket_timestamping=false) keeps only BPF TX
and BPF RX active using read().

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 .../bpf/prog_tests/net_timestamping.c         | 69 ++++++++++++++++++-
 .../selftests/bpf/progs/net_timestamping.c    | 35 ++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
index dbfd87499b6b..3cc52b670e74 100644
--- a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
+++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
@@ -143,11 +143,45 @@ static void test_socket_timestamping(int fd)
 	SK_TS_ACK = 0;
 }
 
+static bool recv_verify_rx_timestamp(int fd, char *buf, int len)
+{
+	struct scm_timestamping *tss = NULL;
+	char ctrl[1024];
+	struct msghdr msg = {};
+	struct iovec iov;
+	struct cmsghdr *cm;
+	int ret;
+
+	iov.iov_base = buf;
+	iov.iov_len = len;
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = ctrl;
+	msg.msg_controllen = sizeof(ctrl);
+
+	ret = recvmsg(fd, &msg, 0);
+	if (!ASSERT_EQ(ret, len, "recvmsg from client"))
+		return false;
+
+	for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+		if (cm->cmsg_level == SOL_SOCKET &&
+		    cm->cmsg_type == SCM_TIMESTAMPING) {
+			tss = (void *)CMSG_DATA(cm);
+			break;
+		}
+	}
+
+	ASSERT_TRUE(tss != NULL, "SCM_TIMESTAMPING cmsg present");
+	ASSERT_TRUE(tss && (tss->ts[0].tv_sec || tss->ts[0].tv_nsec),
+		    "rx sw timestamp non-zero");
+	return true;
+}
+
 static void test_tcp(int family, bool enable_socket_timestamping)
 {
 	struct net_timestamping__bss *bss;
 	char buf[cfg_payload_len];
-	int sfd = -1, cfd = -1;
+	int sfd = -1, cfd = -1, afd = -1;
 	unsigned int sock_opt;
 	struct netns_obj *ns;
 	int cg_fd;
@@ -187,7 +221,27 @@ static void test_tcp(int family, bool enable_socket_timestamping)
 	if (!ASSERT_OK_FD(cfd, "connect_to_fd_server"))
 		goto out;
 
+	afd = accept(sfd, NULL, NULL);
+	if (!ASSERT_OK_FD(afd, "accept"))
+		goto out;
+
+	/* net_enable_timestamp() defers the static key update via
+	 * schedule_work() when CONFIG_JUMP_LABEL is set. Give the
+	 * workqueue a chance to run so that netstamp_needed_key is
+	 * active and skb->tstamp gets populated in the receive path.
+	 */
+	usleep(10000);
+
 	if (enable_socket_timestamping) {
+		unsigned int rx_opt;
+
+		rx_opt = SOF_TIMESTAMPING_SOFTWARE |
+			 SOF_TIMESTAMPING_RX_SOFTWARE;
+		ret = setsockopt(afd, SOL_SOCKET, SO_TIMESTAMPING,
+				 (char *)&rx_opt, sizeof(rx_opt));
+		if (!ASSERT_OK(ret, "setsockopt SO_TIMESTAMPING RX on afd"))
+			goto out;
+
 		sock_opt = SOF_TIMESTAMPING_SOFTWARE |
 			   SOF_TIMESTAMPING_OPT_ID |
 			   SOF_TIMESTAMPING_TX_SCHED |
@@ -207,6 +261,15 @@ static void test_tcp(int family, bool enable_socket_timestamping)
 	if (!ASSERT_EQ(ret, sizeof(buf), "send to server"))
 		goto out;
 
+	if (enable_socket_timestamping) {
+		if (!recv_verify_rx_timestamp(afd, buf, sizeof(buf)))
+			goto out;
+	} else {
+		ret = read(afd, buf, sizeof(buf));
+		if (!ASSERT_EQ(ret, sizeof(buf), "recv from client"))
+			goto out;
+	}
+
 	if (enable_socket_timestamping)
 		test_socket_timestamping(cfd);
 
@@ -215,8 +278,12 @@ static void test_tcp(int family, bool enable_socket_timestamping)
 	ASSERT_EQ(bss->nr_sched, 1, "nr_sched");
 	ASSERT_EQ(bss->nr_txsw, 1, "nr_txsw");
 	ASSERT_EQ(bss->nr_ack, 1, "nr_ack");
+	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
+	ASSERT_GE(bss->nr_rcv, 1, "nr_rcv");
 
 out:
+	if (afd >= 0)
+		close(afd);
 	if (sfd >= 0)
 		close(sfd);
 	if (cfd >= 0)
diff --git a/tools/testing/selftests/bpf/progs/net_timestamping.c b/tools/testing/selftests/bpf/progs/net_timestamping.c
index b4c2f0f2be11..4bbff09db55c 100644
--- a/tools/testing/selftests/bpf/progs/net_timestamping.c
+++ b/tools/testing/selftests/bpf/progs/net_timestamping.c
@@ -6,6 +6,8 @@
 #include "bpf_kfuncs.h"
 #include <errno.h>
 
+extern u64 bpf_ktime_get_real_ns(void) __ksym;
+
 __u32 monitored_pid = 0;
 
 int nr_active;
@@ -14,6 +16,7 @@ int nr_passive;
 int nr_sched;
 int nr_txsw;
 int nr_ack;
+int nr_rcv;
 
 struct sk_stg {
 	__u64 sendmsg_ns;	/* record ts when sendmsg is called */
@@ -65,6 +68,22 @@ static int bpf_test_sockopt(void *ctx, const struct sock *sk, int expected)
 	return 0;
 }
 
+static int bpf_test_rx_sockopt(void *ctx, const struct sock *sk, int expected)
+{
+	int tmp, new = SK_BPF_CB_RX_TIMESTAMPING;
+	int opt = SK_BPF_CB_FLAGS;
+	int level = SOL_SOCKET;
+
+	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)) != expected)
+		return 1;
+
+	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) != expected ||
+	    (!expected && tmp != new))
+		return 1;
+
+	return 0;
+}
+
 static bool bpf_test_access_sockopt(void *ctx, const struct sock *sk)
 {
 	if (bpf_test_sockopt(ctx, sk, -EOPNOTSUPP))
@@ -224,6 +243,9 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
 		nr_active += !bpf_test_sockopt(skops, sk, 0);
 		break;
+	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		nr_passive += !bpf_test_rx_sockopt(skops, sk, 0);
+		break;
 	case BPF_SOCK_OPS_TSTAMP_SENDMSG_CB:
 		if (bpf_test_delay(skops, sk))
 			nr_snd += 1;
@@ -240,6 +262,19 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 		if (bpf_test_delay(skops, sk))
 			nr_ack += 1;
 		break;
+	case BPF_SOCK_OPS_TSTAMP_RCV_CB: {
+		u64 sw_tstamp, now, delay;
+
+		sw_tstamp = (u64)skops->args[0] | ((u64)skops->args[1] << 32);
+		if (!sw_tstamp)
+			break;
+
+		now = bpf_ktime_get_real_ns();
+		delay = now - sw_tstamp;
+		if (delay < delay_tolerance_nsec)
+			nr_rcv += 1;
+		break;
+	}
 	}
 
 	return 1;
-- 
2.43.7

