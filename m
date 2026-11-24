Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501957;
	b=YQBwLZxNbjw3uGm7YJmdruwlyHycVU99VbAhXjMwQlv2VLaacvgsa7u9THudOh+w/3wC
	 aLc99zcliGIfHwSPwN8AXQXW7rBekOI7ttz40ADeR/QkdC6cTqx0L3CyY7eBirEWmoIfK
	 h9XBkT2VcdSkqmyeH7pUcwE6IOQAFi9iskGY5L0vbp9vf0ifK7nRg4wOxvRAyA6OgRPDD
	 EbJ06D4EzV9HXKpWZQ8CkXl80AvXvRcj0BZiuuPVcEx0qpqjoJmS+lKc+ImYmOHstGAbL
	 meKDftn18tGpytM3IzHbyls2FHYtVzL/KA+CVUIPZnrIflY1eT+3PLV1G8Xq+Bc1xOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=mzn5BWbbvEtliT+9iGFUrtwH0MOEd7ojluQSgA2kmv0=;
	b=MExaSUe5N6Hgm/WZQpdwwR7agBy0oM5wYm0yI/MqxYtaqt9MJ8kzm66rB51g51Uq5fsa
	 h7tXJrUlH+qU+YpVuH6wtARfEXPk4BtD/OWkCRpJqL0YUNebqIMFyTduOfWmW6LMfl5Es
	 F5rLa7Xw3i6Z6H5BYUn41Mw4olcSERoaPoYU3tSjXtS2N24yn51waGeo4mHZgnloBzUMd
	 Z+IFQWAeXevi9OfTA20G+usFi3Go3punW4xzovi7pyNodZfJdnVD20BzO8xeQWGGneacE
	 MqcMDdkj5VODVF+Q32QuLiBPPatfaMoJ8cpi7jF3KlA/Ir6oKlra9aFb4lUgEZbBfPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mrgSIa7w;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684E606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0684E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mrgSIa7w
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b3d4d3bba3so2063432a91.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795501956; x=1796106756; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mzn5BWbbvEtliT+9iGFUrtwH0MOEd7ojluQSgA2kmv0=;
        b=mrgSIa7wP+Vh72zhlYTcA12jSvj61+INgrl/1RZqMWQweY8esTDNeatXZfv2xdFCr9
         /TsNRG/rSeId0qnBsWb4GWcFgcWZlF+BUT8fW8it6DlXgqT0mGtYchzNdk7O6yazx4HT
         gv77PnLINxXR6w2pRmbk4Geqm0DCxIHDcaMffEp/oXfiG9JiM6ho2e61GmJ28plTjVWy
         kZaFf7hu9wkO1+va8c+AzdQnnlCHLPmt/pDfOuTFQ658nSL+OymXxIg7cfU3zbQ708Yf
         0RqteSF+KG7aRJTAFRIn8mZBzJAZcPKwBh0E18IHGlAEGkSXoxi6PVFSpdHOQz10TOZR
         +a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795501956; x=1796106756;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mzn5BWbbvEtliT+9iGFUrtwH0MOEd7ojluQSgA2kmv0=;
        b=bMQs03UDIODyFe9RihyHSe3LLNjcIJIjpM0zQPYuqfvz/ir+I1DppE/YzqsM0UiVX2
         KRhQnBP5y5ZWhCabsWP0ody4lYy1KiV5012xrnKSmu+Qnjov0EU05bpFN3Z67PgxVZto
         wcTtboxRlI2e/Yu1M1MfiAHP8Wn5V6Cd5R7kZ3vuZnar8gqlM2rjuaVYE5q049Z2PyjV
         IOW4VhOLAqdihITN4U8L3azC1HwsJQt2o6qW3j9Kp9OTBwYbF8dpCATHMjShr8Gm27br
         27GKWipJQgK13IdV9KjwYOx+eFz0cFGZM2/ilKP7IbuIShCi3j2NgggXgafDjdQEvpk+
         3gqw==
X-Forwarded-Encrypted: i=1; AL+hErEQaAZ298jLQiqP3FRYDzPElaFM9wknopYJK9nOU3JBObxOJ/KIZKoTQfZga/yhzbKA1Q0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MFfTxM/pdeL3sXObv15YPtdLt4BASpRqSXXohBIT6AZA+D6sC
	VZ013cSNHgnw2IC3Lqei35OVc/i7+FAGOqQ2B2t5NSLnxTcpC3XXs2C8
X-Gm-Gg: AZFdTZd49lzH9zkDQucXJpYkQOGhtc8RNoP4svv8bCis7VF8GUZMAf9U7aWAk1adWQd
	Y9MfJZRvUXtrg4q9LyOMWfzrdxLoYESUIgMe7Dc8nFewmLdNsM6vPy0e1dFXP56JWYKtWZPlndo
	KpW8T0tBOI8ldujswBUJZZmgubUwr3VKaBYL2bh+VEZxTFKThjve31XRvqCw6m6+YGGO/nl9WYf
	j80cNZk9W2N0E6AShj9fg/0bO0/Tw9ImCAWfuCS58esAACrwNsW3xMa02k+sHtFwt+sU70melDl
	1TSq1nVKxVT+iz0uVqUdZi/lQWYKFF2q8/LJlY8ZnbK95KZkyZ5k+khnaqoMOnLvpgXh4EaflSu
	zJyYBagQXiqlyXl3Y9NE47rlPKbsqOMnpwTfxzM09QOWNIMDpWCpFCOChGyEQjBhbYqH6fZ+OMr
	kNse3WrQnMZDDyvxdqUM1TiohMU480AYPs8dGtLHQhcAhfnJ9l1DhOy1pNGnHXcisKD1dgS5sTz
	dwOslXKpARZFMk2hQb+tVl0RPpXyLQ6Q2Cg0lWbiTex9rv7b4xGM+WeUKWc/Gm0FsRH5pLTTMrp
	tx6URXNm9iys5Wf5hEq0zF+qdaJ0wrKsmni/k9Ot8maZ06nicDxCJXOTaSR3dkTafEFC6YGFGB2
	8YRa2ygQe+AVhuaIokpKVBWytoOi52MbOZQ==
X-Received: by 2002:a17:90b:4cd0:b0:3ab:36c4:b4ff with SMTP id 98e67ed59e1d1-3b41c925a85mr13516923a91.24.1795501956132;
        Mon, 23 Nov 2026 22:32:36 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcfe16sm21666684a91.17.2026.11.23.22.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 22:32:35 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 06:32:35 +0000
Message-Id: <DN38BN9BAJQS.2DSRH5XIU6EU3@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf v2] bpf: net_sched: Let bpf_kfree_skb() run with
 irqs off
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <a2d4276cbf11b1254aa7997874a6539d20f296cf.1795463894.git.memxor@gmail.com>
References: <a2d4276cbf11b1254aa7997874a6539d20f296cf.1795463894.git.memxor@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 11:58 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> Use dev_kfree_skb_any(). With irqs on it is kfree_skb(). With irqs off the
> skb goes to the completion queue of the cpu, and NET_TX_SOFTIRQ frees it.

Bots are correct :(
With irqs off it also wakes up ksoftirqd. I missed that, sorry.
This will deadlock when the destructor runs under rq lock:

  __schedule()                        holds rq lock, irqs are off
    bpf_kfree_skb_dtor(skb)
      dev_kfree_skb_irq_reason(skb)
        raise_softirq_irqoff()        in_interrupt() == 0
          wake_up_process(ksoftirqd)
            ttwu_queue()              cpu == this_cpu
              rq_lock(rq)             <- same rq

A prog that shares a list with the qdisc prog gets there:

  prog                    drops the node with
  ----------------------  ----------------------------------------
  sched_ext ops.dispatch  bpf_obj_drop()
  tp_btf/sched_switch     bpf_list_add(), @prev is not in the list

The check from commit 94c8d1c21be4 ("bpf: Reject bpf_obj_drop() from
tracing progs") catches neither.
Today a UDP skb wakes nobody, unless a task waits for write space.

With irqs on it still sleeps on RT after bpf_preempt_disable():

  bpf_kfree_skb(skb)                  preempt_count() == 1
    sock_wfree(skb)                   a writer sleeps in sk_wq
      __wake_up_common_lock()
        spin_lock_irqsave(&wq_head->lock)

Lets go via irq_work like bpf_async_refcount_put() does.
On top of your v2 bpf_qdisc.c compiles with RT off. I didn't run it:

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index e041383..c569549 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -5,6 +5,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/filter.h>
+#include <linux/irq_work.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
@@ -184,6 +185,19 @@ static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_pr
 	return insn - insn_buf;
 }
 
+static LLIST_HEAD(bpf_skb_free_list);
+
+static void bpf_skb_free_irq_work(struct irq_work *work)
+{
+	struct llist_node *list = llist_del_all(&bpf_skb_free_list);
+	struct sk_buff *skb, *next;
+
+	llist_for_each_entry_safe(skb, next, list, ll_node)
+		dev_kfree_skb_any(skb);
+}
+
+static DEFINE_IRQ_WORK(bpf_skb_free_work, bpf_skb_free_irq_work);
+
 __bpf_kfunc_start_defs();
 
 /* bpf_skb_get_hash - Get the flow hash of an skb.
@@ -199,10 +213,17 @@ __bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
  *
  * Also the destructor of an skb kptr, which runs wherever an object or a map
  * value with such a field is freed: under a bpf_spin_lock too, with irqs off.
+ * rq lock can be held as well, so don't wake up ksoftirqd from here.
  */
 __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 {
-	dev_kfree_skb_any(skb);
+	if (irqs_disabled() ||
+	    (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())) {
+		llist_add(&skb->ll_node, &bpf_skb_free_list);
+		irq_work_queue(&bpf_skb_free_work);
+		return;
+	}
+	kfree_skb(skb);
 }
 
 __bpf_kfunc void bpf_kfree_skb_dtor(void *skb)

> + * Also the destructor of an skb kptr, which runs wherever an object or a map
> + * value with such a field is freed: under a bpf_spin_lock too, with irqs off.

Also the drop under bpf_spin_lock has an old bug.
The node can have its own list, like struct foo in linked_list.h:

  bpf_spin_lock(&glock)               irqsave_flags = on
  bpf_list_add(&ghead, foo, prev)     prev is not in the list
    bpf_list_head_free(&foo->head)
      __bpf_spin_lock_irqsave()       irqsave_flags = off
  bpf_spin_unlock(&glock)             restores off

The prog returns with irqs off. That's a separate patch.
This helpers.c change is on top of v2 too, it builds and was never run:

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489..bc0dd36 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2302,6 +2302,7 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
 {
 	struct list_head *head = list_head, drain, *pos, *n;
+	unsigned long flags;
 
 	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
 	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
@@ -2313,7 +2314,8 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	 * section, and end up doing map ops that call bpf_list_head_free for
 	 * the same map value again.
 	 */
-	__bpf_spin_lock_irqsave(spin_lock);
+	local_irq_save(flags);
+	__bpf_spin_lock(spin_lock);
 	if (!head->next || list_empty(head))
 		goto unlock;
 	list_for_each_safe(pos, n, head) {
@@ -2325,7 +2327,8 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	}
 unlock:
 	INIT_LIST_HEAD(head);
-	__bpf_spin_unlock_irqrestore(spin_lock);
+	__bpf_spin_unlock(spin_lock);
+	local_irq_restore(flags);
 
 	while (!list_empty(&drain)) {
 		struct bpf_list_node_kern *node;
@@ -2362,19 +2365,22 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 	struct rb_root_cached orig_root, *root = rb_root;
 	struct bpf_rb_node_kern *node;
 	struct rb_node *pos, *n;
+	unsigned long flags;
 	void *obj;
 
 	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root));
 	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bpf_rb_root));
 
-	__bpf_spin_lock_irqsave(spin_lock);
+	local_irq_save(flags);
+	__bpf_spin_lock(spin_lock);
 	orig_root = *root;
 	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
 		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
 		WRITE_ONCE(node->owner, BPF_PTR_POISON);
 	}
 	*root = RB_ROOT_CACHED;
-	__bpf_spin_unlock_irqrestore(spin_lock);
+	__bpf_spin_unlock(spin_lock);
+	local_irq_restore(flags);
 
 	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
 		obj = pos;

pw-bot: cr
