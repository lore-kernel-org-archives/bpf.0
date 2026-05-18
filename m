Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC483E5592
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092675; cv=none; b=jO6jtYYfCf2Xk2bM9todltp3uvoWu10N73lPkViLfleB0WRKzI8awRLW9DP5W3ZjqDTSZVV2khqDGWNfsjMdGfHbjH/rxGfGcBeJhajQviMGU3CTvmkVjuSTMNyAcBRc44+73nDeSJtU4mAQh2wtPekEe+WON0JBn4z5lQ1SSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092675; c=relaxed/simple;
	bh=EHgHOpolMsJgH/MdJzYlHny2DKJzGcU3MGg/LHKX5ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmlhFa9SGFbbrCLB95nj3T55p03/Ru4r6Yyv0e+cijn17qEqMZeh7kYx/kWu0FRsdcbQeYe+U8vlD2mc0nFehEDKWSWAm6dqrmQa4xPwuuoEYKzfMqlo47Ph0JwAS94tMMRw0o4Rh8bt4gXS+6s/XL3IhIF7h03ljQxxxGLSA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwP93Hes; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwP93Hes"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-366375c4076so611353a91.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092672; x=1779697472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdHUXdjwsPh3UPR55DujBC6V4JfFvconq24bKSSPddg=;
        b=SwP93Hesd5/P/yy53oE2bFJn0hZHnoExuhk4V1FGeiP5VlBx5DPauDH7r3eD0Py6d3
         vETeNzIY6nHwcy7lAwuR1v/46TQ96foZOyzV9yGvAj6D3EMZX2xIgnL0phO2ndEsbxqA
         pW7bOvYazSu9xUutMyq78hDFD1JzhE3U7yQqPXwPTvsDm6uc+1HFwPoPyrDpEJZiV/m1
         5nJHu9+NiTDFOMV+Pfi3dnnr4cYGDhSkr6ecHrjDtwxDB4IYwa5pUeJiSUlkkGlsgm1c
         D+5rGTZQWux5ZV+HgmyYy9au+hr3ugFERP5/frj2enjlRO1sgz2SjfZZwoSn4QSa+x94
         vE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092672; x=1779697472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdHUXdjwsPh3UPR55DujBC6V4JfFvconq24bKSSPddg=;
        b=U0lzPDbXXMfCaSTwkU6fFedK5rokfT2jvmMgCdX0BEZMD7JHSKANzcSY5P6VbkVo3D
         U06EfrIDQBgCce7uqwl+azYs1F+2nbJ1YqoVqLPleIwDJuYq3IGvF36uB9SlzmY3kE1Y
         9ksqI+SMcgITbcs8iPMY4v6THOVHmmTqyVZzoN7b2ESY6cT5bAcSO69+YqDVJ/26vhEY
         wakmw3TcNr0NMZnOUuvcBIwo13SlCuEtTp97i4qyUlviP+ILiwrBQ1codtCnZRrWYwr/
         qCPkInBPb/7PItaHNnMIdh5GcfM4gcAnOACMuUJTfK8BHXm+WuL88c0qL4qYEgmIbbk3
         0YvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/SCQ4KTjZSSaJzFKiZwe0Cc0KBAMZm3LLQFhGgq6aPNR7w5/l8kNOFNQ4aI26Hb5uEcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0uY+toAFXsJ5vg0owcrBjRcQjpxQfAv73magrPxoxekCJOlO
	QwmvnPs9vUiPipWhQt5yowwEvVYtUmIIMfU0NpUBtInv0TGVFAogEs3N
X-Gm-Gg: Acq92OFn451KNyCJq207gQCAg2/05qo0defMGXtos4fbAY95HQ23G7wT5+dwFZYGgUs
	X9hohHcnMBxdBRrRQnhb8ECrFGKNnUyIq4uE8YJrzk2MTbBhyUEcsKnlrKJzO1T7m0uUZYvnbJW
	PqlogDrDDOXLOuvlD60laq50OgYzA6K2UZHq0+p6O7Y7rAg9G3GDpoSqc0s0OagYALt8iYmHdRy
	0uuVyGRo+gVBZkThPiPNnJJJzaQt73uSK2dqTdK7t3jYY76fHE++C2E+j6mEbnGtGEaxzjxRj41
	ABFtH/RDGVV6t2lJES+nsjMJzwcEt54Tg8HZIL9eypUUC77d43TvfMHUdZfKzOkusCzyx9pegQq
	WEz4LK1Fcy7TdR9FGD2RaeJphmrdzYRUNfak5EWUKqS4LvZO1XtyaVdFjT51fvbHhE4gdAkuywp
	qsh3kbKVlIrMyY2kf47r/FERFY6HLXw234UVXZ5+P1z1ihCexaZAugZck45qsr36zebJfHGBMey
	Xjas4MRIgC1M1CtVI76FTeH0VFm7A==
X-Received: by 2002:a17:90b:38cf:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-369519c6bcfmr13392257a91.5.1779092672232;
        Mon, 18 May 2026 01:24:32 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:31 -0700 (PDT)
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
Subject: [PATCH net-next 4/6] bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
Date: Mon, 18 May 2026 16:23:42 +0800
Message-Id: <20260518082344.96647-5-kerneljasonxing@gmail.com>
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

