Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617E284881
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028417; cv=pass; b=lRI5KBen89ksBAZj1N5S9s/wimzZ0fad36YGsHo2+HfyIjv/g8MfGQpBpKFkps2IWdA3bd5ea3Ys+P9PJYAhAmuPcYrBGd3Iouu+Se65NzjK9+8AomNUmvpIrkkCtKC+6aoGTArkl5y+bD2MBdQMK/svcEYp0hBAJkGTxj1r3+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028417; c=relaxed/simple;
	bh=BVPeLPps3vMvNbuHTF/MRFDdPj9aEtI0kijCU1BoYjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3Tu6BOw+fRmELvwD+o6E541cYRCnL30AMm0Dfh6hP/8du4cu2L1a6u8otanyigcSH2gQVBRjjGiJzt3oYlIDq1EvZIluoYyPEfo7kPXdw0leakWDwhiW6k/QB8e4WdBzx8bsjxc9J05jJwZzUMYEuVVlMtvhgGPaGH+C/5KzJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eUN7izrI; arc=pass smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eUN7izrI"
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so350279eec.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 10:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028415; x=1774633215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/cZvMoDCv/f+YyEgoq0gpN2oWIvRq/EE9l8J4/P9Ak=;
        b=Mh7yKCaY0IPB7r79kVVEb0Lzy5vEgMmI0nLX5DzKdYNVGSH1gu1BMrhG3HoYBYrPbr
         +gK6PVqY+40eUmGi+sumw9YyLUMxBHVO0ZWizOiDdJGYaMRERRWdsMFybvCSsFX/JeFx
         GIcK/cFeq5WIbCs9hHngXDw9sARuXcUaI5kydlB2NltK24nUmmWW3CXDptRttYCV59X/
         IdQmK+S09xwJWqeMPvAqGaNQtaj7LFgapxquJ9pPu7IO5yjbjZ5IAXrDdtVRoVABFVsv
         ILXKovFJ8GSiMR5JwuGfZp+/Zzxpzs4sg2iUrJVlduMciW0nZ4V5wi0FvkyENkJzozzU
         HSTg==
X-Forwarded-Encrypted: i=2; AJvYcCUTnc8UUP3Cg1TDsuHnHn4qn5j4108fFE1M4OXadN7HWwBlTB5/IJkGn6cW3HKntXRZn/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xW3bMtHlIxEz5pBx79f2XW1kxgrl40yWEJqI8NUjVzjwPrT3
	8zUJU7xadGn2p5uRKKuhTIqLOjbJioWjvNFhZWF8efgZOmDnZ3945O86IadzSsuUthogut2RWbg
	0FYdE6OSsfzO4ImydWHB/12zl8ifvXchj3uIhlExUG1A1dqY+5RMtiJTDUxEw2RQT7KH9k/nmrh
	KBmY4n61sr5cWGHBhJ7V75GbhzkB3fL9fOjI4750Djd65cYkYPDH5H5UpOhkaG52G1JbOEUUmYL
	OmWgmJoeIDc0g==
X-Gm-Gg: ATEYQzwtNDqfE8WDzfmUzi1dl3muSwinrsy/jRkDVyqrue8R30+qElZYgo5+Q++ccrF
	qaudAyVXAB2avbW39guuYKe/4dn10Qj74NjvRsLgC3bJXojpqwhN04P4z7YijWDp7wjPBBpDl1u
	JdLhk+LuWcsMhtJ4ZruuBxgaKJuScFX1/2nyzcu8JbvyCn5iBRslsTtGXwRC0nTKC2/LyGgc90u
	Gl+9viBq1njK+zQg8JFsx/YvFkSrQ7mvtWdKY7xkSL+bHZ2zxTQzZGGT3WHQJaYnGYI3qjf9Cnf
	fNMb4pLet+rsYEbDentj8DP1UmV6gmkW7NySYKAuHo8sbvr7IVOuN29yapjhTJLHt2j1QdodLUa
	U1aaCLooVn7AzZKms3pPridLpu8vz8h7VmMovsSn+eoLkA9bP4MDXilqbVuL2CbxhKJk2MVKXSX
	G7oJn9wjnzjXfKKhbiuNAxqV5eBw1Mi0bojz9tmIh19DJsAwYaHEtqB8i9olBHW+8=
X-Received: by 2002:a05:7301:4342:b0:2b8:711:ae5c with SMTP id 5a478bee46e88-2c1095d7bcamr1992725eec.7.1774028414736;
        Fri, 20 Mar 2026 10:40:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2c10b293092sm231070eec.7.2026.03.20.10.40.14
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:40:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-485397788b3so17099885e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 10:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028412; cv=none;
        d=google.com; s=arc-20240605;
        b=LfNsabtbZpZHxVT3hTFy3N0qC5pxB/nqNVoYzJTyGJyxA3eNgRuocVwCABiijXJVpl
         3CQAC6Dz/rSi4nDGBjmHooYd9QgIZu2emO1vNuqYMLUNnWfYDsQMISLO4Zas+SCfJOcA
         3rOfF1B24CdXFvfVPw/0ypif2XZmaJlEtAfUEYo8gLrkrl923Xi0f2LWkS1mF7UevmME
         LfYq3RLam6WeAvFTxR1HzK3H8gcTp8yXtLcZI/+5L8X8cpH8HClxN5Jqtr5f4R1OIQ+M
         vj7YbP0Su8aAJ5PX83lLUpzN7bOZiIwLNPOTaQe5Kd1tDvZ84n2zRJ9y/fdjT7VAuLcz
         Vtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W/cZvMoDCv/f+YyEgoq0gpN2oWIvRq/EE9l8J4/P9Ak=;
        fh=WEb6hGQ5qBj2XvLtDs858H2Wk45Q5hrLmaT8AGja9NY=;
        b=PmqVZSNL+qGAT801rjIVQ0WRSqC7WWLnyvI8aDgIqXvg5A0gy8ckXpSfqnS7RPwRWA
         df3aYlLAg7bUAvhP4z0YqafKAlFGfbJ5fMLsshNyGEAHVM1uMcvfrs6ixkinLyRYwuml
         aUakoMqXEPpjjIn/K6KGP9pUKfVBGZcL3o9GTW3efEI2lTz+KAkQw5DQYBBdf1f7AIfz
         2gn6HApO3zckqRRfrA3BEkYcC23vilny18WyzLa5j64x41GRGJauRMqh8JUWP+5sUiGp
         L/ZdPSzi4307yeoNrEVQl+EytwHHunxc1FG1V1pXexPzcKQAtdkvHiDjUFLOzbNjCkfM
         +PPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774028412; x=1774633212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/cZvMoDCv/f+YyEgoq0gpN2oWIvRq/EE9l8J4/P9Ak=;
        b=eUN7izrIln0+u2Vb4AS5kqrNdOIlsHkweIFiEsLI+b2MsKrSnqomMvUO3LRvYHff2r
         239xU4hqBieJA1mU12UZVH0UJODHNIkj4YUZOhjpGlMIzbKSJO9UuV+FDh/Q1Ub0PQT4
         TaxbZn85t7Ux7RYc4Pn/IGmOjKUff1AtzEVQo=
X-Forwarded-Encrypted: i=1; AJvYcCVEGrhFKHwBlm+bZ5M6UxaCmhdqyVmm/NTVocmLIPLS7TKNZydNFuvbj28/DiBPU0FxW2A=@vger.kernel.org
X-Received: by 2002:a05:600c:608c:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-486feb5a653mr57923365e9.0.1774028412512;
        Fri, 20 Mar 2026 10:40:12 -0700 (PDT)
X-Received: by 2002:a05:600c:608c:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-486feb5a653mr57922905e9.0.1774028411896; Fri, 20 Mar 2026
 10:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
 <20260313222206.778760-5-jitendra.vegiraju@broadcom.com> <abSXP3gMFQEiC5Lm@shell.armlinux.org.uk>
 <CAMdnO-LYAPfyvM4vgmGcZgy-aagHSkP+VDmpRskNU-414j3gnQ@mail.gmail.com>
 <CAMdnO-+YWowCDh4iB9EZ=eqUidE6Mu4TOqjwyoMgyEaG=pBLBg@mail.gmail.com> <abuwcYH791D_oJp_@shell.armlinux.org.uk>
In-Reply-To: <abuwcYH791D_oJp_@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 20 Mar 2026 10:39:59 -0700
X-Gm-Features: AaiRm51daUnGzokEEKCgv3bQbjbYDVOMLsocPZLljrnpxo0gYhLkY9qweCsnxyA
Message-ID: <CAMdnO-Jx+z7ZVFyuS-MhcaPr+jDEJ6sLiAL15Q2pYsphaXcEFg@mail.gmail.com>
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
	boundary="0000000000005fca6e064d782da0"

--0000000000005fca6e064d782da0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 1:15=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 18, 2026 at 11:12:23PM -0700, Jitendra Vegiraju wrote:
> > Hi Russell,
> > On Mon, Mar 16, 2026 at 1:34=E2=80=AFPM Jitendra Vegiraju
> > <jitendra.vegiraju@broadcom.com> wrote:
> > >
> > > On Fri, Mar 13, 2026 at 4:01=E2=80=AFPM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > > +
> > > > > +     plat->suspend           =3D stmmac_pci_plat_suspend;
> > > > > +     plat->resume            =3D brcm_pci_resume;
> > > > > +     plat->bsp_priv =3D brcm_priv;
> > > >
> > > > Populating suspend/resume means that plat->init and plat->exit
> > > > will only be called on driver probe (former), probe failure (latter=
)
> > > > or remove (latter). Please consider using these to ensure that
> > > > all appropriate resources are properly cleaned up in all cases.
> > > >
> > >
> > > Thanks for pointing this out. I will check resource cleanup more clos=
ely.
> > After reviewing the need for  plat->init and plat-exit, I don't think w=
e need
> > these handlers as this driver with fixed-link doesn't need to restore a=
ny device
> > specific state such as clocks.
>
> Huh?
>
> plat->init and plat->exit have nothing to do with "restoring" anything.
>
> plat->init is for platform specific initialisation.
>
> plat->exit is for reversing the effects of plat->init once plat->init
> has suceeded, and will be called should the probe fail or on device
> removal.
>
> So, where you have:
>
> static int foo_probe()
> {
>         do init stuff();
>
>         ret =3D stmmac_dvr_probe();
>         if (ret)
>                 goto cleanup;
>
>         return 0;
>
> cleanup:
>         do cleanup stuff();
>
>         return ret;
> }
>
> static void foo_remove()
> {
>         stmmac_dvr_remove();
>         do cleanup stuff();
> }
>
> Using ->init for "do init stuff()" and ->exit for "do cleanup stuff()"
> will simplify the code, and actually make things more correct.
>
> Currently, you have this in your remove path:
>
> +       pci_free_irq_vectors(pdev);
> +       device_set_node(&pdev->dev, NULL);
> +       software_node_unregister_node_group(brcm_swnodes);
>
> but in your probe error path, you have failure paths that leave
> the swnode connected to the device, and you don't call
> software_node_unregister_node_group(). Thus, it seems to me that
> your cleanup path is buggy.
>
> My suggestion of using ->init and ->exit means you have slightly
> less to think about when stmmac_dvr_probe() fails - although if
> you still have to do appropriate cleanup within ->init if it
> partially fails.
>
Sorry, I missed the resource leak with software node on probe error path.
Your suggestion to use make use of ->init, ->exit makes the code
look cleaner. I will make the changes in v8.
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--0000000000005fca6e064d782da0
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
gccwLwYJKoZIhvcNAQkEMSIEIOjDrFYUtizxQa+Umj9q17p/hPIJ1PoQph346uqBvFJGMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMyMDE3NDAxMlowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADRewii5RHsf
ibILKSz9PSvvaZkgQJUIMEAg/gXysZSPaCCYgeWGc1Puh9bQiW5ol29xIwwW50CJbNtRR6CBF6Gm
qS92udIowQxTHsZX327AE1fGVpUbLFiTQwUxZ8t00+wT36OYnfw9q2Mhg2dsJ7iu+KDNZ9hoQXi/
Fa9QrpPoVQ8YQH4uOwyT4y9vCSK3zHp/HZpm2bleu6982evMw9zz1CcjP6OlP0SbNjtts3yFG0Xh
nAQ8ETe5ekOvXqIYA3TtA/pVDwCoGXPt+yLCmzc33271cBHmcFCqu101U8aoTeR1D8PJViJ9+C+N
0TzMVdmSHKgJrO/BYI+ZRokmfhk=
--0000000000005fca6e064d782da0--
