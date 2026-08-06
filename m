Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030A4C9557
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044051; cv=none; b=uhS+A9/tFizu+F/0SW++IdfdqbKBI4WTT0Bn9tex+w7w1pfmfMPAOV3VZsbYXga9kCq35LWPnqrJITBDK7y9mAb3jenhYSZC9FyHddk9JWbTnEbzNrLoLAwq+mZD2vIZ7ulLgliTBOMXoanzGJcbTPwx+dzn5T5xUwaxR/Em4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044051; c=relaxed/simple;
	bh=wOCHam3rtEIsL5rfIhh+WEJeyi5VmbVUcHF8KA1qjPM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=u6JHshrPmfFMNwL8PudFyUe8Z2WwEl97t3SgRnS2T7HNXKueZ1aErXzTgXbjN0bGc9iXEGrVJxaAzipvhQ8N8BC3z7iXB5Bu5URtj0xxf08U2KmCTwVGNhKBl+ioMf81WM2r5PkCEqhSg/jQV2gB9zIbgMVS8edLpwqOBs6KOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rnd4kZBX; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnd4kZBX"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso8128485e9.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786044048; x=1786648848; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XoJCEfi8XISWAQ6hwJnwYXwaLqoXrMC87be8k98S4uA=;
        b=Rnd4kZBXmD8JwFEuZMd2Ibnp5XaObbMb4w5kkJ+fMPZDrhcOZ4oB7/4C6jErFjQ4c0
         T2H741TD8k4QvZoU9lChak9B1FONXP50JXcKuTDyFZVcH9ApGMcnD8EmOuWMFTRCZI+c
         Za7Da+hiMrAgvamskgEwzANm0TfDkxYBbrV3Hf3c6lZylQI155+x0/H25Gi7TIGywXXr
         EohBnoQ6tPYifHoPTYYeLnlRLBxP1TvA+ytzWiJ9peUCTxKDkSevYU4jJ+LWRV/4o32I
         mw50L0Tm1/qd+5SvMS29NzjZYTMmVhRxNHe88FFenxyDe1tAJdwwqcwmgVbkGX8WWHyz
         M2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786044048; x=1786648848;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoJCEfi8XISWAQ6hwJnwYXwaLqoXrMC87be8k98S4uA=;
        b=MpgsahJwV914npJW0azy2YzBdRxMIrXBT/ZUiIWXDgMEvUd8G/UW4ilTxYwKoadTOw
         pMlmJvo45hqOrcw60um8iDXMumBMhXSI7tw4rz1gFw7KRBDG7zpXmlT5LYDNBTQfs3MZ
         ZbYls+Cli2uQ12IaOxNbsTycEwMEFBWSRLW5aH+g6cPc5VXLa2dWb6uEyAns1NRJW8db
         /bjFFSocLnGbrLlA1pTSjd0A6MXpkmuO17QrKT7tLhxWJamJ4ChiApVtGS4rhGANRjJP
         DkY93jn9u6BbG/NAuZ+TZjrsKb9FXcnew0HczZSS2I12OWLoLDxQWj7OOW92gQPCPgK8
         FBXw==
X-Gm-Message-State: AOJu0YzrqRUb339jRkdQpVynWdFtDvXZHzeYzNfyFAJLhd6U49v1LUAf
	M+PSZetoHMEEOrrEg+7/aHcio1gvggzD+MnLolIZqRjS4craIs6T8CUL
X-Gm-Gg: AR+sD13UZl2As6kHl1HD3CL8Q1Gk8gAGPVTCYRMXYF3zAURvzvc5feTEXEwT3k+iGhC
	3fLPKwEKP7NSrbythhZu44kNGyZkqpMH1UBeudIwIoiGuvbmWUXrWp/9nG7riOk9JKMjJZK5T1t
	qWrLYukfhaW5jyq7cssOGDn+/FMXPELjSAREUMzO4cuFzG8d34PBF7okRBvj4OABpkMlQOTGxQf
	wyw1bpiWKUSMpgZL/3bF1aIBp/o2JTy7b9BYu7DWRCvS/Z8DkBmiqEaEepU4JCeMdjnHuxibstQ
	Z/z5dhMGTwWb5bYXDFm4PeNpVcAxbl5WqWYPXltwe7LsS+a+O8HuP2eD49qkFrqYD3gBA621Pf0
	0j30YySN0y33GKPtNXta54cr2eicfIECb0RchEeGFk9NdkQo71uPO6oTyZuYSVGQGXcNlg74HXD
	iTyCWiWt80kdFtgNv9LAW6F3BElcPtcRFf5qwwGURWdY6ke0INEX91W43oFFoFcoWP17Pxcf9+6
	5J/0AX2sFKE3ESL03pu5u5qHcVauwuLnlx6Cn6BxOqLxVIqLQbsG5qDQzpeX7CUi2+YBV/oDXka
	uoRLwfRDEhcv704L9eI7oeLl2wA=
X-Received: by 2002:a05:600c:4e87:b0:495:573e:1c54 with SMTP id 5b1f17b1804b1-4994e7c1122mr205364825e9.9.1786044047831;
        Thu, 06 Aug 2026 12:20:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421b1e2sm105953285e9.8.2026.08.06.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 21:20:47 +0200
Message-Id: <DKI3RW4DNSJZ.3LPBJ6YJHOTHY@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>
Cc: <bpf@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 04/13] bpf: Support __arena and
 __arena__nullable kfunc argument suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260805210427.3218326-1-memxor@gmail.com>
 <20260805210427.3218326-5-memxor@gmail.com>
 <CAMB2axOdf7jXcF2+esZqwUVXY407yu7XnkioJXnSU3b0ZsPzUg@mail.gmail.com>
In-Reply-To: <CAMB2axOdf7jXcF2+esZqwUVXY407yu7XnkioJXnSU3b0ZsPzUg@mail.gmail.com>

On Thu Aug 6, 2026 at 7:22 PM CEST, Amery Hung wrote:
> On Wed, Aug 5, 2026 at 2:05=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
>>
>> From: Tejun Heo <tj@kernel.org>
>>
>> Passing an arena pointer to a kfunc takes two steps today. There is no
>> arena pointer argument type, so the pointer crosses the boundary as a
>> bare scalar, and the kfunc then offsets it by the arena base and casts
>> it before it can touch the memory. Every such kfunc open-codes the same
>> translation.
>>
>> Add the __arena and __arena__nullable argument suffixes to make this mor=
e
>> convenient. The kfunc declares the parameter by its real pointer type
>> and dereferences it directly, with the JIT rebasing the value at the
>> call site, rN =3D kern_vm_start + (u32)rN. No bounds check is needed: th=
e
>> u32 offset stays within the guard-padded arena kernel mapping, and a
>> fault on an unpopulated page recovers through the per-arena scratch
>> page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
>> matching global subprog arena arguments.
>>
>> __arena rebases unconditionally, so the kfunc never sees NULL and a
>> value with zero in the low 32 bits arrives as the arena base.
>> __arena__nullable preserves NULL for optional arguments by skipping the
>> rebase when the truncated value, arena offset 0, is zero. Keeping the
>> plain form NULL-free saves the NULL test on every call.
>>
>> The double separator makes the annotations composable:
>> __arena__nullable also ends in __nullable. Match the composite suffix
>> first when classifying kfunc arguments and function-model flags so it
>> retains arena semantics while carrying the nullable flag.
>
> Since __arena__nullable will match is_kfunc_arg_arena() case and go
> through JIT + regno check, and get its PTR_MAYBE_NULL anyway. How
> about just keep it as __arena_nullable to simplify the patch?
>
> 1. No need to introudce is_kfunc_arg_arena_nullable() and changes in
> is_kfunc_arg_nullable()

For consistency, would you prefer that I don't manually set | PTR_MAYBE_NUL=
L and
let is_kfunc_arg_nullable() handle that? That would be another way to addre=
ss
this.

In some sense, __arena includes __nullable for the purposes of type checkin=
g, so
it might make sense to add it to the predicate that determines NULL-ness, t=
hen
it will acquire PTR_MAYBE_NULL automatically.

We will still drop is_kfunc_arg_arena_nullable() though.

Anyhow, I don't have any strong preference one way or the other, but though=
t I'd
float this as an alternative since it appears to fit better, and details ar=
e
hidden the predicates.

> 2. is_kfunc_arg_arena() returns btf_param_match_suffix(btf, arg,
> "__arena_nullable") || btf_param_match_suffix(btf, arg, "__arena");
>

Yeah, makes sense.

> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b62e77949542..2b7f6f6bbe76 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10909,9 +10909,16 @@ static bool is_kfunc_arg_refcounted_kptr(const =
struct btf *btf, const struct btf
>>         return btf_param_match_suffix(btf, arg, "__refcounted_kptr");
>>  }
>>
>> +static bool is_kfunc_arg_arena_nullable(const struct btf *btf,
>> +                                       const struct btf_param *arg)
>> +{
>> +       return btf_param_match_suffix(btf, arg, "__arena__nullable");
>> +}
>> +
>>  static bool is_kfunc_arg_nullable(const struct btf *btf, const struct b=
tf_param *arg)
>>  {
>> -       return btf_param_match_suffix(btf, arg, "__nullable");
>> +       return !is_kfunc_arg_arena_nullable(btf, arg) &&
>> +              btf_param_match_suffix(btf, arg, "__nullable");
>>  }
>
> No need for the changes above.
>
>>
>>  static bool is_kfunc_arg_nonown_allowed(const struct btf *btf, const st=
ruct btf_param *arg)
>> @@ -10929,6 +10936,12 @@ static bool is_kfunc_arg_irq_flag(const struct =
btf *btf, const struct btf_param
>>         return btf_param_match_suffix(btf, arg, "__irq_flag");
>>  }
>>
>> +static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_=
param *arg)
>> +{
>> +       return is_kfunc_arg_arena_nullable(btf, arg) ||
>> +              btf_param_match_suffix(btf, arg, "__arena");
>
> return btf_param_match_suffix(btf, arg, "__arena_nullable") ||
>         btf_param_match_suffix(btf, arg, "__arena");
>

Ack, I'll adjust this bit.

> [...]

