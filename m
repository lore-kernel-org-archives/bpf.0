Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B02C57D20C
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195267; cv=none; b=fyABIIHIXzMSv+n/QaLUk1FzGw85XsIu0H12gQDLScoGYuV76a5rQEuwEpDHhQ7Lf+00b/r/DTRo3qHw/aKWpLDWKPoqhfZ5ZfgSK38zbdpjwXKAuivYNuOeDKGejc3gb853j0jmuVzD8bzmNs+voOUCA2MYgnwM8IaqA5IUzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195267; c=relaxed/simple;
	bh=bLtswKVHHlOIi/UbUOws9e680UKnYjlumM8Dt4Y5mSE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V7pHqLUoxWKKo90IT+I7xcAcMrF3DVZOROTKyytKRXTqqAoGHU02kpBZRORSRDhNiaoMRaBzqMWmPTzdduWkv2cMYDTxL7/7tz2oVr7SAdfhth/UPA22aCBEccz4EOHkfOrGomUef6V4sFJM+YrDNC5Fc7OHjKTqP/UN15MxQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMKQlsik; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMKQlsik"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so608684f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 13:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790195254; x=1790800054; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k/n1Had+EC5tOrszLQQlAmAdpo/bFMcHZLULgIthBrU=;
        b=mMKQlsikuqLjteZh/ApWo8sf9jdUVEgkWkicZLvUBTxzfbosr51E/ZBjD22zgcX73u
         diSf4cYZgHrzQEXowOdbFYI93UY8aaztrPYn2szLJAmzfHerYhSKxozofPBqCLsqrqxX
         ezFynX+K8yXssvgYvKYMJXn5hWg4Jt/+BC+C3d0ix3yZwDkg8U8GGAzrug76hcZes+qk
         BAJZiROOTIjbvS653cBpLfVbTLMuf8dj2O/JXqFiHicDoqAB3yIz8dNjHYUW7Lu9kIgF
         E7S/zFshZpImXoH//Covyx2A6z+GmYfuL3k2bcjB3P751IOwCpyzAdJ8tgNSRk41cCne
         BuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195254; x=1790800054;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/n1Had+EC5tOrszLQQlAmAdpo/bFMcHZLULgIthBrU=;
        b=mePAgg2lAEd0f9Wru36geZ8f3uHKju2MlytHmp19eM13uqmDGr4+z9VyC5DEmp2S8N
         hcT4f/cs94RZhHWEtrXHIIDopqyd+s2FRdwFsdg6pyvOOGFOVrbqf4150Mvatb2Ko8NN
         fxKmbPhwN+mBCRJ88qYVdAmMvVX8EGUpoCpKjj/Lo0l/hGDUUZSeW0wZjZ98duuIwpIi
         xy4u6YBzhz7wdbtI0DCYmAT1KKRIDfF7snkGgM8HxS/zJAxcEdhGoDLxwe5HsljFIKZf
         +JmKkB5rMRfYC4mXYOJQZ6DFKnzcsz8GTlDmFbmHacPPhE10gYZB5moI8HHN9rCD7Ihh
         b2XA==
X-Forwarded-Encrypted: i=1; AKwUvBxyncxGaP0bDkQI4omkQFeu7NdDvlW/HdIC2lWvaZil61cIfD2uUJ3SfH7v9FBSpXdlwiE=@vger.kernel.org
X-Gm-Message-State: AFuF++n/Oe9O7alyGfc3fBDiO7K6hRHfb3mK/axNfXdEEzEEsuomjQV8
	AZJhrqa9Az6Gp6f102YF+bmWms+MkNyB5z8y6LPgRYAr3Xpiy8qA2ehl
X-Gm-Gg: AYBFou1/DpcbwbRacpZWA5Uy0f4esvkXU922WJROJkEhpFkI3AsYREPJ5R+2EQUmP2o
	Bw94aippJrLvDgdYq2nNVDeNUMG+JL+OcmIMOOxSfvqEJPp5u9soNFnUW7pXGhBUZ3zR0Z/sCiS
	WwrmPl/aF6wj5YUBZwWRBrXoNHdGGMaaA8W1S4x7E6h+I0ex2yNZNjeQnyzi1pmDQuhXTfLFRXU
	Lp29DlXpPBIE0oryrJRjsMNWGYJixKwt/OicpR2VvVFO5N+Ii4UNZyhKOLLAq4ytt7H3Gl0Oqwg
	P7kPnsPoAz3+3zBD1eF43Kg7lcHeTTsajq0iHBLu/EL+6QNcWPzAMEKKeasuYyYled8AHAYdKoZ
	9QjWQsguth2nnwfku+MmxJuTLE0z4tXrDNMLUWXp4EoeLG0LrIJ3G9X1oN1A1dgSkOiSzJ27ewi
	M6TftQrqhe4CnSOlrEDXsCQyoNBBUHS9xsnnf6n1rfWx12P7FEMavHDVlyOfKBkFp3Yd/yOgpSn
	sxcPVqBtsqYFH5qKhescHLxJrT+pHqKR+ExMUqNNHEXfuP8G8JDdcrYKnJHYi9fKmlszIQMQ22l
	RTd3ax02klaSrDzZB5JtP/sBInQp1JqJiNid1Q==
X-Received: by 2002:a5d:5d12:0:b0:487:d8f:27a0 with SMTP id ffacd0b85a97d-488716ecaefmr469007f8f.32.1790195253801;
        Wed, 23 Sep 2026 13:27:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488688893a0sm9560272f8f.32.2026.09.23.13.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 13:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:27:32 +0200
Message-Id: <DLMZ95N3740O.2NQLSZVH8NEQI@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 12/18] bpf: Size the per-frame verifier
 structures for a 2 KiB stack
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260923191139.2816206-13-memxor@gmail.com>
 <a1d67ea63858c1e4125d88f346df080360f4a9dd7b17e53163ccbfdb0dddd2c3@mail.kernel.org>
In-Reply-To: <a1d67ea63858c1e4125d88f346df080360f4a9dd7b17e53163ccbfdb0dddd2c3@mail.kernel.org>

On Wed Sep 23, 2026 at 10:12 PM CEST, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index d8cafd3d74aa..11fa9f1f087c 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -19,11 +19,12 @@
>>   * that converting umax_value to int cannot overflow.
>>   */
>>  #define BPF_MAX_VAR_SIZ	(1 << 29)
>> -/* size of tmp_str_buf in bpf_verifier.
>> - * we need at least 306 bytes to fit full stack mask representation
>> - * (in the "-8,-16,...,-512" form)
>> +/*
>> + * size of tmp_str_buf in bpf_verifier.
>> + * we need at least 1399 bytes to fit full stack mask representation
>> + * (in the "-8,-16,...,-2048" form)
>>   */
>> -#define TMP_STR_BUF_LEN 320
>> +#define TMP_STR_BUF_LEN 1408
>
> TMP_STR_BUF_LEN is raised to 1408 so that bpf_fmt_stack_mask() can render
> all 256 slots. The commit message says the buffer grows "so that all 256
> slots still fit". But every place that consumes env->tmp_str_buf prints i=
t
> through verbose() -> bpf_verifier_vlog(), which formats into a fixed kbuf=
:
>
> kernel/bpf/log.c:bpf_verifier_vlog() {
>     n =3D vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
> }
>
> BPF_VERIFIER_TMP_LOG_SIZE is still 1024 (include/linux/bpf_verifier.h).
> The precision backtracking log lines are:
>

I will bump the size.

> kernel/bpf/backtrack.c: {
>     verbose(env, "stack=3D%s before ", env->tmp_str_buf);
>     verbose(env, "stack=3D%s: ", env->tmp_str_buf);
> }
>
> With a full 256-slot mask, the "stack=3D%s before " line is 1412 bytes an=
d is
> silently cut at 1023 characters. The remaining slots and the trailing
> " before " / ": " separator are lost, so the next log fragment runs into
> the truncated mask.
>
> The mask alone goes over the kbuf limit once roughly 168 or more slots ar=
e
> set. The larger tmp_str_buf therefore does not deliver the complete log
> line the comment and commit message promise. The extra 1 KiB only helps u=
p
> to the 1023-character kbuf limit.
>
> This commit only resizes the structures; the verifier still caps the stac=
k
> at 512 bytes here. The problem becomes reachable later in the same series=
,
> in d1a4a32c6444 ("bpf, x86: Allow programs 2 KiB of stack") and
> 5782325bd60a ("bpf, arm64: Allow programs 2 KiB of stack"), which let
> bpf_jit_supports_large_stack() programs use more than 64 slots. No later
> commit in 00a8442f56e5..7757cddf610a changes BPF_VERIFIER_TMP_LOG_SIZE or
> the print sites.
>
> The impact is limited to log readability (no memory-safety or
> verification-result impact), but selftests or tools that parse the stack=
=3D
> mask from level-2 logs will see incomplete data.
>
> Should BPF_VERIFIER_TMP_LOG_SIZE be raised to at least TMP_STR_BUF_LEN
> plus a small prefix, or should the mask be emitted in pieces with several
> verbose() calls?
>
>>  /* Patch buffer size */
>>  #define INSN_BUF_SIZE 32
>>
>> @@ -243,12 +244,13 @@ enum bpf_stack_slot_type {
>>  #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
>>
>>  /*
>> - * Largest number of BPF_REG_SIZE stack slots a single frame can have. =
A frame
>> - * may use any part of the MAX_BPF_STACK budget; check_max_stack_depth(=
)
>> - * enforces the bound on the combined depth of frames sharing the kerne=
l stack
>> - * and on each frame using a private stack.
>> + * Largest number of BPF_REG_SIZE stack slots a single frame can have, =
sized
>> + * for the largest stack budget any JIT supports. A frame may use any p=
art of
>> + * its program's budget; check_max_stack_depth() enforces the budget on=
 the
>> + * combined depth of frames sharing the kernel stack and on each frame =
using
>> + * a private stack.
>>   */
>> -#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK / BPF_REG_SIZE)
>> +#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK_JIT / BPF_REG_SIZE)
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359098=
53278

