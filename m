Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0A2D9484
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371636; cv=none; b=NYVCegtWrUcJYyEDiVf2o1FdTGuUxgox7gsXejBu11IP5DMesYoVe+LUPCCgb2Yj4eP1qC4K413fyfcU6D05GRjReNqbbNRcMYOs6vbOW5ox8o46R6vSMJr7lOJwbORAr+OfokMUHpjEWQIDTBjbJsQQI4h9rU/C8useqQCsCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371636; c=relaxed/simple;
	bh=4bFsDAM12mrZKSw4R78Ox7JfFMnkz8xQoZAOT6nLvY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cpt+fJV/ipgzojKXjpMmnkKx+Ck9k9mkIW65Yv8iL8B8g8/xFS9wldBxYxmaH2NEupwbWPDPttt+SPF7ykc+cpx7TsHGo6V9j2YJ2n0ipMjFitZOXhhKsSC7jAe3YIH/fK3MpLdHeSe+fyhI/suDJF4Lmfc9E51GF1JNTXAjZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr7fPMui; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr7fPMui"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bccb978bd9so42520905ad.0
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371634; x=1779976434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk22UbcVBp7SP3bZskwyIN7wzI3P1oiov9XU2EHkG+k=;
        b=Sr7fPMui6mDuQ9xTCToHl0N9L9VeGd+oraTmVm0+AISY9hix7q8MVLngEtpvFUiZEK
         wZjS3a+kG2oN4opwAEzmwUkDOMw+mVGtfZ1lh0MSUNw4lNpPJfobVax8T2ZL+45MbhrI
         CkXRSrJ8Kzzl0SxMni3T6XFnuhxh+QPlgo/2vNWhcUrRAOOi1sn2sngNyNyFFNVWxUTN
         tZ1NyvQn/GHtjTJQzSNJ5FevHCLwP2YuvjEET+7K4CxLfQGUVp2R8qM9rbVlmy+qzMZR
         ISuPzT/iJu8yBE5dS37ZRo/Pc2sH4FtfTzJ0Ih9dZhicPNHW08f7cjA2YgBuDO4LoYGi
         QJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371634; x=1779976434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xk22UbcVBp7SP3bZskwyIN7wzI3P1oiov9XU2EHkG+k=;
        b=F1aoAMGIZd8kH01tYKRsNT0Spz0wGq5G6VKxRK60knUOIfCj3nWpQP/Y3kmQJYEEzn
         DNYukR27cEyXNB40SuIpmWn2E3kkYmz7U7Lx7piyU4gA3/k+lED6I2OiUlX0E09mLadq
         lnzh6tYj7t1MJaOoOoIOSW5MciVH3yaEbDEpvRQ17+AyELgEflbVVly0DROMvZfGRuFm
         Q1Ojv3zfRMeIfNBLr3Jv4S+KHxYkuCmlG0jBxtx8ZM7rU9UQNGdRSpprW2yju2VcmOfh
         rPkr880O66mS7vsg9oiBX5O6MfQ9CwUvwlQHuzh0bB/Pme9bNFyxk7KcokphqbBG9LxY
         3IVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mcYkS+4doDNc9NpWP3gsdpv/RsnmtDfyToRlpQVuW+9MTn7A7gqpwNWFh8Njc58vUPqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyiCSHbNYA5D+/iOTgChUiwgielSi97ZLf8hntBleC8MyG7dX
	nxmGDoMRrGysRj7X/W9QXmbgMWbbE4HzqkJW+Jrj94z39skHuqf/14ba
X-Gm-Gg: Acq92OFuQxnNRBfeNwoSncnULzHxEDHajqEk5c5u939Ao21y8v7lAUbVaNPlatbHRli
	jTSPnVRQd2GoNhgw/xSBGu2iC9iUQThLY7l9XfZeNPHWm4dGF7NQuhyPr0rtZoATXv7YM4F1ufZ
	wHSJChngA28f7umUzzTqBqtnACPRj9LK28xNil1StX5I/Qe22sErsEwUxx4Pigt17zy3jE0FoaS
	onfoDixDXJYbKCz5YR7dMy8CQnFxhcTs0t/xhmn7L9GUS4Bd9sxcCPFAQ2NDt63Y00KmgL+Tfh+
	8xscPJ79I3AjgtHRjvW6zKeNeqwYmo17oG+qNQEXXJvpAjMic0z50+Iq6aXWhpaS4ZTprAr2qNx
	VQx5X4JYMZoQVrO9a4VnfUegZa66MjeyHU0mteQsAqrErJRNWESDwYXfguN/2ZSgumHcLDMvDzl
	FnSnzcDCvCoCzR1D0kxPMTBJs9Ila8SmeBTdbSeSLh1yPgAYQ6q9UR0UW65+uX/ZTja0YPQI3Gz
	IFOEYMcm8NMmJ+qCCou4gHMA80VbzM=
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bea22b759amr28559035ad.20.1779371633985;
        Thu, 21 May 2026 06:53:53 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:53 -0700 (PDT)
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
Subject: [PATCH net-next v2 6/6] selftests/bpf: Add RX latency tests for bpf timestamping
Date: Thu, 21 May 2026 21:52:44 +0800
Message-Id: <20260521135244.40869-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
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
 .../bpf/prog_tests/net_timestamping.c         | 71 ++++++++++++++++++-
 .../selftests/bpf/progs/net_timestamping.c    | 35 +++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
index dbfd87499b6b..e3fe850e4cc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
+++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
@@ -143,11 +143,47 @@ static void test_socket_timestamping(int fd)
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
+	if (!ASSERT_TRUE(tss != NULL, "SCM_TIMESTAMPING cmsg present") ||
+	    !ASSERT_TRUE(tss->ts[0].tv_sec || tss->ts[0].tv_nsec, "rx sw
+			 timestamp non-zero"))
+		return false;
+
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
@@ -187,7 +223,27 @@ static void test_tcp(int family, bool enable_socket_timestamping)
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
@@ -207,6 +263,15 @@ static void test_tcp(int family, bool enable_socket_timestamping)
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
 
@@ -215,8 +280,12 @@ static void test_tcp(int family, bool enable_socket_timestamping)
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

