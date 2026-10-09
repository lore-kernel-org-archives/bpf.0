Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619834B1A6
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539785; cv=none; b=TV2m2lVgaTzdvZ/A8dykBo2LUQrw2tOY3C0vzqX2Vh0Jufj0qo1unD4skOfG0AuztBYNAPBDThy9w3lXQ34Ua7vSAp3EiIawCZ4FC9EdTrl1vFfBdPtp6Cf07O05HcnSR8wzjLhecKoLuyDHv9nSQeDKDvIgmTBGg3L9aIYhd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539785; c=relaxed/simple;
	bh=Y0/rDYyHRawHC445lf11MGdDy5YaabukKwvi6CwPqSA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=q2UsRCBz2frHIC6tI9QoHrzIeGqjUGkF3GETYQIILRxyrMa68+Ynj3vSG7SXAg6F49Oa8qVJWV5sVjSWw0IzrbuLYrPHuDXhDfRtp+oW7xE79lDOVF3BEsxj3wu7xnSaXE/A8rrHh96BumIzh7YMdOx+LidV5nqAJcIT5wB/lr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyukYt/z; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyukYt/z"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4b62d118aso2488033a12.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791539784; x=1792144584; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yv1DDAsoywTGffsbDdsV32fvuHRZnVcZctAYe3CSpx4=;
        b=VyukYt/zqcnB40kOeMfJQFfssZ0Ac4pel44UTT39p6oDgxIkeB+rjHTo8nn/lsvPrw
         FcOALlb0I1+2SvfOGBk1DwgHjYIWMfrCgXI180FYtblvWE01APTG0GlBjUnovTcL4a+C
         gvmbycieADFRusErawvhuC2EZ1ViQYZA3Vg2Mht42nUp9fb74SZ/uABoppOEEOgzmk06
         4gfVuE+ITaVV9fy4JuYZdV6oef5wAuOzgzkIwNwhLksGo96NQbwllTHgLjwaT8AazrDH
         V3WGd2IFJcYy0seCyVqOmMOzpXw9twFJ7bvaFaerv2HgcsSmRjPkV803HQvCfhPRCU3H
         3TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791539784; x=1792144584;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yv1DDAsoywTGffsbDdsV32fvuHRZnVcZctAYe3CSpx4=;
        b=aghng4U62TY/nM/duKq/LFtD/U2cbAWeCjDkw2jhYEJTpGS2VwajVWlrt1OfNvCZXA
         d3spr/NAWQfKaiZk4aRNDMH4jHSzprfbckS0dyOt6YFJCkBLmM+svyZCaX643oN4mCuV
         H2j4wy+JoDfK/Waa/LWpqEarzHo8acWcvwfRubXKp/qxeXu8mhkzp+jQu/ZB7fQDPzLK
         lEsq0M9rDy0CK+Z5rZjn1ZH0Clu4TnAnpD39xFshTpU9LjCHH/NIIot0clx9a0D8EKjW
         v4s7aUgrq7XUL2xEqTJ64Ui/c9O8xN8eANo+Vgpb+7aEGS6fq3L+e8z3j4dU4pAqSfVJ
         1pqw==
X-Forwarded-Encrypted: i=1; AKwUvBzEoUOzlfcG2oPzIUcFX438r98zDfHBgi4qPJj5F0GYdRCofC8WuHMHu1YcdsWfKby+ZJo=@vger.kernel.org
X-Gm-Message-State: AFuF++m9xN3BMv8bUHJyIt7c7FT89JQclnGvj+WCQz1n5Wn4I5Gtlibl
	HYxVHjvlcqrz3OI+QcLnikZYkjH8lvNG6RpCnMnbvelTPySNu7p4eVK3
X-Gm-Gg: AYBFou2euT6Iv9hoiDzmxcgA2Bi0D4/yuZLXS+lFwg3rh0a2BFP8ozKOytIL7bIuEjG
	A143ix/sYLOelxZthJARbAijnf9XFx+ygk5fuCyh1OHK5OYLOuSa1CPMAui8jy3BakNzGSc62+g
	92izQHyvOegC2qt7wJQ4ttp3EPqghfDRTaslzsFDvcx1cClieSmu4WVhXHnK50xO2lli4zQxQxX
	fNNoS/By1799xlGbK6V3y2Qd8tc/1ODpZZgn41cMcXy3qudzBiNRHSNuUTWk9wB7CPKrw1YY4SZ
	lKhCuap7GuTM5zZu8mPL6qMDiKB2reg19AhdK+LCoH8vMYqKjvoEJ038SVneWM3+BD1t/UsGEql
	jb4A0ff6HAbeiYMlp65wBWu7+++M24iVg7Uee4ha1B8S9nZXMH2LVhYEhevQHISg2zEhGWHd+vy
	AT9nRPd0zxWZnkkHA+IxBkARMgOR2U/GEzglTX9gG8gpB7mKKDHnv+6zOl4+NEwtk05UXuHVDvs
	lmsffF1Fur4lUAghmA076EjK5YlsnNwr6IQR1XbiVCZ8Zw8ELGv8z4NrY0VP0FRofqgFv6mmx23
	S9JppEGuupipDg==
X-Received: by 2002:a05:6a20:244e:b0:3e1:468b:617d with SMTP id adf61e73a8af0-3e16bab5423mr1101860637.9.1791539783900;
        Fri, 09 Oct 2026 02:56:23 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da0596f9sm662849a12.31.2026.10.09.02.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 02:56:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 09:56:22 +0000
Message-Id: <DM07UMA0WYOJ.35PFW44XMAKP@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v4] bpf: fix symmetric register-form
 NULL-pointer check in check_cond_jmp_op()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Rahad Bhuiya" <rahadbhuiya2021@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261009043819.1208-1-rahadbhuiya2021@gmail.com>
References: <20261008185349.494-1-rahadbhuiya2021@gmail.com> <20261009043819.1208-1-rahadbhuiya2021@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 10:38 AM Rahad Bhuiya <rahadbhuiya2021@gmail.com> wrote:

Four versions in 22 hours. Not a single changelog.
v2 answered sashiko, v3 the CI build failure, v4 the bpf-ci AI review.
Pls slow down.

> The symmetric case is left unhandled:
>
>   dst_reg = known-zero scalar,  src_reg = nullable pointer
>   (e.g. 'if r6 == r0' where r6 has been proven zero)

Which compiler generates 'if r6 == r0' with zero in dst_reg?

I don't think we need this patch.


pw-bot: cr
