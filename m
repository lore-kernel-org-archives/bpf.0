Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564363;
	b=c9phrrnG89PBPV+ZFlC+HCWiG8x29n0p4yWdoUp95D6xCsmwnwXbWECFXdrIYdHiIHYo
	 kOSs3301igYlJojxgW35Y22JWlNdZA/ZMrznwsWIX6qs2to/rf6O1HnjHe4bQ4kbvzqRV
	 kXPTqgYSFxJ0Vop1upqdNcl1W3FRvU7ijMB0cRVH6bxWVVj2Qs+YajOINpmVzfGUnCnwu
	 DJBwDkUDZsPM3e7yl9hLCGpTyQEIL7NDpW/3H9YsmoQXSoTgCzrnjIZYBN28ZYEbDVklY
	 aqJCY0DVdkUFdtZ6aNPasOacmL1fapWnhl5p78I0+uEffIav4HVDdYJaUNxKK1y6rNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
	b=W98OZ/srv3/KQroHds7psPNYIrwFmsLe9c9ZNahQ8987K746RG4Ssle07xTpKCitxgkB
	 t7YKmC6B4PfusNJVftJUNb+gdk3gPcNIvGHJJBUfMD80/txgmE3XDawf7veazZQ/lWdrh
	 mv5gPnAe6UupYhKI1EPvjcoLQNZZ7kq0WfzjDzXkxSf/9t+aKFrK6QWagaLUSk/ofBAkF
	 sjr3wrfnko97bGvvgfJcntFiqSa9CDSOL3E7kVxuWSFBXQZvQM/lOK9xmo9mrTUfD0fpY
	 2VOi1rhQprhI1M1ejboBQ4sdxLmFsbVclsEGNTbhrZtoKucVJm7UWE3g50yUw5zGJyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB060A380A
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17FB060A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d581da0aaso117997366b.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564361; x=1795169161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=cjEYfKb2ti/xguKoQF5XePY0eNOezud7K33Duf47S0g3JkHBuObkd06WZKSsE2j4TE
         DEwnxkXlTao4933EWT51qAqcKFQZzBDYUWq7IdS+RrJUrXD2u7QTXDm9Wr29l+nlsY2h
         ba2aoEFnt/fnBZ4TqG8AlHBTx7MlaAOM8MSBIpLqFecTqJgM42mukp171NeFhmx0Zx4N
         EfXY8c4e2NVT5eQpV/Fv1f87MHIzBgzN889RZpIYFKMs83t0n9Q8bpafRw7OfeQ9pMp+
         KOGhNvmnj7I3xZktgYLxquasfZAW0tMnNpo/9hpnK424qA58Vs+J+ftPxNsRzOLYAEav
         G1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564361; x=1795169161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=Dmc9in6je7COHVzd2wBEykQw4XGhAMqKVh98rVW60HLiriVeDS/KQVCRLTjWVLq/Nz
         UNd6WYStFupCWeduMpbwex/o9J5Dt5wm3PCFYRupwoI3boB0QduNbf7AcmJP/Z0avSyJ
         uR+l1uj7NTusG5BRnwIGt+WhRsqQ1eI+/9mo9p4Xg3QMFt5MLVIW0Yj0O5gmzA0ixBOf
         RiDlXWACfWVzLnpRbFZUQiZxjTkONvqE9Mld0mCV1nTGTRgmQ7iXToN5kntXhFRRz2OB
         i5kOcQxJ38kk/ENlI/oMIbhvEbPYonBpuAnPlPGMaAD+oGnDu1nJPOY5bEhN/tHozDU0
         MK1Q==
X-Forwarded-Encrypted: i=1; AL+hErF5z6eJBF45xSD/h9Yz5hG8Ax7VSeY3GBkDlBZ9m3UKE2uUiy0tZ9Qt4CUqUPW/UvcahJs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ke74O30E69blD3OjHuXQW+G37K8UMAl5xr3J1losVpCj7eOvr
	J2IZUL5Tsye7WbT1AfGIVC6SDq2Ljj5hLHaXe5iuiffldjEFWq8FO98e6zjwlb21rk9m
X-Gm-Gg: AYBFou1iJDXcy4TUMcmaX5jJSyND69rHfu8rTVWr+/cHtzb1yfWnFfzQkbNb1bGoSPf
	KwY9yrO1bkpF5LHj99jOL9lpdjTaSXxZqIV7Or8YPGmz72a2yyp1nJQBORyoMHluUlCcl7a6g11
	CaM3t2eyyeNhjzQyN+ovdcB0lrCmhkTWSbc35zC/Ld4hPmInZdYgl1MhnpiWhEgQYqYvUtHHbjV
	nQs3Lx6g/POnzX2dEu6Qjriv83zTFNLBMx3L1xmIoJPAfY4ryQ9O+i34SmPH28yFSOe9f7yXL6I
	PTpU6Q8sNOW5t5JrfwyGsHmqQ46j0QlWLWqq6woJ2AkP6Qw09P4vxu0VMM7KmeTj+wDJpCXw+TH
	629rhLWVWMdnikefkkiRuFeJH3llTY/EDW75Ih9S8FWEwPGmpyKgmBRuoFt7HVP627Yrv+g4icR
	SYmmM3FYiUk+1D50hXOzA6eA8rNw08gHNXS+ROIZlgOUbKRh5N/BVU7E8hXBGSLSy/GpKkcpHXr
	cDWJcfoVA8YpcLSpPoaLyIBHDIiaw4RNu+mDoZIsELd/R1c67jqaU4EbP8SYneyS/QGdgi+b8GY
	tIy4mG/ONbl2CLr6ChRlY7LGBYBKS3zV2y5Bo6ZOkk/MoOUjfS94vFMK2o9UTu4=
X-Received: by 2002:a17:906:ef07:b0:c4d:5820:325a with SMTP id a640c23a62f3a-c50963dc627mr169588066b.39.1794564361325;
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8651bsm73693366b.78.2026.11.13.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Message-ID: <e8b71a2778d7d7797d433e7bac1a37ee64aaa30c.camel@amutable.com>
Subject: Re: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
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
> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/tracefs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5020365ca704..e04febd868eb 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/namei.h>
> @@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D TRACEFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &tracefs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
