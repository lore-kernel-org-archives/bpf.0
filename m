Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1763B3C11
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161996; cv=none; b=mz6To3l1rP/oVh4DC70LYTxiREAcSi2I/XfUHJW/Ymom3o+1CR7LV1IqcPw1zg0CV4ESqjxcVYZsf2fd9dCvzNsZLYPp8r2s/030S2ImFea+kH20/mwbH1zvQWKHzm3HuHHsKfGqkXh8lznD6eUCCoDOoBkYQEZWbjXbBY8/Oj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161996; c=relaxed/simple;
	bh=ufFawdkbPQyxtvP/vY4bfmggah69hAiP4MacVPkP8Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGTKBa+buZaNOPyHPutY87Lytsw8FoRSS7igSlWwlK4v8TZqEfI/ZtTImLzl9R891XwkHItEG+p2mraFrgQTk86CBnfH3AQBN7D0d8rcdeqNJGeax7FsScFUm/lhS/Xs2JPaQFRJLbPE8K3uqmVMhft6rl2CcRycl7C4yruiGWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4ddX5Wl; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4ddX5Wl"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7efac480dc6so58583917b3.2
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 00:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161993; x=1781766793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vZX9ZLsq7+qZlX0ydHeLJ+45hrHGXpIcH8h2xOtT/8=;
        b=C4ddX5WlCj4AYUW4cKSySGq0wwb9BoMyxb/QwchQ7qagzgnJEcRcUO3RW+9H3NUpRd
         43T8T1GbbTKzD89ouPfW0w7K21sE0afxflf8/wlQS+YbpZBxW+mZiuwbqwx3AEkxclhl
         Rd7MYvoNYuzPdP+BCSfzIy63idieg7yqd0B8zQuNYH0sFjAbRNzSO57MLblOJ1jv1tbc
         5zRQZ9ulaKIxaayCJ113BuDMdLE5f+c0oErDIFd08y1Ge6Xl68+5HfqzRuoO+Rr5ucnK
         +E53mBF45smRdg51AJ76vMTuBsaUP10v2LvV+SAJNoObxR84b5+DFt7PyAwFl+hLNHaC
         ZZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161993; x=1781766793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vZX9ZLsq7+qZlX0ydHeLJ+45hrHGXpIcH8h2xOtT/8=;
        b=CPu9VYn+u2jYJIX3f8fFdsH4CFdk89UcBy0bmGZ3Ati3rAeHLIpG6b9BWzH8yyreK7
         dGwwz1I9AGVEegmMUHdChMr/eGLG7F4HgV8xdQ7CMgEs5KuJ7apocmfhUoN3s9v3mcmn
         ylNqlEMED8ywYSIdjjSWxOSR/HOjvF5s9014r0ZhxeUoIv+khTkxRkNYhVx6duUZEdq6
         XPAb/wMHMIBWOmPbVITW+44d7dAn7eSolYxu6NyRw/4+EDtwBTJBXalF1T5ARWTysOgZ
         kVp4hmheqMUr8vMXEolRhIT5ePjmTZzS8NjLrkf+zLaX+WQAsYtsWDayruVI6tbxYIvD
         YW3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+nnCnkbh92HrW2J15raW5WM1/4HNyo+UfGKNiVfJ+M/YVfC0tcgSmCYL42DZM9kguVwTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Be3IdO5+dB3MSYU5zvZLzv/ePJ0BDbav4bLCnl9V+zaiUK/C
	ceflwMeLD1lwcWTnI85GDkpKpwFs5nOePtTZ3OWFRNMXniXl/Ueqq1qw
X-Gm-Gg: Acq92OH6twPVEfQwk1SJtomCARsa7R90MLOce95sDK8vBS+Di4C0qDRVj5ipmlInZWb
	DoDtW5GTPISj+WaIvJXUuzUdgVHAaBMh2FnbxbcfdPUTGCcSn2hFWw9GyoyfuFmcW107MJvm7ek
	/fITn2gAk9p7JECoT58JN4X3w4cGmgi9vx3N32N1KH8n+nJriKG4h5OpRp0Kq+zZ4tC6G5582kc
	Z3lXRmqN06ufn7NhMhzBqLsa0Mud4+C7GYJBWbKwMpDzQgGANNAOk9JLPv7QJM50vt0gbBVRhIw
	eXARbN10TV+ArTzvOOZWgnkZ+PovWNqolQyQ9SBVjK/EoF10U5LNd0h8wKDJZCqJt9ntSIlMNQ7
	x6FOwazs3KQZXxDW6Z8Hjvu56gmXrerFQUZONKs9f2srKA/GmZQTIc7HusiMiSyoxNMSGjIRPU6
	sPPPE96GKs/EEP57tbEKrxw//q4Vmf8fDfNBtAoKu1iGkkGngAiAt1eqteoZOpDA==
X-Received: by 2002:a05:690c:c4c9:b0:7dd:63c7:39b6 with SMTP id 00721157ae682-7f655007fb6mr16817817b3.9.1781161992785;
        Thu, 11 Jun 2026 00:13:12 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:12 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
Date: Thu, 11 Jun 2026 15:12:40 +0800
Message-ID: <20260611071242.2485058-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

For now, we use sk_busy_loop() for both rx and tx path. The sk_busy_loop()
will call napi_busy_loop() for the specified napi_id. However, some
nic drivers have tx napi, such as virtio-net. In this case, sk_busy_loop()
doesn't work, as it can only schedule the NAPI for the rx queue.

Therefore, introduce sk_tx_busy_loop() for the nic drivers that support tx
napi, which will schedule the tx napi if available.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/netdevice.h |  1 +
 include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
 net/core/dev.c            | 26 +++++++------------------
 3 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5a..8a771b014d54 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -416,6 +416,7 @@ struct napi_struct {
 	int			napi_rmap_idx;
 	int			index;
 	struct napi_config	*config;
+	struct napi_struct	*tx_napi;
 };
 
 enum {
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 6e172d0f6ef5..0959e80272c7 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -33,6 +33,12 @@ static inline bool napi_id_valid(unsigned int napi_id)
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 
+enum {
+	NAPI_F_PREFER_BUSY_POLL	= 1,
+	NAPI_F_END_ON_RESCHED	= 2,
+	NAPI_F_TX_NAPI		= 4,
+};
+
 struct napi_struct;
 extern unsigned int sysctl_net_busy_read __read_mostly;
 extern unsigned int sysctl_net_busy_poll __read_mostly;
@@ -49,9 +55,9 @@ static inline bool sk_can_busy_loop(const struct sock *sk)
 
 bool sk_busy_loop_end(void *p, unsigned long start_time);
 
-void napi_busy_loop(unsigned int napi_id,
-		    bool (*loop_end)(void *, unsigned long),
-		    void *loop_end_arg, bool prefer_busy_poll, u16 budget);
+void __napi_busy_loop(unsigned int napi_id,
+		      bool (*loop_end)(void *, unsigned long),
+		      void *loop_end_arg, unsigned int flags, u16 budget);
 
 void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
@@ -60,6 +66,17 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 void napi_suspend_irqs(unsigned int napi_id);
 void napi_resume_irqs(unsigned int napi_id);
 
+static inline void napi_busy_loop(unsigned int napi_id,
+				  bool (*loop_end)(void *, unsigned long),
+				  void *loop_end_arg, bool prefer_busy_poll, u16 budget)
+{
+	unsigned int flags = prefer_busy_poll ? NAPI_F_PREFER_BUSY_POLL : 0;
+
+	rcu_read_lock();
+	__napi_busy_loop(napi_id, loop_end, loop_end_arg, flags, budget);
+	rcu_read_unlock();
+}
+
 #else /* CONFIG_NET_RX_BUSY_POLL */
 static inline unsigned long net_busy_loop_on(void)
 {
@@ -126,6 +143,24 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 #endif
 }
 
+static inline void sk_tx_busy_loop(struct sock *sk, int nonblock)
+{
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	unsigned int napi_id = READ_ONCE(sk->sk_napi_id);
+	unsigned int flags = NAPI_F_TX_NAPI;
+
+	if (READ_ONCE(sk->sk_prefer_busy_poll))
+		flags |= NAPI_F_PREFER_BUSY_POLL;
+
+	if (napi_id_valid(napi_id)) {
+		rcu_read_lock();
+		__napi_busy_loop(napi_id, nonblock ? NULL : sk_busy_loop_end, sk, flags,
+				 READ_ONCE(sk->sk_busy_poll_budget) ?: BUSY_POLL_BUDGET);
+		rcu_read_unlock();
+	}
+#endif
+}
+
 /* used in the NIC receive handler to mark the skb */
 static inline void __skb_mark_napi_id(struct sk_buff *skb,
 				      const struct gro_node *gro)
diff --git a/net/core/dev.c b/net/core/dev.c
index 0c6c270d9f7d..645a2e851918 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6878,11 +6878,6 @@ static void __busy_poll_stop(struct napi_struct *napi, unsigned long timeout)
 		      HRTIMER_MODE_REL_PINNED);
 }
 
-enum {
-	NAPI_F_PREFER_BUSY_POLL	= 1,
-	NAPI_F_END_ON_RESCHED	= 2,
-};
-
 static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 			   unsigned flags, u16 budget)
 {
@@ -6932,9 +6927,9 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	local_bh_enable();
 }
 
-static void __napi_busy_loop(unsigned int napi_id,
+void __napi_busy_loop(unsigned int napi_id,
 		      bool (*loop_end)(void *, unsigned long),
-		      void *loop_end_arg, unsigned flags, u16 budget)
+		      void *loop_end_arg, unsigned int flags, u16 budget)
 {
 	unsigned long start_time = loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
@@ -6951,6 +6946,9 @@ static void __napi_busy_loop(unsigned int napi_id,
 	if (!napi)
 		return;
 
+	if ((flags & NAPI_F_TX_NAPI) && napi->tx_napi)
+		napi = napi->tx_napi;
+
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_disable();
 	for (;;) {
@@ -7015,6 +7013,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
 }
+EXPORT_SYMBOL(__napi_busy_loop);
 
 void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
@@ -7028,18 +7027,6 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 	__napi_busy_loop(napi_id, loop_end, loop_end_arg, flags, budget);
 }
 
-void napi_busy_loop(unsigned int napi_id,
-		    bool (*loop_end)(void *, unsigned long),
-		    void *loop_end_arg, bool prefer_busy_poll, u16 budget)
-{
-	unsigned flags = prefer_busy_poll ? NAPI_F_PREFER_BUSY_POLL : 0;
-
-	rcu_read_lock();
-	__napi_busy_loop(napi_id, loop_end, loop_end_arg, flags, budget);
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL(napi_busy_loop);
-
 void napi_suspend_irqs(unsigned int napi_id)
 {
 	struct napi_struct *napi;
@@ -7579,6 +7566,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	napi->poll_owner = -1;
 #endif
 	napi->list_owner = -1;
+	napi->tx_napi = NULL;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
 	netif_napi_dev_list_add(dev, napi);
-- 
2.54.0

