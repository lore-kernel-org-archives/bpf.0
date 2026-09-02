Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BD40C5C0
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383901; cv=none; b=VKs2yi/kPYzj4MaDm6d7Fgv3mXmdG7cr9Bzh9+OLsC3ZUBRAjAQjGRx3AHHCVFrsTgiFIOtPDQ/4PE+FojnXtVr/Y5amFnNZ3HXAtBZlVaKMPzZnulCQOAxkaqGBAv3yaYGqMKmVIgzLPjCdXmiXrGrXd76wNqvnBtE6z4wjkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383901; c=relaxed/simple;
	bh=IWg49bi5Kh4C/wOoQIgrPbfiZ8PRpBIxPy94SooRSJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=prkCjwWJK/VWeskzOT8GTq42Esop61Yn6j1mBNQO207v89LfxDK2dki4pP5QDIbc2L8U7+xN7gxZPgfTgOSlu9j11LysZOSrXrD2x4rTqzOo7nAbSqeyP6folo5w8BQejbJu3iISRCZRU+QMbVUA1CqcxcqSu6WnjARwVirIbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/CorNTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/CorNTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0017C1F000E9;
	Wed,  2 Sep 2026 21:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788383897;
	bh=q0SMtKOxGxX68Q4AeFYOJMhnTnn+bHj7trredIjA8Pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F/CorNTSLsr6mCcmryj+aR9O+x1+/GQdlehGC9N3G7dFfnvO1jcJ7a2ZC9ji90q7d
	 3OU8xh1ITOagfvqdc8slFem2VAS83dOYJYxkRfep9iK4R2SnerIp5uKJOzU8TSkID0
	 EtePaVqmBjkYmyUot1nQ4yg2q1bkdXeQLEYaM2wu9jlUkZtf92oxwgNQJj52vqf340
	 bq9deaEhuz0c9Qx2iyYzEiIGpuQN3MqHLKEyJqSqRkZ+9koa3sB3cIfyMjVD3E4DAZ
	 Z473Cy8VTTpz2gnaVT00BN3FdfyD/Pxkr22Jik3gTcMEEaQfQ9UlixK0XXvyiH2XV9
	 CevBbf8AEO8dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 4/4] i40e: Avoid repeating RX filter warning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Nguyen" <anthony.l.nguyen@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901211752.1922993-5-anthony.l.nguyen@intel.com>
References: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
 <20260901211752.1922993-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 21:18:16 +0000
Message-Id: <20260902211817.0017C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The fix for repeating RX filter warnings is incomplete and leaves =
SRIOV/VMDQ VSIs vulnerable to log spam, exacerbated by unconditional state =
clearing for untrusted VFs.

Pre-existing issues:
- [High] The function `i40e_sync_vsi_filters` implements an ad-hoc sleeping=
 spinlock using a bit flag (`__I40E_VSI_SYNCING_FILTERS`), violating subsys=
tem locking guidelines.
--

commit e12ee63ee282f8dda3570d0ba1ab6d4fc31ab63e
Author: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: i40e: Avoid repeating RX filter warning

This patch introduces a test_and_set_bit check on the overflow promiscuous
state flag to suppress repetitive log messages when the driver forces
overflow promiscuous mode due to a lack of space for RX filters. It updates
the warning logic in both i40e_aqc_add_filters and i40e_aqc_broadcast_filte=
r.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index 719f45b5cb409..abbc71e815ae3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
[ ... ]
> @@ -2412,10 +2412,12 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, c=
onst char *vsi_name,
> =20
>  	if (fcnt !=3D num_add) {
>  		if (vsi->type =3D=3D I40E_VSI_MAIN) {
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
>  		} else if (vsi->type =3D=3D I40E_VSI_SRIOV ||
>  			   vsi->type =3D=3D I40E_VSI_VMDQ1 ||
>  			   vsi->type =3D=3D I40E_VSI_VMDQ2) {

[Severity: High]
Does this logic leave virtual function and vmdq VSIs vulnerable to log spam?
The patch suppresses the warning for the main VSI by checking
test_and_set_bit, but the else if branch for the other VSI types immediately
below it does not use a state check.

Should the state-based warning suppression be enforced equally across all V=
SI
types?

This regression seems exacerbated by the unconditional state clearing for
untrusted virtual functions in i40e_sync_vsi_filters:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_sync_vsi_filters() {
    ...
	/* if the VF is not trusted do not do promisc */
	if (vsi->type =3D=3D I40E_VSI_SRIOV && pf->vf &&
	    !pf->vf[vsi->vf_id].trusted) {
		clear_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
		goto out;
	}
    ...
}

Does this unconditional state clearing destroy the warning suppression logic
for untrusted virtual functions, potentially leading to a denial of service
via log spam?

[Severity: High]
This is a pre-existing issue, but while reviewing the synchronization of
these filters I noticed the following pattern in i40e_sync_vsi_filters:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_sync_vsi_filters() {
	...
	while (test_and_set_bit(__I40E_VSI_SYNCING_FILTERS, vsi->state))
		usleep_range(1000, 2000);
	...
out:
	...
	clear_bit(__I40E_VSI_SYNCING_FILTERS, vsi->state);
	return retval;
	...
}

Does this implement an ad-hoc sleeping spinlock using a bit flag, violating
the subsystem guidelines for synchronization?

Would it be better to directly replace this custom polling loop with a
standard mutex to ensure strict lockdep tracking and memory ordering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901211752.1922=
993-1-anthony.l.nguyen@intel.com?part=3D4
