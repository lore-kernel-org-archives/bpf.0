Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA142123E;
	Fri,  4 Sep 2026 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513601; cv=none; b=Q5Kkib2eTah1lKnunB2yOj+jmRBL+XDx+DEVDNeO7UehE+lZpNWniHQCvJum0Y2tU54J3U7LZsoCliffn8uJkgRlNhxTL7jnG6+4+VArJY13hSMWIgqz38IwJ/sY0tIq7Sym1umL7TF9AT2gJLLxZLQRXcZ1JeReCmRfjmjmzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513601; c=relaxed/simple;
	bh=OzRy7G56s8hu7pUt4GdQmahUiIPWrLYG9Cn0NPAezQ0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PH9PeMGNrE14lVYS4VmEq+06PCJ1Th37tUvE5ifgFzDFhm73k5NTOsj5Dbb3BAkVmyFHqiPBD3v4KSHf3QwMTjAqYL0+cpRmmX9TOd19wAtThzqTuiko5hbweG+CIGQpW6LUsQwjPf0cdmNL1cYnwAm+fc0oihVEHNHPPINY/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPYd4ppv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPYd4ppv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764E71F00A3E;
	Fri,  4 Sep 2026 09:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788513599;
	bh=m3zmrB+UC+gNhBuz3Velpf0Gbjrecq4GQkgZcuKP/UY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kPYd4ppvGyi6dqlpk/0f8fJMDTzUJM2M6B/HW6hUnaDc6z4ulqM2oMCA3olf/sKPD
	 nu+MT4bKVMJBMP+LmW0P0+k19cir814TPEZLWwL90uWrOVEvtNVuzYgJBBrVMie80b
	 ceQNl48s7CB3hAoMnPFVRiuh1AXhfmSYom3UfRIOFMOOiH5EX8fSXxJUy1/sHDTyKR
	 yvAtGFQpNehzgYBb8NKAZ11vvjxhaY1TOFmIeCDr/WP/470Q3H8x0JbxHrn2n4QAmq
	 8+6X8W8b8uUYTAUUoFgwk7M0THeY1w3o93NItwrV1ODDKJ9S0F0XLUw6rffvuUljij
	 pOgQuJvuhok5g==
Subject: Re: [PATCH net-next 4/4] i40e: Avoid repeating RX filter warning
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 chris.packham@alliedtelesis.co.nz, kohei.enju@gmail.com, enjuk@amazon.com,
 przemyslaw.kitszel@intel.com, blair.steven@alliedtelesis.co.nz,
 carl.smith@alliedtelesis.co.nz, horms@kernel.org,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org, aleksandr.loktionov@intel.com,
 sx.rinitha@intel.com
Date: Fri, 04 Sep 2026 09:19:57 +0000
Message-ID: <178851359799.4131868.11248615575150226456@kernel.org>
In-Reply-To: <20260901211752.1922993-5-anthony.l.nguyen@intel.com>
References: <20260901211752.1922993-5-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 1

- [Low] Two diagnostics that report different failure classes are now
  gated on one shared single-shot bit.

Pre-existing issues:
- [Medium] The overflow-promiscuous bit that the patch now also uses as a
  log-once latch lives in `vsi->state`, which is protected only by an…

--

i40e: Avoid repeating RX filter warning

The patch converts the two set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)
call sites in i40e_aqc_add_filters() and i40e_aqc_broadcast_filter() to
test_and_set_bit(), so the "forcing overflow promiscuous" warning is only
emitted on the transition into overflow promiscuous mode.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 719f45b5cb409..abbc71e815ae3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2412,10 +2412,12 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
>  
>  	if (fcnt != num_add) {
>  		if (vsi->type == I40E_VSI_MAIN) {
> -			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
> -			dev_warn(&vsi->back->pdev->dev,
> -				 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
> -				 libie_aq_str(aq_status), vsi_name);
> +			if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC,
> +					      vsi->state)) {
> +				dev_warn(&vsi->back->pdev->dev,
> +					 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
> +					 libie_aq_str(aq_status), vsi_name);
> +			}

[Severity: Medium]
This isn't a bug introduced by this patch, but the warning is now latched on
a bit whose lifetime is managed by an ad-hoc flag-as-lock scheme, so is the
latch reliable?

i40e_sync_vsi_filters() serializes its whole sleeping section with an
open-coded acquire loop:

	while (test_and_set_bit(__I40E_VSI_SYNCING_FILTERS, vsi->state))
		usleep_range(1000, 2000);
	pf = vsi->back;

	old_overflow = test_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);

and releases it with a plain clear_bit(__I40E_VSI_SYNCING_FILTERS,
vsi->state) on both the out: and err_no_memory: paths.

i40e_add_vsi(), reached from i40e_rebuild() and i40e_vsi_setup(), clears the
bit without participating in that gate at all:

	spin_unlock_bh(&vsi->mac_filter_hash_lock);
	clear_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);

If that clear lands while i40e_sync_vsi_filters() is between its
old_overflow snapshot and the new_overflow / promisc_threshold decision, can
the warning re-fire, or the opposite, can the state read as non-overflowing
while filter programming keeps failing?

>  		} else if (vsi->type == I40E_VSI_SRIOV ||
>  			   vsi->type == I40E_VSI_VMDQ1 ||
>  			   vsi->type == I40E_VSI_VMDQ2) {
> @@ -2465,10 +2467,11 @@ i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
>  	}
>  
>  	if (aq_ret) {
> -		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
> -		dev_warn(&vsi->back->pdev->dev,
> -			 "Error %s, forcing overflow promiscuous on %s\n",
> -			 libie_aq_str(hw->aq.asq_last_status), vsi_name);
> +		if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)) {
> +			dev_warn(&vsi->back->pdev->dev,
> +				 "Error %s, forcing overflow promiscuous on %s\n",
> +				 libie_aq_str(hw->aq.asq_last_status), vsi_name);
> +		}
>  	}

[Severity: Low]
Two different failure classes now share one single-shot bit. Is that
intended?

i40e_aqc_add_filters() warns when MAC/VLAN filter space is exhausted
(fcnt != num_add, typically LIBIE_AQ_RC_ENOSPC), while
i40e_aqc_broadcast_filter() warns on any AdminQ error returned by
i40e_aq_set_vsi_broadcast() or i40e_aq_set_vsi_bc_promisc_on_vlan(),
including errors that are not ENOSPC, and prints its own
libie_aq_str(hw->aq.asq_last_status) text.

In the scenario from the commit message (bridge vlan add vid 2-4094) the add
path sets __I40E_VSI_OVERFLOW_PROMISC first, so a later
i40e_aqc_broadcast_filter() failure of an unrelated class prints nothing
until the bit is cleared again.

For the delete path in i40e_sync_vsi_filters() the return value is
discarded:

			if (is_broadcast_ether_addr(f->macaddr)) {
				i40e_aqc_broadcast_filter(vsi, vsi_name, f);

				hlist_del(&f->hlist);
				kfree(f);
				continue;
			}

so with the warning suppressed, is that failure reported anywhere at all?
Would a per-site dev_warn_once() style latch, or a separate condition flag
per message, keep both diagnostics?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901211752.1922993-1-anthony.l.nguyen%40intel.com
