Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCF314D37
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391076; cv=none; b=uRkYrmG84CgoYg7Gj+GihzwMGZ/wNhhIXYW0Ks1d287YeIPaiDcPwxR02FszaRMZhcjjjmKHG7R3XWRZjXDBIQdGAIQ7RdvWVec0VfXBYZnJ2wJV3PYz74w83tasKWPrKKkBupfDaQ+pihiVGJYo0ORmre9hNHnpWjfsAH9YnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391076; c=relaxed/simple;
	bh=Quymnn6v3oWWNi68G9XB4Ae9bWzZD0vzHgSdOHy2TQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkZcfv/UBM1COs71ilrvx9uMDcqRJbhZgbjanKqkk2FMqOWV2lacQbaaRkcwKf3RrYaxp01BsVQAAyTyJFcGps1rSv0whgZUDLygLVROBeSBnQCaY9fnhv+69WH1EPeooWXixCbjn9Rr2WcMoB2BFDRJF9rO6U3JJM45DKSqLt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPII8gR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPII8gR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A771F000E9;
	Mon, 10 Aug 2026 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786391075;
	bh=c4LIfw+QCKEovo/Vc9IwwXLJoTVydwIkRT1EGc6J81U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bPII8gR/JsHpIQo5SJCi99dkZDbqtz7BfQ6lV0qublZR015zpMzdIC3CfPEuiUMi2
	 X824i6hFB64nWfPMGhVpy2XC/NywUwZWt0hQ270Y0FzR8YZ7vu7rJCRvlB/ALX2BqP
	 4GlaPD5ZXrhMos9PYKigEr9ZuNMIC+bm8OjwLSwrJumkd5pN9rQVL0aKsA1EHgy+B0
	 wtrKTaGVVQ01QXKlYfPxFUsjXwhmYHUaniXCr3bwAx332nK8MRlBvDXUAU2qjY9B8x
	 uCFW7fHmCiqDTl7Insr1InDK+DXvwbCF6QfDgRwyqdSy8Ymg1d/IPRTj/qVwQ9CJPW
	 GL15FshuY17bg==
Date: Mon, 10 Aug 2026 09:44:34 -1000
From: Tejun Heo <tj@kernel.org>
To: imran.f.khan@oracle.com
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/6] workqueue: introduce BPF iterators for
 workqueues, worker pools and pending work
Message-ID: <anoqInQifh6cCxp3@slm.duckdns.org>
References: <20260728065525.653171-1-imran.f.khan@oracle.com>
 <am6ydQ0kl-KVOf_F@slm.duckdns.org>
 <53158355-f12f-4efe-a480-1c375f8583ff@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53158355-f12f-4efe-a480-1c375f8583ff@oracle.com>

Hello,

On Thu, Aug 06, 2026 at 04:41:01PM +0800, imran.f.khan@oracle.com wrote:
...
> When a bio exceeds the threshold it walks the open-coded
> worker_pool and workqueue iterators and prints what it finds:
> 
>   fio-2409 [003] 1246.736278: STALL: dm-crypt bio took 950434 us; sampling workqueue state now (cpu3)
>   fio-2409 [003] 1246.736282:    pool 10 cpu 2: no progress for 935 ms, work_waiting=1, running=0 idle=3/3
>   fio-2409 [003] 1246.736285:    pool 22 cpu 5: no progress for 934 ms, work_waiting=1, running=0 idle=3/3
>   fio-2409 [003] 1246.736299:    wq kcryptd_i: max_active=1 flags=0x148
>   fio-2409 [003] 1246.736300:    wq kcryptd-2: max_active=1 flags=0x168
> 
> In order to reproduce the issue easily I had RT threads hogging the CPUs and
> thus preventing timely run of workers.
> 
> Another limitation with drgn and traces is that often the production systems
> don't have drgn and/or debuginfo installed and sometimes the systems are itself
> in such a bad shape that running drgn becomes challenging.
> For such cases as well, a quick look into the bpffs to find pending works
> (like shown below) helps:
> 
> cat /sys/fs/bpf/dm_pending
>   pool=2   work=0xffff9987afc27c48 func=delayed_vfree_work+0x0/0x50
>   pool=6   work=0xffff9987afc67560 func=vmstat_update+0x0/0x50
>   pool=14  work=0xffff998484b39e20 func=kcryptd_crypt+0x0/0x310 [dm_crypt]
>   pool=22  work=0xffff9987afd67560 func=vmstat_update+0x0/0x50
>   pool=26  work=0xffff9987afda7560 func=vmstat_update+0x0/0x50
>   pool=30  work=0xffff9987afde7560 func=vmstat_update+0x0/0x50
> 
> If the issue happens randomly in short windows of few secs, collecting
> the traces for long intervals and looking for data of that short window is
> not easy.
> 
> These are the use cases/limitation I had in mind. Could you please let
> me know your thoughts?

I feel a bit conflicted because this is something only useful for debugging
and doing this subsystem-by-subsystem would mean hard coding data structure
iterators and accessors into every subsystem, when there already is a
generic, albeit with different trade-offs, way to access about the same data
through debug info and vmcore (ie. drgn).

Even in the example you gave, if you had a standing drgn script running and
trigger it on timeout threshold, it'd be able to produce the same data
that's needed. It's more cumbersome but it's also more generic and flexible.
If you really want to do it in BPF, it's not *that* difficult to write an
adhoc iterator with bpf_core_read() and friends either.

So, my concern mostly is that the use cases seem to restricted. There's no
"production" usefulness where e.g. performance or overhead matters which I
think makes the full-on iterators somewhat over-engineered.

Thanks.

-- 
tejun
