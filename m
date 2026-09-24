Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438E145B3F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208834; cv=none; b=tBwZBpep8e6y4NqVu7zGFkBdPeeFAvVZe+xh3j/3wvHjGZPd/KGRuVg4Zdte1ZSOxlkyVMXjo+F+DOYpaGuYKTlXr/KbZFup/a5goSDRFAvNZl7/F7R18I7OfIICFC1tOXIkBOzK2E160jTl/44NAVDHNvCcM2y5PCywEkR6wtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208834; c=relaxed/simple;
	bh=2zf+9FYecsEK6mHAg7+dy4SXtcQ2VMQ5c87PGWxNzvw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eTfeCVRfFGwLjCUDerZXXq/hVf+SF9izPTgiqpZPJxUzQupjFF+mFCd+GabO/0jSGTHQnEdz3LvapeBo9zYn9i54hPiy3AfAxc/xDDoRzFUd4kF862JUVwQh0qZ79Ba7ALX6Bfoh9dtKsYFzYmxoMcnEJsdmpbPSpVAlYdto4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1ei3JAG; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1ei3JAG"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so3990015e9.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 17:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790208831; x=1790813631; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=njbIrtjc2kHLDp6hlC9e7N3BbSXM4DgZCgPepeaI1/w=;
        b=Q1ei3JAGr+aEVVi0/Ck6xyBBZvIKsBNgzVBqmRogww013e9SMCS6aaEmucv5PwJR32
         Xc2w7J0oLotQM6fihKWTe2FXPYOr11vLT22Mt+/wx36Fh/BGZnrx6AurZgW4El1tnVQr
         yF4+tA++h5Wzh44hcSUSeUQdAp35KHUuWYOsHInSEQyc72jLFDUs+AJFVXvh7IhE9egl
         1JGhdOOXf7uRReSI8ojIwIA4drzC9dgApemfJ1aYf9QUM9bTo2qBM94WEri4bgdT2dNA
         qomPkX/8FyAAaLHgmPL+uOFZVbCr//3S6FlcFd1AuB3XDVAUlFk+sBdsZDMUZBCmJm/h
         k0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790208831; x=1790813631;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njbIrtjc2kHLDp6hlC9e7N3BbSXM4DgZCgPepeaI1/w=;
        b=WX9RkePLBVMjGfGbNlrWrV+eyRpSWEqkc1GtI+KWG2/Ep8WO9BEjUUf+vLDKw4vzlT
         PU5s03ODNYgh0Oetxn1LmkeDDwzRiqJ3L2HWNGQPvQthzm1AVRqtbb3TgVaFYI0SVPsU
         mT+rJaSLhiH3Cv96wyws3001sWL/C8Tn9jt1fw483WHGh30V2RHYtgE2oVbo+khTV2uQ
         NyHtpVd9OQ8NlHJxMzOvKukHl+tO2YwtO3wE/j77xXY7utAYPAm6ZmxbjM1AHrxQta+i
         njiTNAaOnG8j/dmNCTH2b7SPjdTCo+C7Ur7HE4NBcVWNHRBeo70DaUWZd3ywkcvH+Qk3
         8xoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRvZJvOZFAFTnQzMODkLUGHaCMYXOtm53zxnOl3E73ScsYbjmqi9qwZyJtrdawmz/DB6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lu+qR42k/8EYEhhpv25vCjarBhRmaLKgmo4YZVdiyPVo5vMzfx
	WCpdORN9M/GIk9+eG3r9XsBAwGVmZ2CMBewLDEZtrB7+CpkXfiO5umnH
X-Gm-Gg: AYBFou0OBROc3FebyGGs6fogL2J+RqoRilfMfjuxCRRgrlIAb+sTPKjYNbW0jqM4oMF
	2kr3nfO22AdGABCieRxrO0WbkWt8EIxA/9XPfAVzjT7A2NG+IQP2f6DX0e5zVPIsgJw/BY9aOMh
	g9oLs7aGinlnIAh5ncaNNxqp+sFmf4mjZI7M8Y/XCdhGCHfB0cOLz+p3n7CcM+xj8zrPPX6iEwe
	yuWl6MUcF0uYTPjBJyUMJ2HsL4cxPjTt8jvW0kwLu8cZ69CS1TSlMWXBzjiNm5+YAUB9WWHPRCm
	yA39zMV0WsFMlzJpT5XO5BYc02uOQK6afmjGarcxqjpsROaG09WahXndTOnkcbgw0xJf/eNFRwi
	yaz4wRd4L1DhY189kg+Wkfb8X6NCSuNpeh4fFK3shlYbmpyuADoadf2U+LpIYAswsisAI2kvSVu
	6wqK5KqtgX8ZLDgMu2DB1lyiwpgng8A1t6ZZXEUPKY0b7nxMZsorp7st2a+DzwL6jXQV3fT6Mq5
	NX2yl3aithRxjE4JeinbEV3aaz+/X63ertZoecgTQWDanXxVKMrfMBht1bdsw0YuGdthtdb63h/
	ZJ3hLkvgpk4y3aKr82IWlwQgj4EOp4FddVllNw==
X-Received: by 2002:a05:600c:3515:b0:49e:7a10:1b71 with SMTP id 5b1f17b1804b1-49fe66d089dmr12472685e9.11.1790208831363;
        Wed, 23 Sep 2026 17:13:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c16dsm38042695e9.3.2026.09.23.17.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 17:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 02:13:50 +0200
Message-Id: <DLN42F6YUPGB.25WMDJLB3IJJF@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045922.2417689-1-yonghong.song@linux.dev>
 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
 <DLN0K7231LF2.1UNIBGA546C90@gmail.com>
 <9d794d45da75370d010dd0234cbba5dea61c19ba.camel@gmail.com>
 <DLN2XYLSE1PL.3HCQB74CH54GY@gmail.com>
In-Reply-To: <DLN2XYLSE1PL.3HCQB74CH54GY@gmail.com>

On Thu Sep 24, 2026 at 1:20 AM CEST, Alexei Starovoitov wrote:
> On Wed Sep 23, 2026 at 10:19 PM UTC, Eduard Zingerman wrote:
>> On Wed, 2026-09-23 at 21:28 +0000, Alexei Starovoitov wrote:
>>
>> ...
>>
>>> imo the following is cleaner:
>>> - do not repurpose bpf_throw() for this new thing.
>>>   Introduce new kfunc that will do the unwind, let's name it bpf_unwind=
() ?
>>> - replace all 'call bpf_unwind_resume' with NOP by the verifier (or may=
 with bpf_exit. tbd)
>>>   Technically rustc or llvm can do that too, but it's cleaner to do in =
the verifier.
>>> - In bpf_unwind() walk all exception tables and replace return addresse=
s
>>>   in corresponding frames to landing_pad_ip-s.
>>> - just return from bpf_unwind().
>>>   restoring callee saved registers will happen automatically by corresp=
onding
>>>   frames and there is no need to search exception tables at each step.
>>>   That's what typical eh unwinder does, but it's doing it due to C++ lo=
gic
>>>   that is more complex that Rust. For Rust unwinds we don't need all th=
at.
>>>   The above algorithm will do.
>>
>> +1, makes sense.
>> After return address rewrite the unwind would have to jump to it's epilo=
gue, right?
>
> yes. I feel there will be no need in asm() tricks in such kfunc.
> unwind will rewrite its own return address, and will return through norma=
l C
> and will restore callee saved (whatever it needed),
> then immediate callee in bpf prog should have had a landing pad for this =
kfunc,
> since this kfunc is throwing.
> so bpf_unwind() will jump to whatever is necessary to unwind in that bpf =
prog.
> And so on till the end.
>
>> Why not reusing bpf_throw() though, is it because of the exception cb me=
chanics?
>
> yes. bpf_throw() is not seen as throwing from compiler pov.
> I believe all kfuncs are not throwing. (that was a bug in this patch I al=
luded earlier).
> So we need a new kfunc and mark it attr(may_throw) or whatever the attr i=
s called,
> so that compiler will generate exception tables for that bpf prog.
> Last time I checked there were bpf_cleanup section for rust-c in that cas=
e,
> but that was back in April.

Hm, isn't this dependent on how you annotate the kfunc on the Rust side? Li=
ke,
you could make the same annotation on bpf_throw() that you would for the ne=
w
kfunc, no? I got confused by this part.

>
> There is also a case of 'catching' abort in rust. iirc it only stops unwi=
nd and
> rust-c generates something else instead of 'call bpf_unwind_resume'.
> Memory is vague. I think that frame will continue as normal after process=
ing
> landing pad drop()s.

