Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA4353A65;
	Sun, 11 Oct 2026 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738047; cv=none; b=LH2Zn+dzYNDlOrAauYvjgQ7QlD/aAoA/royHYFnevjW3HLH+xM7ybJPUMOV6u51qfvuKGznrjeF3b3FcGyJYzMsatxipWxBCRfAQ4Swi65vOXqVrW+CdQtKQKc+vIefHfQL4JRjZDoa1/ncQH9UWyr1tEWK5h1xsHwBSePZP9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738047; c=relaxed/simple;
	bh=ByLiojNBjsIaGV0p4pEXQGgwAFssr0vIAKGe0bJbjt4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CKQTKzf8l1B8UnVpj1xoRkqo6CkO/EMmGzbrT4xfb8SV4Zfe1Q7k6OuTrdVHH4EVP5nVehntuBB01cM4MMseiRMtzg9DXmvPuC62SogF3fKGF3tDOP3uF5DvKH/ifWs005FfI0znuTAsxCtSq2n8MhBDsQlK8tkYGFK3NuUNysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIqmEN3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIqmEN3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1041F0089B;
	Sun, 11 Oct 2026 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791738045;
	bh=xMbu6g9PgdIm67LVG4W6Tv2hrcIoP9hS1f/lY+PN8yA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YIqmEN3+w9cx8GgxIPSGTxphiwswebpAOjfnnF5+b328nW+vTiMjqmjsEHKYm3/ix
	 L8SrpK9HPVFl4w5BhQHo78R36B3/Ak41R+OBWpwFaHIeGiI8kRlmp5+Cup4mVzss6A
	 jfG0vzQ4GGkXoaE7wEkjNuGZvCFfvCq46/U+9a4TV2QhuY6XV0qVAWpvItk8aC+LJS
	 MkZosCUfvdfvixAmuRe6a2lUVTMuQc9aYM2rRB7isYkpUTXBU0n2dF7ET30XkMDWab
	 SA8aAXi/umOGvJuBGC3/oiq6bR2CAcaENFLZnqPbBhmRYDCWOkmDfQY3BbzK96wfKf
	 IaldnUG5xceXQ==
Subject: Re: [PATCH net-next v2 2/8] net: skbuff: don't BUG() on a bad
 frag_list layout in skb_segment()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 17:00:44 +0000
Message-ID: <179173804472.434549.15534694092186867608@kernel.org>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-2-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-2-b9a5f732895b@toxicpanda.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is incomplete.
- [Low] This patch makes the comment in bpf_skb_net_grow()
  (net/core/filter.c:3698-3702) out of date.
- [Low] This patch makes the KUnit GSO test comment in gso_test_func()
  (net/core/net_test.c:223-227) out of date.

--

net: skbuff: don't BUG() on a bad frag_list layout in skb_segment()

This commit changes the four BUG_ON() layout checks in the frag_list walk
of skb_segment() to use the existing -EINVAL error path, adding a
DEBUG_NET_WARN_ON_ONCE() for debug kernels. The check that runs after
skb_clone() also frees the clone, which has not been linked yet, before
it bails out.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d226fe77d4847..a6821ab139691 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4916,7 +4916,11 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  
>  		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
>  		    (skb_headlen(list_skb) == len || sg)) {
> -			BUG_ON(skb_headlen(list_skb) > len);
> +			if (unlikely(skb_headlen(list_skb) > len)) {
> +				DEBUG_NET_WARN_ON_ONCE(1);
> +				err = -EINVAL;
> +				goto err;
> +			}

[Severity: Low]
This isn't a bug, but with this BUG_ON() and the head_frag BUG_ON() below
both converted, the comment in bpf_skb_net_grow() looks out of date:

net/core/filter.c:bpf_skb_net_grow() {
    ...
		/* Due to header growth, MSS needs to be downgraded.
		 * There is a BUG_ON() when segmenting the frag_list with
		 * head_frag true, so linearize the skb after downgrading
		 * the MSS.
		 */
    ...
}

The linearize is still needed, because the packet would otherwise be
dropped with -EINVAL. Should the comment say the packet is dropped
instead of referring to a BUG_ON()? No later patch in the series appears
to touch this comment.

>  
>  			nskb = skb_clone(list_skb, GFP_ATOMIC);
>  			if (unlikely(!nskb))
> @@ -4929,7 +4933,12 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  			pos += skb_headlen(list_skb);
>  
>  			while (pos < offset + len) {
> -				BUG_ON(i >= nfrags);
> +				if (unlikely(i >= nfrags)) {
> +					DEBUG_NET_WARN_ON_ONCE(1);
> +					kfree_skb(nskb);
> +					err = -EINVAL;
> +					goto err;
> +				}

[Severity: Low]
This isn't a bug, but the KUnit GSO test still names this assertion:

net/core/net_test.c:gso_test_func() {
    ...
	/* TODO: this should also work with SG,
	 * rather than hit BUG_ON(i >= nfrags)
	 */
	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
		features &= ~NETIF_F_SG;
    ...
}

Should this comment be updated now that BUG_ON(i >= nfrags) is gone? It
is still unchanged at the end of the series.

Also, since the test clears NETIF_F_SG for this case, no in-tree test
seems to exercise the new kfree_skb(nskb) unwind or the
kfree_skb_list(segs) / ERR_PTR(-EINVAL) return. Would a negative test
case for this path be worth adding?

>  
>  				size = skb_frag_size(frag);
>  				if (pos + size > offset + len)
> @@ -5036,9 +5045,17 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
>  
>  				if (!skb_headlen(list_skb)) {
> -					BUG_ON(!nfrags);
> +					if (unlikely(!nfrags)) {
> +						DEBUG_NET_WARN_ON_ONCE(1);
> +						err = -EINVAL;
> +						goto err;
> +					}
>  				} else {
> -					BUG_ON(!list_skb->head_frag);
> +					if (unlikely(!list_skb->head_frag)) {
> +						DEBUG_NET_WARN_ON_ONCE(1);
> +						err = -EINVAL;
> +						goto err;
> +					}

[Severity: Medium]
Can skb_segment() still oops on a malformed frag_list through a NULL
list_skb?

For each frag_list member, the walk counts the linear part and frags[].
It never descends into a member's own nested frag_list, but
head_skb->len includes those bytes. With a nested frag_list, list_skb can
become NULL while bytes are still owed, and nothing checks for that.

In the SG loop, take a member with headlen 0, one page frag and a nested
frag_list. It passes the new !nfrags check, and list_skb advances to
NULL. Once that frag is used up, the next pass does this:

		while (pos < offset + len) {
			if (i >= nfrags) {
				if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
				    skb_zerocopy_clone(nskb, list_skb,
						       GFP_ATOMIC))
					goto err;

				i = 0;
				nfrags = skb_shinfo(list_skb)->nr_frags;

skb_orphan_frags(NULL) and skb_zerocopy_clone(nskb, NULL) both return 0,
because skb_zcopy() checks skb first. skb_shinfo(NULL) is then
dereferenced before the new !nfrags and !head_frag checks can run.

The clone branch has the same problem. Take a member with headlen == len,
no page frags, and a nested frag_list. The new > len check passes, the
inner while loop never runs, and list_skb = list_skb->next sets it to
NULL. pskb_trim() also drops the nested data from the clone. Since
offset + len is still below head_skb->len, the next iteration evaluates:

		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&

with list_skb == NULL. In the gso_by_frags case, len = list_skb->len at
the top of the loop has the same issue.

tcp_gso_segment() appears to pass such an skb to skb_segment() unchanged.
I couldn't find an in-tree producer of nested frag_lists that reaches
here with NETIF_F_SG set. GRO sets NAPI_GRO_CB(skb)->flush when the skb
already has a frag_list.

Since the goal is to stop malformed layouts from crashing the box, should
the walk return -EINVAL when list_skb is NULL before each use, or reject
nested frag_lists up front? Later patches in the series don't appear to
add such a check.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b%40toxicpanda.com
