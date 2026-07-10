Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309FF24E4C6
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705213; cv=none; b=Bj26m+AtTJ6qXeGAmjnDIUm2xf/kNUZD1PSv5PT2q6iHu541nhp8sGomM+wEEh9JrsyccJtgC4NR5VZvWyTc4ObNwZWwlRhI2DRCJLg2TY6zpJBqH1kclBpsR5QvuuwDt46CXR+xyXYMjBH4vQ1SxDyosXEdHzUHfuH1XRbfzxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705213; c=relaxed/simple;
	bh=XPEclRDiV6omwaNGtbkvqNxg8v1YbFaAyQAFObbhTHM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=i0C+NapfzGqQl5PqwFTV1J8VIISa+xq/A0daZNWIScQyurWYc12NRPcz1RN/quQHP5C6Ul57VvgTLR+rEdAc2I1DzSG+9VkBf+b6m9va5RvySiXd6wl3ov5N9Bea+X2O5rHSUvs93gFxfSv7lv/hrXYIiq/a3qOVSS3Q4BeKX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxJph1NN; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxJph1NN"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-493e93e58b9so530515e9.1
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783705210; x=1784310010; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/5RW30ZGJk1qNi/VtLris2HIPVm+vUZFh/AIp9+9TfI=;
        b=bxJph1NNd3D5qWRgmpt9tT68qiA4ip3coStQQ9FOvCUcONIRe/w1SBWbu/oXIHnF7n
         vc3qeH86C2y/mn4WZaBb+DkKefZPz+Ulw6zftJrMWKyB/iukpErmDCzgNahqRXr8pzRI
         kSfNC4T8baqjP9NsT9zWk5aMsCg1EeNBVa3KCC56dPzbY7VxhWPpa9NeOu3e0UqOxC0i
         QXOxpb+Dpan33Y09NHW6Z5tYl7KtBL3EUlJWW2ynRu2n9tCcIvpoOnhGiFwEc1cEO8h2
         QxZAWmMg68i57KhRU1cAfiRzQhPzvcbujlu6zSx++/56/WOW74UNs6ktaVnpcO/ZCJP1
         xUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783705210; x=1784310010;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5RW30ZGJk1qNi/VtLris2HIPVm+vUZFh/AIp9+9TfI=;
        b=NzV7HddECpMckx6IuJ7me993zoXB1lVktIg/cfKJnfE+HVPqcivZdBISZDVQAfxZn8
         C5dLgOUpNilCY7RD2YfEvEtw84fG6Y7lHEJVzNv6+8Ikbs0nACaY0deSzrsj7gx76aqM
         x0vGfYnt7P+I7sBkxM8Tossb0o+WKWhwB1L0P4flN25nJGjMQ1tKMyDkDVf36AMPuSId
         2BLGjTfUhvLTgp2VeoSxRoD+ZdoG1Stlq5lpZKc7c9qea7uX+S6EnX1FNK3BBYq7xr8Q
         8xvtnbp1RsqIdlm4yItNztaqa9D/GKvfSbAH6xvb7PWVY0oxNG2nP13x0t4yvP9or4EQ
         4Z1w==
X-Gm-Message-State: AOJu0YzDPgb9SFnJsGX3v2m5pnbO58byveIrpVKJu/IJp6JD612Kb+EO
	ZFILpYTRouKcv9W1X0n7u0SXCKaeYxKwd7Z9mP2dc0cY3/z3y2gP0zzBRu4DcvAe
X-Gm-Gg: AfdE7cna1qDmIVflP8zi4TtP7NUDQDri0RFCiIBH5k/uNEA4E/ugbfFT2TWGr8WhonY
	gC23KP09JXqwQSzcp1y35CtFRdaco1kKEz4BD/2o7YCNofREd07XaOlarE8ShQQNJJ8lD9ERmGn
	81uz0ZVWFNZunMLkCJsJhzDCttgdxg7G8NoRGlIFyipqNz2ZxSLv8l3YaFH87Hrwcwn+ezLXnao
	gA97dc1SU3Ai1VFxPMuAFwKkRcn3OFl7yLEiQK8sDo2WSwABSppf72QGhPOgONF/89VceRkXATx
	kr50NmgsAURppavkWpZ/DFcDAnwVwbsyJqYjtPYBd3FDKMKKT5u1QxuzLDKCfrppKj+ghMgM0oJ
	YIQFUZKX7AUrBU16u2Ea0Uc3AyiUve8PKScwE+anYz7MHzhKe9LRBGtl5F4CVCKigaoWHhIO26y
	5A6K/WDldzBrpUkXARlvAS8p+moFGANvYhi62Kaafz4hzRlfty7jlfkxtFzoL7YkuVwhtg+59EG
	GyMuBTolwBUzFYl06b3trCT+Wl1OJOrIHFu4VBNyP2dvnMoXDe2AlyZi5UpoX+S4g==
X-Received: by 2002:a05:600c:4ec8:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-493f2b445dbmr41872275e9.16.1783705210491;
        Fri, 10 Jul 2026 10:40:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d5055sm153090725e9.5.2026.07.10.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 19:40:09 +0200
Message-Id: <DJV2Q54OF8BU.1H6KXCS93P3N6@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implicit
 args
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260710005902.2234832-1-ihor.solodrai@linux.dev>
 <20260710012112.577F31F000E9@smtp.kernel.org>
 <ce047740-79fe-4fc5-a118-40252b169be8@linux.dev>
 <DJV2D826YVRY.WSTQ4Z6CFX1I@gmail.com>
 <7a5bb678-4fab-44c8-98b5-272124e08847@linux.dev>
In-Reply-To: <7a5bb678-4fab-44c8-98b5-272124e08847@linux.dev>

On Fri Jul 10, 2026 at 7:34 PM CEST, Ihor Solodrai wrote:
> On 7/10/26 10:23 AM, Kumar Kartikeya Dwivedi wrote:
>> On Fri Jul 10, 2026 at 7:08 PM CEST, Ihor Solodrai wrote:
>>> On 7/9/26 6:21 PM, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential i=
ssue(s) to consider:
>>>> - [High] Accessing `btf->kfunc_set_tab` without holding a module refer=
ence causes a use-after-free vulnerability.
>>>> --
>>>>
>>>> --- Patch [1]: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with impl=
icit args ---
>>>> commit 13df91bf669b3a55c459c1663fbf726f9f52bc5c
>>>> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
>>>>
>>>> bpf: Fix tracing of kfuncs with implicit args
>>>>
>>>> A kfunc marked with KF_IMPLICIT_ARGS flag takes implicit arguments
>>>> (such as bpf_prog_aux) that the verifier injects at load time.
>>>> resolve_btfids strips those from the kfunc's BTF-visible prototype and
>>>> keeps the real kernel ABI in a counterpart _impl prototype.
>>>>
>>>> Link: https://github.com/sched-ext/scx/issues/3687#issuecomment-490669=
4106
>>>>
>>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>>> index 64572f85edc83..20aeca6b4f95c 100644
>>>>> --- a/kernel/bpf/btf.c
>>>>> +++ b/kernel/bpf/btf.c
>>>> [ ... ]
>>>>> @@ -9114,6 +9114,26 @@ u32 *btf_kfunc_flags(const struct btf *btf, u3=
2 kfunc_btf_id, const struct bpf_p
>>>>>  	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * Return the union of a kfunc's flags across all hooks.
>>>>> + * Unlike btf_kfunc_flags(), not restricted to a calling
>>>>> + * program's hook. Used when attaching to a kfunc for tracing.
>>>>> + */
>>>>> +u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf=
_id)
>>>>> +{
>>>>> +	enum btf_kfunc_hook hook;
>>>>> +	u32 *hook_flags;
>>>>> +	u32 flags =3D 0;
>>>>> +
>>>>> +	for (hook =3D 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
>>>>> +		hook_flags =3D btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>>>>> +		if (hook_flags)
>>>>> +			flags |=3D *hook_flags;
>>>>> +	}
>>>>> +
>>>>> +	return flags;
>>>>> +}
>>>>> +
>>>>>  u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf=
_id,
>>>>>  				const struct bpf_prog *prog)
>>>>>  {
>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>> index 6515d4d3c0032..fde11a2f6869a 100644
>>>>> --- a/kernel/bpf/verifier.c
>>>>> +++ b/kernel/bpf/verifier.c
>>>> [ ... ]
>>>>> @@ -19121,8 +19146,8 @@ int bpf_check_attach_target(struct bpf_verifi=
er_log *log,
>>>>>  		if (prog_extension &&
>>>>>  		    btf_check_type_match(log, prog, btf, t))
>>>>>  			return -EINVAL;
>>>>> -		t =3D btf_type_by_id(btf, t->type);
>>>>> -		if (!btf_type_is_func_proto(t))
>>>>> +		t =3D btf_attach_func_proto(log, btf, btf_id);
>>>>> +		if (!t || !btf_type_is_func_proto(t))
>>>>>  			return -EINVAL;
>>>>
>>
>> Also, why not do it for BPF_TRACE_ITER case as well? I just feel keeping=
 it
>> consistent may outweigh figuring out whether it's necessary in that case=
 or not,
>> etc.
>
>
> I mentioned this in the patch description:
>
>   The BPF_TRACE_ITER case distills a registered iterator's
>   prototype, and bpf_struct_ops_desc_init() distills the
>   function-pointer members of a struct_ops type. Neither is
>   a kfunc, and so can't have implicit arguments.
>

Yeah, I saw that, but abstracting that inside the function and not having t=
o
think from the caller about those details would be better. That said, I don=
't
have any strong preference, it is obviously correct as it is.

>
>>
>> Please supply a cover letter in the next version too since you're sendin=
g
>> multiple patches.
>
> I used the first patch's message as a cover letter, since it's
> just a fix + selftest pair.
>
> The series could be split further into refactoring changes, but I thought
> it'll be easier to backport if the fix is in a single self-contained patc=
h.
>
> I think we want the fix to get into 7.2, and backport it to 7.1.
>
> If it's ok to carry separate refactoring patches there, then I'll split.
> Kartikeya, wdyt?
>

You can still keep the patches as is, but just add a cover letter, it will =
not
affect backporting. The cover letter is just to summarize the series and th=
e fix
in the merge commit. Also, my understanding is that with the Fixes: tag, it
should automatically be picked up for stable kernels.
