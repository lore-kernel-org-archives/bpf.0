Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D04D2EC2
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044248; cv=none; b=k5EGXkxIoZ9QY7M29mYi0JhT7PY8UQDqqHd74htN0Khm/fkO72slLMf2+wdQ9EVHjhv2NuMFZrs09+p7IBdnhmr5bixCwBAQja5vNftmzvsy1t6+7WLXadcPl/oI+gdEjyi5EzCO/Y3IIU6TBpQNT/dul1W+VaFYDVN8ogD5g2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044248; c=relaxed/simple;
	bh=29CXx/oqMsUQvmU9fpBVc5LnUIge3ca8q+T/vXfhgKo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K01V65ddkQdI1ET2dsxLKdLqqRj0aKJtDLGGjnTJu8xfqPDGhiMA3Fpq/AsCjln0AoVjZKGNvOFY4yqKz/6KY5Bsb+ARLEPmajl4jFI1WaJjjBgjSkWDLFHfESZzssoxOGfxruiNtFZp/QfFTHXwlTYks11n44yMbKuaLK22EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew3lCXku; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew3lCXku"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso680996f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786044239; x=1786649039; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zsyXsUMG6LlhUt75jktsianYUT0kXy/TxzZnZc230bA=;
        b=Ew3lCXku94Vqv5auFyBK6kbU3u+KRlIzKwXvud2zZuIfhGIstAFr0ShX+aWr+wjl9d
         eDhG8k+wUZZvWqCMq9ozWUiumCTXzB7xma3edka71uTWKyJt/oMrMMFUDcluwDzdDWA3
         814W3UMokQ5QNWED95gXLazTmCNTiLAHqsVvkWG8TIKzaq+NLyEQsJdfH38sgRQvu6uU
         rrLgHFz1hWdGWN7shcP9HqSUWBzQ5PJSj3Hy6e0oGpiJdHB7DO9QON/s5QfS3BZuRjcs
         egFC+5zwiNP4kbrx8eCbfFW9IuDWFwNup4BDiVcu3lox9jRgo8kEqE4tupwFIFYR+FpU
         PPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786044239; x=1786649039;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zsyXsUMG6LlhUt75jktsianYUT0kXy/TxzZnZc230bA=;
        b=gy1qbipDKTXsj2gEMyW42VxmP4X46UhopaMfJYGcKM3CGyEDeRyL/Q7Dp0DXPKkDEh
         MVcuZ3tADubE3qFnhQ53Qhy1Wm9Eb1IcWeJpSFwCwxsKKhgy2z6vwBSzK8+kfE1+9eRj
         zGT8e5BkSDkRgb+4UpieamTVbDgSpaVwLY3RvpwdyHybCgqXOzFoUXcg+mIh0u5Visnt
         SfabuTbWyS+j4Cx1lB8F1ISiNKWVGJfhFx+OmLMt8oZBI4gEiAJChXdXQZt58fsyTYgt
         oz4nSYmGFNIyQft6cma1OJnLEc1CitV7ILQkm5ODVDstEX+xzN3rEnz904mcrCoa19uA
         V/nA==
X-Gm-Message-State: AOJu0YwtoA2hRtbQOKqPgd+BwdFP1ofuFw4fqecM2s9IhFzEaHoTXk1O
	65UZ6BfIopEwOlJuOIEOGRQDp2/KhFd+zAIdZXBbiouyuI0XYA+DhTwfrp1mmPUD2yM=
X-Gm-Gg: AR+sD13MSLJEOUmYmmTr7FzUp2d9ZXvfFFhmHHN1JW5ktvLgxMPKqTqDppZyicoxLgf
	L/+N4Hec5OW64nD7fJWYgfogW4HlQSXQzz7mD2SudcNQsMbhUP4GfDc7VjCpmsvC0HChiTqjo+8
	CaS3Vq8MkYIa6gPWfrwVpTcvK+Q+OI+yrkBtGEvM1Z0oel+RiNuhaWSE2ZFyKm/JtD+yDsofzwl
	jXoCaWLkO5+iGrLTkA2cbBya3mAaGrpKRvyBjcupKtpqBt7C1r9koILnuGFB7RIzZZzs7Z1c1Tc
	84fxLAssbPpKuSIRLX43dGZfxiaklJV0tOfWJlwDx6IP2Wc/yV3y/MfrIjzYI/1WLSF15res4w7
	C/Npxz+ytExOGtKEBlNYv0050FnwCmgZZYhn7cLnYxjHCFwqmW+OJ3VY25P6mT/8hflG5w/nYY/
	2qHpySKYayllF6NkcLAAEHKiplfA0H+1Im+iMhh9dX3AgO2bvC+en52mllHR4c/jywLejRq5+GC
	Ml73Ue1Be6UZ0QPhBzxMJT5XEzh4xsOb/X0z+A1GMmKBR7KMSZ0wXm5k+Huf13uqwqkVUGcnAEA
	tkW61DHtv8t24DR6shJYVwLnGhA=
X-Received: by 2002:a05:6000:2585:b0:47f:90cb:630c with SMTP id ffacd0b85a97d-47fec512a47mr24851631f8f.8.1786044238733;
        Thu, 06 Aug 2026 12:23:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b26879sm8300848f8f.30.2026.08.06.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 21:23:57 +0200
Message-Id: <DKI3UBTNC4S2.14C7ZDD8M2ZS8@gmail.com>
Cc: <bpf@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 04/13] bpf: Support __arena and
 __arena__nullable kfunc argument suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260805210427.3218326-1-memxor@gmail.com>
 <20260805210427.3218326-5-memxor@gmail.com>
 <CAMB2axOdf7jXcF2+esZqwUVXY407yu7XnkioJXnSU3b0ZsPzUg@mail.gmail.com>
 <DKI3RW4DNSJZ.3LPBJ6YJHOTHY@gmail.com>
In-Reply-To: <DKI3RW4DNSJZ.3LPBJ6YJHOTHY@gmail.com>

On Thu Aug 6, 2026 at 9:20 PM CEST, Kumar Kartikeya Dwivedi wrote:
> On Thu Aug 6, 2026 at 7:22 PM CEST, Amery Hung wrote:
>> On Wed, Aug 5, 2026 at 2:05=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@g=
mail.com> wrote:
>>>
>>> From: Tejun Heo <tj@kernel.org>
>>>
>>> Passing an arena pointer to a kfunc takes two steps today. There is no
>>> arena pointer argument type, so the pointer crosses the boundary as a
>>> bare scalar, and the kfunc then offsets it by the arena base and casts
>>> it before it can touch the memory. Every such kfunc open-codes the same
>>> translation.
>>>
>>> Add the __arena and __arena__nullable argument suffixes to make this mo=
re
>>> convenient. The kfunc declares the parameter by its real pointer type
>>> and dereferences it directly, with the JIT rebasing the value at the
>>> call site, rN =3D kern_vm_start + (u32)rN. No bounds check is needed: t=
he
>>> u32 offset stays within the guard-padded arena kernel mapping, and a
>>> fault on an unpopulated page recovers through the per-arena scratch
>>> page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
>>> matching global subprog arena arguments.
>>>
>>> __arena rebases unconditionally, so the kfunc never sees NULL and a
>>> value with zero in the low 32 bits arrives as the arena base.
>>> __arena__nullable preserves NULL for optional arguments by skipping the
>>> rebase when the truncated value, arena offset 0, is zero. Keeping the
>>> plain form NULL-free saves the NULL test on every call.
>>>
>>> The double separator makes the annotations composable:
>>> __arena__nullable also ends in __nullable. Match the composite suffix
>>> first when classifying kfunc arguments and function-model flags so it
>>> retains arena semantics while carrying the nullable flag.
>>
>> Since __arena__nullable will match is_kfunc_arg_arena() case and go
>> through JIT + regno check, and get its PTR_MAYBE_NULL anyway. How
>> about just keep it as __arena_nullable to simplify the patch?
>>
>> 1. No need to introudce is_kfunc_arg_arena_nullable() and changes in
>> is_kfunc_arg_nullable()
>
> For consistency, would you prefer that I don't manually set | PTR_MAYBE_N=
ULL and
> let is_kfunc_arg_nullable() handle that? That would be another way to add=
ress
> this.
>
> In some sense, __arena includes __nullable for the purposes of type check=
ing, so
> it might make sense to add it to the predicate that determines NULL-ness,=
 then
> it will acquire PTR_MAYBE_NULL automatically.
>
> We will still drop is_kfunc_arg_arena_nullable() though.
>
> Anyhow, I don't have any strong preference one way or the other, but thou=
ght I'd
> float this as an alternative since it appears to fit better, and details =
are
> hidden the predicates.

This will amount to adding extra OR for __arena prefix match inside
is_kfunc_arg_nullable(), since __nullable should already match on
__arena__nullable.

>
>> 2. is_kfunc_arg_arena() returns btf_param_match_suffix(btf, arg,
>> "__arena_nullable") || btf_param_match_suffix(btf, arg, "__arena");
>>
>
> Yeah, makes sense.
>
>> [...]
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index b62e77949542..2b7f6f6bbe76 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -10909,9 +10909,16 @@ static bool is_kfunc_arg_refcounted_kptr(const=
 struct btf *btf, const struct btf
>>>         return btf_param_match_suffix(btf, arg, "__refcounted_kptr");
>>>  }
>>>
>>> +static bool is_kfunc_arg_arena_nullable(const struct btf *btf,
>>> +                                       const struct btf_param *arg)
>>> +{
>>> +       return btf_param_match_suffix(btf, arg, "__arena__nullable");
>>> +}
>>> +
>>>  static bool is_kfunc_arg_nullable(const struct btf *btf, const struct =
btf_param *arg)
>>>  {
>>> -       return btf_param_match_suffix(btf, arg, "__nullable");
>>> +       return !is_kfunc_arg_arena_nullable(btf, arg) &&
>>> +              btf_param_match_suffix(btf, arg, "__nullable");
>>>  }
>>
>> No need for the changes above.
>>
>>>
>>>  static bool is_kfunc_arg_nonown_allowed(const struct btf *btf, const s=
truct btf_param *arg)
>>> @@ -10929,6 +10936,12 @@ static bool is_kfunc_arg_irq_flag(const struct=
 btf *btf, const struct btf_param
>>>         return btf_param_match_suffix(btf, arg, "__irq_flag");
>>>  }
>>>
>>> +static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf=
_param *arg)
>>> +{
>>> +       return is_kfunc_arg_arena_nullable(btf, arg) ||
>>> +              btf_param_match_suffix(btf, arg, "__arena");
>>
>> return btf_param_match_suffix(btf, arg, "__arena_nullable") ||
>>         btf_param_match_suffix(btf, arg, "__arena");
>>
>
> Ack, I'll adjust this bit.
>
>> [...]

