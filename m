Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564336;
	b=ft4dc1YUCJwLC+je9zgjZ0roJxb9kNUrBhtMfe/en48y0E66Edo1dSKGc3l1EIDBsbPz
	 1CAqRup2d3b/mRotTrDAHTyYpXjba2pzy/lpgJS623dKJ9XG7+HBG8JNT02jk6kZYH7Vr
	 dYnyis1TKEPkQLEbZwN1ND8rl/oT6F/aqJvWrR50mpQnfu+SufFXfrRcoQow4SWFlJtWd
	 oqkOx5JXVZos0MMcAAKp/HE6ydMJNa8OJrGEdanJV+a7rtYBMCOYAsfmnpqRzSKGnUWAQ
	 65cl0zs5POdmKpC2hL1dmtew2CH4W9l1j8Y6JOFLcOSqJeIIfjXbkcvQkVYZtLn3RqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
	b=gKEreI5ZPsAGwQibuXYSZRaogHOhZ4DmWpgngQPKS1VjOHi21tYBur8yHJp2DXicfVwe
	 LmgkY/vR+b1F25RHrUvKSPf/kH2s9PVP2zNGFFnz9bibHBrY3ZU1ltUCdCAyecWxRc9pG
	 v/vUN0QaAJSUmPFnf5R7B1NRFE7+sGYpRYs73GHTGVcPrb12ufne/o5rYYQLQFGtHBC/Z
	 EhXPgvJGC5lNrf+XLFce9+fztV5lHgTwsYDOJwQIlWud+P/ZDsn3JckQCOTqsDF0wUsoQ
	 lnAn+LQKyq+huKsatIEkosYhF3hnWcy4DdFF97XmX8y9FMKHWVVXmtbjUGZHBjvblHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nUCLd8f0;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901AE606A8A9
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901AE606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nUCLd8f0
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so1356669a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564335; x=1795169135; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=nUCLd8f0G/K2fMNIytq9u2LWpw8l5XbCSUxsIs6+S5nVG1T3fI5ErIjnpvRMTRJ1g3
         66+hupjWTQxex7ntfQ08B69tN3G7DYFzu+MIzI3GxWcQnqgZu7yay01l+4mpEhy0Ef02
         xbNHIv/PH0KitW7ZH+pZK/qyW26JriIVV4HRgFAXvls3DDajVpT9R5cy9rfpfJ9qOhH/
         quuiU6KaH+bd+1MNp1oe0tS5lHpOu5FifqraRZhGcQQrLcBdrSt8hi6RHYJpJDDneT+2
         609Jb+e8BW/fqMWXfEgOdGZ8nZZS6I2LapQ01HWyupMw/vLrZIn5Q4gffAveGLQARYQM
         rrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564335; x=1795169135;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=qGWfFuhUr//042w+wf+xcxzSeiJr5e3huwPpCD5FTQtp38EXQLFfX8TuUd1IRKQ0jt
         dUSLwfVclmjxBhHJuoQE9LO2ToDbYszRz96l2GF278HBiYqE0KRydLJHFl3yIn5SgSz2
         svdqR0nxxwQ3Ptzwq6OPKZRvPQjW9zRXafbxPJp+AiocbcvhN3gc+5nHt4Qge2uaYn+r
         Dicq4Cx0EDXWNVjVacr2lgqkEzcmGwrygCGS+Az+EdWkNxgRLJIJWo4ET2Av1zXEzzGC
         wjrn654j+GtgRUkphaO57T4M+GgLfb5b/Fjjg6TJ5ILObS0EW2sGmV006fKL5jejebL8
         Awmg==
X-Forwarded-Encrypted: i=1; AL+hErHJNW8HN8DNTkGrFYQXzfeL9UTANz5kZHgjrgkGUyZbzUQsbWGLSzXbes1JvPtDJDPu5VY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gy1r9Vtgln7uTXKlEZzWhlH82ncTaGnzO1l9COY2VQ3+SYkKq
	X/VpxQp8DQwoLx+ft5Jldg/GATQx2RzU9W4kfnL2sTEUrfmWoYK1e3pkMP4myOpPCmVh1bdsY1w
	78WLkYpUlJ80=
X-Gm-Gg: AYBFou0VuNCxvv2Ae9XrMdw+FC1yDojXTs+Hdo3P22z4rLZK/YbWg8Fxm10i1mASw/W
	LAC6zxfc3GpGKnyLkQMwpT4zm+E4zKDp4rA8n9RkH5kfmptRL4sd3I0vo7lfxTaoBDWfWEkQz16
	aRs98dCSCL2/EHW4hVfcJAkD+OkV+Ze5jNxntfR7vB8PNCKxvgowXGuKYqNbH8jZZr5rmD/LFCf
	fpYQ3ukY0bodU7vX+zieF6LgnstmYU6Iv6NDA6ZMMlI5gg1SpTIGq6bbiCrad78E4bVL0hUlSQ+
	Ft5O3MpFpIofvXCog79ZROBQP//ifkUsJPwjjCkprjuMYlUeS+xoaxF8/V/lfzfmbg/Z4XFz7aF
	WspRuaua0RLGkPx5wectrDNEsFq9O3JPso1RkTjUwhSCcnpY0iia3pP0pXps6pzrT4W9mvIgJ87
	ht+BvklcIYoXZZhgJ3jfuwXcCzRVo9TXfSMJTx4wMxxNwWtfT3O4vbPfTIboIsRqWdvI059Rw7f
	VkOKd7yWLF68C2BQuCQobAZ4fjOrJEfdWupAdJgdYtoO9Z+DK3GG8PBfmNWCLnoui0ueJnJ8gVN
	D3pMUlLZqJ7upL9FNFw+4C+9NjFXwECP9sIKVFWeEVioEmnrnJ1Etim0o5IQbH8=
X-Received: by 2002:a17:907:608f:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c5096398b03mr148720566b.17.1794564321873;
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm75811766b.73.2026.11.13.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Message-ID: <08fa1be263cf4a3db6b3e5ec2847107fba7acfba.camel@amutable.com>
Subject: Re: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:19 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
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
> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super()
> keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/devpts/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb..47ef12241d92 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/namei.h>
> @@ -438,6 +439,7 @@ static int devpts_init_fs_context(struct
> fs_context *fc)
> =C2=A0		fsi->mount_opts.reserve =3D true;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &devpts_context_ops;
> =C2=A0	return 0;
> =C2=A0}
