Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394022FD1BF
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774141274; cv=none; b=b+pMPWdzYdnMPfXYWapToAPVK+clUTKWniIdAPs5YIbS0sYtwaMKws3hkKiUHd6Em8TOxHDCVTjyCQooD6oWyMoQ6W1tutMhu0eRgu+UBb64Xcnlxf20YDMdDKvM+U3vgcE7psQ16JK46T9ybXqJ62LXVEMEeosDGDmQBSQHd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774141274; c=relaxed/simple;
	bh=eG2fBSvgDpYv9E2BJatP4FNXejqqNu6VrgF6/ZsHYKo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xh+sfP2Brp6QBI6mYsJp8Qdyp53GBhvaAtnmpkLTq/PgrcL+VFY/NVxXiU4HCcqKWhrPt1ECYRy7be/S1+lS/m9XfP8RGh/kQgCDyrd2SWO9lNJul/YhW4/BKGjbrvIwnWNafn6pYKDLHV+pzI01BzjGILpq3Fn2LGFzAIJkoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=frvxz7PD; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="frvxz7PD"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89a6ac6f389so42709216d6.3
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 18:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774141272; x=1774746072; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLSBv/zajzPO2v6k4pmmZASk5USLtLivtAjS52MOy7E=;
        b=frvxz7PD+9HyqA6ds6Nvt1sHf2SgSuXtoNGTrrmMIw3ngRhqZIJmLsYt3V5thMNPuC
         4eGWL+VcBrhMvkcPDjhAb1qhOt9J2SU+E8JrgDXMJao++cOIqHDS2ra8DEkIzk7jkcq3
         5FNcsV6dUinXYZEMzzG/qlv6O2lDLAL1LOKRa5ccTDeSMiZk3hz0iNgRm4xTltp/7oyI
         OZBKU16ANSo4ZemUkTnk2U1GfNcEjz/Hqq5TkN58qITkMIYpAKBWnLyI36cq5S1zTIRh
         gdtlzWNVDcZN8Me039mK5j3S3iQZ4FkrClYFRThUX3DnSvqlfSAt6AaeijvgQL4VO/fJ
         mb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774141272; x=1774746072;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLSBv/zajzPO2v6k4pmmZASk5USLtLivtAjS52MOy7E=;
        b=DRrWDdOU7ybn0khCtvoCCr4AjvtfqrX6Ya3WiTJTDwtY/UWw53K8EGBK53dFH8eQma
         djoNri+CWPSos/7TlBCQoVq/zKdTjD1dANFW3RReSCBPMwcf/OnnP2AGtB+b3gI3nc/g
         9LU0ZSyV42A6FfdLrTj6WwIuirfVduVEh+zrfoR+F0cR3Cv1g5k0xQA9oBwEI6yYuOQz
         2tAbFQcujOgvcIeqWr3ZO5IJ1RzOhjielLWumKRTPAWH6ik9f0PtWvITH2jk054sMw3n
         OXuE2rGswdrIqhq/EapdAYDa1xZl4xcIuFjjNCmSOZ9mpm1p4gSR65bM35Fjep7QvCbk
         mufQ==
X-Gm-Message-State: AOJu0YwBvoa3lmRsxkdpzGjAErG+Vr0jbsBSZGGNKjoR8iDFlFAYMz64
	W2KZi2Jfg7mhdaJ4xk7YvaMA2Rm2Wx+kbd4aePvTaFvLueKxBPS4NOrBJsbPv1E/zX8=
X-Gm-Gg: ATEYQzz+qkAtzAz9LCbsFmvvAR89U2ZL6+nubE6IGPGn7rjwo3ns08RWzGQuMzKWIe+
	ofXTwWaiUNuq66+3SWIRY/Nvh5KZvJ0NfE98yAwMeO07g77fnAe894/uL4jsCD4/0h0GC7R4RKW
	kk/tJe+bFYHbU0RpIqHmLPB8FFycGuMiXK7rytUkzuJ1HFJ1GJeKlcW/cH3MRobbsNgSrYDlDf6
	znVcNMynVI4dfZElnwQ7plaWxLv1+gh7RLv24121keC93iE9Risc7E9QQ0Bwr9ipRMxcwvHbz3C
	W1q5pAB14kCZxKfVbh03OGPLBm8Abijw+Hx5nN1ETsGJCU1s5YT6TvnGyrZGndRyte1iC3RN0+b
	lsbwUOhdSu/QYt/NKfMtFLt6+95XCqKwWJiGt0Ury6N7QF9KuW1FTgTNBNk4QD6FRgs3+pil86s
	AOhKBh2M+/NrgdB5yu1TYZIng=
X-Received: by 2002:a05:6214:501a:b0:89c:3ff5:78dc with SMTP id 6a1803df08f44-89c85a376dfmr126267686d6.32.1774141272049;
        Sat, 21 Mar 2026 18:01:12 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85236730sm52169866d6.14.2026.03.21.18.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 18:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 21:01:10 -0400
Message-Id: <DH8WLC5587BJ.30X22578QBN3C@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 7/8] bpf: add bpf_list_is_first/last/empty
 kfuncs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Chengkaitao" <pilgrimtao@gmail.com>, <martin.lau@linux.dev>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
 <haoluo@google.com>, <jolsa@kernel.org>, <shuah@kernel.org>,
 <chengkaitao@kylinos.cn>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
 <20260316112843.78657-8-pilgrimtao@gmail.com>
In-Reply-To: <20260316112843.78657-8-pilgrimtao@gmail.com>

On Mon Mar 16, 2026 at 7:28 AM EDT, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Add three kfuncs for BPF linked list queries:
> - bpf_list_is_first(head, node): true if node is the first in the list.
> - bpf_list_is_last(head, node): true if node is the last in the list.
> - bpf_list_empty(head): true if the list has no entries.
>
> Currently, without these kfuncs, to implement the above functionality
> it is necessary to first call bpf_list_pop_front/back to retrieve the
> first or last node before checking whether the passed-in node was the
> first or last one. After the check, the node had to be pushed back into
> the list using bpf_list_push_front/back, which was very inefficient.
>
> Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
> check whether a node is the first, last, or whether the list is empty,
> without having to first retrieve the node.

Do you need to expand the exceptions you added in patch 5 for non-owning
reference arguments to also hold for this? Checking the selftests, we
don't have one where either bpf_list_is_last or bpf_list_is_first
return true, can you add one?

>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c | 11 +++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dc4f8b4eec01..da70dcff4ba8 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2518,6 +2518,41 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(st=
ruct bpf_list_head *head)
>  	return (struct bpf_list_node *)h->prev;
>  }
> =20
> +__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bp=
f_list_node *node)
> +{
> +	struct list_head *h =3D (struct list_head *)head;
> +	struct bpf_list_node_kern *kn =3D (struct bpf_list_node_kern *)node;
> +
> +	if (READ_ONCE(kn->owner) !=3D head)
> +		return false;
> +
> +	return list_is_first(&kn->list_head, h);
> +}
> +
> +__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bpf=
_list_node *node)
> +{
> +	struct list_head *h =3D (struct list_head *)head;
> +	struct bpf_list_node_kern *kn =3D (struct bpf_list_node_kern *)node;
> +
> +	if (READ_ONCE(kn->owner) !=3D head)
> +		return false;
> +
> +	return list_is_last(&kn->list_head, h);
> +}
> +
> +__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
> +{
> +	struct list_head *h =3D (struct list_head *)head;
> +
> +	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
> +	 * called on its fields, so init here
> +	 */
> +	if (unlikely(!h->next))
> +		INIT_LIST_HEAD(h);
> +
> +	return list_empty(h);
> +}
> +
>  __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *ro=
ot,
>  						  struct bpf_rb_node *node)
>  {
> @@ -4588,6 +4623,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RE=
T_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_add_impl)
> +BTF_ID_FLAGS(func, bpf_list_is_first)
> +BTF_ID_FLAGS(func, bpf_list_is_last)
> +BTF_ID_FLAGS(func, bpf_list_empty)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0a6f2e6a5d28..c2cc622bb3a1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12512,6 +12512,9 @@ enum special_kfunc_type {
>  	KF_bpf_list_del,
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
> +	KF_bpf_list_is_first,
> +	KF_bpf_list_is_last,
> +	KF_bpf_list_empty,
>  	KF_bpf_cast_to_kern_ctx,
>  	KF_bpf_rdonly_cast,
>  	KF_bpf_rcu_read_lock,
> @@ -12574,6 +12577,9 @@ BTF_ID(func, bpf_list_pop_back)
>  BTF_ID(func, bpf_list_del)
>  BTF_ID(func, bpf_list_front)
>  BTF_ID(func, bpf_list_back)
> +BTF_ID(func, bpf_list_is_first)
> +BTF_ID(func, bpf_list_is_last)
> +BTF_ID(func, bpf_list_empty)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
>  BTF_ID(func, bpf_rdonly_cast)
>  BTF_ID(func, bpf_rcu_read_lock)
> @@ -12652,6 +12658,9 @@ static const enum special_kfunc_type bpf_list_api=
_kfuncs[] =3D {
>  	KF_bpf_list_del,
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
> +	KF_bpf_list_is_first,
> +	KF_bpf_list_is_last,
> +	KF_bpf_list_empty,
>  };
> =20
>  /* Kfuncs that take a list node argument (bpf_list_node *). */
> @@ -12660,6 +12669,8 @@ static const enum special_kfunc_type bpf_list_nod=
e_api_kfuncs[] =3D {
>  	KF_bpf_list_push_back_impl,
>  	KF_bpf_list_add_impl,
>  	KF_bpf_list_del,
> +	KF_bpf_list_is_first,
> +	KF_bpf_list_is_last,
>  };
> =20
>  /* Kfuncs that take an rbtree node argument (bpf_rb_node *). */

