Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC63161A2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214824; cv=none; b=VuqSI4T/RmKJ7cvMjlob84aZcBc92VfdQP3KWuMSangkA9jl6vWZLrlAplUk1JkxvKBlGz3MisXhrhJ9mtOJZFI9h06NPDS7D/2D+FgA8YA+r5oVf7sQ3ZR1pAYlZvn7vP+hAnxixcpyCW7PrZE5Gq4l06oNColmig2InZvKTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214824; c=relaxed/simple;
	bh=o7P2tIxYdPYWiGUiZlguvSt3PRESuJD4BhhpfkNI1m0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=O8xDcXoYadaVtnm0fhngNXcOkUqLZJIOUXFpGp/zYv3oyjoxCn/prQhex9MFQOcIuEUkX6uKSla0i3WqrFr1l3HTxxSCOqlf58VpuDWWMVCp6ax3a+EF38xNHXbfUhIzJ8/ida30XYM9Xn/1ZDRKDQe6n/2IEXqmKVjcToUWoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZR1xFR3; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZR1xFR3"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so1218491a12.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 18:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790214823; x=1790819623; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqlX/Fc7oWjZwqFbP6TZjEcx9omeQ7BxZFbcjya7Mu0=;
        b=GZR1xFR3Xjn+/KuizW1I3uZnAOUY0W6uB0VRheI+Ttisehk2WfBtg2Yqoxejve9Qdl
         jlBxKRkzO4+GLJ2pbwv4HLlwtA64GQoKyj1MwabhcWlDvyk1n9K5TKIQk0LvOJ/PfPWG
         sR8l0UOdBD1966wiO3UgkXecfYtLZr/vmljk8GMduqSCtdFyZfMP35ITiQ1ujyfdsnR8
         EN/i2ttymKd0gG6jAAt90Nsigs3wUh4iQ5krNZabWE99Nk5IN4/XX+cxMpsAJQrwUk+p
         iev3ONz/2K7AmPCxzAio3Fkoa2LbAyZhb1qBRQVKf3O4qoBbWv5UZCqrOwNShi2WibWo
         ILbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214823; x=1790819623;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqlX/Fc7oWjZwqFbP6TZjEcx9omeQ7BxZFbcjya7Mu0=;
        b=eM6Fvpo9skZcfb81nfqM9NiPY+SgOUD6AgKoYFlBrgc1HY5XvIYds+3wA+QOELFXIc
         Gi9Vb0DoOmtj16B4AZ0eg0J+wIFBdY0ks084oCzb/11htOUaPzrHlXXT8CMJzyPQJzjO
         UUYAT5uElR5A5PRvZWl2tB2JdARVFgKRn3DcIP53wxvQGlUVbnfIgffpDbc2nfA4PHlX
         vzbPetpwBnlyjlg8syx6u/oJT5Xkgnadeifvn3sbowbrSkNgNqhnSH3Rssomf5Y1tA4N
         nscphSLouXCJTqPq8j/2ZBOj1YHhxsdWuvIZyoMzQGQJIaujh7NqZHErJIMC/yU38X/N
         2/7g==
X-Forwarded-Encrypted: i=1; AKwUvBzG/ashyECsh+YgSLbtVCDd+QUq6M2H5doHXIQvVZ6XNACurC4ppe24a42rG0Ta6iveBk0=@vger.kernel.org
X-Gm-Message-State: AFuF++mUbZxzV4qMYhTxgSjx3ijepGaWrKHjU8XyFpBqP7uYOEKMTPDb
	amR55zfknsx048Aj28dOftfqL0SlbYqlrUVdDGT+D0CrfTlK8tsARr2B
X-Gm-Gg: AYBFou3Hm2v4+zbBwrJ8UUt6Pug6cDIxohuE6DGuLkUtj36RQXIPJ0a+gkYkUHg2eJw
	IY7EQIFbvbfIKi5zrxkc77ky8Xevfj+XrPhiFf7293KLw9CZa3PL0rXxD4ephvN51f8LoxDw31M
	rWVzTrNgie2hz+N0OG6sKeKqASZzOeklm/+arKChF9AT6Ov+po17D/+ZL6OSjwZnSSQC1v3KbUy
	1lU7W0FwZJhR8bwiMYOxry6GS1GAFvxyyuxLIXs5vteNghqf4DYGhvdUAN8hg7nQGTFq9idj1M5
	6+b4/FQExnuw7hfUvYkXnY6Sd2rLIi+3XIEE2YJz3JF4NdsFPQl5vob4Dm+NioXceySJU8/CoOI
	jJtMy07T9dBLcy540KuCkmRlw0pWQQMZJKPcdxlMxwDNEbN9cZYGeMGkoEvE/SdCK6g4Tu2Ti6H
	5zm9x8PwqpZkkloHFCzbG8Ed9/SpmDx63t45hPwRKlrk4NOh9wPl1zlHO/3Irms/NZv28bEEIYc
	bTkQAUwTK1HUt67WL7i80Itp/PRGOn3oC1sdXD0mZdr5AWzAMr8UjhHQhon8Z0RfhsdZdA5mDKS
	vFo=
X-Received: by 2002:a17:90a:d446:b0:3a0:7d23:f7ca with SMTP id 98e67ed59e1d1-3a099234e41mr721757a91.55.1790214822720;
        Wed, 23 Sep 2026 18:53:42 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0973c4fb4sm1758212a91.17.2026.09.23.18.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 18:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 01:53:41 +0000
Message-Id: <DLN66VIA4CPY.1HCNCKTWC3JX@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045922.2417689-1-yonghong.song@linux.dev>
 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
 <DLN0K7231LF2.1UNIBGA546C90@gmail.com>
 <9d794d45da75370d010dd0234cbba5dea61c19ba.camel@gmail.com>
 <DLN2XYLSE1PL.3HCQB74CH54GY@gmail.com>
 <DLN42F6YUPGB.25WMDJLB3IJJF@gmail.com>
In-Reply-To: <DLN42F6YUPGB.25WMDJLB3IJJF@gmail.com>

On Thu Sep 24, 2026 at 12:13 AM UTC, Kumar Kartikeya Dwivedi wrote:
> On Thu Sep 24, 2026 at 1:20 AM CEST, Alexei Starovoitov wrote:
>> On Wed Sep 23, 2026 at 10:19 PM UTC, Eduard Zingerman wrote:
>>> On Wed, 2026-09-23 at 21:28 +0000, Alexei Starovoitov wrote:
>>>
>>> ...
>>>
>>>> imo the following is cleaner:
>>>> - do not repurpose bpf_throw() for this new thing.
>>>>   Introduce new kfunc that will do the unwind, let's name it bpf_unwin=
d() ?
>>>> - replace all 'call bpf_unwind_resume' with NOP by the verifier (or ma=
y with bpf_exit. tbd)
>>>>   Technically rustc or llvm can do that too, but it's cleaner to do in=
 the verifier.
>>>> - In bpf_unwind() walk all exception tables and replace return address=
es
>>>>   in corresponding frames to landing_pad_ip-s.
>>>> - just return from bpf_unwind().
>>>>   restoring callee saved registers will happen automatically by corres=
ponding
>>>>   frames and there is no need to search exception tables at each step.
>>>>   That's what typical eh unwinder does, but it's doing it due to C++ l=
ogic
>>>>   that is more complex that Rust. For Rust unwinds we don't need all t=
hat.
>>>>   The above algorithm will do.
>>>
>>> +1, makes sense.
>>> After return address rewrite the unwind would have to jump to it's epil=
ogue, right?
>>
>> yes. I feel there will be no need in asm() tricks in such kfunc.
>> unwind will rewrite its own return address, and will return through norm=
al C
>> and will restore callee saved (whatever it needed),
>> then immediate callee in bpf prog should have had a landing pad for this=
 kfunc,
>> since this kfunc is throwing.
>> so bpf_unwind() will jump to whatever is necessary to unwind in that bpf=
 prog.
>> And so on till the end.
>>
>>> Why not reusing bpf_throw() though, is it because of the exception cb m=
echanics?
>>
>> yes. bpf_throw() is not seen as throwing from compiler pov.
>> I believe all kfuncs are not throwing. (that was a bug in this patch I a=
lluded earlier).
>> So we need a new kfunc and mark it attr(may_throw) or whatever the attr =
is called,
>> so that compiler will generate exception tables for that bpf prog.
>> Last time I checked there were bpf_cleanup section for rust-c in that ca=
se,
>> but that was back in April.
>
> Hm, isn't this dependent on how you annotate the kfunc on the Rust side? =
Like,
> you could make the same annotation on bpf_throw() that you would for the =
new
> kfunc, no? I got confused by this part.

bpf_throw() has a specific semantic already.
Like it suppose to call that bpf prog callback once it unwinds
everything.
This new kfunc is different. It will initiate the unwind the way rust wants=
 it to
and may stop in the middle.
See below point about 'catching'.

>> There is also a case of 'catching' abort in rust. iirc it only stops unw=
ind and
>> rust-c generates something else instead of 'call bpf_unwind_resume'.
>> Memory is vague. I think that frame will continue as normal after proces=
sing
>> landing pad drop()s.

