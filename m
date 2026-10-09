Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780549A3C6;
	Fri,  9 Oct 2026 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533529; cv=none; b=bweKSCIZ4DVVThWf0RcdspCRu/Ggg2S7X1hJw21yoqMm9QdhmzYy3e42fA8eHb5Ad4V2RzzvY/u/hKgNHro37q0ZQuiS5fNfGzAJJH+3VCs9ud4paGMxynuggW57YQq2jOk2CZkkCwOUWQFygZrllCkpTgbRiI2To2c60WUm3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533529; c=relaxed/simple;
	bh=sKDkDY08xcNXoynlYNf07THCEVH7wCfiByZnL2eQ8ww=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TrR/1rO4QzRLT+Yzs7unYnnhCGopcKXARyDUUamDjyWyV21BhI5Aih/6Rkp/FWqsqPebfkS2a9Z3qIQcdFubwInqqjCBT7YxFPDwA5HW0+K+8kxvSmWzH1TM4MXnX4w4oYtHfBvJ6PhgS7kdzst0uUYOYGHyWnleelpu9pUDDqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr5Qwrrh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr5Qwrrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83221F00899;
	Fri,  9 Oct 2026 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791533523;
	bh=AOTzG9M5fbBh/wu8Wfez9o1gE6QAuTiGMKfFUTPz3J4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vr5QwrrheEGjGzX9D0/ZCV5Rc6+fZ/cC9oL6Snq5IoRNBHPeU1+5/OxJWlMsJr75y
	 uj3PDVNkFMxJOa4Mj3kH/R6Q/Hd+0JVjthKVTrVwJ7pYDx1zEuXeFET4vtIMcHB5af
	 Zy3hUFPXVxcs14qJPvPM1etzLkP4DNeL2rtZNiJY9gSw4xw5p6GDoEjzjx0y9jAqZl
	 WysNL8k0tMnbS/+ojZ203W60hHjUjFnahPbZ+fZCqdsL5OBhVmRFm1zL+CeF1n7EiC
	 Uq1hdOyDDAGHXEQQuur+HPYximR3VCXFDHlAwYv9tVEkNroAW/92E2+q+Mm1lg56rp
	 k9B1gNdtiAgSA==
Subject: Re: [PATCH net-next 6/9] net: skbuff: don't BUG() on a bad csum_start
 in skb_copy_and_csum_dev()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kaiyuanz@google.com,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 09 Oct 2026 08:12:02 +0000
Message-ID: <179153352239.434549.82855271082418093@kernel.org>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-6-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-6-1b4434c5357c@toxicpanda.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message gets wrong what used to stop a bad
  csum_offset in skb_copy_and_csum_dev() (net/core/skbuff.c).

--

net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()

This patch replaces the BUG_ON() on csum_start in skb_copy_and_csum_dev()
with a WARN_ON_ONCE(). The new check also catches a negative csum_start
and a csum_offset that would put the checksum field past skb->len. When
the check fires, the whole frame is copied with skb_copy_bits() and the
checksum is not filled in. If that copy also fails, the buffer is zeroed.

> It also trusts
> csum_offset when it stores the folded checksum.  So far
> skb_copy_and_csum_bits() BUG()ing on a short skb has covered for that,
> but once it returns instead, a bad csum_offset would write past the end
> of the caller's buffer.

[Severity: Medium]
Is this description accurate? skb_copy_and_csum_bits() never sees
csum_offset, so it isn't clear how its BUG_ON(len) could have covered for
it.

skb_copy_and_csum_dev() passes it a length that depends only on csstart
and skb->len:

	csum = skb_copy_and_csum_bits(skb, csstart, to + csstart,
				      skb->len - csstart);

The BUG_ON(len) at the end of skb_copy_and_csum_bits() fires only when the
head, frags and frag_list together hold less data than skb->len. If the
skb's lengths are consistent, it returns normally whatever csum_offset is.

The store after it had no bound before this patch:

	if (skb->ip_summed == CHECKSUM_PARTIAL) {
		long csstuff = csstart + skb->csum_offset;

		*((__sum16 *)(to + csstuff)) = csum_fold(csum);
	}

Without this patch, a CHECKSUM_PARTIAL skb with
csstart + csum_offset + 2 > skb->len would already write up to about 64KB
past the end of the driver's bounce buffer. The affected drivers are
8139too, sc92031, via-rhine, ksz884x, ep93xx and ec_bhf. Is that right?

A later patch in the series, "net: skbuff: don't BUG() on leftover length
in skb_copy_and_csum_bits()", does replace BUG_ON(len) with WARN_ON_ONCE()
plus a memset(). That doesn't change the point above.

If so, the new csum_offset condition fixes an out-of-bounds write that
already exists. It doesn't only guard against one that the later patch
would make possible. Could the commit message describe it that way, so
stable backporters can see it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c%40toxicpanda.com
