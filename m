Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1C3043C8;
	Wed, 15 Jul 2026 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154301; cv=none; b=BQMHPNRlymh54x2QhVQ9E+8vXUSBdScrBlsd9lkIJL8S88BLwt9R/WbaVsBX8ottJuaF5BpHSXKRXeFaY3BLL/PmjXT+KFcnbWR72VHZCUfg8SIfLC1ZjQBC80Zp9ejO1HadSkKTkmnzJfElkxEuNo8UJ94CXxGFym7niL7Vz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154301; c=relaxed/simple;
	bh=mslhgdUt2Ww20foGxEh4FU3Id5Y8x3oEvizlFZd2i5c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K9Bk6UYM9mfutVDs96lkOLGEJJhn2kgJIshuNtrMOl0u7TbpgoBb9F/5GA/yC4KAMy3C9NQpgSgGEbUNjIm1qpKO/YqR4WtAvhQ/xpnmFH0bwYtuRUCq5C78LJK6WgJMgCfUfR2yqKu7Ab68lTxjBPPfHa1fEMlGwXU3i8rdm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqgWX7BX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqgWX7BX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAE31F000E9;
	Wed, 15 Jul 2026 22:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784154299;
	bh=K68CSxTCGAzi7nRLVNdLS1+FYuDfWJYdurucXyw0L8E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DqgWX7BX4lPLnk3/5P4HRDPA6l6kqseUgXn6bX2/GO5ELsXAl4U6AfeG/rucAGeow
	 F7umQJs5FgmDgACEU1t60gedLSKlDVQZgEK6cNuLXQOzUDQeT5kgu/mmfp3hIpGZHF
	 jlT0VeybqnVLvzGV9LfMNa/bNqoTbxM390yT5KzcsziYQr4NuMxaW6kRBenUt3g3Gw
	 DrQ2Zn62D4AftaH4dOL6Kb/oB6YvZFnXRJpMr7Yygw5KiSWD8VA7LYoMRrWToMYOWp
	 9jQUvTJH9aYQgWfZQbzXpug16PENWyvtXDJC91AtiqbJJhWVAQ+OTTTAf/yZC5Wkod
	 Y4LcHIvrBRecg==
Content-Type: multipart/mixed; boundary="===============0392436415614422320=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53cafe8dbb89d70b7aa626bd4819f513026da6764d8e00e0346ef6e2225a60b5@mail.kernel.org>
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org>
Subject: Re: [PATCH bpf-next v5 1/8] netlink: specs: add XDP RX checksum capability to XDP metadata specs
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com,corbet@lwn.net,skhan@linuxfoundation.org,memxor@gmail.com,emil@etsalapatis.com
Cc: deliran@verdict.gg,jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,linux-doc@vger.kernel.org,aleksandr.loktionov@intel.com,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Jul 2026 22:24:59 +0000 (UTC)

--===============0392436415614422320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba..9bcaa423ad17 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -961,6 +961,38 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  	return -EOPNOTSUPP;
>  }
>
> +/**
> + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> + * @ctx: XDP context pointer.
> + * @ip_summed: Return value pointer to a bitmask indicating available checksums.
> + * @cksum: Return value pointer indicating the hw checksum value.
> + * @cksum_level: Return value pointer indicating the checksum level result.
> + *
> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> + * values are:
> + * ``XDP_CHECKSUM_NONE``
> + * ``XDP_CHECKSUM_UNNECESSARY``
> + * ``XDP_CHECKSUM_COMPLETE``
> + * ``XDP_CHECKSUM_COMPLETE`` | ``XDP_CHECKSUM_UNNECESSARY``
> + *
> + * In case of success, ``cksum`` contains the checksum value calculated by the
> + * NIC. ``cksum`` is valid only if ``XDP_CHECKSUM_COMPLETE`` is set in
> + * ``ip_summed``. ``cksum_level`` contains the checksum level reported by the
> + * hw. ``cksum_level`` can be considered valid only if
> + * ``XDP_CHECKSUM_UNNECESSARY`` is set in ``ip_summed``.

Earlier review of this series raised the case where the NIC reports
COMPLETE or UNNECESSARY, the XDP program then modifies the packet and
returns XDP_PASS.  In that situation the reported checksum is stale.

It was noted on the list that drivers today do not invalidate the
checksum in this case, they only stop reporting COMPLETE while an XDP
program is attached.

Would it help to document that expected driver behavior here (how it
works today versus what is expected), and possibly add a kselftest that
checks it?  If this is handled in a later patch of the series, please
disregard.

> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
> + * * ``-ENODATA``    : means no RX-checksum available for this frame
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
> +					     enum xdp_checksum *ip_summed,
> +					     u32 *cksum, u8 *cksum_level)
> +{
> +	return -EOPNOTSUPP;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29453967825
--===============0392436415614422320==--
