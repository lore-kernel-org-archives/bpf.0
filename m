Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F326E71E
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770925896; cv=none; b=JlC+0SdkMxoxwBFHbZTWN8pDPykrs39ntKb7ZpIB2sFIGtgtLMW2/nzP42ClKSeOrK198r9FPgfPWDGxS7j1HV0lhPmqD1nWQ0JjcrzOtwaRcLob9pbKrArVt0VfjpnMFUZiYA5Z/tnoEgivdzVy1co+aEHsLAg9I2mksqcg5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770925896; c=relaxed/simple;
	bh=NmMgFLcW5nYNy4thm118Jnz/rUv/qOKosA46S6z+5pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tn2ActAMb1YRa4WGVCSs7bQ9KxEdhihR8YVB+ezxq+RMS7W/nmx8Ez6dlExioxbeYvcndelcTd3a6BqdpRL+s4cZBeYP3drQZmioYBpGCIiOlXf6LH8x/PO6Y9yOESXcC9co3GdobDC45a5Z6T3KU/dtg99fQKJ/5VMbwAMKTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iIQ05QsF; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iIQ05QsF"
Message-ID: <64e56f03-bc93-46c1-8d5e-fa9720821620@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770925892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjLn5wIj9coH3h+DlcNBjJcyYQgJzJNYhtRL0NoCUKQ=;
	b=iIQ05QsFhxDOPR9BDn0FMx097l7BUzGms0xcnPeEBEi0AQ/dqpcAUyrVOdJC9VWLFNKlcq
	n2Ek5CWHbD4suZKuUHNo0kHDHL1kOD9ohOJxhZpVKtj/N/4wLqhVW7DfIN0e22dX0P0FQB
	h6KBlXvri6aSJTXA3s9WJecYYJvaOL4=
Date: Thu, 12 Feb 2026 11:51:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: fix: Race condition in
 bpf_trampoline_unlink_cgroup_shim
To: xulang <xulang@uniontech.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 dddddd@hust.edu.cn, dzm91@hust.edu.cn,
 hust-os-kernel-patches@googlegroups.com, kaiyanm@hust.edu.cn, sdf@fomichev.me
References: <dd71a6ff-929d-4958-ac73-99b4852808e4@linux.dev>
 <68AC3CE38AB1BD07+20260206071357.4075301-1-xulang@uniontech.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <68AC3CE38AB1BD07+20260206071357.4075301-1-xulang@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2/5/26 11:13 PM, xulang wrote:
> Based on Martin KaFai Lau's suggestions, I have created a simple patch.

Thanks for the patch.

> 
> The root cause of this bug is that when `bpf_link_put` reduces the
> refcount of `shim_link->link.link` to zero, the resource is considered
> released but may still be referenced via `tr->progs_hlist` in
> `cgroup_shim_find`. The actual cleanup of `tr->progs_hlist` in
> `bpf_shim_tramp_link_release` is deferred. During this window, another
> process can cause a use-after-free via `bpf_trampoline_link_cgroup_shim`.
> 
> To fix this:
> 1. Add an atomic non-zero check in `bpf_trampoline_link_cgroup_shim`.
>     Only increment the refcount if it is not already zero.

This makes sense.

> 2. Guard the freeing of `shim_link` with `tr->mutex` to prevent release
>     while the mutex is held.

I am not sure about this one (details below).

> 
> Testing:
> I used a non-rigorous method to verify the fix by adding a delay in
> `bpf_link_put` to make the bug easier to trigger:
> 
> void bpf_link_put(struct bpf_link *link)
> {
>          if (!atomic64_dec_and_test(&link->refcnt))
>                  return;
> +       msleep(100);
>          INIT_WORK(&link->work, bpf_link_put_deferred);
>          schedule_work(&link->work);
> }
> 
> Before the patch, running a PoC easily reproduced the crash (often within
> dozens of iterations) with a call trace similar to KaiyanM's report.
> After the patch, the bug no longer occurs even after millions of
> iterations.
> 
> Signed-off-by: xulang <xulang@uniontech.com>
> ---
>   kernel/bpf/trampoline.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 976d89011b15..c16a53cca5e0 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -702,15 +702,23 @@ static void bpf_shim_tramp_link_release(struct bpf_link *link)
>   		return;
>   
>   	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link, shim_link->trampoline, NULL));

bpf_trampoline_unlink_prog() will hold (/wait) for tr->mutex before 
unlinking from tr. The link's refcnt is already 0 here.


> -	bpf_trampoline_put(shim_link->trampoline);
>   }
>   
>   static void bpf_shim_tramp_link_dealloc(struct bpf_link *link)
>   {
>   	struct bpf_shim_tramp_link *shim_link =
>   		container_of(link, struct bpf_shim_tramp_link, link.link);
> +	struct bpf_trampoline *tr = shim_link->trampoline;
>   
> +	if (!tr) {
> +		kfree(shim_link);
> +		return;
> +	}
> +
> +	mutex_lock(&tr->mutex);

The link_release is done before the link_dealloc. Why it needs to hold 
(/wait) for the tr->mutex again?

>   	kfree(shim_link);
> +	mutex_unlock(&tr->mutex);
> +	bpf_trampoline_put(tr);
>   }
>   
>   static const struct bpf_link_ops bpf_shim_tramp_link_lops = {
> @@ -800,10 +808,8 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>   	mutex_lock(&tr->mutex);
>   
>   	shim_link = cgroup_shim_find(tr, bpf_func);
> -	if (shim_link) {
> +	if (shim_link && atomic64_inc_not_zero(&shim_link->link.link.refcnt)) {

Use bpf_link_inc_not_zero().

pw-bot: cr

>   		/* Reusing existing shim attached by the other program. */
> -		bpf_link_inc(&shim_link->link.link);
> -
>   		mutex_unlock(&tr->mutex);
>   		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
>   		return 0;

