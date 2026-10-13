Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07D4DD3A5;
	Tue, 13 Oct 2026 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888974; cv=none; b=I2Fgz1MRv9bfYnRISbsLsJcW6myH1mEUZf3MoTaQuQvHN/xSCJZ8GvVl9+LBXbY8inIwIKKCVUTho7B36BQZm5PDDiAhkFhvn1LJCR4Na1ojg0eRoBLRZy66auWvY0Tu5krZeiF0tIDqShs1Ns6bp2RjYFHG6nC4+8+v5/4+psc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888974; c=relaxed/simple;
	bh=4t0gCc5/hnG5MdZFl+mUnNykwiB4BkNHEzAvZyd2x78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkAyKJU5oDyyJnd0NEnQh0v7P1/Vkq0ZnLDYqNRhwzX4caKif/KZdg5MN+HUJPVKqoM+H4irpWGdxlNDSlV7WGpYU7iQEoWn7g8TJHqWaY8ne8Vx38vHwE6CgUQJfI2K8vb5fP/XWhI+URNlT6//+lMQ3dPGkxvFQnxEKp92Rd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEJDgx6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEJDgx6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B21F000FF;
	Tue, 13 Oct 2026 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888969;
	bh=InFvmS159g9aQRWPNx+KZVWPATxltcajLyea5HuyXhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hEJDgx6MhjjvXttf0Cvr9s0JcYPqpMKzeiu6WJbLQkv1zbbf1AyC6XSUbNzhd4YTR
	 DWiifbMZ8pg8Md5c/dPrPLHDAGfv8CRjDZvWhf5IJgk6HPml2zGHdmLL9oGyCGkuee
	 eQ4C+ALX0/C3dxioSxIlWwIPG5eSpgm5LehVJ/koLWiJx4l7iOouVd9FvTKUwstnLz
	 /QyDJLE4Fb/4jzkskTT0x/dAU+d9y8zvLOq5LG5GPAXwlSI15z+yTmPfYuVT3oN6zT
	 TMdtBav2ldb+1/b6c2Uw8sQrWlkjAOd+Df83liN7Sxxa+ZNoMMfNnCZd/oo/fBMpDy
	 ptM9BDragGpJg==
Date: Tue, 13 Oct 2026 11:56:04 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev-bot+sashiko@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, edumazet@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	sdf@fomichev.me, sgoutham@marvell.com
Subject: Re: [PATCH v19 net-next 2/2] octeontx2: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <20261013105604.GB83879@horms.kernel.org>
References: <20261006094357.840823-3-rkannoth@marvell.com>
 <179162647058.434549.12221340477037180415@kernel.org>
 <asxY6cs5os_q3mAA@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asxY6cs5os_q3mAA@rkannoth-OptiPlex-7090>

On Mon, Oct 12, 2026 at 09:20:01AM +0530, Ratheesh Kannoth wrote:
> On 2026-10-10 at 15:31:10, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> > Thank you for your contribution! Sashiko AI review found 12 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 1 · Medium: 9 (1) · Low: 2 (1)
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [High] There is a use-after-free race on the deferred netdev_tc_work
> >   during device removal.
> 
> Not addressing this one; the window is theoretical and the impact is nil in practice.
> 1. It needs a failing "tc qdisc replace" (validation failure on an existing
>    offload) to run on CPU A at the exact moment the PCI remove runs on CPU B,
>    with A reading defer_tc_work just before B sets it. The netdev is already
>    being torn down, so this is not a realistic configuration path.
> 2. Even if the work is queued in that window, it is a no-op: the handler
>    checks defer_tc_work (set by remove) and returns before taking RTNL or
>    touching any other state. The only access is that single flag read.
> 3. A use-after-free would also need system_wq to leave the item undispatched
>    for the whole remainder of remove (unregister_netdev, destroy_workqueue,
>    mbox teardown, AF detach, ...) until free_netdev(). That is not a
>    realistic scheduling delay.
> The flag is accessed with READ_ONCE()/WRITE_ONCE() and ordered by smp_wmb()
> before cancel_work_sync(), so any tc command that starts after shutdown
> begins will see it and not queue the work.
> 
> > - [Medium] Offload state is leaked when qdisc teardown fails.
> 
> Not addressing this one; the trigger is very rare and the failure is reported.
> The path only runs if the AF mailbox request that clears the per-queue
> shapers (otx2_nix_tm_clear_queue_shaper()) fails during "tc qdisc del". That
> means the AF/mailbox is already in a fault state, which is not a normal
> runtime condition.
> In that case the driver prints error message.
> Keeping the state is deliberate. The shapers are still programmed in
> hardware, so the cached rates and rate_limit continue to describe what the
> hardware is doing, and they are reapplied consistently on the next open.
> Dropping the software state while the hardware shapers are still active would
> leave the two out of sync.
> The core cannot veto qdisc teardown (mqprio_disable_offload() is void), so the
> driver can only report the error, which it does.

...

Reviewed-by: Simon Horman <horms@kernel.org>

