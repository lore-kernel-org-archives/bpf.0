Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C931A07F
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257094; cv=none; b=db6NI5puZN4pJf71UnWHDCT7Ns0L6HiZbRB60ndH1YjiiNlDtuYNUJBWhehbAqQ3Q4iGWw2QIB2mNtvWRrl83gjnP1ruV+OjJ6QtFo40Lkv3Q/1hk+Cgor8guiLVIJiqtJSHpJ/trbGT8CeS9BMdsjNJVE0lkshBhaUwfanSz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257094; c=relaxed/simple;
	bh=YO5F6xseRGMb/viupNnNgVMA9K53gz6EhnNZjtbn0lQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MzWL9xBDa2L6Dl5zexQy583vqZN7oCCKWuqqXWtXpP3ZRcz+lV+q8S3qx1bSlTbxLjtaXjTwpCbSrQZB+4+MNqRBtwqj3MOAXCDKPEWKn0RbY4KEiSkz1XUdFNsPLJbLxlo0C/IJyeVM6BPG3pds/ynRgFtY2oaz8tU829s2TxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=AnDHW3Yr; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="AnDHW3Yr"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c9f6b78ca4so26055985a.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773257092; x=1773861892; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNMNg6N3Vd5xctzLVKNk2t9/hKxkYr12RfGTtz13QKA=;
        b=AnDHW3YrwCq5+BzPXxXYiPA0/8n5/Ky6wH71kgz2lgNeBYyDPYhJnW8jFiBKfXduXk
         s37a7GYhFRX0Gd5Fr29wUal4P8XwBl8S2KhYwwTzt5/Z3m/DPDxHB3nEW74gVpZiRUz0
         LW72Kut5GHBhJ8LLGtN/r6EbVsVZgKh34BQ1WEnK+/LBa+UU74AoGW1WhlqP/w2y1AMX
         O/mC+E6yE1iu6tM8A09sR1DmS5SIWZrKhnDzGr5YztQC2/XXOJx6qtyHsLbI86glXmDv
         PlCe+mWyGSNoDZEXjh8X2GA+TfyoJ/2ECTc3CfIhPH8lwB9GxY098u7sD9HHWMUkd/N8
         ayqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773257092; x=1773861892;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNMNg6N3Vd5xctzLVKNk2t9/hKxkYr12RfGTtz13QKA=;
        b=Dsibu8ahoBbApM/2MvEaNNwJB/K4FBQxMV+YQ0qvYH13xnFl8JizqQ1F9GFx6FgEa0
         2xmAhus9Tu51uqwI6xZIyawVz3ytXSoRwOHmR8XaTPtCGx3kRm13asA+RM0ZVRLVtbVf
         i+U3f/wkT9RKGSDvt3y1D3rCtez7RD8cv6c4KGQGfEVdEv6kz1RXHDuNYxNnMMggAldD
         15lUFW/2NFYOq9hLjC2uqLHJSo32zU05xcv48s09b1Q3Yov67dxSdmYIFzJepc73oon9
         IM4o1ravuzOjf7aGlSkdsILxRTMZH+lbg9Megal/Ib8ljKa8oTRhcKq5jSnB1lbZij9D
         yiUg==
X-Forwarded-Encrypted: i=1; AJvYcCWJmanK1D8Jkyt9WESXffCsyU5a292ttJ26PuPiKlOMK9C1GBP5HS3cY3wwEYc3CEW1okY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZ+dmVGOVJcAbDTvjNt6DWk0OhVsteEzXyAo/r03gS7yqGeAq
	YuRu38yUl/Lexe45ecHchmKnY9DLSPNQQUj/MbxMQXawr8hFywGw3LEkiYv3DrzCd3+1kbW9cjT
	GP/Hf
X-Gm-Gg: ATEYQzwOjZUYQdW411ZJ8WyZHrC42GWC5REi4yRoRxLO7lpBQjU6LfI2OJ9pg6fA4f+
	f28dGfoXPt24+kq7hOSEYqHuRL27QrQfPItKFTFgxoqfxg1L1MMscrBaV34FkADEZTuHUrvguDM
	EhQ8T+CRdDSs3v0L/6pOrfbwJnfo5IH0PBHM2N4Y1ENTAqDxkD6ps8e/n3/SXM8pV9Kr93ZFVT4
	G8oaKPzNwJiYhLnGASJkVyhiiHhpH8G9ldBC0iPpOqDqFGj5hUvmzO25XhaOyZK34vAzLEASLik
	9Dr25ID/cF/KbbofNzmUmrUyBK3XzEWU4SELBF6j1Tp3GZrR1AAZJ1Rgmrwue8pqD3fDobAk2E5
	oY995P2CTL+3z9+xluTny1mLZVy9qtITkhgXDuV+5rBE2FMjDQd/o8b2cvtS2+OYP8va3wsAHvN
	v4Z8l5fUO57xm10hQ95SbHWLs=
X-Received: by 2002:a05:620a:1929:b0:8cd:8d50:16a1 with SMTP id af79cd13be357-8cda1a9b6d7mr482471185a.55.1773257092036;
        Wed, 11 Mar 2026 12:24:52 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda216b7fasm189964785a.47.2026.03.11.12.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 12:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 15:24:50 -0400
Message-Id: <DH076DCNJOAO.20TLWKWHB5KUX@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <yatsenko@meta.com>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260311182831.91219-2-emil@etsalapatis.com>
 <5e8af34fe927be2c273db8459897fb1f29616b91e7b21f4430c9d414734f6a40@mail.kernel.org>
In-Reply-To: <5e8af34fe927be2c273db8459897fb1f29616b91e7b21f4430c9d414734f6a40@mail.kernel.org>

On Wed Mar 11, 2026 at 3:16 PM EDT, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4fbacd2149cd..0304e4329490 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6733,9 +6733,11 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>>  	struct bpf_insn *insn =3D env->prog->insnsi;
>>  	int depth =3D 0, frame =3D 0, i, subprog_end, subprog_depth;
>>  	bool tail_call_reachable =3D false;
>> -	int ret_insn[MAX_CALL_FRAMES];
>> -	int ret_prog[MAX_CALL_FRAMES];
>> -	int j;
>> +	int total;
>> +	int tmp;
>> +
>> +	/* no caller idx */
>> +	env->dinfo[idx].caller =3D -1;
>
> The function header comment above this hunk still reads:
>
>     Since recursion is prevented by check_cfg() this algorithm
>     only needs a local stack of MAX_CALL_FRAMES to remember callsites
>
> The local stack arrays (ret_insn[] and ret_prog[]) have been removed
> in favor of per-subprog dinfo fields. Should this comment be updated
> to reflect the new approach?
>
> This was also noted during the v3 and v4 reviews:
> https://lore.kernel.org/bpf/ad397307a9cd76c9739ee05f4642c7b6a881b7dfb8a2f=
acefa6b2062ffe328ea@mail.kernel.org/
>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/too=
ls/testing/selftests/bpf/progs/test_global_func3.c
>> index 142b682d3c2f..974fd8c19561 100644
>> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
>> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
>
> [ ... ]
>
>>  SEC("tc")
>> -__failure __msg("the call stack of 8 frames")
>> +__failure __msg("the call stack of 9 frames")
>>  int global_func3(struct __sk_buff *skb)
>>  {
>>  	return f8(skb);
>
> Should this be "the call stack of 8 frames" rather than 9?
>
> The test has 9 subprogs total (global_func3 plus f1 through f8), but
> only 8 call levels. The entry function global_func3 starts at frame 0
> and is not itself counted by the frame increment. Each static call
> increments frame by one:
>
>     check_max_stack_depth_subprog() {
>         ...
>         frame =3D subprog_is_global(env, idx) ? 0 : frame + 1;
>         if (frame >=3D MAX_CALL_FRAMES) {
>             verbose(env, "the call stack of %d frames is too deep !\n",
>                 frame);
>
> With 8 static calls (global_func3 -> f8 -> f7 -> ... -> f1), frame
> reaches 8, which matches MAX_CALL_FRAMES. The verifier would print
> "the call stack of 8 frames is too deep" and the __msg substring
> check for "9 frames" would not match, causing the test to fail.
>
> The old test with global functions also had 8 call levels and
> expected "8 frames", since frame++ produced the same count of 8.
>

I'd say no to either suggestion. The updated expected failure message is
correct, and the old comment still applies for consecutive static stack
frames even if we don't refer to a single stack-allocated call stack anymor=
e.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/229688=
48938

