Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF426982C;
	Thu,  1 Oct 2026 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790813463; cv=none; b=EUnPB6Pb2eIC9c4ieockiMyg/77cFB5/N488J/GTqsoyZFWQhba4yMuXzutTaSQQiM1r/LPLEeNE5AALNWmojiTglYnnppShlU7vG2cltrS2KzPZjiHeiOgPbFb4YaTwpEykOPl6vgkDo1ABJcE7NRChrtoh3lgxqZfwf6f/ies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790813463; c=relaxed/simple;
	bh=5hHv8WZ2orf7JHJYxSHBmYav8i8Ox+ppumgrQYSrNe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDobTPnDuuuXoXMIbJcKHAyN7RL35GI86xHsLS6yydjK2jkgAvQoDdLw5IDsgtpIx8FUg33Rl8sG+urhnPCQpJbSKyPG0K5MjjqJCpj1FDqhV2+xxxC5k4i2tv7kTQ2dyUNhokElWOdmklLng2qEejWkFT70todtVKi5Zug6MBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjZFgVl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjZFgVl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616931F000FF;
	Thu,  1 Oct 2026 00:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790813459;
	bh=fCJPRyf9ct3sLbdw0tgQaR2BtsDQPHhDkxUobjUpC+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jjZFgVl15uSrbLMiuvIThzZ38o0cP7MOsgVII4vwK0QDfdaoSlV7Dzns9c5zgrcXZ
	 XAgmBVu7wlFLbxYdrpRS+7h8NOIP1wrR4OJPWXcNfkiJEM3P64c1kULgAI4G0weT4J
	 6+k4loGWKcZ8DcQruLUkDl38IDajOBplPyebQ36CVpbFHhMORRGm66SPWjG7o7OVPJ
	 cZLnWgAEWIqSc3dv0wDlilkWpxhr6AqutVPpjnzKtCx+u9rSeOSVJa01d4mPMCOzJt
	 cVix5PV5C/fDJp3OeOBMzjONFyagFm5GgFVpQQPYBu5BfxR7t658dpBITYl/McpmV/
	 je92iTjRMPPVw==
Date: Thu, 1 Oct 2026 00:10:52 +0000
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kprobes: Make optprobe optimizer
 multi-generational and asynchronous
Message-ID: <20261001001052.732c3c12@mhiramat99.roam.internal>
In-Reply-To: <20260930130018.997401F000FF@smtp.kernel.org>
References: <179077194409.424772.11709189894572687187.stgit@devnote2>
	<179077195573.424772.14623269427412523026.stgit@devnote2>
	<20260930130018.997401F000FF@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 13:00:18 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] kprobes: double free/list corruption via double
> hlist_del_rcu() on freeing_list --
> 
> commit 713397faac31184a877c512a3215f1d8fc48a2f8
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Subject: kprobes: Make optprobe optimizer multi-generational and
> asynchronous
> 
> This commit replaces synchronize_rcu_tasks() with call_rcu_tasks() by
> introducing a multi-generational ring buffer. The kprobe optimizer now
> unoptimizes probes and defers their cleanup asynchronously.
> 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 4edd8ca5c6578..33523e9beb884 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c  
> 
> [ ... ]
> 
> > @@ -624,67 +696,145 @@ static void do_free_cleaned_kprobes(void)
> >  
> >  static void kick_kprobe_optimizer(void);
> >  
> > -/* Kprobe jump optimizer */
> > -static void kprobe_optimizer(void)
> > +static void optprobe_generation_rcu_cb(struct rcu_head *rcu)
> >  {
> > -	guard(mutex)(&kprobe_mutex);
> > +	struct optprobe_generation *gen;
> > +
> > +	gen = container_of(rcu, struct optprobe_generation, rcu);
> > +	WRITE_ONCE(gen->ready, true);
> > +	wake_up(&kprobe_optimizer_wait);
> > +}
> > +
> > +static void optprobe_finalize_generation(struct
> > optprobe_generation *gen) +{
> > +	struct optimized_kprobe *op, *tmp;
> > +
> > +	lockdep_assert_held(&kprobe_mutex);
> >  
> >  	scoped_guard(cpus_read_lock) {
> >  		guard(mutex)(&text_mutex);
> >  
> > -		/*
> > -		 * Step 1: Unoptimize kprobes and collect cleaned
> > (unused and disarmed)
> > -		 * kprobes before waiting for quiesence period.
> > -		 */
> > -		do_unoptimize_kprobes();
> > +		/* Optimization never be done when disarmed */
> > +		if (!kprobes_all_disarmed &&
> > kprobes_allow_optimization &&
> > +		    !list_empty(&gen->optimizing_list))
> > +
> > arch_optimize_kprobes(&gen->optimizing_list);
> > +	}
> > +
> > +	/* Free cleaned kprobes after quiescence period */
> > +	do_free_cleaned_kprobes(&gen->freeing_list);
> > +
> > +	/* Finalize unoptimized kprobes whose quiescence period
> > completed */
> > +	list_for_each_entry_safe(op, tmp, &gen->cooling_list,
> > list) {
> > +		if (kprobe_unused(&op->kp)) {
> > +			/*
> > +			 * Unregistered while quiescence period
> > was in flight.
> > +			 * Remove from hash list and move to
> > cur_gen's freeing list.
> > +			 */
> > +			hlist_del_rcu(&op->kp.hlist);
> > +			list_move(&op->list,
> > &optprobe_gens[optprobe_cur_gen].freeing_list);  
> 
> [Severity: High]
> Does this code risk list corruption via a double free?
> 
> If a kprobe in the cooling_list becomes unused and is unhashed here,
> it is moved to the current generation's freeing_list.
> 
> When this current generation is later dispatched,
> do_unoptimize_kprobes() will iterate over its freeing_list (passed as
> free_list):
> 
> kernel/kprobes.c:do_unoptimize_kprobes() {
>     ...
>     list_for_each_entry_safe(op, tmp, free_list, list) {
>         ...
>         if (kprobe_unused(&op->kp)) {
>             hlist_del_rcu(&op->kp.hlist);
>         }
>         ...
> }
> 
> Will this unconditionally call hlist_del_rcu() a second time on the
> same probe, causing a regression by dereferencing LIST_POISON2?

Oops, good catch! Since there is no reason to remove it from hash
in optprobe_finalize_generation() (it can be reused), I will drop
the hlist_del_rcu() from there.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
