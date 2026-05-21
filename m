Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CBC3E8C46
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371623; cv=none; b=uIa2sXq9KA80ntvZHaqVIihZyK3+ZlAtuxvRq3dqrFJ2L5HaiZYUKDSBpalDEkyFS6b0BbrRhz2RJFPRexvInCHj0TWUTukxvUvMLkVu6VAdXH4AcRbyM9zaEOvcZnCTxWaR56MZk24aQQ+WvLRvbm5YMHTSPkNSMXMJHykUaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371623; c=relaxed/simple;
	bh=EHgHOpolMsJgH/MdJzYlHny2DKJzGcU3MGg/LHKX5ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qp1xYz91AyFmPzDUorv2Z1k0ca4M4C8OEeYsEXGg/ijXdYL7Tl7/lywhaYzxQXJHbterKmLkeDrhjiigZjFaMhzYQ7jqAfiGbGC0yID85SXE7+g78Xs/n22p1+Wcew+mIBiKQVjJEhiULw4nmc0UTHqzhkvDNXxQm+EEYsSnwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTj/xJu9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTj/xJu9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bc85eda6b6so30036615ad.1
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371622; x=1779976422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdHUXdjwsPh3UPR55DujBC6V4JfFvconq24bKSSPddg=;
        b=dTj/xJu9pDixU3/HHjtsywG4L3c+nJUst7VLAiFmTWov+3J1lypV07kh4YJfseUgdZ
         D0B3hl45qCHK7WQuY2aEL0StboODJT6Z2qPkmkzDs2FP4gfywmvo4BLkUXbG38jqYZqk
         vBggFJjaPidBEqvcvuqkiP7lMc0IvdHbttO97DdDXpa1okj3DWhMg6x4UwP6JUsI0YeY
         aJLAEt3dQmyFjFhyRR167E4kInUdoMWD9hNGdPUz+j3C8h3NLGtITCs2hQUKOifmNIyL
         CGKn28gyDLVymhn3IQI0HvdB9hDpzEwpSR3kWBg0nvEK5HdMz4PtQH5tf8e4VmZtBjzZ
         XwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371622; x=1779976422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdHUXdjwsPh3UPR55DujBC6V4JfFvconq24bKSSPddg=;
        b=gYYanZlCQt4e773v69MBoRxVLNUGN8622tVFaWgBKpqHfQZ6EKIyZCYPo3pJhXLC01
         0BUGlWq9UGFNVP7QGQmcTnIC2+g6l3ymgyc1xRUBXA/xOotzGibgSnwQntW6GGFbxlMa
         vpFQgpnp1BnLk3uQA2kOqSFTFYEO+RXvo7zECbn0/RZo5j1kCsVh2mTABxrdJD1bhkIR
         bfsqMT/Q2w7bhpjqV5lTqAcf8FvQi8kU5nRv8S2+yynlmFaTMzWKJl0SY6SfB7W1RN7m
         LNG8C0nFnda0QYkI+fIl5KTPpCCJd+u9pVOLL3+gUL8R5X9wXQ7UjxKn7jkuq/aMBCCW
         OjSw==
X-Forwarded-Encrypted: i=1; AFNElJ8KXjiWAZheWgjMeeShTRSy7cGJMOD/Zalx3pbIrLK2zLRr9XgVHQREyfGv9tgZK5UoDz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyYsrwSIS1hGvNphTG82IVcNKq+6IQvNoL8UrfYEb3sSt592m
	0H6cFMn5vndJOwxWBZXsfjZqdrI+NxwygaSW2V0Ce+dnkQzVgDaS2vqZ0+E5EcOT6baq4w==
X-Gm-Gg: Acq92OHSZqQq06+ObAeu0VT+W7OVBhv97HH0dDIxVIIAp0LuyjAUQEqSizfLElkNlCN
	ugn1sDt0B7sg9luToqAb1ZSRvScsrhJptViQlsf2BfigQcMXYpLs35CHf1uxMcLB3xcBAuYL815
	7YBLq1GHWO8RSCA3/i+721TfINmjTnMH7zGAUnR9OBKNkoYsEC0DFL71P4jmtxRryQg7sfvtL/c
	09bYR03BDSSVn3gyAOK2fV4X51H/40YbVtOzcTy5LOMSlbRgEvbHp7dh//HiTJgXv3R4sOqHVfO
	QuMJHbM4a9gI54I1yk+f25/7V7pKI/NqU4HRHa32evyjsXGdopMTVm6yQb4Kt8bKruN54sIMzEC
	03Fx6y3WathRd8hGuUlroPWWi+yUBEA2n4piJOzTsScTp4ON5bns+3K02Sc0qmWob1M3wEg5uCo
	yBTp3cH8D0Qf4xrrtYuF2W1ZXbl2kPowCmwgU8kFX05kmZPCd6NeH4CJdqVvgnffCaUcw8yB/ax
	MrdpXfB6vplyg5+z94EKAB1iQf8NP4=
X-Received: by 2002:a17:902:d4c9:b0:2ba:7610:3f21 with SMTP id d9443c01a7336-2bea30a645emr30750305ad.5.1779371621598;
        Thu, 21 May 2026 06:53:41 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:40 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/6] bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
Date: Thu, 21 May 2026 21:52:42 +0800
Message-Id: <20260521135244.40869-5-kerneljasonxing@gmail.com>
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

This is the prep patch adding BPF_SOCK_OPS_TSTAMP_RCV_CB cb and the rx
tunnel to allow kernel to report timestamps.

It's possible to have both software and hardware timestamps in the last
skb from this recv syscall, so the tunnel bpf_skops_rx_timestamping()
supports four slots to record and report.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h             |  6 ++++++
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/sock.c                | 18 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 4 files changed, 34 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index cf0e82e46482..14945cd69c84 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3138,10 +3138,16 @@ int sock_set_timestamping(struct sock *sk, int optname,
 
 #if defined(CONFIG_CGROUP_BPF)
 void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
+void bpf_skops_rx_timestamping(struct sock *sk,
+			       struct scm_timestamping_internal *tss, int op);
 #else
 static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
 {
 }
+static inline void bpf_skops_rx_timestamping(struct sock *sk,
+					     struct scm_timestamping_internal *tss, int op)
+{
+}
 #endif
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1e09b5cd7a39..113a2a72cbf4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7169,6 +7169,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_TSTAMP_RCV_CB,	/* Called in tcp_recvmsg() to record
+					 * sw/hw timestamp of the last skb
+					 * after receiving all the data when
+					 * SK_BPF_CB_RX_TIMESTAMPING is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/sock.c b/net/core/sock.c
index f3d78da3aeba..81a234e10fd3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -952,6 +952,24 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
 	bpf_skops_init_skb(&sock_ops, skb, 0);
 	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
 }
+
+void bpf_skops_rx_timestamping(struct sock *sk,
+			       struct scm_timestamping_internal *tss, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+	u64 sw_tstamp = ktime_to_ns(tss->ts[0]);
+	u64 hw_tstamp = ktime_to_ns(tss->ts[2]);
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = op;
+	sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	sock_ops.args[0] = (u32)sw_tstamp;
+	sock_ops.args[1] = (u32)(sw_tstamp >> 32);
+	sock_ops.args[2] = (u32)hw_tstamp;
+	sock_ops.args[3] = (u32)(hw_tstamp >> 32);
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
 #endif
 
 void sock_set_keepalive(struct sock *sk)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 677be9a47347..483ff4497d51 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7168,6 +7168,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_TSTAMP_RCV_CB,	/* Called in tcp_recvmsg() to record
+					 * sw/hw timestamp of the last skb
+					 * after receiving all the data when
+					 * SK_BPF_CB_RX_TIMESTAMPING is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.7

