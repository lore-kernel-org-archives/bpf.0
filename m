Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED445387351
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772533; cv=pass; b=X2HYPsZqWxUC5kFImRmM22eDJ/fqu/ULIlxKUEYiE3ESf/3TaoTxVCtibtskx92vb6FF0Ux7BaeUDR7GY5rn5oVUa8VzABiDjTdHF0u8Mr+kN0JQ1uasZvZdaJ2wPNjNIrQuTrtLJegTiZDsACuDyZZ7zH8AmFxV+X2sAtrew4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772533; c=relaxed/simple;
	bh=3MYTqkP/OsLWAjjIhBHEHK2WqSnZcZeinyJnYjTW9u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zzv0kYn2eRDWBOlbZ7tk/+1AjOeEG2eArLITXZ34jd+B+sCkg02yESGJcMiil4Zy2JfESS7KwOvZeFVVgllC+t+hN5xNSOPlD7NeZkHT6C+ZnRTLsZa2xeRw24NtYzTVRO2DTGdXnpA36zDAZ6dOhD8775wpZa6EeDudjId+Xj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CPUCi1GH; arc=pass smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CPUCi1GH"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1302128a91.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 15:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772531; x=1776377331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MYTqkP/OsLWAjjIhBHEHK2WqSnZcZeinyJnYjTW9u4=;
        b=rLzcKkHrhLnLNetX6zTKqAnIRdo2bKfotxWJR22nbC4v3jXeVTCe017X6GT0jNXAbG
         YVj2sbgh/mhEuYitOxrHOUVJ65Ov+3CExo6Nt/Y3mUsDxaz6jGO8gZxBUgy2nIRD8kw4
         u77ZiqeE2KSBDJDXwaM+UKE5YvKw3uOrGeHZ+CA1fa2pYeO0HB4oloy1jZzKQODCx2G2
         BmjuicyqBlj/UTbImPeClKHZlDava5Zt6g2F6zvkhfS40cQU/D2Qyti2H45F/TSrL3hY
         BeHPz1gQMWKGlHsZg02prvhn8ju5FFJYkORQQe3KiofSD3JrdaEFou5St2lySyHLep/I
         uTXA==
X-Forwarded-Encrypted: i=2; AJvYcCUUB4w2rCFczzKMUU5SRL757ahDtBsmg/Ol9zn0b38Ly/y0K+Q5cryrWxXgKLntu3HSm6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMs+nhbE5jZdpXBjJH7JXWGzHsW7pOjLS+eJ9+MK519yDw01jV
	WMvf3K3n8KfI9nJRP1GybbDhcjJr7LZleshJvi4sg5eMdoMtyN1LUl7lWPQVLSGOdYwiWVlpO/r
	3aR2OaSIuks/fqYylbsMtKFNkHwxG2KMeYgG/DHG+Ynfck0CKWGQnQMt2kWX6K5s5H5+GRN74G1
	6BCcvCAt78DXFsoo5rqbe4K0oWDecBh9Zx48rXvcp9txOIiGWAiim8l3FBFFIFG2mwngQK4B2Tr
	PL2G3WfJqsSGA==
X-Gm-Gg: AeBDietLf4NoZKgcM8IJg/n0bIQUjLlEVynxJPXzEVnp/P5ikLCJnaxikKwQZqi0AWN
	i9x9Tx0m5+AGChldNQpsw0PCgtfPeE31O/bSF8Z941Pe4O5uRafOiObrtCzWbf89xW+gj1QuL3N
	2rlcR7Ic/VC1xEzJm1hJFVypDIeuvVst2cBfKjXAjVQ145vlqlvxeHA4tYlxUxoQpUBC9DGclXa
	r14WKY0lJchl1BooRf8mMZz4fOIROql8yQZAnPwwxfCiXdndhoExjTKSzHzgJhiBtcuJ9qJ2iId
	Yh/XLg5FDhXSeDunx02N/2JttPvrdX3pXXMHnxd36EkXgoDr5kqjWRazPavIOebUP0oMdcMr36U
	+iPdeUd19ggM3x+jeyJuB7ys9ZXZSktID552QXSG4pE0emlMmoFnPPzED9u9lyn34XBLTMopsDD
	UZS6E2UHiv5WpxUO9UV14kkG+cPxSxSm4oaybpElnsqc1CnuuK21PdrOMhgxT2f2g=
X-Received: by 2002:a17:902:6bc3:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2b2d599adedmr4613345ad.17.1775772531097;
        Thu, 09 Apr 2026 15:08:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b2d4e54f0fsm572705ad.23.2026.04.09.15.08.50
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2026 15:08:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d63280c97so143703f8f.2
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 15:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775772529; cv=none;
        d=google.com; s=arc-20240605;
        b=OrwiFOH5Rny9vxU5fwqri1MOCCnHVAcG1ZltZMiURv3vUjUtmToOd6L2fL18UpGnob
         NuUpmm/r3F6g3HXzhHQDxgcN141sf8DBErHUDho4rLhup5Z4R4cG+3+xZ2weB1plwuLc
         Y9trlCR0db6n8Ksvy0S35jnaRn48hGZiN4rgNX9XNb6D5knIhwSIkmpjoFGy8/d41Ll3
         w/HXBuwEcP9o34gXlHFlJlOnU4jCxfJ+luVmetrbRtU1yTnhsaSQH1NWUKz8igjpv0EN
         wEiRtrICXiIImpqfTOfNRe8MonMH/w7xMBrBwAGoUzTbv3jD44eXsPZwdPA3QQQbWrn0
         S1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3MYTqkP/OsLWAjjIhBHEHK2WqSnZcZeinyJnYjTW9u4=;
        fh=kjm/1IPWwaovej2ICGW5Wr/8EJl21Ct6nIRipL68vjs=;
        b=VnUFFwoxFAxT3xah2Y054ssphjkKwgGvKNSF+S+6JSE5+KwLtFfhxmZdwq5dD7QzY3
         HWY+Di/1hKRCiSP8dNXvqGa9HYlw+pGycDEva/TQpkPEd65AOzMbIB53R/nHMAulZJQP
         K0T8cZ8gw1n9Ug5+pVFtze3sYgW2aW3J9FKeoiPoLU25WNK9m5mw2dqZ8TrpIbn93nDw
         pFT644xVqbJy0jhw389QHQWA8edykBXAXhYGvjy2alz+5EjVfC21W/Jf7VMNvXV6Hjta
         OVQQlzbLF3A2fixelyh8GuVw/xK1zrNER9C1GJYbDF5WTl6omPUC9hLBcTS1lY4s799f
         GS6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775772529; x=1776377329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3MYTqkP/OsLWAjjIhBHEHK2WqSnZcZeinyJnYjTW9u4=;
        b=CPUCi1GHhEUEIDAKVhdUiOplx+HQSlWJiigHsrdjEcSTW2kUXFcHxMdihowv3Ayauo
         +N2zLuC5Sn6Z2sVoxQLnjZNkKwsCg6z/pPpWigIWnJ3DU49nIxlbJVFyaCAtRFf1HgW0
         0v/udxo/lnLRIdG+KXD5k80dWkbIk0HPYEGEw=
X-Forwarded-Encrypted: i=1; AJvYcCV6Cyl10Qae9Yqs7OkiFInxjqDUeKrPGo/vs/rwO8ihHGcaSaWQnOhIr0oH47vjGRGtqPc=@vger.kernel.org
X-Received: by 2002:a5d:5f87:0:b0:43b:4703:9de5 with SMTP id ffacd0b85a97d-43d642dccc3mr1022144f8f.44.1775772529153;
        Thu, 09 Apr 2026 15:08:49 -0700 (PDT)
X-Received: by 2002:a5d:5f87:0:b0:43b:4703:9de5 with SMTP id
 ffacd0b85a97d-43d642dccc3mr1022125f8f.44.1775772528655; Thu, 09 Apr 2026
 15:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com> <adSxQpAE0nY0ulfU@shell.armlinux.org.uk>
In-Reply-To: <adSxQpAE0nY0ulfU@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Thu, 9 Apr 2026 15:08:35 -0700
X-Gm-Features: AQROBzArt3I8bemRMGDxmah0OqjGLcvGglqY0L8HZtuxxXqb_QYUkXgoucoT5Fg
Message-ID: <CAMdnO-J0Ss=+sp+aJA2TOiNPvzAv37MN05gwVZTGJmh3L4n7sQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/4] net: stmmac: Add PCI driver support for BCM8958x
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
	boundary="000000000000d3be7e064f0e426f"

--000000000000d3be7e064f0e426f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Tue, Apr 7, 2026 at 12:25=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Apr 02, 2026 at 02:36:25PM -0700, Jitendra Vegiraju wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > This patchset adds basic PCI ethernet device driver support for Broadco=
m
> > BCM8958x Automotive Ethernet switch SoC devices.
> >
> > The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
> > MAC IP introduces new DMA architecture called Hyper-DMA for virtualizat=
ion
> > scalability.
> >
> > Driver functionality specific to new MAC (DW25GMAC) is implemented in
> > new file dw25gmac.c.
>
> Sorry for suggesting this rather late, but I recently came across
> another stmmac driver in the kernel - drivers/net/ethernet/synopsys.
> This is for XLGMAC, but I wonder whether it may be a better bet for
> this core. Have you looked at it?
>
I wasn't aware of this driver earlier. We are looking into this driver now.
Thanks
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--000000000000d3be7e064f0e426f
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
gccwLwYJKoZIhvcNAQkEMSIEILuLmSSO4fRKTPTuCUL9ZTZdoL2rS4KMUF6rJInr/XkbMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQwOTIyMDg0OVowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJjVU0MvI29h
uY7bvx9vWk/zixT5OP5qh07gQ9ZF9enzeLyx+PJ+FN8nDKF6+sRt2oK57Z/N+zupzhJ8rkQLg/ga
Vae5b8gm1TEdtKWoKjlVg15ODGKq0Yl9xpoE8z1FXc7jtzlszLRjxfDG9kpPtIV+fESaJ948mWM+
Dj+3E9D7GwmUERU4IRcd16s26H3vlHeIzlccQqYyitsy+gq8lArA1S1Xoub06MRPb1oGEnuzt2iV
DfacCXZyQpO1r7f6dLyk0DQdGseZS1qZBL+mvF8voTPWMvQCJcUgxDeBMBgRaIYCqiKAaf2M7jY7
PdVbSt7f6/FRFOnIQM6hwwFig08=
--000000000000d3be7e064f0e426f--
