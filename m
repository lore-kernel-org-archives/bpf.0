Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1553B7A8
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781988377; cv=none; b=Lg8F61I4bNo0+/ktoodxAiiYSbgZSpEDC+mgEVoCPVT2ZMQjH1jfdqhH0p6PNIiSDxevlS2iEQYmmPAa9HHscx6k0oN7eSLKFfCL+uhVwW4+r9cY8yq7D0XudMQCsaOJ7fCn8O3AST53i+3LL0UuALVpSzNCwwYO3RtiMGJb1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781988377; c=relaxed/simple;
	bh=xrEsjbtHIeRgZH7OTyiNdSguF1JxmZ+H5KcIMZRwq10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqFhiDs6gNcvDCXxXnVfWJa6oRChB6ZtuDfRPw4nqvyOHenhx4B94rNkRrgksO/OsEERSqz2+0OoKqDlgxIsjw2ot53KSBlJswvqGpKlq+lPBjarSZ4/MEFbZmYJxykB81dsiDLa5jarD/cCth2tM9wqlNfq/Ma54CnHufIGDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ox1aI2q2; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ox1aI2q2"
Message-ID: <bc9a4f26-2a1a-4e56-aaa4-05c209463324@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781988372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cvpEnrHsIZaNcpYyFldb4rX4EnYH+26JgKdV6+Gzcr8=;
	b=ox1aI2q2/G47GW8R/Iuyu1Z/7+xZt6YpmqZ4/niRVv/hhq2qhFOUqDuqVUh/ljv4bjX16J
	7bHLvb6ix4LQr3qJu0rLLOYUg7w/LLepPWrJ+440VRXgUZk6t7N/4zoPrjR+pNmKEKX/IO
	40fC3t4KAGCOlKbdwQlQe1lII5hWfw8=
Date: Sat, 20 Jun 2026 13:45:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix effective prog array index with
 BPF_F_PREORDER
Content-Language: en-GB
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org,
 kernel-team@meta.com
References: <20260619063520.2690547-1-ameryhung@gmail.com>
 <20260619063520.2690547-2-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260619063520.2690547-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/18/26 11:35 PM, Amery Hung wrote:
> replace_effective_prog() and purge_effective_progs() located the slot in
> the effective array by walking the program hlist and counting entries
> linearly. That count does not match the array layout: compute_effective_
> progs() places BPF_F_PREORDER programs at the front (ancestor cgroup
> first, attach order within a cgroup) and the rest after them (descendant
> cgroup first). So when a preorder program is present, the linear hlist
> position no longer equals the program's index in the effective array.
>
> For replace_effective_prog() (bpf_link_update()) this overwrote the
> wrong slot, corrupting the effective order. For purge_effective_progs(),
> it could dummy out a slot belonging to a different program and leave the
> detached program in the array while bpf_prog_put() drops its reference,
> i.e. a use-after-free.
>
> Fix both by replaying compute_effective_progs()'s placement (including
> the per-cgroup preorder reversal) in a shared effective_prog_pos()
> helper. Identify the entry by its struct bpf_prog_list pointer rather
> than by (prog, link) value, so the lookup resolves to exactly the
> attachment the syscall selected even when the same bpf_prog is attached
> to several cgroups in the hierarchy.
>
> Fixes: 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

LGTM with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/cgroup.c | 108 +++++++++++++++++++++++++-------------------
>   1 file changed, 62 insertions(+), 46 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 83ce66296ac1..4355ccb78a9c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -939,19 +939,65 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
>   	return ret;
>   }
>   
> +static int effective_prog_pos(struct cgroup *cgrp,
> +			      enum cgroup_bpf_attach_type atype,
> +			      struct bpf_prog_list *target_pl)
> +{
> +	int cnt = 0, preorder_cnt = 0, fstart, bstart, init_bstart, pos = -1;
> +	struct bpf_prog_list *pl;
> +	struct cgroup *p = cgrp;
> +
> +	/* count effective programs to find where the preorder region ends */
> +	do {
> +		if (cnt == 0 || (p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
> +			cnt += prog_list_length(&p->bpf.progs[atype], &preorder_cnt);
> +		p = cgroup_parent(p);
> +	} while (p);
> +
> +	/* replay compute_effective_progs() placement and record target's slot */
> +	cnt = 0;
> +	p = cgrp;
> +	fstart = preorder_cnt;
> +	bstart = preorder_cnt - 1;
> +	do {
> +		if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
> +			continue;
> +
> +		init_bstart = bstart;
> +		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
> +			if (!prog_list_prog(pl))
> +				continue;
> +
> +			if (pl->flags & BPF_F_PREORDER) {
> +				if (pl == target_pl)
> +					pos = bstart;
> +				bstart--;
> +			} else {
> +				if (pl == target_pl)
> +					pos = fstart;
> +				fstart++;
> +			}
> +			cnt++;
> +		}
> +
> +		/* reverse pre-ordering progs at this cgroup level */
> +		if (pos >= bstart + 1 && pos <= init_bstart)
> +			pos = bstart + 1 + init_bstart - pos;

Here, if pos is not -1, we could break out of loop since each pl is unique.
But since this is not in a performance critical path, probably the current
implementation is okay.

> +	} while ((p = cgroup_parent(p)));
> +
> +	return pos;
> +}
> +
>   /* Swap updated BPF program for given link in effective program arrays across
>    * all descendant cgroups. This function is guaranteed to succeed.
>    */
>   static void replace_effective_prog(struct cgroup *cgrp,
>   				   enum cgroup_bpf_attach_type atype,
> -				   struct bpf_cgroup_link *link)
> +				   struct bpf_prog_list *pl)
>   {
>   	struct bpf_prog_array_item *item;
>   	struct cgroup_subsys_state *css;
>   	struct bpf_prog_array *progs;
> -	struct bpf_prog_list *pl;
> -	struct hlist_head *head;
> -	struct cgroup *cg;
>   	int pos;
>   
>   	css_for_each_descendant_pre(css, &cgrp->self) {
> @@ -960,27 +1006,15 @@ static void replace_effective_prog(struct cgroup *cgrp,
>   		if (percpu_ref_is_zero(&desc->bpf.refcnt))
>   			continue;
>   
> -		/* find position of link in effective progs array */
> -		for (pos = 0, cg = desc; cg; cg = cgroup_parent(cg)) {
> -			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
> -				continue;
> +		pos = effective_prog_pos(desc, atype, pl);
> +		if (WARN_ON_ONCE(pos < 0))
> +			continue;
>   
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
>   		progs = rcu_dereference_protected(
>   				desc->bpf.effective[atype],
>   				lockdep_is_held(&cgroup_mutex));
>   		item = &progs->items[pos];
> -		WRITE_ONCE(item->prog, link->link.prog);
> +		WRITE_ONCE(item->prog, pl->link->link.prog);
>   	}
>   }
>   
> @@ -1024,7 +1058,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>   
>   	cgrp->bpf.revisions[atype] += 1;
>   	old_prog = xchg(&link->link.prog, new_prog);
> -	replace_effective_prog(cgrp, atype, link);
> +	replace_effective_prog(cgrp, atype, pl);
>   	bpf_prog_put(old_prog);
>   	return 0;
>   }
> @@ -1091,19 +1125,14 @@ static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
>    *                           recomputing the array in place.
>    *
>    * @cgrp: The cgroup which descendants to travers
> - * @prog: A program to detach or NULL
> - * @link: A link to detach or NULL
> + * @pl: The prog_list entry being detached
>    * @atype: Type of detach operation
>    */
> -static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
> -				  struct bpf_cgroup_link *link,
> +static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog_list *pl,
>   				  enum cgroup_bpf_attach_type atype)
>   {
>   	struct cgroup_subsys_state *css;
>   	struct bpf_prog_array *progs;
> -	struct bpf_prog_list *pl;
> -	struct hlist_head *head;
> -	struct cgroup *cg;
>   	int pos;
>   
>   	/* recompute effective prog array in place */

[...]

