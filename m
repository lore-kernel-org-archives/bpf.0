Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611200;
	b=2TTMxn9a6a2wRW3IdDYLZoaQUv8veB7zFCV2XchkwhKBVhQXuPBY5XMGkqSribzSUfgT
	 +OkI1c03VB7gmDJ4WNe3spO3Dv18/MA7LV880HxfzyLRS7GGyfS19zdAXCRDWnmnMm9Nu
	 RM3qhGROTRo3n4QdZw6z7CRaqQh/8krxrgHVu6EwdewUcGdaOxUDHvOBh68sg47nywN20
	 vvsUFmYtgxaFI4gnA2yshhxsw+wGt9tZN0GyEGk6vCme80Ani9JpesYu2BGL392Blo6Od
	 jlht+FDaxZV3fZIzF8vuxaVyK1V05fcNzoVsyPUpU4V6BnXKSlfRSncCAlmuiA5N3dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
	b=S6NeHth6t/xoXY9ozVPa4N7y6ydRtcpwN9h/A7M6PJw9CKV3+7fcIzRnKlCgkc1JURuD
	 nxKayW4ff+w12OjuIQL25/jVe/kNDkEZ3HJrILgBuB9Tp7T22ddjB9YyXG1MbAr/1I7iF
	 2UB3iRveFB74S4ajZiP7YrPnDmeQ1AD+FrkRTY00C3tc2ZzRo64pL6Thz7D7opVMY9eb2
	 sr7l9GZS/1MzWwGfiquzh7RXo14DS8DNkdB26yhRXhMaZYmGTwaDU6hog6j9sHqB7iOWc
	 hSc2wDDMEYALVP84n4wetWOSnfhxppo/zajpa9uVozgBk5PVsPDc7RpZXqCawJ4N1Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B2606A33D
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 12:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A8B2606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so36135915e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795611197; x=1796215997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=QOXEZ5Pu/EPca6q7kzgJRCmLrmsoVFR/ZRe4q5d58yeOdbJoHTuz9y0u/Nmk0CktwI
         CoxL971qgH9IAeYEJL9OV04KK9hoZrCZxCXphCDmaMaCEIiYAFkXm9z/Jipc+urQTX/j
         Fk8I31Tuids+3mCeGda6Q/7DCnEHSLo9OC+CFzZ1uqDLrPjUm6OialCUSj83o9zL6oVG
         iksZBRXktSiMRqpVyhlcQqbeKVyrA1zYnXNdKX3aSHnLNR56AH4l3EmMwrecUL/g6kYv
         65m48YXn1HMJU4OXkynxAivRZrQT+c7z3fBFxX7gT5o5ijKHn00slucTC0ZtqVCasBEY
         yyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611197; x=1796215997;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=SDgro9cykJqawPxD03R2u/iWO4cKfJ0yUlKFKVEe7Fb5hJo730G1Qd5LS9zSpWtYPa
         gWWExUOM6dBF7Pg6eQLPwfhFrZiA3Lue11/9A4C5F8ZY2CUtBP7XXfx8x73wtu8wKTay
         Kc+L4cKEBSuKJhZ9kM/mzQCxUauWtLvqQscJD8741s9NHZ34pC6sIid83fwJW2l/clMW
         dxQIS5nZgsU+KcQUi4IZP6+z7vXwA4zeINTNg7AeTBYr7pU1rJhX369ouBIPAJaMcDgc
         RvqUOd/DJPNVcn0moqiTo7UYPx+fXCzCMagolBvss1asmWbBq9GQcPXOvUlKvW0HwBms
         QAnA==
X-Forwarded-Encrypted: i=1; AL+hErEQcQDyt1rdTyYi3QyKgV2UDRuYSndYCJaPdlNckhRn7+O2i8RQN/80HDfvKyt8kiZSqZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8noM5qYBZajAISc7mrmx9C1sJGElBwI9RofJoVDa8Sk31xZdrZ
	ZC+qXGbqx/UHJWXm0Mfe0whZq5PgFpD9zzdf43P3LfV7vPNPxDcjYPfDdnWylfLc50VM
X-Gm-Gg: AZFdTZcYrIYHS9/LyRHtlt31zd8MyhxBki6CxVzfb2npUdTYre/HMNVOIkmk8cJv/6T
	FyzEYzVfImfiABiEyYMZkCg5qLLBaaFnt3A0pVtU0bCU0yWsB0w9Hx/5/oDfixSXMZQfuGAuWCE
	mQPTl0VL/ZEVOwgnpU6rwS9WGLJ9MqmbPIE6XGFA14uakAqUHNgxXvUOyXK+FG1be799OI0KBVk
	TvNxNVJ6EKu+XH2Hpx7vehxP33EUppkGGJN8MOTJQYU7JYmgKSDPaS/lo5fE5TyOXKXJYRy27Lu
	G4Byo7OQ7kwjSifx240w1os6EnlzO0m6pe0fvqDt1XTBvHc5+/da9C0GBXLXwo++bvRbA1zRLMu
	Mp4IHh41tLSZad2DE9kRJb09i/NqucjW2tZtdA0XlCPbyzdvFLZJOvffJlohQoXAcbr8Ub3z1V/
	MPXnAlQT342FHTUG2CTStjsA1QVrAA0kZSdGN2+N2UEg3bI3ceKxOsMmlQrwNcUI0/lSYoPpeCg
	8ittGiJWe6aLhgkJJXdjR53ZgE3tR2NH86SRUvED0YLgMjtNj2clr8/ipGbU8sCpISBm8w8snbU
	RtyQNYRv90ayICPH0iMpG6PQ2iCTIsQAg95wT5dM7f7ON1QmXLrmKGjshl9QnRJo2llih9/Fetj
	b0mrGDoiZu3MfHc9LFWVaanhsQ+bWxg82Og4bQaMUIvCFKb+GIq8TOSwJiIKMlPpMxaeIl6aAt1
	g=
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb88818156mr356853675e9.16.1795611196651;
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm736573735e9.13.2026.11.25.04.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Message-ID: <45510e886330ade6013838f94cd84c688b263aa8.camel@amutable.com>
Subject: Re: [PATCH v2 08/13] ipe: handle errors from resolving the real
 inode
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, Fan Wu	 <wufan@kernel.org>
Date: Wed, 25 Nov 2026 13:53:15 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
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

On Mon, 2026-11-16 at 10:44 +0100, Christian Brauner wrote:
> d_real() is about to be able to fail for D_REAL_DATA. So switch
> ipe_build_eval_ctx() from d_real_inode() to d_real_data_inode() and
> deal
> with the error.
>=20
> Currently, if overlayfs fails to resolve the data of a file it hands
> back the overlayfs inode and IPE evaluates the policy against that.
> The
> overlayfs inode has neither a block device nor any fs-verity state so
> none of the properties of the file hosting the data are visible.
>=20
> Instead, leave the block device and inode state of the evaluation
> context unset if the data can't be resolved so the file is evaluated
> without any dm-verity or fs-verity state. IOW, IPE reaches the same
> verdict as today but without looking at the overlayfs inode.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Suggested-by: Fan Wu <wufan@kernel.org>
> Link:
> https://lore.kernel.org/all/4e9a39ac-9ad5-49d8-b0c4-09e665504609@kernel.o=
rg
> Acked-by: Fan Wu <wufan@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0security/ipe/eval.c | 13 ++++++++++---
> =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 4a7be96c84f03..a2366eb9a47b3 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
> @@ -102,9 +102,16 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx
> *ctx,
> =C2=A0
> =C2=A0	if (file) {
> =C2=A0		build_ipe_sb_ctx(ctx, file);
> -		ino =3D d_real_inode(file->f_path.dentry);
> -		build_ipe_bdev_ctx(ctx, ino);
> -		build_ipe_inode_ctx(ctx, ino);
> +		/*
> +		 * If the real data inode cannot be resolved, leave
> the bdev
> +		 * and inode fields unset so the file is evaluated
> without
> +		 * dm-verity/fs-verity state.
> +		 */
> +		ino =3D d_real_data_inode(file->f_path.dentry);
> +		if (!IS_ERR(ino)) {
> +			build_ipe_bdev_ctx(ctx, ino);
> +			build_ipe_inode_ctx(ctx, ino);
> +		}
> =C2=A0	}
> =C2=A0}
> =C2=A0
