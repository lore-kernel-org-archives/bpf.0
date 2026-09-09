Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD82D0C75
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919171; cv=none; b=ps0R1w8pPEvP1SkPySBlS+CNhfks0XKErw0FFDv0a3SlFfcIZJdV3iJtHwMFNAUSdKYKUvp9TgKiNNrVfVb1zfq3EonK6JZqtF2TQf4N8F0cZvByZjr6xpY9DWTPPH5ErbXF0RsOEoxayNO9LZgR1iwmIl3tUTNG0GAxDMh9q1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919171; c=relaxed/simple;
	bh=mbKOFK+20Rod41d7o2a8dp5a+eIjWryUesTEuQXKmic=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HnoW6OFFYrCOQ21W9dfDxJIlV8DQ6IlUVyy8+Kk7V2r3z80FNnPTiaQ+XDU/zvBlHRVemNM5+aCXhTGdawdK7/mufMR1e7WbXyRJCQ0C5rfGPtJRvaObXhHSo9GeiCPNqg+FcIEN5whmvXxOoM9uIJt4F5go7DZrTP/nJAI1d24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c18PFP7d; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c18PFP7d"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f5934ba2a5so2575127a34.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 18:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788919169; x=1789523969; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y/YmpvAEHFJrfjWt9yOkVl+p0rIg2pVQv96N++FoxWA=;
        b=c18PFP7denTCEGBz8RbB5Vt6LXAFd9Afp8QC3vpd+JgJffqTnYBODaJla+L5qM8ZBO
         biAwdw/WN4TYZdg342qOduWVutBymseRXTIdBaSUr7ff2M82PzAF6fnINDgMm1z+qJPB
         iUHT8uxtPCKYAeZYBRnhJsZcugpc2ElkauBITqsD6ryBBMYGkzEIrKUF0soCTrF5C0nm
         r3SzD1kaDAukMw13zdTLqPAC/0GcdXGJ6bT4lA6igyulWebgxci5a2WMVLXhGw71AIWJ
         z9/MZIzJfGf0vVdUT6vcTw2b70Zg2HEcwmS8vmbk3dY2+mqPItV2YcYPbV1bGWpW7ikU
         bjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788919169; x=1789523969;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y/YmpvAEHFJrfjWt9yOkVl+p0rIg2pVQv96N++FoxWA=;
        b=FYoAr+YDxvNbZalRZCRWeTGFW2O0BJJxN3kCAcFK/MhAZsFOUHAhwUgV/Qj1oUSkkS
         XeoNHsk1E3gO7wAdWzVc6N4NZELzkctRkfMpEnAIlMM1D8Asz0a3vArwqg/4Ag4LfZzt
         jOHqg4OdbeYuaShLkZ+S8+3OunTLoOnLNNa4uzPDRXRs3koCPn6RWjfly6tHBVkvmRYJ
         jHnzN1FY1CvshQuggDpJk1oC3zemHvpKH8jgtcpsXXfoztIW5mOe92ea6bIxJEh65EgX
         m8SppeazjrggztN2P3d/6YUkQpKRWVgP5T80g1JB+UmXKkSLxVERhtz2OKGYASDKlbp7
         JZ8A==
X-Gm-Message-State: AFuF++l75wIzbJNp7rkl/9afPA5CLBEwT0MmAfjR3SpBrDwKwY2+CiJe
	+nf5ChgEv3ipFuVVjZyUyrnhJEDX6Tq4H/AuLfNf26Q8P6Yof1ypEUFv
X-Gm-Gg: AYBFou18JKBFprv3SiyE4sI9+UB/mMhumIRoF7Q3YrBKr7Nh2mXnZPOjmLKk7CDd94i
	ANfGQpmTY3SOWpUu+6sTLLmqgjp3hX8Ii9nTcNYbjDmr58u79Ke84h+W8XzVrI4USVDaPmeG/2n
	P59mCyA9ggFkFJK4vOVBCnmdK8GCmSNykf+dQ7plh+kIejvtQwjZK9oTwd1gzZJX6J5dTBmbSra
	PnDwCFPDirVbNfk0MS9T9H+G46VFSVcWmIyNHc+OkbTXve6HyodJi4OG//QuYF4Ms0kHVJMFq0D
	Vl2Yd6gaovLvAlPvMIxPPtdYOo6vvGWJ9riynWeW4WRkTyyluSKrD+2WnC3jNH5/hkji6cfRhH8
	+oTQwCA9j0NqfatXaz9psNIeTaBKOp9uKtcBZC0I3hPqku9GUXe7j+xoKWcLMwggPeDNMlSM1kd
	/LhtSRBO+799r1hnxAwT3oksXJocUOqtVdA/0UkTDiS9al+EudwZppv9vp5V/8K+JlAL4LTDYY3
	d777CcCBv1ETKM9MhEYjRPxJUYRk7c7BYlU+d+efe3ZAY7iMpmFIhaiG2hRAnacHw==
X-Received: by 2002:a05:6820:c8f:b0:6b1:d09d:6d73 with SMTP id 006d021491bc7-6b6fb7d5b82mr20129678eaf.8.1788919169267;
        Tue, 08 Sep 2026 18:59:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6daa20bsm16954157a34.14.2026.09.08.18.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 18:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 18:59:26 -0700
Message-Id: <DLAEX3NMK5GW.C82FXVYWQTMB@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kernel
 Team" <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 07/12] bpf, x86: Place kfunc arguments per the
 SysV calling convention
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>
X-Mailer: aerc
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051033.3979978-1-yonghong.song@linux.dev>
 <DL6XUEHAJN3Z.20UKZKTLHI2XZ@gmail.com>
 <f034ac4a-2829-4932-b3f8-b13cee4688a6@linux.dev>
 <CAADnVQ+bKmypdfAPXdk9jDN3QedX9EO9YXHFudLu71AR02Z3CQ@mail.gmail.com>
 <7be30b65-0a22-47b6-8635-e0054c6cba24@linux.dev>
 <CAADnVQ+gGYA+gvEOwvqWCSg4jd4CUsxL2ZWUJCtFAhiq2o2Tbg@mail.gmail.com>
 <1eef259d-e0d2-4b73-99eb-c7fb736a7846@linux.dev>
In-Reply-To: <1eef259d-e0d2-4b73-99eb-c7fb736a7846@linux.dev>

On Tue Sep 8, 2026 at 11:43 AM PDT, Yonghong Song wrote:
>
>
> On 9/8/26 8:24 AM, Alexei Starovoitov wrote:
>> On Mon, Sep 7, 2026 at 10:02=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
>>>
>>> The following is what I was suggested:
>>>
>>> llvm: no change,
>>>
>>> x86_64 jit:
>>>
>>> +bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 a=
lign)
>>> +{
>>> +       if (slots_used >=3D 6)
>>> +               return IS_ALIGNED((slots_used - 6) * sizeof(u64), align=
);
>>> +
>>> +       return slots_used + nslots <=3D 6;
>>> +}
>>>
>>> arm64 jit:
>>>
>>> +bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 a=
lign)
>>> +{
>>> +       if (slots_used >=3D 8)
>>> +               return IS_ALIGNED((slots_used - 8) * sizeof(u64), align=
);
>>> +
>>> +       if (!IS_ALIGNED(slots_used * sizeof(u64), align))
>>> +               return false;
>>> +
>>> +       return slots_used + nslots <=3D 8;
>>> +}
>>>
>>> The above x86_64 and arm64 will reject for certain cases as in the abov=
e.
>> If such rejection applies to bpf2bpf calls then we cannot use this appro=
ach.
>> rust-bpf is using i128 here and there and we cannot change standard rust
>> crates to shift arguments to satisfy JITs.
>
> The above bpf_jit_supports_kfunc_arg_slot() is for jit, so this is not
> related to bpf2bpf calls. bpf2bpf calls work fine.
>
>>
>>> The alternative solution is to change llvm's. Let us say we want to hav=
e
>>> arm64 calling convention. We may have
>>>
>>>      slot 0: int
>>>      slot 1: empty
>>>      slot 2: first64 in int128
>>>      slot 3: second64 in int128
>>>      slot 4: int
>>>      slot 5: empty
>>>      slot 6: first64 in int128
>>>      slot 7: second64 int int128
>>>      slot 8: int
>>>
>>> in llvm and it matches to arm64
>>> but it has some issues in kernel as some slot is empty. (slot 1, slot 5=
).
>>> and it needs calling convention change for x86_64.
>> Are you saying that x86 won't have slot 1 and 5 empty?
>> and first i128 will be in slot 1 and 2.
>
> Yes. For x86, it looks like
>      slot 0: int
>      slot 1: first64 in int128
>      slot 2: second64 in int128
>      slot 3: int
>      slot 4: first64 in int128
>      slot 5: second64 int int128
>      slot 6: int
>
>> So if we go with arm64 convention the x86 jit would still need to shift.
>
> Yes.
>
>> If we go with x86 convention then arm64 jit would need to introduce hole=
s?
>
> Yes.
>
>>
>> While current bpf convention forces both x86 and arm64 to shift slots?
>
> The current bpf convention assigned arguments in order without any gaps.
> So yes, it will force both x86 and arm64 to shift slots.
>
>>
>> I think it's better to align bpf with either x86 or arm64.
>
> I did some investigation. Looks like pretty hard.
> If we want to align bpf with x86 calling convention, we will need
> 6 register arguments, alignment requirement for stack (__int128)
> and register backfilling as the *common* calling convention.
> This will make arm64 harder.

I see. Because of 6th reg on x86 the JIT would still need to do the work.
Ok. let's keep bpf calling convention as-is then.

> I think we can do a better job by having common struct for the above info=
:
>     nr_arg_regs          // 6 for x86_64 and 8 for arm64
>     even_reg_align       // true for arm64
>     backfill_after_stack // true for x86_64
>     pad_stack_to_align   // true for both arm64 and x86_64
>     others if needed
>
> With such information, we can calculate position in verifier.c.
> So we have minimum change in JIT.

That makes sense to me.

