Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4253C5523
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985914; cv=none; b=N5vwlo3CtCN2R+qb2h1iC+zpDRS7/wjlA+tAreuPIFz0IkcuvX7GhLILDtZ6DXqoTTZwQD8Nj1fxJSM1BQZqOYXAeHFRCU2VWhyunNNY0mQgdts4EYQ8fAJRhv2jDmgptmjmFSpg9URMsB+8Lo/95N2SuLPL74zyP2zPSJ6Swok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985914; c=relaxed/simple;
	bh=OuUri7/QJWmBYdpAQycm9GDNcgKYJhtu8lwgC87GRbo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ERgxCz2+nQUuEzO2SZ/QWB7p5arWBZP7Tz6zlRLuASmi0djGCQtCVO8nDtXi8OAeVc1TNqvxCfxfeKEhXNsaWJE1t8kbdBDabl0Wd/59Uf41EdVoaVX7sLYUh2NIG6Ag3Pn4nVEWGz8C+1KwsAfji8l9s1ZrY1tP5DeOKBuWwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=dryztrHL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="dryztrHL"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f1d8902so2116498b3a.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780985912; x=1781590712; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeIGpJPlxr+iwzxCGPMkMnFzATrzk7uuh9qhP7sBuUQ=;
        b=dryztrHLwbvFVWjMd8/vg43I4hKCNXAXH4DyiJEdzHQ6cKad5VEM3AEeMFA6uvQzMR
         I65j4QcCLmaCJa6g1phMgyXwWBeKikdWjTdNPnrUOn7e/xzZjULtVlFLkgeWb/ZXYAn1
         SGux6p9twf2LlHXZZ+TtESIrOqtt2MPFu1qNg9KJLxb3PixBv4zwqDnAIu9D0mMQ7NBE
         jyJyMWNuG3QQEX9Es3Df89KB70S+Ky+eLvruZGga4dFklGO2U+Tgsek+KajwuU/DhgbY
         woFtaa0TANUwpfZAE8jE1TU67YbYuYkmnMbihB8jNRPC76/VWX94ZtlQBXsexXruOdXQ
         ZYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780985912; x=1781590712;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeIGpJPlxr+iwzxCGPMkMnFzATrzk7uuh9qhP7sBuUQ=;
        b=ViVn/QSw7AsJqJurR/+4coo8PCUa+OL9+q5VrkSPPQWd+M7rnmTWaZhjRMbwk3+7XF
         bVvamW8pY+U4LwiOfR4rckGZNi5sIRdbdcDBQnx0kCUzKriurUO5fweiP/L/FKp+waXs
         EW/kuuSOsnR0YyxDA8TxV6/Sg5YCLz9DRxHAiJui1LEO9Nr3rkAbBU1KAFVcFSHUMg3C
         AXKLeLC2++191YuLJ3Yvl1MUfFcGhhiQe9hYYdVu0y8jcNyz7PGQs/KM/TwFqoJ0pc0V
         BzK5lDey3WvrLqygeh6EtRySNJhDjan7J/DLN9ESyLPJVhuJdAMuG73SdEAnnZwjxp/Q
         WjBg==
X-Gm-Message-State: AOJu0Yz0upU/djZ3NajBBTD3hQEs+7/iDHIZRm/EFu79ySVdKWt5buVH
	Bz1F7m3nxCYR/Y3b6s43dM3K48quW3GsYCUaosoqb+cI/P5n7C/gmnMnuXZXKTSblxU=
X-Gm-Gg: Acq92OFMRErT/9KMaSPBsL2Y0qTTdfM7pNsp48B/cVkKT1tF7G7R0CMhGst1bee5atk
	jQ5GIRcGNn6CMb2FRHbNOVf6pEXjSlV+liYwlUUtDjsrOAVJocnMhFLsyQ1uFb+Ai6XSvvUWur0
	wLoFaB6Z4hLkCzEp4EXSIybL1lgUVYcASDh5FcjuQZ8XJg2XlcPf0MPUisy1DZ/horNOigEk+EB
	+90yrbRNYlizq/EsuEsyoX2C+m//yWNSm1wZX3uK8i7JtQm4Snu0KawTMPXfxiQ9EkOgWjQYzQp
	qILHyhAIgsnY7PGyUQofcLbiHD9EXrpK0ZaPJwAUJbrixB8FPb0MUuvEkmxXEVpSGGDc5BKZlOe
	DM1VAzP+bmKMBGQVdANOURBwcVabmL9KhtxhMuoYInW+TZqGaef2/f5u2hsrg5x2y2x3TSQUhbn
	quyOuYyVx5+TjKDI0DBq5fohzw61oIIEarXVJuiL6j4qLknnnFC3LP3Mr8vBKPhMjur9U=
X-Received: by 2002:a05:6a00:420e:b0:82f:38df:681c with SMTP id d2e1a72fcca58-842b0e11ad8mr18687236b3a.6.1780985911765;
        Mon, 08 Jun 2026 23:18:31 -0700 (PDT)
Received: from localhost (d206-116-244-52.bchsia.telus.net. [206.116.244.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e228asm21788738b3a.47.2026.06.08.23.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 23:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 02:18:30 -0400
Message-Id: <DJ4ATCC4ZK3E.UQ08P1AVGZ3Z@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "Jakub Kicinski" <kuba@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: libarena: Avoid spurious spmc
 parallel selftest errors
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260608224732.4482-1-emil@etsalapatis.com>
 <CAADnVQK8iD86UoZ9fe8sRDAUBOg5oNLLaWYqkWb=iG=4eCXguw@mail.gmail.com>
In-Reply-To: <CAADnVQK8iD86UoZ9fe8sRDAUBOg5oNLLaWYqkWb=iG=4eCXguw@mail.gmail.com>

On Mon Jun 8, 2026 at 11:34 PM EDT, Alexei Starovoitov wrote:
> On Mon, Jun 8, 2026 at 3:47=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> The libarena parallel spmc selftest is nondeterministic by design.
>> As a result it depends up to a point on the relative timing between the
>> producer and consumer threads. This introduces the possibility for two
>> kinds of spurious failures that this patch addresses.
>>
>> 1) Spurious timeouts. The test proceeds in phases, and threads use a
>>    common counter as a barrier to avoid proceeding to the next phase
>>    until all threads are ready to do so. If a thread takes too long to
>>    reach the barrier, the already waiting threads may time out.
>>
>>    Increase the current timeout. The timeout's value is a balance
>>    between the maximum amount of time spent on the test and the
>>    possibility of spurious failures. Right now the timeout is too short.
>>    Err on the side of caution and significantly increase it to avoid
>>    spurious failures.
>>
>> 2) Spurious resize failures. Some selftests require the spmc queue to
>>    resize itself. This in turn requires for the producer side to be
>>    materially faster than the consumer side so that the queue gets full
>>    enough for a resize. However, in the benchmark the spmc queue's produ=
cer
>>    is outnumbered 3:1. To offset it we add busy waits for consume
>>    queues. However, we still see occasional failures due to the queue
>>    never resizing.
>>
>>    Minimize the possibility for this in two ways: First, remove one of
>>    the consumers. The 2 consumers still exercise the "race between
>>    consumers" scenario. Second, increase the busy wait duration to
>>    decrease the rate by which the consumers act on the queue.
>>
>>    While at it, also replace a stray invalid error value "153" with EINV=
AL.
>
> It all makes sense, but CI doesn't think so... failing with EINVAL
> on x86 and arm64.
>
> pw-bot: cr

I see, I went overboard with the timeout and the bpf_for() loops were
silently failing because the end variable >=3D BPF_MAX_LOOPS (I wrote this
fix on top of a patch that had refactored the bpf_for() out). I'll send
another version with the spin limit adjusted to be below that.

