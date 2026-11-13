Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564657;
	b=Q8wtdKIOXuCPTJjY759ypjtYYmkCioo5c9dy67WbfOgdxx+/snUYFMYhw9o2PCJclx3e
	 dNxO0AXOGnJuHXRx9Nk4r6Z3Jr0Mw3dfOWsnufVYTmDwmvt5xfWeWsFNlZOFIZT4cjIxK
	 99ckyca5PxpyYs0PlivSSFORy23QX4sq3G2h3TyMBjr4yMVBe7/2ZpPVZ5tRVLlmUGXLj
	 4BnCJiaKGckhe1syz21RoKldohqzFdk0UvH8437VPu9vAsNcOdiwdpm1CSaijqyyKLZRD
	 Omhm9tF0X26tN0XnJ7uFdQJGJMXUL0RCkLilUxJV6A0zxcE6Es/MR1IBZM7iBZQXEhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
	b=ffzaIARJB3ynuSQPcUfDHbEyFkppqOo/u7QMImaYM+oRFhXp2Y4HEHvMfiAPJSP3DI2W
	 oRqUZN1jhD737flxa5AuXjUKAR04JlHeMIkoHyKwdnetE3Zeze7V05jQnrxwTD3cMwb63
	 3BYjk4BkAy9XqT9SNUv0cDrrAP4iXQnTUp3YBNihQMMeCbQtvHRQRFOlMpeGYGnD8HAHs
	 YFP4g4kbC7LhE1x0/DryTysnNKZallQB38gH9rJYEdMGsSVGNcI/ZMUka8xh7CLfwmL73
	 8126lNl9YPzaWX2O0uoexLfAQNt54P2xMOf6MaJ7Kh4rtyLrLukKLvvQiRPZ73KaA5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCCB606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FCCB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490d59c3edaso395266f8f.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564655; x=1795169455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=afSYRRYW0Lzg1RjNF5a8Z8fp4FTD8+wBAkqEEgX+uXVLN6iB/1Oe+S3s3pjBsHkfPy
         t+OYs+BeBV0n1jEyBb10NVx3dBSZolIBqoZV0sAqk1NmAyPkc8BtADcPrCcEDzdTW4+p
         zgkm0FzjpTOQt7I53MJB0zmRNwJ5JPK+9oiFhFL/qPiFq6x22bgZ8fSq9Se2ho9ikF+q
         rg0gx4TedCmdQu2h6zCkoXcFHWmQ+ZQsRVeKTv2sVCXhncyHGZ2k8DCVvoh7926dtvhd
         5w+l12l3Dd1UCqA4z70s6tomNhqNtGqcJuf3lRDB60cxVt/wNhZpOgzeegjchzcaCyfn
         tojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564655; x=1795169455;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=G7X+yxF9bYKPBZmPEalxetsQtfDL3YB3+NODs1AgQtwYk4dwH8qTKQD7ufboINIqdp
         N97qFMbrMe3TJwdE7zOJIcjTwjQ5T03CZJnqFST4DsxyK3Xs7FLKmoAX+lc88ROemt/Q
         +eZOcaO99kclX7Y9LKtlqODILAI6kHFONsJdEFOjnRuUrKYfnyAFhbnNW6pbVqvh02eL
         N1gt2Z0VD+GQojl6zeK6dY14GRJ/8NTj/Q2CvIxRYZZl9WELbEfeJvQCT/LHRBCEFEt4
         uF9GoJCpsi9eWxgjJxb5K18oQgLJE1YrtvV6Cf9Es9iaBQ7aA3iRIF3ZNccHpnrhh6dy
         iSjA==
X-Forwarded-Encrypted: i=1; AL+hErHvR/E7ZLn6zfaqwenphXHFXy7zN4hoBOsCdkVyep/lNrAkFEDlpa3KZekDSYNnsKR3i7w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PpoRBvDk+BQRpkmkS+tiadi96GI8NgwekkJZei5SvDnsLBkDm
	j9Z1q59gd9Os+tZlQ6Xcpf7MAluXsY75Xw/tfXJd9I4slsTrnx64JYUFsABedyMhoV6u
X-Gm-Gg: AYBFou1BRXU2tPcHR/90xwTbhEskczZSf+tqj8MhvccXeYH9v4KRCLFKwjl1WuQndGB
	P/87jYoR1PeH312cBjpk5xj3ZQYKEd5zUTZpaJZdipVmUKbhH4d6ge9TBVh02/yiQAa4TrxfF8X
	FXWrkXwp1dRnJFnAw2I65AThYdRFmMQE9WIFoT4QnJNmasL01tHS6zuKJb3GKUlTOMqsHurDg1f
	rSRKT79JIuqE/XatYUEXJFEm7OMmavISedJa4S31KfzfQBr6CeYCoVw3uVAa//zK7SYroHKtmg2
	X0bfW+A05iJQbOEjr5ItZlZOyl2gn0junboCXMEspiHTh1bnza/0QBaeEK3V9oU30p3qdIz6Xdd
	ML5FI5tZbmQ/HHBFEq0Z7PFJpAIcGc6BzF5tJ5AZXrEmnCSR7A7W61w9Fik3fPy2VhqXdwOPWAs
	ykLk06wB3BRXC926Il/XnK4aMvK/aqGa2ZzDgLeyNKD7jhrgZQ4uS6mG9qaBOe2+VPtmICZIiZw
	db4FaQ1BgfCBc783JaHMMBe4lNH3qY2Gbmn1QR/TyoZ/w497S4jK7lEuMIY4KwFJGIjxIuPy/Z7
	n06wZwhQuHjpAvmIwGiFjJ1/uMtn/X0H6+u+j7xpcV9P/df/Mn1rcSm6Q1e1BsI=
X-Received: by 2002:a05:6000:470e:b0:499:ffd4:f519 with SMTP id ffacd0b85a97d-49b02d4c2cfmr11662822f8f.23.1794564655454;
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm4988050f8f.0.2026.11.13.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Message-ID: <0894c601b3f3c5b92008c6c399faaa539b658307.camel@amutable.com>
Subject: Re: [PATCH RFC 17/41] securityfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:10:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
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
> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables
> or
> device nodes.
>=20
> AppArmor puts a .null device node into securityfs but only ever opens
> it via dentry_open() which doesn't care about SB_I_NODEV.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/inode.c b/security/inode.c
> index 080402367674..93997a9f16fc 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -64,6 +65,7 @@ static const struct fs_context_operations
> securityfs_context_ops =3D {
> =C2=A0
> =C2=A0static int securityfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &securityfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
