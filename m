Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADF3D7D7E
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021367; cv=none; b=YS5pLAIG7QCpnZBUn3aNU2obAACXsFmC7irEf9o6TZ75RHWKB/PrlS0IAWBRbDQndwZi2GfJBbINpaPilEnZ79cAcUwL2tordyOETyeN/zRFUKFES2Rst6fvMNC0wUqkbtm/zjAquG/SYSRaxBOfWMK8gpCQ+8hyxY0ZbOQMQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021367; c=relaxed/simple;
	bh=NYHNZxq7Oq04CRUEjnX4HIYuiGcCOaN9Z/rNxN3m02g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NbwPV3H5MI5qKL9boOmzNBbwe8siYd1fQ4XZMuvSpQQwEGXhTKHEM2Qmm//rI8gM960hc2kE72ysuMvzAUNlMZSJOqw63y5/t1jePN3DckSccFKSt7ou/nw9eLb38BJ/o/VUHPxFQPTOSaHkVbORsQ6EPaDhOFs1J1j+1cUGYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzcgoJxZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4BmtAYW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzcgoJxZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4BmtAYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqGVpdSP2zcszRi0/wYGQr7kElxokpmPd3Y6IXpKB/A=;
	b=BzcgoJxZJekVkF0/kl0svbFc8fsHVkDibOmOeGUvoq2gciK5efBg092/mhfwvaPnSocqlJ
	8pzhnnoXndooRNmzT4H3Mele0z1dt5gRZLqAUoi4m75btlvZpvp3uJRfpP6OoRgZK10YdN
	zqvbFjqjU4a9m6wwe2v8JfMDkKCCsew=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-6E_qk7ccP8W4e0K8a0D8hg-1; Sat, 03 Oct 2026 05:56:03 -0400
X-MC-Unique: 6E_qk7ccP8W4e0K8a0D8hg-1
X-Mimecast-MFC-AGG-ID: 6E_qk7ccP8W4e0K8a0D8hg_1791021362
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48af5a07314so188562f8f.2
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 02:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021362; x=1791626162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YqGVpdSP2zcszRi0/wYGQr7kElxokpmPd3Y6IXpKB/A=;
        b=E4BmtAYWR60DvHyyqiORFCVZTsV3qg+ZOq89CXIBOd0FHEhKD2s+I3KgdOCxPiAA8+
         KyUM5bOOLP+9MFoE4QEXO/70jVUlV/tAcVIRJbEuFE26tZypuPsgs+q6b4MvPan+ANTx
         xOEfWaXUO9L0sE+bH1Iszj1qdzCPf6HupdA1rVAPqSCX4IVHgdm852msfdhuV0A0D6vy
         3ixiJnHTnhTsSBqvHu8SN8NeaAlBT8YQuFAbr4ZpEb1byX4cqXnVPOMEz4gJUGXOO7+i
         jLYG9SJiw6Fe8Ne8rFbNOsv2KDHgCzjwtCwfhkoFbehGfJihN3oSQpv6IpzPVbm+mBlG
         mpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021362; x=1791626162;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqGVpdSP2zcszRi0/wYGQr7kElxokpmPd3Y6IXpKB/A=;
        b=e07HWISUEYhXIFKVsvLxw6cSOcRYSgJkOPJmtNeEi3EAISPeO3PwOHz5bI1eEONx4K
         grlWwM71RmTXCzFVrMpnmuEV9+Q8lCSQEXHc06qIufM+bYty08jsPgdDZEeXE24WNg44
         zrsSUH/IG30pYZ+k7ooycpHROfLphANaamnnLeU4x2iXrOnPOKWZDrDsTw8Zj5THX88g
         lY2eLc9EnMUeQvzYmhrK20RQ+srHF5Hk1VSgl2Jo9dQniIiwL14riSEGVfOJhRtO/e9C
         vW+R5veDEwqrAAEHeRKufO6RAGWLxVFEgxN0f/l3IQPzPq9fTmPlNOCXmox1AKxmLNBV
         MkLA==
X-Forwarded-Encrypted: i=1; AKwUvBw/iqTzt49GukWOYyiLp7E8BoqqtClNnrqV97ewWAbGmxUUQtGPS5rP2MqH8nL5pAlx+FE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmi8uW9Qox99YqcWyJhPUJbfEbj1IwFR0gsibkQd/O4eS39+qJ
	LW6BlW1ORtJ1LfHnZulX0zlUYpw7nr30BqUtW70BvopE9L3AcEIjxo/l8TymtRUskTf1qR0JXLd
	deQAWYRdvmdRQeHFvSRIDOmWW2eRw7Ybo/BoTUw3RNUX9GC3rTjeT4g==
X-Gm-Gg: AYBFou0REPCunTkN4CNlhtnM3rJJu0AsWl9NZP631MuTB1pK25sr9sUbUxJe/trXxqm
	i+0FSth7K3FG5F2MluG+Q1LMFZ/ZWQg8e+nRCpFaYDlIDxQMsekLZFRQJfhjsqvzDrmc/aSjTFG
	9cDDnAD4kznzdlyuorzLe++GSIKUN4uJnBAzam0sxefUjE8nBmAD5/dRF/AK/1oArNVkiNH8eNf
	Rh9dPIxJSwtzh9XzrqBnRIj2xAUImQOadrwtuufiwP4ETMARUVs9qrCItA/mtr4SWxfDiHkLa+u
	oNtegif+7Qn3uVV53KfkTJIKnTT75hegOBQZ7F8ezxEmz7j/Z6u541o1ZB/BBXgD481ueQsPLvs
	RTlcrN/qXXoIZO9Tp0t/XPsrHr4hiNCEx0PZhqPU=
X-Received: by 2002:adf:f108:0:b0:48b:e50:715a with SMTP id ffacd0b85a97d-48b1273e612mr6550001f8f.34.1791021362465;
        Sat, 03 Oct 2026 02:56:02 -0700 (PDT)
X-Received: by 2002:adf:f108:0:b0:48b:e50:715a with SMTP id ffacd0b85a97d-48b1273e612mr6549985f8f.34.1791021362095;
        Sat, 03 Oct 2026 02:56:02 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f06b3sm11631234f8f.11.2026.10.03.02.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:56:01 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:59 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_08/10=5D_ice=3A_dete?=
 =?US-ASCII?Q?ct_a_PF_reset_that_does_not_complete?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-9-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-9-poros@redhat.com>
Message-ID: <07E47138-2DB2-4824-A535-03CA9CD2F73A@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:50 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>ice_pf_reset() polls PFGEN_CTRL=2EPFSWR for up to
>ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT iterations, but
>the timeout check after the loop still compares the counter with
>ICE_PF_RESET_WAIT_COUNT alone=2E When the reset never completes the loop
>ends with cnt =3D=3D 5300, the check does not match and the function
>returns success with PFSWR still set=2E A reset that completes just when
>the counter reaches ICE_PF_RESET_WAIT_COUNT is reported as a failure
>instead=2E
>
>Check the PFSWR bit read last instead of the loop counter, the same
>way i40e_pf_reset() does after its poll loop=2E
>
>Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_common=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_common=2Ec b/drivers/net/=
ethernet/intel/ice/ice_common=2Ec
>index 04633103e3e610=2E=2E0ffd6b5b81239e 100644
>--- a/drivers/net/ethernet/intel/ice/ice_common=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_common=2Ec
>@@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
> 		mdelay(1);
> 	}
>=20
>-	if (cnt =3D=3D ICE_PF_RESET_WAIT_COUNT) {
>+	if (reg & PFGEN_CTRL_PFSWR_M) {
> 		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to complete=2E\n"=
);
> 		return -EIO;
> 	}

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

