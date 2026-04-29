Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3860C9443
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466888; cv=none; b=k7nvJYHPi8SDcGmfMOYqo8UpHn6oOOlGLDlU6grFvKpMP4DuqkCOhy50QU9PbY3LWLMcgn6chnrW05ztqwY+Mx8X9SCblARRUltWR0pf6gH99PKSyQP92efIBWnMlRnBTvp0QhaX+vM9aJJ8T/sueNce59o/o9WctiGvld8Ar1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466888; c=relaxed/simple;
	bh=O5dBa6oCs+siPrZPp2wWm65BGucwQHWsSGQKswAOUhE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPjPdngCwsHeKy1szJsZQdS5nfGvHFg8QBAsRXQlQOxTIFXgBYGZb9W4kROxm8OoVG5ZBCujaX6iPsg5MMmIZh4UV/t5RrdcLI+Ih9ZAjU/QTZRZdoDzgysAe8dywHLuGHow+JM05eag/DZoJ+4Ux/Ht0lhPZTIw/DfW7waRl8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtDGpO2i; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtDGpO2i"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so11004293f8f.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466885; x=1778071685; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZnf09ybHZ5LiCXLuEq7DacFCXz/cYnj1Ldn7gxNQWw=;
        b=LtDGpO2i2fzXjQX5gpzFh075yGpfS3sbpoMvUh5DzgFrt7oPbfWmoEWpEedNjzHcs8
         FyzXNUxkhmb6kSteen4LptNd48RTJfA9zNif3SEgpEODwWTLpC6xHBLUXwvCi/uVjXjP
         B4GuQO4R85fjK67a703+c7v/rXaIxUb/9h8JaX+9II1FF8Oe+K06FqW5r+vuv5GJCp5o
         15UadkROVxP4ThLmMM6SV72te/xETbhqe7PsfXFlfXXT8I+cJzHS359xxZOARcv3Vte5
         wnXqKfb39DDA/lKSwvf6cpub0Tg0YtuySnc3x6KrFcc5yLGR5/100raSeXJ9kCZSExGb
         RnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466885; x=1778071685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZnf09ybHZ5LiCXLuEq7DacFCXz/cYnj1Ldn7gxNQWw=;
        b=alP5N/Qiyz7IEZwpQHvaIn5d8Fdmix9zq8iRX9KlU4UKFEFbWF6lZy2gEv55kbZL3F
         yJVvjVrr1DgZYdEolV24hFl2Md/3aDa9gV7tuyPVn/vYZNOJqUGIMr1BUbUBRxiBHefm
         4Reo/ILNiB/ACKUAi+hXaFM9CyRS1Q881hzSgJS5msfxInujTr2su2yUHecAlCWswp3w
         pDl5lAYS7rvBIGUxI5ITGnj8zRXbV1bDUN+82xWJTaSanaBTmeOHj4GIdPqLdTAsAxvs
         pDH6sPKhWcY4/PdNpCs25/jGcySk4w5c3VnPJE+qXnGC9Zpgu5qD5swPKyfwlIMXBcYi
         iwRw==
X-Forwarded-Encrypted: i=1; AFNElJ9YNt+3CIJ4r+YodaJExvigMG1pG5CQ8L2w5y4KFPdWgIcCCs4a4EhiT7SLPQl9dB+G/eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQj59PUcuBg/+atau/kFDzSi3AvD4g0Xs4LRrH1/kefUxP6ef
	fw7iQo2LrHLl/gidJUyErvKiixjdHECTPIlkvl0Lbn7c6Tj7zf+IFWwQ
X-Gm-Gg: AeBDietgF1KFeGIXwCykzwmP1rJM85F2T0JPbqiX17mbrfACyysHDfQvG31Uulvbbej
	KQA76Phvdu4gJ45VgUf5P/IYxsnh/+a/0BALFYBVQBHnl2Ir0i82GMIeffgWypZuGrC/mFm1f2B
	6YtUJWAp4bizmapBN6BtXojmmXf6kLGR5cD34X7j86QfFj7SoDYzRnTzPlzPHqQG4lMHcziepZH
	0Yvg+1gbyoZ62yxQn/U9L6E3+wzrz66h1A8Xlf1lJnpFzNgfhx+EnyvWgduenGQmgThIIE2dLpC
	NaWR0hzy+F551dvqrXLvC/TNGrMhmqkZBwpQynmUdY303ix2vCcPglW+6ZOGj9vPlTD9jhZHrwQ
	CGrW4+lUZyc2257DT7BaCRDTaMcz/gxplOgIsuSOAaLKAW89Bv4byQ+vt8Q7E/NbxXDsMxbYj4c
	LlnenspBDxfMTVoG+l3RjoukORjUftxHr1avCbTqYd9TU+1Vw534RK6gpoujyhBEmANuSpWxoXm
	pf/CvaHxGEW4q2vL1w=
X-Received: by 2002:a05:6000:2006:b0:43d:7e6f:3816 with SMTP id ffacd0b85a97d-4464a72938fmr12199345f8f.40.1777466885420;
        Wed, 29 Apr 2026 05:48:05 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:1126:4:da80:667b:e928:cc8c? ([2620:10d:c092:500::7:916f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d481fdsm5771030f8f.8.2026.04.29.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:48:04 -0700 (PDT)
Message-ID: <006c46ba8ea2a37d0fa75f82645e2c011c72cc8a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 07/18] bpf: Enable r11 based insns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,  Martin KaFai Lau
 <martin.lau@kernel.org>
Date: Wed, 29 Apr 2026 05:48:04 -0700
In-Reply-To: <20260424171509.2041667-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
	 <20260424171509.2041667-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 10:15 -0700, Yonghong Song wrote:
> BPF_REG_PARAMS (r11) is used for stack argument accesses and
> the following are the only insns with r11 presence:
>     - BPF_LDX | BPF_MEM | BPF_DW (load incoming stack arg)
>     - BPF_STX | BPF_MEM | BPF_DW (store register to outgoing stack arg)
>     - BPF_ST  | BPF_MEM | BPF_DW (store immediate to outgoing stack arg)
>=20
> Additionally, validate offsets: loads must use positive 8-byte aligned
> offsets (8, 16, ...) since they access incoming args. Stores must use
> negative 8-byte aligned offsets (-8, -16, ...) since they write
> outgoing args.
>=20
> The LLVM compiler [1] implemented the above BPF_REG_PARAMS insns.
>=20
>   [1] https://github.com/llvm/llvm-project/pull/189060
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Nit: the is_stack_arg_{st,stx,ldx} accessors I talked about earlier
would have been useful here.

[...]
