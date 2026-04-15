Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F23CE48A
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241636; cv=none; b=npAsuEB97sMLbwufv3esAn5BcQK45MWEIylgXvc8I9cibztVggubzeiLe7aCVucnYHH4VG4HdjBGLhTHF/CNcks4+MQFHzXsdXVcW2DvHvhV88D8TAVsDnlungs29CkdrIbOUqHJZ1fDwM1SqT2SHKt2/I51vmqoNrStt0vlSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241636; c=relaxed/simple;
	bh=+m/WLK9X5plutyFPjpd3AQb1360KbNZd5kcMYtPDi+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnT5MEWQaW2cO8yqmsbIsS3uoqmNMIaj+3Oa/qyzSnSjXPD0IDm0vCp4bOi6GHudsB9+5/fKtk6ie947xmar1xZrFD/h9cBvgWMFxrXC+Gl5y+Hsn9vKMC3WG4UTGaUuVzgrhehKBCJjrUAAvWRMidRWj1zAW/JlZH8n3xvuZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i32lwl+f; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i32lwl+f"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so2341381a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241635; x=1776846435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ16P9ql425c7rop6LMTVQazhXI3kn8UEVCSS+AQW4A=;
        b=i32lwl+foT3R6hVy5eOMhRm0dr6YZpghTxdfJ7d8j4NnW4YL5mLTCB6uii96EWCSEC
         soJzZCTY7AP9HoXoPWiVMVaI+xXozpvcT8/sWhVT0zlcM44LrIpyMHlnBkAIwkcHyn3z
         fNdSWF1/XLfiChYw9g91ELU3nz1g+nSwTIllyPiJX0VQ+V0RqruXab2JtWhEoAjTZBzI
         ZTg5JVJqYd1XcrdE4AWShEWl2dAFmAQ3SB5gCVXODm3BLTcxiTLZLIDIs9fFov3k5gfZ
         IbbPvoRPHeHw1mIbE8DqIsQrdvC/KMwav/b3PlTuP5gkfNWBT9dRuW25POZLlDKT4CsH
         TDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241635; x=1776846435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJ16P9ql425c7rop6LMTVQazhXI3kn8UEVCSS+AQW4A=;
        b=JeeiFsyOrC1WiL8u/25NLb+zvu2OYWdPHZrHH/szod6yjBya54Vr7qWTmp7KXP2KZ9
         TtsmGkP6YU3tY1NOuw7hexnFfyZFuPcDhvgzwAdOqjJXC9zJ0I9+WsgE0dewiTB57GFK
         k7gQEKSO60Jj3hAUS5Mnxsr4me5hw541FWg8gpVONacYa8K0nkhhjDKsxwarwd3cJiZO
         6fVW9vkQ4vYnVdrYlRVfszlNmeCnxrS2xKi/h7RoLuocWVhX1vDOeIIuneZtPMrDjU3s
         pII+cBuCNprxPSZfhFNru7viLJPNX4VLcvwm7GOT5EzZdOLjvu/zk6GHDm5gGw+6VYSM
         gPZQ==
X-Gm-Message-State: AOJu0YzZHi09aoMFKSb8cw3pLntLBJ/uuWxh6z4DoVz7HO99/L09ltoK
	4LX788nel8U0Ty6kzjqckhbqJUO1OJ22ME7DduzjOrfyb06pLdG8t3DE
X-Gm-Gg: AeBDies40NgK03AGFUtWADbV/snW0Rqo1ccVQWvILwdcI8L+qEuFOmiCMkPN6UCPuiK
	0jq1dZTkmkErZ3d7TZJGLRfnvwT0gIq57JOeW6g6hRK87TOMJwRoBH/mJPPtF0epfdJ/FHDDOyD
	VkfvuCsfIf7tMSLGqTPFOgFz8LvTgDks5HTC1kMsm7kHIFOOy1dD4ENJLom+7vLHY2aWr14K+1m
	lbCDsIPyXtcBFgyO4wO6zbPLwyIc9LmGKXKCs+u4sVvmXFkNG29uOKuBQovGLVa9zEVmMwHlvnf
	mBQXu/alWvrm+QqWsPxmGJeQsQLA9AAdMVRWmYEIHOZWTP0x8bfBqIkqaDm7CQsY6/OQ/qEdF2Y
	Pp0yb5gmxgUyPsjChRILbqJxlm/N03VJwuW/oTcrx/r59u5bdRbEPm8CfWr7XMAvJVhA/eagKMM
	lt76ilCyR6Axv//nanCutRMBLQLdZKq6xnyfNQjRXdns8ojVuBomQjUqG9KKNf+9rYk2VzY4wqX
	OXvvSHg
X-Received: by 2002:a17:902:bd42:b0:2b0:61f8:9f01 with SMTP id d9443c01a7336-2b2d5aa6ed3mr134711005ad.44.1776241634503;
        Wed, 15 Apr 2026 01:27:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:13 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 01/14] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
Date: Wed, 15 Apr 2026 16:26:41 +0800
Message-Id: <20260415082654.21026-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a new socket option to provide an alternative to achieve a higher
overall throughput with the rest of series applied. As the corresponding
documentataion I added says, it might increase the latency because the
heavy allocation cannot be avoided especially when the shortage of
memory occurs. So this patch don't turn this feature as default.

Add generic_xmit_batch to tertermine how many descriptors are handled
at one time. It shouldn't be larger than max_tx_budget or smaller than
one that is the default value (disabling batch mode).

Introduce skb_cache when setting setsockopt with xs->mutex protection to
store newly allocated skbs at one time.

Introduce desc_cache to temporarily cache what descriptors the xsk is
about to send each round.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 Documentation/networking/af_xdp.rst | 17 +++++++++++
 include/net/xdp_sock.h              |  7 +++++
 include/uapi/linux/if_xdp.h         |  1 +
 net/xdp/xsk.c                       | 47 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/if_xdp.h   |  1 +
 5 files changed, 73 insertions(+)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 50d92084a49c..7a8d219efe71 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -447,6 +447,23 @@ mode to allow application to tune the per-socket maximum iteration for
 better throughput and less frequency of send syscall.
 Allowed range is [32, xs->tx->nentries].
 
+XDP_GENERIC_XMIT_BATCH
+----------------------
+
+It provides an option that allows application to use batch xmit in the copy
+mode. Batch process tries to allocate a certain number skbs through bulk
+mechanism first and then initialize them and finally send them out at one
+time.
+It applies efficient bulk allocation/deallocation function, avoid frequently
+grabbing/releasing a few locks (like cache lock and queue lock), minimizing
+triggering IRQs from the driver side, which generally gain the overall
+performance improvement as observed by xdpsock benchmark.
+Potential side effect is that it might increase the latency of per packet
+due to memory allocation that is unavoidable and time-consuming.
+Setting a relatively large value of batch size could benifit for scenarios
+like bulk transmission. The maximum value shouldn't be larger than
+xs->max_tx_budget.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..965cab9a0465 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -45,6 +45,12 @@ struct xsk_map {
 	struct xdp_sock __rcu *xsk_map[];
 };
 
+struct xsk_batch {
+	u32 generic_xmit_batch;
+	struct sk_buff **skb_cache;
+	struct xdp_desc *desc_cache;
+};
+
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
 	struct sock sk;
@@ -89,6 +95,7 @@ struct xdp_sock {
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
 	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
+	struct xsk_batch batch;
 };
 
 /*
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..6122db8606fe 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1218,6 +1218,16 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
 	}
 }
 
+static void xsk_batch_reset(struct xsk_batch *batch, struct sk_buff **skbs,
+			    struct xdp_desc *descs, unsigned int size)
+{
+	kfree(batch->skb_cache);
+	kvfree(batch->desc_cache);
+	batch->skb_cache = skbs;
+	batch->desc_cache = descs;
+	batch->generic_xmit_batch = size;
+}
+
 static int xsk_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1247,6 +1257,7 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	xsk_batch_reset(&xs->batch, NULL, NULL, 0);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1588,6 +1599,42 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		WRITE_ONCE(xs->max_tx_budget, budget);
 		return 0;
 	}
+	case XDP_GENERIC_XMIT_BATCH:
+	{
+		struct xsk_buff_pool *pool = xs->pool;
+		struct xsk_batch *batch = &xs->batch;
+		struct xdp_desc *descs;
+		struct sk_buff **skbs;
+		unsigned int size;
+		int ret = 0;
+
+		if (optlen != sizeof(size))
+			return -EINVAL;
+		if (copy_from_sockptr(&size, optval, sizeof(size)))
+			return -EFAULT;
+		if (size == batch->generic_xmit_batch)
+			return 0;
+		if (!size || size > xs->max_tx_budget || !pool)
+			return -EACCES;
+
+		mutex_lock(&xs->mutex);
+		skbs = kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
+		if (!skbs) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
+		if (!descs) {
+			kfree(skbs);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		xsk_batch_reset(batch, skbs, descs, size);
+out:
+		mutex_unlock(&xs->mutex);
+		return ret;
+	}
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
-- 
2.41.3

