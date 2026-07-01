Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D412367F3C
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931654; cv=none; b=nwZqg5H+gjZ3QkQYpRINApLiH8ed8xU59/EcUwKkpH2e3bjWXClQ9AC7z1el6hVCQ6IdsZN9k4T6a1RNyX50j5uVr8TQVd/dn5Xm2Cr9J/ZIzsXXPI5++Ng+7veWNIs8EdxWbft3xEmJ677916fcS9t1IrguEXZoRssBRo+ChUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931654; c=relaxed/simple;
	bh=UMZ/oHufdmLrRebJhJdd4z9UveNzoktn4s6GK0qVg9Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W+2rRFAWraLl/IbU4tEpkA6UeECOf5qjFEfYPtcqkl/28ID5yKPxbFUGZAd41q7L+YfW2xs1VsO7Fo4ySaOBA05YhJ6giiBW41/EdzZjOmckaD5z7zubKCCvyYvyl+dXY++2puNVpJ9rjhHB/NckGAVSEWiv1cgV4MLUvCZXg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQgLZEaz; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQgLZEaz"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9483cd614so816253a34.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782931652; x=1783536452; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTi92KcO4t4fC4vzqRv/t15HFT0DQF/tdlE/UMVxiuQ=;
        b=DQgLZEazr0mccZDrCefhzMX27C6s+NaL/n4WJoSQI9JspxndrjwG5PgNvqCkFMTLUd
         WSGbXgL/OcPpHCBcUgeUD9Slv1EJdvypcFE09QKvxEQIV4f/WVvJY3p8LEItwlyab7IK
         U0U0u/wd3Iw5Byl4FqTPHtqDu80cUkcoVnm4U+8O0w7FrriUJuyuoPG6YcLWGOaOHBTO
         5mFEmaGHMkN9twoEh4Q6/NPz75EKSAuPJ0WpN090KIrK4oyJrEH2OYiEsFxGDvUkjnqh
         SPNn7O7IQ8VzMK43KAF7VwGsblY+vCO5DE1cKuvtKVwYooqIgpuTBt8sq9mCSgSyo2ib
         LVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931652; x=1783536452;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTi92KcO4t4fC4vzqRv/t15HFT0DQF/tdlE/UMVxiuQ=;
        b=iRzidUqwT4dpnceWcGFbCf3d2wW5RlheUblekS72Qba5RVHwAxC+a/F55ZuugUrYII
         ASGEc9Rx6qaZmszaQtanpPF9/+Q71Xw+dXVNAuM4iFw+cHm/veySG5TW9Pi5ellyLY5t
         MrXMt01kiUEMX2TU58Qmdloy/CQXPTbTusv9tNRcKLQZd9UVVKU9E4afQZtGiEwLJwub
         YIBi9hng2Dy/f74XZVBpfUAZbSCiawpAYN+/2zu2OnLEooI/bEZL/uzDcZ7C6Qgjwj5O
         tFPJ0oSGyOaWI+0alHH8NCFm1QTPkLdZUpHpN8Se4z5c44OblnTd8UrQ+JeTAvn/54W/
         docw==
X-Forwarded-Encrypted: i=1; AFNElJ8VwX+Xl6OtXWVLQlbo2A0Do1k+yv+gNl4cpVtJP2rbmb4kbG2AyH7qK1QvDZgs4riJ5hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuC5UfLtZQ+V6NW7xYwDRpcPs86VRnMEgm+oUMobMjuefp1aLf
	eJuse/gQiahbNnzrdPoeJU2ImgY2NPlo4J2RGflaYyPLUv0klUpdCAXo
X-Gm-Gg: AfdE7cnLF7Z2/J5GpB9dbFiYFVGFknUnidofK7q2aKykyk5I/UWs1nAPbpVQpGEUr4O
	thMfSL1vyzPOLDeCXxdgXTyulbM8Ll8QecpORNAZQvkcHxZ5aCRn+JCOPj4fQtaBPS61B01eorS
	7Wu05qLhWFFI2+NSNkWD7PHLgAwd9iLcpStVkRrcBGTUnzf0pqul+o39Apn0xaeYvirNgCwsx2/
	4Q0ClddmDgbUEJ/pnkVfVRQwROarvljMzZpV2uzyVylkKeUmRqFDm35pNEPIJRprSpHZlZWD36+
	IL1SnX/GRXVL1QFW2MK3CsqUXbOuKd1iXtBwcsCVz7wSRFg8WhfNaaU1DMHko4nvworAo9thoII
	xh6iRGl1CXZ4QdejCiGBWcTP/TSimyWAp0aw5GHUSE7PVJ9ZOL0JE5J3SIc48Z7PmHGsnN5Wy3Q
	5Lxl31LeNGZsu29+SuDnd6ZtAfBYUJ3zbSOSFhBfKey82was7S/4HRlfwWC733H4MJtJfZzMzKn
	5zLlg==
X-Received: by 2002:a05:6830:1d63:b0:7e9:e9f3:266c with SMTP id 46e09a7af769-7e9f5f28f4cmr3112378a34.14.1782931652500;
        Wed, 01 Jul 2026 11:47:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb544a109fsm696811a34.14.2026.07.01.11.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 11:47:30 -0700
Message-Id: <DJNGIT00SJG4.3LBZ5DHQDHLHU@gmail.com>
Cc: "Leon Hwang" <leon.hwang@linux.dev>, "KaFai Wan" <kafai.wan@linux.dev>,
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Shuah Khan" <shuah@kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH bpf 1/6] bpf: Disallow interpreter fallback for user
 BPF_ADDR_SPACE_CAST insn
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Leon Huang Fu"
 <leon.huangfu@shopee.com>
X-Mailer: aerc
References: <20260626154330.33619-1-leon.hwang@linux.dev>
 <20260626154330.33619-2-leon.hwang@linux.dev>
 <e279c9a7ca6b16e52dc261560513b0eafdd70f87.camel@linux.dev>
 <a2aaa21d-4cf9-48a4-839f-dd152bda8185@linux.dev>
 <af9c0a7e-13de-c227-849f-4b35d1fb74ff@loongson.cn>
 <d55e10b1-d883-4fcf-8fb3-8210db935e4a@linux.dev>
 <1c07a34f-b050-a281-6a7b-542a9bfa30b3@loongson.cn>
 <bfb432db-bd29-419a-8147-78ff6fac07ad@linux.dev>
 <7438f087-7fb4-4991-a095-1d24d6d09895@loongson.cn>
 <20260701080524.194326-1-leon.huangfu@shopee.com>
 <d369317a-e695-7b56-2efd-f53ec76c6688@loongson.cn>
In-Reply-To: <d369317a-e695-7b56-2efd-f53ec76c6688@loongson.cn>

On Wed Jul 1, 2026 at 2:07 AM PDT, Tiezhu Yang wrote:
> On 2026/7/1 =E4=B8=8B=E5=8D=884:04, Leon Huang Fu wrote:
>> On Wed, 1 Jul 2026 15:29:28 +0800, Tiezhu Yang <yangtiezhu@loongson.cn> =
wrote:
>>> On 2026/7/1 =C3=A4=C2=B8=E2=80=B9=C3=A5=C2=8D=CB=863:02, Leon Hwang wro=
te:
>>>> On 1/7/26 14:49, Tiezhu Yang wrote:
>>>> [...]
>>>>>>
>>>>>> It is a real issue.
>>>>>>
>>>>>> Instead of fixing up helper calls, it seems better to prevent
>>>>>> interpreter fallback if the prog has any JIT-inlineable helper call.
>>>>>
>>>>> Hi Alexei and Leon,
>>>>>
>>>>> What about the following: (not tested yet, if it is good, I can test =
it)
>>>>>
>>>>> [...]
>>>>>
>>>>> If you are OK with the above changes, I will test it again and send
>>>>> a new version later.
>>>>>
>>>>
>>>> If you don't mind, I think I can disallow the interpreter fallback by
>>>> the below diff in the next revision of this series.
>>>>
>>>> The 'aux->jit_required' is introduced by following Alexei's suggestion=
.
>>>
>>> I am not sure if introducing a new aux->jit_required member is necessar=
y,
>>> as we already have a local jit_needed flag in the current logic.
>>=20
>> A 'must_jit'-like member was suggested by Alexei [1].
>>=20
>> Probably, the commits in [2] could help to understand 'aux->jit_required=
'.
>>=20
>> [1] https://lore.kernel.org/bpf/DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com/
>> [2] https://github.com/Asphaltt/bpf/commits/bpf/fix-interpreter-fallback=
/v2/
>>=20
>>>
>>> Additionally, the issue reported in my patch [1] is fundamentally tied
>>> to bpf_jit_inlines_helper_call(). Maybe we can simply reuse jit_needed
>>> by checking bpf_prog_has_inline_helpers() right before JITing, and then
>>> reject fallback with -ENOTSUPP if JIT compilation fails.
>>=20
>> Correct. Reusing jit_needed is preferred.
>
> I agree.
>
> To avoid bloating struct bpf_prog_aux and to keep the refactoring
> minimal, I suggest that you submit a patch to introduce a centralized
> bpf_prog_requires_jit() helper in kernel/bpf/core.c.
>
> This will cleanly bundle bpf_prog_has_kfunc_call() and other JIT-only
> instructions (like user cast, arena, etc.) together, like this:
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..4e96272f7377 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2608,6 +2608,24 @@ static struct bpf_prog=20
> *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>          return prog;
>   }
>
> +static bool bpf_prog_requires_jit(const struct bpf_prog *fp)
> +{
> +       struct bpf_insn *insn =3D fp->insnsi;
> +       int i;
> +
> +       if (bpf_prog_has_kfunc_call(fp))
> +               return true;
> +
> +       for (i =3D 0; i < fp->len; i++, insn++) {
> +               if (insn_is_cast_user(insn) ||
> +                   insn_is_arena_load_store(insn) ||
> +                   insn_is_indirect_jump(insn))
> +                       return true;
> +       }
> +
> +       return false;
> +}

No. I already explained that this forking of the logic is not ok.

> +
>   struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env=20
> *env, struct bpf_prog *fp,
>                                             int *err)
>   {
> @@ -2620,7 +2638,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct=
=20
> bpf_verifier_env *env, struct
>                  goto finalize;
>
>          if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -           bpf_prog_has_kfunc_call(fp))
> +           bpf_prog_requires_jit(fp))

This has to be fp->jit_required and
the verifier has to set it when necessary.
