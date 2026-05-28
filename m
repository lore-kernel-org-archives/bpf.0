Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85567330305
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994633; cv=none; b=CjYcOHj+e1my7WkedQ66D7Cq4AXPNhTQKJcb2qdWwWFXyrtbnkIrOtI6FOE5UDGBofMDssSkwoW6rW31b2i2s2t2jkZc/cSES2K8AaeESnkcHJwjKh07j5cKLWSESqXDLV0hFSZFadwNEaj4WjfSywNGH8IMXGM05lK5vAVM9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994633; c=relaxed/simple;
	bh=t6LwzBagBUTEoQO7InFJQhhh6rSkrtiGTvI6pyuSZK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ea0vWE3XmeP4M6D34jCOoK/sL+LHq2+PRhGFncBnz7mJi6wECZoJ7eA3b+bOsYE7ydWB1X1ID+D+MGspdrTeI7w1InHzQkA9fd660mKWVDA3NuetRl69fwlFZHPt9usHnkZFrAE7ap/3wWYQz68osl8mCqowKZFqnVcRr0lYz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odxG05Z/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odxG05Z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDC31F000E9;
	Thu, 28 May 2026 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779994632;
	bh=S+gwWUg8ZaptiNJrjoDjj34ALo16hdjr0Orr6xoZEvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=odxG05Z/DRbOkp9sOMKGj58F/uqbtmsqA06hCiTlZPHgT5DFuyLmeynSRqx8pU4yE
	 VDxZsLSENtn9mCAq7vzC3STZDoyt3AarNun9RShGlgV5vQ7ySQok3jjD5crlv+QuJt
	 nLjHdUZv9C3DnGb0pUhhugeWezPDWe2CCIm646rxeePEJulO0lItxMThi9hvCl8PN5
	 7Ftkj0pITmq/imVbQxgp+TjCWIB8WVh5nEKkBFeNrU8MCD7Jb4/zrpFDuErHHlVdKr
	 5QiGsJ13S+zO8R2T++2ZAbGHdNPiAJKYKI/xd5B4JMCUXQTWCNvWgNbABXGx92re81
	 Wlij8/AeHnnCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: Fix NMI/tracepoint re-entry
 deadlock on lru locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260528-lru_map_spin-v1-1-4f52223170cf@meta.com>
References: <20260528-lru_map_spin-v1-1-4f52223170cf@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 18:57:11 +0000
Message-Id: <20260528185711.EEDC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A race condition between `__local_list_flush` and an NMI calling `=
bpf_common_lru_push_free` can cause a deleted LRU node to be permanently le=
aked, because `__bpf_lru_node_move_in` unconditionally clears the `pending_=
free` flag.
--

commit c004ee038ff11ff6f1bdd2bb613d6dc9eddf7165
Author: Mykyta Yatsenko <yatsenko@meta.com>
bpf: Fix NMI/tracepoint re-entry deadlock on lru locks

This commit converts LRU lock sites to rqspinlock_t to prevent AA-deadlocks
when NMI and tracepoint BPF programs re-enter the per-CPU or global LRU
lock. It also adds a recovery path for each failure window to ensure nodes
are not leaked on contention or deadlock.

Link: https://lore.kernel.org/bpf/CAPPBnEYO4R+m+SpVc2gNj_x31R6fo1uJvj2bK2YS=
1P09GWT6kQ@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAPPBnEZmFA3ab8Uc=3DPEm0bdojZy=3D7T_F5_+e=
yZSHyZR3MBG4Vw@mail.gmail.com/
Link: https://lore.kernel.org/bpf/20251030030010.95352-1-dongml2@chinatelec=
om.cn/
Link: https://lore.kernel.org/bpf/20260119142120.28170-1-leon.hwang@linux.d=
ev/

> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> index e7a2fc60523f6..a5faf4464d889 100644
> --- a/kernel/bpf/bpf_lru_list.c
> +++ b/kernel/bpf/bpf_lru_list.c

[ ... ]

> @@ -87,6 +73,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list =
*l,
>  	bpf_lru_list_count_inc(l, tgt_type);
>  	node->type =3D tgt_type;
>  	bpf_lru_node_clear_ref(node);
> +	WRITE_ONCE(node->pending_free, 0);

[Severity: High]
Can a race condition here cause an LRU node to be leaked if an NMI
interrupts __local_list_flush()?

If an NMI occurs exactly after __local_list_flush() reads
node->pending_free as 0:

__local_list_flush()
    if (READ_ONCE(node->pending_free))
        // skipped
    else
        // interrupted here by NMI

And the NMI's BPF program deletes this element from the hash table, calling
bpf_common_lru_push_free(). It fails to acquire the lock because
__local_list_flush()'s caller already holds it:

NMI: bpf_common_lru_push_free()
    if (raw_res_spin_lock_irqsave(&loc_l->lock, flags)) {
        WRITE_ONCE(node->pending_free, 1);
        return;
    }

When the NMI completes and __local_list_flush() resumes, it will call
__bpf_lru_node_move_in() which unconditionally clears the flag:

__bpf_lru_node_move_in()
    WRITE_ONCE(node->pending_free, 0);

Will this wipe the pending_free state set by the NMI? Since the node
is already deleted from the hash table, future shrink scans would see
del_from_htab() return false and skip the node, potentially permanently
leaking it and degrading the LRU map over time.

>  	list_move(&node->list, &l->lists[tgt_type]);
>  }

[ ... ]

> @@ -290,8 +280,10 @@ static void __local_list_flush(struct bpf_lru_list *=
l,
>  	struct bpf_lru_node *node, *tmp_node;
> =20
>  	list_for_each_entry_safe_reverse(node, tmp_node,
> -					 local_pending_list(loc_l), list) {
> -		if (bpf_lru_node_is_ref(node))
> +					 &loc_l->pending_list, list) {
> +		if (READ_ONCE(node->pending_free))
> +			__bpf_lru_node_move_in(l, node, BPF_LRU_LIST_T_FREE);
> +		else if (bpf_lru_node_is_ref(node))
>  			__bpf_lru_node_move_in(l, node, BPF_LRU_LIST_T_ACTIVE);
>  		else
>  			__bpf_lru_node_move_in(l, node,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-lru_map_sp=
in-v1-0-4f52223170cf@meta.com?part=3D1
