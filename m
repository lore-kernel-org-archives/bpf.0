Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56933BBFC7
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021296; cv=none; b=r85rrLUJR4dGWwQzvAgSaUZkxDolYuaxmZ6FPPXLFX1U365iBSl2EfK/jAx0ecNJqMuUSgF4Ccv+sjLmg0zb0eAUI7IhMt5bSYwflXM80p9y6+YooskMu4lY5w46blWlFD3YauESJBMbT4WxLW+FBy4XbAfZxoYc1Io5GaeK+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021296; c=relaxed/simple;
	bh=1/VUdwEcbJKn9K5jvVdYdoM5ofQSW9yKaOYYCgehtB8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=s5J7XFZNcd5biU+fm5U22R4zG5MXeoQPwExEuiDSDdNsXi4DuRaluH2s2WMTje52RnHoFSv5KCKKRa7hBC7KD/TlsX43VAOik4oF8WygSm9y9mek6I8OPLVtoJ7H1PgAvWp4TLO5URGR9/olF7kY3YohfrlOZpEA+twFZKFGMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XA9mCwga; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKlamEu8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XA9mCwga";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKlamEu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikxWZJeYQ1V1AF6NYmjgqyaYfUGSJz9U1lEa1NQkyHg=;
	b=XA9mCwgatbGbBqP48o1QhOzybRjTAVfr5B02F8i9/mxvE9ef5JYFcaYcny0aS5cx4tM8BT
	1gb/UxBA1OOT9xV5vhVqnhUFZs4bWRxzqwUojaFNJkh7rk7R5DxfKnM72xX12NeqmRdka+
	lFb0tIrSS5NhRwz1KVSEnpnPGX8jBHw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-WBrWRmbaPtqFDXA1pz-nfA-1; Sat, 03 Oct 2026 05:54:52 -0400
X-MC-Unique: WBrWRmbaPtqFDXA1pz-nfA-1
X-Mimecast-MFC-AGG-ID: WBrWRmbaPtqFDXA1pz-nfA_1791021291
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b02d63407so194714f8f.0
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021291; x=1791626091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ikxWZJeYQ1V1AF6NYmjgqyaYfUGSJz9U1lEa1NQkyHg=;
        b=SKlamEu8u6fuVr7vilZpojQE+visLd4UijwB/z3O+ASsul8T/xuyG2VthdHdVSfltK
         L7M3KXlkQlmrLdOJvhYTcIvMEq3YbtfILYoxjpzNzY8VPWfEqwI7SNhc9+ZGaDXcf/lf
         htsI0S3TF9MDRVlkOZLDK1Zq0srPyICY+cqFqpnT/RuThN6VspAPUAg2cBOnjE303NK4
         6tRUMm9+Rkoi+2W3Wt3VVVBydDTlJEty4RAbztjHev4ceRjc246hycmCRiEzzeo88Yql
         rorzoeqKFHrCkjgDFoXCMdKrza4UAXLDmiq9YkJ6HqVSEKBnuDUzXYDU6cl9L+AYTaQA
         M5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021291; x=1791626091;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikxWZJeYQ1V1AF6NYmjgqyaYfUGSJz9U1lEa1NQkyHg=;
        b=p5hE4WhhZU+hUlH9S/IBI84c6il3u5z5w8qxEH/7sdkRy2D4H9P944jc47iGFIyiSg
         FSiYoZDkmdWI+kFGFDnKasOodN8RKfQxd5tY1DOPy1AzUo6mExjxtcGCAkd+wn13qBru
         CbONnxu8DLMxvqiFIROVZbbBmB/QmOY6Ly+weg3rbH+/B+NkHZWgTYyXPq7LgsXsUcpH
         F1QwuVY5NiLfjPPoEIq+bOhDlIAf9lRpBnwsobrwUF5aIKehOPlCaDaIds81TvjGDT/K
         /4vVDq4nE3TogXvXJWhDK9jzhbOyUWoE29++q2NsmTY54EZWlmXDEpUYYProk90v0kSE
         NyNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvsTs7dGiY3/v+sk78oauDq+TOKw1/pzetbkgV76Bo53ZnL8dthf1lqtiH1CD5YkoXlqA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfTn7fFlO1FXna8pzragUk0mTh8aPUfjIlgxkzm2725ttgdrm9
	P5vZtlFIEyIfkVXn6oWlov4YyYpZW7JMo58ZrzlR+uudYHkIfnkFEL30LdFrYnxnFzcAhbYjoeF
	jSLC1kyQ4MHMd1zWGMVuy1CwqP1JYA+ShzLMXFMpS/PuNKkLayaAwoQ==
X-Gm-Gg: AYBFou1grTpIDYNs/GwbYQUDDA4GvOUx4HACFc41B5UgqbLeG653dCwQjhoYFyww5AO
	IeZ1lGyeTSRupUYb7Qu7uVRIvGSO5O6vPtystC2cU4d50vblA2OFAbZbk4IwrHiq6geRni8p79X
	kJ6g3J5jYjBg0F8Easz2j5Z8wVfbZjsqaFHppgIgXluqQMK3WwzSI3byWP8xk7JkZpUSgvyhNQf
	XWwfKr1yrVp7jAqMjjhOORJi6YWjQAczOhzaaCFQk59Gl84LK50mXHBOLm2cW6ldv0UAXfOdagF
	NMMHJoSds+N0YFs71jreplKjl+ncGipF6mcU3BXa31q+BGA5J9uGjSUmB85Qc9wB26XnzavtQvb
	JsW7/sfFItt+T/xYtZTgmsTOYINsWxclLqZJ4TW0=
X-Received: by 2002:a05:6000:4553:b0:48b:610:df98 with SMTP id ffacd0b85a97d-48b1276366bmr5184997f8f.40.1791021291326;
        Sat, 03 Oct 2026 02:54:51 -0700 (PDT)
X-Received: by 2002:a05:6000:4553:b0:48b:610:df98 with SMTP id ffacd0b85a97d-48b1276366bmr5184980f8f.40.1791021290914;
        Sat, 03 Oct 2026 02:54:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104d58sm12123904f8f.28.2026.10.03.02.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:54:50 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:54:48 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_03/10=5D_ice=3A_stop_the?=
 =?US-ASCII?Q?_LAN_Tx_queues_when_ice=5Fvsi=5Fopen=28=29_fails?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-4-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-4-poros@redhat.com>
Message-ID: <1465AD22-8132-4286-A2AF-ED94E64E12C8@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:45 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>ice_vsi_cfg_lan() adds the LAN (and XDP) Tx queues to the scheduler and
>enables them in hardware=2E If anything after it fails in ice_vsi_open(),
>for example requesting the MSI-X vectors, the error path only frees the
>ring memory and leaves the queues configured=2E Every following open then
>fails to add the same queues again and the netdev can not be brought up
>until the driver is reloaded:
>
>  ice 0000:04:00=2E2: Failed to set LAN Tx queue context, error: -5
>  ice 0000:04:00=2E2 enp4s0f2np2: Failed to open VSI 0x0010 on switch 0x0=
002
>
>Stop the Tx queues on the error paths that run after ice_vsi_cfg_lan()=2E
>The ice_up_complete() failure path already does it through ice_down(),
>so let it skip the new step=2E
>
>There is no i40e counterpart of this fix, i40e does not add its Tx
>queues through the admin queue=2E It was found while verifying the
>previous patch=2E With the IRQ unwind fixed the warnings were gone, but
>the netdev still could not be opened again after the forced
>request_irq failure=2E
>
>Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
>Assisted-by: LLM

Which one?

Otherwise=2E=2E=2E

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>


>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_main=2Ec | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main=2Ec b/drivers/net/et=
hernet/intel/ice/ice_main=2Ec
>index d246cde36ae726=2E=2Ee62a8f544345a3 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_main=2Ec
>@@ -7561,13 +7561,13 @@ int ice_vsi_open(struct ice_vsi *vsi)
>=20
> 	err =3D ice_vsi_cfg_lan(vsi);
> 	if (err)
>-		goto err_setup_rx;
>+		goto err_stop_tx;
>=20
> 	snprintf(int_name, sizeof(int_name) - 1, "%s-%s",
> 		 dev_driver_string(ice_pf_to_dev(pf)), vsi->netdev->name);
> 	err =3D ice_vsi_req_irq_msix(vsi, int_name);
> 	if (err)
>-		goto err_setup_rx;
>+		goto err_stop_tx;
>=20
> 	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
> 		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg=2Eena_tc);
>@@ -7593,8 +7593,14 @@ int ice_vsi_open(struct ice_vsi *vsi)
>=20
> err_up_complete:
> 	ice_down(vsi);
>+	ice_vsi_free_irq(vsi);
>+	goto err_setup_rx;
> err_set_qs:
> 	ice_vsi_free_irq(vsi);
>+err_stop_tx:
>+	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
>+	if (vsi->xdp_rings)
>+		ice_vsi_stop_xdp_tx_rings(vsi);
> err_setup_rx:
> 	ice_vsi_free_rx_rings(vsi);
> err_setup_tx:

