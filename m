Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371473F929A
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021327; cv=none; b=Uyu25yT2qSTEssW5JG794bOtrxVvOJ6I11isq5tUUaKNMuL0s91TIEtjlUhwH0xMYzej5nReUbeNDAP+JTZOs4kpidAehA/a9QN1i9bbauwq0AZLmNg1lbSjsPApksHOhdBcTrkDTlwczHRfwCMCt42dQ4CeSA39F7NJfCTcfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021327; c=relaxed/simple;
	bh=q0PnyaOp7rmWQVGcbuwICe+ZVkM09BC25gMqef48JT4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Nf84aPONeKI+dC1o/ClC/pB2GaSvEKJX+rijuYtRo0eI46BBYwWlNd6fWbK0j2QE7+SxAU4H5Y1+LmDpsrGKbkiE+b/nZecwsh17sJHR6T26tdt+EBfKHdDOjS756XAcTZ5s7WiAt9zfzjY2TD3WPztZG8WiDdH/jcvZX2P5C+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtzuYpK0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGL3U1t/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtzuYpK0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGL3U1t/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2/SsgxfyWuM6rZwWMjamjv6eHU2cXgtGdTv8wJ/i0M=;
	b=CtzuYpK0BFKX7U0p5qXcizYzRsMOxnSAJQ1mIxlA8vSUMB76BrZ/vZurgCGIynq/kxCQ6z
	wF1z01zWxSCMqZ8nlOu/Fb6+LhTakfHYrSsgunLUhKgEBk5/z0ip4R5pkC7t2NitBz1QoX
	y2wubDtd5V6AjT2hSYWHzqvUfROtd60=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-4Hj6uCjmM2ucaM2wAmzMkQ-1; Sat, 03 Oct 2026 05:55:22 -0400
X-MC-Unique: 4Hj6uCjmM2ucaM2wAmzMkQ-1
X-Mimecast-MFC-AGG-ID: 4Hj6uCjmM2ucaM2wAmzMkQ_1791021322
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1624abeacso4401255e9.3
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021321; x=1791626121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T2/SsgxfyWuM6rZwWMjamjv6eHU2cXgtGdTv8wJ/i0M=;
        b=IGL3U1t/at0vVl74+S2jKer7cMaM/xsptwCUUHlfWnJw/ZPejPn3DHzzG2AYWREHrH
         x957Q6Az5fHyJkUT5xcbQs/l1TtOkh0uJieA6Tb6GxklxJ5EsAoa9ipujjs4lwLXMv9x
         rVdldrvaoC0slbVyhknBXPl0f0ae2llCES8UdHJkHQqktY+CDSnyQLSjuGobkEneHhoN
         fJ8eUeFhiUItsxYjsNMYlB28i0b0TZ5D5Lmz1k/exhvkoiPMGzhAumeTWzKTkcTTtb+D
         msDZZGj7sUwrZSatEtEff6HwizvvczypKujIiCkazAcTgrZtyj9xcbfWHwgfXwlWA2er
         hJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021321; x=1791626121;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2/SsgxfyWuM6rZwWMjamjv6eHU2cXgtGdTv8wJ/i0M=;
        b=iGB4R/VnTGheHU7ltZOxQ9+zeBNgxiBPgP79yy/e1bg/vcgtZ+gg+Dek8Q3hdcw3gm
         8znSIDrtquiCsP6ex20rdM7e+fiJy+GLCDxj/wlmu74PFGVK8cAli3cwTKKcPKH8h9uw
         6QXCK3F5Kxu6lj8lqVL/gRHXxvhljkj8SfgVV/3pRhCoGbvPpMcM6lYWNs9QAsg9q5v3
         lz32rDAQDDWIlRexElVaAg1UJ2ymvbj+tCnVAO5EJTwji+BK9mxXBi4gqF7+1w6g3ean
         ulaE8HekCw4lIGF4W+c0+qk2oahEmCZveU+emiRwkJ8dp4QcBw2ipgQ4mXlNHOANk7Sp
         9i/g==
X-Forwarded-Encrypted: i=1; AKwUvByzt+RWsMPkz2gkmpSOSY9JbKeFmGZXosKDDHLNgEltd+SeLlPH4/iyOe8FXa8rEa9a4+o=@vger.kernel.org
X-Gm-Message-State: AFuF++lIzOqKUzzKrngVqi7N5MCb03ZY+FrgQBt4KiS56fZY/twuZwWX
	efyChb5i4OB0hgliBfsY7xXB3IGUsHYGXiNq+Yk4SkMLhVep5J5zhyXKcD9KCB5YDQSUmqq+bFf
	bK8enDhUT5Vvr6f/E9uy8b8/xAA7Awiwf/PKxF2rFkwOt6E+zSqCS+g==
X-Gm-Gg: AYBFou2zzJOmfLCbBOcRtb4mu22qpW6keeM15S8wR9a+xWtS9IP7GGFZPfQ2pDtDRWi
	UkT4gdkeZ8M5oIRacaQO8vCOmrJsWXUlHAwdd8Kwz1pbg7RFPMtSwQ/kVqYy2F8pzjiF7FkkKuG
	VyxC948xW8ElQd0zROuJEx7lW/hLTGpy3jGOtWwxYBg/bzp4sUAIz4PugjUE0kAGFOlRn9uRKoG
	ubNhkJbN7+4kedgjBe3oufpd/5oCzCRqGvrkjIw8Pr3vBKSJXWwA8Bot1qM5/cJkzjPYbdc8R+c
	bmCZikd76GazC008TmwjgDL5/O2/Opx7lMPUP84kUpX/V3sjsIJwYmSHjjjEfMtjJeVDVs9jWV9
	M2kMBJd8aWpmvK5GIzcUWreK+7opnye5en8UyAGM=
X-Received: by 2002:a05:600c:858b:b0:4a0:1f9e:5f7d with SMTP id 5b1f17b1804b1-4a0275430a0mr66345285e9.7.1791021321650;
        Sat, 03 Oct 2026 02:55:21 -0700 (PDT)
X-Received: by 2002:a05:600c:858b:b0:4a0:1f9e:5f7d with SMTP id 5b1f17b1804b1-4a0275430a0mr66344995e9.7.1791021321223;
        Sat, 03 Oct 2026 02:55:21 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104d58sm12126984f8f.28.2026.10.03.02.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:55:20 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:19 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_05/10=5D_ice=3A_report_VF_tx=5F?=
 =?US-ASCII?Q?dropped_with_tx=5Ferrors_instead_of_tx=5Fdiscards?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-6-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-6-poros@redhat.com>
Message-ID: <42067B5C-78B8-4580-BAC9-7E03520EB167@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:47 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>ice_get_vf_stats() fills tx_dropped from eth_stats=2Etx_discards, which
>ice_update_eth_stats() never updates because the GLV_TDPC register it
>would come from is not implemented in E810 hardware=2E The Tx drops of a
>VF, such as switch drops on an anti spoof violation, malicious driver
>drops or TTL expiry, are counted by GLV_TEPC into eth_stats=2Etx_errors
>instead, so the VF always reports zero dropped packets=2E
>
>With spoof checking on, a VF sending 60 valid frames and 30 frames with
>a forged source MAC shows:
>
>  vf 0 =2E=2E=2E spoof checking on, link-state auto, trust off
>    TX: bytes  packets   dropped
>          3600       60        0
>
>Report tx_errors as tx_dropped, the VF stats have no separate error
>field=2E With the change the same test reports 30 dropped packets=2E
>
>i40e fixed the same issue in commit 50b2af451597 ("i40e: report VF
>tx_dropped with tx_errors instead of tx_discards")=2E
>
>Fixes: 730fdea40bef ("ice: implement VF stats NDO")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_sriov=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_sriov=2Ec b/drivers/net/e=
thernet/intel/ice/ice_sriov=2Ec
>index b21279f0f5f1e1=2E=2E8faddf8ba0d523 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sriov=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_sriov=2Ec
>@@ -1640,7 +1640,7 @@ int ice_get_vf_stats(struct net_device *netdev, int=
 vf_id,
> 	vf_stats->broadcast  =3D stats->rx_broadcast;
> 	vf_stats->multicast  =3D stats->rx_multicast;
> 	vf_stats->rx_dropped =3D stats->rx_discards;
>-	vf_stats->tx_dropped =3D stats->tx_discards;
>+	vf_stats->tx_dropped =3D stats->tx_errors;
>=20
> out_put_vf:
> 	ice_put_vf(vf);

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

