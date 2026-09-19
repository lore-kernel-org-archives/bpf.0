Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925B2BFC60
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781174; cv=none; b=sMOqLnDhYrmksGiwwRrmXtzvl5UA8qMAhlZohr/e67ID+F9AONFo/Wfxx1knBlbCONdDBaCz6GNqVYiirR8URpbpf6RwNFTeS5RP3ruvNRAUjW9yZQvdCqlvyN0zRlF8XOqZ5RvvPX845vlIVsKLX+RwRiodf1CHOjIMjLt8AOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781174; c=relaxed/simple;
	bh=pw0xVBSJMGSqUzehos+pMIH+RXRHeVNDafs64hQjF6I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=qDM5y+nhB9Jmul0bPnym05gBTllosC9xRvIVMPP52cVBdgWyjo25A4CjKjwECD3y4wvcExiCPsggthKGuuy04GvUB6vi/6oExs2nX3ICY8R0jygGwHh87LUgUyeQT6Pk/7E2dFYxWY4Dp54fKfSdvTwbB9G3uJy0F7/lUyjG3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TThpeshh; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TThpeshh"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so343430f8f.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789781171; x=1790385971; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AzYIXAlKfxIW6Tyqomxe2Cchgk0IVoHHDbzwuQj/rqg=;
        b=TThpeshhnCRNfbtLcTuHyUUTJckgVCI3Egjs17IpdMj4upDGqYTQ2Czf2OwWQZJAsw
         /rJeMfnCqjY8JwVPlPrUfOBZzO9/FTBWm3YFXAemwwwbumvoRPR5ogEJIUPa4Aajkhw6
         fPhe0ouUpK2X4Wd116g7sQSHR/PrH31KB4AQB2Iq2S51RLDk4997DERz3iL5RSaQ3182
         Y2KYQwY+1P71hU1Hnim4rZUjcFzsDSgjuSHsu5+fA/DmiWv92o/RXxwnOvOH1rM0rZ3X
         Qqe2YGbIokeS/Kl1d3r3HxPq0mcpIM6tGQQRsVtO1rRY8pXwFSzRVIyDjyygGqa/QhGc
         5GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789781171; x=1790385971;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzYIXAlKfxIW6Tyqomxe2Cchgk0IVoHHDbzwuQj/rqg=;
        b=kbwcS9DII/lYpYbVfKU6Fhq/U8dlfVrtNVmxNYbv763RZNPisixD4MmMoVVLbkyxal
         qJQ260qZ1aw0JXYNnzr2UVMxK9YBMEqqmlyLAGCPwvBb5g1+qpNkqTJX7ou/UJB+NLCQ
         8vkpsvTbw82LL+IspIs5YGyTCQvdBOuDQhG6H4NjYOcs07CnkrG+d4WDkQN3JHUsz4da
         SiQp0/ogZu1t7+joV+m/pOOuwUZEFV5Byo2aGGrsFx5MYPwW7ZKKFW/mGYKm8yBRNW0V
         zhJwtJ9/8wiuEn3UEU4U7EARdD9AkICudNfmSDKB5YhFH5LiytutlhsSBJtPOnrDMqEs
         r5qQ==
X-Gm-Message-State: AFuF++nW9w0PfI/tjkLHFFJXjsG7f/GyxH3YMj6HmAiMTNRi8B+e1s8e
	kUFV23xACc/VCedrJOnMEQ7n5Le5QkwL5jLGQ4bBQNvDhQaNLE2SXFA2Gip+c/MO
X-Gm-Gg: AYBFou0XH3QnDRfHUShTUUK1FILg3JKwEMqmH/FoNn3LGBEKM5Get1J3EajIpesEl8B
	Fr17kcrIdWBEk/EbGxPN/YY6zjtW+SFVI2ith/oEIoFckts3dRjlYnFr5crVS7jI1ymLghLJYlT
	g+EhTjpwLxfkI7IsWHN82EZnuvm0Gn/RW4SJQ8XkxmNwLf/1ez01copWmez5t/X1nqUBA87yODW
	RUswTjy7qwbpfyrb7MkXAWvjLoD2iFvFfSG/gJsObEw15qEEoUYN7viYR3xJkelNQMlHHI3xiNA
	iUrhaxqQY5qXHLJxQN79UQ6hNcoGIM9Q3bIrXhAIcUJ8u7fgM46v8lFFuaGFbis7iQYv7zQPZr7
	4usSQ1FNpxjIjVrP5+H43uAHpi4CfTY/GaonU8UYwzZpdl4/g8HD0H91VVVbp+wx3zkShAFDGYu
	bH7GJoM8FJ7PJ1XggLsoTrNxoBxb57KUP5VWtdpviv5DkW5BZvScP+ZT24WNeI2sH5Yj4Xa6KgC
	HwvfiB9Ion0L2XjHCmaECHLhX/FYQ9j0YcqKLzBH9Nz9OjX5LE7U7AfXbK4M1dSV/y8KJw10KlD
	9SMV5wavMoa5m6f+8agNfhxvIhDj51068oG/afWeAIMpEkZ5
X-Received: by 2002:a05:6000:2304:b0:484:3200:b7a1 with SMTP id ffacd0b85a97d-4871e25d894mr10867826f8f.13.1789781170725;
        Fri, 18 Sep 2026 18:26:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487245a869asm2825832f8f.37.2026.09.18.18.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 18:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 03:26:10 +0200
Message-Id: <DLIWH2PDV8ZI.3NEWOCLKS37IM@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v3 1/2] bpf: Compare stack frames in regs_exact()
X-Mailer: aerc 0.21.0
References: <20260919004327.1403382-1-memxor@gmail.com>
 <20260919004327.1403382-2-memxor@gmail.com>
 <20260919010829.EE9211F00898@smtp.kernel.org>
In-Reply-To: <20260919010829.EE9211F00898@smtp.kernel.org>

On Sat Sep 19, 2026 at 3:08 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: Out-of-bounds array read in bpf_func() due to frameno alias=
ing
> --
>
> commit e17b850ba98b74f1dac193b96d8c0646c06a22d0
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Compare stack frames in regs_exact()
>
> This commit moves frameno into the type-specific metadata union, ahead of
> id, to compare stack frames in regs_exact(). It also moves the
> states_maybe_looping() boundary from frameno to precise.
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index a7202b44ab105..17be5f7df35af 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -45,6 +45,14 @@ struct bpf_reg_state {
>>  	union {
>>  		/* valid when type =3D=3D PTR_TO_PACKET */
>>  		int range;
>> +		/*
>> +		 * Inside the callee two registers can be both PTR_TO_STACK like
>> +		 * R1=3Dfp-8 and R2=3Dfp-8, but one of them points to this function s=
tack
>> +		 * while another to the caller's stack. To differentiate them 'framen=
o'
>> +		 * is used which is an index in bpf_verifier_state->frame[] array
>> +		 * pointing to bpf_func_state.
>> +		 */
>> +		u8 frameno;
>
> [Severity: High]
> Does moving frameno into this union cause an out-of-bounds array read in
> bpf_func()?
>
> For non-stack registers (like PTR_TO_MAP_VALUE), frameno will now contain
> arbitrary aliased bytes (such as the lowest byte of a map address).
>
> In kernel/bpf/verifier.c, functions like get_constant_map_key() and
> process_iter_arg() call bpf_func() unconditionally before verifying the
> register is a stack pointer:
>
> kernel/bpf/verifier.c:get_constant_map_key() {
>     ...
> 	struct bpf_func_state *state =3D bpf_func(env, key);
>     ...
> 	if (key->type !=3D PTR_TO_STACK)
> 		return -EOPNOTSUPP;
>     ...
> }
>
> bpf_func() evaluates env->cur_state->frame[reg->frameno]:
>
> include/linux/bpf_verifier.h:bpf_func() {
> 	struct bpf_verifier_state *cur =3D env->cur_state;
>
> 	return cur->frame[reg->frameno];
> }
>
> If a BPF program passes a non-stack register as an argument, and frameno
> evaluates to a large value (e.g. 255) due to aliasing, it indexes far
> outside the frame array, causing an out-of-bounds read and potential KASA=
N
> panics during program verification.

This seems correct, will fix.
