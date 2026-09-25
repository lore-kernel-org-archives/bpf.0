Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E93B2D0F
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368529; cv=none; b=rJo1UjPx9UxhwttYXVfH8ebch9PR1XRMx3bxlFKSzkaGPeAppQT/3rgspeJRB4hvN8lwZqW+NR5x3NzU1CL/4TL42+0tAJYHXcYvEO12FDwYYkdTRh4hcbY2UMEddrqzS0JCBPqoUN4NNGAJJSPqrNETz0gIVIJgTks4XwlqJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368529; c=relaxed/simple;
	bh=vPHx+JByx8l0TYl+zB7IzwfH+Tmv+iQcsRruU44ePIE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=d9zbQjDTjP4ItIw+OdXQYW9DafSsfOsRtxmgSNBBcmuDN68dAXkjCcX3OWmfct0mMv2iRrd6SM11aeb7mcKI4Ux/fJ6By77dXW9aq+mpIrpsJ3sHcOgLh9egV93CcqE/hRqNaXeneZtLWfqQdedlVyAMFIgMw1EAVST76sX0VcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO/v2G+2; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO/v2G+2"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso708288a91.2
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790368527; x=1790973327; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RahKXyALpxxJlMog/IoOu/AqxGme9XhkUkuEy+BX9JE=;
        b=dO/v2G+2+ztAAZlqOWzlZkN0qnFxkIgV+C19Cxp+NIuqfIyg2s2af/qatv3dJ4UBqA
         zrncEeMdl+y5HDRz4XDjRsnBA2HLVTVDos1pOzGNtqn01xXtioWCZVAY8rOmSCGEW5hL
         BG7JZNFJd6RUiXu0dFW4hfWAc2rqB9meo2a+cbH1PgVYnNC58wWZPGiZ0DhGSBoXPDMM
         sD3vx7/QsNmrNy3io0XJpOgr5ydVpTJlWPR2tNimg1wNQQRZQyz/f6eVTIzD4UjUMyc3
         lnsPBLKprvqa84pdlh9u+ASzyu9LUsI/L3o7z8DRk7GM+Zzo0z3zoTkbh2MEugkD8Nt0
         B3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368527; x=1790973327;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RahKXyALpxxJlMog/IoOu/AqxGme9XhkUkuEy+BX9JE=;
        b=tkSQ1Y4fiM7c13UeVFHNldNxE3ANiGEWqfnEqqcYeWtUa27Odn2tmTBpWTGtiuf95h
         rwPb0aQFtvMhucZ/+EYwefnYlQun2K5ULOf/E87KT9GU6K4nvBOApz3OAcymSspbsZnD
         jcmeE0SlnZrNOFVTIRUKUz2GG3oINB07xwv0tou5O+WwC2l1dMD+fqKV260htpcjxsmv
         qG+GFGs2ZwNp2c9csGH5e++1caaE4JHsraQhNiBCujz2AopS2829314gSRpqlgIGp2wT
         KlQuWHmPS9vtZWJix71K4sBuoU7KAa0hWRZHajWlSapWrR035jgcOS3mjHdAEB7xg5Rk
         2ZZA==
X-Forwarded-Encrypted: i=1; AKwUvByVrvPzhiho1TLq7m7ZgteACMceDCmJNGU2+DZJsvs7wevR/w+zsNZOpXpHbwJVbId0k1M=@vger.kernel.org
X-Gm-Message-State: AFuF++nnyP7fa/T7fXzuf9lGv9zP3xxwx1RSZJnA7krTbUdeVbHekPML
	cLL5++3/Bzuz09vxsagKFZVoelsudcfW1j1XW1Lps5kklgHnlXRIFtbn
X-Gm-Gg: AYBFou0sLJb7rEaeUxYg45txKqoYtgRpjpRkKFMUbTTuzl1iFq6ImrkiJnlLN2F27AY
	bSmki3nRF341kZ8e/nTKxrvy7HXUynyqWEIGYEUOmwV7NnK2hvlxOKz1Sndv4qQjoiYAKE7IWCX
	KZPAIhul52Df3N6fNBmgmqbbr41tzA/eDC5tedlhjXrwNWoYsiw9NKxLt1pmoOJ4lrRwbwM3pcv
	osQ3pcL7+IgjArLOIT4ucPZRzdzjW3n+zGgW4v+CkPUYhvXokAIhuk/ck0WXc64X5M9Q0lg1K/g
	C9RjWs5ZcJLvavi2Im99stPx6siGzK4dea5aVSn+esjUzpvOt/yiQxu6UMSdUBVXtKCAHAgg02h
	ZfGzr5UeuBhZcPPA6hRJ8OWDAerrJDsTP0/rXORjkZhiRv14X2ONxPus4vQos1sEX1fn39+avA4
	qr9FXFn5cCvQ6QaK03ZIGzXldnV1KwAK2B1YGjdLCWjnO9eS9AbXPQlPuyZV5UvjA5kyb5bKQIF
	rDROJNHP+watuGu/TRq2LElUSmzlU6UY8NHJSZPTVAwCtBMPdhHfKMA+yjNCsqpcRcK5IP9C6fW
	T+5PSHFMouDNAg==
X-Received: by 2002:a17:90b:48cf:b0:3a0:c367:4310 with SMTP id 98e67ed59e1d1-3a0c3675098mr1979608a91.52.1790368527400;
        Fri, 25 Sep 2026 13:35:27 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b99e5220sm6113368a91.16.2026.09.25.13.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 13:35:26 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 20:35:26 +0000
Message-Id: <DLOOOAHTOMTC.2QEWQ5J60BATG@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <qmo@kernel.org>
Cc: <jolsa@kernel.org>, <daniel@iogearbox.net>, <ihor.solodrai@linux.dev>,
 <yonghong.song@linux.dev>, <song@kernel.org>, <martin.lau@linux.dev>,
 <memxor@gmail.com>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <nsc@kernel.org>, <puranjay@kernel.org>, <yatsenko@meta.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Verify BTF_KIND_LOC_PARAM vlen,
 flags
In-Reply-To: <20260925170854.1240637-2-alan.maguire@oracle.com>
References: <20260925170854.1240637-1-alan.maguire@oracle.com> <20260925170854.1240637-2-alan.maguire@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 06:08 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> +	/* All LOC_PARAMs have vlen of at least 1, none have vlen > 8 */
> +	if (vlen < 1 || vlen > 8) {
> +		btf_verifier_log_type(env, t, "Invalid vlen");
> +		return -EINVAL;
> +	}

Why 8? seems arbitrary.

> +	if (p->flags & ~(BTF_LOC_PARAM_SIGNED | BTF_LOC_PARAM_CONST |
> +			 BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_REG |
> +			 BTF_LOC_PARAM_DEREF | BTF_LOC_PARAM_OFFSET) ||
> +	    !p->flags) {
> +		btf_verifier_log_type(env, t, "Invalid flags");
> +		return -EINVAL;
> +	}

CONST | REG and DEREF without REG are still accepted it seems.

