Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23840395D8B
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123213; cv=none; b=WDQRuL9FqbZ9GDWXaZ+uK3KLpGyVW7CtRG0DVfrGK0kg6StjogZALvhuBVxgyVaeD09BQ+tzdQjVFeiHui7kCsJZ85UTam2AslQGbqJEnq2ew6DIV2UgK+viLctRW1FkuaK8sMCkfPbMBviFMVVSn78T1hxp7E/sDUvxbH6Jsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123213; c=relaxed/simple;
	bh=/6Wxpwh1Jw3QuzToWmSpaDn4Z6kHsjQxgV3vtD1wfB8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr5owgFMXkDa2V6vmM6+We5JK2o98sybtr/rRw8ykzTL/9N1flL3Nm3eA5bFeoJ1Xo1H5l3same7wAq3hDfpUWFyRbr93v6jb/td2VyR6zt+/WZCKh8vSrb0c2lDBj/bjL/zofE10WppsLTOv8T2VlgbilCWcrJ8fVaZID0t6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKLuRE48; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKLuRE48"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so6108465e9.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775123207; x=1775728007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xyst/4kmEsxgwGqDda+/V97Ys8/9T/NJBxPyHbegpPw=;
        b=qKLuRE48N2JAojAlolw2Tdqrv6Gyoo91vCG2ifgYDY9YZYe3FW0IKiaY3G0ADwtiIj
         7M2IOSqbzb9APo4F2kuq6bOKVpE0M05OwQNZL/LLRIlhTyrF+zf6UVAao0wSDDHUnufB
         tkZV5LkAR5CkIz4/pLTV2E8lS7U/ynPYeZ39bDdm4hrYt7nmyu4nclC70Sv7QocypD7E
         S01nRYAppM4fC/3NxVhODLMsfqokmBls+lwiBQXGT3hMJdxQ4s73EqAiTmUzMu5jKaBA
         PEdae+zP7tR/AidBwGrpEDH8jk0QaTxt1TLWu0siUzy9i6dqpKKMTVWU/tGgoWzVxfqr
         B8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123207; x=1775728007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyst/4kmEsxgwGqDda+/V97Ys8/9T/NJBxPyHbegpPw=;
        b=svSB0lawZUzZXCpflcspA6mVrRi2OqiAXThqkPK00uUFtBp1FSGVEsIWxQsJ1DDLX3
         B/3nEASQl/JVp55MTtCpaCodKUHsIP8dW35DeQiYGPJmKE2M4ygP3vEoZHRHE5Lylxbq
         bRwWiUqNNfRpYpYw6ubuzrPrafKJiRikXn/CPJ7NfJ06bxObCQgU8Wy6yx+U57zKf00Y
         HbKvpnkk5j//as8dUViYdr62KwbiCstWVewfdTM5SfTIknDurQWze6Wd3Pb0mcqnYh/i
         9JP5CcullD4BYcjHxSAfFLxhvuUmYMIpKMTh8lI369xSoawNlTY1QZSk7VM3tXWHDiyb
         eSig==
X-Forwarded-Encrypted: i=1; AJvYcCXHjK556+Iup/QBRZo73B9cdoV2Zcd1qss3ciZSLZoef7g31jX4RDKM2qpkBxXWXc94PIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUAykcYBb4v7wGssXEgIdCQ9QAjfuEv/9bBJoilio06jACw05
	XoFq/F1pOIcYbtSCnhnSknTHuN4NNNq+iN5fNo09ybJymTqFXhSbf6a1
X-Gm-Gg: ATEYQzw4NjDEeX9N4nQvrMLkvDLFwxF9eaclXjLH3i05rDEzU9JkWKIgYYFIsvQw2W9
	NUSsKDyBTjUf6dLretMlGsSuaU4uAKw4rJ+Yas+GG1b1Mph2aklERdI7rfWx4emYntDRMSH0MrX
	VLbx17fQnKz3RUgMXrc4uXrrnlj6QOr6jU7nPbVfjTaWvNxaiQV5bQw3P5fDG6iB+x2YPXisrCe
	sOMZy4uGfm9MCIK+EXIF+P2LVQQssHJSqEiSMVD3+D350PGMZ51JqYAGEQ7ktYsVYFSBShoondf
	yqjRuGiptFpT51X/foHMaubwFV7LOPZG+gqm2FtguKKyX9WEavNPfg+GzTeF6chmISP9gbC95Uo
	l2wqF9ZUoZtpM0N3SxX9uIDVb2KtoqYMkZZkz97/hsJIMnmuHAF2OQmKw89wR4mKauqD2wHfK0g
	AM1QrB+XQ=
X-Received: by 2002:a05:600c:450f:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48883568af7mr117366155e9.5.1775123207187;
        Thu, 02 Apr 2026 02:46:47 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c760320sm106077895e9.3.2026.04.02.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:46:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Apr 2026 11:46:44 +0200
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Varun R Mallya <varunrmallya@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test to ensure
 kprobe_multi is not sleepable
Message-ID: <ac47BIEUBBkTch31@krava>
References: <20260401191126.440683-1-varunrmallya@gmail.com>
 <20260401191126.440683-2-varunrmallya@gmail.com>
 <CAP01T74cudrCFGAJhhNUWdCS+D1Gn5yFNccaS85YcoX8vdgzBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T74cudrCFGAJhhNUWdCS+D1Gn5yFNccaS85YcoX8vdgzBQ@mail.gmail.com>

On Thu, Apr 02, 2026 at 12:50:10AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Wed, 1 Apr 2026 at 21:11, Varun R Mallya <varunrmallya@gmail.com> wrote:
> >
> > Add a selftest to ensure that kprobe_multi programs cannot be attached
> > using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
> > rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.
> >
> > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > ---
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
> >  .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index 78c974d4ea33..f02fec2b6fda 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -10,6 +10,7 @@
> >  #include "kprobe_multi_session_cookie.skel.h"
> >  #include "kprobe_multi_verifier.skel.h"
> >  #include "kprobe_write_ctx.skel.h"
> > +#include "kprobe_multi_sleepable.skel.h"
> >  #include "bpf/libbpf_internal.h"
> >  #include "bpf/hashmap.h"
> >
> > @@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
> >  }
> >  #endif
> >
> > +static void test_attach_multi_sleepable(void)
> > +{
> > +       struct kprobe_multi_sleepable *skel;
> > +       int err;
> > +
> > +       skel = kprobe_multi_sleepable__open();
> > +       if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
> > +               return;
> > +
> > +       err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
> > +                                    BPF_F_SLEEPABLE);
> > +       if (!ASSERT_OK(err, "bpf_program__set_flags"))
> > +               goto cleanup;
> > +
> > +       /* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
> > +       err = kprobe_multi_sleepable__load(skel);
> > +       if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
> > +               goto cleanup;
> > +
> > +       /* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
> > +        * Also chosen a stable symbol to send into opts
> > +        */
> > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> > +       const char *sym = "vfs_read";
> > +
> > +       opts.syms = &sym;
> > +       opts.cnt = 1;
> > +
> > +       skel->links.handle_kprobe_multi_sleepable =
> > +               bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
> > +                                                     NULL, &opts);
> > +       ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
> > +                      "bpf_program__attach_kprobe_multi_opts");
> 
> Nit: While vfs_read will likely remain stable, the check could
> probably be stronger to distinguish an attach error from -EINVAL?
> I added a typo to vfs_read and it still passed, because it failed to
> attach instead of getting rejected on unfixed kernel.
> May not be a big deal since vfs_read is unlikely to break.
> I verified it works by adding bpf_copy_from_user to the program and
> attaching to SYS_PREFIX sys_getpid and invoking the splat though, so
> LGTM otherwise.

why not use bpf_fentry_test2 ? you could also put it in pattern argument
and bypass opts completely (up to you)

also there's test_attach_api_fails test, please move it over there

thanks,
jirka
