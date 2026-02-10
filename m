Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCE32FA32
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757627; cv=none; b=SXC/bk3Y+yj7JW7sMYDADmACh5o5Dqq6WrtOgQ4Rz6v1JzCJPoo2teo/UfJxaHitoUB85CR88IyWW5kb1N6XobES7N2v9awx8QaUy8A90dcRqugDBi2icKPgTe4sN5q2LdkPRe6hIxPov6X2hGwUXH6GFtRp9hrWJrqdW7Ed0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757627; c=relaxed/simple;
	bh=RNJYResRebNRH7Z9j40IrwW3u2UGUbnA7oSLIcqDk8w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RSog5eegOHaQ5sYxSqEDN6+Lmpy4tFbbOWwo4f1z4jVWVLakFpO8xDVMPr8sFLFnF7ma6R+do3Ry93Cvx0l3tPh+STYXD4c1DYdULMgROpVBiEwyHaxTka8v9U7TDsM8THxq/3o+XsT3EFuGB3gEPCPY2+07oSxKUxE2BNi4Mwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbF8Q68l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHG+FswB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbF8Q68l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHG+FswB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770757625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SH75Lcn0Bk0i3INWSVd804url4O7Trp8bwYcgcysUxE=;
	b=AbF8Q68lD8rYTI1wgYOhEGE1tSWuqFXSvZcCbZlA8HyfVBF77hxGlKM0+PluvlnOACACu6
	zisOtWMdTiCNaM2m+6QKUskHeppvxWg3EnGFHDqEOeO5vfcqrDHJ7aXw2yMF9qvEY4KpoP
	67TNuOVYq/IqxhO9IeykSltC5rn4XXA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-ROjo-TaLMhCfuTv7aXf-7g-1; Tue, 10 Feb 2026 16:07:04 -0500
X-MC-Unique: ROjo-TaLMhCfuTv7aXf-7g-1
X-Mimecast-MFC-AGG-ID: ROjo-TaLMhCfuTv7aXf-7g_1770757623
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45f148c7fc6so4576219b6e.3
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 13:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770757623; x=1771362423; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH75Lcn0Bk0i3INWSVd804url4O7Trp8bwYcgcysUxE=;
        b=OHG+FswBsnytb6Zca42uci+Fq8t2kJ7VeGB+F171KGYv5amD/Hvr1xR0sqSOVhrem+
         GLzCcw8UzvbnqeMyjRnXDr9GLRnXlJOF8S+BLpIguNL/ksD9daTZuz128HpahBdyBovM
         +E0om221Bd9txJtZnc0Wjpu4n3NEUJ0FlloqrJdt0OBCdI+Db17BijZEAGKVvYGOp/6F
         1lxSCpWcDx32fUkU2Pbo9NEMZg5sS0xlvGnTVCRjIARQUSaTu/TmAXIoVoGBFe/B6zym
         le9iDfhH0u0FX0tabUPsFIP1RDMbLDl9sP8rMvfJNVCWBy/PNwnzDuqIRzVhl9sN+nvy
         seog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757623; x=1771362423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SH75Lcn0Bk0i3INWSVd804url4O7Trp8bwYcgcysUxE=;
        b=uZzOfMktfmjQtuAxkqaBiLgkg0tR4Kc4et6dSw7HpIOoSkPX8V3W1yLSbhJbArrVd4
         q1/KikpQSqvw29irM3+zrvVx3fsw/mg+fXYpFlv/9692Hu9k4i/xR7z6TN6QPu/h6fCl
         R+E/LbhCnl9c093A7vzVN5pV4+SaSl5GdvzWdVfGj5szc3eY17obSuh5ttpd9MtdnvaI
         cIHpBGG/4vu0KH+DhQr/j4l7d8vItEtvzXh1sbgAskWewsdCSSMDgqv5adh2Zk0u2xH0
         wvuVgyRpn9kKd4iR8POL0qJ5ehPUlW8qDCVDsOdmg5uy/ch+CrycxRPJwsjSywpVoava
         38Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVbpzUmijn4tHo1iNRwDqI8Of0HX0tnUEApOWByseeeWBMx82pTRpVLa2VoN67i2UH2M3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWeslSHuzrzpseb8vx/EAmgrmxJO7IKOpCvtMFP98z0ejY5dXx
	5nT9JsgpH2t775mX5AxHx5QWElGHY5XSlt4DZ8iwjk8DpklqD0681IPxpzyHOS9LISTipISxRxF
	JMPbqDVF01ijff6j6HjtDNyrYOGVk2XsUsniJJiztJXWjigR6hddLfA==
X-Gm-Gg: AZuq6aIACcvO0zm/AK+Ebfy6PVBPW1Cjkr+mz1iyd4FTYLXGRSZFiCSucUnf9r4FOma
	hVxOzRwg+MHkN8EgYJNbDaYO45f3RfOpWAtKWsC0eaH+g3OXIIzArv33MVbIDKjeuHu/cVRh+Gp
	MUuSO8mqXshMgtcfvgzXvMkIO3nE/266l9pIm3s9uSHdBNPvC2NYP9ek3U7n3F8WPEMEJso3muH
	g/mFBu9cUjHGCtyHVusYFQ0/io/ZVxnjyHjUenKkXLxhz0pgbn9SVfUEDyz+ujFE3WfcympEuL2
	phO8kl9+gfkt7dN2ID2gEveudS2trpAM5uPusfqk04otfPITurcUHAMCULO6mIMLGEbIsSLSlJp
	Nq4xurZyn1gkXopPPPjGdloUKUW+iRvfNoRpIrhoCxfYbg/eV8Ow8cw==
X-Received: by 2002:a05:6808:138f:b0:45c:a3bb:ad8f with SMTP id 5614622812f47-462fcc8d431mr8555914b6e.56.1770757623521;
        Tue, 10 Feb 2026 13:07:03 -0800 (PST)
X-Received: by 2002:a05:6808:138f:b0:45c:a3bb:ad8f with SMTP id 5614622812f47-462fcc8d431mr8555902b6e.56.1770757623252;
        Tue, 10 Feb 2026 13:07:03 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462fe9a12f5sm8999355b6e.5.2026.02.10.13.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 13:07:02 -0800 (PST)
Message-ID: <95b45cb5db8d3f3b8202eff5c754e4c0c95769de.camel@redhat.com>
Subject: Re: [PATCH v2 0/4] tools/rtla: Consolidate nr_cpus usage
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Wander Lairson
 Costa	 <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>,
 John Kacur	 <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Tue, 10 Feb 2026 15:07:00 -0600
In-Reply-To: <20260209092436.2899888-1-costa.shul@redhat.com>
References: <20260209092436.2899888-1-costa.shul@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-09 at 11:24 +0200, Costa Shulyupin wrote:
> sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
> cpu_possible_mask, which is fixed at boot time, so querying it
> repeatedly is unnecessary.
>=20
> Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
> global nr_cpus variable initialized once at startup.
>=20
> v2:
> - Add `#pragma once` in timerlat_u.h to avoid redefinition errors with
>   pre-C23 compilers.
>=20
> Costa Shulyupin (4):
>   tools/rtla: Consolidate nr_cpus usage across all tools
>   tools/rtla: Remove unneeded nr_cpus arguments
>   tools/rtla: Remove unneeded nr_cpus members
>   tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
>=20
>  tools/tracing/rtla/src/common.c        |  7 ++-
>  tools/tracing/rtla/src/common.h        |  4 +-
>  tools/tracing/rtla/src/osnoise_hist.c  | 26 +++++------
>  tools/tracing/rtla/src/osnoise_top.c   | 16 ++-----
>  tools/tracing/rtla/src/timerlat.c      |  9 ++--
>  tools/tracing/rtla/src/timerlat_aa.c   | 11 ++---
>  tools/tracing/rtla/src/timerlat_bpf.c  |  5 +--
>  tools/tracing/rtla/src/timerlat_bpf.h  |  6 +--
>  tools/tracing/rtla/src/timerlat_hist.c | 62 +++++++++++---------------
>  tools/tracing/rtla/src/timerlat_top.c  | 47 +++++++------------
>  tools/tracing/rtla/src/timerlat_u.c    |  9 ++--
>  tools/tracing/rtla/src/timerlat_u.h    |  1 +
>  tools/tracing/rtla/src/utils.c         | 10 +----
>  13 files changed, 80 insertions(+), 133 deletions(-)

Reviewed-by: Crystal Wood <crwood@redhat.com>

-Crystal

