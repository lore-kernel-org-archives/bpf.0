Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADA3F54B8
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692873; cv=pass; b=PPNEIo2Q4YoFniVGCLK3Op7b4O8e2t1I3cYmg/YizoSlofieVw8IQ9HLJPpIze+ZYOkm3DciOqomkgXwdQwmsA5SGaeCBO0++zS345Jtui/8w2l7FCM0QGRa/8ATn8MbCnciK7aqGv/+JrsFHJfYnqOdGVMtwD8+7q/vkozdnFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692873; c=relaxed/simple;
	bh=vHamnbqklu8TjhR8P8Zkhm2WSURRAaDxDSdZ937O94k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VP/WbvPAnJ6vqQirg7mDQhxinZ+a9d22ZQKZEO0Zb8xILh7ZjvOhstyGd//LQ/rCzCiJWco5Ro4S96rURn0ASTLfO7xvsNqaAUd1nHL/oosHFC/F0Jh5ZEtmDtiO2KOtDvn1FkJskA+C+9R+Garrb93JkCEjDBj59GLzM7Y0ZWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PTUgCMJ6; arc=pass smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PTUgCMJ6"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso69761a91.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 13:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692868; x=1774297668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXzu3AiykcSnkrt6kRFoXygfEMlZtFrOOtdBsesf8SA=;
        b=BcuWJj7o95FRRsHaagko4HFBrE5u64EVIBi2Z35o9Kg/qSNvtfoLB154yVD3oIoyfS
         SA+byvwQZYRJTlOT8jxThC5hDhBRBxCAEz3vCntZ+K7+bPMeW14Czg4kHicGOR/gHWuZ
         IBJxbbJlYXR6JHzuK8tnmJpmgFxJqXFqvHhLd/ScXKxGDw8yT9FMGlkv8/dIzJR6PWla
         uSAYrl1XFn2JmyebjXsyH/ZrBqJNIx15JnMqVroESj1vib9HpaN8L6wIk/p083Txat6u
         sAWqfAGPTtAfh84UczyfhQeVAUyw35RNxr5jKUzCoquynSEpByJ1vNYTz5bO5Ocmm0Jg
         5VgA==
X-Forwarded-Encrypted: i=2; AJvYcCXSGCGPfTNj0gqzFJdW5K3UeWxZMkyGECfvKj5lGNstIEtmyINv48pTw+wEPunv4lR0VKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxad7yvQrObwCg/GyRvntVy0ryC9vw6vBNehdaFrDWSKIDvX0D0
	RMKFvHYki53A5U8YUfbq5uwiiUBf+2Vtyn/IQnBeemlPJ0wHhSHsWCGnAytbQFDT3pufqeNFFou
	ku2eqScRoHZo5ybb9AbaIx30EO4rDsUGE9Ze+BGLrOuHlaNAedQvxD0nJ7Q3OJzVbCNlkKYqeSf
	29k2t0qL1MHFlypgzDzsnYRnFytFk05lTk1FPZ07xLbpkKqmyaFCGVRXLkhqSFCANTUj5Gr5j2I
	aMd7ytKtGhIew==
X-Gm-Gg: ATEYQzwezY+dfxqj6QaGWWpMiW86ozROyufp4ZujJ9qHnfPRQzK8KFlZmIDtYg6rfxj
	L8BAeco+sHbxr8XG1x8m/hPHYFqPZ6Ek43qS/HftoZ1w6FXJJrdsRdQkoAiSs43LEsJ4IFsvwAD
	aK0wHpytZz1jvWwWfBiqEh+DD8iivrFDmrNf9GlpI+PoFEf2EkHhCbwLnLZkyM3+/H97X1E9lWa
	rmhFSy0KmMJ7wvCz3rZE/be/LfLnNR31lH7YjsWHO25y2ZxTqXwmO9kHwaBimZ9/da56IqOjgZa
	jvO7Dbhu1yJABEQkWDSyZVLLmdUJt2iKQza75rizBkdi91wcQtPYTGF9aFXF5K765mwtIbhVGRQ
	1mrWxzZxbFxDIsHLVtb0Xs9PrkMgOAs/sZYh3c6Y0AC6roLBfkH4AjlvFCyEDWo/n4MFd0IhUqZ
	ul3eMJ3Pp9zXhkL/npGyLUDhlki+eQrhNiQC83vJc4RbCeoA+B2O1hulsy0pSy4H4=
X-Received: by 2002:a17:90b:2d8a:b0:359:8957:7285 with SMTP id 98e67ed59e1d1-35bada62db6mr648823a91.3.1773692868084;
        Mon, 16 Mar 2026 13:27:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35a24aa0c74sm551111a91.1.2026.03.16.13.27.47
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:27:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439af7ba802so6330069f8f.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 13:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773692866; cv=none;
        d=google.com; s=arc-20240605;
        b=Y2DRP7JU+H+HyhZBP0lLI0/39nAUr/5WjR1LvOsRJ7YqQfl6eJ3JahyL+w82klmoQf
         JW8FJTkr2hz0ZW+M3uPK7XvIy89Jy3pSHDmH3xj/fO8Givqlz3GpXxSnwIhIyfQ5YaDS
         BvbkNXOn4Mv7ZCagUgeEQTJc2CKMH8LzL63MiuVOOkVuGS/M04WWxaBZZln1/K9TDDkq
         ans7Q7PLTm4mcXDCtj4o1TitsgVN/zVznxN9OwDnqZCWR8rMbl+ESx0tIcwc7gNyYL9e
         +9bW9/GDDa+kXSqX/PknySuPbvrWkD0Oqfc9Z7Ad0qhp0FVlEfkuFFJtG8ifR1vAWg85
         W6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AXzu3AiykcSnkrt6kRFoXygfEMlZtFrOOtdBsesf8SA=;
        fh=J2GBcy8OLiCX/rdkMcb6WUgS9WBawUMvS7aukxfaDNw=;
        b=b76hCXF1MNmJsOp+n8VGS1U/V/Hvr3CR64uRs135zbiV1d2lY6KXVbcqBvnBM9IdiH
         PgGSzH25iLRbyk8Y1U79e/dU0u/NVqxnMyK+M7hY7Kpp5rsfOj1VE8focN2r6Ki209gt
         g3CU2PdFk76jbvxI4dAhBbFJfIK0hutSa80SMIcfmi1EifAliGDYiU5mda500PHm7vjH
         Yw0mW7ox/clDmBuZRHaINiFMnByIRtYR8UxJDPBCESdAT6J2Tttg6MIotGSK0TxJev1X
         YFGpum1L8z1xGE1PxETlbKQrjc2MmLU//Jp49UzDHdGTSGEAQVqrt1tRd4wSsZUIBYLy
         V5pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773692866; x=1774297666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AXzu3AiykcSnkrt6kRFoXygfEMlZtFrOOtdBsesf8SA=;
        b=PTUgCMJ6fkUpwiE96GqFpvlkybng5sQeqKNbDjFsbWlSlcqn84epZko2FKh9rFY43J
         4uTV6wYWUXMdtWVLDLdKfVeCOY84+L/lu4CyubQWurePAiW8K7QbA8libgrVHCdMzbqm
         vAPNpnMuqktL8esOaqg3C0cRYOQnBnaZvo28s=
X-Forwarded-Encrypted: i=1; AJvYcCVjWXniY3pGLe/oaOHauO7P4OuCuVdkRioi/7Ud6DtAnB68Ba2pGTVkZlhWir7oDOizJdU=@vger.kernel.org
X-Received: by 2002:a05:6000:2403:b0:439:c5cf:fc73 with SMTP id ffacd0b85a97d-43a04d7a050mr25499244f8f.12.1773692865780;
        Mon, 16 Mar 2026 13:27:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2403:b0:439:c5cf:fc73 with SMTP id
 ffacd0b85a97d-43a04d7a050mr25499179f8f.12.1773692865235; Mon, 16 Mar 2026
 13:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
 <20260313222206.778760-3-jitendra.vegiraju@broadcom.com> <abSaKe3d4fcBMqLm@shell.armlinux.org.uk>
 <CAMdnO-+UEb8sVf8=Aj7G6UgY-DxWe3bFYbSbKJRdU4woEX+dWQ@mail.gmail.com>
In-Reply-To: <CAMdnO-+UEb8sVf8=Aj7G6UgY-DxWe3bFYbSbKJRdU4woEX+dWQ@mail.gmail.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 16 Mar 2026 13:27:33 -0700
X-Gm-Features: AaiRm53K7fiQEZkpJI-MOvV-cHRkeznqwMJWGxhDHPBRcNZi_mzV70LOImU7VIY
Message-ID: <CAMdnO-La1d7AfqLHPxTX0Y3_17Cpn6SeAqFgW-vJUg+2OZp-xA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/5] net: stmmac: Add DW25GMAC support in
 stmmac core driver
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rohan.g.thomas@altera.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, me@ziyao.cc, 
	siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com, 
	lizhi2@eswincomputing.com, boon.khai.ng@altera.com, 
	maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com, 
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org, 
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003b05e4064d2a0d87"

--0000000000003b05e4064d2a0d87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, missed one answer in the previous response.
On Mon, Mar 16, 2026 at 1:14=E2=80=AFPM Jitendra Vegiraju
<jitendra.vegiraju@broadcom.com> wrote:
>
> Hi Russell,
> Thank you for reviewing the patches.
>
>
> On Fri, Mar 13, 2026 at 4:14=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Mar 13, 2026 at 03:22:03PM -0700, \Jitendra Vegiraju wrote:
> > > @@ -42,13 +42,18 @@
> > >  #define DWXGMAC_CORE_2_20    0x22
> > >  #define DWXLGMAC_CORE_2_00   0x20
> > >
> > > +#define DW25GMAC_CORE_3_20   0x32
> > > +#define DW25GMAC_CORE_4_00   0x40
> > > +
> >
> > Do these live in the same versioning numberspace as DWXGMAC and
> > DWXLGMAC?
> >
Yes. We were informed by Synopsys that 0x32 is an early adopter
release and 0x4x is general availability release for DW25GMAC.
Device ID value for 25GMAC is 0x55.

> > > +int dw25gmac_setup(struct stmmac_priv *priv)
> > > +{
> > > +     struct mac_device_info *mac =3D priv->hw;
> > > +
> > > +     dev_info(priv->device, "\tDW25GMAC\n");
> > > +
> > > +     priv->dev->priv_flags |=3D IFF_UNICAST_FLT;
> > > +     mac->pcsr =3D priv->ioaddr;
> > > +     mac->multicast_filter_bins =3D priv->plat->multicast_filter_bin=
s;
> > > +     mac->unicast_filter_entries =3D priv->plat->unicast_filter_entr=
ies;
> > > +     mac->mcast_bits_log2 =3D 0;
> > > +
> > > +     if (mac->multicast_filter_bins)
> > > +             mac->mcast_bits_log2 =3D ilog2(mac->multicast_filter_bi=
ns);
> >
> > The above seems to be common amongst the other two setup functions.
> > Maybe there should be a helper for this?
> >
> Ack. Will address this in v8.
> > > +
> > > +     mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > > +                      MAC_1000FD | MAC_2500FD | MAC_5000FD |
> > > +                      MAC_10000FD | MAC_25000FD;
> > > +     mac->link.duplex =3D 0;
> > > +     mac->link.speed10 =3D XGMAC_CONFIG_SS_10_MII;
> > > +     mac->link.speed100 =3D XGMAC_CONFIG_SS_100_MII;
> > > +     mac->link.speed1000 =3D XGMAC_CONFIG_SS_1000_GMII;
> > > +     mac->link.speed2500 =3D XGMAC_CONFIG_SS_2500_GMII;
> > > +     mac->link.xgmii.speed2500 =3D XGMAC_CONFIG_SS_2500;
> > > +     mac->link.xgmii.speed5000 =3D XGMAC_CONFIG_SS_5000;
> > > +     mac->link.xgmii.speed10000 =3D XGMAC_CONFIG_SS_10000;
> > > +     mac->link.xgmii.speed25000 =3D XGMAC_CONFIG_SS_25000;
> > > +     mac->link.speed_mask =3D XGMAC_CONFIG_SS_MASK;
> >
> > Is there any point populating link.speed10 and link.speed100 ?
> > You're telling phylink that 10/100M speeds aren't supported in
> > link.caps, so these speeds won't ever be used.
> >
> Thanks, I missed this. Will remove 10/100M entries.
> > > +
> > > +     mac->mii.addr =3D XGMAC_MDIO_ADDR;
> > > +     mac->mii.data =3D XGMAC_MDIO_DATA;
> > > +     mac->mii.addr_mask =3D GENMASK(20, 16);
> > > +     mac->mii.reg_mask =3D GENMASK(15, 0);
> > > +     mac->mii.clk_csr_mask =3D GENMASK(21, 19);
> >
> > This will be the third instance of this particular mii data setup.
> > Please consider adding a function to do this setup.
> >
> I will move this code segment to common helper function.
> > Thanks.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--0000000000003b05e4064d2a0d87
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGbTCCBFWg
AwIBAgIMGHX6KxYK3WW2YyprMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDkyNTEzNTAzMVoXDTI2MDkyNjEzNTAzMVowgbMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEaMBgGA1UEAxMRSml0ZW5kcmEgVmVnaXJhanUx
LTArBgkqhkiG9w0BCQEWHmppdGVuZHJhLnZlZ2lyYWp1QGJyb2FkY29tLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAKWV+9PYvG4njqRsbQas79f8Q46VL7b1ZxvWT6ik6VMbdRZx
tfpfZalVXksqcb02/N1H7UA9V04cV2q97FkSr/KxeFLMetPb3cVJZICg23IRO2NTPdmgPFzwkPTo
35h9h/OYLgh3/9a1nTsC2xqJa8GtohD5+42rsskGcI57U4n1r1L4R5IL9ypSqDxX/xVEAdGI5FTj
VgvoZC6iuEbnez+yO8TT3wun9b/PQowOB5P0CwIFv7ERW0S1s6B8yrbsoaTrz0vQaEA786k1pZkg
ykC1+zXq/iTyZuPP4B4RkzFd43Pw+GAH0Tt2nx5V4rNisJHeAVNU92Gj01cEg0I+FnsCAwEAAaOC
Ad8wggHbMA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0
dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQw
OQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAy
MzBlBgNVHSAEXjBcMAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIw
ADBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKQYDVR0RBCIwIIEeaml0ZW5kcmEudmVnaXJhanVAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1Ud
DgQWBBRq5Jlxz3MqC+zEgUxK566xEc2g3DANBgkqhkiG9w0BAQsFAAOCAgEARXrmeeWA31pp9Tr0
M6mOlMv+Pr2raES4GzPSyftvxf6tBQCBNaqi6LSbyusDYOj3mG9bp6VeVn+68OxNY9iNAk+ujtId
f3+30BlZOQ1v8z9u2peUOUtWI60y2MxhdH0X0n2H+BCGvUOFqs5z440jqqy1HsscZTXHB7FEZmVP
fyD+0Z6cxyh7WNC6+BgLiFwf8iqmAbu7Yb1sGTUGyS5gfYEjJbF2PJfwNUcJDd7eS4w5Ju5mK5y7
spgjH2/JmDgbkpSk9JyuWfjGZIg4ah/q2nb6UMd1XJb6gLQZuzPOI3SgXPvd8MHGjKZrX2BHOBSC
bJJ8rp4w4a9QMS6dde2MFObusxkZAft4tUnwo+ProchHs7iA85sL7sWEZhAmjmKKCpECpEfZm0+/
hpvKQV3AZp5vBstb4IVL8QmLj8beDVHYnNhEicsSiG1wW7zSYyBnmGbFRrFQIJnJDWPjTZOlVEyp
T1ShrXRCtqJpOt6rgg+rFEY3D8j6/bAkJXnmKnE2LZ0YyrrKk7eC6UfNNimx38w3NWchtcGY8zJn
Y/1/C9Jv/mWm/2lK8nvusOFxhKmbG83Hx8toQdZ5F1kYk6zAWjfB7lwXr/En9mCmLieJ18hen9EK
qbYyUkmCmuoLi5GXFMJy+iQv6DgMVQ7CACagybU6FUrmL9lVa+A6caBEEh4xggJXMIICUwIBATBi
MFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9i
YWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwYdforFgrdZbZjKmswDQYJYIZIAWUDBAIBBQCg
gccwLwYJKoZIhvcNAQkEMSIEIEmds8YruXz+kLzusi9PvUSj4X/xjlJST+Hyz+O6WN5QMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMxNjIwMjc0NlowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAG1Ud31IjVSh
QFZsf6AaDp7pdhVd8kOhGr6bXM6EFiH5Qps9qB57B034/QB2FI5yq0Gp2/JGfIWbrw9c9EbZ67Rm
M4HOoEBQq+cDrQc5+lqMYDVnxmspJqeVC9lMH+MjbcIsONAHoRYoLum3bbQxnjHgHc7JX5PjSW6S
ufSXY8KBrEyDGVCz7/leqfmAnlNAW4e/Xayjcfcwsgt3UykT/bZUkg3SZjQzzczws9jixWlFOYqj
lvp0iRRkK/IB/abdrpKo11OZ7IgboALFQz/7NMlVzIIp5sgTmF77kQ43ujw7kxHjCdqdHakkI3o9
l5FvQ/i6WnfhUmz6yCP+vv5L2Bo=
--0000000000003b05e4064d2a0d87--
