Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564960;
	b=XOFlNkmfc01DPcs4JZhM0TgVpyqW/EIuMXhYLxnkkAlzj3oQCfYAXuFF1XNrLF1jFfx/
	 IWVogpLwZN39DGHiw1lmKExeXZH7rGFk4JiYbVhJEnQBnDukVjjsnCGSiZIrBBKLOV81D
	 a05OXYL7X882TbfMYtdxuFAVujLyDVSvIhWKGnZCyNjw/n2UqhOkHNYNsQQgHlscCLFiQ
	 k3Ak9vQrFLlw1C1BspQL6kBzaZDxCIOY2I9hYx2GHLbE/AnpcC+kTyNopayKVsx+tOdMg
	 aYMCppV5Moy6mKzpGule/+yzVY6XdGLrrZpatZ62OqHTw16/V1b4WP9iOBdTLMW7Clw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
	b=C854KPbWsCEUZmw02/6BZ98xU9e10Ako492aFxSAnPgN38QW3DBQZfO5ifTTMDhrTkid
	 X2YFQwu/EMlNFJQtj8eTjZIwu+tXPkDuCDY/Z/knj82EWXsgTwazlTAdvfUUCLonQNcnN
	 3S/28ZxPwCPetiT7IQ5FW+64IBTUc65ehY2xnRnB8/eOiAW1CStvc4+a/UNfaXS0sfNFU
	 nYQTK9yWHIuqc1LxEZXY2oJdh59AD/qKa6lu1bYR8j6xOIQk21b4SwtS5f+IHJGh+GNiM
	 Noyh5zOhsyUDivocLR3pKDpsi8CCtC592djAneKpXeh0IhkxCQA7FWYiM58YTRli+jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lkMNxDps;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4375606A8BB
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4375606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lkMNxDps
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d21051042so151914766b.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564958; x=1795169758; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
        b=lkMNxDpsxePjk96S0ywzwnWUXxYio8wx2cNNe0nC6j26qPYCKZTFlNU+9IrTfafYUJ
         vVJYUkmMgC1UbEefAlU1yHOjVK+ZyaavdAq5vDpOrqfNUQTfZSYOp+z5MtAN0fGM0C/g
         WKoVDnfAgRrvHWrOgLujvGV7IRsdQm2D1xIiTvFC1PPHHAhefB4+1EzNQGHJZGVEqqG3
         mRj5HPfDo3Do87jK8wkSwQeESRRW3NHA44wwS7GSfUWi+U+GxhbfTaI9vHs9ExXVB/2E
         aEkBTT5WDqLpZOCj3LhS4i2xxQF422KmjG442iJAtFRLE9RsLg4/ErcRXtOWPDB+ahLm
         /22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564958; x=1795169758;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
        b=LnaRIBU+I7wnMT49CWZxekELIQU8eC7r133th0/k/xBGVqixW9MzS1r9y52uLSaCQO
         +rxn1r6b2gTlV918Uz9rJKD01U8foGz5w8w7wjXMRunWC/fLHP/0QGvkJxGqwXFn+Yuw
         Px/TSG7jUkZzS5o6P67Z6mlWlnsZjBx+d2Pyg3Ymj/l2yBywRPzoHxhZOU4rDl7QnhNx
         J5rQVw0rMpDGUeMKNiw/Oor8zZOXta/6kX6MD3Q1VE1wsZniDdf2vC/NyG05GXFFHDl6
         34m8DpvIBDCyHMEtD9F5lfPR3A5gxv50NddJm4AT4NHY8NEvcoTSfXhtQS+f4h/6dmVC
         rD+A==
X-Forwarded-Encrypted: i=1; AL+hErGgRTjXxS38t29b06xh3ZYwiOJzMS6D5AggSgrPmgBbqPpVKbBYrcGPXUOcqjEvUGIpioo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9c6CHzpygK7APqDhl8hrNUcZtCjA6QRF6AQkoDjhwLYSB5zgn4
	nWMDsVIDtQRaS5XmLcgMHO70thJU4OhGoST88pcprwzdOBz8zE0TN9QkbuW0O4BdKtcH
X-Gm-Gg: AYBFou32gwH6Zpga6pAwddNNTB3chPfGUf73NlyPclS/O+fPxIC42kBYhFdYw3MmpGh
	W0gvBgZb8g3ifdyKAzMh+tTa16vE5z/e9eyrDmzLIbCc/kqT1GIM1zv5dxOdigFmRbV2LQuXsAB
	WhYrbSoaDzrBChhZvgIFZ2U68S0bk2kZ54y+eruvKKSNt6hv6vc7+GWs3XlyDsosrx7z0JGvnGm
	7/TI5q/9DoFpT+I39iswMuy5EPy6HKqE/cWEjszn7bshWBqCCJD3+mmdQSIg1edS0ywf5w2t5We
	zIdIoFxOPzNOdsRp3Gy4SF5EvCB59a5YnJi9B2hAklxDUOglfqdRGVYiue7zqkVslOZO0rXVcXN
	U/cLw6JfKQvEdKq62TAEo1t4R5S/CeS7OJXe2Yu1XFU2CFb5GWHVlW3lb3Yl6gToLqni2saHpIg
	B67OALxIMjO9imTWBy8gxP0iI4wm1qe1E4I8atPS3uhjtn2fEJKMfnMobFIWZuZblp+mnysXRQ+
	Gt2n2pTZ2+F0aDa6yTiVs9pVsAJR5H0dQHQUUvjsIuWneabrteDC/hq4JbLZsQKLCVIdRRAEMCQ
	6uV70u3hvLuzEqrGcvrgxeTK0LikrBJ0xaw9ZiSYuIGvG783iOe03rD9wt0HTYY=
X-Received: by 2002:a17:906:f59c:b0:c42:102f:15f0 with SMTP id a640c23a62f3a-c509614d4c1mr171873666b.3.1794564958075;
        Fri, 13 Nov 2026 02:15:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7d1b7sm75606066b.74.2026.11.13.02.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:15:57 -0800 (PST)
Message-ID: <c5a694991af7e9182fd475a20bf4cfd73a13e395.camel@amutable.com>
Subject: Re: [PATCH RFC 34/41] loop: refuse files on pseudo filesystems as
 backing files
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
Date: Fri, 13 Nov 2026 11:15:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
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
> Currently loop accepts any regular file that implements ->read_iter()
> as
> a backing file and any that also implements ->write_iter() as a
> writable
> one. That includes files on procfs, sysfs and other pseudo
> filesystems.
> For example, /proc/kcore attaches read-only as a loop device the size
> of
> the kernel's virtual address space, 64 PiB with 5-level paging. sysfs
> attributes attach read-write as 4096 byte loop devices. Writing a
> block
> to the loop device of /sys/kernel/mm/transparent_hugepage/enabled
> changes the THP setting.
>=20
> That's not just nonsensical, it can be abused. Loop calls -
> >read_iter()
> and ->write_iter() of the backing file directly from its worker which
> runs with kernel credentials. But pseudo files enforce part of their
> access rules at read and write time against current. Dozens of sysfs
> ->show() and ->store() methods call capable(). Behind a loop device
> all
> of these checks are done against the loop worker instead of the task
> that opened the file. And setting up a loop device requires no
> capabilities, only access to the device nodes. So on v7.4-rc1:
>=20
> - uid 0 without any capabilities can't write to
> /sys/kernel/reboot/mode
> =C2=A0 as mode_store() requires CAP_SYS_BOOT. Writing "warm" through a
> loop
> =C2=A0 device works.
>=20
> - uid 0 without any capabilities can't read the files in
> =C2=A0 /sys/firmware/dmi/entries/*/ as dmi_sysfs_attr_show() requires
> =C2=A0 CAP_SYS_ADMIN. Reading them through a loop device works.
>=20
> - An unprivileged container that was handed a loop device can't
> change
> =C2=A0 gro_flush_timeout of its own network devices as
> =C2=A0 gro_flush_timeout_store() requires CAP_NET_ADMIN in the initial
> user
> =C2=A0 namespace. Writing it through a loop device works.
>=20
> The same goes for hard_offline_page, the md and sd attributes, rfkill
> and others.
>=20
> Refuse files on pseudo filesystems as loop backing files. Note that
> file_is_pseudo() looks through overlayfs so stacking overlayfs on top
> of
> sysfs doesn't get around this.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c96e35c3ef42..1482580a1979 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -537,6 +537,9 @@ static int loop_check_backing_file(struct file
> *file)
> =C2=A0	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if (file_is_pseudo(file))
> +		return -EINVAL;
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
