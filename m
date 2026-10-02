Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018836B927
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947697; cv=none; b=rKwhl7bUCVWZ6BOLizy805fD1F1Imvl3+TALkUBiUQ7ZBBfqo19dpEZVSOxWru979eWg+ZlO4vDPAR9KrDL9WhqQ4xp2Em7biO4BbDmv73kjIAe4NRZdvCzUCt3YZfevOcN8BYyr/OSSD7Azshwq+Mza1uYrbD88jjFq1YgaYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947697; c=relaxed/simple;
	bh=+e1d/VTnIn4uESy6IXkPX7Rgy4itecHxh5ZSLryKcc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QedBaFz+pMDoR8AHAPtEpg9Muzg6S3QCMZHvbydYuBmUBXW/unmZhBUCAPBh5XVCWzbHOqkT0Phk0iEB9a4046t9YLsketSbpxZL/HChc/PmxaeyBEIMt3R96yTE7l81AOjs3+kCQmq2q6+LigzYH0DeI5Dg/QwUxHKK7zrIK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4L/ke2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4L/ke2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A771F000FF;
	Fri,  2 Oct 2026 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790947696;
	bh=lMZIdpOmHFk15d8aqFi3eoOlRYxwx0M+jcvhN7YnOJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4L/ke2kWQIngCj6a5MIGTBgY3yBKVBMdA2bJeDMEPFnQnovHP03+n0djTL7k3Fu6
	 tZlZq7KQCOQoaJhY3jGqI6afKKykHueJxoe4FGZMaupAlVBowMESzbCUpHhX0CSODG
	 ItyH0lVOfn7134raTd+BYNFOHZ9uggce8qgFXbq1XmPgyWMPWp8pPrvHDJzFv6m+mR
	 ngSGG2HQuxwnjBtYYVspWBGNPHqXkUqjvfaYKHo9qQiHXKV2DsyIP2S8FGYAblL2ei
	 25cxwSckd//lEgZSkCf24x0sbQmqsFEuApEm7c5FS+XR5HrVscwOKx0p2lKJeGNvhs
	 yyyOMVN+bcvoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Oros" <poros@redhat.com>
Cc: bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261002130752.2597259-10-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-10-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 13:28:15 +0000
Message-Id: <20261002132815.D3A771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ice: Use-After-Free in ice_setup_mc_magic_wake() during concurrent=
 devlink reload
--

commit 6cf8b519dd4de7f3996192dbff4ffe7afc4d34f8
Author: Petr Oros <poros@redhat.com>

ice: program multicast magic wake before tearing down the main VSI

This commit moves the ice_setup_mc_magic_wake() call earlier in ice_remove()
before device structures are torn down. It fixes an issue where WoL magic
packet wake was not set up correctly because it was being called after
ice_deinit().

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index b121faa345c1a..857ba7d92b140 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5465,6 +5465,8 @@ static void ice_remove(struct pci_dev *pdev)
>  	if (!ice_is_safe_mode(pf))
>  		ice_remove_arfs(pf);
> =20
> +	ice_setup_mc_magic_wake(pf);
> +
>  	devl_lock(priv_to_devlink(pf));

[Severity: High]
By moving ice_setup_mc_magic_wake() outside of devl_lock(), is it exposed to
concurrent devlink operations like reload?

If a devlink reload operation executes concurrently with the driver's remov=
al
routine when Wake-on-LAN is enabled, the reload can call ice_unload() and
ice_decfg_netdev(). This unregisters and frees the netdev.

When ice_setup_mc_magic_wake() runs unprotected by the devlink lock, can it
experience a use-after-free when attempting to read the freed netdev's MAC
address?

drivers/net/ethernet/intel/ice/ice_main.c:ice_setup_mc_magic_wake() {
    ...
	if (vsi->netdev)
		ether_addr_copy(mac_addr, vsi->netdev->dev_addr);
    ...
}

Would it be safer to place the ice_setup_mc_magic_wake() call after acquiri=
ng
the devlink lock?

>  	ice_dealloc_all_dynamic_ports(pf);
>  	ice_deinit_devlink(pf);
> @@ -5475,7 +5477,6 @@ static void ice_remove(struct pci_dev *pdev)
>  	ice_deinit(pf);
>  	ice_vsi_release_all(pf);
> =20
> -	ice_setup_mc_magic_wake(pf);
>  	ice_set_wake(pf);
> =20
>  	ice_adapter_put(pdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002130752.2597=
259-1-poros@redhat.com?part=3D9
