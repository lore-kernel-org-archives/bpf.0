Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9564364045;
	Fri, 13 Feb 2026 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998406; cv=none; b=YCEyDCCXiVUS3iYtoHtiP5AKTF9egagSFswlCJitCwiAN9MoelEAicT4GLlTBN4aw77RbK7yG5kGQ2QTCmxTya9ySB8+JCbiW7TgkdyAFZbucfa/o0zaIbzbuH9IK9qM4Rt94fCckh08HsFgVQvXIr1DhW54AtoPgZOBkNxYDHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998406; c=relaxed/simple;
	bh=whQkudV1SP30aO8I7dV0xsnAsYatFTQhrUgJ+sjo/1M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b8GZsymV9rcf48PK6U3osEsE1KZ/3qLtYlKScZJ7x2bdD+aPe1xV0+QrqquxOSO2rN4wZuu+ZPFbJ9Yl2hIiKgQ76UymKbfXLm1foB6tnwROlNDZg9LZYG/CYd6TbNWv6Z/1xIPiltaHdKJmZuW1eSkN8RgCmVapLibtEdsAKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2SCLUiH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2SCLUiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0815FC116C6;
	Fri, 13 Feb 2026 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770998406;
	bh=whQkudV1SP30aO8I7dV0xsnAsYatFTQhrUgJ+sjo/1M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=H2SCLUiHDLnAwodQZXTH8btk+XcP2E1n18noDQLIIGgWut55lveURlQZJGiVLPSL9
	 e0hN3eLVSTFiBM1+oQXzxNulKEAVCnxVXh5BS5tvnevJflB8eLVwGVmGQ1KB749JUe
	 OdAduXL5cn0KoNBLfubk0/hkxcPYGOOghizOTD2CNPFSXcANeADG60LGVAGXMtALD5
	 5L29Ow1zd4EiT9db+1hQjg9VxM0i5RBFeMYIiSj3jpt6p3tzHSdpsyFIzRKKFsTW8b
	 fjlDWCpqqzewoJnnq3oM7LF4/zL4dK3HIVFEt+nQR7ZtnvH3xGQt/3X9EE+e4hu+KU
	 JGnHRirgi5wCg==
Content-Type: multipart/mixed; boundary="===============7943291750325700544=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73f7405c9054157df20cc9bb4babbea3e3727e2093ce508b01871557690cf24e@mail.kernel.org>
In-Reply-To: <20260213-bpf-xdp-meta-rxcksum-v2-2-a82c4802afbe@kernel.org>
References: <20260213-bpf-xdp-meta-rxcksum-v2-2-a82c4802afbe@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/5] net: veth: Add xmo_rx_checksum callback to veth driver
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,aleksandr.loktionov@intel.com,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Feb 2026 16:00:06 +0000 (UTC)

--===============7943291750325700544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 9982412fd7f2..3ec77599299a 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1697,6 +1697,35 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
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
> +	*ip_summed = skb->ip_summed;

Is this assignment needed? Every branch in the switch below overwrites
*ip_summed, so this line has no effect. It looks like a leftover from v1
where the raw skb->ip_summed was the intended output value.

> +	switch (skb->ip_summed) {
> +	case CHECKSUM_COMPLETE:
> +		*ip_summed = XDP_CHECKSUM_COMPLETE;
> +		*cksum_meta = skb->csum;
> +		break;
> +	case CHECKSUM_UNNECESSARY:
> +		*ip_summed = XDP_CHECKSUM_UNNECESSARY;
> +		*cksum_meta = skb->csum_level;
> +		break;
> +	default:
> +		*ip_summed = XDP_CHECKSUM_NONE;
> +		*cksum_meta = 0;
> +		break;
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21992879200

AI-authorship-score: low
AI-authorship-explanation: Multiple version iterations over months with incremental refinements, a non-native English typo, and a refactoring leftover are all characteristic of human development.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Dead code assignment from v1 refactoring leftover has no functional impact but is unnecessary.

--===============7943291750325700544==--
