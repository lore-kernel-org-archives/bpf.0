Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A902C15BB
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054161; cv=none; b=LXXn1v/6c00RHcCi9nNIxBCCghfZWfIdH8FYAkow4SIZ0L8Z0G3OPSF9hZxeLgWqwB03LO/jiNn9gWJV+MZloylGAEbiwBMwqDcp6jBjzrwWLIOjEY/JtPZ4KBALo1bJxzm9jbAIQxZ+mmok2qBruaXzCeG+K1HjWl9NaCfOPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054161; c=relaxed/simple;
	bh=s0hZQDN02oJEE5b/BIEpY55ZpEubIdlEu4vdzUb9JGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kPL2d0fDYNtNZrUSsJoEBKJ0uW4TPZ+HZcAWKLKCX2dnpy5GGdxV3p4gCC4kNwpq/ho34/G9TkDY9aYWtqKey/W7ivKZww6elkgZLwJ9XYSp0RNRg4Ftge/xIGjjdvavJ7LVT4ownJYJNtcIE0Soa/drHXFKur4RVSgltqCemmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv5pMW3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv5pMW3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15771F0089C;
	Sat,  3 Oct 2026 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791054160;
	bh=b5kjYcoPmpzi/BmeIyMOcLbGbqjFknDOIZmo7ir9kS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jv5pMW3Meocif7kywB87NToj2SJMPLMmpwcyGPUou1riiL6U8DZlZOfwn9QGsvNsj
	 3rQ11Sg+7RXtLPqh+mBm3NZhi5fzqu51zOV7GGo/5Dk/AkYHkNVQywM9CZu2URQarE
	 Rp985ZzKeIe+nwiZBpX8ChB4rhxI8MbBa7gAxuGzuGN4Q5HDBqXw/Ghqo8SPacqgnA
	 SmwIzGsQcUGwIgMj61j1bu7kuR/4LMhE5+Q/KIRbkdDd+yRt/2QTQsaT593/Icbcao
	 QJsV1YdKa3YDBIG+xd6xeL3rvE5d9aZTTgfFZvIIBF2PJc+6ePiIQA+DAFSRooLm8V
	 BBPyLR/v4m2fw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC net-next 11/15] xdp: Copy provider buffers on pass and
 redirect
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002190018.696925-12-bjorn@kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-12-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 19:02:38 +0000
Message-Id: <20261003190239.B15771F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: xdp: payload truncation in xdp_build_skb_from_zc() when metad=
ata unsupported
--

commit a36f92358b032a7e20669d832f27102e55f9f4eb
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

xdp: Copy provider buffers on pass and redirect

This commit introduces logic to copy provider buffers into kernel pages
on pass and redirects, handling fragments appropriately. It splits the
copy from the release for redirects, maintaining the classic zero-copy
path while resolving frag addresses through xdp_frag_address().

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 386240bd24c98..b7f16f44dac22 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
[ ... ]
> @@ -638,6 +718,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct =
xdp_buff *xdp)
>  	u32 nr_frags =3D 0;
>  	int metalen;
> =20
> +	if (xdp_buff_has_netmem(xdp))
> +		return xdp_build_skb_from_zc(xdp);
> +
>  	if (unlikely(xdp_buff_has_frags(xdp))) {

[Severity: High]
Does generalizing xdp_build_skb_from_zc() to handle all netmem buffers cause
a payload truncation when metadata is unsupported?

Previously, xdp_build_skb_from_zc() only handled pure XSK buffers, where
data_meta =3D=3D data is guaranteed. Now, it can receive generic provider-b=
acked
netmem buffers.

If a netmem provider driver does not support metadata and initializes the
buffer via xdp_prepare_buff() with false, xdp->data_meta is set to
xdp->data + 1.

Looking at the length calculation and copy in xdp_build_skb_from_zc():

struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
{
        u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
        ...
        u32 len =3D xdp->data_end - xdp->data_meta;
        ...
        memcpy(__skb_put(skb, len), xdp->data_meta, len);
}

Without checking xdp_data_meta_unsupported(xdp), it blindly uses
xdp->data_meta to determine the length and as the source for memcpy().

Could this cause the first byte of every packet to be truncated and the
payload to be shifted by one byte, leading to silent data corruption on
XDP_PASS?

Should xdp_build_skb_from_zc() check xdp_data_meta_unsupported(xdp) similar
to how xdp_copy_zc_to_xdp_frame() handles it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002190018.6969=
25-1-bjorn@kernel.org?part=3D11
