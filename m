Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379AD3128CC
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078106; cv=pass; b=WztQ0F5FSEjXECKB7SMKCmh/KfhyXpuzShbpmia2hiY3tJPZA7AEFwx5ZcHrVdc2Ce+Cfi3o3i8IxXJAz3pJIuVh2DZ7OW4TPs3+fUZirmoX3SJRPudergU8zpdpAbN4BRz+5DF1tNV1gOzux1jnwQMxdkMV1y1zgubmWCzUSNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078106; c=relaxed/simple;
	bh=Q/nCxuEWM/b5MLwmqfLVD8OyxTH29OvdyYXvQn/i3d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJjeCEkrrVZ6NAC2nbkexmSuDUoO8Cg76XdUo0L9MSLViG8zJbwNK9XOFoUkfXPUjjJSDi+pj3hufr7VwzrY/6wfa8Wamw0cW0XTX1rFF7hovODen90/rrvQ6Yn5lKw/qGYzb4BJJdBDl/uL5vtdbDwTC7PVhPukapiKA4q/LPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UbxoQDpe; arc=pass smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UbxoQDpe"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2b04d051664so22137065ad.0
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 00:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774078104; x=1774682904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qg6zLFyRO4XRA5+79sdX0Ogv9sZBA/xhe303w2goDg=;
        b=atCh0/E9Cp9GNq4uhDr+xW15duO/9482aVnADVa8xBlFQYABzh5fic9apyuupz1uow
         4geAPizy9mkvfhQBCUVQymLqxda/Ku8QhyxkfjOLwKpxNYMhzk/WPRsczUjLQhSyGI+Y
         m0Z+n3bW6bNaQiI70vCD7EHx7aqarHlC020cVXzsniT9y20Yhc1hD/U049XtV+x5mq6l
         tBnSeBGb7gRBvMfq3PGNwKCMi5d7iO/9Rcd4kqvzJF7Oxi9uBpxW6yHFQgvUT/Vefx32
         2KvdDWJtNjSSwhLkbQ4wFZpiNa9ZH207uAaiu8VFsMZY4ONr+4a/HHQuz92LTQnlDPJi
         Xrwg==
X-Forwarded-Encrypted: i=2; AJvYcCXWUV8Y69DsObB1PfFng6RRtbKNs8M7hyvsw5MLplTAMRmMqNZzl3RWz29b5MzjVQt/Mok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBc76rIxKvhtHyiBqRpSmEXyf9gyH8KVD29TWHj4mhbo5kKfv
	rR0vuFpyioPx+fT5wboFQhrdzlqKfS2KL+bYj06lYQ/r3MOaJyHXoKFNw1FVTOychDInb4NKRsx
	kCdA/+ugs1YJvluGr1/vda+X16ySQoHx25HUxsHBhHT3pS0j/ZDZEMssk7ud/GLMYiAt4m/ENiu
	qe9aEraEOnNLTdWQwEZlIy94SmuMgm9i5Jh6/s6vNly9V/aVSYEdb4U/Z9usK1DYiWBPq8QHmc0
	iQglhI=
X-Gm-Gg: ATEYQzz+vLogmj7BQn9+FZoFsarMlYLQLNPqKRwpUQqFjELykb/Lmf+qiudWVNvSx6C
	nGpo+6mnz5btex2K2bgcfrh26DcqtjBH45RYE+LJCbllY+ahoE5B2UrknLXM6Dac5mT+YmyGctv
	STZIQaItNMe3unQgt+s3J8sdynN0BZwlrqE1rP1KLfveyI2IPI+35HbtJKc/aO1g81VogM8wXHA
	UT8/d5lH/OM2ph3X0j19FbSvl4CeW/ou4RBkFV1Sz4w1sb4/f8fyV2lH3GtgHIJyL1/C2iTNNic
	S1xRRvSwh8H6dpLlXMf7yBTRKSpMhgmZSyazHgNFsnQcJG4sL4x5f/Hk9bc0oTlGA3ngQcj2RlA
	y9YGopFBFAgh2TPiCg28OVidf/uNboKDWjJHM8adT3JqpW2VDrrQ3lV4RdvZsqctDsq1aP3gwKE
	WWiW2Yrit7LEsJ0YYiTGN6+Our0qxx5jH4xM64mIOR6he7lHFPJ0VReF+C08Q=
X-Received: by 2002:a17:902:dace:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b08271a32emr56426055ad.17.1774078104389;
        Sat, 21 Mar 2026 00:28:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b08362939csm5917555ad.52.2026.03.21.00.28.24
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2026 00:28:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82a77f807e4so9816360b3a.3
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 00:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774078102; cv=none;
        d=google.com; s=arc-20240605;
        b=Db2l1aUOGIa3g5+J6rhDtfdQZuajg4MLF8M1Xp1E9REOLw2ksoeCPrKclwijmTjUAX
         DfQy3zz1dy5rn1URWZPM8WdBw595BCbUf9wMlGBf1nen4WwkKjUTA0bMKoK2OsIjirn1
         3xr5OxBNngGHeNfxMEyo7AzWyg3oHti9zqd19uZUeTI++X25tmf0zkwfUWduU9NkActO
         Y6N2KZO/yizexXUYcPNIUfMrSSegOIH4oQzVY10UZ27d9He+Lf3mbu63r9eYipLoOpsX
         s7z5jxwFIfJPH2JI2Jr+dYo0n0cweGIED+wBf3EtivzLW+eKeVek887ZFfPGwUEGOuum
         LXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/qg6zLFyRO4XRA5+79sdX0Ogv9sZBA/xhe303w2goDg=;
        fh=xqyCsIjGFYipEeylNbJ4OwIoySSO2leSc3c4J2c+ZF0=;
        b=C5h2ruJP0PDCdb9qAOkSWy1mEuYPWW5weD27z9qP/Yg1A6n69swlnhckBWD5MYqBg0
         t4qMoK6DFJ/lHjqxU5jN/7BoN0rqWumjg8BlRrcOQ6AG2/M9snKiixEqx1sgNL82CO3x
         ZCvr1fkFHCBP2WBEvcRveYK3UxHJwgN21Q+9IS0RcKSgUnP9byDODfizcECXD7nA0Lsp
         3MIg4UimXLBFsa3/akBa1kjkp8jVxyoRQWB9zq0bnEyKef1zJGd/M3KzbyVMTs02yHGy
         zn+DjK378fkMF3ex9UwTrcqLH6jKyHQ8fo32QGfK/+daA4+MEEcwi4RI1SQ3UE1DqIih
         PyYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774078102; x=1774682902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/qg6zLFyRO4XRA5+79sdX0Ogv9sZBA/xhe303w2goDg=;
        b=UbxoQDpepfE0pzn6C50xwW1UZB0BYFW6Zm8DKzUqgeoAO7mf7GIp6ORBIlqvmQNYSJ
         nCiQbIXYi9DwcVBNcOhrA0WCnOxUWLvm8b5f3RkcGjsTtmOGmsGS9oObeHblRPwRxex5
         SjEBsR4dEXQPpoA2Upfi5ce5OjNvVRlIKuvR8=
X-Forwarded-Encrypted: i=1; AJvYcCXAyi0dWEhVw4XB+shWI2mT3uMSTftD7ustQYY5Zk5jrU4Cf6CnXljENWtsxdsvu6o5HrE=@vger.kernel.org
X-Received: by 2002:a05:6a00:3c8b:b0:82a:768c:9a2c with SMTP id d2e1a72fcca58-82a8c23e434mr4905188b3a.22.1774078102695;
        Sat, 21 Mar 2026 00:28:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c8b:b0:82a:768c:9a2c with SMTP id
 d2e1a72fcca58-82a8c23e434mr4905176b3a.22.1774078102289; Sat, 21 Mar 2026
 00:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320144141.260246-1-joe@dama.to> <20260320144141.260246-8-joe@dama.to>
In-Reply-To: <20260320144141.260246-8-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 21 Mar 2026 12:58:10 +0530
X-Gm-Features: AaiRm53Rp_qWSdKnYSpHlYzwg-PjWNa0UV4sEdOBZnMtlZjnJmeKZAnUP2gIb9g
Message-ID: <CALs4sv1UwG4bKxFwD5kcSCvsO3qOjctdOfDoeoiaydZSoRLVdA@mail.gmail.com>
Subject: Re: [net-next v4 07/12] net: bnxt: Add boilerplate GSO code
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, horms@kernel.org, 
	linux-kernel@vger.kernel.org, leon@kernel.org, bpf@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000218451064d83bfeb"

--000000000000218451064d83bfeb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:12=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> Add bnxt_gso.c and bnxt_gso.h with a stub bnxt_sw_udp_gso_xmit()
> function, SW USO constants (BNXT_SW_USO_MAX_SEGS,
> BNXT_SW_USO_MAX_DESCS), and the is_sw_gso field in bnxt_sw_tx_bd
> with BNXT_SW_GSO_MID/LAST markers.
>
> The full SW USO implementation will be added in a future commit.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 30 ++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h | 31 +++++++++++++++++++
>  4 files changed, 66 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
>  create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--000000000000218451064d83bfeb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC3m2CN
NB2beMhk0YUU96ZHW0cyTKuhCLfzDHmLQGy3lDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjEwNzI4MjJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBpOVSSvhix0HHYnjD5VmNixmMCvoioLA4Kd1jGBf++
UkhcBXLYtk+LAbVkd6q8hCIrP/K/kWvfS8PX2+AF6XadpHKXQY1KXCRx0XZMKazWPglO8M7J4IBl
1R4D4m4T60Zu63KtgNqa9NbvQd+/lms7f9z9Uq1M4y7+I3JhYL7aZCL/4rCiSUh/cA1AuCu4toI8
pApinDMsGZEGLQvRFGk7kie7KPzRqlh+34Q+vS6TnChntICYWuLxCgPQpcZ6Auj2YvTOlZZ2R4oS
aEP/YblyPuyrMe/PlJAdyHbZacuIlxY/hbzAQk/Wn9G0FsxgQrctBvqHAHkgT7439TsRv0Qi
--000000000000218451064d83bfeb--
