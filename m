Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579431;
	b=vVLmPmbsUFI7xsqkVcfoq8IvCmAf2XuSzfNjre6GIxzAURWs83eB+5nvzb4zAWkjXzeG
	 g1GW9h5uigXGuxeOVCoq5yXggqR5UEiaH5dJ9ItxQvX/yLruEndVFkdqaEn5lkG4bcwEE
	 r12MgBsh6M6u7EzAMt6hHDVMicdU3PEHLa1owrSDUxunxwNMqfjCErq5qieFoteyIACnU
	 IF5SijuQjFd2+ulexQ2gWxBqmrv74wK99FCxZQDSvz05h0L1pszAahyK3/Cb4wLF4dBsE
	 dfHBB5G3D+qbI0CV5oxvmI6OpVz1foO+cjSVpOiV24s8qnN+Yc8GDvs4JGN9eNiyxTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=FJpFlG2KhF/i7ZYFbAbjEhsaAMAjHqUu1cyD0w44kPw=;
	b=aPDu4C9qYVPVcSOLP3lXCzcrAzlP4JiFJlB9sjIvVQ5hERNKQyokO8CqzEwNhbKHY4Fd
	 iwfyFN2gHoQscT/H6J/hla07miD9b+WLXtVAVAFl408NhoVcMz+hX4UWn17YYIJdUqsJw
	 F1uV+ffWQ3WkB2MAa019TQ4/CBp34qTq84QajKmW3dZhrWyzGewNbWUitNwmPKLg54ydg
	 GSH1T/UkqTK/ygoB1nUkByglpyRiFHtmfg41Lkugdjarq7Pym1U6IXqc5n1o1VbHqnfJk
	 L31x43A3c2MsQ5jaRoCfmFpcyFSxHn40IgCJbUJXL6pxXf2rDgLm2HKTeja8dhmJNOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFqd666p;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B64606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B64606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFqd666p
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b271e573adso2255365b3a.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579431; x=1796184231; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJpFlG2KhF/i7ZYFbAbjEhsaAMAjHqUu1cyD0w44kPw=;
        b=wFqd666pVxX8odUiX88E5A6dCczA8eVt0MMhu+kzFLlKgcLwRRoQZUe6BOtjZPlaA4
         RXYFOmjn73IVOFU2nbyHtvPYEaBfPAptUXVsrMLOUSQVg/7sc+ODLSo3rkKQXjuRieEO
         LIiktH6/5c0MvCvfeJe5hAsXg8/GZiatJafwfuFvrxe7iNjST2ScgA5dGaDonAtjK0R4
         0q2EofEMQp9uJLFIm2zsvLe8Ru5USzFSC8JdY8ClTwFfwwCgg2pLa61BA/TfhzWVA3MZ
         zJY09OACmu5FwvxzvVs+k9+TrCgcaMJwKVia8aQFp5SuRYuvVR5863cHWlVXXS/5VyXz
         KxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579431; x=1796184231;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJpFlG2KhF/i7ZYFbAbjEhsaAMAjHqUu1cyD0w44kPw=;
        b=SmQbyfFzAHGOukFnStwoKJpups7HEp662ULdIvcd+8tjZlnm079mJiG5rrDV/RiD8e
         xHW7fnoKToMSgR8cACJ/xDAddga/RvgqoX0CdrmDaoQqhLqO67InFyAOKtmq0c3euUk7
         OHE67rdGS0fEoTdtGMiJYs07rXzIQVmLygwDKo05WPPxNIgGQ85LyP0GyA9CpPIMQBhf
         73zXmuqNrxVLiLFccFvZ1NkGJmI2RdlAFpdL8mQAjY+7uZqlT54XtADkQGp4HPXJwlA5
         FxPjAsoGMpY0nyVi+dlEbTjGB2sh267nkzTrsesFK8oDG0bHYFlsS9pYYXktkxNZ5RTX
         +Pjg==
X-Forwarded-Encrypted: i=1; AL+hErHSNEEFiDqmfl2uG0qOUS93fl41rHz+RoKnV2fOv4rGuPhoopc2/8ZfeJ5GTRTPVCyESKs=@vger.kernel.org
X-Gm-Message-State: APuU4Z80s6m1mbSjXJvA8vDVm0StFKG0GRkk5dGpjp/iXMMgMIOGjMS1
	79460zXsrXP1dPwOgf9ZSGkAhIOBewe/ke6VrQ8FC5ywKoq/PnlfvC8R
X-Gm-Gg: AZFdTZdhfa9YSB4d6n8qeBENLKf/svwzuds+Dvn3ghmH4/2SrHN1e55wOdaSLp2ruDJ
	4lNcvrq8DwA0NudI9Oxg68MMn1nItxmKMwZHPWr5Mm+6zpl9YxNYgtZgUwl9Kh5xceKMeKQWejx
	Sx6J1NL8Co4uvuzHoJUq54Doj5ClhKhAzcx8F0FQigTGpFSgWvvo1vd3qXnlPs5LryOgwZr9jom
	hUF7cAfby5JFDgeICHeoSS+QXGp7HO+iU+ntwrAk7OVr0/0ieWc4/dlFZTfZs0PBaBS9VLfX4LK
	ERTuf3p73bDApnJ9UAN5CbqyJPy3LBz3eqVp/kxqt3itgse9HfRjUdBHBiyoR5GvXY18qh6gLu3
	SpQ5v0KGO2u5+Sj7xwmO0WJ9gGKM7884Frcj7AIRpZIc1dYGENyaKvbPZgj1yMQdG+nlKuila4B
	0bgfD9Y+tcl96srSTlSLpNupeUyImhVMzqmUIy42d3RGBOq08atwqb8eTTYH0zQx89EVU8h2BOr
	FWT64Y60MCMfSyJyuIIFL65yGyqEI5DLqYSMT1n5ZRm38eWvxl17KSq9gGAcQ9BXmN5SKgBFE/N
	LsL7kJT60o+w8d5m4yT4lCMDRSgVfD00kXz9jlXKtIi1cwyjB9OAl9j5O9KQNCYyakxtJcm5E74
	J8fA2QZTqJpCcmgxL2PPGCMBaLGcVlTJ3BA==
X-Received: by 2002:a17:90b:3a4f:b0:3ab:5758:3757 with SMTP id 98e67ed59e1d1-3b41c98bec2mr15855830a91.61.1795579430408;
        Tue, 24 Nov 2026 20:03:50 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b495035339sm12649812a91.0.2026.11.24.20.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:03:50 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:03:49 +0000
Message-Id: <DN3ZSA718QIA.11EAQE8I69WJ8@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo" <harry@kernel.org>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-rt-devel@lists.linux.dev>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>, "David Hildenbrand"
 <david@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <awWRZ9xCzWLnj_R6@thinkstation>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation>
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

On Tue, Nov 24, 2026 at 05:59 AM Harry Yoo <harry@kernel.org> wrote:

>> +	/* The caller may hold a raw_spinlock_t. */
>> +	lock_map_acquire_try(&zone_nolock_map);
>> +	spin_lock_irqsave(&zone->lock, *flags);
>> +	lock_map_release(&zone_nolock_map);
>> +	return true;
>> +}
>
> I'm not sure this is a better solution unless this could be generalized
> or abstracted further.

Alright. Here is generalized one.

diff --git a/mm/internal.h b/mm/internal.h
index 85cf7be..1de6292 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1688,6 +1688,44 @@ static inline bool can_spin_trylock(void)
 	return true;
 }
 
+/*
+ * An IRQ handler can allocate at any point where IRQs are enabled, so a
+ * _nolock() caller can wait there for a lock that is IRQ-safe.
+ */
+static inline bool nolock_can_wait(void)
+{
+	return !IS_ENABLED(CONFIG_PREEMPT_RT) && !irqs_disabled() && !in_nmi();
+}
+
+/* @lock must always be held with IRQs disabled. */
+static inline bool spin_lock_nolock(spinlock_t *lock, unsigned long *flags)
+	__cond_acquires(true, lock)
+{
+	if (!nolock_can_wait())
+		return spin_trylock_irqsave(lock, *flags);
+
+	spin_lock_irqsave(lock, *flags);
+	return true;
+}
+
+/*
+ * The caller may hold a raw_spinlock_t. The map has to cover the critical
+ * sections of spin_lock_nolock() up to the unlock.
+ */
+extern struct lockdep_map nolock_wait_map;
+
+static inline void nolock_wait_begin(void)
+{
+	if (IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING) && nolock_can_wait())
+		lock_map_acquire_try(&nolock_wait_map);
+}
+
+static inline void nolock_wait_end(void)
+{
+	if (IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING) && nolock_can_wait())
+		lock_map_release(&nolock_wait_map);
+}
+
 /* char-mem.c */
 bool file_is_dev_zero(const struct file *file);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2fef409..f22ae49 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2550,7 +2550,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	int i;
 
 	if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
-		if (!spin_trylock_irqsave(&zone->lock, flags))
+		if (!spin_lock_nolock(&zone->lock, &flags))
 			return 0;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
@@ -3237,7 +3237,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 	do {
 		page = NULL;
 		if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
-			if (!spin_trylock_irqsave(&zone->lock, flags))
+			if (!spin_lock_nolock(&zone->lock, &flags))
 				return NULL;
 		} else {
 			spin_lock_irqsave(&zone->lock, flags);
@@ -8115,12 +8115,19 @@ static bool __free_unaccepted(struct page *page)
 
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
+DEFINE_WAIT_OVERRIDE_MAP(nolock_wait_map, LD_WAIT_CONFIG);
+
 struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
 {
+	struct page *page;
+
 	if (nid == NUMA_NO_NODE)
 		nid = numa_node_id();
 
-	return __alloc_frozen_pages_noprof(gfp_flags, order, nid, NULL, ALLOC_NOLOCK);
+	nolock_wait_begin();
+	page = __alloc_frozen_pages_noprof(gfp_flags, order, nid, NULL, ALLOC_NOLOCK);
+	nolock_wait_end();
+	return page;
 }
 /**
  * alloc_pages_nolock - opportunistic reentrant allocation from any context
diff --git a/mm/slub.c b/mm/slub.c
index 5c33d12..5bd00d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3821,7 +3821,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
 	n = get_node(s, slab_nid(slab));
 	if (allow_spin) {
 		spin_lock_irqsave(&n->list_lock, flags);
-	} else if (!spin_trylock_irqsave(&n->list_lock, flags)) {
+	} else if (!spin_lock_nolock(&n->list_lock, &flags)) {
 		/*
 		 * Unlucky, discard newly allocated slab.
 		 * The slab is not fully free, but it's fine as
@@ -3939,7 +3939,7 @@ static void *get_from_partial_node(struct kmem_cache *s,
 
 	if (alloc_flags_allow_spinning(ac->alloc_flags))
 		spin_lock_irqsave(&n->list_lock, flags);
-	else if (!spin_trylock_irqsave(&n->list_lock, flags))
+	else if (!spin_lock_nolock(&n->list_lock, &flags))
 		return NULL;
 	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
 
@@ -4543,7 +4543,7 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
 
 		if (allow_spin) {
 			spin_lock_irqsave(&n->list_lock, flags);
-		} else if (!spin_trylock_irqsave(&n->list_lock, flags)) {
+		} else if (!spin_lock_nolock(&n->list_lock, &flags)) {
 			/*
 			 * Unlucky, discard newly allocated slab.
 			 * The slab is not fully free, but it's fine as
@@ -5608,7 +5608,9 @@ retry:
 	 * kfence_alloc. Hence call ___slab_alloc() (at most twice)
 	 * and slab_post_alloc_hook() directly.
 	 */
+	nolock_wait_begin();
 	ret = ___slab_alloc(s, gfp_flags, node, ac);
+	nolock_wait_end();
 
 	/*
 	 * It's possible we failed due to trylock as we preempted someone with
