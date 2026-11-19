Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098504;
	b=gmPVP+lmCLbEJ97AQ0Iz6w+um6gl2hMIU3+lrqAGhU0RxHXhQmrL4+vjBcDxRRU8NCvm
	 humEsn5p4BkkaffELbLJ2ZmdnT3HGUpIoLnrccjc8T84eaz9G8kxFFsVUYn0BCuOvGp1Q
	 syOMEggzTMPzN70H6TyiiB4engag48OX+OnzMpXahsCUGDMsu04+XsoeuzZv8GATqjcl8
	 0Y1ILvfXaKn5q6aFEsUzJhZigWPrQhp5diBCcphgDlAO8lRtMt0RgQXm7AelQEh9/OcwX
	 v1MrqL/tiev2wCekA8NdwYVvTlRK2wXsE1HmyF7b4r2BexVJzse1EBp678dsr6ffcWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aDolSJGzJ9eNhH42W0V8Hq6aAfDimZGKnPrQQn0FKh0=;
	b=LBHTdr1G6oJSp/JqI/2lP8gzdhfVIkk7x7uK12ACmbe9P1DhfNj4x5Wu9jWAKgMarEEn
	 8uU7qvWKQafuNlUcSLbVFHn6AdieHsrgxVkJmFqBWMzl7pR5Omjn/xfkOO/7CElNcXlzY
	 SCqtQRn8ZyKoMVwGgxbg7Soi+u1TkpKq22MzdtcshCZASj9dW2aMHb2xkSXiihqRcLH5F
	 AiMY1sbQv2nTRMK5cMNu1kllUIBY3hYC66cetoDz+9/bBMayiVzHTzy+w1IwRjvKIKG+n
	 RVxHjChmvUzPCsq1hGnxv+oOR78jnjhIwVsjdGQeFStUAPGpGKnCH6GqxAwfXL8sV0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=k5DGBpdZ;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7297606A324
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7297606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=k5DGBpdZ
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso14488575e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795098502; x=1795703302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aDolSJGzJ9eNhH42W0V8Hq6aAfDimZGKnPrQQn0FKh0=;
        b=k5DGBpdZP01TebVA2IIRUM6srGoHzYEnmVkWOAtg+rAfjp8qi7gYmvRVD8LQ3m/8/f
         YZbPbIAhxqRR1OHTuRThNV83srBCvr7AuNzfRpRnAxTP4uAgOJbTsUH5TsYfu+XbAmPS
         3SHikzKvcyM387C6FeRbK1gtAHlyvx8cKL/IS4vRgiVbIc7AiQnEkSjPJlDzzlYrtsDk
         Jjf8WaaGld81gxc1pnFGXvx53/GjhljBqMvpSm7msRFql7j9rN/HnL/GNGz5T/Th0a+v
         o3cDFtq8fRI7QFHqBVkgjumFi0HcPAEZxuZctCLWt0EndyNeoPC3WaKah5gOIzOkvO5U
         guZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098502; x=1795703302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aDolSJGzJ9eNhH42W0V8Hq6aAfDimZGKnPrQQn0FKh0=;
        b=h8Q/dp4zZw4tLQr3r4iVVn24m+M4exQvec9TP9wcyX+iXbWf2FRP763zI9EaSQpkjy
         +Zyx4sa5w0VRFMjndofoGQUkLqhdXGzonT2tjYTobphS64VGcF4Y03rnHzRjWD+83kjd
         ZLQgivD/WEw5L4ptkdFBXt/Qy5ATzYAMUBc31IkAcdVEvzYMveaQ0rNgnDNx2JGfDHqK
         3i9wZYO4CLyPjGiYPzOzkLBu15MOwgeie11HfvG4Sj4z+QT/5LdeRYf/lle6PplZ8eTb
         P1YDJJtZoEXtXaxwherTMmf2/i94oIGDeIS/4GuleRDgvAVD5R8gPFZil1CMS0vrlIcs
         OkbQ==
X-Gm-Message-State: APuU4Z+X7QMymyt6ZJLRhZ0GhaInCPqPZ6oWq0kNgTLz238n/RvpX8UI
	NF+Skczdsj97SSrF1LpEIIsCEbzL0YVGJmqoTTcRt/X3LtdYyUXQBQo0TNesUQGGr1pDGOrsLch
	5kpYvVtWFTqlU
X-Gm-Gg: AYBFou2UD9XO4foFylzxYH0vPcY9paI2YDT1MGOeO1zlnwtG/NXZd1OfvjMhg22ylkn
	LlvgDmg/NzyvTGcjJ9j9FsfB72wWP36Hvu2bH3m69zqwfHEVX7Iz8MwCo04NWIl2VejA3P2pJU9
	kJWpIqr5N9fQroSAYw4+HWHO7WbKjrEQTakBGzElPlnDvKVplo40SaKempZLZHhcVyD9FGADURT
	wd3W0WyjMqQhu76GjhtHdc+WnGLLzG360C1qPd7SinCuLopBoIQQDL+0+n6WQPZECbXpZkXUZAc
	GXOChcX7L1YgGWHW6qFrIUNhCiQTvZQ7p63fJKcmbDa+KobrSM/zr2W/K5zY/JLrFoAgyG8s/TU
	kr01HVbG+g1SuGhBKQjO/dOUAqwrj+7QRLgaUBY/kMh6yreZu/SUHig8koFIvoQ8zThneqJahDu
	f/eTv+JQpRAueMhGe2tC6Ts9PU0KzsDf0bxh+7b2BQwE9WISn2dsGY23BSjf4TZd4S9Sl42gGYA
	pOGX/XlDxzxJ6Nwf7ij+UM2uoshmpmY/YdLyNh1MrC8Vob1S6WXkswiHjm+je7P+llWe1Es1NS7
	XgqgUgaQVddrx0hOVu8edc4sweNYSY2AL6WnkDOE8v+3KcsQSQU=
X-Received: by 2002:a05:600c:6746:b0:4a2:1364:252a with SMTP id 5b1f17b1804b1-4bb7d5d41f0mr118656245e9.3.1795098502012;
        Thu, 19 Nov 2026 06:28:22 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab55d2e241sm97733f8f.45.2026.11.19.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:28:19 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Paul Chaignon <paul@isovalent.com>,
	Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 3/8] bpf: allow bpf_sk_assign on tc egress with refcounted sockets
Date: Thu, 19 Nov 2026 16:22:25 +0200
Message-ID: <20261119142231.2612515-4-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119142231.2612515-1-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

bpf_sk_assign() has been limited to tc ingress because the assigned
socket may be a SOCK_RCU_FREE listener held without a refcount, relying
on the current RCU read-side section for its lifetime. That assumption
breaks on egress where the skb can sit in a qdisc across grace periods.
However, the helper is also useful on the egress path, for example to
attribute forwarded traffic to a specific established socket for qdisc
flow classification (fq, fq_codel), cgroup accounting, or SO_PRIORITY
propagation. Established sockets are refcounted and therefore safe to
pin on an skb that may be queued.

Allow TC egress to assign full refcounted sockets, taking an skb-owned
reference after orphaning any previous send-side owner. Preserve it
across redirects, classic BPF verdicts and netem delay. Reject decrypted
egress skbs to preserve the original TLS transmit owner.

Using sock_pfree_ref as a destructor encodes the refcount state so:

  - sock_pfree_ref releases the refcount on drop (unlike sock_pfree
    which skips non-refcounted sockets).
  - skb_sk_is_prefetched recognizes both destructors so ip_rcv_core
    still skips the skb_orphan on the receive side.
  - skb_steal_sock sets refcounted=true for sock_pfree_ref so the
    transport layer calls sock_put after consuming the socket.
  - skb_do_redirect only orphans sock_pfree + !sk_is_refcounted (the
    true no-refcount case from ingress), preserving sock_pfree_ref
    sockets across redirects.

The refcount_inc_not_zero cost per bpf_sk_assign call is negligible
relative to the BPF program and the sk_lookup that precedes it, and
does not affect the UDP early demux path which continues to use
sock_pfree without a refcount.

Handle reference-only ownership in TLS software fallback and Chelsio
record reconstruction without sk_wmem_alloc charges or lost references.

Software GSO splitting after assignment is unsupported, including qdisc,
device/driver/tunnel fallback and netkit peer-side NFQUEUE segmentation.
Segments can lose the selected socket; intact GSO and assignment after
segmentation remain supported. Ordinary loopback and veth peer NAPI/GRO
preparation can also discard the assignment, even without GSO.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: Ayush Sawal <ayush.sawal@chelsio.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>
CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Emil Tsalapatis <emil@etsalapatis.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>
CC: John Fastabend <john.fastabend@gmail.com>
CC: Stanislav Fomichev <sdf@fomichev.me>
CC: Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@google.com>
CC: Willem de Bruijn <willemb@google.com>
CC: Jamal Hadi Salim <jhs@mojatatu.com>
CC: Jiri Pirko <jiri@resnulli.us>
CC: Sabrina Dubroca <sd@queasysnail.net>
CC: Paul Chaignon <paul@isovalent.com>
CC: Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>
CC: netdev@vger.kernel.org

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  5 ++++-
 include/uapi/linux/bpf.h                      |  8 ++++---
 net/core/filter.c                             | 22 +++++++++++++------
 net/core/sock.c                               |  4 ++++
 net/sched/act_bpf.c                           |  4 +++-
 net/tls/tls_device_fallback.c                 |  5 +++--
 tools/include/uapi/linux/bpf.h                |  8 ++++---
 7 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index 4d645771596a..796497e9d3b9 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -1669,7 +1669,10 @@ static void chcr_ktls_copy_record_in_skb(struct sk_buff *nskb,
 	nskb->truesize += record->len;
 	nskb->sk = skb->sk;
 	nskb->destructor = skb->destructor;
-	refcount_add(nskb->truesize, &nskb->sk->sk_wmem_alloc);
+	if (nskb->destructor == sock_pfree_ref)
+		sock_hold(nskb->sk);
+	else
+		refcount_add(nskb->truesize, &nskb->sk->sk_wmem_alloc);
 }
 
 /*
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62de0919db72..45e3018fb2ae 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4611,7 +4611,9 @@ union bpf_attr {
  *		**bpf_clone_redirect**\ () or other methods outside of BPF may
  *		interfere with successful delivery to the socket.
  *
- *		This operation is only valid from TC ingress path.
+ *		This operation is valid from TC ingress and egress paths.
+ *		On egress, only full refcounted sockets are accepted.
+ *		Software GSO segmentation after assignment is unsupported.
  *
  *		The *flags* argument must be zero.
  *	Return
@@ -4623,8 +4625,8 @@ union bpf_attr {
  *
  *		**-ENETUNREACH** if the socket is unreachable (wrong netns).
  *
- *		**-EOPNOTSUPP** if the operation is not supported, for example
- *		a call from outside of TC ingress.
+ *		**-EOPNOTSUPP** if the socket is unhashed, or TC egress uses
+ *		a non-full or non-refcounted socket or a decrypted packet.
  *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
diff --git a/net/core/filter.c b/net/core/filter.c
index 1ad57a371534..feeb752f7a00 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2559,14 +2559,17 @@ int skb_do_redirect(struct sk_buff *skb)
 	if (unlikely(!dev))
 		goto out_drop;
 
+#ifdef CONFIG_INET
 	/*
-	 * Prefetched sockets may borrow a listener under RCU. Orphan them
-	 * before redirects that can outlive this section. Peer ingress
-	 * stays in the same RCU section.
+	 * Prefetched listeners may be borrowed under RCU. Drop borrowed
+	 * assignments before redirects that can outlive this section.
+	 * Peer ingress stays in the same RCU section.
 	 */
-	if (skb_sk_is_prefetched(skb) &&
+	if (skb->destructor == sock_pfree &&
+	    !sk_is_refcounted(skb->sk) &&
 	    (!(flags & BPF_F_PEER) || (flags & BPF_F_EGRESS)))
 		skb_orphan(skb);
+#endif
 	if (flags & BPF_F_PEER) {
 		dev = skb_get_peer_dev(dev);
 		if (unlikely(!dev ||
@@ -8115,21 +8118,26 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
 
 BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 {
+	bool egress = !skb_at_tc_ingress(skb);
+	bool refcounted;
+
 	if (!sk || flags != 0)
 		return -EINVAL;
-	if (!skb_at_tc_ingress(skb))
+	if (egress && (!sk_fullsock(sk) || !sk_is_refcounted(sk) ||
+		       skb_is_decrypted(skb)))
 		return -EOPNOTSUPP;
+	refcounted = egress || sk_is_refcounted(sk);
 	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
 		return -ENETUNREACH;
 	if (sk_unhashed(sk))
 		return -EOPNOTSUPP;
-	if (sk_is_refcounted(sk) &&
+	if (refcounted &&
 	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 		return -ENOENT;
 
 	skb_orphan(skb);
 	skb->sk = sk;
-	skb->destructor = sock_pfree;
+	skb->destructor = egress ? sock_pfree_ref : sock_pfree;
 
 	return 0;
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 3b1f60eaa73e..f4ec58a86056 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2818,6 +2818,10 @@ static bool can_skb_orphan_partial(const struct sk_buff *skb)
  */
 void skb_orphan_partial(struct sk_buff *skb)
 {
+#ifdef CONFIG_INET
+	if (skb->destructor == sock_pfree_ref)
+		return;
+#endif
 	if (skb_is_tcp_pure_ack(skb))
 		return;
 
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 06d8f78b7368..a0918fe9a71a 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -54,8 +54,10 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 	}
 	if (unlikely(!skb->tstamp && skb->tstamp_type))
 		skb->tstamp_type = SKB_CLOCK_REALTIME;
-	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
+#ifdef CONFIG_INET
+	if (skb->destructor == sock_pfree && filter_res != TC_ACT_OK)
 		skb_orphan(skb);
+#endif
 
 	/* A BPF program may overwrite the default action opcode.
 	 * Similarly as in cls_bpf, if filter_res == -1 we use the
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index b547027cc879..1450335a94dc 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -194,8 +194,9 @@ static void complete_skb(struct sk_buff *nskb, struct sk_buff *skb, int headln)
 
 	update_chksum(nskb, headln);
 
-	/* sock_efree means skb must gone through skb_orphan_partial() */
-	if (nskb->destructor == sock_efree)
+	/* these skbs hold a socket ref but aren't charged to sk_wmem_alloc */
+	if (nskb->destructor == sock_efree ||
+	    nskb->destructor == sock_pfree_ref)
 		return;
 
 	delta = nskb->truesize - skb->truesize;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62de0919db72..45e3018fb2ae 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4611,7 +4611,9 @@ union bpf_attr {
  *		**bpf_clone_redirect**\ () or other methods outside of BPF may
  *		interfere with successful delivery to the socket.
  *
- *		This operation is only valid from TC ingress path.
+ *		This operation is valid from TC ingress and egress paths.
+ *		On egress, only full refcounted sockets are accepted.
+ *		Software GSO segmentation after assignment is unsupported.
  *
  *		The *flags* argument must be zero.
  *	Return
@@ -4623,8 +4625,8 @@ union bpf_attr {
  *
  *		**-ENETUNREACH** if the socket is unreachable (wrong netns).
  *
- *		**-EOPNOTSUPP** if the operation is not supported, for example
- *		a call from outside of TC ingress.
+ *		**-EOPNOTSUPP** if the socket is unhashed, or TC egress uses
+ *		a non-full or non-refcounted socket or a decrypted packet.
  *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
-- 
2.47.3

