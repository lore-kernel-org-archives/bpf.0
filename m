Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0A4FD7B2;
	Wed, 30 Sep 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773230; cv=none; b=He9hZecfCn4UFKHeMbzaINm5tMrvXpcZ8J13Vjvu7JQMvsiJuDrp8AM1P2mHNwHZgXVKkULcrRCBL/S5gKpdFgm9dh8zHRlHRdYmGjHelrpZ6DNy46peSDwzoRVXnzjGWfMnZf2OU3zpRQ03eMH1BGafC/+i3Bz45hZ759A4FQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773230; c=relaxed/simple;
	bh=fcIdDB5bjMWLXZ2y00ZKC9osUC2I6XgmKzizTSzXlWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uz697Dz1uwchuxh9+uzqBmsAQyy0ZoGtq2PEkTArs4FSyZ+IYFWi8mUTV6jVkLojbhLqjdz6CmRF+JH0uJcAhNpUPtopVAM5NAcIaA/38dzDVRgl14Nw2VhnP2EJqMvYV9OYCSr+aZPfmad51Q78pRTzeuW3t5mZBgKvg0T++A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbZOjzmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbZOjzmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997401F000FF;
	Wed, 30 Sep 2026 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773218;
	bh=RSVQr8YzOLpc7bt1klRaSVXgRVhT34fjQ7RFxwBtGYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KbZOjzmZn8DaYNiKsJpyDP/bCu+os1v8t9Pe0Ype9dEwbyq1UhufmzA9KrcigaUDy
	 gceBKX+NdC0520EfshYLOAVU9vyRmeRdQxPneZHjIv8jnMqDJhm7iIiirtkDQJyQKc
	 Rd8JTPl/w5PAlaprFCCUB+HPZNg4TfFKdTydFmbH4gWRhR7QZHUV6lFSercoddjQ5k
	 sBhj7ft/Ga5eG7yw0KXA8PhOFD9Vq2UCiooDrCmhOJygh/g08+TW67YOaSK8xaUlDP
	 z7MfgE//JG/FTwRfp2s5OFf3T0larzDrNnZO+X6RYaSnnGPheVFsRzVMN5BkeYZgj0
	 At426K15olJPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] kprobes: Make optprobe optimizer
 multi-generational and asynchronous
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179077195573.424772.14623269427412523026.stgit@devnote2>
References: <179077194409.424772.11709189894572687187.stgit@devnote2>
 <179077195573.424772.14623269427412523026.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:00:18 +0000
Message-Id: <20260930130018.997401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kprobes: double free/list corruption via double hlist_del_rcu() on=
 freeing_list
--

commit 713397faac31184a877c512a3215f1d8fc48a2f8
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Subject: kprobes: Make optprobe optimizer multi-generational and asynchrono=
us

This commit replaces synchronize_rcu_tasks() with call_rcu_tasks() by
introducing a multi-generational ring buffer. The kprobe optimizer now
unoptimizes probes and defers their cleanup asynchronously.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 4edd8ca5c6578..33523e9beb884 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c

[ ... ]

> @@ -624,67 +696,145 @@ static void do_free_cleaned_kprobes(void)
> =20
>  static void kick_kprobe_optimizer(void);
> =20
> -/* Kprobe jump optimizer */
> -static void kprobe_optimizer(void)
> +static void optprobe_generation_rcu_cb(struct rcu_head *rcu)
>  {
> -	guard(mutex)(&kprobe_mutex);
> +	struct optprobe_generation *gen;
> +
> +	gen =3D container_of(rcu, struct optprobe_generation, rcu);
> +	WRITE_ONCE(gen->ready, true);
> +	wake_up(&kprobe_optimizer_wait);
> +}
> +
> +static void optprobe_finalize_generation(struct optprobe_generation *gen)
> +{
> +	struct optimized_kprobe *op, *tmp;
> +
> +	lockdep_assert_held(&kprobe_mutex);
> =20
>  	scoped_guard(cpus_read_lock) {
>  		guard(mutex)(&text_mutex);
> =20
> -		/*
> -		 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> -		 * kprobes before waiting for quiesence period.
> -		 */
> -		do_unoptimize_kprobes();
> +		/* Optimization never be done when disarmed */
> +		if (!kprobes_all_disarmed && kprobes_allow_optimization &&
> +		    !list_empty(&gen->optimizing_list))
> +			arch_optimize_kprobes(&gen->optimizing_list);
> +	}
> +
> +	/* Free cleaned kprobes after quiescence period */
> +	do_free_cleaned_kprobes(&gen->freeing_list);
> +
> +	/* Finalize unoptimized kprobes whose quiescence period completed */
> +	list_for_each_entry_safe(op, tmp, &gen->cooling_list, list) {
> +		if (kprobe_unused(&op->kp)) {
> +			/*
> +			 * Unregistered while quiescence period was in flight.
> +			 * Remove from hash list and move to cur_gen's freeing list.
> +			 */
> +			hlist_del_rcu(&op->kp.hlist);
> +			list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);

[Severity: High]
Does this code risk list corruption via a double free?

If a kprobe in the cooling_list becomes unused and is unhashed here, it is
moved to the current generation's freeing_list.

When this current generation is later dispatched, do_unoptimize_kprobes()
will iterate over its freeing_list (passed as free_list):

kernel/kprobes.c:do_unoptimize_kprobes() {
    ...
    list_for_each_entry_safe(op, tmp, free_list, list) {
        ...
        if (kprobe_unused(&op->kp)) {
            hlist_del_rcu(&op->kp.hlist);
        }
        ...
}

Will this unconditionally call hlist_del_rcu() a second time on the same
probe, causing a regression by dereferencing LIST_POISON2?

> +			kick_kprobe_optimizer();
> +		} else {
> +			/* Still in use; now safely disarmed */
> +			list_del_init(&op->list);
> +			if (!kprobe_disabled(&op->kp))
> +				optimize_kprobe(&op->kp);
> +		}
> +	}
> +
> +	gen->in_flight =3D false;
> +	WRITE_ONCE(gen->ready, false);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179077186716.424323=
.12884899073547396948.stgit@devnote2?part=3D1
