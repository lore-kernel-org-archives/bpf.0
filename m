Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C63129D281
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900761; cv=pass; b=RAxugc2CecZcSFZnZ1sqbZwUk7V+BSzJj6dIVtt43xVFCYjChG3lFl1CBVtAirs/LrLv6WKXHSrdDeeCuSeBmBIpaqjtCsqyRIwbvOY8vim+1AsXKzP84YYiZiL13CidkFSDCfzRNNZpo47LzxEjeaLaH+roFL9PLc4WRZGrxGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900761; c=relaxed/simple;
	bh=Vh1Ea5GAfA038G0QnV6+Rwkx75p0loxBrlVo2m7LHRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvTHXdrmSnnyoqjZhC6Zd/kYQNK25r+GNdK3wbpQMHKal2/wXXVv1oY8kKXdleSPqIcQLi3hUwc25Ma9W01Fsdf0sf597bXRCKSbO2k+XTB6CVbriVdTWvuPKfUjJD+6iyLjMxaolYkiejHr3xxkXKytYSY6mSP7VpnBo3pW0jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TogvaVoM; arc=pass smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TogvaVoM"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2b04fc8851cso5519635ad.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 23:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773900760; x=1774505560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS67RMk/FGiuzbwMtEPNB8droSodemv/flchczXR2SA=;
        b=TOfieksygGmWt7ZBbFtWz2jlaBm12spcrnI+DxjWFdz5ve5V9BueaTLhT+XdzSm64b
         zVEzAxonXsggh5W6p6zJUc46i+/gQyM2Gd2uKaCP8N3zHCSNBoS8hiO7Deq//qf5idUP
         5b+1b+YTuA97LHBKVton2cGiTkjicmd7THfc+3+F28DMuwI7YV1qdpZV+o5zWj6FtVOl
         BhCbs1XMZu7W+SFWNvxvQsxpwl8HBHHm9rVrZFJKTT7U9+3nqdgvS6n10BWOKIkwNYum
         aslw+IrGmUN3xsf1Gk4blmi7oo7c7Wx1uPv8FopbHpLncEQtyHsdgHkkA4cqpkbtJwrp
         Zt7g==
X-Forwarded-Encrypted: i=2; AJvYcCXGMs866Lsf6B+viaHeymmfBQBRkRKDB0YlSQWpGGqusO766vNqpimf8lhkyZ2dugyoM0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCsHB39iClurMut24zFTTm9FGwBvpbbnMDP5mhYW1oOczGYMo
	zEDp1bvsz9+oEm4JQZ102AY26GBYDiKZP150SKo7nSop/8Cz9J7Ua0GtixmXcSa5P0xcYC0lMot
	iWDGRia6ZM0shrfpjXncQcpnbswJNB8a/ansU6QOD+6rLXuMHgBXZjVRowFhlgqgyViWbgc8Cqy
	E0DQYZYlSWQGpL6TO3ae0CBvDzgfN/6s9xZHnb/PgpzjJAaCwMT0sIM5kvGXnWNJpwcujyeYdVP
	cghTrALausxgQ==
X-Gm-Gg: ATEYQzxQvOGtZGc8uK72Zd7NXw/A2zOQJFwRTek3IXG3jSpPUXJYZuwCpgRQTALM7Wz
	M8EQ2Aoqe5ObUqMcfNy2E/44qUjS453y8OrsgVcPN1Hws0dGVMHE3ZzuZOQOJUgxuzpeFCLUxe9
	Fck4J8XlkULSXxUNYX5ymMFpZBmOebt8iLyV6YbbIOEBjW/lDzQ/ZX3rU7EVrpzQQFlCXCfMaIk
	bbhRQ+mQhe9XJxtx284k5i142TBPMI0bAHT6lu8+khzQ7IfkGFd+ZsEo29JRmmuhxG8uW+PLB9n
	wy3Y7CKXmqvcwVmQyVyyBiGDy/VxrcKFWNRUNrfSyzRnmEMZYC1h5GzO6XHpavaeShXUJ/Z2Dmp
	ebFl/L5c6sg4DeneaCZh5tvPUVLuo/T8T1EDMjks625kedJD/oVhK/UVsAtIJpqR9ZB7oXt8FnM
	rGRDJOCfBgLal66ZdcGW2SK2BKNkUoh/t1hgi/DZisLQ1yZb+pqs6RNgbr/oCLrnl6MQ==
X-Received: by 2002:a17:903:1a24:b0:2ae:5a0b:9ce8 with SMTP id d9443c01a7336-2b06e428cf4mr62211295ad.45.1773900759844;
        Wed, 18 Mar 2026 23:12:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b06e5f467fsm5476605ad.25.2026.03.18.23.12.39
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 23:12:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b42cd4becso291479f8f.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 23:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773900757; cv=none;
        d=google.com; s=arc-20240605;
        b=ilWICUqmUYAhicmTktjPKmqqzlQP+V6YdkL0IgC5hMIZxAM182bki4v8gqNaEa2MeY
         pSC5uPVCGtLoOuxFlnqQwtJpcB7m6DS7287Gj+QP2G66zM889M5qntywOCyTQcJxA66c
         RmeTKf0S9N04ALJ8rIbHWvPARwuH2KH4mWwXGVa0LVzzTBS0y7lNMONPuqZQmvqZkTlP
         fBXgHZeCNkPOpor3ifg2vwjW/l8gWLzarDxNlqH6oPCMQEAdsMAcg+oHcJtwviqJoQtU
         IrrTGaKIU4EZCePphk/bnh8Fui8ZGMwviiPdsxcTvCGJR8CCdi2VPHd22VL6Mpx4gOLk
         R5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hS67RMk/FGiuzbwMtEPNB8droSodemv/flchczXR2SA=;
        fh=qIvjLFunGqEjAHl/gwLRtshAdqPMyTZE+8KNaCwMwaY=;
        b=CEVdMxNeS0VWbkhJmywjQk4CdyoPc7JjM0dY18DDaNDhcDVVsH8ns5S8AYK8oC0YVk
         lNkgzTEAidVQquoiCqBmJY8l2SkrJYxvdrr0VO1hNR7gl3tcvdGEKwWRJKSt8ipP6aPR
         Y8h6UkkeJSGpf1jgOMzD+qeSY+oyhjRPS8eZ7d/P5ikRpmz9Ksv8YLa66AE3TfnOtrLz
         y+yURIL8J8sMXdQFCkAgPLLNnnB/VVBF9ENOjDmiHO46M6aHDHSsXkg0bl3Ztg9s/a/v
         BGwFv7X5lxaPPP8gZyKHl4DVB92v901AWLkHBFUKnKz9AhlviZDtaZWr84vQI2E5rQpW
         ul9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773900757; x=1774505557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hS67RMk/FGiuzbwMtEPNB8droSodemv/flchczXR2SA=;
        b=TogvaVoM1zjmiAtuBQ1kvon5+SxOr44ec/AzqSo3AoD8PEFLvCKQVOZ53OGyP1kfPu
         xB+NO+8MjAMfDhsK4wKBjsnfBmUyEpzd07G/hk8Gv5rKU94XDCWrLgMBv4cbqB3lvp7j
         S5Xia+6axlmYoI6xkYjBl8+yiemDBw9gjLX4U=
X-Forwarded-Encrypted: i=1; AJvYcCU9LF33y9iEYjNJNlbJ4FQZuTYBWMfGdMasxvDyJ39pLtTS/RpDEmGxKtGfqutAGCteHQA=@vger.kernel.org
X-Received: by 2002:a05:6000:657:b0:439:cc5e:a6d5 with SMTP id ffacd0b85a97d-43b57729818mr3028472f8f.23.1773900757553;
        Wed, 18 Mar 2026 23:12:37 -0700 (PDT)
X-Received: by 2002:a05:6000:657:b0:439:cc5e:a6d5 with SMTP id
 ffacd0b85a97d-43b57729818mr3028418f8f.23.1773900756977; Wed, 18 Mar 2026
 23:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
 <20260313222206.778760-5-jitendra.vegiraju@broadcom.com> <abSXP3gMFQEiC5Lm@shell.armlinux.org.uk>
 <CAMdnO-LYAPfyvM4vgmGcZgy-aagHSkP+VDmpRskNU-414j3gnQ@mail.gmail.com>
In-Reply-To: <CAMdnO-LYAPfyvM4vgmGcZgy-aagHSkP+VDmpRskNU-414j3gnQ@mail.gmail.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Wed, 18 Mar 2026 23:12:23 -0700
X-Gm-Features: AaiRm523T3yfvZCD0epc5meBKP27na-ViVz8_6bCVOXjtZZcwVC4fiK6UmLEqL4
Message-ID: <CAMdnO-+YWowCDh4iB9EZ=eqUidE6Mu4TOqjwyoMgyEaG=pBLBg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/5] net: stmmac: Add PCI driver support for BCM8958x
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rohan.g.thomas@altera.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com, 
	lizhi2@eswincomputing.com, boon.khai.ng@altera.com, 
	maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com, 
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org, 
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008b8c14064d5a74ae"

--0000000000008b8c14064d5a74ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell,
On Mon, Mar 16, 2026 at 1:34=E2=80=AFPM Jitendra Vegiraju
<jitendra.vegiraju@broadcom.com> wrote:
>
> On Fri, Mar 13, 2026 at 4:01=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > > +
> > > +     plat->suspend           =3D stmmac_pci_plat_suspend;
> > > +     plat->resume            =3D brcm_pci_resume;
> > > +     plat->bsp_priv =3D brcm_priv;
> >
> > Populating suspend/resume means that plat->init and plat->exit
> > will only be called on driver probe (former), probe failure (latter)
> > or remove (latter). Please consider using these to ensure that
> > all appropriate resources are properly cleaned up in all cases.
> >
>
> Thanks for pointing this out. I will check resource cleanup more closely.
After reviewing the need for  plat->init and plat-exit, I don't think we ne=
ed
these handlers as this driver with fixed-link doesn't need to restore any d=
evice
specific state such as clocks.
>
> > Thanks.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--0000000000008b8c14064d5a74ae
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
gccwLwYJKoZIhvcNAQkEMSIEINYa4z6UGpcjabiJYulOCRrZPxZUTfVF9+pdPkZKYfkBMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMxOTA2MTIzN1owXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEaiQAnFaDsC
C6CuaAWt1k2iuATKujEBZ5NzU5WbvK/KdsPptNrglD0RGdVpsJl5UUw2H4oT7T9Udl1m2zK/I2rK
CQIL/Hsf3wrjHVKuHYZbseHqX+D5iEg2yTGSUknuqFKhrWgD4r9OzA+TkZtorCfGNbHb+JknjSOd
7Q5AKdpcv714fy7enlibXav1Do8clrPo/51kL6XVvG+NhO+ncBha41GcYKu2znWiWPry3FvkByQ0
qLgMi9Qsi6LSn8YauEkrlhfvyPFDeQe1TWvSA7JofJ+Fy7+JdJj3I5vCa8xv8vLLx2wA4N3bN36J
jbnFNXitlYdIUw8pV6sXkyk+UjI=
--0000000000008b8c14064d5a74ae--
