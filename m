Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8507285058
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692059; cv=pass; b=cso/Al88yB256XLbvl46zR3LIT0wYihzU7mG5RYG+Xzy0ikBzTBdS/AupUOTe6vqce2JCCJR+LVqa2iskbITq+aoy4jNwDC0OgG8Ur31tCcUM/IbC0T+C5u+pAhvhgUxaoLv3vTRfV/HaBRSezJd+O9vFbIwQXc+9o+xbqgkhts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692059; c=relaxed/simple;
	bh=diRDr/+5p0+/L9c9Mv4Or2wlfWAQzrXayhOS4n1m03o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaRrSAI3UOAtGAFubwKmmfRzoUc6Wp5CraOcRHK2w0hUTMe56mW2s2xxh+IL/8tYELJZA6G3DU4EDePeyM7BE/2lCU0AtIUO4KXhafr1kofBItssqwtj+Wq4KfIoUCg3VtnIIs73lwLyAfcKV2GqofGJxxrTLZekcQ4x/51o298=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HNpoObIr; arc=pass smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HNpoObIr"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2ab46931cf1so814385ad.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 13:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692058; x=1774296858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lexh0FPoUVCHJNBkP5tl4kw1j/BVfIFrb0t7ALcSJ5I=;
        b=M9dTy0TXR0NVtYYf27IW4ZR2PrAy/Ov99l02h76oM4XAZh32CMF7wYHdAvXkgkitmq
         HfyCQ8JaIZmcbqRlseQVo+1dYOMrqC9yVXsbLRgrG1nGxkJeVvS+r0D+jhOo7gw5Slmx
         HKNpnzW8q0/ojMc6GeFup7cnT8+rFt3dbC6+C5I8tZwBdIIsNsxPXxWZTdKQMHvZAbmO
         KcrIhVFgFwMv9AMy2HHcjKXgYkq1LNd85YQmrRIvq2qcU/NehQKqDCV+ZwDGxyy12wJs
         1QuecVHbkjp7jhAQoQzMFprxiToIYYVyj6ILOEPrylcPaAArpsDqTuOsar61yFUylycN
         VSZQ==
X-Forwarded-Encrypted: i=2; AJvYcCWG00e4Y58CREUCEaRuUVx85KPEKe9GYBvBKfcALHTayuf9N3TNAkkK7z30EScTuNlWxVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvtXRzFOfz4SxJGG39RzGK2qd+UKwU5hQbYjmyqjZ9pNVs7QH
	slr87TgcF33VcqWJ4KUu6P++VwOoUSAIDsUOIGqDmeXlhCKuNwMItlBbUiYxPL+9CNftnS9NSe+
	xHxowBTb0a/0c5/CxsxCIkRHipCbCQm0NBq+2OW79iuSuxWlFymy5URYSnYwB6EWGRu5QYDGNjX
	Rw6gdQ17e9XTGdHQgsttUzo6uAZiSn26SSjnvYN+CKLOgFXEKYnaINo9sAsvfRKkfi1keKyFYM/
	tOepqMCbJ3vhg==
X-Gm-Gg: ATEYQzwyCvmmneky2H34Yg0rC7F0Rlbu+n6T6KAVlPRcPuR0xs+y9sv4hXT39n3Rysq
	2yxdWWVPIUKGvUFsZZ3auIlC8DuYuPTcnsLlwDdACPXbWgLVJYYPAQX+PnaO/vU7dyeH2lMjmaQ
	nCqEiLKJplx0nplIXj2XKdn5bAmBPc6q5E7khksZYvE9FmOeW21OPaXoKye8uxHudUxBdS4dKzi
	otewH7eEA6Jt9hbrdMnjkFVhBY9Ndab1xb5ab9kFiCm8EM5nu7W0pZid6k9PHNf/9LNptiMfFV1
	13JB+2sQP+QEiPlu78hT55b+coDrtrmTyXGsLFl2APW0QNWoqrGIeM21QWLGr2cfkgrvYW7UuLr
	Rc6MOdjB9t5ttwVw+vJQqh3jjWmcYAmWl8BpwSRLCq0NZ1jr6hmuipgItpOMDAcHKYygg65K0z5
	Ut1ucsPMUwQpc12trsGEAe3EtUd0fvNkhOfHf5rQo0wbwD2jkJACrYJ4IADVy0lb+Jgg==
X-Received: by 2002:a17:903:2ca:b0:2b0:6365:217e with SMTP id d9443c01a7336-2b06513bc05mr1946905ad.15.1773692057942;
        Mon, 16 Mar 2026 13:14:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2aece7e15d9sm14195565ad.34.2026.03.16.13.14.17
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:14:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b3e0a73f8so2318978f8f.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 13:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773692055; cv=none;
        d=google.com; s=arc-20240605;
        b=G46KpO+ZZGgoJDJ//ABAuM0xNrtS98jemC5wQFFm5vrS3/WRmO/mfar96xABhHL7/t
         mI/kIZOLgQZtHnjtShAZ1JVZKEDW1dO4a0Bx9wlozuup7qK6zjFUy8W+zRqMWiCiZycE
         BOE00H70IkPxCms3k10fOsahNkLWc0/5hx1bkg4+IHBCI4/pQ0K6B7fvKTkjw/g95PXs
         3h21jjwl365ru1Hpsz0AfjwrT4V1r4BtosUVtZ/oghp1Lmpr1lpyTZetM13aeG3UZ16t
         16N3czOMAPXgnas4jou5gyg1oGJ+gIhBQC7N2Thr4OfB64FqBEGvYr332lHfe8RrVD2+
         r3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Lexh0FPoUVCHJNBkP5tl4kw1j/BVfIFrb0t7ALcSJ5I=;
        fh=dkJw72uAvPi9dbiG9ZTiGV5Id4d6kZoD1++Z1cAis7g=;
        b=OqwcKeqovxCzXu4ATd9xjw5PEQgxmIIL9HnGAHYlq0U/QUIRO+jc6VtYP+zDA2LCJr
         /Mrl+p8tEpvRE/jU1oKdFNCZg0oPreGX9Nxj1NGnLFSwFN4rH1EaQfwKyjETE7iqxBtL
         F5BZ1z1eowPy3TPAj4Ilw7z76lFf9n6N3ZCJa346YLL9e4049X80XPd71MVBURMj2DE8
         nEroDCzNOGM6uGLpcjLHs6Zxi2/TaVJt8wRmXfJ9WnzhiZu55hblwyYfT+ph5Q7esJBb
         clJZG2j+yRtYgkrV9DOPRq6EhTpQOJbSiGNF+nan8mz2nGRq5DF2tVjguVXp3oVhxv3I
         NSdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773692055; x=1774296855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lexh0FPoUVCHJNBkP5tl4kw1j/BVfIFrb0t7ALcSJ5I=;
        b=HNpoObIrIN+tT/nfT5uYwZ0JfW3M6mHCUeUVL1kP8XHSTxvrgsIvVxdMJKa3/aBGAk
         ou4ZKBJw0nAMOwuRH/sojqrGrCtQb1iX8jTQf1zuFAPDdSx4nWkkfFrVya1VPCJ4neKL
         LHXSEyqfABk97/O/QYhs4mEHCkp1A60bJsKVk=
X-Forwarded-Encrypted: i=1; AJvYcCUxehmsdPicPGfPtv4YfYB6h1fosSR4ru9zfGWHMlLJLk9V4weQWxQb17ZDEs5vX/eLLO8=@vger.kernel.org
X-Received: by 2002:a05:6000:1849:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-43a04db6013mr24504399f8f.31.1773692055522;
        Mon, 16 Mar 2026 13:14:15 -0700 (PDT)
X-Received: by 2002:a05:6000:1849:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-43a04db6013mr24504362f8f.31.1773692054993; Mon, 16 Mar 2026
 13:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
 <20260313222206.778760-3-jitendra.vegiraju@broadcom.com> <abSaKe3d4fcBMqLm@shell.armlinux.org.uk>
In-Reply-To: <abSaKe3d4fcBMqLm@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 16 Mar 2026 13:14:02 -0700
X-Gm-Features: AaiRm51rhr8AUuKjJ896JXx8rkZIE9TCvoAwPiDICMMkm27V0tquX6eEi5cGDi4
Message-ID: <CAMdnO-+UEb8sVf8=Aj7G6UgY-DxWe3bFYbSbKJRdU4woEX+dWQ@mail.gmail.com>
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
	maxime.chevallier@bootlin.com, matthew.gerlach@altera.com, 
	chenchuangyu@xiaomi.com, yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com, 
	chenhuacai@kernel.org, florian.fainelli@broadcom.com, 
	quic_abchauha@quicinc.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f0382b064d29dc1f"

--000000000000f0382b064d29dc1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell,
Thank you for reviewing the patches.


On Fri, Mar 13, 2026 at 4:14=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Mar 13, 2026 at 03:22:03PM -0700, \Jitendra Vegiraju wrote:
> > @@ -42,13 +42,18 @@
> >  #define DWXGMAC_CORE_2_20    0x22
> >  #define DWXLGMAC_CORE_2_00   0x20
> >
> > +#define DW25GMAC_CORE_3_20   0x32
> > +#define DW25GMAC_CORE_4_00   0x40
> > +
>
> Do these live in the same versioning numberspace as DWXGMAC and
> DWXLGMAC?
>
> > +int dw25gmac_setup(struct stmmac_priv *priv)
> > +{
> > +     struct mac_device_info *mac =3D priv->hw;
> > +
> > +     dev_info(priv->device, "\tDW25GMAC\n");
> > +
> > +     priv->dev->priv_flags |=3D IFF_UNICAST_FLT;
> > +     mac->pcsr =3D priv->ioaddr;
> > +     mac->multicast_filter_bins =3D priv->plat->multicast_filter_bins;
> > +     mac->unicast_filter_entries =3D priv->plat->unicast_filter_entrie=
s;
> > +     mac->mcast_bits_log2 =3D 0;
> > +
> > +     if (mac->multicast_filter_bins)
> > +             mac->mcast_bits_log2 =3D ilog2(mac->multicast_filter_bins=
);
>
> The above seems to be common amongst the other two setup functions.
> Maybe there should be a helper for this?
>
Ack. Will address this in v8.
> > +
> > +     mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > +                      MAC_1000FD | MAC_2500FD | MAC_5000FD |
> > +                      MAC_10000FD | MAC_25000FD;
> > +     mac->link.duplex =3D 0;
> > +     mac->link.speed10 =3D XGMAC_CONFIG_SS_10_MII;
> > +     mac->link.speed100 =3D XGMAC_CONFIG_SS_100_MII;
> > +     mac->link.speed1000 =3D XGMAC_CONFIG_SS_1000_GMII;
> > +     mac->link.speed2500 =3D XGMAC_CONFIG_SS_2500_GMII;
> > +     mac->link.xgmii.speed2500 =3D XGMAC_CONFIG_SS_2500;
> > +     mac->link.xgmii.speed5000 =3D XGMAC_CONFIG_SS_5000;
> > +     mac->link.xgmii.speed10000 =3D XGMAC_CONFIG_SS_10000;
> > +     mac->link.xgmii.speed25000 =3D XGMAC_CONFIG_SS_25000;
> > +     mac->link.speed_mask =3D XGMAC_CONFIG_SS_MASK;
>
> Is there any point populating link.speed10 and link.speed100 ?
> You're telling phylink that 10/100M speeds aren't supported in
> link.caps, so these speeds won't ever be used.
>
Thanks, I missed this. Will remove 10/100M entries.
> > +
> > +     mac->mii.addr =3D XGMAC_MDIO_ADDR;
> > +     mac->mii.data =3D XGMAC_MDIO_DATA;
> > +     mac->mii.addr_mask =3D GENMASK(20, 16);
> > +     mac->mii.reg_mask =3D GENMASK(15, 0);
> > +     mac->mii.clk_csr_mask =3D GENMASK(21, 19);
>
> This will be the third instance of this particular mii data setup.
> Please consider adding a function to do this setup.
>
I will move this code segment to common helper function.
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--000000000000f0382b064d29dc1f
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
gccwLwYJKoZIhvcNAQkEMSIEINUVUbysjL9+gNiqoYke75wxwIG38bARO/RSYDlx0FPlMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMxNjIwMTQxNVowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJvC306FDFxC
YyuqhwG9kk4ZE2u8CfOZbr12Sk/AAb5hZtzCfbOsLufo0ZNcY4TWW9REt6+7uiiyxAHKgN9hchsK
k0bLdOuuTkbOInqAxku1J//a0k7EXnUqwpMJPLSsTRs56Czw/fw0PQuuw5JFVc4C/8dk/i7fMiC4
D3DwfGGM4pM40xg8LC5ACVZcmEKCovxmlcPEzx2drZIBCOznEF2j/CaSyb/ym3+uBpejbUMyqgBl
9mEMRE7lrcnKmvIiFmGLiXsx2B1dXeOdg/hjYxXJ0O4XAQGhLZDFKUxlsRqV7TIWsJZWYNp1QF1R
u0jyC1v6qRrjB6uG0y/7HMIG4yo=
--000000000000f0382b064d29dc1f--
