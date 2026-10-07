Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD34CA29D
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393073; cv=none; b=A8xwDtjEjD74VIi4bwThRUqL5MJUMSwo5eNEVL9FM+C3nScqfdwHuav5RhRmwCcmebNLJ8qUxx3+4qQIMTTj94+RZh7Aq6Elq9qQMsgeTm/H299nUHRhNyWeUj2Cxcce8uswTxjDtuxeA68C0VOVyrULSotmTRR3sB40q0HkKj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393073; c=relaxed/simple;
	bh=MjVQ3N8eL1+4wSPyVvXS5nyD3bCtqVu3AHwFiabDidE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NehUZceV+uGpKfIUJq5Kx5H8Miqghg2OG9PNcitddoIZWs/TMwhungk7A8fIexStX7w1y1c9/froNsCIG9VKxUCsgal2e8kv0NkXcaoZ76kSxHx++8P7q7uxYThTdVIshUEUT4UYDm9feWyZ/1PNc8RZNuUsdKQZmmQUp5e7R5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/oGPW0u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/oGPW0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEFC1F00893;
	Wed,  7 Oct 2026 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791393072;
	bh=jsrvq50hqttlIAR8w7TwrOL44W4OPq0NpzrSVP2J9bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R/oGPW0uvqbAc541tKXlofnhFnj2oURhqtVyQU87oE7hrU/d0GYQnSkD6ufu4/4C3
	 FaftaFfH3tM3McHC0QE6tVsDZrLagepU/rUN1EAUb6XIhgP4nnLtVygoLcI+tETsFF
	 jOlg+l9dqp72LbTLAYrSSJzYY+xB+IUvYMCIlUkGtTJizGkIX5Q8vQMUypGaHqNM7E
	 OA+N42+j+HFPhiSb6z2WteUMslqtFo2AlRdapFKiX8REoyLS0/Noam0G9UtvR090yi
	 UuNL/zwl7RqO/jmXAOk7L/DV8a2BChksf5lnM74HvmRIgYKai4TG4rFpqZFrn2tNGu
	 PbNVSOjbUWm4A==
Message-ID: <sashiko-outbox-163222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 7/9] net: skbuff: don't BUG() on leftover
 length in skb_copy_and_csum_bits()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-7-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
 <20261006-b4-skbuff-bug-on-v1-7-1b4434c5357c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 17:11:11 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: incomplete defense against negative len in skb_copy_and_csum_=
bits
--

commit a487a003d242af9e08ff639f329ea71c902adabb
Author: Josef Bacik <josef@toxicpanda.com>

net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()

This commit replaces a BUG_ON(len) with a WARN_ON_ONCE(len) at the end of
skb_copy_and_csum_bits(). It also clears any remaining space in the destina=
tion
buffer if len is positive, preventing stale bytes from being sent.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c8c2c0319b87a..e29eda2eaf3f6 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3709,7 +3709,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff=
 *skb, int offset,
>  		}
>  		start =3D end;
>  	}
> -	BUG_ON(len);
> +	if (WARN_ON_ONCE(len)) {
> +		/* Don't hand the caller a buffer with stale bytes in it. */
> +		if (len > 0)
> +			memset(to, 0, len);
> +		return 0;
> +	}

[Severity: High]
The commit message states that "a negative @len from a broken caller must n=
ot
turn into a huge memset()". If a broken caller passes a negative len, will =
we
actually reach this check, or will it cause memory corruption earlier in the
function?

Earlier in skb_copy_and_csum_bits(), if offset is smaller than
skb_headlen(skb), copy starts as positive. If a broken caller passes a
negative len, copy > len evaluates to true, forcing copy =3D len:

	if (copy > 0) {
		if (copy > len)
			copy =3D len;
		csum =3D csum_partial_copy_nocheck(skb->data + offset, to,
						 copy);

Could this pass the negative copy to csum_partial_copy_nocheck(), which
interprets it as a huge unsigned size and causes a massive out-of-bounds
read and write before ever reaching the new guard?

>  	return csum;
>  }
>  EXPORT_SYMBOL(skb_copy_and_csum_bits);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-skbuff-=
bug-on-v1-0-1b4434c5357c@toxicpanda.com?part=3D7
