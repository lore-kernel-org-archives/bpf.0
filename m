Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7E46D2CC
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840966; cv=none; b=SAmIIkxB9s+qOdCzZKgp77myXjyGQtJfdluMNz90RvjwiuOqaify1fwo4i0CHGBwhArDd5OyIZPjgIc2S5fLCBCAbjUzSLhxBMQjFsTzzge/s9eWoxCbqrGONnn+SQlFxnMjq61DO7QKGpn9o32XxmRYjqyHlj2LsD/gmwlYsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840966; c=relaxed/simple;
	bh=7nC6VU1e+EkD71INuWX4LMYsCXiWV7QzlelrKPrgVfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy2yj6ktCPq+UTKeD8nhJuhSjXSnFiMGGMnyoMhhmevEso7F8uSyPJbxcvrf+t/Tl4dx72It15lyU1qH9eRZaJrYewho3o/yoVAqnmiXxe6cqBpQOLE+Bsj+EbzGQ0ZDY8wQrmCqia0g50uHIzc/KkiIo6ABS5tTdvnp0nVTx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K5C3bsDl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ys9ak0ot; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K5C3bsDl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ys9ak0ot"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xOSA1932341
	for <bpf@vger.kernel.org>; Thu, 1 Oct 2026 07:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fcJEazZnT8uURAanK1Vp1Zd7
	zXkiTHBM91KnjXvtuLI=; b=K5C3bsDlHExr54kPSs+k42C1Le03azP4hHEclWjd
	oPVQ8l4jJl0G4i05tME0aYbORdAoY/Zdz3X7IFOJ3gkymDNrQcgkzGTVKhUPKGkQ
	RIzSjZrPQGcu7xwV42gRDcB2eltkNnnD6zCd6s8etYHjo+EV07hwVzaZqVRp5xY5
	qKOmhaOT8zapXKDkYn4Or+VadKDFuqtebUsLwVqeKwgyplsi3AedJMToxoROlnHc
	DW9t9YdZTZlE22m6jiuNzjtZY+SeP6ctXmJppbhA/sZi3HnKFwkRbb06pWEHLGE1
	ySBXtUaKRge/6R13V2oQgIIALQp27IZDO9AMPfJKN9V6cw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh59ny6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 07:49:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93c5ab5c136so855442085a.3
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790840963; x=1791445763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fcJEazZnT8uURAanK1Vp1Zd7zXkiTHBM91KnjXvtuLI=;
        b=Ys9ak0otBk9M+WgdSXAjwwOAyzfUd7Dmq8L7JOi5Svn6CbjQ7V+byMaZRo/J5abIph
         IxEH13eFsZuuNMfYIGAmlSKxe4NnyD0DdrNdSh1zlTAHkC68bFvehQYnHRHuoIswX/ab
         M17ctVClfxnJdoNEpYZlcJ1O98A4RtemKz+9wUPichs5ks7fA420wQbnFuAtF/OWjdmg
         oJYZ71u++T4wl2yj7kRBxB5alkhJLvwph8mhkRroOGxVoC3pEUifu7uHlCfLwyfXeJuC
         P+isZrS812qQ9CLIckQAAm3gvlCkc3m6Ij1cuTUD5jofKetm9EhduFPSUg1jOxK78q2O
         vrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790840963; x=1791445763;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fcJEazZnT8uURAanK1Vp1Zd7zXkiTHBM91KnjXvtuLI=;
        b=oEwlfEQS0+gEW8Mq95Dtof9qspzTqNoDxR+S/RtBMsnC7HNRbw6cl8jdynf6/VKd9g
         VCyrAITul4VQEY+a/kucugJtibqKV5ZiQTI9Sw+dckUG9QikMwahdwm/Ljs1msNuLCz0
         qyZvv9USiaSeH0sDdANbjVgT8naF+cbTzALeZCzHw730QCh505IN6c/GeD11SpdDpD/e
         yih/Vpf81scwjf0YjLzAfj9iwIz2KGDQUyNvVDjzO3FVQ7wlwV7F4D/fWnR8Bcn+HA49
         CJYjzrZIvcxJC/GTrev3QKPOEn1dPs7Bevk+lmme9nOk14ZKuGQCZahsWkA+8a6zVKD/
         iKLw==
X-Forwarded-Encrypted: i=1; AKwUvBxVjha8rhkpDdNXxkqD+BuclaJoexs9pMCfYDI27nkM0/c/JKZVgrdsAmQ48Ccln8wfl80=@vger.kernel.org
X-Gm-Message-State: AFuF++nn+/IYnJpxG8I+huiwi3Ba6w3xSR5mgVmM6YW9L9XM3M/S/5/F
	CRdwJNPYaCm/mWyg90iizr3lYEmYJXg0uLPF9rpdXQEoqKr0KZjHHm2/XMgMjuKts0LlJJjPTxS
	gAdptgg6wdZVdQ2UDTeC5+gQLvN+f1Q+GP4Q2qZBUPF+nk7KPiq7/Mkc=
X-Gm-Gg: AYBFou1MZZFrBKLrRT5CnSnk28Lj0rIbmVKthXcWaUhidCSwVHiZvlJ9ILRx+g51dRy
	ak9axsrnfnqAUQyqB0i7yvR3JutBMLesn1HMwR8w4dI4U3hpWu/Xt0v3CmFQjJadX2cnyf+tiEY
	YJS7kY1XWnZcp2fNsgeiMR5UNt+dWcDTmgPNhurpCRPUWXJPQh3MpQ03gMy9nvDUWD0LbqVh7f9
	kyOU0AQvnyaOLQA28PhrkQR3Mx0r5wHqNwW/NRDaDLL7sAGtat5ZoEuLW7GCDJyVImc4/7Dwij5
	wppQUaFq4k6nRnRHbdtBrYXRy/31nMFi20Z3c9QKvqtjmDm3Cu2fvK9bc8tjoUMJpPD8q83Yg69
	52hszZYMUZfT2Gw==
X-Received: by 2002:a05:620a:6602:b0:939:ede4:a499 with SMTP id af79cd13be357-93ca94f6634mr719058185a.5.1790840962808;
        Thu, 01 Oct 2026 00:49:22 -0700 (PDT)
X-Received: by 2002:a05:620a:6602:b0:939:ede4:a499 with SMTP id af79cd13be357-93ca94f6634mr719054085a.5.1790840962161;
        Thu, 01 Oct 2026 00:49:22 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068ff95esm4416843f8f.12.2026.10.01.00.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:49:20 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:49:20 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Serge Semin <fancer.lancer@gmail.com>, Simon Horman <horms@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Rayagond Kokatanur <rayagond@vayavyalabs.com>
Subject: Re: [PATCH net-next v4 0/4] net: stmmac: preserve and restore the
 installed EST schedule
Message-ID: <ar4QgHsclh1vWVHk@lore-desk>
References: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5O14Dw0334SoMGBW"
Content-Disposition: inline
In-Reply-To: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
X-Proofpoint-GUID: 1bRczzrhfEYSv1LQEZ0-obnyF4x_crTA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfX5T57rKyz5pLF
 2oEZ4GjPRIP5fU4BVaUKFjbQ4iBllNZXTIceSsLBYJtTUhBlSfWmvzYZ0Q83MMzXFWT4bmfm2+o
 eego1gZf3+WBOarG3WZjsUKasbITLww=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfXy+mr3Mn7n4G/
 1HTk88Bk2rhIN9KUZF0h5f++M2xfqIYgalOSoI//7dCmK5OZDtB7LlJ9Y1ywGRUN9ImrcDA7rv5
 DIz8bfV0MQE27TAGrdGl4it2+kcBS5FsNHnOpejWMI2DLw87hB7jTFjO6aoHFryVx/61sjTrFjY
 /8UhKCthVhzIDg3IabQNE6Ja6GXbHIjU3bxLYssBdM9A2INxlpAJi62k3CKf8xBQ2E8rtHG2Ort
 oilgnX/4lM9F40ZrUQ74IsELBMkey4V+VlaenrFX6hZU/IJWNGNYh7FdnKENdb3anGw83lSd/OH
 wZHmwBCL7rnSxkpKugxDv+NOsGviRg/FDMldQrEoxAyxtoFsQvpy6f23RrcZtyuVcbPkO7gglKU
 ki8JL7mTMsTJq+jQNFDwrJ7rwV8Gc0pIP8VKDQX7UbhYMfcxDfZ3eHByartuVm9iM3y8FNMRgi1
 cCCUyVK+wINfGBu3Sog==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abe1084 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=vIXCTXOdsuUdJ7saXm0A:9
 a=CjuIK1q_8ugA:10 a=6N3VuSNxPG3FNRDMqtEA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 1bRczzrhfEYSv1LQEZ0-obnyF4x_crTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010031

--5O14Dw0334SoMGBW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Continue Lorenzo Bianconi's EST replay series with v4 of the unmerged wor=
k:
> https://lore.kernel.org/r/20260902-stmmac-est-reapply-after-open-v3-0-e72=
a6df5a7ef@oss.qualcomm.com

Hi James,

My plan is to continue working on this series (the code is available in [0]=
),
I am just waiting other patches to be merged upstream before reposting in o=
rder
to avoid any conflict. I guess it is correct to publicly ask before posting
other people patches.
Moreover, this is thecnically a fix so this seires should targed net tree.

Regards,
Lorenzo

[0] https://github.com/LorenzoBianconi/net-next/tree/b4/stmmac-est-reapply-=
after-open

>=20
> The PTP initialization fix from that series is already in the base.
> Carry the remaining embedded-state and explicit-enable preparations,
> and restore the installed schedule after open and resume reset.
>=20
> Build TAPRIO replacements separately so rejected updates cannot
> corrupt the installed schedule. Rebase the previous schedule against
> the current PHC when rolling back a failed hardware update, and keep
> DMA stopped until replay succeeds. These changes do not depend on
> the later datapath recovery series.
>=20
> Changes in v4:
> - Omit the merged PTP initialization patch and adapt the remaining
>   changes to probe-time PTP locking and current TAPRIO error handling.
> - Separate schedule validation/rollback from open and resume replay.
> - Reuse the base-time helper for replacement, PHC adjustment and
>   rollback; propagate errors while preserving the installed cache.
> - Start DMA only after the installed schedule has been restored.
> - Link to v3: https://lore.kernel.org/r/20260902-stmmac-est-reapply-after=
-open-v3-0-e72a6df5a7ef@oss.qualcomm.com
>=20
> Changes in v3:
> - Guard priv->est.enable update using est_lock mutex.
> - Embed stmmac_est in stmmac_priv struct.
> - Rework locking in tc_taprio_configure().
> - Fix possible divided by zero crash in tc_taprio_configure().
> - Add missing reconfiguration during stmmac_resume().
> - Honor ptp error code in __stmmac_open() and stmmac_resume().
> - Link to v2: https://lore.kernel.org/r/20260829-stmmac-est-reapply-after=
-open-v2-1-5e5ccb185e92@oss.qualcomm.com
>=20
> Changes in v2:
> - Rename stmmac_est_reconfigure() in stmmac_setup_est().
> - Rely on stmmac_setup_est() in tc_taprio_configure().
> - Link to v1: https://lore.kernel.org/r/20260825-stmmac-est-reapply-after=
-open-v1-1-dfa80735e0a1@oss.qualcomm.com
>=20
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>=20
> ---
> James Hilliard (1):
>       net: stmmac: preserve the installed EST schedule on errors
>=20
> Lorenzo Bianconi (3):
>       net: stmmac: embed struct stmmac_est in stmmac_priv struct
>       net: stmmac: pass the desired EST enable state to est_configure()
>       net: stmmac: restore EST before starting DMA on open and resume
>=20
>  drivers/net/ethernet/stmicro/stmmac/hwif.h        |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  |  47 ++++++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  13 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  38 ++++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  59 ++++-----
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 142 +++++++++++-----=
------
>  7 files changed, 176 insertions(+), 127 deletions(-)
> ---
> base-commit: 1631d79ae57dce2c5f88ad278307028638a8b4d9
> change-id: 20260824-stmmac-est-reapply-after-open-181d70a15eb6
>=20
> Best regards,
> -- =20
> James Hilliard <james.hilliard1@gmail.com>
>=20

--5O14Dw0334SoMGBW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCar4QgAAKCRA6cBh0uS2t
rHudAQDRHrkhhNLiQEOGozztlHRmh86K2cUt6Z+4yLFiMw0PWwEA8XYf7p64JJYb
H5S88bWzi8YBwiXw36fKmolphF5lWAk=
=R8Ou
-----END PGP SIGNATURE-----

--5O14Dw0334SoMGBW--
