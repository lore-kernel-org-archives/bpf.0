Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9B5A0ABA
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069087; cv=none; b=GGJ0J9dqh7THT/sxvxtmJJ1n63Ug70aQFvAY4KamPZ0L5wD8YtMO3kEb7ApFrxnEb8SQ8bWu9lI2rbueN8omcyfUnzn9YDzKSAT99jhjJsx7+lUxNae68eQGcRZm4XRNBLX2TWr3mfPKNEQH77gqgF0MZCnY3Zt/4Alrvm3A7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069087; c=relaxed/simple;
	bh=reaqCnN9W3x+7eKJnJlh3FTOHWx2LA2BN8w3xz+SAlk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXFJmZdo67CofyLtko7IIoS3/DmGWa1DSVT+Z/nGzEzspGq1DT4tHbF09dhgTJYNN9twzhkV08O5kJ476CHXPD2g/DzfB3H5umCoObRXJRUdbIV0s/jtEuu6kxzJhNcnPergJMmfuhN+uIh53jj2vO3EPmBvIxIDxFTI+MsvIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly35UL1V; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly35UL1V"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4be0e5469so189211a12.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789069080; x=1789673880; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MU5LplLT2IDrVrD8xtFoGDACPWlR1E9PY4h4AIq9gPk=;
        b=Ly35UL1V+LcGXix1WUJIXkzr0NZm+ifWLYg8aeb3mdX4JW5XpkUKuj9Rzwz5argJbc
         hx9ifjGnPPADyVKbL9z4PmDnOOMfAKd56UHJEzcib2zwO7GMqz1iuRRRxTa4EFTECC7V
         A8Yndn1478Svc6Q/G/2/YeODa5sV6aZM9rpuz7Nqy+UvwChaQGRmH7KiBjMK9u1eY6Mp
         03QMG70rY0bZpCtki1pM1K+BRQ22l8lpxikelxR2DMLLA84x36H3o+DWHO/5q10qPKtt
         qeUDhwAz+/bRdaUvXgM7GLgErQtRUeJnC13Zkz0VKUFSw3KVzvgILZNiuUhz5h1sgrWw
         0Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789069080; x=1789673880;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MU5LplLT2IDrVrD8xtFoGDACPWlR1E9PY4h4AIq9gPk=;
        b=NZvaaNLA4EXHm+KnkfN8irsPyIaVOgO+R6TUnXTi7/Qe5BCN2t4oBa9WCWZ6xqPMww
         7GqQbv1gV0pGV9KQR5VP7M0zsc46OE7FkwSIVNGGcyerdusg/y7IbV/fwmNmDYl7v7ZT
         P/wuRBi+IG1CutnNmTOwux69+xXt4abEAUC/CyYgV2FqxTIsI2dJZTCKFQr54IvysclI
         Q3I/eqKpyjxJ8K9bSwlpEAWUdEPPX9pPakPIp3c3EXZqCLF9DEPGXkgT4+Prae+BV6gv
         KADPp348/zHZsq5LD5htfhyveInf4aiYCS2vxEkvNgLE6lromJTk6n9vBenCa8iPV9F5
         qmDg==
X-Forwarded-Encrypted: i=1; AKwUvBx0P9qjXz2iBa3CZ4nu3w8L3XqkBoGh8lYfXjo2j8qLyxzFLgQid56etjf0twILBXtqjp4=@vger.kernel.org
X-Gm-Message-State: AFuF++k3qyj7xUIT6KBmc1qnSW285RzHdEOWkMU3nyrzIYE1JZgRr5lw
	WMor+FK767GfHwbkrM0MQu7FhyVmnllEZCNI9WABSROaV5PV+v4CpDoc
X-Gm-Gg: AYBFou2IEtpXoVSFzBQL60pXURVP0y+TRawIDaGEc0SNvoLit7K/7uVLdpCSEc6UbCR
	cN28Gufb7JsyOpRXrm7xdCmaTevPgHdVbhEiF+WEvvxeiZDZc6epZRGTS76tS+msXjClaIFc0/C
	RMCj73/ecm7a6iD0jd16RlNJG7p7GzjqNYHr7pq/ZkhBdzzgpBV9vJc7qw7QFaoSCzX6zjeqQnm
	Yd2wJTWwbaEk2gWX11IWrOFlkB/TVpPMaTVFmnQJ5h6ocXNaq7IAzrlJHOtIVBIZPplRJ7+hJaZ
	Vuwxm0t5DHkjATykYU0f8hXPK/Fk0osJseHktbniOsuMCtFjgbWeGWJUyksh+Bjg7vuVsA0iArE
	vraH9dxDgOJDYSJlRvCi8eBqyuyANdSe6QC7ey+TyvKhxP3qj8qD0Leh8UnmOc67GCeOU4cmcUr
	yXRSqgiVCNXaImb7Zxa0ejcjIWvzJ8GviOzxmYjfbgMS0y97OKNvqLbzk9WCc7kTTkc3bTS3Asp
	jWIMIkRE5YwKyCgKAwO3ibohGUeIQGJX8XwUSd/KyZl202eCk44lcrfAg==
X-Received: by 2002:a05:6a21:9185:b0:3d0:ba81:79b7 with SMTP id adf61e73a8af0-3daed17ce6cmr934889637.12.1789069080288;
        Thu, 10 Sep 2026 12:38:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a3ce:533a:7492:3ff3? ([2620:10d:c090:500::4:d279])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fbd424sm248093eec.31.2026.09.10.12.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:37:59 -0700 (PDT)
Message-ID: <ec0b41c25bfa601bcc9d01a63434c6fc92f5b9fa.camel@gmail.com>
Subject: Re: [PATCH bpf 4/6] bpf: Reject indirect jumps that leave their
 subprogram
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, a.s.protopopov@gmail.com, info@starlabs.sg, 
	bpf@vger.kernel.org, James Burton <jamesburton@meta.com>, Nuoqi Gui
	 <gnq25@mails.tsinghua.edu.cn>
Date: Thu, 10 Sep 2026 12:37:57 -0700
In-Reply-To: <20260909204035.24289-4-daniel@iogearbox.net>
References: <20260909204035.24289-1-daniel@iogearbox.net>
	 <20260909204035.24289-4-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-09 at 22:40 +0200, Daniel Borkmann wrote:

...

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 8aee94689229..879587af8d08 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -315,6 +315,11 @@ static int compute_subprog_jts(struct bpf_verifier_e=
nv *env)
>  			kvfree(jt_cur);
>  			continue;
>  		}
> +		if (jt_cur->items[jt_cur->cnt - 1] >=3D (subprog + 1)->start) {
> +			subprog->jt_spans_subprogs =3D true;

This is a single place where the flag is set, why not report an error
here and drop the flag altogether?

> +			kvfree(jt_cur);
> +			continue;
> +		}
> =20
>  		old_cnt =3D subprog->jt ? subprog->jt->cnt : 0;
>  		jt =3D bpf_iarray_realloc(subprog->jt, old_cnt + jt_cur->cnt);

...
