Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAE367B9A
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970777; cv=pass; b=I+ZkzwGw8kohjhThCkqhagHL1J+Lr2q38COC95b8hcAJT6CpD7zL5rBqWz9nCOQqLJBNc+CqSuef+XcQkmJ4oT3vuILQQibs+Edkk+4vRQobOn6NNO+GefQAzjB221/kT0wwrnzkpevs+f+rXLeJ1tGSU+G4tjITm4RCxhx+77w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970777; c=relaxed/simple;
	bh=r0oea4DsE+/Fov0KykxRB5CSjwQYNH/nKviFCsjXURo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXEvUA1PNKN1OItw1GZ3EOu/t2c3MHF5n58DspwFlW0vk+C/5XV9jhqFHNIt4ZMyeWmAv+G6jVtxeIlXf9FZZI8vpXsThP9k7CKVMPLfTZmW8CLQ+7HSh4JmmXUz9cSYtVMPHWCaLt+kq1hPQ43mtj9zMr3uPfkKP+QbAbVneh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adgzpMRH; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adgzpMRH"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ca15944645so12296815ad.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 22:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782970775; cv=none;
        d=google.com; s=arc-20260327;
        b=U4WNA6YNUl65BbpiS3ktRVIJ8n8v/sbWwTKb8L1YHTgo9BGFDfxUdu35+28yqA6GG3
         GxoUJpT/W4+uXtIeDZi9tked0hEjBOoiSPG6Zm/LonVbowmbi7uAJl5N4kfqSj2nkKJG
         603Ukm6koEt8aUFAHhn65RXJ/PKdEzWG9Mwfzf0PN5FCLULHiB8sLr2ghnivJ7ZyMhYD
         RK+WgtHYVz/chswLXICHV/RuBmh3JSmnJIhUkAluXobnqPvCPX0H1+9P44Ur32utJrbr
         Jf4+b9IqZd19oWR4JcsqJhaX8CN5KtBGo1ptAPQyy/9XgEIRDOzAekmCXzomDskyz9Qc
         8fLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r0oea4DsE+/Fov0KykxRB5CSjwQYNH/nKviFCsjXURo=;
        fh=eOw4QbFYVf4yn8vexkR5qyYKsu2oasJV4SMwf6Tzeyk=;
        b=G8PhRRnuojYRPL9GYB+sPLzn6L4CMoVKK7jULYc+Q1B66XM2B2Yh3dZNNqvhDQCtNt
         D2MWUn65ShUa4UmdsbQwxo4geA+zqWkX0Ryg5LBE/DyoaJmBElmw0TlCdf4WQ9c6WGaU
         LOaJ0O6xRojmQUajaIwVuQ/SOhFNgxb9hn9DHcxALLjvl/10Jkfz7Nyddbyo3Rh284Pq
         ltOl6OppR3Kr4YAftjCpQcxdXnq9zdhTCegkF33z/InwSbOmZxxW0AFRPeGLSehz1dtV
         z8zNLyStkFS2BRcrTHzurfkt5j/BTOReglSpKE3P6ZdgaNIgIYuVlb6MGCujgt8MWo/Y
         yj2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782970775; x=1783575575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0oea4DsE+/Fov0KykxRB5CSjwQYNH/nKviFCsjXURo=;
        b=adgzpMRHAxSnp3T6UND8CzrIzo8TKCyZbBePLKpZQyBhrO+lPDD8EBlXZlBXe49+8L
         yCkUBlVkSakE7A/Pn+kPvWJXr5ak3E2Vv6V1933ro7H+lXHnXq57vhxy+KrspSZrt+7w
         Ih+M6gfsYqlSiMGuMSBl3KjtnwWmaVHXR5kKh1bxluwhej/lv8L56VuXcXPeSaGZknD/
         QzFe4zbO4ToZpiZ1r3/5Gtk8CSxxZQBy+5awtCTUzmEVm1h/rNn2mOEdzXOPRkPsiMPi
         lKDsX5OSI9oCh57sl+Kn9FcS3TzYZCH9qHhBMq0/vdx/RC6+SRRLPe1qT2roqVVQUpP2
         PkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782970775; x=1783575575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0oea4DsE+/Fov0KykxRB5CSjwQYNH/nKviFCsjXURo=;
        b=OxlTqhyx7tMyGt1NLTcB5k+zmaV/Fmd8lTh34j3RgWc26GVQWcNhU9OlapAQTCnS5/
         l1qDomFCfzDwsR8HB2tu8LxbJwb02zNBT/451U0X8I9LZbMVeJBvFxMob+CpobCNlZ3L
         8iIasmP2otqG1TdPKu3MbodKGxf3ahGdtZPiPDaQwolialURwdoMc213cLItD8Sp7zk/
         j07WPEUWiqvyi5X+ZqvYvRYBeQRdelci/K+rc098O+B4tbim6QKScpA3Bv5YVw+SFfEA
         Po9tre6F2ih4XDA2qXojyObWydmrmchQldtMxKp2uhT2tHNcmjN+M2HwW+UuFP4+2ew+
         Uqyw==
X-Forwarded-Encrypted: i=1; AHgh+RoQFUqVUW33VsDZDCV7VlJmZM4OxV2VLQAqAX9JOp0kIeIcYZAHoNfFUY7oPKGoA2NI0BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZU540PXD0YvxWZM4btl7IYTKPuH0lmn64M/7X7t6rNLeWQgE
	BaEKSxfhIJR3OCjYAU5BYL9cUp9BaEHD+osrLjtZubaaVVIrOeI437Tn/ZVs78O/GYcwJuxWTNb
	I1B1eO3YNWLwAt8T1TG84ykQ3xPn7jRw=
X-Gm-Gg: AfdE7cnG82Sqm6l3mIakRiSWvjwHxzdqUmNuOeQk/mlb//OaE9YDf189/lrP+pw4Ow9
	2PkcCkl92LJ/qgZjYj/q7YNRzbdvnuQHJTTaP9q7OJL1ud+M3uT0peiCTxw61lMq/flmWPwymyv
	qAcEgYYCwmXfBcNHCw/Ko9KMY6/nEc7rXkdnZGUFKI1abLzwlAf9wezbusvO30n5Oiw2/bxxBzQ
	14svC2gUCfhLeInbgWSBOikNK3CTiCq/jbZPMvi1kWXLDDM7TDGCHXVZGEZngJxBEcCAt93y4KU
	nwXrOR7VWoE646A5tXWdwKeHLdurnMrqfnJL4yCFDtKGMxSehgLMJcuGrBzQkxjzejOyaGQC6rp
	hwpas7fvQT6ulzw==
X-Received: by 2002:a17:902:e841:b0:2c8:be9:1d9e with SMTP id
 d9443c01a7336-2ca7e86485dmr47475665ad.34.1782970774733; Wed, 01 Jul 2026
 22:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702022108.17693-1-yangtiezhu@loongson.cn>
 <3fe115fd-8df8-4bf0-805b-2d0c2c40fdf5@linux.dev> <527b7e2e-e9cc-33b2-6a17-a888331a4d3e@loongson.cn>
In-Reply-To: <527b7e2e-e9cc-33b2-6a17-a888331a4d3e@loongson.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Jul 2026 22:39:23 -0700
X-Gm-Features: AVVi8Cef_t17V2Lu4bXkTa_xCxYiJRzZZA1gYJYB61h0hKWpLeqLSaO3rYNd5eM
Message-ID: <CAADnVQLaRRXQg=LuQMJpjkzqc63SK9bEP=DCGShHPrxH06mj3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] bpf: Reject programs with inlined helpers if
 JIT is unavailable
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>, bpf <bpf@vger.kernel.org>, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:31=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
>
> Hi,
>
> Thank you for the detailed pahole analysis! You are absolutely right.
> Changing 'u16 -> u32' for the bitfield group row implicitly changed
> the layout of subsequent fields like 'type', disrupting their natural
> alignment and padding.
>
> To address this and preserve the original bitfield packed layout perfectl=
y,
> I have rolled back the 'u16 -> u32' change. Instead, I moved 'jit_require=
d'
> out of the bitfield group and declared it as a standalone 'u8' field righ=
t
> before 'stats'. This elegantly packs it into the existing 4-byte structur=
al
> hole (at offset 52).

Your replies smell AI way too much.
If I sense it again you will be banned and all your patches will be rejecte=
d.
