Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496883;
	b=t20A3E5dbhKvQ+qc0AomXt81APDn0baMkz0A0SH5k3eTthP4dcqjcn4R0j9A4oetfrc3
	 5wtSbGJ9owe6mKxAsCZYqJztLyUMsPCI9fp7kb4VSaksnHEyXim7YrUJNakW+IEZ5GSO2
	 N0u3FSTHUByRTezcImw0RnFYnFdHcAl4+Fju8v4YkB+GDvL/e+eH7fUf4XdaX61jRHsIh
	 FYS94IrbarAqvG1Cui9OgEalpcMt8uO/ESshEaoSRDn57S68H3NQ81hnTG1b/dM445n6D
	 I4qSChhBCTnMfquSW92KA1Qh4AdXbdtBBYTrfH2rtHiPVkfRQlMJsRidhsoUvLv9v0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496883;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2k9Pp8R0bWBJ2/Be4kIp/NqviaViJyrqHM3zzKX/Os4=;
	b=vlDQO+7l2b1I9HrmgQ603E1VKEDVhY/hivDtWXIFrA130RfUkV7OB+eRGDQUvhsNhkSw
	 h6g5wboV2nPJzd7Cs1RM+Da/o7/EvLe5ECFeiGW899vzS1jgvx1YjxPNjgLbzESfcbanT
	 m9gOwGh379v9dBAbSiMOD+88/wU/bwTjoXNh68H8zidf48hcU4KgMc3Nol2Nwq3ujxeiC
	 BQgTytO0MTM/EfGz/PW+NX6waYS4S/w7F7GItnS2DLvd3KR26W6/LP2FWDw7y4qcZ6WJX
	 0wddI3CVIutER8OzQ5Cjs+nEeOkDf5WeIDUlTsz88EAkleoc/7QLd+RVIKGSV+FcBqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HbQP09mZ;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465C60A2607;
	Thu, 12 Nov 2026 15:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E465C60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HbQP09mZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2k9Pp8R0bWBJ2/Be4kIp/NqviaViJyrqHM3zzKX/Os4=; b=HbQP09mZDCZTwfu11tESG/toXs
	/Clf2p3Q3g1YVQ/zDXzeeiJrrj4HkXxQy1UStS9GHnaAf6L7Gpgq5WxfJe1aZNqbqCZftcQjIo1nQ
	rKLQhdi82A6d5sQHKXEUVy9gyTIvSDMit/TzYT+9bFn0xiUqAdGepTTkNUZjeROkYK0T3m8Hv5mMR
	OmPqZaInqzuCs+RwxSVYI1Vm9Ng0Ry6eMwg3zlcVd7mNAmowFukrfD8kOQ7aGZYeKt+IY5YVROZMz
	ceRYWpsMZeU2yPjKqrug42xOK6eAEFHqlXyKAm2pZD/yCZvxhkoDRZ9eHTfKgrXm3sWWeZOOW8//s
	JoUXMJ3Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWc3-0000000AUYM-2OtI;
	Thu, 12 Nov 2026 15:21:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 936ED30057E; Thu, 12 Nov 2026 16:21:18 +0100 (CET)
Date: Thu, 12 Nov 2026 16:21:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, mingo@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 2/2] sched_ext: Block a retained donor before PI deboost
 routes it back to sched_ext
Message-ID: <20261112152118.GD1813469@noisy.programming.kicks-ass.net>
References: <20261112144935.583937-1-cui.tao@linux.dev>
 <20261112144935.583937-3-cui.tao@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112144935.583937-3-cui.tao@linux.dev>

On Thu, Nov 12, 2026 at 10:49:35PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> rt_mutex_setprio() is the only entry path into sched_ext that does not
> block a retained donor: an ext task PI-boosted by an rt waiter can
> block on a second kernel mutex while boosted, and on deboost is routed
> back to sched_ext carrying the queued+blocked state that
> scx_prepare_setscheduler() promises never happens; every PI cycle
> hands the BPF scheduler a queued+blocked donor it never admitted.
> 
> Call scx_prepare_task_sched_change() before the sched_change guard when
> the class change routes the task back to sched_ext, which performs the
> missing sched_proxy_block_task() (plus an update_rq_clock() that is
> harmless here: the clock was already advanced, so the second advance
> only applies a small delta). The boost direction (ext -> rt) needs no
> handling.

I can't understand this. And I take a very dim view of sprinking magic
hooks like this. So no.

The little I understand of things makes me think __setscheduler_class()
is buggy for EXT and *that* should be fixed.

> Fixes: be8be8acb268 ("sched_ext: Block proxy donors before taking control")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  kernel/sched/core.c    | 12 ++++++++++++
>  kernel/sched/ext/ext.h |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f7a452123ef5..dcb16b006740 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7816,6 +7816,18 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>  	if (prev_class != next_class)
>  		queue_flag |= DEQUEUE_CLASS;
>  
> +	/*
> +	 * PI boost can route @p out of sched_ext: policy stays SCHED_EXT but
> +	 * __setscheduler_class() follows the effective rt prio, and rt/fair
> +	 * may have retained @p on the rq as a blocked donor. Block it before
> +	 * sched_change_begin() records the queued state, the same way the
> +	 * other entry points into sched_ext do.
> +	 */
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	if ((queue_flag & DEQUEUE_CLASS) && next_class == &ext_sched_class)
> +		scx_prepare_task_sched_change(p);
> +#endif
> +
>  	scoped_guard (sched_change, p, queue_flag) {
>  		/*
>  		 * Boosting condition are:
> diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
> index d32bc01071b0..1a699be25331 100644
> --- a/kernel/sched/ext/ext.h
> +++ b/kernel/sched/ext/ext.h
> @@ -19,6 +19,7 @@ void scx_rq_activate(struct rq *rq);
>  void scx_rq_deactivate(struct rq *rq);
>  int scx_check_setscheduler(struct task_struct *p, int policy);
>  void scx_prepare_setscheduler(struct task_struct *p, int policy);
> +void scx_prepare_task_sched_change(struct task_struct *p);
>  bool task_should_scx(int policy);
>  bool scx_allow_ttwu_queue(const struct task_struct *p);
>  bool __scx_allow_proxy_exec(const struct task_struct *p);
> @@ -72,6 +73,7 @@ static inline void scx_rq_activate(struct rq *rq) {}
>  static inline void scx_rq_deactivate(struct rq *rq) {}
>  static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
>  static inline void scx_prepare_setscheduler(struct task_struct *p, int policy) {}
> +static inline void scx_prepare_task_sched_change(struct task_struct *p) {}
>  static inline bool task_on_scx(const struct task_struct *p) { return false; }
>  static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
>  static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
> -- 
> 2.53.0
> 
> base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
