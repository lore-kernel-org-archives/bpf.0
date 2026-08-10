Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C527366045
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397257; cv=none; b=e09nPj9dq2/PtDUH/+Go8eIFuKPZ7Q5gH6fZncTfdXxXcPSFpMCzsAvVl4NcL4yug4QXULn1TT4ru7NDf6YmgEUSPWBcoNO+eYKM4C5qMqdVSvdeuZtIpTsThVd43y7y+wIPUY3SkmH7gylhCPN+mmFT8XdGPrvYaXWZcg01XbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397257; c=relaxed/simple;
	bh=NXvb7s3/qRENTSL/evhzAhhPM4Pb93ScFARdHrzmtLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PgzyKNLtC63hBXndLoVSK/HuCykwW4i+CDTJmHIfxymaTxCflkM9QQ6F8VADYg9/+x1S9WoFTI8gpBDdtAorfZ9Hikoq7CN2DlSBKfZHhZK0RVIrkM0/PZ05QXgaWICe0NBhKnStcIz5jtPDYz5tSqJVw27PS/seE27x4Tt73Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZkNQJ4T; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZkNQJ4T"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2329040a91.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786397255; x=1787002055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m+y6FrNX46tJRUwIlvcMASBTiGW9nxWqu51j6c41Rms=;
        b=gZkNQJ4TvInDBm5TC0/4s8TY3i+OnUItUsFQBMUgXy562BF+1URWjww+3Vam3NcqXT
         mzRemYkieIEy/mFUuE5cwlY+DluRgdDYkOkOl2XEr3T0W1+PLkAA5H1h703eAMVwrrnS
         r8KwO1cjP/NPmuJ7qh/bPAmFV4svr4i9qxkrMzpTKKaPuwyGXgZjRxW/MTRzgoH5FXJT
         PXvPxMP3KKEW3DW/vK87jNNwMcf2UgN11sr7fbkhuEspGGdUrNyzWwTBEDy9afMIbjSA
         8fntRV9FmuX5leRRzYbW3XTMTwgqAUXaq3bRgS69mHwSkUHujRDwRyFPby/T7IGlgNwc
         /Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786397255; x=1787002055;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m+y6FrNX46tJRUwIlvcMASBTiGW9nxWqu51j6c41Rms=;
        b=fr9xSx2DKEtQN7X3d7PD5oK0BPCU4UMNDPkOXhHNmVTWORQQW1SJLlcELsPo5sRusm
         JXYm8Sc7NCHJsoSGjdKc2Q7oKRr7ZvlO3HBkqq6iVR8CRtiG3YpLYlXYBfk65E7OGjCu
         bokgyspya/lowMMUD25Y5coQtoHK292GYxFHttcdRxvam0FJ5KdWHV/LB1hoQwl+AwhJ
         VZKz8LAMM3bTpC8jeSatPzSrwp4Tvm45PswSod2xBYMEN4tX5qG9rcuJPNBQX8545661
         qMxRYte/L1p8Eo3mf9UgQaFGya+3888C5Wb8jeN9aHGnIVuvduj+pP+Ny6g6PxnMjpyo
         i91g==
X-Forwarded-Encrypted: i=1; AHgh+RpsAp1DCuszCezq49yapWZdjYFpgZYLR1GHB+MOkpk00xVSWm6wZg9twUOxjEztXC3oroU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMsZZU/YsG0eN8bgNy7AByLv68auDWNln0S++XzCaJrS+yQCH6
	KTBBZrvVe2rzpiA6br+QThAvNAACtsG8L0OOR4xK9wdmXgshRRaB2dx0
X-Gm-Gg: AR+sD12FS5dOQpK0BfrspCEx1cv7jAQS/yx4XWyz8O+twFUYR77BgoxCydv77YOcFde
	svZUq8KCuB5aiZiFb6xr6zZ1sV2ZkK37vUYZ0P/kZ3UAUy8YHSvB19GVpQTxUysZEqL+IrD56Fr
	S1rDoNgZq2t8XNntZR8ps7H+o8+pjdUeiR9qBnqYSLAUgEfkLRMrzttE/ZDDeljL0yzFRzBUjDZ
	UaLYIY4sFFwiP2d29HvhLis1R2dmunKp1WYN/OxkaahpwgIZUdE9VY7vznoLB8bTitv74hjsu6m
	Ug5yOl1OsPRqsHOSM1yUqAukKZ5+gh6AVx8apJitaDKe/TfOmFVB/h4KKEJV1OUKEjHBbriO47u
	HROVhm9E/4gpy2kAJ2JhipM+U8ajz2Op48kqw8FSoHSijM2twOa9qNIvd5+9wA2u5daD404AWas
	c9rumb5gE70jmzgR4nZxskfX8qKPbbZHrycsnmxAV5fI7hwfIrVGIH20Vb6G822Wm8kCafL0WY6
	ycANLyEjsVynpar
X-Received: by 2002:a17:90b:554d:b0:38f:23d6:b4a9 with SMTP id 98e67ed59e1d1-392cca737c4mr4586428a91.21.1786397255334;
        Mon, 10 Aug 2026 14:27:35 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b345b841sm6909984a91.3.2026.08.10.14.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 14:27:34 -0700 (PDT)
Message-ID: <855d8ae50086be9d792c5efdaedd01895c7e2f13.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Remove unnecessary dup/restore
 subprog_starts and prog clone
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Yonghong Song <yonghong.song@linux.dev>, Anton
 Protopopov <a.s.protopopov@gmail.com>
Date: Mon, 10 Aug 2026 14:27:32 -0700
In-Reply-To: <7e27df89f8d4e1c8790cd26b4bd30ffbd2926cf6.1785240296.git.xukuohai@huawei.com>
References: <cover.1785240296.git.xukuohai@huawei.com>
	 <7e27df89f8d4e1c8790cd26b4bd30ffbd2926cf6.1785240296.git.xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-28 at 20:25 +0000, Xu Kuohai wrote:

...

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 505d134cd264..ab5da3ff941a 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1564,27 +1564,34 @@ void bpf_jit_prog_release_other(struct bpf_prog *=
fp, struct bpf_prog *fp_other)
> =C2=A0 * Now this function is used only to blind the main prog and must b=
e invoked only when
> =C2=A0 * bpf_prog_need_blind() returns true.
> =C2=A0 */
> -struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, s=
truct bpf_prog *prog)
> +int bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_pro=
g **pprog,
> +			=C2=A0=C2=A0=C2=A0 bool clone_needed, bool *cloned)

Imo, the code is harder to understand after this change.
Maybe it would be simpler if clone_needed/cloned handling would moved
to the caller. In the current form I'm not convinced the change is warrante=
d.

...
