Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD23F823D
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587486; cv=none; b=A9JDZMCvtx0QYIGH9G9RuGOhRsCnX1nlC+vX9Tnt64jq1T0bOlTF01rNxZR3/s8grj5iz8tP0jw75XAPpstf4vnnAbewChvTQwjQ+hjGwMn/Y+N/SiGPwtAd0ShAKpw8hr4OUXe3wfYuHtcg/UMrEL8AvTPguLlZzo4QqlWRz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587486; c=relaxed/simple;
	bh=2BOsfRE/4H7mqCEIU/QKgJ5VXOnN/Ix0GR+lSfaJ6FU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e4EMfTUpPh+myN7Z/+KgAoQ4oGoxNpA2mC33PYPhAbj5YO3RL3VWmigxrZApqJgw8ewowieezwHyNBGmh+PHKa4Hr++RRN4hwanp63i8JPh/8dpJemgQAxobJ8EFXOjBKeasuoXbwDOpa+iFDl0/8luWgQI9Di/AW8baKZNr6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mBs0x0A7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mBs0x0A7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf452def93so18184815ad.1
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784587484; x=1785192284; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f29SqK1zYfYX1vUkxnGsBKwKsH/yiHmZW3fO103/0t8=;
        b=mBs0x0A7miL6QhrA28DSwNrAe4tuKCTcJoFCzXlHb1UWmVnmJ93yjLduY3VGV5WJLV
         I0akxEimsVaHXs2BCkJoM0udwGPxu7qQj/azeJQwtJN+yW+c4tkE0YkCCeAR9SSNB7P9
         jxohl68GXHnJsPcBDv88aI7gwMVwiR8sCETugahKcxdTY9vfCijFcK/525iwgkhebQle
         eYyg6XAZidKnuM5qVMZ6BDAAqJQj7XA6YtITJmContrBVHNPGheWTjfF/f08ytduucrX
         WmUQT8nobwyTUEzCiJsJ2mz5BLmUVtG+GWVeVUxitOq5lQVkzofXm9y6ioMiVch9rJvD
         6h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587484; x=1785192284;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f29SqK1zYfYX1vUkxnGsBKwKsH/yiHmZW3fO103/0t8=;
        b=UevD9UMVlrzSmJVWdwq1MkXLshz1ZYeKA3RXBFoXAb9oKUDaONJthH++rK9lbj8It+
         +NRv6axVsfACEVkgkfZeb2YvuJy2kGD7WQ4qQOu0e/sI66aI9nmc6FgoN47yfmybOa6k
         VYD8M/UlYPThmQHpA6uGMwcXj2iwcrmu/0prxV49ZGQTHiBzayQtv0wbZfw1JIVMH0L7
         qzl8Rnp75W55lqMm25N5L1CoFKTIIZahF6ag/pcWYvYOifetfgoFIwUQR93DJzSU0kE9
         MX/imCcGTGaxvy7ePAyjpzp0OCiJtArfn12OEJ+aaVlDfSXacZeyVeoCyzwoY26Az0ko
         OXTw==
X-Forwarded-Encrypted: i=1; AHgh+Rqx4ET9/8ecR2P1yoNTGjeEOuuIoVbyj4YQ2SLBevIwEJwh1csL6aEBGKDMOu85fmLm9jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr4Jp32NGbu2oWRfdLKSfkLcaB54Y8PSg+wQ8tGcPeWw/+ukRo
	KyghQ6wKfr7wvNEm0d41Ihp88+U4i2psld3n4GmhH2TSGrQepybcSLnid0L1qnKm4Ao=
X-Gm-Gg: AR+sD12u90v8PvX+UROFeVaeuHaHvvHfh68xhO3g+t4NzhjEwCuQ55+HwIeCN1rhmv5
	IcBfJpIoirpa7YVlF+4/06CE7bew1+QIg2T/brX4B1UJytHWuselY+VH99Seydqg2LbQsTMlAkC
	8FJJTaqS+nc6xhXoxdjQmwuG73AjI7McXQxiaEg/XDVos79mcO8jrSZcXjppzk+2G0KcGRLjE7i
	pbZjWml+hlcflZdu8vPsVWej88vZZpd2lOumm2sKsbUu/FK3b5ugdORAr9OzKwPdnchXoPgvbHX
	pLY+HSvdFWkn4IYjkyt7RF3uR81A9uz40VyNlAegYTPcXLh+5YgOugZv5K3PqWdK9j+ZkKDhZG4
	8LRqcJ1vLoexLrucqmOAFTpxJoC79CzVomghN3oghMOPIVBiWlBNoYF1aHlD1RYOs35Y8ubbjB7
	FYYOP05xH11krFmI07ID7gkINAUHPtUy4=
X-Received: by 2002:a17:902:ef03:b0:2ce:803c:6f09 with SMTP id d9443c01a7336-2cf34a00efdmr170365045ad.18.1784587484454;
        Mon, 20 Jul 2026 15:44:44 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da115sm64421655ad.44.2026.07.20.15.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 15:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 18:44:43 -0400
Message-Id: <DK3RGS3F7L5E.35FH3A0DQAVG8@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next] bpf: Fix offset warn check for
 bpf_res_spin_lock
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260719121740.1547434-1-memxor@gmail.com>
In-Reply-To: <20260719121740.1547434-1-memxor@gmail.com>

On Sun Jul 19, 2026 at 8:17 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Sashiko pointed out correctly that the case statement for
> BPF_RES_SPIN_LOCK incorrectly checks offset for BPF_SPIN_LOCK.
> Fix it by checking res_spin_lock_off instead.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index cbb1e49b9bcb..e7d4e9ba24e2 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4168,7 +4168,7 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
>  			rec->spin_lock_off =3D rec->fields[i].offset;
>  			break;
>  		case BPF_RES_SPIN_LOCK:
> -			WARN_ON_ONCE(rec->spin_lock_off >=3D 0);
> +			WARN_ON_ONCE(rec->res_spin_lock_off >=3D 0);
>  			/* Cache offset for faster lookup at runtime */
>  			rec->res_spin_lock_off =3D rec->fields[i].offset;
>  			break;
> --
> 2.53.0

