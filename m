Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D353B8105
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838569; cv=none; b=Gt77O5aD7naf/4Xq6etQEh1x0Du8YOgsy0mS+c7CUPBiBXf963S3x+QEyUk7GwVUqxAfOV4TC5y6u/2l1OMAdHT44g/TyMbCSy4qjfr+6IJtuKCyNN5lefnphax7jau1xj6BM4qeL92kOZYDvI8t1Y1MvUl8vVIpmvtJ798hjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838569; c=relaxed/simple;
	bh=bQCQXtI5gchlr1B/STLAaZrWjysoaBL5mGwl2FwchiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hBBaM/vzMQWauR78EXkn0KE2QEk+e55EOP3VJrXKr41D6TviaTAi0FAkjVbaCMxPQiSGOAdEloA1EWKB7P0+dVbKMri/CYS5aJ17wRw5MBUwg7bBjpKXtiIB1zLvs1Ms1Vket8Tjill7dNx3Dll6uQFpsUXN+cDVIGxgJSsl3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HomwVeFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HomwVeFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF93A1F000FF;
	Thu,  1 Oct 2026 07:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790838568;
	bh=wkXEmU8Vn+3P8Nr2FtOr5M+9aommtud78bpCJ5Ll020=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HomwVeFsRKRSO8XN2CxEImZZXlSBu7f7nVFRpQZkGV2/NvDwYrqcxryILPxlutmpm
	 vEQtNZk90A//pV5Yaoz0AhrfpLnv9wOw4ME7jaaHc5NISuS33bMR9EpvQkYfSfFttr
	 IQWjIzggAOSXVSh0vld8t/HZHDiEfSUCVGqf418bhi6cZ4Igy42uXprr0Hf5DdZje1
	 HSARcYXohdPyoGhHXOkkwLR7b8wE4QKc05sgDM8wb1xU8D/g+59zAz5bq0P9YnqWMh
	 L2ryGd4UAVV5hda6mmMLk3kEAqxpqe0afcQHZYKbzeaNp/FipIiT3gmmTyD+mSRAc3
	 TfhibJ9owylYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] bnxt_en: don't leave an XDP program installed
 when the open fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vaibhav Nagare" <vnagare@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930070901.1218980-1-vnagare@redhat.com>
References: <20260930070901.1218980-1-vnagare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 07:09:27 +0000
Message-Id: <20261001070927.EF93A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bnxt_en XDP detach memory leak and state desynchronization on=
 NIC open failure
--

commit a5efe83c5d84fe92f5143236d2e982d0ce3eaec4
Author: Vaibhav Nagare <vnagare@redhat.com>

bnxt_en: don't leave an XDP program installed when the open fails

This commit restores the previous XDP program and ring configuration when
bnxt_open_nic() fails. This prevents the driver from leaving a freed program
in bp->xdp_prog on a failed XDP update.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_xdp.c
> index 9e5009be8e989..edfd751a601ab 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
[ ... ]
> @@ -418,25 +438,21 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf=
_prog *prog)
>  	if (netif_running(dev))
>  		bnxt_close_nic(bp, true, false);
> =20
> +	old_tx_xdp =3D bp->tx_nr_rings_xdp;
>  	old =3D xchg(&bp->xdp_prog, prog);
> +	bnxt_xdp_apply_cfg(bp, tx_xdp);
> +
> +	if (netif_running(dev)) {
> +		rc =3D bnxt_open_nic(bp, true, false);
> +		if (rc) {
> +			WRITE_ONCE(bp->xdp_prog, old);
> +			bnxt_xdp_apply_cfg(bp, old_tx_xdp);
> +			return rc;

[Severity: High]
Does this error path introduce a memory leak and state desynchronization if
the user was trying to detach the XDP program?

If bnxt_open_nic() fails during a detach operation where prog is NULL, the
core stack's dev_xdp_detach_link() ignores the error returned by the driver
and forcefully unlinks the program anyway:

net/core/dev.c:dev_xdp_detach_link() {
    ...
    WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
    dev_xdp_set_link(dev, mode, NULL);
    ...
}

Because this error path restores old to bp->xdp_prog and returns early
without calling bpf_prog_put(old), does the driver maintain a leaked
reference to the BPF program?=20

Would this cause the driver to continue executing a 'detached' XDP program
when the NIC is brought up later, while the core stack considers it fully
detached?

> +		}
>  	}
> =20
> -	if (old)
> -		bpf_prog_put(old);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930070901.1218=
980-1-vnagare@redhat.com?part=3D1
