Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8639A800
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938391; cv=none; b=DPP+Jr/bzvc1HryxdgZbtvzCMGUw2y4yDXE4/roN/SPVo8NVdrrpk9eyMtZrF8anIFhVZYCBzVont86f2gfE5eR40Myr/LqH/671JRX18nsPpT9BWz8tPLSVIfhfe+Eg0fowMkhBS7G2xD8SVFnWIS1V90whjLLL4l220CLqJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938391; c=relaxed/simple;
	bh=2xPoYMNjUSes2lQKq9h/JLqWNjgaw6rqtM8ZvG22mOo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O218WpVV6VWuZGo+HWJGgpH2uiZmtSiLjWLAso30QRs1/inLB2rrVYWhhDbqbH5WIo+hHYnpIQvB6lryoLNrUKsSVBnEcpSgNRzd8hSqRjwqJiZ5fNVtHUnqo1WRheDAUyhOOxLqTx09cIDVkJPmsn71MVGwCI9NjeL8fJZhq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxTW95YP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxTW95YP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso48038135e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 05:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771938388; x=1772543188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i0gUfyZOYIhgH1x0+goFc6QziEoYeTgCpw3mPbS1TY4=;
        b=dxTW95YPRccAtD40xgJj9Yv5tM3zYvOeG1CtFEqkLfyXYbmqsSeW+a2mRxy/uF5igi
         D1ftOpP+esXisb1WhT3ia4GZFN7ZkjlvwLXxpD3z+WTpy6SDzB/K+q06jmmfyFQr9LSV
         atGF6Gpcvh8thIjFJlcF7rTo+DFs5l5XB0bUcKUdIM7k6VMpqWNjEfrEZQPCJZHHzEc0
         oKcXTzH618kaA5IlAgXWFaW7is2YAaMRcvodUNjIxigESF6W4/pQvy+lqZ4OG/glUVa6
         09hyIa60lBvQSzbPvLerp9mUK3Eyvvz4Bi+79VVLbgzVm9+c2+VISENZZ/oTzR1wg6L8
         i2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938388; x=1772543188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0gUfyZOYIhgH1x0+goFc6QziEoYeTgCpw3mPbS1TY4=;
        b=QGJ0Nlr5ABfdHIlsduR7FfnBSVEJMp+E5Yxc5G7jj8kGJPjhINHqEJ8MogDMvoYIWH
         /0noLKW9mXxljrH47Dz9Om3VyBwEcq95Wz2dnW9qa2LSZdxRqXRDjJW5hZNBGbyYQ7WW
         kwBlgy1zyHgG84X85bt6XVl+NqLgLRHxag6PRK0GAPBlFXfkwJrMAkaYY3R0N7eNa9BO
         xrDlc9Tn4XqdFh5vfxJnhCfmnBHtJCSvFz5ZXjMZH7mitnSWqDxnAQ9lsUFCegmPQaem
         nv/+AbIEqE0+VPx9zLAdMfMIEbtKv4GgpewB6mRa1/F0068hhLqxymi630u7OAXpH/qi
         Aj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1LPnacQkmFruc24XwzqRZesx842ISpsD8T6fvMNPj4oyYKj45SrgCIC8J/QTrTl96i1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1tcZFi4jxsvI5Y67ZzkTWSSBuiuWjHfme6SZewz7iWVGqCI1
	Fyh6oLCp4xTQVux7ZTGT8jV9oaL9aJFrgZuizsIt5QsY/0Kmb6k0gxG/
X-Gm-Gg: AZuq6aLmi8zV3jh9WASJzq9zkjSGq4OY/taI74QXGTFrzxJTsWkCU1jbV72FnT0tGhN
	wXJ7WZT2/qwmaaSETg/IWZDc4vHbcfWznPLj/aSAF6jN2nFidsDXjkeia0Cbt9vSjdo2txJOjAh
	vw6qur7UVRGsfAA/A0SUAY+X9d1iu2FOh6bCV1S5/SJR9eEv9YnRqlpaSH+C4kaNLtNOLxUA4TR
	SKd7s1ZlIlfLx4ix/Q02ZA/a1ZKIFW3xK362ZQFKcvrwNHH84JJeL67FvaV11lfjbAxgV2om7wQ
	NlrmloiRu5Arq/Jn9fwPBUkI+8BBGyUxRHxPNSqxZep/JdaHMLd5ZQf18RjHFrhb6CcS25wmNQP
	RMznBJJ0ArAHt0K+6QtkMFai/YVjHqVqxVcA5bT1gcZAsB2Tz3EVuvPZIPZJjd1sQcWDJ/Opk
X-Received: by 2002:a05:600d:6409:20b0:483:78c5:d743 with SMTP id 5b1f17b1804b1-483a9637a19mr138106555e9.28.1771938388159;
        Tue, 24 Feb 2026 05:06:28 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b88f95a0sm17910645e9.14.2026.02.24.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:06:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Feb 2026 14:06:26 +0100
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [External] Re: [RFC PATCH bpf-next 2/2] selftests/bpf: Add tests
 for duplicate kprobe symbol handling
Message-ID: <aZ2iUnroUsOp3QQY@krava>
References: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
 <20260218225617.354858-3-andrey.grodzovsky@crowdstrike.com>
 <aZwbhsJ1PgL21oXr@krava>
 <CAOu3gNhZrtgVU=Vt-Eu972RL0fh9j1BRRt0QYjwN7QnfGQAjaw@mail.gmail.com>
 <aZ2DXhDKG9iS4Rcm@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ2DXhDKG9iS4Rcm@krava>

On Tue, Feb 24, 2026 at 11:54:24AM +0100, Jiri Olsa wrote:
> On Mon, Feb 23, 2026 at 01:56:15PM -0500, Andrey Grodzovsky wrote:
> > On Mon, Feb 23, 2026 at 4:19 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Wed, Feb 18, 2026 at 05:56:17PM -0500, Andrey Grodzovsky wrote:
> > >
> > > SNIP
> > >
> > > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> > > > new file mode 100644
> > > > index 000000000000..98b3e085ae90
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> > > > @@ -0,0 +1,45 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Copyright (c) 2025 CrowdStrike */
> > > > +/* Test module for duplicate kprobe symbol handling */
> > > > +#include <linux/init.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/kernel.h>
> > > > +
> > > > +/* Duplicate symbol to test kprobe attachment with duplicate symbols.
> > > > + * This creates a duplicate of the syscall wrapper used in attach_probe tests.
> > > > + * The libbpf fix should handle this by preferring the vmlinux symbol.
> > > > + * This function should NEVER be called - kprobes should attach to vmlinux version.
> > > > + */
> > > > +#ifdef __x86_64__
> > > > +noinline int __x64_sys_nanosleep(void)
> > > > +#elif defined(__s390x__)
> > > > +noinline int __s390x_sys_nanosleep(void)
> > > > +#elif defined(__aarch64__)
> > > > +noinline int __arm64_sys_nanosleep(void)
> > > > +#elif defined(__riscv)
> > > > +noinline int __riscv_sys_nanosleep(void)
> > > > +#else
> > > > +noinline int sys_nanosleep(void)
> > > > +#endif
> > > > +{
> > > > +     WARN_ONCE(1, "bpf_testmod_dup_sym: dummy nanosleep symbol called - this should never execute!\n");
> > > > +     return -EINVAL;
> > > > +}
> > >
> > > hi,
> > > this fails to build for me:
> > >
> > >   CC [M]  bpf_testmod_dup_sym.o
> > > bpf_testmod_dup_sym.c:14:14: error: no previous prototype for ‘__x64_sys_nanosleep’ [-Werror=missing-prototypes]
> > >    14 | noinline int __x64_sys_nanosleep(void)
> > >       |              ^~~~~~~~~~~~~~~~~~~
> > >
> > > jirka
> > 
> > Hey Jiri, ran i on my local mirror of CI repo  with latest rebased to
> > origin/bpf-next_base with command
> > tools/testing/selftests/bpf/vmtest.sh -- ./test_progs -t attach_probe
> > and (arch is x86) and eveyrhing pass.
> > Then i also ran in guthub
> > https://github.com/kernel-patches/bpf/pull/11138 and the only single
> > failure i got
> > is during runtime is some unrealted test failure.
> > https://github.com/kernel-patches/bpf/actions/runs/22318486040/job/64571209293?pr=11138
> > This seems to be because of me defining sys_nanosleep duplicate
> > without static qualifier and so if your
> > local build has -Werror=missing-prototypes,  this warning cause a
> > failure? Do you think we should
> > add static here ?
> 
> I think adding declaration will fix it, but if CI is fine,
> it's something in my setup.. please ignore, I'll check

ok it's just warning, but does not break the build, I can see it
in CI run as well..  but I guess we still want to fix it.. let's
add the missing externs?

jirka
