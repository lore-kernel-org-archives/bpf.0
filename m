Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917C4A0C
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980591; cv=none; b=co6tit0relRkeAw8P/ns4a2NjaLxvF7k/3OtMrKT+D1/wKCZmkOtwaq9U3KBrITHdRGmDmN0CQHJciXAMhLL4p9caNq858k+yPkEJ7rRxFtSGoE4GcLpzzaJ3MKczgNwAhKUDy6fcTha6keN2F1Nw+zvBJQ/sM40tyIFDGD1Fp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980591; c=relaxed/simple;
	bh=gsD/yMciq6j/2dAEmngjHdGj+1UyGMFNx2TIoF99TTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlaRa0um3FUoQWdqzpzKzyn3qtpy/05G634R2hzt2qXMFPu6r/TYbOmZzbcIIBX7ztClFKj+IwdSetTo3z9HVpSBN8Rxtpz9ag4uVtiV68lvdKELAY1SPFiQYPd7+IBv2k9pDOlyD9+IM4kn4ET/pe0efWt2+cx4ha5n1juUCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxBWUgdM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxBWUgdM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceab75934dso26485895ad.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980589; x=1784585389; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gsD/yMciq6j/2dAEmngjHdGj+1UyGMFNx2TIoF99TTk=;
        b=rxBWUgdMaN0/ptGAotpKubxqPXVD+8DAJzCx4DH2eA2ud1tu8Ig1MZjQuLVeM3Zopo
         My+xfKnsBtEzAbBEQibVen3Z9l1BdxrQn+tHhYQov1yCSmrqp2iX9eJlT1RS8EWVRAfp
         Vw0BXb+Vdz0f3tCbLeH2qcgULUw15SGhtBbo0bAYJN0oVH598Dzdxzl5ne46YkhPr+GQ
         uydlLjTC4FHp2+l58UchcWstBzX6QhUJDPdP3+TAFPyt+bMEb4l1B6t2QgNz/2iSwIIz
         BkjqFmUD5Oz8FSh8tu2WVHL+Nr22MEBPS7nWkSxJ/UvR8rFWqK/CdsAAzxu7yxtILlBT
         YxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980589; x=1784585389;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gsD/yMciq6j/2dAEmngjHdGj+1UyGMFNx2TIoF99TTk=;
        b=NQHhShw0zgImJb3GERaqbi6t+gH5LsAmMZqF1NZktb7p/UrMVhTzwm4eiMWPVIMUZ6
         EGqpEBXUE7n0aFfxr5LvSArHtFoNIc6usax3mIC4SL1DGBZ5PPc1iKlujMmcVyjzA5OO
         2Qh1w9nYLPKq2VJBreevhQHSZpwymFxhSdhDsxo7OW3fEii6i4fMR7z9D/VKA5WTc85p
         cKdVlhSu9QdzeqwzJfLZBUYZUtuICG3dgRqoQOdQRqBt2V1UbmMjtNz9pkIE/pRf9hdT
         A+xF0o3bx3RreDL4cI7eo7fM4IE3irohRG+7pILwVAILNXLZaTFRE2VD4kT5d0ku9Ebn
         zP7A==
X-Forwarded-Encrypted: i=1; AHgh+Rq8O2JFBaDlfSTfB0Y7lxFxcvXnX3SDbmseJyDsWlo4UGTwteBv+9FmHgsrdwyOubOQoUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJKW5KD2KkBE4zcPJzsv5v2bCnbZ1NpMHaLERqSqC4Kke7rXxY
	mbVPeON0QUX0BvWKd5ymf7PxfDT6yZFdpRpteQY1Pihzjepx7jxWC3hK
X-Gm-Gg: AfdE7cl5XtRQl29SUpC/SPcYaUgO1Z1OMQht/OnY1hbt8Ov8NOcT2LXPkEME161NquZ
	yZwT41tH8SMcU6F5MSLtPZE4iGxxIDxg5DIsD6Iv/PgINCglqN58tzjupRngOX0/weVzmb+GYE3
	6a+ex5Opp+JwxNG94bmoVeu2QZLVzDFrDSzfQ1Xq4DU6HgdnwFt71jKHDGLBll9+OyrpwiHV6qU
	dtLsTFrn8CCPF0/IKUKQtEXz9n4B1vu1XpSn3y4hOi0cfH+7r+CR+6HAFiDh940zzmUFytgfJ9h
	pugrx/gzK1S8dnAbXZbyJfPwVayDwAiyVct3bupu1yClKR8qngYIPXlBSiIOmx3662pJ6gph85d
	ycATQ3gOKGRSgQ3zT+1X0au1gQxuHvNjqCscVBU8PKj8vQfJ3jSxp2k02oAjSPsL1O69qTHqF1W
	bTYIZLSQVHxk2Fg6cB+a/S1GhN5FFp0trMXtzHk7JnKGnVSh10S5NXripuOEEzOw==
X-Received: by 2002:a17:903:19ec:b0:2be:3850:297e with SMTP id d9443c01a7336-2ce9f052d20mr101568855ad.31.1783980589319;
        Mon, 13 Jul 2026 15:09:49 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e33sm103432975ad.74.2026.07.13.15.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:09:48 -0700 (PDT)
Message-ID: <3e15d4b9ce4e24e94e0a95d3785fcc0c90448c10.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject callback subprogs invoke
 tailcall
From: Eduard Zingerman <eddyz87@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
 <bjorn@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Yonghong
 Song <yonghong.song@linux.dev>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Song Liu	 <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>, Pu
 Lehui <pulehui@huawei.com>
Date: Mon, 13 Jul 2026 15:09:45 -0700
In-Reply-To: <20260711104727.4023420-2-pulehui@huaweicloud.com>
References: <20260711104727.4023420-1-pulehui@huaweicloud.com>
	 <20260711104727.4023420-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-07-11 at 10:47 +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> Some JIT compilers, such as x86_64, rely on a register to pass the TCC.
> When subprograms of synchronous callback invoke tailcall, C helpers
> invoking bpf callback clobber this register, and the corrupted TCC may
> bypass the TCC limit, leading to infinite tailcall.
>=20
> Fix this by rejecting tailcall inside all subprogs of sync callback.
> This also cleanly consolidates the existing async and exception callback
> checks into a single unified `is_cb` check.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
