Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563701;
	b=FTwcSqCtg8Et+LPYixKDc7OJubsJkH7wXQh+LVmo9fNoIkkhf6B3Uwcf80eFJ8dor7pu
	 2OzUtEdibQhX833pAZo55T/2MaIpoT39hPG0bSGBPwbHC/Gj59UgODIrKn/FRM4dmbHgi
	 yUOVf+Xf6YDf88SUGzcpgdtQ8SRZp/LEZ3nhoRCXNKLOh2cHZ/azfaW5Nvq3EtJ9ITnwn
	 4X0zyTxKvUSTs9SDXegha7LO9s38KVpNty8bazbtJydhcllTjJX4p2pvKHVUvRTBlb+YV
	 ePJe1QLfWkONcAVaSE2LLY0samsJzIsxHLivmJyN+jod6JnchcEtBsJVYpIdAj8rK8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
	b=iQaI3NKVzhjRTnvAUTrHTsJueYf8qSIAsi23+WU+sBmihxq6EfxiBcV8LwPHC/5TcwpZ
	 6iFGbvNrdti4n/M8H9ac7bI68CMDmQaza+C8LugoFI3xZnACxpbo69nMih2nqrsQVco3I
	 AGzpCtBRUb6TKKb7NI5rQosLVIOH1lYOQ1JMxxIYtCA2a8Zd4PDO9h2dNFD+ERHJCsIhE
	 GYJNtETSmvXwrH9Fy9ZdwfYDzc4p0nhpkSqrDCih4CWcUJEe+XH23G0oKB4fxFW9Q7Ykb
	 po1YdIrGSVH52l178QQG5Wm/qBPMk6m2cPbTCocgwOSnn/l1tzLV8/8d4fAHY1/gB/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B3606A8BF
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 09:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 361B3606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso1444195a12.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 01:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794563698; x=1795168498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=sk58W6sWmN4ERo+6S+koVh/BM/TVuc998Smvb7+dAHAHasLoIxA1PyH7SpTb2sphTs
         qaL8BceJIK/C5zTluK59TXAg0t7i18MIhSXKzAc74GDtFkVBtJ5XexxofTn2ErTCpEyw
         wBL0ZIwSoD+QdFLNUYuAtp3uhttIIU+8CcgeY50Q9BuPcdVkRSxffNnvhBi5q+TOT3Z0
         N0fPVcnw8avDa7R0wdKzwUNoVC/3vPRCD1SmgKjZfrkNv7BBIugYP8aqCryl3mRTzhIm
         nyzLSOhSkS/Bye+QA00IM2MsjhnUA408QIyungJaHYxvuyXbuTeC6K0dJcKnUnQNsCLo
         BJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563698; x=1795168498;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=PJIiBC9HO0vJuHjQxcBd7YNzaEkiGV7XziY8oWDiWctv5FB9HIc/0s8TKECGxQCnIo
         ekdMafQ4l3+C1xwbX2S+f8+3UcuzJptedJFAxhfuPsxHr7Huf1bbtPFImCE6baeOpLF0
         WxgbsU3+Fi/utUbgJ002vuvUPFiWws/hh3BOeTYcNYqynMWrjrhw/aXMsqrPx2+C7rBE
         t6uuGDMPLy3Ia9m5Qkj9JeqkLM31jqW3rAF/kNVISXscwihOIdnWG1YBuZL/aAC0vx0m
         sGvCWwMSrF6lE11PqW7Wly3vWfEL6weLLsb6E6G8pJIgMbuWT+aNPnYMA0WS7qexwSkv
         ag/w==
X-Forwarded-Encrypted: i=1; AL+hErHhdMjQVg29rFXUZIVzcacrGtwLHG+XhfVBHOZQYsAiy1bVaHTznyvL6ibMKcM0iPoET6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nI+dMZtGBmzEeUFOdhZS36VQLePrJg4iVKuRkI380JzUQaC3I
	blbol54hRgA6jSTG2UpsZEOjGXJNu2AcUPscZ/alZJZpaL9XrIxY/zj6op2XumCxAmze
X-Gm-Gg: AYBFou0/f4mUx4WuUmHWuVa2zYAq8+ouaFBoPEDnKSaRiLTdnpKSkMT+sJUxxB7GoEn
	93Ze8cBbiho+M5RmwYN0WtNmEbIuspyKU13H9NXejN/w7RUyGs46MC4rlUpZvIZ16reW6Tt25yE
	yun26N5KvjdUaIw1qVruAEx/i30UWaAzaiyxlBLRjqkq5k/e6gtL/wEc2lCWUmg9+z0NFxihXi9
	jhD3+scyoaWRFVF1ehUxUZq81086ifV6dnt6X+MBJfKjNV9C37FMFX03z29g1IZVTef7HTvxy0r
	spW8IO7Y1nnD9JglttM8TKeVj4xKpjKeoKndMKnf803O6cIIZwpO8YoLQNcj/9cwkRNZy5x56q8
	XrnBN+aIi5eGd7gtMlgiAgMy/jyJ7qDnPEzpa950nXNSoBiDlBb6Sx924HpaChxQAsYEVKcrdf2
	JbBUjr7bNGtwY9qVUFpRGHz2Up+9Z2aofd+IyHfbwl0qbjNWAsYf74an818vtnHNmi+Vr8QBcoX
	uaYiRBRWezPJUNucN+psNi1Iok8LTGGWLWIVrB4ixbUv8q0QmKA4SxgqLBdC3PDPnP7OXYbpAmy
	3YBVsS0qEXQwaUHrwfRafOiXySZ6SgDJo9O1VvoGQDYdsCq+jZaQwa3ZGyrrgBc=
X-Received: by 2002:a17:907:ea93:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c50963bdb9bmr198299566b.44.1794563698514;
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm75151566b.0.2026.11.13.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Message-ID: <b42c9f4d29a9cbea66929c95cc8f736f12703c72.camel@amutable.com>
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
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
 linux-kselftest@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 10:54:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
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
> loop_configure() takes any file as long as it implements -
> >read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses
> files
> without FMODE_READ. Direct I/O has called ->read_iter() of the
> backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write}
> for
> buffered I/O") buffered I/O calls ->read_iter() directly as well.
> That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only
> allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense
> in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..c96e35c3ef42 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -528,6 +528,9 @@ static void loop_assign_backing_file(struct
> loop_device *lo, struct file *file)
> =C2=A0
> =C2=A0static int loop_check_backing_file(struct file *file)
> =C2=A0{
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> =C2=A0	if (!file->f_op->read_iter)
> =C2=A0		return -EINVAL;
> =C2=A0
