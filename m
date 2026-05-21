Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30715356742
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337825; cv=none; b=DbOJ6GAktjvk/rxc065/Htbzt0KcshVpHoGxZM++2Czcn/rfFBAps70b0Hg3ZHtu576hdCAF0fuD4IkaseGNscWIKES/rsC2HC4pNibfrgl4Zmbd0NZKUDIY0SDWJqp/ti5syA2FaUUEpJVSRm6fc6G5A8+IlZfs9mRFVnFBmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337825; c=relaxed/simple;
	bh=irqFk6mqjMjwGfXt427bsER8quLH6AaSh68xRMS9NBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nOTgdy3ufMroxROHL/iiOcB5m8LfyO5e2RcXX/mXeB57yP1LJdvCADz59YMaZHFtViYLRGnoOWSfYXyv6oGBmCrxBiZP6vv5aEbGsVKXClZMst0xdH6hC3rvN2FzlpiJkWRP6INJrK3v1QiqY0o1xw4EKXT54NgsOs5lpAUKq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU18r+Hc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU18r+Hc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BD71F000E9;
	Thu, 21 May 2026 04:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779337823;
	bh=X5GblndfLg6aXSy+30b5eMTEKG7kmcQP5bt3WjJf/VQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iU18r+HcFfhLPD7T2F4Xw36K2/9rzgabMkTp0uz8JgxrApOfro/AHBlWwqZk/qwnM
	 0PAiI804k7aUuhTVxVzMYG43nUhtCabzLoYfcNdOVLfE/yGgtFni4nRvsAOOmtJFU1
	 cEQVKPOdz4tc/w9PP+scib6+TTZtQwIPoh20BW8s0CIudRZAAtO2NLoOoM1Wp9oIOL
	 AbBSFNxvTAcLXF+8z2LqxWtp/o1+Oyq0ry7dlxhxFgO9dLDjLAxhmB70pSmhvCDNZy
	 5/VedN0M4r/qWk5/xpZ6XbPwGNqZRUcv3UeMbd6NJNgIRHprRuktqWr/aRbJuqxrfq
	 TjlJ8RkxWAezw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 2/8] bpf: clear list node owner and unlink
 before drop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521032306.97118-3-kaitao.cheng@linux.dev>
References: <20260521032306.97118-3-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 04:30:22 +0000
Message-Id: <20260521043023.A0BD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Potentially unbounded O(N) list traversal with interrupts disabled=
 in `bpf_list_head_free()`.

Pre-existing issues:
- [High] The patch fixes the stale `node->owner` issue for `bpf_list_head_f=
ree()` but fails to apply the equivalent fix for `bpf_rb_root_free()`, leav=
ing `bpf_rbtree_remove()` vulnerable to the same memory corruption.
--

commit 59439e3ee3f8d57af8635b521393d245d26bbdf4
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

bpf: clear list node owner and unlink before drop

This commit fixes an issue where refcounted BPF list nodes can outlive their
list head and retain a stale owner pointer. To prevent memory corruption if=
 a
new list is allocated at the same address, it moves nodes to a private drain
list under the spinlock, poisons their owner pointers, and unlinks them
before dropping the objects.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 094457c3e6d37..59855b434f0b2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2261,20 +2262,30 @@ void bpf_list_head_free(const struct btf_field *f=
ield, void *list_head,
>  	__bpf_spin_lock_irqsave(spin_lock);
>  	if (!head->next || list_empty(head))
>  		goto unlock;
> -	head =3D head->next;
> +	list_for_each_safe(pos, n, head) {
> +		struct bpf_list_node_kern *node;
> +
> +		node =3D container_of(pos, struct bpf_list_node_kern, list_head);
> +		WRITE_ONCE(node->owner, BPF_PTR_POISON);
> +		list_move_tail(pos, &drain);
> +	}

[Severity: High]
Could this new loop potentially cause a long CPU stall?

Since __bpf_spin_lock_irqsave() disables local interrupts, this O(N) list
traversal executes with interrupts disabled.

BPF lists do not have a hard size limit, so if a program accumulates a
very large number of elements in a single list, could iterating over them
here trigger the NMI watchdog or cause severe latency spikes?

>  unlock:
> -	INIT_LIST_HEAD(orig_head);
> +	INIT_LIST_HEAD(head);
>  	__bpf_spin_unlock_irqrestore(spin_lock);
> =20
> -	while (head !=3D orig_head) {
> -		void *obj =3D head;
> +	while (!list_empty(&drain)) {
> +		struct bpf_list_node_kern *node;
> =20
> -		obj -=3D field->graph_root.node_offset;
> -		head =3D head->next;
> +		pos =3D drain.next;
> +		node =3D container_of(pos, struct bpf_list_node_kern, list_head);
> +		list_del_init(pos);
> +		/* Ensure __bpf_list_add() sees the node as unlinked. */
> +		smp_store_release(&node->owner, NULL);
>  		/* The contained type can also have resources, including a
>  		 * bpf_list_head which needs to be freed.
>  		 */
> -		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
> +		__bpf_obj_drop_impl((char *)pos - field->graph_root.node_offset,
> +				    field->graph_root.value_rec, false);
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does bpf_rb_root_free() need
the exact same fix?

When draining an rbtree, bpf_rb_root_free() calls __bpf_obj_drop_impl() on
each node without clearing the node_internal->owner or unlinking the nodes.

If a surviving refcounted rb-node retains a pointer to the freed rb_root,
and a new bpf_rb_root is allocated at the old address, wouldn't a call to
bpf_rbtree_remove(new_root, stale_node) erroneously bypass the ownership
check and invoke rb_erase_cached() with stale tree pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521032306.9711=
8-1-kaitao.cheng@linux.dev?part=3D2
