Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B551363097;
	Sun, 11 Oct 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738053; cv=none; b=O2MlFal+YlyHobz46ZDgHdB6iVg6CI4a31wSSUeqwkFpc4gSLGO6KNSBrO5LmtzV9l9KZoLfqT7i2EeuZ3zrZYBbbN4QdWLL9uNIO1ANAT6NtdkH4G1tJnqsstaYMm2eKMMMPDUwsgpdI+wYo+2KgGKgS9Jnc4YCyys0BZylCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738053; c=relaxed/simple;
	bh=FbxG+px3G5632sS0Zj5o+7HZISGsr2yu2FpIeHiOzGE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+q0AKCK0ixovf/ssFFmB4M4pDIrP0GSJoq8Z/hrcY8FEwvcIY9N0RsiQ3lwFZbhs37kjyGuZyB3GtqV9A7cmGZnAnMh3MUhYJWeSgkImDwj3KguT+zLvbfbXZG8/dI3Yr2oTC2I/3pHTg3R2HURWNSx/jDJFFaFgjCxFeMr8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI3h1wJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI3h1wJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6AF1F0089E;
	Sun, 11 Oct 2026 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791738050;
	bh=dZTDnCK3HgK3uX/LOK0zMufM9J/PD7mhbFkE1Zi+CY8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XI3h1wJz9MrzQybrSgTl5mNa3mgjJSa3Xp3oZD0CxqdyF2M1bO1IGqZp8XTynEpvP
	 /NQ0239v7Cl5tRvD5Xg08NWs6j90oC+hUsPAXgVJC9cTz5RUdpS+OusGfCV51QVXt7
	 KcBtBo+qmCKy6R0m/hLMyXSBtRR2A5OAkpVakr7Wary4PeyO5gqb28OzqAXW2iE5px
	 GBUDaWM0bApWhcksMmSbaMtZY1jJZMwOdZQO9VmWcnptoAxQeScQ4DRGiUHQy2Hhs2
	 aALlT7FDG5zWlEBk4ptGCA4CHDCOs3/VNaY/EWU8/O6uOuj3Fkegeq2ptopAkFCf4a
	 cx6TiIalCWGvA==
Subject: Re: [PATCH net-next v2 7/8] net: skbuff: don't BUG() on a missing
 head_frag in skb_zerocopy()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 17:00:49 +0000
Message-ID: <179173804997.434549.4450793967361922984@kernel.org>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-7-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-7-b9a5f732895b@toxicpanda.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message calls `!from->head_frag && !hlen` in
  skb_zerocopy() a caller bug or "bad skb geometry".
- [Low] The patch adds a new -EFAULT return to skb_zerocopy() without
  updating its kernel-doc.

--

net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()

This patch replaces the BUG_ON() in skb_zerocopy(), which fires when @from
has no head_frag and hlen is 0. In its place is a DEBUG_NET_WARN_ON_ONCE()
and an -EFAULT return. The commit message describes the condition as bad
skb geometry passed in by the caller.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7fd2f8142cc41..629de22d98e48 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3913,7 +3913,10 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
>  	struct page *page;
>  	unsigned int offset;
>  
> -	BUG_ON(!from->head_frag && !hlen);
> +	if (unlikely(!from->head_frag && !hlen)) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return -EFAULT;
> +	}
>  
>  	/* dont bother with small payloads */
>  	if (len <= skb_tailroom(to))

[Severity: Medium]
Is this condition always a caller bug? The commit message says:

  "The check runs before anything is touched, and skb_zerocopy() already
  documents -EFAULT for bad skb geometry."

An ordinary zero-length packet from Open vSwitch seems able to reach it:

ovs_packet_cmd_execute()
  __dev_alloc_skb(NET_IP_ALIGN + len, GFP_KERNEL) /* kmalloc head */
  ... POP_ETH action on a 14 byte untagged frame
    pop_eth()->skb_eth_pop()->skb_pull_rcsum(skb, ETH_HLEN) /* len 0 */
  ... USERSPACE action
    output_userspace()->ovs_dp_upcall()->queue_userspace_packet()
      skb_zerocopy(user_skb, skb, 0, 0)

Because the allocation uses GFP_KERNEL, the head comes from kmalloc and
head_frag stays 0.

In queue_userspace_packet(), skb_len = min(skb->len, cutlen) is 0, and
hlen is 0 on both branches:

	if (dp->user_features & OVS_DP_F_UNALIGNED)
		hlen = min(skb_zerocopy_headlen(skb), cutlen);
	else
		hlen = skb_len;

When a !head_frag skb has no linear data, skb_zerocopy_headlen() returns
from->len, which is 0 here.

OVS_PACKET_CMD_EXECUTE uses GENL_UNS_ADMIN_PERM, so CAP_NET_ADMIN inside a
user namespace is enough to get here. With the old BUG_ON(), that made
this a crash that userspace could trigger.

Should the commit message describe this path and carry a Fixes: tag and a
stable note, so stable kernels pick up the change?

With len == 0, the small-payload fast path below always copies zero bytes
and returns 0. That is what an skb with head_frag already gets.

After this patch, the same request returns -EFAULT for kmalloc-head skbs.
The upcall is then dropped and counted in n_lost. On CONFIG_DEBUG_NET
kernels it also fires a WARN that userspace can trigger, and with
panic_on_warn set that WARN panics the machine.

nfqnl_build_packet_message() never hits this because it only calls
skb_zerocopy() when data_len is non-zero. queue_userspace_packet() has no
such guard.

Could the check move below the "len <= skb_tailroom(to)" fast path? Or
could it be enforced only when the head really has to be referenced as a
page, i.e. hlen == 0 && plen > 0?

[Severity: Low]
This isn't a bug, but the kernel-doc for skb_zerocopy() still gives only
these causes for -EFAULT:

 *	-EFAULT: skb_copy_bits() found some problem with skb geometry, or readable head
 *      payload would be mixed with unreadable frags.

The new early return gives -EFAULT before skb_copy_bits() or any frag
readability check runs.

Should the Return value section mention this case? It could also state the
precondition the old BUG_ON() enforced: hlen must be non-zero when @from
has no head_frag.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b%40toxicpanda.com
