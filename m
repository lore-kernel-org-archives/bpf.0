Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625023EA88
	for <bpf@vger.kernel.org>; Sun, 25 Jan 2026 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769373425; cv=none; b=CfKPj8CSnM07lKx5xQUcZi64ja1Oq1m5QvWew45pnSy101I5SJYKzitvwVQTIJrifI8CN3gD0+ho80jMrfyb1a54Uw+qmr2shwnj3y4TO+OZKz2XfsxM/gCb7pt6Z2IFtd/iXnij8T5MA4T4uR6fF+rfuvyLSIJkBlmn5JSd8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769373425; c=relaxed/simple;
	bh=KaPXS/Z/c7D152Q/n61SaHtWw2eblop+3/kEWHmsHuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AN0cdCorgMyH4OVll4iaROFvMf2XBpjZ65AyKk+H6kJWRc8afhGN1qfvKx/ehJMkXe81jWpeagGXLCncxSl0A3fpGmmZLPs0/uS6c2FU7AgB9Qr1M0CbBs9B2oEuRHYtPBy25xXnXMJZP6L/Ep06zJsXJyfnlWVQ4BuWXqP2YxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qw1IPWmY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qw1IPWmY"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so6559142a12.3
        for <bpf@vger.kernel.org>; Sun, 25 Jan 2026 12:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769373422; x=1769978222; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6PV7Aw1GuCHemjI6CRSwhEaXuqwDH59s8evm2BBYZE=;
        b=Qw1IPWmYFB0+6h6ZiIm1fa/iOlZvllRVg2MaAEL9LvX9K/MFR9g6U0XdPt+ryrh9bl
         lKztIaNpPX4LJ5oDo95onJVbHxbhvaD9uqJjwdE35dax7Ntlfo8OgeACgBEUI07EBUcu
         d3OzZzEX+mflDNDEBFdJmUZvemHRFn4STY36xFBwteF/8sQ8/AtKA2avzowRW+2NKCzs
         qpqjCpdmdGYKWNlEO0zhUrQRaIApPpKG6ZeA9ePa2CvkbYdFdL+UOOlDyWxE3uVIGqJW
         QQXEUS4vfO+OLX0e0VXuP45Je25lMkrcy5qZ6LBCCHTk/93h6/HImBfz35aXNw/qyORU
         OcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769373422; x=1769978222;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6PV7Aw1GuCHemjI6CRSwhEaXuqwDH59s8evm2BBYZE=;
        b=oGVfqxu0JUqML/OZdMX9B+rtaFf5zVhP/8MmXO3dxIMobYJCbHoc33gaTmvuPXaa1r
         pNypW+Cwsdj6wT7ZXcTDdVPuUhEl/G1nKfw1burnv39vS0R2/04zDRkDlL1JlMYuy+ZO
         /eZSkLpH3+TnAZbReqTuY6mOsk7Hx+BHiBvOBKz/Ac7h3mFpUkOK+WRULpgoj3yVnMot
         lyQjuJJonGIfGCaczcE3pBkw1zLaQFCvtBdjb0GQnc/7FJfqQU+r5fa6IzzHJEg3WI4v
         g68u5X9c7hK1B5JC/9r1wnE6cb3Q6+GlHBkfgsyTD7LVPRRZJJZ71BujZcVvLH5glUS/
         Nq3w==
X-Forwarded-Encrypted: i=1; AJvYcCUp1gP8J9or/kU/Xwc5k0BQoO3ENSK9jADV0HyL6F4Cn8uIIjHKjTGk5+spxuJ4Rb3qkcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuyfNwSiJh8Au63kpeadiqFObkP4+RFLg1y1FPnKQH3c3mZOlU
	sfC/6q4NwFy8XuKnHN6csmE3d9uzkSpwd/0Ga9xeG9/Cy7rMA2nphDGSj3xO4wzLRwI=
X-Gm-Gg: AZuq6aKAv0srv7YvfTBpO7dTrsFJpLIHTK8IHrXDj6gbEICiU3HwjC8tl+sfGd4Gvvq
	gXjNQMnZpL1ebh0fEf6xpYRTJghsrvktHLQd5tZZyWbcWI3aWHGXxQF9O+KYRGIpLdZhrOCd0p/
	d9SJV3jlEtj0lCDiIDn5HJE0FZCDQH8DzAsmoQXzjlVq02+Sen53E9PZMKTzWYqtu44RWmuaB4c
	V91Fi59+Vh/342UauxPt2NTiNHJTClBwgmvlHHG/FEEm4ayRpdrpqFi1MR/zH88pCC4Z4upUfzI
	yhiqZEdytjG+t01Tf3dbmVs3kRlhyyv6uq6RJUZTQuyTd9PNCmxXkxLRNtpaIhrSIGS1unyZLV8
	mVia17D5N6CFNqC2uJ11YjfG/fRt7yquYYZnQY0odL99hXS3jpooRcWveTNHcSb2Z0kai9UBXbN
	A3j8U=
X-Received: by 2002:a17:907:9710:b0:b87:206a:a241 with SMTP id a640c23a62f3a-b8cfedfc951mr173619466b.11.1769373421994;
        Sun, 25 Jan 2026 12:37:01 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6fc4d7sm507309066b.45.2026.01.25.12.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 12:37:01 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Amery Hung <ameryhung@gmail.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,
  ihor.solodrai@linux.dev,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] bpf, verifier: Support direct helper
 calls from prologue/epilogue
In-Reply-To: <bbbf1b30-dfc9-4206-9285-0ce96e934e54@linux.dev> (Martin KaFai
	Lau's message of "Fri, 23 Jan 2026 15:49:34 -0800")
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
	<20260123-skb-meta-bpf-emit-call-from-prologue-v2-1-0e50db4d4663@cloudflare.com>
	<bbbf1b30-dfc9-4206-9285-0ce96e934e54@linux.dev>
Date: Sun, 25 Jan 2026 21:37:00 +0100
Message-ID: <874io9tonn.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 23, 2026 at 03:49 PM -08, Martin KaFai Lau wrote:
> On 1/23/26 9:05 AM, Jakub Sitnicki wrote:
>> @@ -23909,6 +23928,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>   			goto next_insn;
>>   		}
>>   patch_call_imm:
>> +		if (env->insn_aux_data[i + delta].finalized_call)
>> +			goto next_insn;
>> +
>>   		fn = env->ops->get_func_proto(insn->imm, env->prog);
>>   		/* all functions that have prototype and verifier allowed
>>   		 * programs to call them, must be real in-kernel functions
>> @@ -23920,6 +23942,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>   			return -EFAULT;
>>   		}
>>   		insn->imm = fn->func - __bpf_call_base;
>> +		env->insn_aux_data[i + delta].finalized_call = true;
>>   next_insn:
>>   		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
>>   			subprogs[cur_subprog].stack_depth += stack_depth_extra;
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index d14401193b01..cb39388f69a9 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
>>   	/* ret = bpf_skb_pull_data(skb, 0); */
>>   	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>>   	*insn++ = BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
>> -	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
>> -			       BPF_FUNC_skb_pull_data);
>> +	*insn++ = BPF_EMIT_CALL(bpf_skb_pull_data);
>
> Ihor reported that the test_map has started failing on arm64.
>
> https://github.com/kernel-patches/bpf/actions/runs/21298510237/job/61311053284
> https://github.com/kernel-patches/bpf/actions/runs/21298505282/job/61312363930
> https://github.com/kernel-patches/bpf/actions/runs/21301695907/job/61321375157
>
> For BPF_PROG_TYPE_SK_SKB, the BPF_FUNC_skb_pull_data has a different
> func_proto. It is sk_skb_pull_data instead of bpf_skb_pull_data.
> A different func needs to be emitted here based on prog type.
> Not sure why it only fails on arm64.
>
> The set has been reverted to get the CI going.
> Please address the issue, add a test for this case, and
> then respin. Thanks.

Sorry for this oversight.

I see now that sk_skb_pull_data doesn't bpf_compute_data_pointers which
writes over skb->cb. Perhaps that has something to do with the failure.

Will get this sorted.

Expect some delay. This is a pre-conferece week (FOSDEM).
