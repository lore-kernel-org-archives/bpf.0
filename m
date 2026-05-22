Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285F34CFAB
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481313; cv=none; b=NonWOwKCplqBfXyR4bV2BleEG0kOSrNH20KnOxPL6hkK278LAuDfQQhTfcWu0uVyrTMG+YFbJql5ZS+Z+0/mwl36ob0QgQs4tuGJ0JMz4+S9YQw7sKVBq8YkSF7pPOEzUX+OkDFya0cXFQwDTZnrvK1r6AKc9UYXEuvBxsN+HXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481313; c=relaxed/simple;
	bh=3l5EwpAaP5ijubwHS/zXSrCjIUieF6tw/2tieWwRCxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5Gih+8Hd/nywrdqWA1sDtfD57cZM1tXlIlUqIE6OS0Pb7hEPHtI86KXRihneO1JVv+OtHL9PtUcClyhTqTM/U/1g0XoStQxDthFw7Tj2YJC+E9Fd9vXp84L/F4q7nnzqCsM1DpNcpvoAPkg7wkNsJojVq15Du5X9AtNCQ3RiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eocW+XPy; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eocW+XPy"
Message-ID: <9bd2942f-8e6e-4a6f-a300-d20d0f40ef3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779481300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+ERplWDjzUkx+QPM+Sjzujvb4WulGw/uySZnR86p00=;
	b=eocW+XPyitZiHEZBtWXEpyzMWrUTmImGJqbQFuufWpN0K1/Hj7ihl9lmoQqBJwMw63CFuP
	VpnMBYn4t6LaYBzFlCoqpvAKXaEPvtgeWZpVk6U1veHf8L8ySv5a5L0gGvU8OCZ19RAF2z
	HH+suq83x9b/ntrWsnuJ67/LQit7euQ=
Date: Fri, 22 May 2026 13:21:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Fix preorder-unaware index in replace_effective_prog
 and purge_effective_progs replace_effective_prog() and
 purge_effective_progs() compute the target index in the effective program
 array by sequentially walking the hlist (pos++). However, since commit
 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs"),
 compute_effective_progs() partitions the effective array: preorder programs
 occupy indices 0..preorder_cnt-1 and normal programs occupy indices
 preorder_cnt..end. The sequential hlist walk does not account for this
 partitioning, so when BPF_F_PREORDER programs coexist with normal programs
 the computed index diverges from the actual position in the effective array.
 In replace_effective_prog() this causes BPF_LINK_UPDATE to overwrite the
 wrong slot: the freed program pointer remains in the correct slot while an
 unrelated neighbor is clobbered. Fix both functions by searching the
 effective array directly for the target program pointer instead of computing
 an index from the hlist. This is correct regardless of array layout since it
 matches by pointer identity. For purge_effective_progs(), resolve the
 effective prog from the link when the direct prog pointer is NULL (link-based
 detach path). Fixes: 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup
 progs") Signed-off-by: Himanshu Anand <anand.himanshu17@gmail.com>
Content-Language: en-GB
To: Himanshu Anand <anand.himanshu17@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260522162248.55586-1-anand.himanshu17@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260522162248.55586-1-anand.himanshu17@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/22/26 9:22 AM, Himanshu Anand wrote:
> Signed-off-by: Himanshu Anand <anand.himanshu17@gmail.com>

Please have proper subject and commit message. Your probably
messed up your patch.

> ---
>   kernel/bpf/cgroup.c | 74 ++++++++++++++++++---------------------------
>   1 file changed, 29 insertions(+), 45 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b6..437e1e873bf8 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -923,15 +923,12 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
>    */
>   static void replace_effective_prog(struct cgroup *cgrp,
>   				   enum cgroup_bpf_attach_type atype,
> -				   struct bpf_cgroup_link *link)
> +				   struct bpf_cgroup_link *link,
> +				   struct bpf_prog *old_prog)
>   {
>   	struct bpf_prog_array_item *item;
>   	struct cgroup_subsys_state *css;
>   	struct bpf_prog_array *progs;
> -	struct bpf_prog_list *pl;
> -	struct hlist_head *head;
> -	struct cgroup *cg;
> -	int pos;
>   
>   	css_for_each_descendant_pre(css, &cgrp->self) {
>   		struct cgroup *desc = container_of(css, struct cgroup, self);
> @@ -939,27 +936,20 @@ static void replace_effective_prog(struct cgroup *cgrp,
>   		if (percpu_ref_is_zero(&desc->bpf.refcnt))
>   			continue;
>   
> -		/* find position of link in effective progs array */
> -		for (pos = 0, cg = desc; cg; cg = cgroup_parent(cg)) {
> -			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
> -				continue;
> -
> -			head = &cg->bpf.progs[atype];
> -			hlist_for_each_entry(pl, head, node) {
> -				if (!prog_list_prog(pl))
> -					continue;
> -				if (pl->link == link)
> -					goto found;
> -				pos++;
> -			}
> -		}
> -found:
> -		BUG_ON(!cg);
> +		/* find the old prog in effective array by direct pointer
> +		 * comparison, since compute_effective_progs() partitions
> +		 * the array (preorder progs first) and the hlist walk
> +		 * order does not match the effective array order.
> +		 */
>   		progs = rcu_dereference_protected(
>   				desc->bpf.effective[atype],
>   				lockdep_is_held(&cgroup_mutex));
> -		item = &progs->items[pos];
> -		WRITE_ONCE(item->prog, link->link.prog);
> +		for (item = &progs->items[0]; item->prog; item++) {
> +			if (item->prog == old_prog) {

This probably not enough, BPF_F_PREORDER should be checked as well.
The same for purge_effective_progs().

> +				WRITE_ONCE(item->prog, link->link.prog);
> +				break;
> +			}
> +		}
>   	}
>   }
>   
> @@ -1003,7 +993,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>   
>   	cgrp->bpf.revisions[atype] += 1;
>   	old_prog = xchg(&link->link.prog, new_prog);
> -	replace_effective_prog(cgrp, atype, link);
> +	replace_effective_prog(cgrp, atype, link, old_prog);
>   	bpf_prog_put(old_prog);
>   	return 0;
>   }
> @@ -1078,11 +1068,9 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
>   				  struct bpf_cgroup_link *link,
>   				  enum cgroup_bpf_attach_type atype)
>   {
> +	struct bpf_prog *target_prog = prog ? : link->link.prog;
>   	struct cgroup_subsys_state *css;
>   	struct bpf_prog_array *progs;
> -	struct bpf_prog_list *pl;
> -	struct hlist_head *head;
> -	struct cgroup *cg;
>   	int pos;
>   
>   	/* recompute effective prog array in place */
> @@ -1092,28 +1080,24 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
>   		if (percpu_ref_is_zero(&desc->bpf.refcnt))
>   			continue;
>   
> -		/* find position of link or prog in effective progs array */
> -		for (pos = 0, cg = desc; cg; cg = cgroup_parent(cg)) {
> -			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
> -				continue;
> -
> -			head = &cg->bpf.progs[atype];
> -			hlist_for_each_entry(pl, head, node) {
> -				if (!prog_list_prog(pl))
> -					continue;
> -				if (pl->prog == prog && pl->link == link)
> -					goto found;
> -				pos++;
> -			}
> -		}
> -
> -		/* no link or prog match, skip the cgroup of this layer */
> -		continue;
> -found:
> +		/* find the prog in the effective array by direct pointer
> +		 * comparison instead of computing index from hlist walk,
> +		 * since compute_effective_progs() partitions the array.
> +		 * Use target_prog which resolves link->link.prog for
> +		 * link-based entries where prog is NULL.
> +		 */
>   		progs = rcu_dereference_protected(
>   				desc->bpf.effective[atype],
>   				lockdep_is_held(&cgroup_mutex));
>   
> +		for (pos = 0; progs->items[pos].prog; pos++) {
> +			if (progs->items[pos].prog == target_prog)
> +				break;
> +		}
> +
> +		if (!progs->items[pos].prog)
> +			continue;
> +
>   		/* Remove the program from the array */
>   		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
>   			  "Failed to purge a prog from array at index %d", pos);

