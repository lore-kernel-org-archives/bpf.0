Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42B12FF69
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619377; cv=none; b=aqZOrH0lz2ixdlgtsNJ+MK+PK4B9xT0DclZneK3V3SEpOmTy0iwDrjw4IFFhKXHYrLZvfbaNX5Ta9gyJnnd1Sy5uihDPyfUtKWi8BEoNxmtVaufsGuGw5GweoEGsUO0B/q+m2J0fvK9hboKXIyywFqOUiGwFv7CoyCMRaiDVtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619377; c=relaxed/simple;
	bh=NeUDmQvBOXjWZfh8oA5S6x+uy6cAbfPSwTwJYaQTXEY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oaJkZGu0joQpcPG3DPyhxQAFXUjayL141bweXho6ro3V27C5rF3oHhACvf0iM3ejg5TQlxYosDq3jXswysQs509eSugs0ZABXfGKSFmtrpZsrlQGd78R/T5efbe9ueDCCps8i5XtTCdhS4NwN37jIPvB1Z2kIUgQexg/f6e1AUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=n9jL2SPK; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="n9jL2SPK"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-13807d2f898so83774c88.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780619375; x=1781224175; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTj9dtYoNdYPZmlbq7YxGbZ/jzLtXua7StSfxMgmz2k=;
        b=n9jL2SPK1jKbORawXkpfEcMNO8fzp13BFTcvn+nkeIdlE3+kB90VDrwdq+QvMSNsi2
         IvDhc23YI4jg8HEmO0vwFYTOiJ8YHJrs/WnVObQvoXhO64yGJOqLuD3mgkG1ikX6CSTx
         2S6qNDA4v7TX0DkClJwc7u0iSySToyp52AYf9Ock9d6LdVZ5OIUatZvOusQsNxlEybU6
         vq6Fl5a+k+v9wGwohiXe5I3sq10eZ2/2uRH25PsB/iUVeOYL8GUpuTdfZIuPUjcCGazX
         Kxnj5rS50eiQ7spaq4ut5lkOXnHd+XhFXsq+3qC/7ZeDw9bfA7+oOJ5O4KXQEHoiKMT7
         h7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780619375; x=1781224175;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTj9dtYoNdYPZmlbq7YxGbZ/jzLtXua7StSfxMgmz2k=;
        b=kL60fY+4a0tcDNV+waukDY+ACYnJ7g/WxN+SsqC9aUJxsXlyesNbzzxTel6qZ5s86Z
         k+tmH80A95Mtse2dlezI4EI67CoOg3dfrv6rAJX8b+uH1myGxR+N+ABr8m2LlMzgyFcQ
         BlQ8DiUe+FhJQ7S8sIuabQqqAhduvQ/Fh5qJ74mekPkNzjczWhsCXW4r2JGbDuU0MObj
         WYcJ32GEBLMaM8zV1hc9UQ5vw6pvTSdLzkHhdMbfsGk3ALkVYbDzBK9exJ9JqeY0mbgB
         U62+NKzRd3N4D5vuNR8LTf8h9Dzvswg/YPz67ndZ/Ta8NTrRbg1PA/aLlY+XusnOCTOf
         sTGw==
X-Gm-Message-State: AOJu0Yy+gkkHJRUBDw5EEHCKMNi6maaOMI+fwH83j8aD1Ex3iP1UA004
	od5lQ9896VgPZ3QnDxtFHoJc7wTGvQPH851yiEqAtMxh6xElt0sfJnbQaRgoHVH0EFs=
X-Gm-Gg: Acq92OE0O8NCI7i/Z6CYTqIvJOyRTwH6Rw2sn7MNkfWCESoAN3aCOq/g7/koyf1TKbY
	9qmbr6+Ilx19mK5/Z+wNG8LKmUrxSiFhK+paYWOp7pxdxln3bIwOFqGJ6Uy59jygfF7ObOnCBvX
	UNtvtciBZaBbx5imDVpwRUUIb73xgPMjKdwo0ojPssOjSSWZnSeXR3+LSsJcLe2LFy+jFvGVebr
	qXsdrhLggGjGrlbRHAcZOn0vG2Qf2kedEUD2mkChgyu9QfdjLtPW3ndNJqojrySKRlboflmpe6E
	to+3StLKPvaZmmcHGvJ+i8+OypXRg9MRqHCwcrp40mmUIEKaSzdi4EaQ9Post3v6cr5uKWgcl0g
	NhbpgnXFxdBIH2mKPpGKFvdLQDMiPxNZMsWcBPmqzPnURex7VosbpMjNW5imsDutPN4tAN6iyAc
	N/1EZ0ypaQd53hQ1U=
X-Received: by 2002:a05:7022:b99:b0:137:8db3:73a7 with SMTP id a92af1059eb24-1380673adc4mr596021c88.31.1780619375362;
        Thu, 04 Jun 2026 17:29:35 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::39a8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138063de4a5sm720414c88.13.2026.06.04.17.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 17:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 20:29:32 -0400
Message-Id: <DJ0OVZ8WT5E5.23LQUYQYZUUYJ@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Matt Bobrowski"
 <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next v2 0/3] selftests/bpf: libarena: Add initial
 data structures
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Yonghong Song" <yonghong.song@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260603182727.3922-1-emil@etsalapatis.com>
 <CAADnVQLCk1gVt6XOcZnuvsULx+R+T0DaJBQ7-sYHFSaEKPW=ZQ@mail.gmail.com>
 <DJ0FG1XDA4ZU.3MA6IY4M6LA51@etsalapatis.com>
 <CAADnVQKA5Fj-OTqJUP5qpBKuk1Gvp_L78ZH8uh9ed2G5qv4Ffg@mail.gmail.com>
In-Reply-To: <CAADnVQKA5Fj-OTqJUP5qpBKuk1Gvp_L78ZH8uh9ed2G5qv4Ffg@mail.gmail.com>

On Thu Jun 4, 2026 at 1:27 PM EDT, Alexei Starovoitov wrote:
> On Thu, Jun 4, 2026 at 10:05=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
>>
>> On Thu Jun 4, 2026 at 12:51 PM EDT, Alexei Starovoitov wrote:
>> > On Wed, Jun 3, 2026 at 11:27=E2=80=AFAM Emil Tsalapatis <emil@etsalapa=
tis.com> wrote:
>> >>
>> >> Add two new data structures to libarena. These data structures initia=
lly
>> >> resided in the sched-ext repo (https://github.com/sched-ext/scx) and
>> >> have been adapted to the internal libarena build system. The data
>> >> structures are:
>> >>
>> >> - Red black tree: Fundamental tree data structure that can also serve
>> >>   as a base for more domain-specific data structures.
>> >>
>> >> - Lev-Chase deque: Queue data structure that allows efficient work
>> >>   stealing, useful in scheduling scenarios.
>> >>
>> >> The data structures are accompanied by selftests that are automatical=
ly
>> >> discovered by the existing libarena test_progs selftest and incorpora=
ted
>> >> in the CI.
>> >
>> > bpf CI says libarena tests are failing.
>>
>> Looking into it, the issue is not manifesting with LLVM 22 so trying to
>> see why. In the CI, the compiler is generating code that is doing
>> the address space translation then still dereferencing the scalar
>> instead of the PTR_TO_ARENA like so:
>>
>> r0 =3D (scalar)
>> r1 =3D addr_space_cast(r0, 0, 1)
>> r2 =3D *(r0 + 16)
>>
>> In my opinion if it's not a programming error we should prevent this
>> kind of code sequence from happening.
>
> That sounds like a llvm bug.
> Pls craft a small reproducer and pass it to Yonghong.

I fixed the issue for v3, but ftr this was a bug that was fixed in LLVM
22.1 (commit 94290f). I pinged Vineet because GCC was also failing with
the exact same symptoms.
