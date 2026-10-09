Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87234CFCF;
	Fri,  9 Oct 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533528; cv=none; b=kGulbKJCec4pOaDdrA5oxspfPYT+NONtjUTz0pP3z6IeIYf+IADpDfnNbBJDnEbIox57SEIAqqJX3ObHG04rtOmS5gNNWqu5HrRyhRlJSwiJvJpPynhWkUZWL58vRmGh+3PYzgIlxUU9nmptoH5tmBQ7iK1TNxUoCdu1jblhihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533528; c=relaxed/simple;
	bh=LzNfJ/QuelNQIPa+5THeRO/sO8w9449OvViZXPZz9JA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=idP4III8wyKtECyXwipxMyO+c2UPoi2oR+Ox0XyHOGfE3nn0Llg9A3+137JMovJt/x6wfZww3bveRxRlU9PpyW+UI7EPVI2X6kEP6VJZ2tEV3iAn3m01XQcVtOkJ2sBvHovesJhKmNBq1XOvP7lhzdTbyVqlCVKs/VG44OriOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfSb+jil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfSb+jil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716331F00898;
	Fri,  9 Oct 2026 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791533521;
	bh=MGSDFZ8QxtD4W8jGrQZdA7pypggrA+L9YwjgZcmH5IQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QfSb+jilw++8MZxxcYU8mE45J1fz4R+CEki4qu4kJlX3r4vMD2mEc2KMf9coM3xA0
	 /wgOuXmec+iBPz5UjeaJt/Lyg3apnPu8Ck0B+JeYyEmczl5mcLCBkAEKlsp16QCaXi
	 QlqS07hJGOOFch7pwjyq9l+2vjQtk5rxjS6/SBjZU783Xa5b+FLYxkxEhqlOxbGqac
	 SZ49uE3gf4dov4vDgHe37L7bk7IbkBi2hUHXeSb2hjBtESKoCxOZpetiGgp/R1Fitg
	 Z0NtjO5fCqUgpqDCJhqJVWTZC9DU5iEU8bozIatcwwfS7NDtnVhrMKfd81QFA9iVQK
	 dtum5r9oDqObg==
Subject: Re: [PATCH net-next 3/9] net: skbuff: don't BUG() on a bad frag_list
 layout in skb_segment()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kaiyuanz@google.com,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 09 Oct 2026 08:12:00 +0000
Message-ID: <179153352002.434549.8562336759000042936@kernel.org>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-3-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-3-1b4434c5357c@toxicpanda.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit "net: skbuff: don't BUG() on a bad frag_list layout in
  skb_segment()" replaces four BUG_ON()s in skb_segment()…
- [Low] The comment in bpf_skb_net_grow() (net/core/filter.c:3698-3702)
  still says "There is a BUG_ON() when segmenting the frag_list with…
- [Low] The KUnit test gso_test_func() in net/core/net_test.c (lines
  223-227) turns off NETIF_F_SG for GSO_TEST_FRAG_LIST_NON_UNIFORM.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  skb_segment() (net/core/skbuff.c) still dereferences list_skb without…

--

net: skbuff: don't BUG() on a bad frag_list layout in skb_segment()

This patch replaces the four BUG_ON() frag_list layout checks in
skb_segment() with WARN_ON_ONCE(). Each one now takes the existing -EINVAL
error path. The check in the clone path runs after skb_clone(), so it also
frees the clone before bailing out.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 5d856948cef92..405d27e9bc9d1 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4916,7 +4916,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  
>  		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
>  		    (skb_headlen(list_skb) == len || sg)) {
> -			BUG_ON(skb_headlen(list_skb) > len);
> +			if (WARN_ON_ONCE(skb_headlen(list_skb) > len)) {
> +				err = -EINVAL;
> +				goto err;
> +			}

[Severity: Medium]
The commit message says "Anybody who can get a malformed GSO skb to a
segmentation point gets to crash the box". Malformed input can reach all
four of these checks. Is WARN_ON_ONCE() the right tool for them?

If panic_on_warn is set (boot parameter or the kernel.panic_on_warn
sysctl), check_panic_on_warn() turns each of these warnings into a panic:

kernel/panic.c:check_panic_on_warn() {
	if (panic_on_warn)
		panic("%s: panic_on_warn set ...\n", origin);
	...
}

On those systems the crash is still there. On other systems a malformed
skb still taints the kernel and prints a stack trace.

The "Do not WARN lightly" section of coding-style.rst says WARN*() should
not be used for conditions that user space can trigger.

A little further down in the same loop, the too many frags check handles
a malformed layout with net_warn_ratelimited() and -EINVAL.

Would net_warn_ratelimited() or DEBUG_NET_WARN_ON_ONCE(), plus the -EINVAL
drop, be a better fit for all four converted checks?

[Severity: Low]
This isn't a bug, but a comment in bpf_skb_net_grow() still refers to the
BUG_ON() that this patch removes:

net/core/filter.c:bpf_skb_net_grow() {
		/* Due to header growth, MSS needs to be downgraded.
		 * There is a BUG_ON() when segmenting the frag_list with
		 * head_frag true, so linearize the skb after downgrading
		 * the MSS.
		 */
}

After this patch skb_segment() has no BUG_ON() left. A lowered MSS now
makes this check return -EINVAL instead.

The skb_linearize() call is still needed, to avoid a dropped packet. Should
the comment give that reason instead?

>  
>  			nskb = skb_clone(list_skb, GFP_ATOMIC);
>  			if (unlikely(!nskb))
> @@ -4929,7 +4932,11 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  			pos += skb_headlen(list_skb);
>  
>  			while (pos < offset + len) {
> -				BUG_ON(i >= nfrags);
> +				if (WARN_ON_ONCE(i >= nfrags)) {
> +					kfree_skb(nskb);
> +					err = -EINVAL;
> +					goto err;
> +				}

[Severity: Low]
This isn't a bug, but gso_test_func() in net/core/net_test.c says SG is
turned off to avoid this BUG_ON():

net/core/net_test.c:gso_test_func() {
	/* TODO: this should also work with SG,
	 * rather than hit BUG_ON(i >= nfrags)
	 */
	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
		features &= ~NETIF_F_SG;
}

With this patch there is no BUG_ON(i >= nfrags) left. The check returns
ERR_PTR(-EINVAL) instead, and the test would report that through its
IS_ERR(segs) path.

Should this comment be updated? Would a negative test for the new -EINVAL
path also be worth adding?

>  
>  				size = skb_frag_size(frag);
>  				if (pos + size > offset + len)
> @@ -5036,9 +5043,15 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
>  
>  				if (!skb_headlen(list_skb)) {
> -					BUG_ON(!nfrags);
> +					if (WARN_ON_ONCE(!nfrags)) {
> +						err = -EINVAL;
> +						goto err;
> +					}
>  				} else {
> -					BUG_ON(!list_skb->head_frag);
> +					if (WARN_ON_ONCE(!list_skb->head_frag)) {
> +						err = -EINVAL;
> +						goto err;
> +					}

[Severity: Medium]
This is a pre-existing issue, but what happens here if the frag_list is
already used up and list_skb is NULL?

Just above this hunk, the i >= nfrags branch in skb_segment() does:

	if (i >= nfrags) {
		if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
		    skb_zerocopy_clone(nskb, list_skb,
				       GFP_ATOMIC))
			goto err;

		i = 0;
		nfrags = skb_shinfo(list_skb)->nr_frags;
		...

skb_zcopy() checks skb before using it, so both helpers return 0 for a
NULL skb. Nothing catches the NULL list_skb.
skb_shinfo(list_skb)->nr_frags and skb_headlen(list_skb) then dereference
NULL before any of the new checks run.

pos only advances over each frag_list member's linear data and page
frags. It does not cover a nested frag_list. Take a member with headlen 0,
one page frag, a nested frag_list and a NULL next pointer. Could it leave
pos < offset + len after list_skb has become NULL?

Two other places make the same assumption: the skb_headlen(list_skb) test
in the clone path at the top of the loop, and len = list_skb->len for
GSO_BY_FRAGS.

GRO does not appear to build nested frag_lists today, because
dev_gro_receive() flushes skbs that already have a frag_list. No current
producer of this layout is known.

Since the goal is to drop malformed layouts rather than crash, would a
check like this at those places make sense?

	if (unlikely(!list_skb)) {
		err = -EINVAL;
		goto err;
	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c%40toxicpanda.com
