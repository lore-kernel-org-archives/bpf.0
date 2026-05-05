Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB63A2570
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984066; cv=none; b=UWCClog6v32+B9k8skOf6x7luT1O7VtOQDxcQS+8vFkdxtmC2nhl030yEik+e6E3LoGdXpjgYdmR6lV/40HbgGvo57WmkQTHPwy4oL+PcvQmSGuoFzaYlKWHxE89zVUv1GMJiK6JLFZsgrGwKkgzxEVFDEUxCeA8J6mk0Q4ieHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984066; c=relaxed/simple;
	bh=Fa/3962kpvhdF7V+0z88Zf2DU1hMlF5cUeKj970O0jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C12Kd1jvthIfoOHAD734QghYV87+bx/FwxAv0kzHxUsE5RVh2paqY7Q/BjejBGWvQH/FDMIH5bbcnH4p0+y4hkiyEa/8IDrvLjXis7Qz+gkt8qbvLuz0cLEsobZu9Ep5iJy0ihfeUy+rA36sn8t/Rb/H/OfX4t9VKodUICDIV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=S2KQtR4j; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="S2KQtR4j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IxfTjv8LOMYjfUi8h0wbVoUSkjcjlTLTPYdh0YikeHc=; b=S2KQtR4jzO7j0+clGGWn4QIVgT
	3tICv4HAfSV2VzWGeprV7p4BQxufNYl4MRzi3ym1YXFVMRKvBZTpHSo4qcIUycHqNlUT33xHHmc4d
	0MDd+hpRiFhUiZgqGT0z+/ybU+fuwnWJrH5CtxrjawJbgA0bu2aLsIIFdm7/SJBsdXNd/tiFsfyJc
	mgl65e3Wzyq0qfChUwT60zP9N2cXfgDwX4ZQsJueElmg6WvZ9Rt7mymSXyy4FpgBoJgInYEry8wT8
	/g1dfBk6TZoNl+3SV4akrd4yDI9DHlD5VuLK5u4T1BA/46Pjb8BWzFMH47nBKiJQk2+p6W2VfqKmj
	BKIH+8wQ==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:17959 helo=archlinux)
	by pf-012 with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1wKEsI-00000003jl2-2Hnm;
	Tue, 05 May 2026 14:27:42 +0200
Date: Tue, 5 May 2026 14:27:41 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: sashiko@lists.linux.dev
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v5 02/14] lockdown: Make the relationship to MODULE_SIG a
 dependency
Message-ID: <afngZZcIZnZ2DrBC@archlinux>
References: <20260505-module-hashes-v5-2-e174a5a49fce@weissschuh.net>
 <20260505093229.D8CD2C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505093229.D8CD2C2BCB4@smtp.kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

> > diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
> > index e84ddf4840101..155959205b8ea 100644
> > --- a/security/lockdown/Kconfig
> > +++ b/security/lockdown/Kconfig
> > @@ -1,7 +1,7 @@
> >  config SECURITY_LOCKDOWN_LSM
> >  	bool "Basic module for enforcing kernel lockdown"
> >  	depends on SECURITY
> > -	select MODULE_SIG if MODULES
> > +	depends on !MODULES || MODULE_SIG
> 
> Will this change silently disable CONFIG_SECURITY_LOCKDOWN_LSM in existing
> defconfigs?
> 
> Because Kconfig's savedefconfig strips out automatically selected symbols,
> many in-tree defconfigs contain CONFIG_SECURITY_LOCKDOWN_LSM=y but omit
> CONFIG_MODULE_SIG=y. Since CONFIG_MODULE_SIG has no default y, it will
> initialize to n.
> 
> With CONFIG_MODULES=y and CONFIG_MODULE_SIG=n, this new dependency evaluates
> to n. As a result, Kconfig will drop CONFIG_SECURITY_LOCKDOWN_LSM from the
> final configuration without any warnings, leaving the kernel unprotected by
> lockdown. This also degrades discoverability, hiding the Lockdown LSM in
> menuconfig unless a user explicitly enables MODULE_SIG first.

I think the bot is correct, powerpc/configs/skiroot_defconfig,
powerpc/configs/ppc64_defconfig, s390/configs/debug_defconfig and
s390/configs/defconfig all set CONFIG_SECURITY_LOCKDOWN_LSM{,_EARLY}=y.
They also set CONFIG_MODULE_SIG_FORCE=y but do not set CONFIG_MODULE_SIG
directly. The new 'depends on' condition will thus evict
CONFIG_SECURITY_LOCKDOWN_LSM{,_EARLY} from the generated .config.

Nicolas
