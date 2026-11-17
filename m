Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904117;
	b=TjvGfHiBYnZud/+D4gePD69t60O+sK4TCBlhVt2QVWnuLSonINuVMMOTihqDW1OHIn6a
	 JBdVmF+jWRwzRvXEIFvSNAHexql848rwOa6+lUq/sPOJS5JxKn3sZQqALNSGymyNskzoe
	 ZDi6aGN0gE9kT/73Z0NLvrvSfyT2z2tQRIBG+BcL4RfjIQIxAr4SlJPO5eHlYx6xYOKaq
	 uQ8tCGOnPvtHhGC1yBHZW+CJwA7nB5gkJVd4HQKo6qW/pFYkr74BGT0WiKqplH5dPlyEE
	 BwDpQFILShTSLk33EEBCXloA9+7YrP408HDaurLrhxUurfqmuoBLjNv9Khk7LHh1fGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
	b=gXAt+HAa8oj/TWWFoNnzMLb+tGdEcNy5216+sgZuaWk1FTDOClvvCRyQIc2MD6L0sAmT
	 qwv4++yPb/IlA6pVkXaxmRkG2/zwfQy8j79WuItaTuzyslPq/XXX9N/yaZvrNP/BHWRen
	 /Zr+hBobIdz7Emv1wv/RjTFx98y40+KG6VzMWyXf+w/kkeSQ0eyzMR7a/Wa9sjLuAVDAm
	 JJRPIyqJu5HctMmUPYKWBAQVBtBAGOGRZibX7tp4+O7vbaqoCWp9yBF/KNPagsGiISlFl
	 SVpRTQnkLFb26sCEfET6tGTolTj0kf+AKDbMQOi5Jqht28hUQ9M/lj/tZqJelbvxErA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="lDHE/E60";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82E60A260D
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE82E60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lDHE/E60
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so12248135e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 00:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904108; x=1795508908; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=lDHE/E60fAF7y/GcfWe7zssqpibfABjaDWc4DbPAbANFwY7mipSCQzk/tGna/Yk9Yp
         5M31Ja6Q4S90Eg4jWdoE2GH6TurYV9Y9Yxd6SoBGFySZlSGgcD3Nf8Ac20Morq/IEeLi
         HZNDCkpilOoqmPVEk/N5paMQG+RjNO9OhPzIDtVn6k+5pNMY8rSlnV+zGCrptyxwBw8i
         uHdMwH/Pby0zhrQLCKl2b6izfUmExSZrUoQCnWP4NFP78u9vhGGyVwUcvE3no1VAV9ln
         DDlxdlg3j7mlBLcF1wQFzdXfstbmRKgVspXMjOajtHMeg5NsSNAba7k+RMZ1HFntU+s+
         8A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904108; x=1795508908;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=cGWTStY7rOzqQOFBwp2AZMZrxWGrfU08NuZoTLq5jn760Nc80eQe57g3IaAEp+fdFJ
         ziKve4vjfVzfBXN9KbLlldE0itSb6v8tu8NQDUYrtcnlDUkiIRKBddzIbZSHiGccCHO9
         cTGj8dCr/d3TSS6Er3zhuYuroo2GX6rtMlKZ5s2wpV2LqQ687WFMwh7XBLpNEogsRe6j
         KqtPG2F1tXMnhOlwsJV7l6TKo3StkSwQYvFgOV8B4rFAGCFkdeOTqWz+UnXAlLgUsLC7
         JKgG0ZZTWTH5VBg7lKT9BnNdI8u0w08typIzURb48wGO5+DJX5vYSC9iisrO2ikjHCuL
         VQ/w==
X-Forwarded-Encrypted: i=1; AL+hErEoLxc3LT6uU/Q6LRzhLrQ4y36oyqHcDpMwu2VbdDM7YuzPaKVymGNSy6gnnPdOhktIRSQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bcc1MkrIOez9DNukMtYd58wjqeJXeQ+Cfg+RyPmdAyRTmX3hP
	tLWna/w8M991hGS/07uncqLTA3h6H50dRcnpG6oKDL2EPvz2WA+5nufBtqhcckqfQEeb
X-Gm-Gg: AYBFou0bCo5b5IljcR3m/4wp7if0CbQ5vjbELeB2fmS+e23f6f6WDTRx3hzCOkd5RSz
	VbDjpiRTdiANmgWEQfiOgtjTp+7kyN90lEkYuLU3Om/qvZSaFtPGDMm7CiQL0a/AC+LvsYnSSgR
	e4sFcVdXrUYru/XjzKaVD2dTUxcvHMh6esdHg/VFQZVwBmoV+q4mbIytUbkxFMrmMX/4dfnpB0q
	DX1Y32WY+kC94KfrNufVUeLDzk+oZk65pr4gdyKaDvZyeWJtPk1PovQ7WzLsRyQ62EW2dhzhbbv
	CEOfO4Szqdpb9aUVLiwC/oeFN7To5yxb15PCSDcEZoiC2JgLs8d2YNN+BHE59RZYELy6aEvmWRf
	DCaKHPk1Vfrh7Ov1dD4ZNelUZ9efyPAWqp9AAROvlTyk1QLCdX9NsI6jpc41JCJEaz7Wr9ZQ+U+
	9sITcjJfeUpWgSs5FCtCqRHWmUbfuJ4iajyXvz2j1Hl6gPz4S+jQIOZjGVkm32eLRGGUNsBPODa
	uAJXtBGtbMLlq+S4d96jRG4M9BUpCoJ9DXV7o0W1zl4J4AA0il3k2FBCHIu2kE/JZ0uKeC92VdH
	NzFEj6RUobUpX1dQtdgWR7ZswEiuX3N1MtE5v35eRLWsweRey5WW2FIfO99EU/2ioV0zMZtXdJt
	SSe+A7zOn4EIRqXggABnTvoP9X+WsQ62BT5a2ndEllq5m53xTEmsa+Jri
X-Received: by 2002:a05:600c:6286:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4bb55a5d634mr255399085e9.5.1794904108278;
        Tue, 17 Nov 2026 00:28:28 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm75197335e9.10.2026.11.17.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:27 -0800 (PST)
Message-ID: <afc070a816e3ae5eb3c9e2d62d4f25c59ee61df2.camel@amutable.com>
Subject: Re: [PATCH RFC v3 26/44] xenfs: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:28:26 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize xenfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. xenfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. xenfs maps the xenstore
> page and guest memory through privcmd, both data.
>=20
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/xen/xenfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
> index 37ea7c5c03469..aba7d038ed735 100644
> --- a/drivers/xen/xenfs/super.c
> +++ b/drivers/xen/xenfs/super.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0
> =C2=A0#include <xen/xen.h>
> @@ -80,6 +81,7 @@ static const struct fs_context_operations
> xenfs_context_ops =3D {
> =C2=A0
> =C2=A0static int xenfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &xenfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
