Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006CE3FA5D0
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021354; cv=none; b=FB5xPX5rGDmh18xTpbW7t1orj3EXP5e3JjCEuvN4yCVsvdtPzzK06RFYTRFyiqGdTtEabgt51Dol0x5soTp2Bx8cm490gfhwpHkxDIlGJDfcXyHPIh/iq5Xe2wNztHdsgU9/uXBecJr8vjX+r3EPsQfx+2zb30FmLbfe4zp1fBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021354; c=relaxed/simple;
	bh=NNdvpSbWcpCDak+fCIfxwUO4njtUxnGMFI2EIxozuaw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gX8uoPQpkylEu0YwddnQK30xKGsVqyh0KGFxjTNB4YJ/VlxglbtZeMBq3NYM4UXrvNWsPHjSQkAHxD28jJdaTxN/nba0a8ALTtl7HlfuZRsulf8CVyAf8vimC7aX3vSJ0F0cy+OFLhjLdt1AegZL/vlTiilUawDG0xmNSeuoQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2RQqp3u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ia0apF5J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2RQqp3u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ia0apF5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=211tvn9y3p5J+u/mzZRpmt2Ac+xaJHBNaH1jQgm5GKo=;
	b=Q2RQqp3uAUpft7Ja0IVDyqIbI2ntHYBrBQ94m1zkj5F89MYmJ3muQMo/HOQpncrstvvOkw
	2UluyKceRUXOFxfpkjlRYAieT/mbup/f/S/MHC8jy7wqPLlmmJhulzovdHaAiNZeQMs6RN
	38aXAvCsS5IFYOH+cIDmVVwUudz7DAI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-iThmPkfvPbOsY_xaq9QZ7w-1; Sat, 03 Oct 2026 05:55:50 -0400
X-MC-Unique: iThmPkfvPbOsY_xaq9QZ7w-1
X-Mimecast-MFC-AGG-ID: iThmPkfvPbOsY_xaq9QZ7w_1791021349
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a022fee32fso4495295e9.0
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021349; x=1791626149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=211tvn9y3p5J+u/mzZRpmt2Ac+xaJHBNaH1jQgm5GKo=;
        b=Ia0apF5Jav/Dcn3J0jRE9lPIxZeUSR3QVGmQNtfY940Gr5xJ4ZMi1jfZnmnPAOryKQ
         /3QNf0VyL6hCCOZrR6pmGjl5rhQLjjAjGmEh6Kf1h3E9SFbj9LQ/6it4XlIpdoSQLfjn
         Spf86Hjo357Nu6YxhvH2T5BcgLW6nid9I2yQia0gkCciyMmu8sakBge9Fh8m8Kb4/tP5
         7mURopLZVvGPz4L9c6dc/FQW602iEqTdJ5AbCWwkDQfK9iweEm3hR+SV2L/8WUSM2pQ2
         2JP2f5uczQEiF2v6mRpJvkuvJbUefK3WGx9R/zr3h7ZayKwKRCYGT+K1rZtpArrMX5DR
         duMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021349; x=1791626149;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=211tvn9y3p5J+u/mzZRpmt2Ac+xaJHBNaH1jQgm5GKo=;
        b=KfzLpg85OYx/Qp2v62qeAu4Quwgw3BJ8JsEozvU5dL0c2AClEau8uS7vlIvJ6jj/rw
         dMC1Qt6mukHnmAPlS8/jkMZM4N2N+nh8f9OUD4t2Rq8zV4BzhlhZljzGIcN2LkPklSiv
         oUplmwvTklKVn0g6aqQnXvwfnHarZ63/4hySW2JBxWDX0LYRBxOJklJZpbEhyalI4PqE
         Mxdiy8wJsLsJFAjeLixzEf9LzqqCVXa57+HPH/3KnFWW1WqhUQ4vz6LLxBWDwkvEtUel
         yLbHMVDoIoe4IpvtZmphqi4FcK8jsrONSOYJJ+U4b0Jw6LMIUX1lQrRM1vUhMO40tar9
         sIDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLIgDxV+j/TN3mISuv27PO3WLliDx7ehv1qWoJxx3/RYgudD6SDXsQzMjN/kmcdgiS1Cw=@vger.kernel.org
X-Gm-Message-State: AFuF++n7+Yi17toe0/wq5cpaLEyLV8XXeJull8BfhY/Xj5TiTwlsNIba
	e3OKW8fEQTub+KUt20xOqBd40DMExzWF0HNzMbVPtbUbuRv0kjFLmbn3rR7OoPt/WF86gXnyeGB
	bE4HIlfK2tvARNBZbWFA+oAf/H0NinBNgrog+MrffaoKC6EZ3ccxUNg==
X-Gm-Gg: AYBFou0FCqGp8qGlqJAj1EiZEmHtZqL4TI/gtrf+7bAV2hShgYE6zX067Z6cnud+iEa
	azEEhyfs0M0EYyATQ16bUBDhmWaIS4Hc4q6olz9YIwvCCNq1Nsu/CIZJ67xl5m0UeFALq45IaWZ
	w+nIXyqy/7fnLqk7RdHD0szSxBsZIadnNqFkJ7CdZVBax06V9KJOOa5YOvzUT0wOKcWAuAOCrho
	XnsVDqYFz9ENBdGWJExuJ6tvbvM4JRvGTpnPQxhSZwNgiwmR6n+1NdwWYVSMiO69SPuFEG2a0sA
	zBN25AFttGYPBieB2FfBkgxnl94tKaH14LQIQZQtlaFJ+fvmVQVEDG3mSV9BMgibQfz+CW9JMSa
	WXF+bl78EhzvAGVrI4fA4O6EI2ZrPBlRu76x25Ow=
X-Received: by 2002:a05:600c:3510:b0:49f:ff32:803c with SMTP id 5b1f17b1804b1-4a02758653cmr85580335e9.16.1791021349377;
        Sat, 03 Oct 2026 02:55:49 -0700 (PDT)
X-Received: by 2002:a05:600c:3510:b0:49f:ff32:803c with SMTP id 5b1f17b1804b1-4a02758653cmr85580005e9.16.1791021348969;
        Sat, 03 Oct 2026 02:55:48 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16bcb9a21sm38091735e9.10.2026.10.03.02.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:55:48 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:47 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_07/10=5D_ice=3A_take_the_swit?=
 =?US-ASCII?Q?ch_rule_AQ_error_from_the_response_descriptor?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-8-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-8-poros@redhat.com>
Message-ID: <9B559EBB-75B5-43C6-AA5F-304E2AED20AE@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:49 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>ice_aq_sw_rules() decides whether a rule removal failed with ENOENT by
>reading hw->adminq=2Esq_last_status after ice_aq_send_cmd() returned=2E T=
hat
>field is shared by every admin queue user and is only stable while the
>send queue lock is held=2E Another AQ command completing in between can
>overwrite it, so a failed removal is reported as a generic error, and a
>successful one can even be turned into -ENOENT, because the check is
>not limited to the failure case=2E A caller that sees -ENOENT keeps its
>rule bookkeeping while the rule is gone from the hardware=2E
>
>ice_vsi_sync_fltr() has the same problem with ENOSPC=2E It checks
>sq_last_status only after it has freed the list of filters it tried to
>add=2E Every entry is a separate devres allocation, so freeing a list of
>thousands of entries takes seconds, and by then the value usually
>belongs to a different command, so the MAC filter overflow handling is
>never entered=2E With debug prints of the error and sq_last_status added
>to both places:
>
>  ice_aq_sw_rules: opc 0x2a0 status -5 aq 16
>  ice 0000:04:00=2E0 enp4s0f0np0: Failed to add MAC filters err -5 aq 0
>
>Use the retval of the descriptor that ice_aq_send_cmd() copies back,
>only when the command failed, translate ENOSPC on add to -ENOSPC and
>let ice_vsi_sync_fltr() check the return code instead of
>sq_last_status=2E
>
>i40e fixed the same kind of race in commit 53a9e346e159 ("i40e: Fix race
>condition while adding/deleting MAC/VLAN filters")=2E
>
>Fixes: ca1fdb885e5f ("ice: return correct error code from ice_aq_sw_rules=
")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_main=2Ec   |  4 +---
> drivers/net/ethernet/intel/ice/ice_switch=2Ec | 13 ++++++++++---
> 2 files changed, 11 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main=2Ec b/drivers/net/et=
hernet/intel/ice/ice_main=2Ec
>index 8a21f87eb6ca21=2E=2Eceb9fec2af21e7 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_main=2Ec
>@@ -396,8 +396,6 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
> 	struct device *dev =3D ice_pf_to_dev(vsi->back);
> 	struct net_device *netdev =3D vsi->netdev;
> 	bool promisc_forced_on =3D false;
>-	struct ice_pf *pf =3D vsi->back;
>-	struct ice_hw *hw =3D &pf->hw;
> 	u32 changed_flags =3D 0;
> 	int err;
>=20
>@@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
> 		 * should go into promiscuous mode=2E There should be some
> 		 * space reserved for promiscuous filters=2E
> 		 */
>-		if (hw->adminq=2Esq_last_status =3D=3D LIBIE_AQ_RC_ENOSPC &&
>+		if (err =3D=3D -ENOSPC &&
> 		    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
> 				      vsi->state)) {
> 			promisc_forced_on =3D true;
>diff --git a/drivers/net/ethernet/intel/ice/ice_switch=2Ec b/drivers/net/=
ethernet/intel/ice/ice_switch=2Ec
>index 239d4d9633baa6=2E=2Eae96a2003d5c5e 100644
>--- a/drivers/net/ethernet/intel/ice/ice_switch=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_switch=2Ec
>@@ -1959,9 +1959,16 @@ ice_aq_sw_rules(struct ice_hw *hw, void *rule_list=
, u16 rule_list_sz,
> 	desc=2Eflags |=3D cpu_to_le16(LIBIE_AQ_FLAG_RD);
> 	cmd->num_rules_fltr_entry_index =3D cpu_to_le16(num_rules);
> 	status =3D ice_aq_send_cmd(hw, &desc, rule_list, rule_list_sz, cd);
>-	if (opc !=3D ice_aqc_opc_add_sw_rules &&
>-	    hw->adminq=2Esq_last_status =3D=3D LIBIE_AQ_RC_ENOENT)
>-		status =3D -ENOENT;
>+	if (status) {
>+		enum libie_aq_err aq_err =3D le16_to_cpu(desc=2Eretval) & 0xff;
>+
>+		if (opc !=3D ice_aqc_opc_add_sw_rules &&
>+		    aq_err =3D=3D LIBIE_AQ_RC_ENOENT)
>+			status =3D -ENOENT;
>+		else if (opc =3D=3D ice_aqc_opc_add_sw_rules &&
>+			 aq_err =3D=3D LIBIE_AQ_RC_ENOSPC)
>+			status =3D -ENOSPC;
>+	}
>=20
> 	if (!status) {
> 		if (opc =3D=3D ice_aqc_opc_add_sw_rules)

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

