Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40873432BED
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781961; cv=none; b=Xp1OF94ELW3aRF8y69v+NRcTbkjQ0QIqbAM9ttFoQDW2ukf8/LSHfxyDWHLuuzOXogR1N0OvSauByhDNHxPDeMk7nuBoUyE4Fdy7SWsI60Xk3WGaYyrZT8ozhMQNRny5EWGMBhsLjWcKsB7SgxISB9kNHFHq2GsS3mG0jdc2GJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781961; c=relaxed/simple;
	bh=EWK1ft8tWPRjtGtFH2NUV8Im/4vIjACQCzA7HtkG9uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNVcnqQOXooTUk44jXlojRy62r0+rh2vRZH9R2JwSnceEoNqrEx1eCQXP9bE5DEgDaSwzQA2eKCIzaZuhSFnt9atncyt6IbhHVHM9VcPXtu+9/5wZOSwPJ4IDUgqKlN8n70KbortOVs8msYu//soKvvIpYNOPT/cFh8Nd+Ugudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X2WwdSo/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X2WwdSo/"
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id C27F920B7167; Mon,  3 Aug 2026 11:32:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C27F920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785781938;
	bh=9sY9aD5AzAhd4hg3leeLKVh5l1Seb4OX/QLWZ0dagI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2WwdSo/mUNc1eTN9HlBFjkk4bSvzRs6kCnw7dGw0oqjnNWad57xZu8XUL17ergNj
	 JwGeKKFeC2TDWIifUEfE+CAuP+GIZVgjCQ7cAk3SDwSJJz1FeeId4p1mscGv0LRGAi
	 jtUXnQ6vzrmACEJnMbRGV38Xziy/21PlM4ztNqs8=
Date: Mon, 3 Aug 2026 11:32:18 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v13 2/2] net: mana: force full-page RX buffers
 via ethtool private flag
Message-ID: <anDesh1z2Z8cE8Ga@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260729063347.3388035-1-dipayanroy@linux.microsoft.com>
 <20260729063347.3388035-3-dipayanroy@linux.microsoft.com>
 <20260730063437.EF6391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730063437.EF6391F000E9@smtp.kernel.org>

On Thu, Jul 30, 2026 at 06:34:37AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Use-after-free of BPF program when mana_pre_alloc_rxbufs fails during XDP setup
> --
> 
> --- Patch [2]: [PATCH net-next v13 2/2] net: mana: force full-page RX buffers via ethtool private flag ---
> commit 2ea505589c71d255969461add82f06436f8f8e80
> Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> 
> net: mana: force full-page RX buffers via ethtool private flag
> 
> This commit adds an ethtool private flag to force one RX buffer per page,
> bypassing the page_pool fragment path. This is intended to restore
> line-rate throughput on certain ARM64 platforms with 4K PAGE_SIZE.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > index 482cd16009abb..7e441d6ae5dce 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> [ ... ]
> > @@ -756,6 +775,78 @@ static int mana_get_link_ksettings(struct net_device *ndev,
> [ ... ]
> > +static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> > +{
> [ ... ]
> > +	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
> [ ... ]
> > +		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> > +		if (err) {
> > +			netdev_err(ndev,
> > +				   "Insufficient memory for new allocations\n");
> > +			apc->priv_flags = old_priv_flags;
> > +			goto clear_flag;
> > +		}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the callers
> of mana_pre_alloc_rxbufs(), does a failure during XDP setup leave a dangling
> pointer?
> 
> In drivers/net/ethernet/microsoft/mana/mana_bpf.c:mana_xdp_set(),
> apc->bpf_prog is updated before the allocation:
> 
>         apc->bpf_prog = prog;
> 
> If the allocation fails, the function returns early without cleaning up:
> 
>         err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
>         if (err) {
>                 NL_SET_ERR_MSG_MOD(extack,
>                                    "XDP: Insufficient memory ...");
>                 return err;
>         }
> 
> The core network stack handles the error by releasing its reference to the
> new BPF program, which may then be freed. Because the early return skips
> the err_dealloc_rxbuffs label, apc->bpf_prog is never reverted to old_prog.
> Could a subsequent interface flap execute mana_attach() and assign this
> freed BPF program to the hardware RX queues, causing a use-after-free?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729063347.3388035-1-dipayanroy@linux.microsoft.com?part=2

As this Sashiko comment is for a pre-exisiting issue and not related to
this patch, will send out a different patch for this.


Regards
Dipayaan Roy
