Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0F55C1D5
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088526; cv=none; b=rIkzGlm3zEfJJgESF0ouqPUqFIjW8TBnvgMhtK5ZEEETCj15MwRi+VN/m5F5nyon1fQ6zrm26fJ3JOxSdkUydzcMP/hw9Vu3kmfZ8CbASkv87NW50xoEUBuAC0KwUk9GOmlxuQf6M6LwH3xMf3+37QFTUZxkSoNMR08Gd8spcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088526; c=relaxed/simple;
	bh=wfWzdvYmU6Y8Q5OOPzVioUI3bRS1vkVct+gSN3XnDy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gZDn53Grae/jBtKtT0wyiYzAu1K9N5rLn1pzXVzAhKYRDjVwEmkjKxZ+8Dy0oMtdNw7bSeqVwFLNQg++PERpCCEZ7cjE+EGv2TffQkwpDto3Da3n0AHJHlWMWUNr5ZimdwxAoI9msrjXXGRhzbsf2cW8KNkMP84AJ9gJhNhtcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLAFvO1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLAFvO1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10D51F00898;
	Tue, 22 Sep 2026 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088524;
	bh=M9BJk0zIT+xjtCtkDu65wyTYkIaokt6pkluz3wjhObY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jLAFvO1FZB0ltNE0OkJ/pbg4CcKylJBqpUyvekFXRGGFkR0wk5kX+ZnLsOR+u861/
	 rutAfxNPRAGdWripbuWR2vOx5gXFkk4wA/PGwauQ5p6qMHU4FlfbGV3FPHjH9gKPa5
	 tthTcCBZzRLIvTrprUA6Unvkv2H6vJZjHNSHjNErPvXVpl3xj6CcMfLRi1nJrS8UMz
	 dXwy8iimllyBjxkyWAHNXlQRRCGbDVhquiJsle1SUu1IsGlIM6awT9XzjZM4GhryvJ
	 B95NFE4eMkmw22bqTJCrK4SeQCDuldA9Zo/5Lv8apHeYbYMIofvmfpvocKzQY8n0Wi
	 MdNJ+DmqRNxqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net: stmmac: fix rx Scatter-Gather support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921-stmmac-rx-sg-fix-v2-1-b6d88c5ac2d7@oss.qualcomm.com>
References: <20260921-stmmac-rx-sg-fix-v2-1-b6d88c5ac2d7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:48:44 +0000
Message-Id: <20260922144844.B10D51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] stmmac: FCS stripping check corrupts payload on legacy cores
- [High] net: stmmac: skb_trim() on non-linear SKB triggers WARN_ON and fai=
ls
--

commit a400f52631710a5add56c0a39b6ab0128eae6a53
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: fix rx Scatter-Gather support

This commit addresses SMMU translation faults on oversized incoming frames =
by
allocating and enabling a secondary RX buffer (buffer2) for non-SPH
scatter-gather frames on supported cores. Legacy cores keep buffer2 disable=
d,
and the FCS stripping logic is adjusted to handle both linear and assembled
frames correctly.

Link: https://lore.kernel.org/r/20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f=
@oss.qualcomm.com

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5807,24 +5812,31 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
>  		len +=3D buf2_len;
> =20
>  		/* ACS is disabled; strip manually. */
> -		if (likely(!(status & rx_not_ls))) {
> -			if (buf2_len) {
> -				buf2_len -=3D ETH_FCS_LEN;
> -				len -=3D ETH_FCS_LEN;
> -			} else if (buf1_len) {
> -				buf1_len -=3D ETH_FCS_LEN;
> -				len -=3D ETH_FCS_LEN;
> -			}
> -		}
> +		if (likely(!(status & rx_not_ls)))
> +			len -=3D ETH_FCS_LEN;
> =20
>  		if (!skb) {
>  			unsigned int pre_len, sync_len;
> =20
> +			/* Each frame starts here: reset the FCS handling */
> +			fcs_stripped =3D false;
> +
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
>  						buf1_len, dma_dir);
>  			net_prefetch(page_address(buf->page) +
>  				     buf->page_offset);
> =20
> +			/* The XDP program must not see the FCS. This only
> +			 * applies to a single-buffer frame (buf2_len =3D=3D 0),
> +			 * where the whole frame and its FCS sit in buffer1;
> +			 * otherwise the FCS is stripped from the assembled
> +			 * frame with skb_trim().
> +			 */
> +			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
> +				buf1_len -=3D ETH_FCS_LEN;
> +				fcs_stripped =3D true;
> +			}

[Severity: High]
Does this logic incorrectly strip the payload on legacy cores for
scatter-gather frames?

On legacy hardware without set_sec_addr support, stmmac_rx_check_buf2_cap()
returns false, meaning buf2_len is always 0. When a multi-descriptor (jumbo)
frame arrives on a legacy core with XDP enabled, the first descriptor enters
this if (!skb) block. Since buf2_len is 0, this check evaluates to true,
improperly subtracting ETH_FCS_LEN (4 bytes) from buf1_len and truncating t=
he
payload. It also sets fcs_stripped =3D true, which means the actual FCS at =
the
end of the frame won't be trimmed later, leaving a corrupted frame.

[Severity: Critical]
This is a pre-existing issue, but can this underflow buf1_len and cause an
out-of-bounds access in the BPF program?

If a multi-descriptor frame is received and the XDP program drops the first
fragment, the driver frees the buffer, sets skb =3D NULL, and loops to read
the next descriptor via goto read_again. On the final descriptor,
stmmac_rx_buf2_len() returns 0. Since skb is NULL, the code re-enters this
if (!skb) block.

This check evaluates to true, executing buf1_len -=3D ETH_FCS_LEN. If the f=
inal
fragment only contains 1 to 3 bytes of data, this unsigned subtraction
underflows to a massive integer. This corrupted length is then passed to
xdp_prepare_buff(), setting a huge data_end and allowing the BPF program to
read and write out of bounds.

[ ... ]

> @@ -5924,6 +5936,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int=
 limit, u32 queue)
> =20
>  		/* Got entire packet into SKB. Finish it. */
> =20
> +		/* Remove FCS if needed */
> +		if (!fcs_stripped)
> +			skb_trim(skb, len);
> +

[Severity: High]
Can this trigger a WARN_ON and fail to strip the FCS for scatter-gather
frames?

For multi-buffer frames, data is appended using skb_add_rx_frag(), which
creates a non-linear SKB (skb->data_len > 0). However, skb_trim() requires a
linear SKB. Calling it on a non-linear SKB evaluates
WARN_ON(skb_is_nonlinear(skb)) and returns immediately without modifying the
SKB, leaving the FCS attached.

Should this use pskb_trim(skb, len) instead to correctly handle paged SKBs?

>  		stmmac_get_rx_hwtstamp(priv, p, np, skb);
> =20
>  		if (priv->hw->hw_vlan_en)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-stmmac-rx-=
sg-fix-v2-1-b6d88c5ac2d7@oss.qualcomm.com?part=3D1
