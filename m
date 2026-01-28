Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910042AF1B
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769562688; cv=pass; b=c3PFbf4KE3+CDVrZuCFXLkHDGbz+mee/bqXG7+LFsB/1RI2hfySJoEUawwb3gYOWPDEZ2Mgz1bb3dK9SE7RPeBdFIO6fMG9NpXCUnhT5t2mt2pdEelUL86gPia/wDcAzE2phO7EmiBAJJhaICch7oJgbnCp1122RPgqsXKFhkWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769562688; c=relaxed/simple;
	bh=NGRqEld76sUAA6KZHQ+QkQTEws9mMfIFD0LAdv1mXiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAKL2OM12V+RqiW5y2pPLy+zwhpq8+I1tyApS1ByrtGjgLNMvw8YEGVjWDUZOkkhGq1E282/W3Rluet4mylnfIsMu2KnL0ZcTClSFs9cI2kcP+QWLdJMEhjLcMQBbxOwEI32ZKRXrj/uJmBrTKiONMI0//0gOEP1Ho9FYd0MDM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4BVqUz8; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4BVqUz8"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-93f5774571eso1631555241.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 17:11:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769562686; cv=none;
        d=google.com; s=arc-20240605;
        b=NjdYP0x8NF8mn0F6hn63JjKKsS1KnTQb4AgGxBO7DcqDIZUW1uv4ZW0120Aw6VuM92
         UUa+Ge8ceuDXHF3KiHUfgauzJvypNtPpYPB1FJ4DT1G3HXQBAvSh7UWXZW5U8tg2B+yh
         +gxaY/KjjJTV6Plq5juPepdAOqhceAHkgXI+fDsGP0uAPuTdtHwXz3IiCBqPdZVCk6gF
         Fg2bdR8rM9WlAF7zZQeLDiQgUxsh6XNnlFxTugyybbcWw50vxvpQPBz1VN1VJJIdUmTj
         83N98lCVop5CA7oNVPpI9kiqP1qN3KwbmI1LFo52Fzk5X1JZFDXP5XJR5GIYB7V0OvRo
         eWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NGRqEld76sUAA6KZHQ+QkQTEws9mMfIFD0LAdv1mXiI=;
        fh=swAWWsj3Hs73RpxCPxlbiKdXoAa/zCTpuCXtRLFYHc8=;
        b=PyTTPshgUri3+rL+Ttqq5qBBfoloYx1ltPME595DVHI4Cw7AV3X018hO7s1bCgJpQ1
         DvV4apwk9bpoFPp6hAgy2Rs+7OIy1+1oCgAY2ygJcHMipBsW8D4XD71PkyOFMThThARD
         VxVE6jFO2oVsrWy+4jAoXobz6sWeA8jTWbmwlGj0LR+ytvxrtuntZuIiOK19qf2gQqEH
         42oaERurCRDNk+p+K/ma2lnmWG1dRH5olcxC/ec08klWrIlSEjbuY8a4olOMnMCZ67r+
         5l3rM00T3KfscneeA6Yfb+v7yjXXdBpkYoyrNkL69sZhGw7y5WOTtMWWzHg+8l44VUVK
         vSuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769562686; x=1770167486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NGRqEld76sUAA6KZHQ+QkQTEws9mMfIFD0LAdv1mXiI=;
        b=v4BVqUz8nr4di40UefXyotzJIBr0R5QNpHb4pIMiretwruaIKvg1skmD3avncPqfKf
         B+caRYxU1Dua41JjvSAIfP0hiSGXfTdQrCLiKXhjYsesuslFiqYEffViGPAOSYhvsLK0
         NcgktH/JX/HjIF4X5nTBrvw+5tAK+5x/K7BunL45UuljgVSx5qDfOaduzRhLWlTAMXAo
         G5Gf1tPJo3Ov1Z5ctJxmz6ot3LRJthjh/U8WXSTX+tSO7wz+YNW4cjIcaa8A7zMY/Tfd
         BQMqRiGO0gM6wofjIcbNE1W8wY/n/BQkp4rBQ2yCvV3Biec6vRDr0N/v1hHljUbEJdhg
         V0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769562686; x=1770167486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGRqEld76sUAA6KZHQ+QkQTEws9mMfIFD0LAdv1mXiI=;
        b=bG/LlbjcxLMTVjTzC1BkxXMq4F/gAN7tm0ef7IOX54qhkv4g3ddPYVohH0BKqg2d5t
         ypzymvzd5r2FUzYMAviq3Jy4NScnDpssLJpYEY9WqqOJAIjlot+vTyDvuhhh9TOnbbX9
         tN4i/A7AP238i9k3VnkEpxuOrhZ1EsJKxAkErTHu8ocPUNTBBzhu4ApN/0hTJY8MUfyj
         +s3A2A0E0TRGlvsRqVvelBq7bZQvcmddjw/cDM+DgDE4CLYXaDsJRnxhgsFB/s2hP4IA
         T4BIlXtIh62B1h35EmurWRwkQyH7Pryd9SumZhys+9FHVmUQ6D4sNN3aUQlQRbQNps9b
         HMnA==
X-Forwarded-Encrypted: i=1; AJvYcCUI5vcH6iju++MzwHG1aULnZQvSeYNmwsNquQ9XrJKuMCJ4xqOlnYkkUjDuUUlOxdwEjF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhS5znt85orv9uwX7jzw9DlkQEMAGaJgHLTiZ14Iyd4PAmOEnf
	ymQ9s8pCQPDn3mZoBUPTmu5F15lzvtERgv0zOWxBE8tTXyV0PgB9gxcJYez4FdEJKH8c1vFAeeJ
	g9UXWk7OvhHD0vRKlmNieVWyXHhWX0BbIuqICeabj
X-Gm-Gg: AZuq6aLNAHxheNqdXcOTHzpV8h5hlhFMUIb0emH6iOqjuuq0M7qYLkQtryYldyz1y2N
	812pGn86c4yCRD9X/spfaOwroinklzCP5qc8WXcXHA9A1GxJED0BNBDO+E0cAHH1AW2neRdtUKW
	sv5hphnMbqOIheXc4R2mtMPgECvlLC5W2kq7i2Wp2kVr9idk53Mm9qT2PJ0rVm88c6ecQ4vBCfg
	H/uEuDX7Cu+zC+pl1RwnsuSDoPENMjFeqZDfPkwgpzx6NdiVJwaf+SOLeSu0Ni/4FFS1n9Y
X-Received: by 2002:a05:6102:dd0:b0:5f5:514f:4e59 with SMTP id
 ada2fe7eead31-5f723789011mr1436257137.27.1769562686167; Tue, 27 Jan 2026
 17:11:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
In-Reply-To: <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Tue, 27 Jan 2026 17:11:15 -0800
X-Gm-Features: AZwV_Qj1esr5IjrxZ0Fx-OCbxI9auwLPJ6HNBXtxJ0-2VrxjtHfDZnK1qLblJWo
Message-ID: <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrii,

> > On Mon, 26 Jan 2026 16:02:10 -0800
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > So what we will need from kernel's sframe support side is just an
> > > internal API to get stack trace, similar to get_perf_callchain(). But
> > > it will be guaranteed to be called in a nice task context. No NMI, no
> > > irq disabled, no nothing.
> > >
> > > This shouldn't be a problem, right?

I raised this concern with Steve last week, in the context of off-CPU
profiling (e.g. https://www.brendangregg.com/offcpuanalysis.html). I
maintain a BPF-based off-CPU profiler that runs out of the
sched_switch tracepoint. It acquires both user and kernel stack traces
via bpf_get_stackid(), stores their stack trace IDs in task-local
storage until that task is rescheduled, and then uses those IDs as
parts of a key into another BPF map to store the off-CPU data.

The context switch handler is of course not a safe place to block or
page fault, so it wouldn't be able to acquire a synchronous stack
trace anymore. (It's possible that my profiler is missing some user
stack frames today due to some text being paged out, but presumably
paged-out text isn't too performance-relevant anyway.)

So, as far as I can tell, my profiler would need to hook into this new
task_work framework to acquire the user stack trace before storing the
results into the final BPF map. But a profiled thread might block
several times in the kernel before returning to userland - I saw one
block 53 times, just looking through one day's profiling data - and I
don't see a straightforward way to store data about an unbounded
number of blocking events in task-local storage until the thread can
wait for a user stack trace.

Do you have advice for how I could handle this under your new proposal?

Blake
