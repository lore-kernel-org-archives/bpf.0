Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482339D6FC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230346; cv=none; b=t/cCUqty3m1gHWnB/A4BAOT08aGE+/BANI5WtPzMxDHT5mU0iK6xRvG2L4b2gLkl50nRIUA9L2UkFF+RgOu9eiTp5gYAT8a3lFd1UTshPek9fBPOepQLD2M6VfT/RwWybHR2EVk7HPh44jvoZLhBmcxZPrpNUBTARcFaDSTb+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230346; c=relaxed/simple;
	bh=1aeHcPvM+nCf0irntby5zg5CXrW4RqIvG8FOKc/C7sI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SAa7rzb/hMdWj39I3Qdt6GYnOxu4o7EeLDze8D9Og0j+7SYaw+CJTLzjoyw7eIx0OvNAKnrB5ASCwR9nggcJh6Wech6vwnjRspGTwDAbm5tneHIzJyvDrffTrKLFSz2xZ8pUagiTCT47MIoK22mNO5UcFoS04KU7MFx0aUL2bTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shqTNrzB; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shqTNrzB"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so3466535e9.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790230343; x=1790835143; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QleQTWy80si6Y33wtP2OanXLegmzjYUiFaaIslERXfc=;
        b=shqTNrzBwHxStleWqI3ALmaJO9yTHeukufoVW7sq987N4u6MkFogwrchiDKjlVJ+hX
         6myYGw6xa7c0Psk0ROXDIOnFZifP6KPqtJIVt61zWtPod7b8lLvEAi3aB6tnkhbfBZSA
         K3JgxD3tfLUJuLH+O0tvHQltVBW6JQCzUHmsaEt9Tp8ZsSgIMybJ0x5C3oB09lg8yLxD
         1NUwKSD0szYsqTyinJOlmZmBellaJcFgRZkjtYw+wEZ5M9S524jVy/u02aAo3Cn2hBJy
         Tfs2Fy2ab4fA3rVKKZDLH8RSAdjCE9FHzaB3OP18wxDTT0OvIO3z0Ykg4NOSWKBrx8de
         rDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790230343; x=1790835143;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QleQTWy80si6Y33wtP2OanXLegmzjYUiFaaIslERXfc=;
        b=et8ChyX+xDFDVUEU6lhEkThcSzZ/oAGCu4jS1GijSmMjK2TCtqoKsqT+G2sQ/n+WEU
         W6GKuQWLh8AflkbFie95Uh/OBvLEXhotOCLc0FWuKV1etxDiLuf3cvWYHcoCRv379Hn8
         invS+7W+HLhslsMSvCARJRHp9/ieOtqQ+K/l0Vr5Zv8nGsrrSfa4dkfMdHwMs9CM5Kav
         A+axL62tJicfPAPm+esVNyi+vQHLp0T8jhO7kaDtCAH1h9k+0q6A6raP6f9iGQX8QwBA
         TMBRmuF4Zhz9LzD5gtb6DRxFdhFbT6gIOt/m63vuDSbiRu0bqTbIy7m9+EEcmKTHNT7L
         rGbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGnKdVxwV0BqNUXP/8t6ZPa1Wu0Kej7I13dXM8JKQo3xnKXDMZY31OaqQ2s3JSF9HIaCs=@vger.kernel.org
X-Gm-Message-State: AFuF++nMABlt43ACcPWkmB/oXbTHKW9rv2/448u0AQZWOaUoPQYta/vK
	VROImRrcBWan1iIDH0m31XnLNfor+TrmD4vzTOUZ7HkNbCbBcaI7UB+F
X-Gm-Gg: AYBFou312Ifmgal04vpKHw6w9rn9AQ0Pyr/Y7J7zxSY08P3I3cez3cK6pk/k9f+35vT
	/8xVisoGRAloSJ4BnxfFxSSVXl2l0RFatmXSt2I08UcwHFDrTB3pbSvw4ULSA7h2G1YeVTiwyNz
	DF0VaSeATbXwew5l9OGnERNhdZwVoFmSJ8B/tTC96TqYmDrW0GmYVfbRXWbjWkHWAje/NY3W3Lj
	UTQF5sp2Z0EHWV8hrXbNwZifyBroNex/Foz+pVq48eXL9rqZMDZXTyH/hp8WzZTEs5E9iXey4/l
	LIN1LcQ3u358dWX1dD6WOd6ZiC/icHrKavtCB5jt/gKC8Hy3YwsdQUW3Sv+EmI1IF2ovmK77ulM
	EqhGriWXO9cJ9epHM2qD9HcVF3GA5w8kppAUYiHbE3z3LaCoYzlzu0V8LtmjEwxmBWYdY5Db74p
	qfOGjYHA4PWxEGNV3rMj+RZ5iCFghVU0m+h3WFuOq7rAfa/Bgdbb0/fmJyRMYR8dHewfuGQSfRq
	Nh4O5t8ZrU4Kv4JrVu9g34yXF4oASv7s2R4NbsX3zsCq7O0eO/qcv1iKlMzzNiFtV6yf9UHUC2F
	xBL7uWTKeEaalyibDXvl+CdqQiRwggS1FKDCiGA=
X-Received: by 2002:a05:600c:1987:b0:49c:d26a:cf70 with SMTP id 5b1f17b1804b1-49fe66d81e3mr21326495e9.15.1790230342314;
        Wed, 23 Sep 2026 23:12:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cc90ccsm69109565e9.10.2026.09.23.23.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 23:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 08:12:21 +0200
Message-Id: <DLNBOX5XC5IC.YZ4E0D307022@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>,
 <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045922.2417689-1-yonghong.song@linux.dev>
 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
 <DLN0K7231LF2.1UNIBGA546C90@gmail.com>
 <9d794d45da75370d010dd0234cbba5dea61c19ba.camel@gmail.com>
 <DLN2XYLSE1PL.3HCQB74CH54GY@gmail.com>
 <DLN42F6YUPGB.25WMDJLB3IJJF@gmail.com>
 <DLN66VIA4CPY.1HCNCKTWC3JX@gmail.com>
In-Reply-To: <DLN66VIA4CPY.1HCNCKTWC3JX@gmail.com>

On Thu Sep 24, 2026 at 3:53 AM CEST, Alexei Starovoitov wrote:
> On Thu Sep 24, 2026 at 12:13 AM UTC, Kumar Kartikeya Dwivedi wrote:
>> On Thu Sep 24, 2026 at 1:20 AM CEST, Alexei Starovoitov wrote:
>>> On Wed Sep 23, 2026 at 10:19 PM UTC, Eduard Zingerman wrote:
>>>> On Wed, 2026-09-23 at 21:28 +0000, Alexei Starovoitov wrote:
>>>>
>>>> ...
>>>>
>>>>> imo the following is cleaner:
>>>>> - do not repurpose bpf_throw() for this new thing.
>>>>>   Introduce new kfunc that will do the unwind, let's name it bpf_unwi=
nd() ?
>>>>> - replace all 'call bpf_unwind_resume' with NOP by the verifier (or m=
ay with bpf_exit. tbd)
>>>>>   Technically rustc or llvm can do that too, but it's cleaner to do i=
n the verifier.
>>>>> - In bpf_unwind() walk all exception tables and replace return addres=
ses
>>>>>   in corresponding frames to landing_pad_ip-s.
>>>>> - just return from bpf_unwind().
>>>>>   restoring callee saved registers will happen automatically by corre=
sponding
>>>>>   frames and there is no need to search exception tables at each step=
.
>>>>>   That's what typical eh unwinder does, but it's doing it due to C++ =
logic
>>>>>   that is more complex that Rust. For Rust unwinds we don't need all =
that.
>>>>>   The above algorithm will do.
>>>>
>>>> +1, makes sense.
>>>> After return address rewrite the unwind would have to jump to it's epi=
logue, right?
>>>
>>> yes. I feel there will be no need in asm() tricks in such kfunc.
>>> unwind will rewrite its own return address, and will return through nor=
mal C
>>> and will restore callee saved (whatever it needed),
>>> then immediate callee in bpf prog should have had a landing pad for thi=
s kfunc,
>>> since this kfunc is throwing.
>>> so bpf_unwind() will jump to whatever is necessary to unwind in that bp=
f prog.
>>> And so on till the end.
>>>
>>>> Why not reusing bpf_throw() though, is it because of the exception cb =
mechanics?
>>>
>>> yes. bpf_throw() is not seen as throwing from compiler pov.
>>> I believe all kfuncs are not throwing. (that was a bug in this patch I =
alluded earlier).
>>> So we need a new kfunc and mark it attr(may_throw) or whatever the attr=
 is called,
>>> so that compiler will generate exception tables for that bpf prog.
>>> Last time I checked there were bpf_cleanup section for rust-c in that c=
ase,
>>> but that was back in April.
>>
>> Hm, isn't this dependent on how you annotate the kfunc on the Rust side?=
 Like,
>> you could make the same annotation on bpf_throw() that you would for the=
 new
>> kfunc, no? I got confused by this part.
>
> bpf_throw() has a specific semantic already.
> Like it suppose to call that bpf prog callback once it unwinds
> everything.
> This new kfunc is different. It will initiate the unwind the way rust wan=
ts it to
> and may stop in the middle.
> See below point about 'catching'.
>

Right, ok, that makes sense. I do think it is cleaner to have landing pad b=
ased
cleanup initiated using a new entrypoint.

I just wasn't sure how much point there was in keeping the old unwinding sc=
heme
around, given without being able to release any resources it's not very use=
ful
in practice, so we could just drop the exception cb stuff completely and ju=
st
change its behavior and make its working conditional on landing pads being
present.

>>> There is also a case of 'catching' abort in rust. iirc it only stops un=
wind and
>>> rust-c generates something else instead of 'call bpf_unwind_resume'.
>>> Memory is vague. I think that frame will continue as normal after proce=
ssing
>>> landing pad drop()s.

