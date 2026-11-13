Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573510;
	b=EOMF60CwNQHXzP6JEo8jvrcZAvIzXJG74lNhzqKAGrDpoZ7EMlkaKn9C0C90umHcnVK2
	 Uk9a1V1I/dEKOHaqU92hsiMFHRprgOZ8W0g0S6TL8p496yyDbRVahbSsyq/k/q5MvEzDQ
	 yMtgY0qjC/Cwv5b1MocDN7rfazhmU/oWdasR/Zv60FRSRqjwc11kXFWCto74SjK5IbBE+
	 MMQaQRgsSUAUJnq5C/gCX3b5i6+Z1Hz//Eyt/XF3eI0eeOaxyMgqH3GZur6kNf0EHZuNh
	 qU4xDdKDdd6Hcx7rdre36foZW4VL06KwzfEQBpGJhZ5bJ3Av4v7lWkKLVCpiBQg7bIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
	b=GGyBiH9jLjFNFWb7KEAhKNsTpqXsU0oIvIUKrlQNlGz6QkliJLqXMRiGdGhdMk6stwJe
	 jzLBHJBviZSoMVNz1eQIWkNvsegrtN/iX56r/yCie5gqGzaDr9WbUSEjrsEf918nWcWVj
	 AQyNe1KQW4/LblwtOA4hMepVIH3/3fv29JCbZsd+iks2YICatghS5TTQpebzeB2enMR3H
	 GzgfS1rzQoL9y7NPmH/WJPTA3rAwXrOZ0HLjIO2x2CMIiH9v2DyUtRQhlsupYo30nme+f
	 Imp4ZWK/VgjBPKjWCN7WHRwCYJeZwbLD4fVrvdvEhvyTJKpji+YNiChi2dG0EWjJhFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8826606A336
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 12:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8826606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so3649055e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573508; x=1795178308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=Bz2+TnPIApHKvsf08kyiSuJZ5AWViHONwTwuNXVAuo2u8JGXjKnEoxSd3hG/r/h3b1
         tdsUEBtaZSOWfU3+mD3LjyqvBKt9Vc6RBsvkZZTD05u5eCDGhnWto1Wbu/C0r64DVVdd
         h2TGnt6meedDH7Iwjf2Hw2JxWOY8jwAvEAcAC10FURsf5jjp4p/KJzFYjzuPwuYFNKea
         Iij0h8HoPs5opXKf2XwMBJpd5hsYSV0+BHP/DvKdCCgwNFtbeIFAwqDf2ag0NBOCbqs2
         OXWiZmXbdGCixyOlqQBMgrkFkrhg1VmbSdmvvBdeQ4Vz+QMvhYl+k9AO6FJ5UW1pg6b2
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573508; x=1795178308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=CyWagTmVfgkZLw14ithg8ohj64emNuyatDb8mjRgcx/7flkBiuYf+pdgOQnjm81ceL
         u5yvw3cxW3BHYM8VCCMF87pm5+O2+EnnmBIsYlJcle8uFntFbbI+rFN/M6SuVQcyyFwy
         RCgpTdp1LVkd+FoMSBznPPCMmUzkGh3NXEPz1Uir1R3Wm7BFIZViPxIjPtipQekY4GWS
         7mI+o1NZAZGIyx20KybJtg7SAlSfK9d6MDbfkQL1itdQC86Kv7IV6iJEFGwoJRhtksA5
         2nFl7cQOy+q5GxQzLJVc14zJ/s1s05QAjDuCHPFKRPDiFamRsODPjeXr/aDVTaKHXWTI
         m0Ng==
X-Forwarded-Encrypted: i=1; AL+hErH931wZqWzpNIwJetvDS4oqPMu623qMxYrV+J/cAXTVCPnlr6MK971VFjCSLh4jRhVrmLs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4DwufNuodOiDkqm6Xz9yFJpiV3peNYnabKUVGjyq8JcZ1YkEY
	bSuK5FzejS3JKLkR5G90qB+e5qKWhK5AXJn259aWNHKFWDA+GaVFowXPY3Z2Ei5FTDYk
X-Gm-Gg: AYBFou0xvMBDjBOkU1TgF1dAdLmREIw+zkM9yQH/LU8ise19AMcwbGbAJH88tFJ+iml
	fG8bg0r48Eadx793vPp717pCQul9F3nUP1M+HV/k/3von6M+ZXtwA+v6QUO8ymeYg1B5uV7cRXR
	W/VnXKaNJLjBA0ZNjRcggh896O+Bq+y1iYDoK3GUv/0XQbYJbmxPzkFU0l01Fwb9Yh2ctNwnpBN
	GlNBnRl6pf3De1SaACOv2uxGArswOssrW3XRHWzAdUpK7cBkZFiI+T/iI9c1FXHv5GP7S+jwq82
	tR/vbm132ZkgGK/my5nolFKFw+l8H9eLTERhxLRx7qmaKmFeJC18FY8vEcGNFfWohVGiPy+lSPt
	IuJ7o7gODHcfmJ8T9x8Ysp+sb/FGvHMpXRC/+9/zxMvb/zFR8qwW5cnejZ/c7HALzKne6QP2Ehc
	KNjt27G/jgUbkdcb+2pRuHL5LmSqtRm6w4eMMW/D9DfZEWl33HpWoHAKYb4X8HQ4CsvtHT4wE7Y
	60RbGV0iIOuRBnU5GecOmF18zSJdSGAWdq5f1i9frALqOPzo61u0IPSnyXjlqGD2OdCTQZu2+IM
	gvLdcUfE3qnFA+b+kvMby8Nh8SZ1lRe2L4slA2oGThaFVv59rXbBKHnPuFKW/Fw=
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr24790785e9.11.1794573508217;
        Fri, 13 Nov 2026 04:38:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm48348475e9.2.2026.11.13.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:38:27 -0800 (PST)
Message-ID: <28a33fa649dcaae2eadcc934ec49fa591ec1c283.camel@amutable.com>
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 13:38:25 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/apparmor/apparmorfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/apparmorfs.c
> b/security/apparmor/apparmorfs.c
> index a99366467217..351ea3a7120e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/rcupdate.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/zstd.h>
> =C2=A0#include <linux/string.h>
> @@ -263,6 +264,7 @@ static const struct fs_context_operations
> apparmorfs_context_ops =3D {
> =C2=A0
> =C2=A0static int apparmorfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &apparmorfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
