Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C436F435
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626568; cv=pass; b=MtN+gvb/0CfjGH4KfZsbsT0PQwrNnfR6QOwYbBmKiU2/na3x5E8FPqQ47v3W1f4e/UdpHhQRjAaEO5MCSzUZNKSeMuUQ/EsQhJXsn0Pz9qWwA4kl0NlK5/pGGql4Xh03G+HjUB64zcL0TK+fUOrpdm4Y5S00cEZts0q1X++NIGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626568; c=relaxed/simple;
	bh=GbjJME/nuQhCEQ+372mh5xTEDtjGu1hRDbZuxX2zZ2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phUzc6iucS/l2L9euM5/O5sq7NettV4GZdRmjSmuPdfW2FtelEO1a+nWjW5/FWNnOZJq4LE5sy31a9t3z1ZZH4gfVhsGlPpYV6Uar2QRobH24yxsH2XYbKbZsUA/xVnu5ZitRTO4UYHKmIYMBp8V5M5zMuGsSkSYuIbDQvKRfNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5WKa7Pe; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5WKa7Pe"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c3259da34so73628a91.2
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 10:56:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626567; cv=none;
        d=google.com; s=arc-20240605;
        b=G2OIjEat1kEUNV06Npq0e+CrEgwJK99iS1OunxM/F/EcBKhDkrK6e2QckBK3ViMtaZ
         KC6GZgCmhK4lSmq2acFpCxSKLpcXFXnXomoV8gGlK/DBFkIkEdn56rXoypRg6iK4H6xA
         Uw45uLuCQAocQCSo2hRT72MkWREugV8ri1umlh4CVQfyFkmONAmVnh9nFf4LC38V2xTf
         SESqjzq1clPl915/s8tPTjaob/K+lz352FnQrMhOJAtsw4dJKOVGv+q4vrsJ2TpX5H4T
         T7Skce8x9CVz3NnHeinwA+lncva6UvX1N3owsTPSoBXZcePBY5E0jXP9xH59aW0fPj13
         IMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GbjJME/nuQhCEQ+372mh5xTEDtjGu1hRDbZuxX2zZ2M=;
        fh=GADw2PuDHmMAX+f2KEaMBnXYoqfsIvq0WAsitInVS/E=;
        b=lX5MMYc3hLFi3qXkz4ZQoD5sXWjl0TbUPmEpvTea2AEpekGNs77/+CW7oY65e4PFL9
         2+KdMdDaJoEAlnOkepSitDKU4SJbMr1LGk+3cHMuQq6eUJ+YN9h0I2u4mwl09gz6bQJF
         LvgnQm/fabHGJVy7xyfgkWGeYkDgea6muIcZHYJ1UTOasXxqMT6YMpDDGPq1pXUk0aek
         Ps2xZOZwQFfW9tXKz3iimQdjpG5Ma/0FYWnLIVu083eTk8VK6w1JcD2gsxCWpcueITpF
         HVvhyCxWhPMlKqv9wHlBb61k6kPEozx468XtYVFi9pyOdcwL9VOe17xaGQ/GKdHD6ber
         4XkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769626567; x=1770231367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbjJME/nuQhCEQ+372mh5xTEDtjGu1hRDbZuxX2zZ2M=;
        b=P5WKa7PeIEq0XSFVsKndKWeqbSw/opIgiPQYOwK3Lg9WFhoYrmpQXLR5Is8yuOvMej
         NQ3l9qcC2yyvCVedJXPqJV2mSRyHl1dfQ5+WxQvGYy9iECxXwfeDe8uSUyrZN1Gmz5fH
         PAJx6PpqMm++cXMC/yNrNUW6rlDErLb8ovWBFld+acPBb/5hG+MZbZMdEY+uVUm4P7IJ
         Ja7EwTfjrt2XUBa+VrQrGQxfD2G2zGBiyFUbmBT9z0q6hOMrkIm5OimoAjYqLsp3+hK7
         UeybD8d2aDBpFYzkOO1nFymofT+5IGea1XjFrZ/eHzmj5JmehWnDbbWhFSjQYtC1qCWo
         gPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626567; x=1770231367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GbjJME/nuQhCEQ+372mh5xTEDtjGu1hRDbZuxX2zZ2M=;
        b=gY2v7wVP3i15ljSqfvfSOkFcCxZ3JO6lpoa2E/Y6ICuIVVIVZYtNmIZ6bIFbsZAckI
         KusOhTr0YiDhKmN7mCoevMz39FqAPcoyXAKfbP7otJfFUsHxHH+y6ts4CAQ+xldTERa2
         h1AgkAvUNeuvN0RZlcdrhSUcizX8+RGCuylRuMyoimNAZ6XwOcA8yy9Wt/5BmqtgnnKF
         nZrhNc9UQqoH42higOE2DPdCHW2ZYJ4Ea+iKHxrg9Z1oNYGm5t1WqkY5N0H1T4ucBNIH
         fliRmBJqcZeNA+VRmymQdOa1yfUzifoACDB8EVEmop7KbcygS/miZKAZnHUkDi5ekzyo
         nGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6UoO1T6ut1E4y3FUAPSFRXsDT6jlip6ckhzp9ueCciK0Ax7JQBPmUp3p4hup2YFQmQf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbqHDL2hTatjRtIrK3HTIdQrYCQha2VU7jTzvc/Yj/t9/CZKRU
	R+FS0EVo8DpRScfHfapVf43abb7GJXNqnCLsH3iqpLwC7I9ffr3xb/g/QWYiTi8YhuneTk+vePq
	AzHeq5qiofgSLO/K7t5Zrheg32cjHAgRw+A==
X-Gm-Gg: AZuq6aIWza0sAHkx/aokeAh84WQSMOziJkrBsn/V6/NHtBB4MkyzfYYJ3NcGqkT59W0
	2bBbk/inNs+Fxi/GZvlpjtU9gdkGSbEa2dtwJ3kHWXwDYknbMS/8gr+vzm8p9W19szvAImwnoZ/
	C+vN0SuSTnH7XCfAf1sOlYeRkFOmJSFVqmEQfJyGi4eglwCfuwNfTbY6j1euN7BzmHFVk4NgiM0
	ZS5W9CqMYvq+DZ7YzswE/N6B76h1NbAdU6tuIqzrbD8i9nXRDT7Kd8bQTpcW1mIwAVoV0zLGsiM
	byKKTShpFVM=
X-Received: by 2002:a17:90b:3a4f:b0:352:e27e:79c5 with SMTP id
 98e67ed59e1d1-353feda98damr4965562a91.31.1769626566865; Wed, 28 Jan 2026
 10:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
In-Reply-To: <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 10:55:54 -0800
X-Gm-Features: AZwV_QhZFUtlKhhmh1Fki3mfmzOSzwbZ9cKOopflLchM185a3ebkdwBRJU__k_0
Message-ID: <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Blake Jones <blakejones@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 5:11=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> Hi Andrii,
>
> > > On Mon, 26 Jan 2026 16:02:10 -0800
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > So what we will need from kernel's sframe support side is just an
> > > > internal API to get stack trace, similar to get_perf_callchain(). B=
ut
> > > > it will be guaranteed to be called in a nice task context. No NMI, =
no
> > > > irq disabled, no nothing.
> > > >
> > > > This shouldn't be a problem, right?
>
> I raised this concern with Steve last week, in the context of off-CPU
> profiling (e.g. https://www.brendangregg.com/offcpuanalysis.html). I
> maintain a BPF-based off-CPU profiler that runs out of the
> sched_switch tracepoint. It acquires both user and kernel stack traces
> via bpf_get_stackid(), stores their stack trace IDs in task-local
> storage until that task is rescheduled, and then uses those IDs as
> parts of a key into another BPF map to store the off-CPU data.
>
> The context switch handler is of course not a safe place to block or
> page fault, so it wouldn't be able to acquire a synchronous stack
> trace anymore. (It's possible that my profiler is missing some user
> stack frames today due to some text being paged out, but presumably
> paged-out text isn't too performance-relevant anyway.)
>
> So, as far as I can tell, my profiler would need to hook into this new
> task_work framework to acquire the user stack trace before storing the
> results into the final BPF map. But a profiled thread might block
> several times in the kernel before returning to userland - I saw one
> block 53 times, just looking through one day's profiling data - and I
> don't see a straightforward way to store data about an unbounded
> number of blocking events in task-local storage until the thread can
> wait for a user stack trace.
>

I'm not quite clear on why blocking 53 times in the kernel before
returning to user space matters for capturing user space stack trace?
Given we haven't returned to user space, its stack trace will remain
the same. You'll need to schedule task_work (see
bpf_task_work_schedule_resume()) just once and capture stack trace
just once. How you join that asynchronously (from the perspective of
the point where you called bpf_task_work_schedule_resume()) captured
stack traces will be up to you. You can send it through ringbuf, or
store in some map, or whatever makes most sense for how exactly you
structured your BPF logic.

This, of course, is not going to be as convenient as synchronous
stackmap approach you are using with bpf_get_stackid() (or, similarly,
bpf_get_stack() that doesn't rely on BPF map, but is still
synchronous), but there is no way to avoid complications due to
asynchronous nature of all of this new SFrame-based stack trace
capture.


> Do you have advice for how I could handle this under your new proposal?
>
> Blake
