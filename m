Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8230C142
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573038; cv=none; b=TM6EApdq0aJJZwA1Uib9H/3V5D+PnVmG7DnsB1yggOMy8ZFsBU0ITF+nRiG6Q+Sor5iYvQ+7xAorpjKbK4bYut98tE+vRBx148JhBfen12/plRa4KbtnPYGLbF2B1/NiFiF8J83BPvt1yh7hYRFBqQHlzvQkZ9UssV0Yq6wpSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573038; c=relaxed/simple;
	bh=Vc+maRlzHSDoYgXfsGWeigzOmsNl+6MqXcgQJ7qxxOY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=BjTUuOCBGKPIpwxzHnnlDoZFvD5Tzdb5c1Wcby8V2kLEbMYM/P2VbIBHw0F1JkyAN56iA4OfIzo1EB/I2nLcEOLZRvUzSwDOFnT3+0m5XVZtH/d5vM9pps3BPoqMbQV3eJLMh91hWyCoHtoYahgcN1WW2sIpXi2VoBr2L0XDXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=EREuNalo; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="EREuNalo"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bb2df6fbbso2963eec.0
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781573036; x=1782177836; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe8YWslIf9gm4jvk0v+TWmxJ3R0XMoL65QlDf+Vgrpk=;
        b=EREuNaloN0WsSzoyocZoPxGoo81yGmMbRIOUmTt3de4gYMDOqBfMJvr63MwpT33uic
         Hd+n0UQZyptCYfy038G7D36yOaVCLpvIhAXjgD9jto1SLncTlA+ulJfzNVjXL1OnjoU3
         sqSzMhRn927C66cqh6Y/KISYFOVNNiJ10c7z+u8DzTKM4bZ0Puw1hj8kbezCr2XE4B9M
         Llz5+2cJYqCakDFIhpNlVbNcax+rqbGLtQh3lbETK+DRXKHjVSMPnXCx7s9kDLcX3JHo
         TDsiH+e077YZ1EgvFEkwpHRtyekPQtBG6qgLjtbulNRIPe0vKycRGxcj1prdXrPZw9UA
         Radw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573036; x=1782177836;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qe8YWslIf9gm4jvk0v+TWmxJ3R0XMoL65QlDf+Vgrpk=;
        b=hqUzB6cI04n71aMjdJi4SLabqe6Yf12BVtcS1VZKovs8+7P87QRMlC/YCtTcQV0YSL
         XiscgbYfc8WZE0w7bPGQy9/gbXD/FRd1dEgovufbg7gNGSD1VZ1rFb1GMi8+HqdKzv5j
         tXvTfkkYIOcNgAp5WZaBRZ9wZgJFTeaoixRF+dkSE+irC6tUTMzF5WhmoCY00FQYu1Hd
         /6IS2zGUWA8Anxspfw45qxy3txPN/539YJGFjyJypihjqWICm659ptIGa8/fAjiVWYio
         1o/O1/9uwUlmswMUzwWCeb1TlRC6CGmj8SkmuzihpvzpZP9U1OyCb9n7ximjJ2peqALc
         yjBA==
X-Forwarded-Encrypted: i=1; AFNElJ/rlGsPbzJheBgtDaGiwXtOifJe3YmDo+AIk/1hA7rL8GqE7+1JANqGgeYTFLNDIb3JdYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPPtsz/bqOZE3KDCByXsEAN2V2nraCoDaKEkB7KfN0conp2XK
	1e3UfCvBIbpb1qtkCRLt6Pjdjg38ml+YIpnJy23ku/z/GIDs3aPMt09ejEugwt2/T7k=
X-Gm-Gg: Acq92OGObqR8G6eINpQ2/JzXAGy+joO4cwZ0oJNjCn0RHgP0mPblYgRs5rwzOJ/Cd/H
	1Gt54mYNpXTbnwf+tNB/TYTz+A2TFwK7cVDvDoyejU3vytddCrPG7ANKDUWqJMJb7iyJsILcZJu
	GNnvRGdDhyIeKuKnUE3OsUxnQ0bB+Zv4J/N5WxLyNP1sdlFR1wmUQ3yjlgH1G/G8sMcYNExZx6A
	jLvwAbV/7fANlw/izGoxbYpRy8dAX+IpwtclmWaCeicfoUGwm4ShsXQu6kkawDqIjNBRibjH/U5
	AvXLiCK0tz3mBBmlCAj5zCWQxwbMcMnOjUlfiH550mrl+h8zD+G92grJR2Iln02xv3UNC+TRJ3O
	m76Jr0alqABV+pAHi7nnaqn74LgM8YFkma9/nyvFB6FMayGfHrZ2T+lGo3EJ0sKsm3KRo2a+X9L
	cwEID3
X-Received: by 2002:a05:7300:6415:b0:2ce:3aa1:d39b with SMTP id 5a478bee46e88-30ba5ec50c5mr1143193eec.20.1781573035527;
        Mon, 15 Jun 2026 18:23:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::bff7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm18153448eec.4.2026.06.15.18.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 18:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 21:23:53 -0400
Message-Id: <DJA2XL0AL5VW.XDNYFNSCBML0@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Emit verbose message when prog-specific
 btf_struct_access rejects a write
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615232146.5491-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260615232146.5491-1-alexei.starovoitov@gmail.com>

On Mon Jun 15, 2026 at 7:21 PM EDT, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> When BPF_WRITE goes through a PTR_TO_BTF_ID register, check_ptr_to_btf_ac=
cess()
> delegates to env->ops->btf_struct_access(). Most implementations
> (bpf_scx_btf_struct_access, tc_cls_act_btf_struct_access, etc.) return
> -EACCES for disallowed fields without logging anything, so the verifier
> rejects the program with an empty message. For example a scx program doin=
g
>
>   1: R1=3Dtrusted_ptr_task_struct()
>   ...
>   4: (7b) *(u64 *)(r1 +0) =3D r2
>   verification time 83 usec
>   the program is rejected
>
> leaves the user guessing which field is off-limits.
> Emit verbose message.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/verifier.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281..030505c8f3e2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5786,6 +5786,10 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>  			return -EFAULT;
>  		}
>  		ret =3D env->ops->btf_struct_access(&env->log, reg, off, size);
> +		if (ret < 0)
> +			verbose(env,
> +				"%s cannot write into ptr_%s at off=3D%d size=3D%d\n",
> +				reg_arg_name(env, argno), tname, off, size);
>  	} else {
>  		/* Writes are permitted with default btf_struct_access for
>  		 * program allocated objects (which always have id > 0),

