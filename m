Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC918B0A
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775437869; cv=none; b=KODLG7ZhKMXZIls+FzEXgP8WbvWPFoHHDfN/kyuYKcF+za5O0i8MiclZseUI67Lb9GZY620OSRSAsPbE8wK69bP4wttCnq5jG2W41/2vcVvFUwB9KsaD8eJPwDoxmt1bLBJek1jpNqh2NqplXelAf+sIjFjnjSokdQlwPOBMrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775437869; c=relaxed/simple;
	bh=fdsrBekX6r4t1ATanQwQV8K5lO/UqSRwtiYVl20jXLw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RDsQ0yRpbSO9FBBCEQIA3pRJ/BizEdyoAzR96RtlXzamhF77Z3HG7gqVYNwo6AnrwdG0k7GjFPPFJOdREEBuEMc676coPa7WS4pZ2+EvYRxCKencjIxqMbRH8xYvtHtIT/mP3tczt9iTP9ybDLVNeSWTrjpolwxU2OKk03lM9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CKZOPwx+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CKZOPwx+"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76b95e652bso925127a12.3
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775437868; x=1776042668; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO5MNa1CRHtkGMFbhFqP9Xr+/poIqfeQ0sP/h4uUd/k=;
        b=CKZOPwx+v0y1Tx3ovYk7tVwF8e/oyQBclqGQVkBVxP31y1LP31jAzUmvD8YY0pcI4Y
         GaCkyg9TtsXDazYXektY4c3ztSdNG+8zjlv718EWf8O+gCUsAnVTVGsyzjYls7ugtDPB
         qI6W47hIwcNOdOJ/7NUxXK/1hgVaZ5ClFD4KvLilzSAAS1tCOJbyhgmbbjqKEB33tJ3k
         4+Pi5WncaJTwStYAYFx6To5pWIS/I+OqkbPjC3+WVEfqTA70NIBvjbk3obchYWqdM1LM
         InzUbLvWoqKgJvRnPDpmYg1WK10jS70vTsTfTcxnzIEHz5TcdY2dEMhfyoYAUkSWLmEd
         ZtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775437868; x=1776042668;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iO5MNa1CRHtkGMFbhFqP9Xr+/poIqfeQ0sP/h4uUd/k=;
        b=NcYP18MhKNlj7mDhmz5RX46AnH7EmYngaDp0jCedkCu/BHJoEKldwKyhK8ZUz1jPhu
         qfsuSj3iaywL6FccJucmmg//HL1TaaGFwi2kjpnF9Z91ZFChsMGfQTwdrdCLyBlH+nWu
         eHNjVxLDxpS0KzulWkcXySHZHUXagtrB6bLpDP8gb2JaskxujeJvoMQ/LYE3ADOr0nWa
         mG6iyr4/Flcf/Fje8kDLoId95P+d7EgS9IDWf/C0aqJ+9ebiWMbD6eqD/vVOeib3VPtw
         ZPpZOuveI6KJKFJ2pCzu/ABVT80ZMBGmEEhuyNo1yXYyV2Dm68tCD2Dn0JyyPkSkTQw9
         KMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpPbrUxAuZP4v91jaq8/8EBxQozz1kjbeWC3E2iuJN1SO2mwfNLN/ZCgy6wkMzpH4nwHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDJOT0SnSRLfsU08gO1xscG8/UrXkA/UcHCsifDQ+WREKthy4
	WU28xrwagGy+7Ii/7x2clNknBDQoHkilaTvxuBUqrb/e4SyVjMxLnmeu4Rc77peQ/BE=
X-Gm-Gg: AeBDievYdCr8IL/itqyJOzEiJhPR7ANxujokh/1Ytj8m8trZsaFY8l5lQsil9U9uxK/
	zDrAkSDR91+d7neru/VmIEf2nSRyFKPpfcczGkbL6joM5z4PfabRT9o4PY0qfsLVu8w6dpxLYOT
	RMeh6M3jgihDqD3vB0lwowwKmerQEcP7u772ANmuuuaYPtXGHoyVZv+6VDyl4ObE4LZJWVyZraD
	hfkr8Fzzboz6giVkSO7HiYdN9wviTdsPkm2e/KY1HHzf0fgYaI4WRb+y0F8GFwHkzFF8tNHWaok
	qEulP0zRriZDjgmMdjhvAnS0jRsj2mPGtM90VcS6sWydHgjKGJV5Tl/2VMqfGLaCQiWf2EYhT53
	hRY/DvWNP4Ag72p5MmfXNquPs/Qg4eOiklxl68zUGQMvgsnC7zw+HxJLSSQh7J/d32TE3sOEv+m
	tj53d1xoo=
X-Received: by 2002:a05:6a20:2595:b0:398:8d38:c60c with SMTP id adf61e73a8af0-39f2f0c9432mr10498476637.55.1775437867789;
        Sun, 05 Apr 2026 18:11:07 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6492097sm10655112a12.10.2026.04.05.18.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 18:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 21:11:06 -0400
Message-Id: <DHLO745WN9GD.3K4OBXMOCY90X@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Dan Schatzberg" <dschatzberg@meta.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 2/7] bpf: Enable unaligned accesses for
 syscall ctx
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401122818.2240807-1-memxor@gmail.com>
 <20260401122818.2240807-3-memxor@gmail.com>
In-Reply-To: <20260401122818.2240807-3-memxor@gmail.com>

On Wed Apr 1, 2026 at 8:28 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Don't reject usage of fixed unaligned offsets for syscall ctx. Tests
> will be added in later commits. Unaligned offsets already work for
> variable offsets.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/syscall.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 51ade3cde8bb..f06fe9a9b1d3 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6348,8 +6348,7 @@ static bool syscall_prog_is_valid_access(int off, i=
nt size,
>  {
>  	if (off < 0 || off >=3D U16_MAX)
>  		return false;
> -	if (off % size !=3D 0)
> -		return false;
> +	/* No alignment requirements for syscall ctx accesses. */
>  	return true;

Nit: Isn't this now just:

return 0 <=3D off && off < U16_MAX;

?

>  }
> =20

