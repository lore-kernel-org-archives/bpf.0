Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5549AA4D;
	Fri,  9 Oct 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533536; cv=none; b=O4KNfOk9NzYtH2FfBtAZyqpUTDMsOwt3Cy2gi7IfLz5H7nHX6fWXcr6W/LofC1qYLnVhGMifCJZ10nC6ExL1ksowopj9x1N5nhUzA4A2OX9Cs2k2baRfSNwGSu3Tcu3mFxZD4v9IQymFi5TLYYWQYNa9uB6zK5xWKZWbo4JdHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533536; c=relaxed/simple;
	bh=M7S8dJ/eZO0A9OjcfzhdE6UG3F4nfMApE6SDSmotEBA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zgkuq6JIuQwsnhJ9OX3+zJst9BYrqXRxQydu8ZjJxR2a3JcxwfJWfJGH2BT/ZJ7xwOLcG0B0ZnpvYFqv/ohvsw5+8F8DB4DEWkNT8v8GimkxdQKN/LCcuggd1u4zx0QFZSBw5X8wOH2YgnXqlJ4vDl4lLNH72Hn7yG6xHP5OP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7hUw667; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7hUw667"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3734D1F0089C;
	Fri,  9 Oct 2026 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791533525;
	bh=L8XRnEnBa0HKZHjy6KbvaHgrxcXuvCFoIys4n38QheI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a7hUw667ASk5Jg9org+cghkmjacvpLh2fM10kb+Ul8WBeJjrm3VeO+cbjNghlI9/J
	 dO1FrLsdg5e8mE//l3dN+VLCkoQLc8sL8l5qqtAav5NGCEPC91J9IAD9iP10UE1HyP
	 9BnILIAp6KHnSg5HCzKXY1ztRuLLSmIxDmqrGFeefZH399HSdhyxiW0/iaVTGpCfoh
	 IWtErZPsN1qtZswB2YzYB2Vo3i/oVGmCacsgRDjw1UM39g++GWkaadFWppOSAFxk04
	 7rZM+xATrv8X31vkHXGT/BaiLM1ar+swzFYNVmGrjb4Kt3V5BoussZs5eN45RJxv3Y
	 iSHoOKPe9AICQ==
Subject: Re: [PATCH net-next 8/9] net: skbuff: don't BUG() on a missing
 head_frag in skb_zerocopy()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kaiyuanz@google.com,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 09 Oct 2026 08:12:04 +0000
Message-ID: <179153352480.434549.16663209568702554994@kernel.org>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-8-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-8-1b4434c5357c@toxicpanda.com>
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

- [Medium] skb_zerocopy() now WARNs and returns -EFAULT on a legitimate,
  user-reachable input: an empty (len == 0) skb without head_frag.
- [Low] The kernel-doc 'Return value' section of skb_zerocopy() lists
  exactly two causes of -EFAULT: 'skb_copy_bits() found some problem…
- [Low] The patch removes a BUG() in skb_zerocopy() that userspace can
  actually reach, but the commit message has no Fixes: tag (the first…

--

net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()

This commit replaces the BUG_ON(!from->head_frag && !hlen) check in
skb_zerocopy() with a WARN_ON_ONCE() that returns -EFAULT. The commit
message describes the condition as a caller bug. It also says -EFAULT is
already documented for bad skb geometry.

> skb_zerocopy() BUG()s if @from has no head_frag and the caller passed
> hlen == 0, meaning the caller didn't ask for the head to be copied and
> the head can't be referenced as a page either.  The check runs before
> anything is touched, and skb_zerocopy() already documents -EFAULT for
> bad skb geometry.  Warn once and return that.

[Severity: Low]
Should this carry a Fixes: tag?

Userspace can reach the BUG() removed here through openvswitch.
OVS_PACKET_CMD_EXECUTE only needs GENL_UNS_ADMIN_PERM. A 14-byte Ethernet
frame with the actions POP_ETH and then USERSPACE ends up here:

ovs_packet_cmd_execute()
  __dev_alloc_skb(NET_IP_ALIGN + len, GFP_KERNEL)  /* head_frag == 0 */
  ...
  do_execute_actions()
    pop_eth()                    /* skb->len goes from 14 to 0 */
    output_userspace()
      ovs_dp_upcall()
        queue_userspace_packet()
          skb_zerocopy(user_skb, skb, 0, 0)
            BUG_ON(!from->head_frag && !hlen)

There are two likely candidates for the tag. One is the commit that added
the BUG_ON() to skb_zerocopy(). The other is the commit that made POP_ETH
followed by USERSPACE produce empty upcalls.

The first patch in this series, "net: skbuff: don't leave stale bytes in
skb_copy_and_csum_bits()", has a Fixes: tag.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e29eda2eaf3f6..8c6a45a20eb0f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3906,7 +3906,8 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
>  	struct page *page;
>  	unsigned int offset;
>  
> -	BUG_ON(!from->head_frag && !hlen);
> +	if (WARN_ON_ONCE(!from->head_frag && !hlen))
> +		return -EFAULT;

[Severity: Medium]
Can this WARN fire on a valid empty copy?

When len == 0 there is nothing to copy, so hlen == 0 is not a caller bug
in that case. The kernel-doc names skb_zerocopy_headlen() as the source
of @hlen, and it returns 0 for an empty skb without head_frag:

net/core/skbuff.c:skb_zerocopy_headlen() {
    ...
	if (!from->head_frag || ...) {
		hlen = skb_headlen(from);
		if (!hlen)
			hlen = from->len;
	}
    ...
}

The openvswitch path above hits this case. queue_userspace_packet()
computes skb_len = min(skb->len, cutlen), which is 0. hlen is also 0 on
both the OVS_DP_F_UNALIGNED path and the aligned path. The skb was
allocated with GFP_KERNEL, so head_frag is 0.

If the check came after the small payload fast path, this call would
simply return 0:

	if (len <= skb_tailroom(to))
		return skb_copy_bits(from, 0, skb_put(to, len), len);

Because the check comes first, userspace can trigger a WARN splat (or a
panic with panic_on_warn), and the empty upcall fails with -EFAULT.

Would adding len && to the condition, or moving the check below the fast
path, avoid this?

[Severity: Low]
Should the skb_zerocopy() kernel-doc be updated as well? Its return value
section lists only two causes of -EFAULT:

 *	-EFAULT: skb_copy_bits() found some problem with skb geometry, or readable head
 *      payload would be mixed with unreadable frags.

The new return happens before skb_copy_bits() is called and has nothing
to do with unreadable frags. The @hlen description ("size of linear
headroom in destination buffer") also doesn't say that hlen must be
non-zero when @from has no head_frag.

The commit message says skb_zerocopy() "already documents -EFAULT for
bad skb geometry". The doc only uses that wording for skb_copy_bits()
failures.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c%40toxicpanda.com
