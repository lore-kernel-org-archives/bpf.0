Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBA134CF
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286712; cv=none; b=aokbDrTgVMFizrE1/ezxKFtqqxofWJYOY8vmuG87Cs1jbbsQSe5kTr/gEErNvKzGfZo6EIF+BMoVKV9B4G7cFS0qUo2Hq7OS+lZyGoeN9S55uN7JCe+tdxYlg0UAT+tIToLK9c72hF6dTcLIxjzaRZpEWnMFGc1V7SX25mDGcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286712; c=relaxed/simple;
	bh=21GnbT6wp81vV9M/ud8/rwHFbXCj/WbHHH5Sw/UppvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVdD9D/VF+1WS8HxaGzSglIAYNfH5BK4N/jLQ00FjSOsJElhN+in516iH+O5BO70qyyMo+0tKZz3ID6jvcQ2bTt3pAU6bJzlmfQJtTZyVOT4WGPnOGm604sPZ7FZNP84qhsMwsOPoOPxfARWDjWqQldcSC+BBuSybEJvZuSV+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVr+Dzwo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVr+Dzwo"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso516131a91.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 17:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286710; x=1785891510; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ylNNNEvZp3+lZiwGGO09XotLrkiLTU61MPCxVFgm8zU=;
        b=GVr+DzwoRM39RAeMDGKBAfqErGWeruXwplJK1B8zaxWY9tiMAx9Lp+0C9rhK0Z/lY8
         bCvP/89LC56/7uxWiDUniwyU6jvgUrs3LIKUO5AlYkREZ7alMpN2KXDcswO5PVv+H6C5
         iojE/L+qjvaWkqxzhNEEOxHjUaquTaYz+t7q1obKBlJBG/wKmzUCF3jb/a39bik6pRcU
         TSvYW6mPHvXKpP8gdxpCYBHt2XVGUItWLVvIvOUPzJC/xRo3dv8CJDR2PmKkByjXhSDH
         cHzW2iZRPIifEkZoTuCEaRJu2ID7eGY0D6w6qD++FXHjdkJB+v6wqqqtbD8DwM8J4k9v
         wK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286710; x=1785891510;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ylNNNEvZp3+lZiwGGO09XotLrkiLTU61MPCxVFgm8zU=;
        b=eaaaTZEOHvdJtQGb96XItho/zw5HXdeGNur9e0zldGSxhlUFK0AnoPu2mwiDo8IjlU
         kSKnvNVxjm2/nctcX46QIuyjaIIbuw8O/RdHN9W0q+nCIvShDNJ3TQGMnTXZRDeR57sy
         zm449IHmVZ6CD202ufLlsr4cYJxtBrWVCKxsYEiP2Irj6q/PGBU1ElSfkWCv6ITQJNPO
         hK7bD5J/0fCyg1mAnknRUdAC/iOA6SlAM3h1ezU4+j/LKacmB8ryLXHjtfTl/+yKIFtf
         SqEV/SwuDNxJ4Dq/lEetb7Z5TE+Bj0Kg1HonORMSXzK+W+YM0b/AP3G/PAcbgoAWP7L7
         mcKw==
X-Forwarded-Encrypted: i=1; AHgh+RoD7SF1Q3glFxtLqMpruYo4RAQDGEULNP9wVwP7JNhtr7CzbyYb38UIuJ+q0Lsvt2K8B9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMW59ZyoZ5s7EITk2ejqnO3byoB778W70hdS1JziVrZQ50KVGo
	2c9+4sf2kzeoJa855Fvj/uWFGaQmnBqy72ysoi8i0agTdL5bZ4HO4MKK
X-Gm-Gg: AR+sD10dAUX69+L2AExOqxX0DOo7/ZldCWFlR/Y745WmFznphP8X974kQk3Rrt/yj5I
	+69BwShTE2uQ4pNob5RuztgS+GJZemTjzFSLW1U4tobklhAC+4P0zlUFFCEiocaW2JAMrArUYq3
	BGCiL/W6zpsW09VAmxShfUl/vP7biHeuZ7KEzJscCfnZ58JgAipJ1xjJWnUdE+Xftl3aXHry4EX
	BIe+UHgGz9KVsUK9lV8lZ0P3gju2WWm0Ow6Hp37WriO9A1BZXddEj53e5MJA791PryzhFSQYUqo
	RPpuo+xg9EY9KJWn0UYJ3IgyeVgMkotWSecjlstiXyrFHhC4y2OzmVyQy0x0rHoZPWVrs6uMidk
	4e0y2+WaIleYMLRnF/aKexBkd934SkwPTCx8pTqrsTZCnXCvtyAk89HL2t9CdYCQeyo8gYeE4o7
	/bD/8f8nxW6lAgPx0GNFobGyrOzfv1INOnZhkkce6fxiPpr+9kLmau3dg/ta3/Pb7bwSNXvdjDv
	z3E3nlutw6ewS5c3LFK9vJ8QjXqO/OfyUbu1RdqvDQ9ig==
X-Received: by 2002:a17:90b:3ccf:b0:387:e0db:3faf with SMTP id 98e67ed59e1d1-38f6a53f749mr4887035a91.40.1785286710238;
        Tue, 28 Jul 2026 17:58:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm3271397eec.6.2026.07.28.17.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:58:29 -0700 (PDT)
Message-ID: <60ebdc9ad7fe251ba240268d61c2b66dd6153d0f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] HID: bpf: Make syscall kfunc flags
 match the struct_ops set
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 bentiss@kernel.org, jikos@kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:58:27 -0700
In-Reply-To: <20260722233518.778854-7-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> Update kfunc flags for hid_bpf_syscall_kfunc_ids set to exactly match
> hid_bpf_kfunc_ids set by adding KF_SLEEPABLE flag.
>=20
> The syscall set omitted the flag because syscall programs are always
> sleepable (the verifier rejects a non-sleepable syscall program).
>=20
> However the upcoming resolve_btfids change enforces per-kfunc flag
> consistency across BTF ID sets at build time, which is why this change
> is necessary.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Benjamin, Jiri, could you please take a look?

>  drivers/hid/bpf/hid_bpf_dispatch.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 536f6d01fd14..44671dbdeca8 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -590,11 +590,11 @@ static const struct btf_kfunc_id_set hid_bpf_kfunc_=
set =3D {
> =20
>  /* for syscall HID-BPF */
>  BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
> -BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
> -BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
> -BTF_ID_FLAGS(func, hid_bpf_hw_request)
> -BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
> -BTF_ID_FLAGS(func, hid_bpf_input_report)
> +BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | =
KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
>  BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
> =20
>  static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set =3D {
