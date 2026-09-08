Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B6538D98
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881076; cv=pass; b=K+sVIZZug4rROZazRjFbebSqcDK1WyEnmH6iSV8jrhxOQwM4zTkUfFhJEDGleCbOTNO91lRKUtGVi4UfW0ZIvYMt74QSCPo5nub0T5Q9eSNOVg34iQjl1QP3vhoYULFitjF+T6lomsUCAdcA48eHSSbVG0U7wIRI0eHDf3Z1SW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881076; c=relaxed/simple;
	bh=lyTdOGr74RZ9r75XXuibKDNT/4L95hR40lBqe2QzwBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbCPh/O1JxwH0hg4oZkDkLxdOewxulcapA+PyMefhQefUiaOhRBiEzc7EltaF4K7g4nEEApxG/0KkJm4HCMtgZnPMeo2lque+sRvxL3/8DqQKwkODDlJY35s5lDUKIU4GbchrdYoNofPKCwE8w+oMSa733I1kw2GWcjii7x+Koo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiscbvAH; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiscbvAH"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso2543388a12.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 08:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788881068; cv=none;
        d=google.com; s=arc-20260327;
        b=KOpW2zEPnnCOjtrXwUmYsjRZ6lm3T/Nj1T9YazzQdfXhy9TkEFCwazxx1XgaeGgXuA
         DBoH3e+G8rkdcBCFD5kUlUSdo/2M8YFbnLdEa8NhV8sM6FzxiN3GunZAvD2nKEtulCZt
         2JFtVWHcbZPPAyeZ+SrMqI/wrtOftSBgD8vtRU4YgJo+MvkGN5FPjknuEYnIsmWrc6T1
         u8D8lNOLvCvxw6ZrkICptG0CmfkECyM+GvVLphjxcJ6w9G+AHJgNn4h+SA1gVglUvaRh
         CTF1z5Uj8Hw5t1sqT5wuWQk1kOBA7ACInGXe6hNplsTt/6uLXvR815R1dzj8PpiNiXeT
         noDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JpOSeO/rV0kg6odyiM/7k8i1wVzzaVotrtCBn7bkOeo=;
        fh=PiZzXbmd7hJcZtjSouyIc1YrC1qfhJkhey4rD+tta/c=;
        b=YpZ85GHqGxlvLZ8T1jm9YPhE7v5Av2RJsxyM/vvUxG6a4Ukp4utodNDrx/xCFEEgY2
         HT8cMhWT3B3l5FqsN9mc8JezBoYFfeQ+yYnTIVH+URAM6vxe8QU1u3T1UCB8xb9tSoAQ
         yHTmBY+DUgugC9RUSE1xME/fZWbE3kGuDn3mlm9p2i/taVQob3CCQRhtOnwxTtBcoHLN
         0640ObkU0ARK27gNa3FjPZj4wGONbGYI3M96rYMy7vDMmdXr2JqLgQV8qQU5hJX+Aeoo
         QaqkU0guH9acF4nMpNZKGgMn/a0fSM4aELAXQYeaIY14lyUKQE1bGc8TWebEvpmoaV4m
         LFeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788881068; x=1789485868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JpOSeO/rV0kg6odyiM/7k8i1wVzzaVotrtCBn7bkOeo=;
        b=FiscbvAHxHPvUzsHpxwXNQcJXgNA5QD2UtDm8ewYgZpYVVBe8KshFKTvzALCFYCsjZ
         CZ3FB6RYjDd75dCAQ5RMEJYByUB8bG5SAbKW+8AS5HeONPPFhNaGJ7aOAT4+00RoFFK1
         6MfLbYZRAp+0I0uRbawdGdhbeWIVzmTBxhGX1EJhfCeT8tU9Xp2gdBOKyIqZaRFYGM20
         norb/gFldgQwEkAhAe0wUzjYArUx5u44acWlSiT/T82mswz/BGmQ+FhUwrQGI/GUbRGu
         w0ue9ehf/MbwOKEs5SQFe22+Oo/ObNwLkYp4bVyS9AzluVJDSKtugfH7sYzAsKwdd2/F
         UKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881068; x=1789485868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JpOSeO/rV0kg6odyiM/7k8i1wVzzaVotrtCBn7bkOeo=;
        b=cq5hj/GCmQcuz+h51Tj5zoVgEpXwOpiY/4iK6lRPdVhUvbmQJVX2PCqPuQmOkBAn26
         YSjlrUOFVMbybKn+VwZ5Ogm3v5+gb1j5Sc6fnQtZzjInfPxcu6yC28vSZPoMPpURkB/g
         VoFf9LbU2VJD4qcPNh3VoFZ1eEqXFia7ifXXk4juDrFytocR7BjzF9LsijuF7UK7t/YG
         XHh6JMQMbs92uKsS+q6h+rZS4seTa1LV/hpRgPYsJMXqWniDoBdciCmo+GlkUsc0eN/K
         7EeciK5jIh7pizYjehrBpZkHVxpveYH3+u2nnnT6Ieo5Ni/SuxN+KApg9exMnTWmrUPg
         GjrQ==
X-Gm-Message-State: AFuF++n9PykTsDJZAmPiIiXxdkxBuO1mUYEHAqlx/aIgWH+VIELUuVMY
	cvwCg19LJyap3xH9ynkhcrrOd2oRnxbBs1OMMWVJGm61e/Z/BFlXTupYcAUXRJ8zTo1ynzt6IRj
	aAztm+sdcNQet7vP/uw8Nf49x5oVjn0k=
X-Gm-Gg: AYBFou35peBRzxQHcFrPL+y7tJgSOetLGpa9V3G5YerPnWrYd0p8yzwDGZSKXR9PPaY
	wJmr8FI5GTLZ3MGBBj5RqtiqrwfxphnGBOSqIgi/GuRFFt03yzd4KOC7p9YcsA/8poCV8Gf0sgq
	Vu/JpwhCPgtNwrHR09on2DaJwnYClBhuQQliiB6nZLEf32uTW8t+XiT7PSoiCV0MsG3cYOnoS6T
	032zMyMMfc1THrelPdk0lgHe8jeD3gar7AOckhl97JKdkEoTIfCvbqTthScqD+TUrYdgYYEb65X
	CQap2STfwxj1o4dPl0AXNZeip2LND2ZQ67o1GG74DPFjA3hO0SIpR6L8NXvMxpXpf3V8GQXbDd+
	C+drH/QHRzgBUO7B17hdiuw1VpSLI
X-Received: by 2002:a17:90b:5287:b0:38e:6a44:671b with SMTP id
 98e67ed59e1d1-39b25eeeef9mr46996895a91.0.1788881067803; Tue, 08 Sep 2026
 08:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051033.3979978-1-yonghong.song@linux.dev> <DL6XUEHAJN3Z.20UKZKTLHI2XZ@gmail.com>
 <f034ac4a-2829-4932-b3f8-b13cee4688a6@linux.dev> <CAADnVQ+bKmypdfAPXdk9jDN3QedX9EO9YXHFudLu71AR02Z3CQ@mail.gmail.com>
 <7be30b65-0a22-47b6-8635-e0054c6cba24@linux.dev>
In-Reply-To: <7be30b65-0a22-47b6-8635-e0054c6cba24@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 8 Sep 2026 08:24:16 -0700
X-Gm-Features: AcwNN1V-21xzL_DpkYXWfsn8Zbm7ZIR7vESPz--AbwRtPegg6U-d00wimB4Z_gc
Message-ID: <CAADnVQ+gGYA+gvEOwvqWCSg4jd4CUsxL2ZWUJCtFAhiq2o2Tbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/12] bpf, x86: Place kfunc arguments per the
 SysV calling convention
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 10:02=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> The following is what I was suggested:
>
> llvm: no change,
>
> x86_64 jit:
>
> +bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 ali=
gn)
> +{
> +       if (slots_used >=3D 6)
> +               return IS_ALIGNED((slots_used - 6) * sizeof(u64), align);
> +
> +       return slots_used + nslots <=3D 6;
> +}
>
> arm64 jit:
>
> +bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 ali=
gn)
> +{
> +       if (slots_used >=3D 8)
> +               return IS_ALIGNED((slots_used - 8) * sizeof(u64), align);
> +
> +       if (!IS_ALIGNED(slots_used * sizeof(u64), align))
> +               return false;
> +
> +       return slots_used + nslots <=3D 8;
> +}
>
> The above x86_64 and arm64 will reject for certain cases as in the above.

If such rejection applies to bpf2bpf calls then we cannot use this approach=
.
rust-bpf is using i128 here and there and we cannot change standard rust
crates to shift arguments to satisfy JITs.

> The alternative solution is to change llvm's. Let us say we want to have
> arm64 calling convention. We may have
>
>     slot 0: int
>     slot 1: empty
>     slot 2: first64 in int128
>     slot 3: second64 in int128
>     slot 4: int
>     slot 5: empty
>     slot 6: first64 in int128
>     slot 7: second64 int int128
>     slot 8: int
>
> in llvm and it matches to arm64
> but it has some issues in kernel as some slot is empty. (slot 1, slot 5).
> and it needs calling convention change for x86_64.

Are you saying that x86 won't have slot 1 and 5 empty?
and first i128 will be in slot 1 and 2.
So if we go with arm64 convention the x86 jit would still need to shift.
If we go with x86 convention then arm64 jit would need to introduce holes?

While current bpf convention forces both x86 and arm64 to shift slots?

I think it's better to align bpf with either x86 or arm64.
