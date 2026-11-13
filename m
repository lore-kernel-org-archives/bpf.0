Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565649;
	b=3pEO8hADWfVFnEpo190O7W3fG+3I2GU4iSv+HJshaVH9FgjAW+qhEUcaAsFIazxLDwzq
	 8r+KBEv74eOQXzzjjCHmKJYhIgBdhYHV+HYDfX7q0wIt5H8F131v9RTgyC+Z1LEvtk1Nh
	 yquCgC/doC0JU/9/4MfZ7sLrs6NIJpDonaw/9tD8CX4DxLzvPVI6DYqS1y9yeE2Zt2Bcj
	 Ahvlv1eCqkv7p0cH3hczUgpNUv0us+DVr+qJjHJOpXYvnZx+cDTyqNXzp8P5fkVgvMVoN
	 3QhYX5IMf2pG72Ik12LKPXK6kWn2Eqn5dAWwLHz5eDrEz0zyhlJomqSbljyXZj9Wcfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
	b=rPZYXsEIOLVTvvdZ9xbJz8Yc8CYllORlvQjhBUQLy0xHFU8FLU55A9wOqJYEAk6jnjmm
	 vlJaw+jsxUtP6ezkbAUlsYLctPQfxpX/sVq3Q2PdZBm5m7b2f0KmU9Alui6As4yquLx+u
	 EK6+5Srdkmun8EVRCSKbSgarBsGjTx3IH+EZrCa3FKV3ygOf8yOpJJLhXNE5JtukAXMfa
	 tBGLcugdprEYoysf7J0HmtG2tmKBIcZZ1ZfvgapM+cISkBZ9YY4VcK7fMx0HXt/w8qudb
	 am8KpgM2r2SLWkT9IPNZZmdzyjGj00f+iyW8paWnKhzTvmbvZlsvxevZSVnZKD+gT8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ff61ik;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFD606A331
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCFD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ff61ik
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-491846221ffso783336f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565647; x=1795170447; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=N7Ff61ikIQ27nXVrR+i5fFuiFp+kpNCkSJ8kzzwXsWXF8oHPQYaaEtIn2sVJ/R61Yt
         eN/EgbWtaqyPzsaKr2MVnoSj+msmKBheiZS6yCjGNfIw7Nev7hKixHBvdeyifMwCAuyY
         p4HuC2pLhsdw/6s4IDRTQYVk2XreSuuUeA2/lEtpnIKw65+UPm9cBNCU3JmsoFXsrPGj
         WUoovGImF4s4dFS6xRIsBa0e81egoKAVqgb5m7AbWjvbiu6rsFasaFfPaH+ik5AAKzYn
         61DshIaK40jfv3WiwMjZKKDrEIOQNGX/IDgIqQj4sI1tIu9ZETTA/xF/QESgBcPouNO3
         9yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565647; x=1795170447;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=vjquPVGYSh5nCd0fuRGYnGB9f2B1tHZUPQTgi1C5BCyp2S9b663p6032GdYA2JaH71
         QpDECgDXPF7ZOpQamV+pbtve9o8Fs7y7hiXRnXLR5tfJKXyx7mrGYRJcnMqrzkp/5suB
         ZUtYMigLE/qvexPnll0T6PySBk9r+XvYUtQ1IbnnLSyYnoaFhNv6PFo37qiEcqIyn/vm
         kTWDEgJX5i2lb1a9VQPj+lhLPBtwBala0PAdXlmifUWSFDS6NUT3/9EQK3Qw4vgW6zQL
         OEpotoR/Nfj9+XpZFzEVJOj7BD10C1e7kLx0q6IzN+0CVN7yFMjKXAqaAOYpce30AzQW
         C2YQ==
X-Forwarded-Encrypted: i=1; AL+hErEtYCRnYWWLu/TJmNZzx99290JABT9EemLH478YE+WFsxiRhpAf8MmrkzceF/XgBlPJu3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8R0XFkk4ccIG8QeOTUJTRFYcx6K7zQTQHbsLKuZsTzGtDvCPwY
	djZ4ESoe8rJLsEEBKbj6uapdAx77/Lur0dprlTLogdV1aINUgddtVf6a+7o3mevACsIx
X-Gm-Gg: AYBFou1DYvnfkzb2sHHE8BmpEwtEEBNQtjTsTvom99g6MGazgfv0hDIzXVtroMI0Q3F
	ezx1P3iW2muhAOPm4sTb/JmZqX0Xg6lg/fPkRfBk/6qVldYtsFmr15uU8QK/t2hTUvSsoXN3Erz
	5g4+ikwlvyIvdkN4zrWX9eWceIlnlV0GzZkC7NqBinVW9utm9DL8CSSCQ29wqc/1iU5xA9zBjnR
	PpqhzbcRQBifwNS0BpI4zcMpaCnNdDuj3eHNNO2AC6L0N/kYYbGbBxT66jvA7R8DUvtgplUjY8T
	Og+xN5OwGMXSM4dw6XErwbmy4Tn9G09iJAszk+f3l35Aw2QMR1QMcK4MCKIWQsMPHsLwKF2vNwT
	C8qeX7euM5R4j2HjFcpXRIuMauvhx3kZHFClRETrkwg3clnqpsR99erqYJnk+RN9oWhK/HK+fSg
	0EJ5m1Xbwe744fNU9hpZ7VeHSorRThSepYJsEVRtPFy3gWuiAlfPOXHOGBSy3Gd5rXmhMgElnSf
	mf/TUMQv+m7hI8qmYSlGfExVaNPi4J23OwToc0sVQVOmZo3yxpz/lgCaglcRXMu724zQF7QGIR9
	+I8UW2Onx7wnpiVJRauwvMRYrKAbyEiEZvlUf8kJlDftxs7hZJnlVK7kyaPZ0jg=
X-Received: by 2002:a05:6000:4707:b0:498:c419:3728 with SMTP id ffacd0b85a97d-49c713ae367mr4463557f8f.22.1794565646661;
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm5077482f8f.0.2026.11.13.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Message-ID: <0c109a58804a2d782e549af6ad13e89532d9f9d2.camel@amutable.com>
Subject: Re: [PATCH RFC 40/41] erofs: refuse files on pseudo filesystems as
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
Date: Fri, 13 Nov 2026 11:27:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
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
> File-backed mounts take any regular file as the image and the same
> goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the
> mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/erofs/super.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index ce05557bd998..980d5fc2b576 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -158,7 +158,8 @@ static int erofs_init_device(struct erofs_buf
> *buf, struct super_block *sb,
> =C2=A0		if (!erofs_is_fileio_mode(sbi)) {
> =C2=A0			dif->dax_dev =3D
> fs_dax_get_by_bdev(file_bdev(file),
> =C2=A0					&dif->dax_part_off, NULL,
> NULL);
> -		} else if (!S_ISREG(file_inode(file)->i_mode)) {
> +		} else if (!S_ISREG(file_inode(file)->i_mode) ||
> +			=C2=A0=C2=A0 file_is_pseudo(file)) {
> =C2=A0			fput(file);
> =C2=A0			return -EINVAL;
> =C2=A0		}
> @@ -835,6 +836,9 @@ static int erofs_file_get_tree(struct fs_context
> *fc)
> =C2=A0{
> =C2=A0	struct erofs_sb_info *sbi =3D fc->s_fs_info;
> =C2=A0
> +	if (file_is_pseudo(sbi->dif0.file))
> +		return invalfc(fc, "source is on a pseudo
> filesystem");
> +
> =C2=A0	if (!test_opt(&sbi->opt, SUPERBLOCK_SHARE))
> =C2=A0		return get_tree_nodev(fc, erofs_fc_fill_super);
> =C2=A0
