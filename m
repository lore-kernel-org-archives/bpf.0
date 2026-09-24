Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7389C32D0FC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214275; cv=none; b=QgO5kEA5zuvotp637dmj80Kf7wUJ9spGHN5EiJSj5nmqEQ9l2YZ3o/oOaI0FahoI5eYShdU8O59mTS1hOCLJ0gb8vqIMDIpb6pNGAlYQvpX9x4y3KXpYbmj+eZSPMiA6WdqRcp2aCvyHCzVLd73yQ/R/BIMeY/gcfmVRzT8J8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214275; c=relaxed/simple;
	bh=Sr5qIUxVw2kaigMk3/IIL3c21ChMRIgZV5Fu2+vBW5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NXgzr0AfnCGXXtzZI1r22k9xYrUB3zpaf3lfaClNPePoZFLI7rLcoXiEe13z3G1K9s/4yfSNZjrcpw+kg8vnw9r/XcxPmjQ2LnCvPTFKFWtf3IYmxWIxxnAW3paYcM0+aYEGe7LNXlIFa83hgGieIcg1TvYL2V9M+8AiTV9mu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6qVV9PO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6qVV9PO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214B01F00893;
	Thu, 24 Sep 2026 01:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214274;
	bh=vlYpsIDwTk/ML0EJUTGZBAIZ5E2I4cmV1QhP1ezepL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6qVV9POIfW+1F7Gq72bax6plY1gX7kvbL1mf/JLicgDtVc2TmhpCsr4pYwzYXDer
	 62M5CE++N4jsYrxoqeaF/UaY97HN+7tqdiREGwzTk8SCtcA2OZQIFcAx2il8DQachg
	 HR5pHCPGkyE8lSBPvQk7n7l/imsKH2e8QOnoYpcTkxQrUyLTi88eFC8ssiZAPqq9N8
	 KjrRVRi80sNNdkOulaA9s7Y+NVscUDiPmIInXM7V7F2fRHkVbA+xebHraR2YfMBoUL
	 IEA6ojONoM4V0V6cld8mGcWzrzHXKzJ10wCRrO4//C12yX849ERnnEoRxEfVnpRfsM
	 5ESwbjhbheD3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 5/8] eth: mpnic: start and stop the Tx HW
 queues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-linux-mpnic-v1-5-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
 <20260922-linux-mpnic-v1-5-236844f53072@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 01:44:33 +0000
Message-Id: <20260924014434.214B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] eth: mpnic: hardware pipeline deadlock from incorrect teardown seq=
uence
- [High] eth: mpnic: DMA use-after-free due to ignored queue idle timeout
--

commit f74c6bf4e3ce87eee577108084c59c43728d6d01
Author: Daniel Zahka <daniel.zahka@gmail.com>

eth: mpnic: start and stop the Tx HW queues

This patch points the hardware at the descriptor rings and provides functio=
ns
for turning the Tx queues on and off. Teardown waits for the DMA engines to
go idle before the ring memory can be freed.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.c
> index fe360a26a27be..cb4d1427434c9 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -460,6 +461,180 @@ void mpnic_reset_netif_queues(struct mpnic_net *mpn)
>  	}
>  }
> =20
> +static void mpnic_enable_twq(struct mpnic_dev *mpd, struct mpnic_ring *t=
wq)

[ ... ]

> +void mpnic_enable(struct mpnic_net *mpn)
> +{
> +	struct mpnic_dev *mpd =3D mpn->mpd;
> +	int i, j;
> +
> +	for (i =3D 0; i < mpn->num_napi; i++) {
> +		struct mpnic_napi_vector *nv =3D mpn->napi[i];
> +
> +		for (j =3D 0; j < nv->txt_count; j++) {
> +			mpnic_enable_twq(mpd, &nv->qt[j].sub0);
> +			mpnic_enable_tcq(mpd, nv, &nv->qt[j].cmpl);
> +		}
> +	}
> +
> +	mpnic_wrfl(mpd);
> +}

[Severity: High]
Does enabling the Transmit Work Queue (TWQ) before the Transmit Completion
Queue (TCQ) allow in-flight descriptors to complete against a disabled TCQ?

Could we swap the initialization order in mpnic_enable so the TCQ is ready
before the hardware picks up new work?

> +static void mpnic_disable_twq(struct mpnic_dev *mpd, struct mpnic_ring *=
txr)
> +{
> +	u64 twq_ctl =3D mpnic_rd64(mpd, MPNIC_TWQ_CTL(txr->q_idx, 0));
> +
> +	twq_ctl &=3D ~MPNIC_TWQ_CTL_ENABLE;
> +	mpnic_wr64(mpd, MPNIC_TWQ_CTL(txr->q_idx, 0), twq_ctl);
> +}
> +
> +static void mpnic_disable_tcq(struct mpnic_dev *mpd, struct mpnic_ring *=
txr)
> +{
> +	mpnic_wr64(mpd, MPNIC_TCQ_CTL(txr->q_idx), 0);
> +	mpnic_wr64(mpd, MPNIC_TIM_INTR_MASK(txr->q_idx),
> +		   MPNIC_TIM_INTR_MASK_MASK);
> +}
> +
> +void mpnic_disable(struct mpnic_net *mpn)
> +{
> +	struct mpnic_dev *mpd =3D mpn->mpd;
> +	int i, j;
> +
> +	for (i =3D 0; i < mpn->num_napi; i++) {
> +		struct mpnic_napi_vector *nv =3D mpn->napi[i];
> +
> +		for (j =3D 0; j < nv->txt_count; j++) {
> +			mpnic_disable_twq(mpd, &nv->qt[j].sub0);
> +			mpnic_disable_tcq(mpd, &nv->qt[j].cmpl);
> +		}
> +	}
> +
> +	mpnic_wrfl(mpd);
> +}

[Severity: High]
Does shutting down the TCQ concurrently with the TWQ stall the hardware
pipeline during teardown?

If the TWQ is disabled, packets already in the pipeline still need to be
completed. By disabling the TCQ immediately in mpnic_disable, the DMA engine
(TDE) is blocked from writing completions to host memory.

Will this prevent the pipeline from ever reaching an idle state, guaranteei=
ng
that the subsequent wait for idle queues times out? Should we disable the
TWQ, wait for the pipeline to drain, and then disable the TCQ?

[ ... ]

> +void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
> +{
> +	static const struct mpnic_idle_regs queues[] =3D {
> +		{ MPNIC_TWQ_IDLE(0), MPNIC_TWQ_IDLE_CNT, "TWQ" },
> +		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
> +		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
> +		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
> +	};
> +	u32 non_idle_bitmap;
> +	int err;
> +
> +	err =3D read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
> +				!non_idle_bitmap, 20, 500000, false, mpd,
> +				queues, ARRAY_SIZE(queues));
> +	if (err)
> +		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
> +				non_idle_bitmap, err);
> +}

[Severity: High]
Does returning void here prevent callers from handling hardware wedges safe=
ly?

If the 500ms timeout is reached in read_poll_timeout(), mpnic_wait_all_queu=
es_idle
logs an error but the caller will unconditionally proceed to free the DMA-m=
apped
descriptor rings.

Could freeing this memory while the DMA engine is still active cause a DMA
use-after-free, leading to IOMMU faults or memory corruption? Should this
function return the error so callers can either leak the memory or issue a
hard device reset if the device fails to idle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-linux-mpni=
c-v1-0-236844f53072@gmail.com?part=3D5
