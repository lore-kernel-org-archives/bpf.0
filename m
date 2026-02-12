Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C9CBA21;
	Thu, 12 Feb 2026 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924663; cv=none; b=JqsodY5isXaBJ6KjOBZynyJRF+A94T+PoEpnOYh8yICsZHy2znilxh7v+5y91Fg/2yBUI5YsLGYpRFy6vm1OiPwArGND3zNlWjMDG0MqdLqC/98KAcG5vRDR1phgMPa4vK3oHrz6Hy+NhJ/pJxdvmny58Fi0w3lGWzQZj0kcpI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924663; c=relaxed/simple;
	bh=CfyMoN19AB34Wz5ReWi6alLjCIlR82xPRObwiwQjs/0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pUHHyZlrLKScOX7OP8S1DKWtXcHcR77d/QqH1SSOQOQcSRaJS3j2cXR5Jf2cglmdmM5fqyBBe7vOUxMSdEgszWj/kWuRcQe9KHbe1MqfSchVRsjr/4y0s4EZE3PVCze/iqDGZhpcAgFp3KjUKKhDXfW5N+qZ2mLVhzk7KGMXcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAwqP0ZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAwqP0ZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32734C4CEF7;
	Thu, 12 Feb 2026 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770924662;
	bh=CfyMoN19AB34Wz5ReWi6alLjCIlR82xPRObwiwQjs/0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uAwqP0ZNhEW5Vagfetvw+PvGC8DYBv2pnSNHyd1ovIS88pn9ifnTiDPBYMEgDtfBi
	 156V17wRWRf5GaA0M4JDS5ELgZFPsToJluBFN1XLAGhKW8KgCeXz5gDB6+vnQ/qdzt
	 ErH1JSBmG1tJomT9882swyU1xVor44SJj2wBmtUfim4nUsRCLmHH2crP79+8i/KLrJ
	 RL96EddJ5mcRRkjR+VGWrMdsl2IvJvHtDwUCqRRaZyXq0yzheA5CtI69vZAFbKLgJb
	 Kx+0YVrKWQsw/ZPaeChxh75VEwtzllV+os7CJyqECsn8HZNcyzJPsZEB+oOKEDJZrK
	 ZKgv9CAsQkFjA==
Content-Type: multipart/mixed; boundary="===============3404291497187834089=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <105606c43804c23ec856f4ec17a08286f182061e547f954359e2e0325d0d3a6f@mail.kernel.org>
In-Reply-To: <20260212183328.1883148-5-larysa.zaremba@intel.com>
References: <20260212183328.1883148-5-larysa.zaremba@intel.com>
Subject: Re: [PATCH bpf v2 3/9] ice: fix rxq info registering in mbuf packets
From: bot+bpf-ci@kernel.org
To: larysa.zaremba@intel.com,bpf@vger.kernel.org
Cc: larysa.zaremba@intel.com,claudiu.manoil@nxp.com,vladimir.oltean@nxp.com,wei.fang@nxp.com,xiaoning.wang@nxp.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,horms@kernel.org,shuah@kernel.org,aleksander.lobakin@intel.com,maciej.fijalkowski@intel.com,bastien.curutchet@bootlin.com,tushar.vyavahare@intel.com,kernelxing@tencent.com,rbm@suse.com,echaudro@redhat.com,lorenzo@kernel.org,toke@redhat.com,imx@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,aleksandr.loktionov@intel.com,dtatulea@nvidia.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 12 Feb 2026 19:31:02 +0000 (UTC)

--===============3404291497187834089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index eadb1e3d12b3..511d803cf0a4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -663,23 +663,12 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  	int err;
>
>  	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {

[ ... ]

> @@ -702,14 +691,13 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  			if (err)
>  				return err;
>
> -			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
> -				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> -							 ring->q_index,
> -							 ring->q_vector->napi.napi_id,
> -							 ring->rx_buf_len);
> -				if (err)
> -					goto err_destroy_fq;
> -			}
> +			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> +						 ring->q_index,
> +						 ring->q_vector->napi.napi_id,
> +						 ring->rx_buf_len);
> +			if (err)
> +				goto err_destroy_fq;

The registration condition check was removed, so __xdp_rxq_info_reg() is
now called unconditionally. This works correctly when cleanup properly
unregisters the xdp_rxq, but there appears to be a gap for ICE_VSI_SF
in non-XSK mode.

Looking at ice_clean_rx_ring() in ice_txrx.c:

    if (rx_ring->vsi->type == ICE_VSI_PF &&
        xdp_rxq_info_is_reg(&rx_ring->xdp_rxq)) {
        xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
        xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
    }

This only unregisters for ICE_VSI_PF, not ICE_VSI_SF. With the old code,
the conditional registration skipped re-registration for ICE_VSI_SF. With
this change, for ICE_VSI_SF in non-XSK mode during reconfiguration:

1. ice_clean_rx_ring() - doesn't unregister (only checks ICE_VSI_PF)
2. ice_vsi_cfg_rxq() - unconditionally calls __xdp_rxq_info_reg()
3. __xdp_rxq_info_reg() sees REG_STATE_REGISTERED and triggers:

    WARN(1, "Missing unregister, handled but fix driver");

While this is handled gracefully by the XDP core (it unregisters internally
before re-registering), will this cause spurious WARN splats for subfunction
devices on every reconfiguration?

Should the ICE_VSI_PF check in ice_clean_rx_ring() be updated to also
include ICE_VSI_SF to match the registration path?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21960574055

AI-authorship-score: low
AI-authorship-explanation: The commit shows domain-specific knowledge of ice driver internals and XDP subsystem, with targeted changes that suggest human authorship by an Intel driver developer.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The issue causes WARN splats for ICE_VSI_SF devices during reconfiguration, but is handled gracefully by XDP core without functional impact.

--===============3404291497187834089==--
