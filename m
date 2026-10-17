Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36643F4C2
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792235007; cv=none; b=U60PZVY1qg67t5tnvh/a4UCftN4rJAZX+7M6H3jvgdmRHpZH7MuEfk0iMN4m3MT0lRIYzDuzf+/XGwVgebCqSYp3xbnuTTgo6mZ5/P62zdBoe4+ld7eAAYNdnA+Df07JMnqe+b/G/MWopfpk9+SfjLZCPPPH2ScPNeQHlHaVAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792235007; c=relaxed/simple;
	bh=ZfdFL+mOgr8C5/Q5zBQQ/lVzqfgyNXnS/9dewaQPMiQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=g4BScsd8Y9FF19d33phGax5Alt5ukU+znJbu3PETQsYUvdhtJyD4row6ZI4GAQZAUpoMwvfzUsjeTUGGsQCAwIb++dFUJMCQMjrud5L0MzqpPLHvyqQbw93UuHMBuuJJyz3bj+2X9dvkz40iDTxfOy9msqc4MJXeZCoLJqTDi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MboZPP5B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j57Plmlr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MboZPP5B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j57Plmlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792235005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfdFL+mOgr8C5/Q5zBQQ/lVzqfgyNXnS/9dewaQPMiQ=;
	b=MboZPP5B4KBUubf64rj8/J4RM9oZ8hRBtMR+0g/8Wk5YKm+rW0E1oOIqy1R+7UutkkTh4L
	3+GOb6WU46DLd2m5JR8kbK5Rc+x3VOl35t8c7Qi5FtjdydOQegBgdyQNF8sc5NcvtK13pB
	NhoJhX1FuQQrJysIBH73kVMswjNKHvs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-wsrSGXhIPUSVnDDSLAK0Fg-1; Sat, 17 Oct 2026 11:03:23 +0000
X-MC-Unique: wsrSGXhIPUSVnDDSLAK0Fg-1
X-Mimecast-MFC-AGG-ID: wsrSGXhIPUSVnDDSLAK0Fg_1792235002
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so274427f8f.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792235002; x=1792839802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZfdFL+mOgr8C5/Q5zBQQ/lVzqfgyNXnS/9dewaQPMiQ=;
        b=j57Plmlrj5Dex8EbJmEMzgHh3/3Ui59HX5d0utzFWQmIdMSoCwNW8IUekstQ82J9Qk
         /7BW/UyuUv1I1LvotQOdCly9TjqoOrr4F1qvbJjPBJodI83dyINHdkQW50un/YzrP30g
         ZjhcgMb2Guf0Red0rBAXyTg7OFfdKRYIxTWyLVr0e1yCVwJR0OJJ2ojNx4Px8NVtl1Yf
         yIy4iyL/g3RDIXaYeFElS0H4Ou2SMmkunW+IwEKznOeHNr48neWv0gguswwmhPOoQEyz
         gDRpObvs8GQS9y/X1rh8S41YQ+Mj7GGDM0ZmoYJS+ycxGd777vqf75zKkEspCiQLy7Gz
         NAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792235002; x=1792839802;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfdFL+mOgr8C5/Q5zBQQ/lVzqfgyNXnS/9dewaQPMiQ=;
        b=1TWlDSLTRwg0CDGaTkGs7s3liZohNxuAKR5Hx/EdD2J29x3/R9m3zS/dFLfgoEN69h
         ltfw0mvCP2eTw084re/XT6v+SODJx6guC0vGwZjoAlsscKjFjEqLSyoW2nECRpv4NhS3
         /GL85Fqu8dZvlT5hOhoUPsvknlMei3qf7NqZpu0RGnR/2Z5/xasEyPXdP/qq7HbuPrIS
         W/KoeLrpoIqdq2DCFR4NCi5xgfg5QaQwLIrx0tY4XWr9/JW2EalV5IS7uzZORZNO98cS
         iVyTPvWCf7T945/vmbyP2upMDG7ZlqpeZRvRB8euzVIPGYPJEEhIJx8Kw/LsX6xWSc+k
         gBQg==
X-Forwarded-Encrypted: i=1; AKwUvBwuKOfFxUqxeL1kU9U95ntyyO/mxSCvdRTmVRZPt7nBq5+dv327GLPxzWmfYh1WX7Xu3PE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKl+T7BbJ/VIKY4njSRLfPoL8Kjphb50cnbrWhBU0FTgmTVlk91
	fT3yvyu+bD9mWk4jn9FzqQggetnbUsb2aMnO9VSHrTuw2AUNMxYfjPntvm17+8J5Fv4pCMarWXT
	AB239HM0RnDWhSubkywE4tvWIw9xcAdqQxLP2W4SVDnJAWYlQVTVt1w==
X-Gm-Gg: AYBFou0Af8EU6Ml8x5FW3jwSO4aqTeVLswGBatb/tSpd1FN+PUlF6V1GUYtX8BOkR+Y
	uFYHeSSA2hVk1YAdycCGBbaedAC2iZAodXZ875lQDBodO52QG184S9FXNXcy54CgXj5SW+zgnTA
	EM92lHWZTXvDVjJje7UGnip0xzbU6trB+2ahkV98jmMcN23CuseNUkySwXHdYCPH6PGdir9zeO0
	6uKiK765e/5dWvd5wfgf3rXFxCdPmRPIgPhPZBXKTVfo3IZzDZZAc98MeXyGqdJntgw/9cziEby
	SkMMweJd7+ma9fW9LTGHBmKRxBpqY0XqgpUOQqD2rLmhh6P55g4j5M5w28G7u0rodcgfTa51Tvt
	iQZ/SwHHC
X-Received: by 2002:a05:600c:a4b:b0:4a0:eae0:b30e with SMTP id 5b1f17b1804b1-4a1d7604051mr52205215e9.22.1792235002059;
        Sat, 17 Oct 2026 04:03:22 -0700 (PDT)
X-Received: by 2002:a05:600c:a4b:b0:4a0:eae0:b30e with SMTP id 5b1f17b1804b1-4a1d7604051mr52204745e9.22.1792235001686;
        Sat, 17 Oct 2026 04:03:21 -0700 (PDT)
Received: from ehlo.thunderbird.net ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4feb6bsm11345521f8f.41.2026.10.17.04.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 04:03:21 -0700 (PDT)
Date: Sat, 17 Oct 2026 10:48:30 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
CC: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>, John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com> <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com> <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
Message-ID: <5A1AB76E-E338-4B88-8FDD-947BA0C5A294@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 16 ottobre 2026 18:32:44 UTC, Alexei Starovoitov <alexei=2Estarovoitov@=
gmail=2Ecom> ha scritto:
>On Thu, Oct 08, 2026 at 11:54 AM Gabriele Monaco <gmonaco@redhat=2Ecom> w=
rote:
>> Reactors in this patch use bpf_printk(), which is in fact a trace_print=
k()
>> instead of a real printk, is there a technical limitation forbidding us=
 to
>> create a kfunc using some flavour of printk_deferred()? Or am I missing=
 an
>> existing one? (this need was brought up by John, Cc'd here)
>
>No technical limitation, and there is no such kfunc today=2E
>printk_deferred() is a lockless store into the ring buffer plus irq_work=
=2E
>It's ok in any context where tracing progs run=2E
>The closest we have is bpf_stream_vprintk()=2E That's stdout/stderr of
>the prog=2E User space has to read it=2E
>rv tool is around for as long as the monitor is loaded, so it can read
>the stream and log it anywhere like /dev/kmsg=2E
>If the message has to reach the console when user space cannot run
>then the kfunc makes sense, but using bpf_stream is imo much cleaner=2E
>

Thanks for the answer, I'd expect a mildly higher overhead in doing that, =
but since it's only on violations we can probably accept it=2E

I'm going to have a look at that=2E User space should be able to run for a=
t least most models, I'd say, but I'm not sure how fast it can pick up=2E

>> Not needed in this patch but potentially required for more complex moni=
tors=2E In
>> kernel, when timers are required, we allow monitors to use hrtimers (pr=
ecise but
>> heavy), or the timer_wheel (lightweight but less precise)=2E
>> I'm not aware of any wrapper of the wheel in BPF, but I think a few kfu=
ncs for
>> these could be useful, in general, also for other programs needing a lo=
t of
>> timer instances or simply light timeouts=2E
>> What do you think?
>
>I don't think it's needed=2E
>bpf_timer is hrtimer only, but hrtimer vs wheel is not where the cost is=
=2E
>bpf_timer_start() cannot call hrtimer_start() directly=2E
>bpf_async_schedule_op() does kmalloc_nolock()
>and irq_work_queue() instead=2E
>I don't think timer wheel will help=2E
>

Alright, I'm going to keep that in mind once I get to work with timed auto=
mata=2E

Thanks,
Gabriele

