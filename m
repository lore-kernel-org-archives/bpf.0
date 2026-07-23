Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5317F45D1A3;
	Thu, 23 Jul 2026 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824197; cv=none; b=pMGQxajX2P9BbOCxnR8FMa8+QnqGQhUU2kS6J6CUJa/CvAvnkashTs3+v/1SBA4zasICJl7/KatlvkjzvKViMHEf+/fmaaPiqMb0TGToyq6QU3HKWPZgYFYxRtYcF27p8LSM4uGROmhnbWrIa9Jk/CPbdXq6GdnOqIHi8IuUYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824197; c=relaxed/simple;
	bh=/cSrtwwDG/OeEv9j4ZM7vkFNdubrEiKmwU7mLoyt7Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOep5Vmy3FNHl+4dV0zGuGuyYAYRZ143W0l3iakxUDHBBLMsdLqmcid6aNMQNwB1eMLMBtrwHIHBLgyAzN1k7QJPXIx4mC4lxRPpnUG/ZDkdjicZ7bpDAj44frFOAtMMPN7hL/Enpp1PGh5vBS4dUzLIpoX7PhZh2UQtFPKDZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730571F000E9;
	Thu, 23 Jul 2026 16:29:47 +0000 (UTC)
From: Jakub Kicinski <kuba@kernel.org>
To: maciej.fijalkowski@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	kernelxing@tencent.com
Subject: Re: [PATCH v4 net 2/6] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Thu, 23 Jul 2026 09:29:43 -0700
Message-ID: <20260723162943.747184-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260719135609.147823-3-maciej.fijalkowski@intel.com>
References: <20260719135609.147823-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
xsk: drain continuation descs after overflow in xsk_build_skb()

This patch fixes the AF_XDP generic xmit path so that when a
multi-buffer packet exceeds MAX_SKB_FRAGS or contains an invalid
descriptor, the remaining continuation descriptors are drained onto
the completion ring instead of being silently lost. A new
xdp_sock::drain_cont flag tracks whether draining is in progress
across sendmsg invocations.

Link: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/

> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ebac60a3d8a1..8b51876efbed 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -80,6 +80,7 @@ struct xdp_sock {
>  	 * call of __xsk_generic_xmit().
>  	 */
>  	struct sk_buff *skb;
> +	bool drain_cont;

[Low]
Would it be worth documenting drain_cont here in the same style as the
preceding skb field? The semantics are non-trivial: the flag persists
across sendmsg invocations, only clears when a non-CONTD descriptor is
consumed, and can be transiently overwritten in the post-loop error
path with the composed expression:

    bool drain = xs->skb || xs->drain_cont || xp_mb_desc(&desc);

Today those semantics can only be reconstructed by reading the four
separate assignment sites in net/xdp/xsk.c. The options field is
also user-influenceable (an invalid descriptor can still carry
XDP_PKT_CONTD), which is worth calling out for future readers.

>  
>  	struct list_head map_list;
>  	/* Protects map_list */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index a7a83dc4546a..12a845d012f6 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -1063,11 +1077,21 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
>  
> +		if (unlikely(xs->drain_cont)) {
> +			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
> +			xs->tx->invalid_descs++;
> +			xskq_cons_release(xs->tx);
> +			xs->drain_cont = xp_mb_desc(&desc);
> +			continue;
> +		}
> +
>  		skb = xsk_build_skb(xs, &desc);
>  		if (IS_ERR(skb)) {
>  			err = PTR_ERR(skb);
>  			if (err != -EOVERFLOW)
>  				goto out;
> +			if (xp_mb_desc(&desc))
> +				xs->drain_cont = true;

[Low]
Is the xp_mb_desc(&desc) check here ever false in practice? Looking at
xsk_build_skb() in net/xdp/xsk.c, the only place -EOVERFLOW is returned
is:

    if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc)))
            return ERR_PTR(-EOVERFLOW);

so reaching this point already implies xp_mb_desc(&desc) is true, and
the conditional appears to be a tautology.

Would it read more clearly as an unconditional assignment with a
comment noting the invariant, or alternatively a comment explaining
that a future non-CONTD -EOVERFLOW return would also want draining?
As written, adding a new -EOVERFLOW return site could silently
bypass the drain machinery.

>  			err = 0;
>  			continue;
>  		}
> @@ -1096,18 +1120,33 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
>  
> -		sent_frame = true;
>  		xs->skb = NULL;
>  	}
>  
>  	if (xskq_has_descs(xs->tx)) {
> +		bool drain = xs->skb || xs->drain_cont || xp_mb_desc(&desc);
> +
> +		err = xsk_cq_reserve_locked(xs->pool);
> +		if (err) {
> +			xs->tx->invalid_descs--;

[Low]
Can this decrement of xs->tx->invalid_descs be made less fragile?

The value being cancelled here appears to be the increment performed
inside xskq_cons_is_valid_desc() as called from
xskq_cons_peek_desc(), which incremented invalid_descs before
returning false and dropping out of the while loop. Nothing at the
decrement site documents this cross-function dependency.

invalid_descs is a u64 exposed to userspace through XDP_STATISTICS,
so if the increment location is ever refactored, or if a future path
lets xskq_has_descs() be true here without having gone through a
validity-check failure, this decrement will underflow the counter to
~2^64-1.

Would a short comment naming the paired increment site, or an explicit
save/restore around the peek, make the invariant more robust to future
changes?

> +			if (xs->skb)
> +				xsk_drop_skb(xs->skb);
> +			xs->drain_cont = drain;
> +			err = -EAGAIN;
> +			goto out;
> +		}
> +
>  		if (xs->skb)
>  			xsk_drop_skb(xs->skb);
> +
> +		xsk_cq_submit_addr_single_locked(xs->pool, &desc);
> +
>  		xskq_cons_release(xs->tx);
> +		xs->drain_cont = xp_mb_desc(&desc);
>  	}
