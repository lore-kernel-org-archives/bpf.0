Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95300209F43;
	Tue, 10 Feb 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746098; cv=none; b=TrhbLHVMGWKQXvmGAciAZVrpsNexmiAS7miH2IOKpvn157VPqxS2R8851zux8Bazg0zclIRR4eMjlYTFANjQ2Rz3M+ETn683HwRMWztKrgkdIhSpcBKDp34l+9DcwM02FU1iqLkMrfZ65Rqx4bF+o+k/BO2/lnGUbyINVdDVc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746098; c=relaxed/simple;
	bh=bXbCzhilE2J1SjH3AHgYT2z07lxejMikTfvqH+y+qsc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DHZXLnIbSk6xTyERGlK6tKY1tEwfZrB+gEE3pWeMEG72gHcz089a5YS6ngqlFp++6mX5rU5SJIbrmujJDb7VjCFAO8u9YinYl88yfjXBkMeV40aQ6D7L1qWMQxeYM9eIhkeT6do8uEWRbwuRvewAI4sTdsHI3pwomRMhsfNmX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jki4NPnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jki4NPnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AFAC116C6;
	Tue, 10 Feb 2026 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770746098;
	bh=bXbCzhilE2J1SjH3AHgYT2z07lxejMikTfvqH+y+qsc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jki4NPnZhrV89b2prpfvMmoM6uGwcVy6PdQWTQnHuSN1f432jef3qLeFkLhYSTBnI
	 jjF7ppW7Odwvx3ln0iORuiw0rYe1ebei7PNeWhadvHWqoQ3rI/wY6U8h9eOg3TSlL5
	 3KyO3SFDcnHtRuswDPxwBJPFkJGA4+KfDmdF5l9CeN+/Ys0GtdwF+Cx6eJU101aOgb
	 OTKA9vPRpFWTHQs9RYTWvGqhpb17VOigGhZ4apso0Q7tbwnr9ruJ3qA6A4R7F+5kTf
	 t33TipPx9J1JoasEN0Cha7pvzBzK2i/d9fxvl7UjlWtB9qaxADFOTDriLZSj4cMOfD
	 8m63hJkKTVlrA==
Content-Type: multipart/mixed; boundary="===============5180779401008178218=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <47acb6cc57c54a7f63de587c66306f0cc006907afe0601049f63e22af812d175@mail.kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-2-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-2-e5d55caa0541@kernel.org>
Subject: Re: [PATCH bpf-next 2/5] net: veth: Add xmo_rx_checksum callback to veth driver
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 17:54:57 +0000 (UTC)

--===============5180779401008178218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1693,6 +1693,25 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
>  	return err;
>  }
>
> +static int veth_xdp_rx_checksum(const struct xdp_md *ctx,
> +				enum xdp_checksum *ip_summed,
> +				u32 *cksum_meta)
> +{
> +	const struct veth_xdp_buff *_ctx = (void *)ctx;
> +	const struct sk_buff *skb = _ctx->skb;
> +
> +	if (!skb)
> +		return -ENODATA;
> +
> +	/* For locally generated packets ip_summed is set to
> +	 * CHECKSUM_PARTIAL.
> +	 */
> +	*ip_summed = skb->ip_summed;
> +	*cksum_meta = 0;

Should cksum_meta return different values based on ip_summed?

The API documentation in net/core/xdp.c states that cksum_meta should contain:
- the hw computed checksum value for XDP_CHECKSUM_COMPLETE
- the csum_level for XDP_CHECKSUM_UNNECESSARY
- 0 for XDP_CHECKSUM_NONE and XDP_CHECKSUM_PARTIAL

The ice driver implementation in this same series handles these cases:

    switch (ip_summed) {
    case XDP_CHECKSUM_COMPLETE:
        *cksum_meta = csum_unfold(...);  /* hw computed checksum */
        break;
    case XDP_CHECKSUM_UNNECESSARY:
        if (tunnel)
            *cksum_meta = 1;  /* csum_level */
        break;
    default:
        *cksum_meta = 0;
        break;
    }

While veth typically handles locally generated packets (CHECKSUM_PARTIAL) or
packets with CHECKSUM_NONE, packets forwarded from other interfaces could have
CHECKSUM_COMPLETE or CHECKSUM_UNNECESSARY with csum_level > 0.

Would something like the following be more consistent with the API:

    switch (skb->ip_summed) {
    case CHECKSUM_COMPLETE:
        *cksum_meta = skb->csum;
        break;
    case CHECKSUM_UNNECESSARY:
        *cksum_meta = skb->csum_level;
        break;
    default:
        *cksum_meta = 0;
        break;
    }

> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21875603263

AI-authorship-score: low
AI-authorship-explanation: The commit follows established kernel patterns, has a concise commit message, and is authored by a known kernel contributor with extensive networking experience.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: API inconsistency where cksum_meta always returns 0 instead of returning skb->csum for CHECKSUM_COMPLETE or skb->csum_level for CHECKSUM_UNNECESSARY as documented.

--===============5180779401008178218==--
