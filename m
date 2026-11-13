Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573425;
	b=QdJ4z51vABRfqi+eD3HwDBQbEX4ko4ceQ05/t/KaJOL0YgaG1eF7COQSYruXiJIwZ74Z
	 du2jAIzgjdSUZyC6DBtuLV8847+Bp1EkS7lKqKGAhg6OgprL24pj/5fQKZFRc/dbkAxnX
	 9pcpLey395+N/ht4Os5c5LR9CbkNvv+qvdA8/IiO3dx1VIa8+UJ6WAQbvorByJDsNH/P+
	 JHB/TiEfA0sktzlr3N2VYpLz4Z7E//Ts/OA+3qkUgAbkAvuU258L/t6WKZoAxbQDOfaq/
	 yutBrleAU1bizpLxjyTT3H5WWnaxLdNqzTl0zLOSao38ATk451vd5RtQmq5tZJyDriQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
	b=v1PkmMdSEztWwki/c6Yp8oS7cmzXpGPZWhiUS61CEUEleXM0eykXDoSh9N6vFEmhuhY0
	 I9AgMNuq3aRCxi/yGxDL/NNEw0LbYoOIyDP3lVNxuGG7Lb7cVBSzwfnHvPeZ3PzxHQYsh
	 Wf3sxVTeOnT9OMkHn1K1vvkjoT8849qz78EaeQvpQXE4yFFF8dF/G1vQQ9rWAAB+0LYMx
	 ZQoxfozRcX4AhN3RBtRv54xcTvJTx71L3DhNcfEQEOZE5pL2SmiqV73cbhrOodRZ2/MZd
	 7eAT76W954vqaHe76l5pzNKnHMRsCaSz/sFoZDCyZnSlfFUuZK0Is0FfTx0FTk5AimA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907B606A331
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 12:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D907B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so3542115e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573423; x=1795178223; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=n2XPHptJWAiGnWBjuWK6g5NkFljgiKFcabC8Vn0J/U7Rs5oCxIs8ae//bm8icbKFtW
         GhaGag1Xoi7ZyXwdHESo4gzqQGVIFHJ4SWyDVffZrMrzihrR6J8Y41NroO1pUm4S3UEM
         GevRMV87lpSFNCzDE68IInZGbL5X+gYDk7IApotAPKeUo9xOfBbHGBSC5mcggp0KJBcK
         Nc+e1mR1SmgmgC0Frha4Bk72pKDTzd14yUseYASwtvG8qZfbG+gNn4GmoQhA8ODET64L
         X6SskqZIriPJvj35d5mhI8G8hobVKdLKjnxeG6bMHAYcCPTjUD9dRkaaJK3nWVTXV/IA
         bDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573423; x=1795178223;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=kte5+b4KwhKQIrgyfw3wICts8KtkNg947NeKojIaiTdJhn4j1aPQLGcGnxNm/O0Sm/
         8hNV6gf80vS0HB9P1KNYBC/rWod4lQzLM9deXsh1DKZzeOZuWacWXuNovXK7h4WORrcf
         eFBhqBCE8wUY5k+I4FPKhfbiFT8Wag0yf/h8pG7/yBp9vbIIl6mibc1IlxTaGNI5VA0L
         AV/pJcJWqdUQLheQukATauOTPXBrqZxZsgIyQUJkjZAo0epFe0n/sTRlziDl7tlkECk2
         QrQsBcOpbnkkQ3W6MoNVJ0mUfglObn2JR++vliKTKmtXdSewy+XthF8/X6pUhh7x6VDr
         Flcw==
X-Forwarded-Encrypted: i=1; AL+hErEKUTPnwMiY7EUoVnMYk+2IouEwCrEMLqxWbAMci0uq4ep7oBiLXasBpvto9N21ST2jbZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CK+1vksMjC8b1zPvUyKRLIhwIpmcdCnJdDebs/D0atuH1A6/x
	KtMJwybvnwA2MGBNjqtzQEJ6lkNDKeYolw8VqJLUG918a99QK0smoeaqdsaiQWhy3yYr
X-Gm-Gg: AYBFou2uybbMCnZjb+yJf3ihU4ly2/u4p2e4KODD2+vLEMMRQf9pUVTTyIC0j3do5wO
	c4F+/QdS+fiTuFy2xgatzEuRvlP4ZFHQFZvMIgW9ikxLXCrRKsT7En8AVi0V7l0ImzPOc5Ac6By
	g5x6tn73EqJBVML+6GxvryD2ZvcWkdj98lLjop9oyhi2S7cLABkD1yO5J/PuUzpjygPEk5ajM5s
	mIpHVQoESYbAnW017XswWoPgTTCzyEnZaPL5VZ3vfXKS0Bswxw0u1+/uTTl1DOKSfiU7aTq5f2W
	V7KSd5FeQccrYfirAZBjaBpHdV9AWnR/Sjmfo+hpWgxSGUc6vbZkMx0B65xmmSHDNw0QFm5cLDe
	Dm6r8sEhRPtvme4TnJNq+noMDcIpvGAAtcNg1PoISSpITAqs6Na4Wqw++0sTSPetukMN+uvO6r8
	PxU5WbRiONgq9IdnQOl2fR5GhF3hscfArEx3Yxe5Biz0Qy6U0TkCR+dogs4ywAKcWgW5tXhW4As
	Q64Lf2rNwRDoaoFKfsk38Wt41ZuF7cwQIC3JiI2GR8OQ8CeosMTbKl7xRUw4xvYws0/wlEFl3cf
	NDLnvY2oU1E0ToJYZ99DXlfx0d6dWtMuCDEAwIXhXbveCqEdlLCc2a9Ff3o4mdXut10SZg4ynkj
	zZffOBvC3
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr49782945e9.34.1794573423157;
        Fri, 13 Nov 2026 04:37:03 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm57437255e9.13.2026.11.13.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:37:02 -0800 (PST)
Message-ID: <f12140be54ffc4d1e8e4026f80c41c75cf5727e0.camel@amutable.com>
Subject: Re: [PATCH RFC 39/41] usb: gadget: f_mass_storage: refuse files on
 pseudo filesystems
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
Date: Fri, 13 Nov 2026 13:36:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
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
> fsg_lun_open() takes any regular file as the backing file of a LUN.
> The
> file-storage kthread then reads and writes it with kernel_read() and
> kernel_write() on behalf of the USB host. With a procfs or sysfs file
> behind a LUN the host gets to read and write kernel interfaces with
> kernel credentials. Refuse files on pseudo filesystems just like loop
> does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/usb/gadget/function/storage_common.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/function/storage_common.c
> b/drivers/usb/gadget/function/storage_common.c
> index 75831f2c7abe..83683ade20c2 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -211,6 +211,11 @@ int fsg_lun_open(struct fsg_lun *curlun, const
> char *filename)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(filp)) {
> +		LINFO(curlun, "file on a pseudo filesystem: %s\n",
> filename);
> +		goto out;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If we can't read the file, it's no good.
> =C2=A0	 * If we can't write the file, use it read-only.
