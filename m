Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998115;
	b=Bf89FgkjcdbeWhvC7sA0O40l1Qr+6/r7t6/GeGg3WHcdCz7lz1pMi6i6Ce9hBAM2vCd9
	 pLhqpjCYD2c/B8yqvS+q3Q9fbQObo5Od5gV7IOyj8nOfTQjax90ccNM6XD2ttqMpIhaHE
	 ZLYSLmXfhdSkUIiIbFKuI1xbQ2+iFTo1/K1Jcw7b9Go+BAPIyRSPu7A91fuFEZ4/AmsvM
	 2Hr7GKLEKR3/hKIop1Jka+YjlBhtOUkAnxfEcFMbRWKeL4Xj8OPS6LE88be1Vji6IrfMV
	 H/fUj31eBME4SmE1qTL4Nz5FUD43IzaE+QjOkNRp+hHATbYlidz/0uI28WSPZYi+Ptw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=V/rcDmWi1GhtPKbEjFzCUZhJ8UrOGyK/nBYXCR03k6k=;
	b=BLT9gVNN82Bjaa1TjSni249VHEVILPThDEkFEKqMAGaN8tEz77oRkJfLN+qs3kSeHplb
	 K62AhGikLoVDF99zQW1in+FA6QN76CLDrrek6/pRWv1bjacVz5zFZR8coGHcc3l4F2Bl7
	 y76tT41VEdaNDexMvKoJWGRjsgP+MOYn5HqnZO7kGZECUJ0M7dAV0Y+Cv2fQjn7jkGrlw
	 szd2Nm4fgBBd7x1ZxHojIXOWKJ82AQXhNMRS2sVjF038ZOZZbvTxKTlDcL+LaeblVDpwn
	 CngNFLVYF3/7UzDhYL2v7fNdAW1uSStPVD6FF8+sLflb1eAOS0IRYinsl8WdpjjzAUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eEQaPypI;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D8606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 10:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F5D8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eEQaPypI
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso1933355e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 02:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998113; x=1795602913; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V/rcDmWi1GhtPKbEjFzCUZhJ8UrOGyK/nBYXCR03k6k=;
        b=eEQaPypIwfhomdAqEvFeeYyFXJIk1zUNJ4899C3azLdFLU3mWkK9maUI1it27Aopnf
         Yizybi1/pD9i0ZCeQITUUuNG8TntDtwcqEbtyVwbh58Xwd5n9dG+A+BEsRPPgxbkaLkB
         ySRo4NRcQh2C1mKZvddkxfB/au0fyXHnAh68lVNdDTRbVW+fc11Sksno+oER3qnxUNgH
         pAsP8hvtnKppFMoqZGOGNyLDYukOVcJJrVuSb/9HTWERBnsN+5IyI1O6Ol1Ot2Ieef9L
         zvR52lKXr7fiB/GWfn1C7aidLj0NBH/uWMnEG41mlTIhuKwbVrxEPac4eMA4r9U+c8qr
         o+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998113; x=1795602913;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/rcDmWi1GhtPKbEjFzCUZhJ8UrOGyK/nBYXCR03k6k=;
        b=EGpMU67U22+AfJJEk9jmkdbls111TMTE1DxwukgVLHKCV00JI9V/8fGl1MpznXRTY+
         R7BKlSHcK7kPPcQYRDrAFpK5GD8i5ibilwCbSmCC/S6rfW+fDawTbNkhc0H3XJJZckdI
         317d4eu/imdgsm1tkeueYuA2LBsYpeQM2OkPLaZfKp0gYfWBD0uOtPujQdzeZztqRn+A
         B8PQ0Ff9F3AraJXcJVgE5d2FEzIt3WJ7b6hHTRlrJzI+Vh7BK0dHWjJM3PzENMu4pGRz
         ZAImxwxtd/kqpb418BC6mb3lFmTFZ3myoaZqyk9YPFOuxH7LQgN5oOe2jxGuyv2wUuPV
         yecA==
X-Forwarded-Encrypted: i=1; AL+hErEfDOlQp9CDMo8TZWir3KezqzyPvosLxTmPlXiNA+F5rVif+PBK2d1NTi3OzYYriYIM5ww=@vger.kernel.org
X-Gm-Message-State: APuU4Z/i35IL47bjhi0LR6txwYwTVBRx9NszqRr0zQ4z79Xk22xZQ/TH
	8JJ6kLdYqnNWTx7xryIAz0olUoo3+PgCjT8gS/oW5LyJlHDnxqFGJhzd
X-Gm-Gg: AYBFou2kCaUHRADVxdlQC6pbz7+cGFm1QQjH/pEm9B+d4gJLoDJ9EvxDmjApAG5bReV
	V1LBSC2RiVZR+wHhbUXMcajtCcqN+txkDDtVaRGrToUImdwiHYXCfRYyGpEV80Yzi+/04rKWFRL
	WcbccVEjZiVrePmHJG+YsXNGCSt9hZGkpws3yVdKTLT9o/dnt/UeFkbGzrpo0yO+quWhepErWyp
	m8Bz46w/TfzJ74cw4z4mIN6FFiQ5dI1Rn3nuVeVAYgKCXq/+RSTj3hSchFInjgfIuL8tnYfOJEt
	5hDO+UOwdBDmxDifyrRVxo/mqHR5+Fum/J6Cy8rxsndZYmogLLusxT3buMqeMUBkJ/igZKyJs6g
	ht94it/284ttPln3faIwYN1PqHFpDoUs0sBdPzwxRNeSeY0Ye2P4C9umqRfDbcqILa8sfrc7Y8s
	DyfDyWkkl6+qpQWgMSLQ1l0p/xF5PO5dt8zRQPrNNREiAWiWqbLc8yeJzYrYX4E4s+p8sIYGGu8
	0CbuDwXWnqlSj8Bdp8tGC95wgVaY3UYwXj4SDlXOe+WyR3SntKD6D1jIFzTUi7NbvB0QXZMXzZj
	WYCCAE+MCPzBO40DZnkL8B6ks9gj1SRZU0IG/aTMMuN0ffS5ER2shc5t80QFGHwFbQf/5Y7MoX3
	TVMHR87MpTc+h/P9e7HlXTkwA6vuvlPmMQKr2M9IqG92kbenA4jF9XEMIVepFNZp3FGxY
X-Received: by 2002:a05:600c:4e02:b0:4bb:6b59:aac3 with SMTP id 5b1f17b1804b1-4bb7da44054mr39406725e9.29.1794998113097;
        Wed, 18 Nov 2026 02:35:13 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78346f4asm144465015e9.0.2026.11.18.02.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 02:35:12 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 11:35:11 +0100
Message-Id: <DMY9Q4RMBKLM.2F6A6DVPXCTOH@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] rqspinlock: Reset tail if no waiter queues behind
 the queue head
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Shashank Mohan Jain" <jain.sm@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>
X-Mailer: aerc 0.21.0
References: <20261117225023.36660-1-jain.sm@gmail.com>
In-Reply-To: <20261117225023.36660-1-jain.sm@gmail.com>

On Tue Nov 17, 2026 at 11:50 PM CET, Shashank Mohan Jain wrote:
> When the head of the wait queue claims the lock and its cmpxchg from
> n,0,0 to 0,0,1 fails, it sets the locked bit and waits for node->next,
> with no timeout. The comment, taken from qspinlock, says the cmpxchg
> can only fail if somebody queued behind us, or if a waiter set PENDING,
> which will then see our tail and queue behind us.
>
> In rqspinlock that waiter does not always queue. After clear_pending()
> it goes to queue:, and two paths return -EDEADLK there before
> xchg_tail():
>
>  - the trylock fallback for an NMI waiter whose per-CPU node is busy
>    (in_nmi() && idx > 0), or when idx >=3D _Q_MAX_NODES;
>  - check_deadlock_AA(), when this CPU already holds an entry for the
>    lock.
>
> For example, with the queue head H alone in the queue:
>
>   CPU 0 (H, head)                    CPU 1 (NMI, idx 1 on another lock)
>   reads lock->val =3D=3D H,0,0
>                                      queued_fetch_set_pending_acquire()
>                                        sees tail H
>   try_cmpxchg(H,0,0 -> 0,0,1) fails
>   set_locked()          -> H,1,1
>                                      clear_pending()   -> H,0,1
>                                      in_nmi() && idx > 0, trylock fails
>                                      return -EDEADLK
>   waits for node->next ...
>
> H now owns the lock and spins until another context queues on the same
> lock. For a lock that is rarely taken, such as a hash map bucket lock,
> that can be a long time, with interrupts disabled, so it shows up as an
> RCU stall or a hard lockup. The same happens on v6.17 and v6.18 for any
> NMI waiter, as the trylock fallback was used for all of them.
>
> The AA path needs the interrupted context to have taken its entry for
> the lock and not to try the lock again, so it is much narrower.
>
> While waiting for the successor, reset the tail if it still points to
> us, as the deadlock and timeout exits already do, and keep the lock. If
> the tail has moved, a waiter has done xchg_tail() and will link into
> our node, so keep waiting for it. try_cmpxchg_tail() reads the lock
> word first, so the loop only adds a plain load while a successor
> finishes linking.
>
> Found with a TLA+ model of the slow path. A userspace port of the slow
> path, driven through the interleaving above, hangs without this change
> and completes with the lock word clean with it. I have not reproduced
> the hang on a running kernel.
>
> Fixes: 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters=
")
> Fixes: 087849cca31d ("rqspinlock: Precede non-head waiter queueing with A=
A check")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
> ---

I am aware of this one, but I don't think it's that serious (of course, nee=
ds to
be fixed). I was going to send it in a couple weeks with some other changes=
 for
rqspinlock. For the next version, let's drop Cc to stable and target bpf-ne=
xt.

How about the approach below instead that I have? You could check whether t=
he
violation in your TLA+ model goes away. The benefit is that we don't penali=
ze
the loop that waits for next, for this very rare condition that is not like=
ly to
be hit.

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 111ec80ea958..f6a938ee7ab4 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -624,20 +624,23 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rq=
spinlock_t *lock, u32 val)
         * Otherwise, we only need to grab the lock.
         */

-       /*
-        * Note: at this point: (val & _Q_PENDING_MASK) =3D=3D 0, because o=
f the
-        *       above wait condition, therefore any concurrent setting of
-        *       PENDING will make the uncontended transition fail.
-        */
        if ((val & _Q_TAIL_MASK) =3D=3D tail) {
-               if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_=
VAL))
-                       goto release; /* No contention */
+               u32 new =3D _Q_LOCKED_VAL;
+
+               for (;;) {
+                       if (atomic_try_cmpxchg_relaxed(&lock->val, &val, ne=
w))
+                               goto release; /* No queued successor */
+                       if ((val & _Q_TAIL_MASK) !=3D tail)
+                               break;
+                       /* A pending claimant can abandon before publishing=
 a tail. */
+                       new =3D _Q_LOCKED_VAL | (val & _Q_PENDING_MASK);
+               }
        }

        /*
-        * Either somebody is queued behind us or _Q_PENDING_VAL got set
-        * which will then detect the remaining tail and queue behind us
-        * ensuring we'll see a @next.
+        * A different tail proves that a successor will publish node->next=
.
+        * Preserve pending while installing ownership; a racing claimant m=
ay
+        * still be undoing its speculative reservation against this queue.
         */
        set_locked(lock);
