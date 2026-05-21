Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8D3DC865
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371617; cv=none; b=TumBdryyjLk+Zmvotw6Cz9OJKgDfXDGSQXps+XU7hY8elcisSSnOTM/237cWjFqBaNneupcnA0mPPnsww4TxGBy+KldDjkF+PadIK8yc+UbuBsDcZn5kQwmysHKMjCg7NdYeKj2VuXo+9zzip2MzFZhydZDyMVoWcq5MNUbHq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371617; c=relaxed/simple;
	bh=tZtPPNL9Vrc2JmWRN3ooRrA5uBIMk5/gsLjd/4M/DXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GICW5choSyMUyzpxf8rGv8sz1Flt/J7GLUdUMxqhmehHJRJ3xvSnlXRxpH1+aON60uNmXJnoGplRZrv0T2M8pQqemKx5iYwCbq5qU62apVxEzc6DcVw++ULwVC11jFzWxBiolhvr2mGncWbd+mrU8kgbZNfHBI0zndLF4sO1+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmrfySTi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmrfySTi"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b4650d5f5cso24477365ad.0
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371615; x=1779976415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6QyqDaqjvExe25pt6hbxG1OXe8peYolpHaEpUnsVIc=;
        b=KmrfySTisbuQ+HOe0CeQh2yTv7RJoDOgcKsLgsauXV3FCdy4zVY/3O1PrPyOKW/iNo
         lrZ0flaw+QMvK4jwgJTt+ICFa1tTS3w+ky9KjE7OmqSEj5jwQ8YWkZb+Qa3fOcu2bupq
         UNpvYZW9zjMpk/vh65/kZwgHtJDRe6KZhURCcCwkfAQqEQNn50vpFfj4oTNcTlIKi2yq
         +41rjjrcuscVzle+hSvhMBxqM8m18x42dGQbjII6zx3pBqNx7cCEkYVZPhdBNtbhWzcG
         WlvVT3Skb0TCicf7CIsGDVJb6ycYPExNdA6J9XmFpvd6cXPLrikY/7dCZSJVzDwbAOLr
         /VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371615; x=1779976415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6QyqDaqjvExe25pt6hbxG1OXe8peYolpHaEpUnsVIc=;
        b=Woffw9cXRCD+cyEXOnmSpc0UCN8Rzp3+69qC1DNfSOnNOjbMuzDtQBumMM4ZiJ7zet
         Isr0LQH7nNDe33wn9y8l3Xt2NNWrlY5ZOjx2xZuzZ4ifQlEggrODMDfdyo9oHo5V7PNS
         QPnsxqmS2EA8haYs3aMJHxsVz5F6+Z3g7XVWGk58y8JDFzk/mQ+H/m4bUJCmUNqXBMrH
         vhUL+mMiMYXYYbH/uW/UGdLLcTcf45Vqfqu8S7My/PjtksWWGMJZv+jZwlhn3wI2ZamG
         RYWuqsUFPp6mlS4sg/qQzXdi5+WiT8iH0LUiKEXK3neLUYlKe7MdBujF1BFDG2LmakLz
         qxWg==
X-Forwarded-Encrypted: i=1; AFNElJ9nW7JUJttdFtOR7EGrZTCD7ZAEHpIi+VSySUIr1e/JlRKmmlWFWAkDvwKv0d7BhkdZ7ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0+IFJXirMRtr+sUCtHykHge5QnNCPBW/aQqQTw6YhXNhVfPI
	OlaJhi8kdqDmFqgRUe5CUH3B5mNzBvVsvtUj/eOX+YAPqOG7NHGFyse5
X-Gm-Gg: Acq92OEGRHMTzQZipVXgPi80Kpfo0t5x+ocBYqSE0vixDpKCzQNEcwgmvSpQFE/K1eB
	yHk+2mdHwFNMNmdrP7sqyWy6c3uo6zo1LdXohhq3gEgLMulXbiiTCmj9Hc22bvBiGyP7/0q70qr
	x/xq28MyPUXmtJrubwlXvr3Lwl3psYEQmaH0/8n9/F8Z8GKcq/Qgoibl5JPetIriirP7iVDsAcZ
	832gtke4jwIKuRYOfWe4XUQABXgnh7zW3TQfn8+Up2R3eAW8qsQSb7TNZb5tbqACU9ciSsBoiLg
	bgxKJDssVvWffUBh8tvRhtFp8baH/nSmnwfRhybB9YUhn3jtTY+jrit3lnC61uspzYpgF6N3Koi
	/wmjp94j4ghYm0wHHUOTXwVPfsNnj1ILOkld06EnmKxnHauiEWpxsV/ey3d0p/3rWG266G2u4se
	VrhqrfWCaabh3yPUY7iJ9xGDXExzWoO54gbEasq5cGeZKRpca29e731EjBd1h7u6jGq6mEM5s06
	GlhINqztqSwXtj0X1cqdcGpR/8qRUwwaVhWnD8M0w==
X-Received: by 2002:a17:903:2449:b0:2bd:606d:b339 with SMTP id d9443c01a7336-2bea3078c25mr31964385ad.21.1779371615508;
        Thu, 21 May 2026 06:53:35 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/6] bpf: support bpf_setsockopt for bpf timestamping rx feature
Date: Thu, 21 May 2026 21:52:41 +0800
Message-Id: <20260521135244.40869-4-kerneljasonxing@gmail.com>
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

Add SK_BPF_CB_RX_TIMESTAMPING callback flag to enable RX timestamping
via bpf_setsockopt(SK_BPF_CB_FLAGS).

Add SOCK_BPF_TIMESTAMPING_RX into enum sock_flags that is used as
centralized management of net_enable/disable_timestamp. Note that only
one of them (timestamp, so_timestamping and bpf timestamping rx) can
enable and disable the global time record of skbs.

In addition, include SOCK_BPF_TIMESTAMPING_RX in SK_FLAGS_TIMESTAMP so
that __sk_destruct() calling sock_disable_timestamp() to thoroughly turn
off the global time record.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h       | 5 ++++-
 include/uapi/linux/bpf.h | 5 +++--
 net/core/filter.c        | 8 ++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index a579d5b09207..cf0e82e46482 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1022,9 +1022,12 @@ enum sock_flags {
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
 	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
 	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
+	SOCK_BPF_TIMESTAMPING_RX, /* BPF RX timestamping enabled */
 };
 
-#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
+#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | \
+			    (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
+			    (1UL << SOCK_BPF_TIMESTAMPING_RX))
 /*
  * The highest bit of sk_tsflags is reserved for kernel-internal
  * SOCKCM_FLAG_TS_OPT_ID. There is a check in core/sock.c to control that
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..1e09b5cd7a39 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7029,8 +7029,9 @@ enum {
 
 enum {
 	SK_BPF_CB_TX_TIMESTAMPING	= 1<<0,
-	SK_BPF_CB_MASK			= (SK_BPF_CB_TX_TIMESTAMPING - 1) |
-					   SK_BPF_CB_TX_TIMESTAMPING
+	SK_BPF_CB_RX_TIMESTAMPING	= 1<<1,
+	SK_BPF_CB_MASK			= (SK_BPF_CB_RX_TIMESTAMPING - 1) |
+					   SK_BPF_CB_RX_TIMESTAMPING
 };
 
 /* List of known BPF sock_ops operators.
diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..08ad102f204e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5304,6 +5304,14 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
 	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
 		return -EINVAL;
 
+	if ((sk_bpf_cb_flags ^ sk->sk_bpf_cb_flags) & SK_BPF_CB_RX_TIMESTAMPING) {
+		if (sk_bpf_cb_flags & SK_BPF_CB_RX_TIMESTAMPING)
+			sock_enable_timestamp(sk, SOCK_BPF_TIMESTAMPING_RX);
+		else
+			sock_disable_timestamp(sk,
+					       (1UL << SOCK_BPF_TIMESTAMPING_RX));
+	}
+
 	sk->sk_bpf_cb_flags = sk_bpf_cb_flags;
 
 	return 0;
-- 
2.43.7

