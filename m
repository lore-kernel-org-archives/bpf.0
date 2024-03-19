Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C213D387
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885155; cv=none; b=XYB+ZDBDWN70/HW6suHNUKltztYbQXLEa8cr2ts86HH3kKkPXu6/KKVnd9Njgbo6V9SDR3R4FiLVbRYxStKdQybyf0euX0797+M3/7mI2oOezMJOcy66FcfOPdwFafo8yhUzPmmwkao9rjiqsbnPxG3Y/g0UCLTnSttlWA305bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885155; c=relaxed/simple;
	bh=gxKhswklrUUfPFlGLsX/MvNyDA5fZrFQf5wTylo1HNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeWN60RwyJ9ndQEjFHKEtUD9LGtELA+EUfglymF+ZlLYr2aZkKJVk74rXUwrDIE7DrWVYnAroXtl8UEXwsDqB0uJGakK59iIQ0ORKRsTImvYZvWVye22wYxEJ6dEG9sPYmk97XYs6AYMpNthrAOB64mOLJYDsqR/i6t/1GrY92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8ho4tmY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8ho4tmY"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4669772a12.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 14:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710885153; x=1711489953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvhJvUZ88vBQ63jdGJRpNoiYYjjbdLB63J8+2HpFrp0=;
        b=V8ho4tmYTgi2YMvZoRR3LpN2M6PYLchO5EJCfS58wQ9SwLNM10dEQ5ns5JCQXPDSKZ
         2zXtnL5YbQPuq57ig0CtMckna+ChSIAOzaH+wBIGR0X8HDsAF20h36nC8Pzsx0j1dpe9
         wqFpTT67QV2xhaknOI12rx8Lb8vgpsWgRdejUTI2DDEq83aHkpqRAbNHPnw7WJA+3vvE
         dW/6KCHFBNlbNcOWpWEsl8lNdtFpHisnT0dMKftOa4MpmFHCH9NdUiDfe3PXF2p6tpNB
         SUCzfj93Y/j2Mlglg70fJZUSBfyDrO2yFdctcfAc/5It9XEFmaHTJ++JU3M0FAUUjAIF
         zGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885153; x=1711489953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvhJvUZ88vBQ63jdGJRpNoiYYjjbdLB63J8+2HpFrp0=;
        b=dytXDuIuUe1tsObFCxTUNgjMCkv3YfQ89tDXr6YaDjL3kJA8bjKQmURKcj4yHzW7R3
         S2t75wvksffwW6tAlDw1epDwJ83YKTty8xneiBNwB9+0VntCoV0avhh9EyK4cTH+nWdx
         PNtMDlC0N9VhB3ALfwGdWyPGTPdmBBlTYNUiY2bPXysu/N4l5qA748njGE0DO43WbXl1
         cI4weOIGKHjfzR8FMa98wmA6ALWcZXgRH9lcaP/5bJnk5ys34o8SVzyhN1HO86UR1cxs
         +fVDhyNlckEsww7tuM0mlbn1t6ZmEoe/rl+6fmULSp9/BRs3KbjkdIJaBH6n4l/jWe11
         rujw==
X-Forwarded-Encrypted: i=1; AJvYcCUnEmxHjonK2NihGMr5o0+fABGcGoHIYOVYrrOhUuiLRnXx2cYrBb/ebFpeVpofMUr4CfdDaG3CLVAN4aFs2TS6kX2x
X-Gm-Message-State: AOJu0YwR068/vKjt3cOtUXfJMBnlcVNQGPSUurcIURhuvjzTy5GOBcXN
	yboQyCNLstiZBanGdvfgtEcFRn76MuHZDfJSnLivddh5MMBuWA+7lafR6F4U4scV/4JjzSDEQhR
	0m6ve+RTzsydsAX6QRxkwvnUq+p1k5kme
X-Google-Smtp-Source: AGHT+IEg7HJY22ITIs8jTX6IuHK+bLTiPKD8sKYmtIQOxtNaoBANSu9KjAFAX6fad//FqlUAnD78C78P2UrvQuVQoRM=
X-Received: by 2002:a05:6a21:3a4a:b0:1a3:564e:a56b with SMTP id
 zu10-20020a056a213a4a00b001a3564ea56bmr4269642pzb.3.1710885153360; Tue, 19
 Mar 2024 14:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315184849.2974556-1-yonghong.song@linux.dev>
 <20240315184859.2975543-1-yonghong.song@linux.dev> <ZfgnLQ5ytpU2IcUX@krava> <2af81b55-4be4-4936-a42e-940786c45877@linux.dev>
In-Reply-To: <2af81b55-4be4-4936-a42e-940786c45877@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 14:52:20 -0700
Message-ID: <CAEf4BzYWoe1DEOFsXe4=fx+2ceFKEc8ASW5Jt002jOHkErxqHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] selftests/bpf: Replace CHECK with
 ASSERT_* in ns_current_pid_tgid test
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yury Namgung <ynamgung@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:30=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 3/18/24 4:36 AM, Jiri Olsa wrote:
> > On Fri, Mar 15, 2024 at 11:48:59AM -0700, Yonghong Song wrote:
> >> Replace CHECK in selftest ns_current_pid_tgid with recommended ASSERT_=
* style.
> >> I also shortened subtest name as the prefix of subtest name is covered
> >> by the test name already.
> >>
> >> This patch does fix a testing issue. Currently even if bss->user_{pid,=
tgid}
> >> is not correct, the test still passed since the clone func returns 0.
> >> I fixed it to return a non-zero value if bss->user_{pid,tgid} is incor=
rect.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   .../bpf/prog_tests/ns_current_pid_tgid.c      | 36 ++++++++++-------=
--
> >>   1 file changed, 19 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgi=
d.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
> >> index 24d493482ffc..3a0664a86243 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
> >> @@ -20,19 +20,19 @@ static int test_current_pid_tgid(void *args)
> >>   {
> >>      struct test_ns_current_pid_tgid__bss  *bss;
> >>      struct test_ns_current_pid_tgid *skel;
> >> -    int err =3D -1, duration =3D 0;
> >> +    int ret =3D -1, err;
> >>      pid_t tgid, pid;
> >>      struct stat st;
> >>
> >>      skel =3D test_ns_current_pid_tgid__open_and_load();
> >> -    if (CHECK(!skel, "skel_open_load", "failed to load skeleton\n"))
> >> -            goto cleanup;
> >> +    if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open_and_load=
"))
> >> +            goto out;
> > you could just return in here so there's no need for the out label
> > otherwise lgtm
>
> Since this patch intends to just replace CHECK with ASSERT_*.
> I tried to keep other parts of codes the same as before. But
> I can certainly do this. I will wait for other comments
> before sending another revision.
>

I applied it as is, but feel free to send suggested improvements as a follo=
w up.


> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> >
> > jirka
> >
> >>
> >>      pid =3D syscall(SYS_gettid);
> >>      tgid =3D getpid();
> >>
> >>      err =3D stat("/proc/self/ns/pid", &st);
> >> -    if (CHECK(err, "stat", "failed /proc/self/ns/pid: %d\n", err))
> >> +    if (!ASSERT_OK(err, "stat /proc/self/ns/pid"))
> >>              goto cleanup;
> >>
> >>      bss =3D skel->bss;
> >> @@ -42,24 +42,26 @@ static int test_current_pid_tgid(void *args)
> >>      bss->user_tgid =3D 0;
> >>
> >>      err =3D test_ns_current_pid_tgid__attach(skel);
> >> -    if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err=
))
> >> +    if (!ASSERT_OK(err, "test_ns_current_pid_tgid__attach"))
> >>              goto cleanup;
> >>
> >>      /* trigger tracepoint */
> >>      usleep(1);
> >> -    ASSERT_EQ(bss->user_pid, pid, "pid");
> >> -    ASSERT_EQ(bss->user_tgid, tgid, "tgid");
> >> -    err =3D 0;
> >> +    if (!ASSERT_EQ(bss->user_pid, pid, "pid"))
> >> +            goto cleanup;
> >> +    if (!ASSERT_EQ(bss->user_tgid, tgid, "tgid"))
> >> +            goto cleanup;
> >> +    ret =3D 0;
> >>
> >>   cleanup:
> >> -     test_ns_current_pid_tgid__destroy(skel);
> >> -
> >> -    return err;
> >> +    test_ns_current_pid_tgid__destroy(skel);
> >> +out:
> >> +    return ret;
> >>   }
> [...]
