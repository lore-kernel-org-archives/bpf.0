Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2F382394
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838966; cv=none; b=p5EeNHKoOZolZ3Y+cGJjEu17OknH62k/o7cHTuIeKU8VTr9zFTo9kOVP4cjBvAV+ML46lMrppXGI30cbsnf0pAZUtlNuQoZefUTZjfccrFIGlc5qgq1FGIAIAthyGvE7m0DA9K6Vws9uSbbOBUpnzPt3DbDItPjRwdRMk6QP8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838966; c=relaxed/simple;
	bh=3xkZ1I4V9e5W+zJ8RdTsPcKI5CtCMPp6aRPOwKILVbg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pbkmapyDv/TEt2XGg66+LsNK9C1N/1IpMa11TFRzroYHkxD6z2T13vIYY9tpwJQBBhXyi3y9Yj+PoooEN9Z+9p28QwqkcwWZfuRlDNKJ5gXotwgWFLmhwKgOWFIhuzvvqkkUxylipf9kou0mAiUx+nF4mdyuzAR5bCg96eA65VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va9il2PR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va9il2PR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF06C2BCC4;
	Sun,  3 May 2026 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777838966;
	bh=3xkZ1I4V9e5W+zJ8RdTsPcKI5CtCMPp6aRPOwKILVbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Va9il2PRm3CzVl+fZAlTzdcBg1Xj/XVdK23v9qIjmFuNlQupysejTIDnYmX2DSXZF
	 wjgBe9Bmdc0KhDjmiQvSwLtvcOWacHwuu7GeC/nEWPKoNDwIZ1rGc8ffFuybVuIT4s
	 7QohMy4fxjujMI4Tkma4nVjS6t+dMeNep2Rae2E4j9SciKhcjBtTqha9cE6CSLRP7z
	 pk3W/ZcYYyhE8grvqRhCHbdHB9g6fW0DkKNBaLIolOkWGrGuRYZHMATeetMUKooLQI
	 pYLJmOOB3eCQH7yjsZ7SS+bD8A34j4uRok75twV9/7tclRgQm3eqDXrun5+bivlL6u
	 MIaVfhGWn2xog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 4/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260502200722.53960-5-kerneljasonxing@gmail.com>
References: <20260502200722.53960-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 20:09:25 +0000
Message-Id: <20260503200925.DEF06C2BCC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Memory leak of SKB in xsk_build_skb_zerocopy() when TX metadata pr=
ocessing fails.
- [High] Memory leak of xsk_addr array when an SKB fragment allocation fail=
s and the packet is subsequently dropped.
- [High] Double completion and Completion Queue (CQ) state desynchronizatio=
n when xsk_skb_metadata() fails.
--

commit 7c8b265d19cf8eaa2671c3f79683f55810dfc68a
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path

When xsk_build_skb() processes multi-buffer packets in copy mode, the
first descriptor stores data into the skb linear area without adding
any frags, so nr_frags stays at 0. The caller then sets xs->skb =3D skb
to accumulate subsequent descriptors.

Fix by using a !xs->skb check to handle first frag situation, ensuring
we only free skbs that were freshly allocated in this call.

Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@=
gmail.com/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 06ee260f3afc..55378c3855d5 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -972,7 +972,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
>  	return skb;
> =20
>  free_err:
> -	if (skb && !skb_shinfo(skb)->nr_frags)
> +	if (skb && !xs->skb)

Does this code leak the SKB if xsk_build_skb_zerocopy() allocations fail
during TX metadata processing?

If xsk_build_skb_zerocopy() allocates a new SKB using sock_alloc_send_skb()
but metadata parsing fails (e.g., xsk_skb_metadata() returns an error), it
returns ERR_PTR(err). The caller xsk_build_skb() explicitly overwrites its
local pointer with skb =3D NULL before jumping to free_err:

        skb =3D xsk_build_skb_zerocopy(xs, desc);
        if (IS_ERR(skb)) {
                err =3D PTR_ERR(skb);
                skb =3D NULL;
                goto free_err;
        }

Since skb is NULL, this check is bypassed, and the newly allocated SKB and
its associated socket write memory quota are leaked.

I understand this is fixed later in the patch series by commit "xsk: avoid
skb leak in XDP_TX_METADATA case".

Does this code leak the xsk_addr array when an SKB fragment allocation
fails and the packet is subsequently dropped?

When appending a fragment to an in-progress packet (xs->skb !=3D NULL), the
code identifies an inline address tag and replaces it by allocating an
xsk_addr array via kmem_cache_zalloc(), initializing xsk_addr->num_descs
to 1.

If alloc_page() subsequently fails, the code returns -EAGAIN to retry later,
leaving xs->skb intact.

If the packet is dropped before a successful retry (e.g., socket close
triggering xsk_release() and xsk_drop_skb()), xsk_consume_skb() attempts to
clean up the array. However, xsk_consume_skb() uses the check
if (unlikely(num_descs > 1)) to determine if it should call
kmem_cache_free().

Since num_descs is exactly 1, the check evaluates to false, and the xsk_add=
rs
allocation is leaked.

I see this is fixed later in the patch series by commit "xsk: fix xsk_addrs
slab leak on multi-buffer error path".

>  		kfree_skb(skb);

Can this kfree_skb() call lead to a double completion and Completion Queue
(CQ) state desynchronization if xsk_skb_metadata() fails?

In xsk_build_skb() copy mode, xsk_skb_init_misc() sets
skb->destructor =3D xsk_destruct_skb. Immediately after, if xsk_skb_metadat=
a()
fails, execution jumps to free_err and triggers this kfree_skb(skb).

This executes the SKB destructor, which unconditionally submits the failed
descriptor to the Completion Queue by advancing the user-visible
ring->producer pointer.

Immediately following the free, the free_err handler calls
xsk_cq_cancel_locked(), which decrements the internally cached cached_prod
reservation counter. This desynchronizes the internal reservation counter f=
rom
the user-visible ring pointer and falsely pushes a completion event to user
space for a descriptor that failed transmission.

I note this is fixed later in the patch series by commit "xsk: prevent CQ
desync when freeing half-built skbs in xsk_build_skb()".

> =20
>  	if (err =3D=3D -EOVERFLOW) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.5396=
0-1-kerneljasonxing@gmail.com?part=3D4
