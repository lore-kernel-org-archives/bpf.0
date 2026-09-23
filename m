Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F34372ED3
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205663; cv=none; b=qVmSxXoIz/hTmjV8tkAX4ecbqkk9ettIeMWjodA+SJSaqkCOb+gdyUloARbKfJhqnd0d8H8kEHN+D1jac+igQHWtcDcYrWnKwEYnJx1A/taSuNY+k3qKH4zV/I7+PD6b9vaMoQz5E4jXmwhhem+Rnq3LIuRQgAUl2+HV5FcCdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205663; c=relaxed/simple;
	bh=Y0HJO77HxrPEQSmFMpzdx4PkYf6guG2ohv0vAAZv0V4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IQGeiZbbiQNWA/9sd5rQb8EMlDmXDuPUnu5xmdx/JGNTuDl+ILmGhniIumcSnB5401VxWC9GU+unjpYAtMZEbFZgXzJ86dFrWuvYGCMpm/asqWTaF/47tHRpN5dSZwI6hE7TowYI44GKGgiDO+M7OVyY8Kr5OREz0XICMAGCjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivpf0a/j; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivpf0a/j"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1059505a91.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790205661; x=1790810461; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xAWbKNApdX6DxFupC+xN8Y/UmbTzZQIyk+vEvFcA8sA=;
        b=ivpf0a/jSI+cs+1GUCjE//OVYyjQlP7BgT2ccDch4Ey9LToeDAj1FM8Dqh9wFncllc
         45o99ppC1dr9mpgrUZ2NTrdqJzqnoKc4qPD2If8w2+MIi6dXx03XfPKJx6ScmQDA2Ill
         vJaTzFlqAysBWchdJCb2O4/dSn8J8TI5hMBFfHqK83f1lQ8bQ5I2Oj5HtsYHU8rIoBhC
         oLWd2uWnSTIfNTghycsnNk+/0l1ONZeaV9+vfTy5Kv+DgJ3YMJeyuZZD/j7go6QbkFsB
         GGpF3QyPpDhOLKoz0xTQGUHO8zf990wN5YbIxM0J2dwFpTXv136LVvPJaNQyLSLJkYwG
         2x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790205661; x=1790810461;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAWbKNApdX6DxFupC+xN8Y/UmbTzZQIyk+vEvFcA8sA=;
        b=tTtXMPpkZ0gBpPtMofsoDbrIgLF0l0Mj690kPC/Z6/I4ksTkbxe2OMvh9CK6+bsLNv
         4GDnN+V1AO/nuUm2FfIi3xgc+0AHbI754FNPQpao0XwfdO16S3h6Hte5kMWIaajwaycS
         Oa1jgfh6e3bCFIRQCLXVPNwc189JAD64PtqAEpMQjmQJ5NIbD1SZkYSlOb3SORvrC+Mx
         n8d8vyJ3/CANOUfqPG2m22PRfzY/TGyJWdHU+NYzvu4rf1b9T6ZJ/lMOJ/xsKEPoFk3v
         1wSwsrpxDiQyfmPoJdol5FkI40OOGrLCSfK8H2eavCzyauVbJPrrz5oCo1SQGRF5OK+M
         kWuQ==
X-Forwarded-Encrypted: i=1; AKwUvBz81UW5FyI0IVJQEwyQUmPgoGmy3tvZWE6Ksen7rUoWVvfcc0cOobki4fGkdk1YyouzfZw=@vger.kernel.org
X-Gm-Message-State: AFuF++mP1O72LQgjht+H1Rbh78m03sKfYLHGovurxQidlZdYL5CEWUCT
	T69aCoDSssxXIRqPIhrzRYBTpEKV0QM4jyZsUsk5EYSPolE511CqU2hR
X-Gm-Gg: AYBFou3DBR/27Y/25ZQBagmHHRsYlTUs55aYLEVGM6kAITbgKsZVp1DT+JWe4PNmqpq
	6iKfINvpj5jJ43fjn4jJsfr6V5EwXzcW+4owCxOXZnY4d9JOF8RYYhE8o7vc1p4mtajsOGODuJx
	ZCChK1ws62Wz3FKZjg3y3yhJlFkYfenavQmh0YS5BlofJ3aBPTjSSn3L4n3CPxiLRhGe6TyRXDe
	pZC7Y8yW0TdXXGnKa/vYo9Cmm9OFXT9brl3RGkpSylPvbYovqzPFrlzJAU0ZX+bCuKrjxHUOqa6
	3o59gtTAd4Tsn/OOshRl68/uHKm0jCLHsNAANh+goHIDj7b7jnwN4FDs2KT1zS/coK3JOMF8TEM
	xvthwangJBdY9TO2oitgrg2RMNkzS8IZalYPOeqbKhW7B6cX7NKG/81Pi3ZSAPHrT6Zo9Tp3Yqc
	v8YfC70Pd38S0U4ZRv+TtgsPClztGpUTUscKIkmSRwChZYkV/W83//x+w1tmVJiXuhRr+jUg3xE
	5KQSREoAmCnUMEZpqnw6Z/4FMLYNAgwAelPtxnKbxcjZ4VXEoxV9Y00A+qxV1xrnoSetHC4e6K3
	C1+E7x18LEX0uw==
X-Received: by 2002:a17:90b:2250:b0:3a0:574f:5854 with SMTP id 98e67ed59e1d1-3a0987247b2mr518800a91.39.1790205661095;
        Wed, 23 Sep 2026 16:21:01 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a9516sm17296065ad.29.2026.09.23.16.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 16:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 23:20:59 +0000
Message-Id: <DLN2XYLSE1PL.3HCQB74CH54GY@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045922.2417689-1-yonghong.song@linux.dev>
 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
 <DLN0K7231LF2.1UNIBGA546C90@gmail.com>
 <9d794d45da75370d010dd0234cbba5dea61c19ba.camel@gmail.com>
In-Reply-To: <9d794d45da75370d010dd0234cbba5dea61c19ba.camel@gmail.com>

On Wed Sep 23, 2026 at 10:19 PM UTC, Eduard Zingerman wrote:
> On Wed, 2026-09-23 at 21:28 +0000, Alexei Starovoitov wrote:
>
> ...
>
>> imo the following is cleaner:
>> - do not repurpose bpf_throw() for this new thing.
>>   Introduce new kfunc that will do the unwind, let's name it bpf_unwind(=
) ?
>> - replace all 'call bpf_unwind_resume' with NOP by the verifier (or may =
with bpf_exit. tbd)
>>   Technically rustc or llvm can do that too, but it's cleaner to do in t=
he verifier.
>> - In bpf_unwind() walk all exception tables and replace return addresses
>>   in corresponding frames to landing_pad_ip-s.
>> - just return from bpf_unwind().
>>   restoring callee saved registers will happen automatically by correspo=
nding
>>   frames and there is no need to search exception tables at each step.
>>   That's what typical eh unwinder does, but it's doing it due to C++ log=
ic
>>   that is more complex that Rust. For Rust unwinds we don't need all tha=
t.
>>   The above algorithm will do.
>
> +1, makes sense.
> After return address rewrite the unwind would have to jump to it's epilog=
ue, right?

yes. I feel there will be no need in asm() tricks in such kfunc.
unwind will rewrite its own return address, and will return through normal =
C
and will restore callee saved (whatever it needed),
then immediate callee in bpf prog should have had a landing pad for this kf=
unc,
since this kfunc is throwing.
so bpf_unwind() will jump to whatever is necessary to unwind in that bpf pr=
og.
And so on till the end.

> Why not reusing bpf_throw() though, is it because of the exception cb mec=
hanics?

yes. bpf_throw() is not seen as throwing from compiler pov.
I believe all kfuncs are not throwing. (that was a bug in this patch I allu=
ded earlier).
So we need a new kfunc and mark it attr(may_throw) or whatever the attr is =
called,
so that compiler will generate exception tables for that bpf prog.
Last time I checked there were bpf_cleanup section for rust-c in that case,
but that was back in April.

There is also a case of 'catching' abort in rust. iirc it only stops unwind=
 and
rust-c generates something else instead of 'call bpf_unwind_resume'.
Memory is vague. I think that frame will continue as normal after processin=
g
landing pad drop()s.

