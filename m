Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AF3FCB1D
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635449; cv=pass; b=U7HW39Si/YHaUw0qVZVjM1rbu1AiM7Pdydl6OdWcOiK+bEuSZTQwEkXt18SOWOfBbeh3nSmPktS1kuGg/6UvWrlBrFA3sWksdWKSa9n9HG+YPhq/n0g6jLPLEijcpngsvWju0FO1qAdBpzvRZ/BRR9WNwvF2NB3WIrrl1ntFwDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635449; c=relaxed/simple;
	bh=gv9FA1AXOSDoSErGjg7Ec3gLzty/D2uaqOH+18aJgdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENhW8lWnngzfewp9gxMYcRT0rxhq7T8ZRiojizQCCsGX6KdtADVZT/C6um88YCD3L3HuXTkPzbr2bHVfCYloKM3iWtJEs1KVLXIb0k8ruJI0RqvEASuJ/VDggiaFUgN9jPdUtgC6XHvLZdipQKlDT8ZfSkY/YdcJL1T5cQUXn3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KZ7YvMzo; arc=pass smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KZ7YvMzo"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-89c43c4c383so30025806d6.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 11:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774635442; x=1775240242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv9FA1AXOSDoSErGjg7Ec3gLzty/D2uaqOH+18aJgdk=;
        b=UmOivAWzy6OAEwX+34Gw4ghBGzXY12a58LjKvI7ds6NHg0EqB5LgGm34y/sm1PVVnV
         VHevH+XoR795CNN380gfOvqqQNqZmKir/w9l/BJdnBEGFgPYx+BH7V6s76ozAwnX42Sd
         n2NPrsA9aP8w8+jm+q3CPHrXb3nc+juyPiQ8haEIoyWZkmnHvObYqBMQwwxhGwuMvXWe
         Bz1OeuTQj4x1QNKpW2hW5y+3uCI7h++kWGGxSMTc740dVSHi0p/99usp3zNRcM1Opbj8
         h8abj+ZaZ4J4xI47kuHpKhPeQ8fmISx0z9znOijr5hq3MaJDYBUPzACdHzfu5uuJMI7m
         ONzw==
X-Forwarded-Encrypted: i=2; AJvYcCVULbgIl4V2Z3/WlT4MHMtxzEdSoOm30W2ze4gM9CCXKWPfResGOebtPMKPFny+4DKrVRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz105COeZN8aOx2HY5lFmhTrpxbWCXi+ar2E1wzdwkEkI8Yuvdh
	VHs+IkCvi9ZlgTtE7D0a9oRrguDTJ3wEhXEYMGOK93g4LNex6tPeS5mMts2f0UCUVsNghksv724
	cMVv39lUmeaAjBnbCRYR6yWvwLvlOzm+H80iVt9X+UbrxS01oLT9qL7lTAykUIjnbhkcll8xE1p
	zcv4/qr7a327yNxkXJD0la7uk8tbe5GmegiyZkSHmM0LsnPFVaPbiSOLI55INrl+p5j0z84B65T
	dj2RkFT5pHy/g==
X-Gm-Gg: ATEYQzzjpGWVgCe1xDO1d2xzZBC1GnMWAKr3iGDGcxjlBIzucJhbnJyKkamY0XVVL84
	TWhi/32iR9xguOAQ+/BTLYKVQwxmjbyzVra3HhpDqt2VYkgjVIf18a7TajI08Ml5k/jMtvLWnoM
	SFJ/XKtGtBZJQ7slUgEzlXWLGQ0RL6bX2XHVjGyazekK2g12hyYyxCumUP6Cm4ISn9A3Jg/8fiM
	ydE6fR6ONtvif+9iZkom4xLjjYUBl+3bh19CzfpvkEl4b1VHVVd/n7YbxGGdr0kOEC+nT5DAzZc
	y/c+k2x6setbA0XU9MQNUx8pafYxna4K5LfI+6iOHtSEVqj/iXuxeVe/A1zrRBFgdKo36okJXHm
	/Q9ENUYGoz00UzHbZSFOquwLD6Q8OTtcEd6MC9jvI7b1KcNrzlg2sDnl9lFn2VcbBaF0GHY8f83
	jNICNMnLtcBGftN3pyzgXz6tY3kw8BYfoIslmWTqDaLz9/iTJm1YjgW1qztfalVN4=
X-Received: by 2002:a05:6214:29e7:b0:89c:edc1:dfa8 with SMTP id 6a1803df08f44-89cedc1e0d4mr33544176d6.57.1774635442048;
        Fri, 27 Mar 2026 11:17:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89cd59ab315sm7514596d6.16.2026.03.27.11.17.21
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 11:17:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836abfc742so20846765e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 11:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774635439; cv=none;
        d=google.com; s=arc-20240605;
        b=Osgq/l05uSjA2kj+vZ04eIvXaDnSvfCx3l8I+uQc1Oi8aFIQn046NG9PzRDr8m09aU
         pGoBsjFLAwSfjpuAKp6X2WtIHHza8TnJMmVHLBYeufkVfmBNbrPKJKYFmBnTVNe2U3oB
         qAwkyJJEr+hvEDt5/nfOYpLJQZpKcKccYG7K2CjbyrND53WQtB4z+1FT3LMuC4cqRENb
         oLCnIfkAy5xrxSJsJnc1Tc4aEPnidD6ogx2jWBkqKqJCuuMyIFtF82QdGXBt7xwsgIL3
         Mj558RnPny1yxOoWGcK0y0SOzCbBjM+0lIBGYbIjv2Mi6hZU/CmO63XKW043znq9giFw
         CrzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gv9FA1AXOSDoSErGjg7Ec3gLzty/D2uaqOH+18aJgdk=;
        fh=rWvodS/rOBmKqd06eG8GV4cn8OCDCAmTabFkrL3f5fw=;
        b=iS7nW2SQakKajzP8AIYEDUo5TgVk5eRK1BXVJAx7z0GAf+4OfR+YLa6OcT5VStDZU9
         3ya9u7SM8ZpxcyHDXJWwWZ65mOkPkQ9cy3ocPXKHI5/n18oAqeotogq209M86NdsAEmp
         yf5dU2aYZGkNw6U9elziXMQRgPiNQCZgb6kfpzPokEZ77X7lxOsrCrqHIfKP73pfwIw9
         KNqtEk0sxK6kFmXCb6HAJyq6uAA1wvyjwZDSWafBckv9hhHNIeEnKF92fhYmFyIpHF/M
         7T20ox98/g5TeTWh5iLMLa9Gwz2PiUozI3fUg9Q6Jl7RlD3jhdUMu134lTVvKDDzVZmZ
         2WPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774635439; x=1775240239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gv9FA1AXOSDoSErGjg7Ec3gLzty/D2uaqOH+18aJgdk=;
        b=KZ7YvMzot+L6ZfW7qPjWk+hq7dHN2/KYiDnZD/Ly+Dra6BN6bBgz5GQCTxMACjzIxe
         wG8KushPUqApnh4swK47lWez1uTtJD6zYy+FQ3+68syLY6OtnsXBZBgQ1/GQvniaMflm
         DedugG4J9lWsWWIeaLE02FYjArRx4Zj2ii6kk=
X-Forwarded-Encrypted: i=1; AJvYcCUmBUocY+xtS/FnaL9XQ1VmrB+PElzqz1snKYFEngoMtfkpr4hEBBNScMCHldgInluP7iw=@vger.kernel.org
X-Received: by 2002:a05:600c:a408:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48727d735a7mr47046215e9.8.1774635439526;
        Fri, 27 Mar 2026 11:17:19 -0700 (PDT)
X-Received: by 2002:a05:600c:a408:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48727d735a7mr47045795e9.8.1774635438989; Fri, 27 Mar 2026
 11:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
 <20260320211921.1202058-6-jitendra.vegiraju@broadcom.com> <acVleH7_kh7kAAZR@shell.armlinux.org.uk>
In-Reply-To: <acVleH7_kh7kAAZR@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 27 Mar 2026 11:17:06 -0700
X-Gm-Features: AQROBzDOeqJbNa9mCtRKtZ-IFiNPO_lpzfpzaY_mAFy_J0BCDBOc15lDtCnVYpY
Message-ID: <CAMdnO-Ko9FX2MG0q=sSK9foXLwtNW-QxDpgz8oUH3VmA3K0EfA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 5/6] Fix error handling in probe function.
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
	boundary="000000000000003997064e05834b"

--000000000000003997064e05834b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell

On Thu, Mar 26, 2026 at 9:57=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Mar 20, 2026 at 02:19:20PM -0700, Jitendra Vegiraju wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > Software node created in probe function is not being cleaned up if
> > the probe function returns an error.
> > The stmmac core provides mechanism to handle this error condition
> > with plat->init, plat->exit helper functions.
> > Move glue driver's initialization code to plat->init function.
> > If the probe function returns an error, plat->exit function is
> > called. Handle any glue driver level cleanup in the plat->exit
> > handler.
> > Use devm_add_action_or_reset() to register a callback to free
> > irq vectors automatically, simplifying error handling in probe().
> >
> > Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>
> Oh, you did fix it. Please merge this into patch 4, there is no need
> to have this fix seperate.
Sure, I will merge this into patch 4.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--000000000000003997064e05834b
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
gccwLwYJKoZIhvcNAQkEMSIEIK7K1B0+upDb2Rg1K3KbRZGMl9LrhHVqxjWjk3jOneLUMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMyNzE4MTcxOVowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHX1NL1jPOYc
ybekXYy/gSqctAcX5qJYLf31IuN9ygUzI9pMDQj+iO/w4/POsq1yRIkEI3KcnTpH2OfKDAsPBV8Y
5+sVV0tEH+yaNOmj1WK++Jhigo3YeLYxXo4R+l0YlQ+Kc/y6L3oPPjvakwDj5wCrqRriuZRITimP
kyzb66eMwiCoulGJcKMK+PQFgA6iT8OY0s222p/LXLcP52iLv4MUyxahVlkbPOcWttWmm5IO564j
5wpy6TyT0WuTESX2EGD0VBUrzXI931F4DulMDhFhZHy8+vrfc7FXm8oWYbbVgiqo3enq4IG+hyFz
5qLaxHNQG/NKu4oPOP6zesOQQis=
--000000000000003997064e05834b--
