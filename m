Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E843F0A2
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879408; cv=none; b=XYL38Ibi/5qh6zNWYhcXnp8I4Lrx426cfwqvQwGO9H/Chric70HGLVih2hE/kNS1lMaSdtaFhLa4ereB9CTa3lGpkp6KoZFZvUMCQCowklMGn8CLlfD0nv6GkM7aPw2N1B4Gdvc+88iyoG1cj+v0jMnpT/JUMcx9jOn3ChXJUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879408; c=relaxed/simple;
	bh=goN5mnwgm79/Legex9n76FIwGsT8mjt3YP2xFmZLuJg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LR4jCyH/p/QuF5sqABbhH63u28IXEnHYQT9SknhNNfYMCwKzlyQ4VQp8SY2rMSR0Kmt0Lk0sxOJssuI2iqwB3HjOxzbE2ZdFIc7Kp6//cyAcI/UfNg2JVmKCgS9wV1j9VUcve7gCsWQkC0B59/V/4ssyh6J30dEeTlX6WoNG8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGnBJXA1; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGnBJXA1"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso93260f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879405; x=1786484205; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p/d0sQ3hEgdZ1u5eZbpLzlkfI6h6wTcNliywbj+CM5o=;
        b=GGnBJXA1ZJpxCiEqynd0zAQ4X3N4gGM59mlVYdKqPjUt0wc6bwCCw3L4rYcaazijI+
         0PQulDr4kkrUubZTAE1ojf6+/SOiCjG9K1XaTjm1mAEz0gK2v09J2S9bLPYwfBf/FlQW
         FCtS39WqmUBZeS1Cc80udjq+TtDfNHa4migi7nUDfXZtePJh0jbbcySLS2KIlfSw/4GO
         3yU1S76YTpwzKJWtjPOueOjKNf/XyQAs1uIXrwtni1mx/tHTwZ67tV4Oi4OcMcjwIcCN
         wOvfHwQooUCnZp+QNYQnLI3v9UpTATfPpTIn4AxWpDIbrbtDeQujICS21O/xVQE/ike9
         wsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879405; x=1786484205;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/d0sQ3hEgdZ1u5eZbpLzlkfI6h6wTcNliywbj+CM5o=;
        b=JiW1h/OUIt43DISPSEXgKH8BKpUFYxG545NF1pYz5o77ri22CCA50Ap4lwkZUN4kb0
         H/r8ywiE6hYMATG2dpAK/CaaxjJBxaN55NYIoCOPRgEdk+7KsTAoGWLoOw5bhOEw0E0L
         d5tbBn+J2SDOE3VrEUpLKteKEB3POQ16jM4JnE7ZBM0LERvvaD0JhLlHVIRWJ6s59gOR
         OL+hZvr1cqFw8x0YrDNbQP25/rRgZRo7mazvAGIz6WwGMbFzPHBPWA9CZmZBuzBagSMf
         fadld7w4QVssKduErvZXeU8euIMxlquXZHM6tuRTvrShXf24Kyvlze6QZo6DmmNaCC2T
         9YFg==
X-Gm-Message-State: AOJu0YxEDZ7V81EDS3aBeHiFKQ3/4EkRZFWVSds9szfamiNuTsVpnTbe
	Qka6E50yL/rYV2ean9pAsgblT+D/MzR1hFQIWeuTJc/wCDfMDdKNa/T+
X-Gm-Gg: AR+sD10LfLSew6Em4+glEDx5BfuKVmdZKXK2uymWS6qbWq9PxTUAsytRqxpys+rspoe
	RFulbXWNgG2gHuN/emhL2Wwf5DYlLJ2JbvPH7QPOMjk0Yiq2CoSj8LRZEkpHqYzfXxs/2ArTOBT
	7VkG6qnX+hLMBTQMQHA6lmwKMeo517mRpf4VsquDWjl8arN5S4H7FJptvA+M6W8r+dxk4f/+eVV
	WSS/NWJI4P2WP567Hf3Aiamdz4y/1ZkARpVDUoMBuyKgspoGWVlXUtZMQpteV1MpM9myM9l+RzY
	SvllQ2esBlRgovN67Mp2hH87iLeZajL5gFb4nqih0VR6adtA46eGqOUrq2G9gnJ32Wd+S0SEFvB
	2aiL6EORMc2WeFixe2iPuUPNcXXKcK815NyyMUMvwe+1n7dtECVRxdoNaOe37PfBgMzJ/NEUMMj
	3GGMK4HBMDlmcc6jCLmbZSQ+jeL3qurP3HNVHutZU3JtZ0aJAKbksCZGKbjVxSbFd328DVZ8a2/
	2qClCh3J8o6ci9MRUpAkYgch6k6xyP/B+6q64R3Bfo946ZVUqzCD1tBYEOLJF9wQiEllx+8GCo9
	noZbtTvpMxVg2Y8jIcZR/BQxny4=
X-Received: by 2002:a05:6000:46c4:b0:47f:d011:f644 with SMTP id ffacd0b85a97d-47fec4e73c0mr2790115f8f.4.1785879404648;
        Tue, 04 Aug 2026 14:36:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfda58fsm3550465f8f.7.2026.08.04.14.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 23:36:43 +0200
Message-Id: <DKGHEW1R8697.1KI5JMFLC1Q1L@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>
Subject: Re: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from
 suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Alan Maguire" <alan.maguire@oracle.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803125518.2279340-1-memxor@gmail.com>
 <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
 <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
 <8dc173dc3d051d338916c72cae070238718fd196.camel@gmail.com>
 <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>
In-Reply-To: <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>

On Tue Aug 4, 2026 at 11:19 PM CEST, Ihor Solodrai wrote:
> On 8/4/26 1:22 PM, Eduard Zingerman wrote:
>> On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
>>> On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
>>>> On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
>>>>> [...]
>>>
>>>>
>>>> So while I understand the reluctance to add KF_ARENA_ARG3..N, I don't
>>>> think we want to introduce and support yet another mechanism for arena
>>>> argument annotations. If we do, we'll be stuck with a mess of
>>>> supporting two/three ways of doing the same thing for the foreseeable =
future.
>>>
>>> I think one major difference is that KF_ARENA_ARG* things were mostly f=
or
>>> annotating the vmlinux.h with the right address space label before, but=
 didn't
>>> carry any semantic meaning for the kfunc's type checks.
>>>
>>> That changes with these suffixes though. The pointer will be translated=
 when
>>> passed into the kfunc. IMO it would be odd to diverge for this particul=
ar case,
>>> since we use suffixes for every other case where we constrain the input=
 type of
>>> the kfunc argument or give it special meaning.
>>>
>>> We also want to have similar annotation on struct_ops callbacks, where =
we also
>>> use suffixes, so it seemed better to keep it consistent.
>>
>> I agree that we should follow the principle of least surprise here and
>> use suffixes, as everything else uses suffixes as well.
>
> Ok, I understand the motivation. Let's say we use the suffixes.
>
> Should this enable getting rid of KF_ARENA* flags then? For the
> purposes of generating address_space(1), we can also just check the
> name suffix, no?
>
>>
>> And yes, the __arena and KF_ARENA_ARG* annotations have different
>> semantics:
>> - __arena means that user space arena address is passed as is
>> - KF_ARENA_ARG* means that a user space address is converted
>>   to a kernel space address before passing.
>
> Also I am a little confused about whether we *need* to be able to
> express two distinct meanings of "arena pointer" or not?
>
> My understanding is that "arena pointer" is a feature of an arg type
> that has a single meaning: the pointer has one base in BPF world, and
> a different base when executed in the kernel.
>
> The things that are missing is auto-conversion (Tejun's RFC [1]) and more
> comprehensive support of PTR_TO_ARENA in the verifier.
>
> This is still only one "arena" annotation per arg. Do we actually need
> the proliferation of __arena, __arena__nullable and/or __arena_kern,
> __arena_user? Can't we have a single defined semantics of how arena
> pointers are supposed to work?
>

I agree that we should simply have one __arena tag. It has a well defined
meaning for the program already, so shouldn't be confusing when seen on inp=
ut
argument in struct_ops callback, or when passed into a kfunc as an output.

From the kernel's PoV, as Ihor said, it will rebased to the kernel base.
I wouldn't unnecessarily burden the consumers of this stuff to worry about
which side it should be translated to, that can be unambiguously derived fr=
om
the context in which it is used.

Having the ability to specify __nullable also makes sense. If for nothing e=
lse,
we already do that for every other pointer argument in a kfunc, otherwise a=
ssume
the argument is non-NULL unless the kfunc definition specifically opts into=
 a
non-NULL argument. As a side benefit, it leads to more optimized JIT sequen=
ce.

In Tejun's branch, this came up already: only one of the callback or kfunc
really needed the __nullable annotation, the other was supposed to accept a
proper argument without the need to represent optionality.

I think we should have had such behavior for global functions too, but when=
 they
were first implemented we hardcoded OR_NULL into the received type for a me=
mory
pointer, and thus live with explicit __nonnull annotation now, to avoid bre=
aking
compat if we change default behavior.

> I can imagine something like follows:
>   * arena pointers can not be null, check for nulls
>     before passing from BPF prog to the kernel
>   * arena pointers are converted to the kernel space for
>     kfunc/struct_ops callback by the verifier
>
> With the documented and enforced semantics like this one way of
> annotating and one annotation should be enough.
>
> What am I missing?
>
> [1] https://lore.kernel.org/bpf/20260713024414.3759854-1-tj@kernel.org/
>
>>
>> It appears, though, that from the BPF program side having an address
>> space annotation on the kfunc parameter would be helpful, as it avoids
>> an additional cast.
>> > Tbh, it sounds like we want __arena_user and __arena_kern suffixes.
>>
>>> I agree that all of these should be using type tags, but we're not ther=
e yet.
>>
>> Let's put aside the type tags discussion for the time being.
>>
>> ...

