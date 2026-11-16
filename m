Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859450;
	b=4ktUXCz1ljE7No1AAmJqUWo2wfYR6j9q4/CTl1nVqmR3+II7wh/S6U4+iajsvjr/a2t/
	 zl9VB7lOX902L5irMw+Crp2z8GZ4BRZNLyZ2gMdcnQ2KQPwCbx1mYbJn9rEfYxyohPQWN
	 fwB90rrdmyJbcwr4zU0pOuKRBXogr83vx59trcHWjg+Y5QQ3Ifih9Jf7CKeXBiQ6UYxLY
	 KIB/b1CVBbVgl4Srt49nL9M25Xe+u5wt0zdDU40fSp7ZEjyhgm5YqOiaHixruT4ESgXZq
	 mYM5a0SpdTmT+XF5mmlpp+ZViHIYU8FJe/MqpKjex/gqwNZxRhshZ8n80RqN/g06Edw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
	b=lT2Z2O0JCm1sGoU45RVB+o2EFFx5JpLKHcQrQp5oZVwvTD+wzDJLxhF+90KWvHB2yhTb
	 xM6xLT8RINg0YY7jX/yi5MtFFUeZSp1rST5LOk6L4aVseh4fjJ3m4icy6prK6DFiD8p6Q
	 WKji8KFdAXYNCceXTIp33z6VQU3OHVM235TL+ss8HY+4zdqfF46jcv3A/2OtB9BYQM4rq
	 K5yjeePWKBLMq8y0WUndTDvWneYiaRE+0U9x/AY1wwLPWo+XL1tSxlLCLBEebIFLJ4Mcq
	 JcYbcurZafA5qslnS9aiaI5RODi652OSLEYX4uBURBtfrQBWdbUB77lfeG/+Ao+Pniw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24C606A33A
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 20:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D24C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a32576da88so240835f8f.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 12:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859448; cv=none;
        d=google.com; s=arc-20260327;
        b=YqumJgI7sLUYjlFq+zJw+ta9R7nC4elI0UbrE2hoSd6nozVhHSI2ft4pwwFibPRpKp
         uCcqWk+XFjnVLyePT0TQpPvxf1IsgU+fv1RnQd1pv8b2uQAcu8yDUHyGhnN/lUNBts+7
         Eea3Ni9lVjePvQ3zAirOGgyGa5d13MjgNlBQUgAZvVH/sq1L4zc0x+knuU+6hKvKHfPX
         NIY3uXWEb/NgfJbBHFghq+mllMV3TYivFucQjJE/LGYGezrCpL/rG6tWvNxW+EO8VxEK
         W5NetgPklUtEzhhT+cWvAatd+PjQuRtwT24EYzxsvsfaNbfsnC7r/d9qmeyOpr3xM7zq
         5lQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        fh=ZunnIvdBwtueHnq/WA8N75elEw6YU5Tyqn6yTfk7gDU=;
        b=HXwlMZdcSxWFFYOOkSYVm2VweUn3dWWAbUM9d8LxFeYQw5kLmP8RLA9KY7X08ESVBy
         hybAgVZ7r2Uth49G4mu2dVKv3SQMkZ0F+/KNEyJfvmaDk2QDpaAK5hpWdaQZl1qH2upe
         Y1y9EO67FEh8yaI5OwEt+w10A/oc6yj7nwwL8+0MJLGYmLdHyG2sDjr2j3CkwECX1gpQ
         4j/yXc6CUK8cbhioTkkA1lUOVpg9fa0dReSNTiNGVjD/WEJG7n7MeibAhK7TKj1FKsiI
         Ic/fmESwev8ReJEVQjCE4vNRHAFZdRjkpByIdboQToYNxAzWvTMYILx7DAGpA2jVxf9B
         q4sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859448; x=1795464248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=hnqDx80H1BHGMZ+jCw863LQE2wm4hG6wTw//ziQNWkZpZIjdyNNCtFJNcbykSvuJWZ
         RrqgQGru9l+9Rlw9NCoAO7RXSeH6CHzRwb+h6TsbT77V+vTLtC7o5AslWzWJ8+7yhciq
         sbJxN7Yoz6y6VYO91QUyEDVlXVHt5e/uzOZriYhKEljZIduQH6pNfhdOY5sHlJFueOxf
         bN/uTLfuNBjnHaTZ+WukZQS/Wa30tWyiKsfqEPmOKtkcPCgN1gGIeLsa9pfco/3ZvP3P
         koo3Bb9/+esUnHdHS2hTd5qtXE/k/xctadMJUuU/zchcL0VDKvTRNofZgdIQ6mLOou9W
         X5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859448; x=1795464248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=CM6LoBXYjnnuVzqUWr5bgdt3Ld1uvMtftYhtVP/Cx/rs3i5A+M8Oh0AZbJhYuBixS8
         LOQKf6q6zTi3gsH6EUzFwA4XTxPdpu/GE7j11LfklAMpvBvxYAUFtkGXOM4EVmklpD5D
         ygGipuC7tDy6bfLcUeYxlX+ddvQzSQ86epz8XFjCKzP4vK52Ee9R2XZ+Ran0iPE1UhUG
         b2T9xHZWy2L8gw+tCEDxZyR38KzNjRrY5yrTyPS1PJa7675r7DrHqpRnsqMFFs6cLbFV
         W6kHsc5Korb9EVK+NoxaXFcGZ6ys0M7q/8TkfpRP+ki3j4+KgsBmWmWrAHRhqx7iOC5P
         s57g==
X-Forwarded-Encrypted: i=1; AL+hErFxeZb3d+jtgSqx07323YOzZWiiQdM0ukTdaWQ8G6tpXSMiFSUkltA7XsoRuB/uZaQZArM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4YlkD/QV23twBMWI8pONjKa8eBXKVUW6GDof4f4uZv4ipmd29
	SicW38q16rcCkBR5LU7YzMALMm7uKjpSxV4l50mhQWVS/vvPoIbwzYlJJ9roDs3IyPvfPwrAXLv
	jXp3yeOvrnRJJSOBlgSA0ZVuY3rC3Qzo=
X-Gm-Gg: AZFdTZfVyks5vo1BUMeJB49xqpUMAiGY7rW9RwMWPaLRjT6q0UHJJcbjL81E+bnbZ2F
	RA0zKcYOG2gobDcog4vI9CyjRuwgj7itRlavWpyfTPcmvucmwNOFjW5CjdWKIyScdJlxnFn9gnW
	u6PjYsSydIMBX2k5IAGpk1qXbv3+3KVjkRhT5z5wwkdDoiNEwNUeUcVuRMhpZR/w7QghyTIccSW
	EuDvj/pI/xt2ilwqmrqz/HiTsyYCpvdps2W7lJLRYTZtN9a/u0YQUZCnoJs27gteBQQtPrNRdn2
	qTXpU8OHzYII46ieKkRmmvwSFsU31PEoPZ8o4hcEzYpx1TUSSOwQ1YFfX8t2IVIPfLa8xuQK3bw
	QEmvLvERLYUqQSLMXjC/Eju0wjhPi4NeOcPZsxCOWIRw55gH2G0c68uTfthe5lw3Xrnv+p7VID4
	p4AQEfpac6hGWHRD5hc2Y=
X-Received: by 2002:a05:6000:4692:b0:491:3fdd:af34 with SMTP id
 ffacd0b85a97d-49d61c80db3mr13343868f8f.36.1794859448335; Mon, 16 Nov 2026
 12:04:08 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:03:57 -0800
X-Gm-Features: Aa3M54q6P4M0RFDCKQ8HHGNCWJafItTSPdWR1qNwVGtToDAv2VOv8vDfWHzYR6A
Message-ID: <CAEf4BzbLFVawibuX0wk=8uzy0WZSYHbkgK55d7rqLab2qAM1Fg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/44] bpf: use fc_init_pseudo() for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Alexander Mikhalitsyn <alex@amutable.com>, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:21=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/bpf/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e1..57cf3775c0766 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/fs_parser.h>
>  #include <linux/kdev_t.h>
>  #include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         sb->s_magic =3D BPF_FS_MAGIC;
>         sb->s_op =3D &bpf_super_ops;
>         sb->s_xattr =3D bpf_fs_xattr_handlers;
> -       sb->s_iflags |=3D SB_I_NOEXEC;
> -       sb->s_iflags |=3D SB_I_NODEV;
>         sb->s_time_gran =3D 1;
>
>         inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct fs_context *f=
c)
>         opts->delegate_attachs =3D 0;
>
>         fc->s_fs_info =3D opts;
> +       fc_init_pseudo(fc);
>         fc->ops =3D &bpf_context_ops;
>         return 0;
>  }
>
> --
> 2.53.0
>
>
