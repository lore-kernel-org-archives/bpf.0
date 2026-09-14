Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D654288AD
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344462; cv=pass; b=iUkq9foEa/Kb6R0qJM1UQV2oKSKkEiYip5bLV/WgzhsgPn/5teVL4XZQi8wfMJpt7SSRbnYMOb8kwZ8lrIPbWamb6XKySRO6s9ueMIvhD1znMwp8SJNACGefJuIROaoqXo3VDINbGJgadZbf9/E2pymbaQqB90gSrYeoGUb8j7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344462; c=relaxed/simple;
	bh=7PwzviEF4dqmT/XoKWSi1q97eWdnuvj01htYvo5Ua3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKk5YYQ/NEwwbJZIOOcLREO/6PBU2luOBBxE77bm5jzdNWR16x2En3pWQmuHljDIk65iG22EpZ0P/e+luPVYyYk/lGHhUYbqVzS5YaUDFs9wlbbE0lqA6JaI4qPxrONJFEPEXPOReoDMPOmSgDtxOQb0CLtkQa5nLhiEJiSdDRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvHy/Yhp; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvHy/Yhp"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6c1983dfaffso1851496eaf.2
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 17:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789344460; cv=none;
        d=google.com; s=arc-20260327;
        b=EZ88ZppYs8T5pAax8iJNi6Pm6gOp4UUPCqLoBe+ndbde0WnWIZo1ymyfIhyW8hdd06
         H2UxB2J34F4JPVMjT96AA1VmeJXyQe2oXOlt2zsteHa1s0Xz8u4FqyCZNXwU6QgSSg76
         WYUSKFATLpauz3KftwMYICR4K7hHoFNJf23Y4MoYw+JsmyTIrTYLBB+E7Uaag5703lEA
         HnX9OwxtRTbr6lYWxddC68CCyRvwUEmDmJC/SbSzrQO1vM7Nd3r2GhBX4sWplc6x0Mra
         +WHLZqxAEtrFm9TIgakXl5diGBD82cjyKvnqgcnIp63xl77/EeeP9puCRe7xf5UGnNyo
         dJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7PwzviEF4dqmT/XoKWSi1q97eWdnuvj01htYvo5Ua3o=;
        fh=b0nTke/dWNZNVxYYun7OzhjBPrEmqbca3P2CX/fBOFk=;
        b=dr93tNe6ry2IdJ3MnyPW2lZLPb9K4jQaDRZuUC/S5S6BNOyoC3p2xJcGAfOjvD+b/W
         A/U45VGsEvNiyppLF8YO5q28nqOpqkC3olhlhCoCfZvxlaOqjHIQzQbEFijG2BzAlhU7
         gnbEioYwRDeaQOOGlZIXbPd89xds56bT5NoNrwgBrgCOPd9f/RV5nfPD17CLv58naMnE
         vCDkjRnK6DA+OUSI2vUEH5HeEgUNY3Bni53hhloBvUwIYEeuJBuLgHc57oewRXay69/Z
         5C27o4dowfizGCh0yx521yHpJNVceZIT52R41VIVTXuWnvomkNlsX3TOcdurw9IoNr9b
         fPTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789344460; x=1789949260; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PwzviEF4dqmT/XoKWSi1q97eWdnuvj01htYvo5Ua3o=;
        b=OvHy/Yhp86vI5u9g93KoMQmS/J7OC1yX44Fk/PmneqSY5Fxl2Xg/RbgoffVjGlF37W
         U0in/C8nWG1Y4pkgXLSi65QaOfQ2oKQpNker2++VosL5cd7fTI6/+tIeRy8q8jaSgekX
         SFwmLwonM/NT/lfhjHU8vax83C2/dYajFSnKbgiN+6+3ROcn2zlW0RUK1Nw/ZtdZumH5
         bELR/GUAK8CpuBQ+6dySuO1bRB0njVL++DLAB9lOZWeCiK5Q3a39v2sYSVJEP/SB+LHh
         ZgJtIibpsQz5VT/uOBw9qni2upJKfuEfIfE62zERG+MnJOdUBpKQBOBhcj71c54/Nwbd
         bDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789344460; x=1789949260;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7PwzviEF4dqmT/XoKWSi1q97eWdnuvj01htYvo5Ua3o=;
        b=rvt8ZRbb6o/qtdEUMwQaqKGixFNDdVTjqe0VfKvRdnKO+LKm8D7wTTR5dzcEZJwYu0
         k3mpBpreCMWdbOZk8NXjdH984rNB29PaD89MlxNroiHiRgQ2KNAqzC/2+vUPxzcH4+kH
         slzqyA25RB5MIyIUncr/luC8aU7i/Dw5tMHcyuyeb36/wkrRsxouEeSDwuaXHbKSsoMa
         najSn4YU+ZL0Q7wrYXrX6jsNHlN8wrDVtkZVYP5NgHSznQgFKlepnxveFD7M5vCk4Kha
         T+YUZr/EYfUxQrueVUg5jjtzbfY35stHZIpXabIgFwfTGaSH1B609CRPntpwvtyttCUT
         liAg==
X-Gm-Message-State: AFuF++m+TVExCodPzN2AtfTC4kX47n0ejPwl0qLYPLczWgrlKWnQ1zdZ
	BnGvaPeljwvQ1oHDuZsfgpOkeiCfpSr8e29aZDcbMPUxj7AB3VpQ+nd0YKD0i3iqJDVJbHpu3MT
	p8lrPsWPXxC9CwqgsBiV3GETisxy0+4Y=
X-Gm-Gg: AYBFou0Bx7YjHxED1+ZhQkrDqNgkeBRzWQDF6urduiqexoCmdwIWdrfSceFDrDHYpcg
	RMIoICOyBhwgwmfQ9zJFKHkKgXlGxhcrRA29CnJ4KzGczzxMo2R5tvLRQJB0Kx91Cl/7v5ME1tU
	lKtI3tWhzdKZfiQnehVQ+A5Gd/13UoBPxkUz29jBAlrrinrPIFmY797DAN3f2pKsEUF/PE6WSbn
	/AhHQkYVxMhrmWerFS2Ykw8JbZwjPIbuLLkmfW8TvKfTqng0W91QzaM1DAfpnva0gkWwtP6rVE5
	wzWdUo/eML7iu2aCjy1pWGt4TjzMhltC5CG/mHseg04B+xGOiR42vlk=
X-Received: by 2002:a05:6820:615:b0:6b7:8415:d785 with SMTP id
 006d021491bc7-6c5423456f5mr57158eaf.48.1789344460102; Sun, 13 Sep 2026
 17:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn>
 <20260911084254.3481508-2-xyx2021@mail.ustc.edu.cn> <CAMB2axMX07j49sZRmGFm2s==FMgKFzvKPWxc8hDvU=b3Lp=VOg@mail.gmail.com>
In-Reply-To: <CAMB2axMX07j49sZRmGFm2s==FMgKFzvKPWxc8hDvU=b3Lp=VOg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 13 Sep 2026 17:07:29 -0700
X-Gm-Features: AcwNN1WtyJIKD_BdB8RZDUnaR-K8q1ku-evp2BDspz3mWWcJwsVJQGJ5LoYBtgc
Message-ID: <CAMB2axM2WtNh2fo5MAuao=4G_U2pqkLhk_VtGsaDFHoQTh5Ddg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Invalidate iterator-owned BTF pointers on
 next and destroy
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[...]

Please also rebase to bpf-next before respin.
