Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06236EAA6
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930467; cv=none; b=ntqF9XrSZo4tN4pG/eyGa9eAeH3aLI/11PYXiRMmGy6wiZe6tU4L2IxZDupFwPTWe/75+/uLt5iv+Vhe7g+mjM5HZ5MBLT3+DAHZo4ZeYUjsobxeGaPoFMfLJ8HmD9a/NI/xNmaonTKb4kY8T00LZhPIj8sT12UkVvdgRRX+pRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930467; c=relaxed/simple;
	bh=itlwroz8zq3rrKw5ID0e2txHQF7Ba8eb8M9E4oymWr4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIeEfxWFul2oiArSKRRtlmK0c097Bs/kHiaKxy7dUFBIfI6T1FUf1cJFuSh02dBsh+WMeWP70h47pVhVnbOWM+gADA6OeDGjI/oSUCLrrI/huGo8YpD/+hAPqacmHH8uEMreIhwHR8IuDtFGv+xoHdZE1fshQjvUCFAcS+hrgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjFJHNFA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjFJHNFA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso46671715e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 02:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771930465; x=1772535265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7cNM89iJpxcTWpK7A5R0HtR8bYFzJ1NGRRKXJQdBQpA=;
        b=MjFJHNFAQzyYwKdgT4ZXPU4h2GLeX5gqom8XtaBxmcEDdKz+tgKHzihDb2lEtCd0ne
         EtbfzE00z8I+xdDtPGJsg0pcnDdlRcBdIuOah5Qua41CFwfzRFludTO2tKOc30+2+cs0
         CQBmfV5RI/IhF8qBleb0e8d34hpCgplaYpOj4BwSagMrT7VdNoIi4XwDhpoonLWk2pnO
         Gzzc/1UZY/ePtvEHUqXlD4PFTlR8rbQnYP+QkMvNuTVyYWOHYBPieHfW15kTAR7R2yz3
         XORwQMYPuQ5RNStNhYS7mK8ImN5mk9WCvb+hXDBtSkH4OTfKJZcX5O4z+9iMSViVRXIq
         Od9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771930465; x=1772535265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cNM89iJpxcTWpK7A5R0HtR8bYFzJ1NGRRKXJQdBQpA=;
        b=YLpZZ1ZgJbXxGEoIbnV7url7YvqTsqXhXD/ThgbDnsxl9WBXwF7H2/hrrM/KtguLs8
         1vpax+7oyfxPY818ONZrNDt3wbQ7vwChzz0nMdM48o765G+8d1E4jrlhyWaakG47vFyF
         +boiucASjf8RkoRRh0vSJO3w8l9KoQXrnPAq/0qGwuolvVcBRgX2ih8DSKf7u/T4I6G6
         j4DDIirlgXE9h0ry//Dlhn8YkUPgV7maapBEvPowh6UdHqmgkBPolJZRly9ev4uNwTe6
         Vz4TgmIuWet2ti089xf+cQBrKqWSI3xpZlJBLGRviwXavv64Sg726QQNfSlXq+C+PWqN
         9j3w==
X-Forwarded-Encrypted: i=1; AJvYcCWIP0lQxc04LMKU1JXkkzUlksvF2dPTb6oJ7uDKfL4btYzySTN1WJdmlq3aTE8CE/9mWU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/rz92IQaYwFHr5EcYvJaEV4hX3Lud/HoTdrqPbdFKFPu19C0
	JbtlxDGD8RNOZJnJ0rRRJM6BgLyOxJFMPbVcPzPz4f0bdrX2gcrGh1CV
X-Gm-Gg: AZuq6aLJCLwuAVh4ryV21V3QaUx+ORjoaALBl2cgu1ab4uWK8jiykcmm8oq4KFQ416b
	G7atL/XrhVdvAO49xuHwpJJcX3pbufNzeMZmwD5Ul1bW6n2/p0KpOcXU/DSD00loTG2QHWa0wfI
	ZNmvnqPqncQkN3renjj/w75k87iL33wkTQ1U++3MQBhSdeSO6WF6TmATgYublVRCdpsIVjlrhmT
	7hUAz6nPcyIBj2QYPqsr1PgdKfO5V8+oqXO8IniSCAGQ5Tngt4HO4vJetiJ9ja/2FGkCeDWtJis
	LAZBXgzjZnPFN3GXdM44YppZponsS9PiK45MWfIqrBz0DSIZ9bh5P93wGko3Qj2MkSG/mgk1cT1
	iKpi4nVA40nhHUGF+8+ADWkDgqy8qjAGSIbjQb0WsOq6N0f74dze/1Yza9Dc7FjXxYVXfa3FN
X-Received: by 2002:a05:600c:314a:b0:47e:e20e:bbb4 with SMTP id 5b1f17b1804b1-483a9637a24mr169617215e9.26.1771930464514;
        Tue, 24 Feb 2026 02:54:24 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b82203c0sm17321725e9.7.2026.02.24.02.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:54:24 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Feb 2026 11:54:22 +0100
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [External] Re: [RFC PATCH bpf-next 2/2] selftests/bpf: Add tests
 for duplicate kprobe symbol handling
Message-ID: <aZ2DXhDKG9iS4Rcm@krava>
References: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
 <20260218225617.354858-3-andrey.grodzovsky@crowdstrike.com>
 <aZwbhsJ1PgL21oXr@krava>
 <CAOu3gNhZrtgVU=Vt-Eu972RL0fh9j1BRRt0QYjwN7QnfGQAjaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOu3gNhZrtgVU=Vt-Eu972RL0fh9j1BRRt0QYjwN7QnfGQAjaw@mail.gmail.com>

On Mon, Feb 23, 2026 at 01:56:15PM -0500, Andrey Grodzovsky wrote:
> On Mon, Feb 23, 2026 at 4:19 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Feb 18, 2026 at 05:56:17PM -0500, Andrey Grodzovsky wrote:
> >
> > SNIP
> >
> > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> > > new file mode 100644
> > > index 000000000000..98b3e085ae90
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> > > @@ -0,0 +1,45 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2025 CrowdStrike */
> > > +/* Test module for duplicate kprobe symbol handling */
> > > +#include <linux/init.h>
> > > +#include <linux/module.h>
> > > +#include <linux/kernel.h>
> > > +
> > > +/* Duplicate symbol to test kprobe attachment with duplicate symbols.
> > > + * This creates a duplicate of the syscall wrapper used in attach_probe tests.
> > > + * The libbpf fix should handle this by preferring the vmlinux symbol.
> > > + * This function should NEVER be called - kprobes should attach to vmlinux version.
> > > + */
> > > +#ifdef __x86_64__
> > > +noinline int __x64_sys_nanosleep(void)
> > > +#elif defined(__s390x__)
> > > +noinline int __s390x_sys_nanosleep(void)
> > > +#elif defined(__aarch64__)
> > > +noinline int __arm64_sys_nanosleep(void)
> > > +#elif defined(__riscv)
> > > +noinline int __riscv_sys_nanosleep(void)
> > > +#else
> > > +noinline int sys_nanosleep(void)
> > > +#endif
> > > +{
> > > +     WARN_ONCE(1, "bpf_testmod_dup_sym: dummy nanosleep symbol called - this should never execute!\n");
> > > +     return -EINVAL;
> > > +}
> >
> > hi,
> > this fails to build for me:
> >
> >   CC [M]  bpf_testmod_dup_sym.o
> > bpf_testmod_dup_sym.c:14:14: error: no previous prototype for ‘__x64_sys_nanosleep’ [-Werror=missing-prototypes]
> >    14 | noinline int __x64_sys_nanosleep(void)
> >       |              ^~~~~~~~~~~~~~~~~~~
> >
> > jirka
> 
> Hey Jiri, ran i on my local mirror of CI repo  with latest rebased to
> origin/bpf-next_base with command
> tools/testing/selftests/bpf/vmtest.sh -- ./test_progs -t attach_probe
> and (arch is x86) and eveyrhing pass.
> Then i also ran in guthub
> https://github.com/kernel-patches/bpf/pull/11138 and the only single
> failure i got
> is during runtime is some unrealted test failure.
> https://github.com/kernel-patches/bpf/actions/runs/22318486040/job/64571209293?pr=11138
> This seems to be because of me defining sys_nanosleep duplicate
> without static qualifier and so if your
> local build has -Werror=missing-prototypes,  this warning cause a
> failure? Do you think we should
> add static here ?

I think adding declaration will fix it, but if CI is fine,
it's something in my setup.. please ignore, I'll check

jirka
