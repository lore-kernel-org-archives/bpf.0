Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B2386C17
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201512; cv=none; b=We7PnZNoB1K5e0uZx+tPb6CNpSgevIjfG4a8T6SHIUv/1gq+zQRieTRCNqFx0Km89qpWFWn8HTHROKrrW9TmAvmxjXniyVOpHbNG4COKdeuMivfuy7ZsHwRPHMvwELQDjvh3uQJnkL+7O3Ie35ZjbmYtUvSFtU5D/GMBPeJ86zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201512; c=relaxed/simple;
	bh=6xKXCc8055xG8ribT8PRQtCwtLzJinZCCFgyiQJiPC8=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=PvI3Y4yR3Xd3AqxBYetruYttzUHgABoQC7+fGIBL5Pu29F3n2ZLVq/UNetQ1dxbEP8EyR868nrr1HOn1nTkHSLG5fioFT0nDjfIPLbYIA+FR4/9Xg+/01w18RlKDodJXuTHth6yryxluSHasI17VDgKB6LAO0Aor4jjWLYnLhAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA/mKeUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA/mKeUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5607F1F000C4;
	Sat, 17 Oct 2026 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201510;
	bh=Ua4Yp18iL6Yur/CnjQkF9OH2FsujBVSqiFd+g8vRbTQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RA/mKeUUDGt0lajZfT60uBYhb5ZaPH24iQmMiOklMrUnD8ZuRNCOnc3Y2by6HapcL
	 EZZ0+odUACr9TE23tgvWWsVhhRCc6TOOg+Zjd5W2VhRVETfve/prm7Vovu6ZyHL5sx
	 WA2zYTpDY2gJuDUVkMJcNqwgwdamsJcExW0187z8dg6CG8EswG1qdgdI8bMwvxs5Qu
	 v54120PYx5iZRxDvvxvnfUdgqEHPwn891VssvMLARH0tIyydW3eKtsDXImI4a6VpUL
	 O7HQmHgUofAYzc1andjDKjUXPq40+6/K12lKr6fgE4ayEIlkvO3uB7VW0a8tcDz57A
	 8nkmzD4nOfbiA==
Message-ID: <sashiko-outbox-175145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 04/38] bpf: don't hand out a linked element as
 extra element
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017012058.355787-5-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
 <20261017012058.355787-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 01:45:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: l_old stored in extra_elems before check_and_cancel_fields()
--

commit 2a85541dd93d84eaa60a85ebbff00bfad598417f
Author: Josef Bacik <josef@toxicpanda.com>

bpf: don't hand out a linked element as extra element

This commit atomically clears the per-CPU extra_elems slot when claiming a
spare element during preallocated hash map updates, and delays storing the
replaced element into the slot until after it has been unlinked from its
bucket.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9d4791ee17411..923fec694747b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1279,11 +1279,17 @@ static struct htab_elem *alloc_htab_elem(struct b=
pf_htab *htab, void *key,
>  	if (prealloc) {
>  		if (old_elem) {
>  			/* if we're updating the existing element,
> -			 * use per-cpu extra elems to avoid freelist_pop/push
> +			 * use per-cpu extra elems to avoid freelist_pop/push.
> +			 * The caller puts old_elem into the slot once it is
> +			 * unlinked. Until then the slot is empty for an NMI
> +			 * or a kprobe that updates this map on this cpu.
>  			 */
>  			pl_new =3D this_cpu_ptr(htab->extra_elems);
> -			l_new =3D *pl_new;
> -			*pl_new =3D old_elem;
> +			l_new =3D READ_ONCE(*pl_new);
> +			do {
> +				if (!l_new)
> +					return ERR_PTR(-EBUSY);
> +			} while (!try_cmpxchg_local(pl_new, &l_new, NULL));
>  		} else {
>  			struct pcpu_freelist_node *l;
> =20
> @@ -1459,11 +1465,14 @@ static long htab_map_update_elem(struct bpf_map *=
map, void *key, void *value,
>  	if (l_old) {
>  		hlist_nulls_del_rcu(&l_old->hash_node);
> =20
> -		/* l_old has already been stashed in htab->extra_elems, cancel
> -		 * its reusable special fields before it is available for reuse.
> +		/* l_old replaces the extra element that alloc_htab_elem() took,
> +		 * cancel its reusable special fields before the next update on
> +		 * this cpu reuses it.
>  		 */
> -		if (htab_is_prealloc(htab))
> +		if (htab_is_prealloc(htab)) {
> +			WRITE_ONCE(*this_cpu_ptr(htab->extra_elems), l_old);
>  			check_and_cancel_fields(htab, l_old);
> +		}
>  	}
>  	htab_unlock_bucket(b, flags);
>  	if (l_old && !htab_is_prealloc(htab))

[Severity: High]
In kernel/bpf/hashtab.c:htab_map_update_elem(), l_old is written to
htab->extra_elems before check_and_cancel_fields(htab, l_old) is called:

    if (htab_is_prealloc(htab)) {
        WRITE_ONCE(*this_cpu_ptr(htab->extra_elems), l_old);
        check_and_cancel_fields(htab, l_old);
    }

Once WRITE_ONCE(*this_cpu_ptr(htab->extra_elems), l_old) executes, the
per-CPU slot is no longer NULL. If an NMI or a tracing program (for example,
fentry on bpf_obj_cancel_fields()) triggers on the same CPU and updates an
existing key in another bucket of the same preallocated map,
alloc_htab_elem() will claim l_old instead of returning -EBUSY.

When the map contains BTF special fields (BPF_TIMER, BPF_WORKQUEUE, or
BPF_TASK_WORK), the nested update can link l_old into the other bucket while
its previous timer, workqueue, or task_work fields are still active, and th=
en
the outer check_and_cancel_fields(htab, l_old) will cancel and free the
special fields of the newly inserted live element.

Should check_and_cancel_fields(htab, l_old) be called before
WRITE_ONCE(*this_cpu_ptr(htab->extra_elems), l_old) so the slot stays NULL
until the special fields have been canceled?

=D1=82=D0=B8=D1=82=D1=8C=D1=81=D1=8F

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017012058.3557=
87-1-alexei.starovoitov@gmail.com?part=3D4
