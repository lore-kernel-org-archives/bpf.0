Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDA39CCE7
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828130; cv=none; b=jP5cC/IXhK2ty1Nh8TbFoAg+jtDNDidnuvcoUGuON8rN5/Z7DQKiF2enPH4AAaaf68371jBliRXGlRVFjZRw8ovrHMIRt1e4zkPq6gBybT9PT6hfZbQaBMyMKcLrFBZ4O3TPNT6Kl6JFQxv2KowX0xDaR7BQpF7TZjSj6jFcI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828130; c=relaxed/simple;
	bh=SQ7DJ0PfgPG+lfGBSOJGXKcBKPHLY+ziIZ5lLkxF/RM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ns0NR67UdvR/z6wIUC0jURPYthNahVgqkICrJXaGDyV7tR7fnR37Ewf4uZmwr0ax1NSr0W21tXMMJC0rAFNlGZNKT7N+xRguGHz4SRqah9cIN+ErxnparctcyiocML4UdXfQqo6RluNGmqa5hYSmO8MWNb2DPU0soAMmC2y+lF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7GhoN32; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7GhoN32"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce98cb8165so8813865ad.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828129; x=1785432929; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3+C2/eQx85hIDTRoY5V0ZRlv5zniHV47faqIMelZ0cg=;
        b=H7GhoN32KR/vp95vgwYtVkssJ7SlB3JRz3Zot3Hc/5hOmQ+9cIUQGfLhhqw6GCV8o7
         UkvKSLG5a576ThIKc187pvJIkMsMwsKDQz7cCFBcTb9EuO1tG+/TIgBlC8KncTSVdQC+
         O/vIECUTCYhVH0nmI8ZypbHImZpGCNEXKy2fVfSkzWK4BU29qYElgzH1bT+DT70B7WdZ
         1n+zjZnIJsaP0I8InwKNbKWdXISV7w08vLbkWnZb3vcRhXsDD7nt66JSZNMtb+2fVp6F
         2XTCNnt82SeOjft2Ef78yYr1VoNIwHBF1oZXzDUtSFVUObLo0dzBFOIPzZkjHMCzz+my
         01zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828129; x=1785432929;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+C2/eQx85hIDTRoY5V0ZRlv5zniHV47faqIMelZ0cg=;
        b=UyYttHwLSKvrM8LQewC7pT8GX0OrQZ3ObZwexxcnt9uJWYgC+WCJP/pSq4wlrhPLBL
         fvC1Tzb4PHEhky/JcTpy5wc2Gmv/xvb7lwAUuKzRqDYL2W3fgZNjnwss5FNUa0b/MYMY
         K0q/F7o8GwU8TAroP+KTSyqO1Lg17+2LjA9i/yFuSXcNSg3O4quHpc+9uhN55yvWdQ/0
         076aqRZ/l/dLxbZxmX4tXSS4pgU5YVhCavMvQhKnPytPzRrCCwTb8ByiuXHsob2nAI/Y
         jB3jRBdIb3VOHXow8NJ0lmE9Q+uRhuO1m8+cZqN1L/T9KzgiBtsBTgOJY/LbV5d9wUKX
         VNUA==
X-Forwarded-Encrypted: i=1; AHgh+RplnaMVfoiNb+E157BNoySMFdihasolqjhMNNRZkEatHvQ5uH+fQ+kjwbYxvdPfXb9QWaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeKSLC55o4wWJNDYOWwRZEW0iM7Bkwg7pde0f7DjCBwxA46lK
	QgCDwD4bMgu+AlpFMmpqoa0uhzpleCtAwuOuvWYv5g0afOP68GFj4cgt
X-Gm-Gg: AR+sD10KRRayhoJZCofR6s4DiQucRs82ZYC6Ytyn1OlHjoWQd6oubQZE6KgkR/NDh8s
	Ab63WTCh1hRgKgIUUlzdvct+61eF3DWstFI4C/Iga1a3J4e58AfvoxmqtodnW//OvAGVyd1kI63
	GsdR7hqIW2VbFTYaz9XUrnBKDFJ/RuCDHpYS3pMT7LXLjVrudJuziCM4BmNbmQA+LfKqZc7Odg+
	+oqn4BrrIpg9xRvlTSRXU8/evIOUYtv8ur63paD/Q0oZhCc3w+dNhjQaKJwG6rEc4WsDTWYcMDg
	DtRFlUUORU7DkfpVGd5nsIlgQtuxPVRA43rfYGsJIpdBA/LmBVYAIUJWa9xxGzhfoX1HUFtTKqA
	akX1jEEThGolFePJ9mATwVQPD0XE/GGr5yMELkUEguzX2r/BJzphztfX/n+DPB7XQGCc889Puw0
	tZHZ4Ryzit4ieBiUSKYKHsY3g7L8b3H+BdZ4//32CWfKKuOMRweDQYjcf4bA0=
X-Received: by 2002:a17:903:1c1:b0:2cf:18e5:1d18 with SMTP id d9443c01a7336-2cfa958568amr41353275ad.29.1784828128485;
        Thu, 23 Jul 2026 10:35:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c221:d012:6e37:77f9? ([2620:10d:c090:500::2:8dac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm21822514eec.26.2026.07.23.10.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:35:27 -0700 (PDT)
Message-ID: <c5c2dba26e217763c73c237daa6d8639043f5207.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Preserve pointer state for
 commuted arithmetic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Yiyang Chen
	 <chenyy23@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend	
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa	
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 10:35:25 -0700
In-Reply-To: <amGUjFu1MN__jM4c@u94a>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
	 <004a83de52a36e9f3acd6c3fa2d0dfd0a013460d.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
	 <amGUjFu1MN__jM4c@u94a>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 12:25 +0800, Shung-Hsi Yu wrote:

...

> The sole purpose of having orig_off_reg seem to be for satisfying the
> 'off_reg =3D=3D dst_reg' conditional in sanitize_err(). If that's the cas=
e,
> maybe it is better to change sanitize_err to accept an ptr_is_dst_reg
> argument too.
>=20
> And given now that we are starting to make more use of scratch register
> states, it seems better to get rid the likes of 'off_reg =3D=3D dst_reg' =
all
> together, and simply have ptr_is_dst_reg passed down by
> adjust_scalar_min_max_vals().
>=20
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce..72d49f2a57a3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13505,13 +13505,13 @@ static int sanitize_ptr_alu(struct bpf_verifier=
_env *env,
>  			    const struct bpf_reg_state *off_reg,
>  			    struct bpf_reg_state *dst_reg,
>  			    struct bpf_sanitize_info *info,
> -			    const bool commit_window)
> +			    const bool commit_window,
> +			    const bool ptr_is_dst_reg)

That's a bit invasive. I think the simplest thing to do is to drop
off_reg and dst_reg parameters from sanitize_err() and re-derive the
information about which one is a pointer.

...
