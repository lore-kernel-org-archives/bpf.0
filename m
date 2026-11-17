Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904512;
	b=hiDkWSOZ2ie0ywBCt30Gbw1ELivFJbPmUtbIZjAAMrVkEJBeembjqoeUIiqGk1W0vQNm
	 fIq//Ac8x0byaGz7cdHdNpBCz+GgHzBYx3FmDNw+h2T62lpZXKSrSifsnAJx+zFFjkV7M
	 YTg3Q3N4BraWvqAOs3qpsORTRCRETAD0yRR2X9h0WuCpifrDRwdh1+D+EesxiXzvJvBHQ
	 F8ablMvPERiHUYGxKLBZpXawJfByurTBpEOaX4mcfQ41CWc0da2nnHTDKhOAbpnq1PVaC
	 tb2fJ2rBt63i7B/cqf3B+H6iIswejtSqYNcd1xGeN9Vfo3H3hcG1limbKJY1ttjftRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
	b=bQBFVsDYno7PA1xZFvRpxoe/qiZVQMgFV3iH3u/k89GzoS6K1AgMX4i1b93WvOyqdxF8
	 ZM6BIaJnDb4Qu0/3XXySWfsYVD1O1u06SNJsrLm/rFoodvX2avIIM25WNqT16A7BB5u7l
	 /1Nw/f0rCPVR65fPNiF1mH39wCR5J3yd9S0QOAKOj5aeD1otdPMxrI8bcG8kjVn1qeAP9
	 xtGghIjAoQ2GwNZw55IKsdzS27AIalu2xE7G2MKGvgcCeyPIOHiPmCIMnPc8ZT2BvKk5F
	 KENPScFRYWodX8kCkpLnTcWLuo73s1yR9Zh1kuyW/zTXZ8kxfa/OG/5ya6PGShgh6cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5C606A8AA
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BD5C606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so2440150f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904510; x=1795509310; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=asHWLUHh9Osx9c7ISjHVvBK+jrwM+bEKiKQ5ZLUG8jHeL8cbDrdmay7aq+azwtlrvN
         q7YkHw224WJQO7TnM1AyMygFYXrlY29jKpq3C9XROr0oTqsA+UK4p+WS5GMy+xx9DTRb
         nuDA+OEO8+ykjkDq/RDjAwEfWgenycj+snq2KkG6mulygb6NKchr6plM71+t8W0/+aGL
         LigMC+giRqQ92TsunABClmE52NWQSdRqhQeez7lH76lemvGh63Ic8nud3Qte/9KpQmbQ
         YrdviXjfG5hlS64KIE7Iq0kMRVYmtZMNK2hkMRb6Cz1tihRk5N+J71aJKPK+K5E0SOED
         KbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904510; x=1795509310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=EuXhic4LTvZ1QDV9QGzXWYRmKSf1A/JkIzy7JRntl/HA6fZTHgPuCo6yBJ9FjvmA0q
         AO4sDzmbyW1oV4fAMqjiCKhYrmZPfQZkRGAeALarRsm4akGGnW6R8eOCkWWOOrr2QcTE
         UWnULQF1dBzGt3rRXzOatwTyYpPUEzPvsxJReWfcDdUmTyBpwO6Q5NFuTzRUvbgrU6rV
         L8X6F9MEDbNf/3CEOwHb17hY0ET86aPnLj29oMQ5q6i2qL5jJMyvNVZSPbSoduZ6m64n
         u4iSRo1paZLA+hqXXQNJVPMErKitsetEALc1upRSMnIHiRZJfQP0vF/lM6r4/pVWKtle
         hJug==
X-Forwarded-Encrypted: i=1; AL+hErFmal8oJTkMTTKM1Kr3rhKMDooGvqH/V3hj0lP6SbLOu/fQ5FgSfXG4KbHLUAEzqX7Udc8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uLUCv1HHyG9Wk5QIVYx9NcZlvhaimoyPWd0LZflsfI5v4lQfV
	9qbhmRVMjjl2E8ZoFuHFWZqGywEnugMjgNQhWehZFv25OjAaaE6ahQkiLNSAsHP9htaX
X-Gm-Gg: AZFdTZdCyI3DRW87T6J7/Euwmzm5fHz4WWqlnKIRMh3FwSJu8Rdzx0IAJNexY683tG8
	MT3tg+Tz74PqhgfnijTeuUF1c5npuf/X8JMY4N9wPRAb7Rmrv6uGP70XOfZbgphcw0a2cSm9j6x
	RAs0oQpsDv16/UUH+QzOfjK9cuGkxzYhRnKCSGi+sMvU3EzcccJCqoU9ys6psRR20MgoFXDbqnx
	oJ98mR0uLTAd0C4cOnsCkKfQOTp7vO6DnKse5OeVnz0m4bwmAE3HsudImcFKHBCQnxGn8UPi+KW
	aaylfP7IMVEV9hHcCdXgY8M08YsGZqGFcVDQe84ZNRmgyZ9mNryf970wA9C1AMIhKIOhlXtQAjC
	qLtcdsPGIbrF988/jEReoHV+TEfuDFkEp9n5IpjSQPyzAXZ2kBW+ltT2y4y2saxRS/IL3igGtIv
	V9cQlAH7JUxreKV+M6NUZikZ7+ln2KI3c5Xq+b6mWbLvs99pX3hoFrm9NaZQRLJqQczEy1UiaIg
	djPQoNasxyIXaiEBdzikFPn1iWCBHq9q1tDT9+Hn3yOX9Ptxow2e1EpBuF5feYXo4cJWONjUOn2
	MQHnq89li0sESpOqL2Q3/aF8uiTX+UxqLGEQGpA/4BnflG9EruhichY2rtxhKuGFCuxi7qzVWrM
	WnLsRi9pc9Dl5nXGG5BNNA204YZhvilPHPi2a1Lq5p/OU5SzTwfpKOo6z
X-Received: by 2002:adf:e193:0:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-49c728c6e6amr26569239f8f.43.1794904509932;
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm26338505f8f.36.2026.11.17.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Message-ID: <b0ec2cd8f9b7a6a2e4a54c6df2fa897bce068cbd.camel@amutable.com>
Subject: Re: [PATCH RFC v3 28/44] ocfs2: use fc_init_pseudo() for dlmfs
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
Date: Tue, 17 Nov 2026 09:35:07 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/ocfs2/dlmfs/dlmfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index d3bfcada3e3bf..1789ec96dc130 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/slab.h>
> @@ -563,6 +564,7 @@ static const struct fs_context_operations
> dlmfs_context_ops =3D {
> =C2=A0
> =C2=A0static int dlmfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &dlmfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
