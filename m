Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A43F99E3
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021381; cv=none; b=Fu5YUG8m6DKGEB33qlZ1sTa98vNCGcbvrM9vWhPNFck9IiR/sG0/MM+9EpHvJTImAG4/WgWtc2HBmTMock3CRBOJRYrzrhAQJPyUP+Pm1UjZ+4S1vSkzsofIilGOBty8j6zCCw4WEuUkjseoPZbN3M6rqD+R6O8YVhuOlqET5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021381; c=relaxed/simple;
	bh=yoxZ8bT/2tnoW+aoZPk3W+kJx2jfdtxBJMrb8XM8I9A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=c1SJ7barP9ykh4Wr42Mklo0dHomo+Y8E0Q0lDmBeFp45O9KgfPWdU654FXx4wcmSzTbHFug9Ju3MURyAg5Uie5xFq6jeoQoGRrGgkqddIofFcB4pbujxwPXKGTNrYwKtaEILcRlNRTsyX9NYPWGb2YwjheZmCBCEVVx00I349QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ooi0/ZCi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yfl8fz3r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ooi0/ZCi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfl8fz3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i118fgept/V5HNHIJAC4nRHOFN2iHEPIInJ6/LxCKAc=;
	b=Ooi0/ZCiFC2wP2moyqmETTm+CALGbv/CPhFEwL9qGhAlwgSyRwdXCVqBX25rl5bwdbuUeX
	EVcv25syOKTn28C13lE8aH+kTpZyHIxIVaPzd8TVLGJfDt92AEsDaK+mKs2N6Gh9XXny9/
	ejibjwFp3PaeVB7/TmljiZW1KfFdtt8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-v8mQrTePPliGQp3p49jJww-1; Sat, 03 Oct 2026 05:56:16 -0400
X-MC-Unique: v8mQrTePPliGQp3p49jJww-1
X-Mimecast-MFC-AGG-ID: v8mQrTePPliGQp3p49jJww_1791021376
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49fcc575709so4566045e9.3
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021376; x=1791626176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i118fgept/V5HNHIJAC4nRHOFN2iHEPIInJ6/LxCKAc=;
        b=Yfl8fz3rAreF7c+1ltgHTRz5XKmdvuNVMpBLRl3eld+vG831+ZJR1p8+RchwLo5WvA
         cO4349w6TXrGQQ5NN68ElD8VB16O05noOx3oWLYrHJiLFVefach+QE3VN7/jNcqQwcGD
         JB24Jx2a4RXrneXVMRpEs+v7PsCv+h4SpjoHoOgEV31iEVWbcNtTy+sil3aGQe2MyMyZ
         JNtkBl8zBQWHaEN4Swvp8hYrDSvKDoqwE9N4fRZYEXv5bOXzXcnVa3xJ6fxnN9D6FiVI
         WCJpg1ulrpiXgH1Wgi0jjxZAkX503yQlegJJ+uMIdz0htf36q4z61kkivlIfmZ/rcgAG
         /slA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021376; x=1791626176;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i118fgept/V5HNHIJAC4nRHOFN2iHEPIInJ6/LxCKAc=;
        b=ssYY64ty5BWihivpGRXz8yWCrC55VGTznhX8VpGFgFL+FsJzG14FMSm2oJBL6g5LR9
         Q39sh5Slbp1U/yYFUUf6+3/iuw8eaMZAF2i789Uz1jS7xL5RPBCnkwVUIEr0L7u0KMl2
         UKLo4cP4RtjlKDAJFWsT719kC8ndZoe2kBJGPA+fCDifD9xMeXsMtDD8gCm0UAiarpg1
         t86vg+HCkoOU36RZv+o3dKFNj2kxvmG+Q/ooxRzJstZ3o5OZVMIZF7i8ncpeWX2yyUzU
         XS4wxM9xyn0ZOk0qa0KQ9yGeRnbvUjzNEBDbcIcRMi1GiFRSo4UK38yaNntQH7qqWxEg
         3XeA==
X-Forwarded-Encrypted: i=1; AKwUvBymmir5JVxvBlowylXuIr4n4z4H13yBlJ9Dqg1CJw0Vt3x7iirRSL8uhAtDjTvZpssT278=@vger.kernel.org
X-Gm-Message-State: AFuF++lGIsQz1yWpTicsMdOhVfF561aOyuBz11uNVk6F7NzZg8EgUkWV
	ubMLWSgyjuoO+KeM9hTOn+7IO5YWXkzW8m4zg5bdPxaHhOCit13Wi2Dr2Cl/aV/DovahHu+8pYm
	t9DboUGrOKe6NnpzpuIVmlYaGqlqiMLigM5uqirXKvNcDeq+Dh0UBLQ==
X-Gm-Gg: AYBFou3wSX0JkLd35XiRsrFfOIbzrmyr4MpRSVNu27OoeeDH5p8OX5+EU1fs4fF7DXY
	WZLA8xx9GrBvombDnKn27QRtyOcDnUWbkC4ec/KjyFbgIlX+gR39WmduiWyXdNjHllbHRmMzA2t
	/XKvMnsPo1wN7qFqgF1oK8fdcE1OYdwBv+n/D+IUhQVTsSOCnPgMI7swkSQbQSPwVN0yXWZU64g
	opFz+8aYLOJ6FJOG8CB2+VjyPL3c6WopSq2RVVXga3PMGrBdrAA/Ez612bq1/mEtnHv/O1WhZ+m
	DrMuOLa9NPnLAxTI0r5HVugohxU8yXjBZzuA6OQTiHkeh+uGEk9dilBfnFAOogj5HE1VuarUwJM
	6yE/iN49GMtRms+rezVmgGmjIz3vZ+NWwS7X4ru8=
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1680b5402mr30628125e9.2.1791021375700;
        Sat, 03 Oct 2026 02:56:15 -0700 (PDT)
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1680b5402mr30627735e9.2.1791021375223;
        Sat, 03 Oct 2026 02:56:15 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm121786205e9.2.2026.10.03.02.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:56:14 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:56:12 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_09/10=5D_ice=3A_program_multica?=
 =?US-ASCII?Q?st_magic_wake_before_tearing_down_the_main_VSI?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-10-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-10-poros@redhat.com>
Message-ID: <5BEDFB6E-4B19-47EA-9CB8-893CCF103D49@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:51 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>Since commit 5b246e533d01 ("ice: split probe into smaller functions")
>ice_remove() calls ice_setup_mc_magic_wake() after ice_deinit(), which
>frees pf->vsi=2E ice_get_main_vsi() then returns NULL and the function
>returns before it sends the Manage MAC Write command, so multicast magic
>packet wake and keeping a locally administered address across the PF
>reset are never set up on shutdown with WoL enabled=2E
>
>Program it before the netdev and the VSIs are torn down, as it was done
>before that commit, so the current netdev address is used again=2E
>
>i40e had a similar problem, where the multicast magic wake setup ran
>after the admin queue had already been shut down, and fixed it in
>commit e661414c98df ("i40e: Remove duplicated prepare call in
>i40e_shutdown")=2E
>
>Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_main=2Ec | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main=2Ec b/drivers/net/et=
hernet/intel/ice/ice_main=2Ec
>index ceb9fec2af21e7=2E=2Ea885b3e0baaa5d 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_main=2Ec
>@@ -5456,6 +5456,8 @@ static void ice_remove(struct pci_dev *pdev)
> 	if (!ice_is_safe_mode(pf))
> 		ice_remove_arfs(pf);
>=20
>+	ice_setup_mc_magic_wake(pf);
>+
> 	devl_lock(priv_to_devlink(pf));
> 	ice_dealloc_all_dynamic_ports(pf);
> 	ice_deinit_devlink(pf);
>@@ -5466,7 +5468,6 @@ static void ice_remove(struct pci_dev *pdev)
> 	ice_deinit(pf);
> 	ice_vsi_release_all(pf);
>=20
>-	ice_setup_mc_magic_wake(pf);
> 	ice_set_wake(pf);
>=20
> 	ice_adapter_put(pdev);

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

