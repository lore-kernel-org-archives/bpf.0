Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBA836C0A0
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773092228; cv=none; b=P338YcK88UCZvew4JXMlquNNOb5uugBgMbHgrqCuCBWnOhsYeQUBH9IzMY1oDBAEr0UazrjXqrKDDtOA4e469F7Jy2LqOyEZbxIyXLRL0nvEY0t2lk7EkVbQMn6ReJQ2A10+7JMHHXNznm6TXYylu0LaibdoXCH9ztIBc1Rguec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773092228; c=relaxed/simple;
	bh=m1mpEWVI9ON06Z3ZkPKJ/8O6hK2i5i9B59iAP6ngmyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZeVx7hv2yr+V/i3q+SWSrZCNlR1Vp65Kg3F0/PORATRx77G8rDFI+pc0jDAPhVQSbToy7fJp5nuVs4BnlE6UqNmKoFcQcz3bzUpxlxFYcXyxzcLLN+VtCyJk1GzClleB9ppaEG12C19zaHUbZ2ccZoBtg+3MBai9tEC6ViU35PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei8TzCdd; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei8TzCdd"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso9256378eec.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 14:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773092226; x=1773697026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCptEfOsEm0hpwTM96l/wvvOTh0jHbr+FBafjGgxX8g=;
        b=ei8TzCddb/Tl8vONTCJ2lLpsy+Xrv086APeHMdtMuNoy7qaIh0fbUxI8v4ruhVgIRV
         ZWiZruoGFamKNJ/+J+bHyBO9hfU4m9uwyV+7ueLMcgfKX68GOrBREJe7N6V+5bVIDxDl
         wy7KbWaGyxtRV3hfVdAOA0q5jWefTB/bLtsCfwJkYrzV/Zl0+n1kKsBe7G5dctzizSbB
         rd/CYSVR0kvnX9ybUwYKoDJMS/qkrh2a99MY4Hx4GX2QbSp+1mZyPzc/G6sCYYbaYR3Y
         sAMxhg/oYJAP4ZoIXZD8SUTXkT3NspU02sYMh3GA2GZsBR6isMGhDjGrLF03zRjIWKtB
         a49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773092226; x=1773697026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCptEfOsEm0hpwTM96l/wvvOTh0jHbr+FBafjGgxX8g=;
        b=ghkgDNStS21wXUtLedANsQ7eBg7cN415h/ndjLq02iGjX+dPGss9g60RX18wLJY6np
         PVU7DIKQGIafEkvuDZzkT4Ij0Rw2DJ16a85ZAhK9d07Bu4YfZAW2Fb1EA7mpk3kXy200
         GGXcFO5aq+PO2B1F11jbqHjiCWtvmMfkRcKEtQRuo0jUwef1Vwz8brfzZK+B+US4HURt
         8NNMhI/Bi2vDhLuOFsRfeRJH64077yWw5AqmZApXsk8fziHtae+qxlRya+CCw2ZFQINy
         hjKZpR+RB903112Zrc0w4w87jfvKIIhBgHKZ4azGOVaMGuK3NxSxXRZ5b/zvCcjKyyoZ
         RiGw==
X-Forwarded-Encrypted: i=1; AJvYcCXvd8afZ2A2TgqqrhKPf+NXhRwMgq+/3YLyjDAyk9/NG4qzK6hufWieSjwbqTn+3N854WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxVOr8TCIlwcLtyGntLqleIlQ4LShnwtkebfZKypCSGGyfuSV
	h6TLkG5tR3jstBQEe0PGkuUZ5wbhxl9ekoSpNjftAFoH/Y6Qniqc3AaG
X-Gm-Gg: ATEYQzw2o+Nvrwr1BEtl0AucJQtMNHB8L0CTW8mC3M/pkZE+z22efprrnALQlZmVL+C
	dIABCbTVrLTZGv2vSw5iz/h6LWnwEUN9YN6W6Kka2vZudwdzp4bbddWxd2Un53J3U0kYQeTb4sj
	CfXbqqrpUvoQi2bsXNI7muAYAbN4lVqzTOiTWIveFRcGWTVNMRQNNThfCgkps3LSgOirE4uVNdm
	NJN3Fq0VoucrJWTMjzJWlVyfuk++9etykozIJCOdpqFXSSvqBOX5OjitT/aBVM37kvQl3sEvl/4
	GTHHrRHX3pOrtExa2WgA+OOxRTb4kdtANNi3uqj3n27C4+xE6LvNXNx3Gwa5tWLuS8K8KbGnLZ9
	E5Iv+bZz24jIebbKX1CCi7PPBAXGRGIwWFPZtJi4Y99A+TItEkXlYTn4FyzSFxgMMJqESDj9AtM
	ga7pWi1GcOVCrWbqqF+LWWev1suQeLA0I3qZwwOV+TMv24yBRKEDRa31knXPnv2+k05otrlVNGV
	QFRlSo=
X-Received: by 2002:a05:7300:371e:b0:2be:2f62:8bb6 with SMTP id 5a478bee46e88-2be4e0ac325mr4534453eec.30.1773092225607;
        Mon, 09 Mar 2026 14:37:05 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9362:b19:e25f:7640? ([2620:10d:c090:500::2:405f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be7ade6f56sm948473eec.0.2026.03.09.14.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:37:04 -0700 (PDT)
Message-ID: <7ca5c5ed22705e31b4ff6085dd4b9a92fc653f53.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Mon, 09 Mar 2026 14:37:02 -0700
In-Reply-To: <20260309204430.201219-2-emil@etsalapatis.com>
References: <20260309204430.201219-1-emil@etsalapatis.com>
	 <20260309204430.201219-2-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-09 at 16:44 -0400, Emil Tsalapatis wrote:
> The BPF verifier currently enforces a call stack depth of 8 frames,
> regardless of the actual stack space consumption of those frames. The
> limit is necessary for static call stacks, because the bookkeeping data
> structures used by the verifier when stepping into static functions
> during verification only support 8 stack frames. However, this
> limitation only matters for static stack frames: Global subprogs are
> verified by themselves and do not require limiting the call depth.
>=20
> Relax this limitation to only apply to static stack frames. Verification
> now only fails when there is a sequence of 8 calls to non-global
> subprogs. Calling into a global subprog resets the counter. This allows
> deeper call stacks, provided all frames still fit in the stack.
>=20
> The change does not increase the maximum size of the call stack, only
> the maximum number of frames we can place in it.
>=20
> Also change the progs/test_global_func3.c selftest to use static
> functions, since with the new patch it would otherwise unexpectedly
> pass verification.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..b45c3bb801c5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -651,6 +651,12 @@ enum priv_stack_mode {
>  	PRIV_STACK_ADAPTIVE,
>  };
> =20
> +struct bpf_subprog_call_depth_info {
> +	int ret_insn; /* caller instruction where we return to. */
> +	int caller; /* caller subprogram idx */
> +	int frame; /* # of consecutive static call stack frames on top of stack=
 */
> +};
> +
>  struct bpf_subprog_info {
>  	/* 'start' has to be the first field otherwise find_subprog() won't wor=
k */
>  	u32 start; /* insn idx of function entry point */
> @@ -678,6 +684,9 @@ struct bpf_subprog_info {
> =20
>  	enum priv_stack_mode priv_stack_mode;
>  	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> +
> +	/* temporary state used for call frame depth calculation */
> +	struct bpf_subprog_call_depth_info dinfo;

Nit: I think this adds an unnecessary nesting level (e.g. I'd had it
     either at `env` level as a separate array, or here w/o additional
     struct).

[...]
