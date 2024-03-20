Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D71119F
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710909759; cv=none; b=j34kJZxcUOebupNGF5PGeAOXjMacUCz46fxuOGtfrE0lXWMeGxzqKtiTZEReNvSdOxjHbR564Lq1/9H6J6sOEAuOemNVxjcdUyna4PV72SVq4Fa6wqA/fAnFZS4tYo3qngtvTuSQIbDBwCUdhoEGlsSf1jm99J1rctgnOkULlvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710909759; c=relaxed/simple;
	bh=FFkw7m91uLgfhzY8lSs7u3SRzgLtl3hfepkuhkqEOco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Qo8q9+6ZJA6DW/yF7VRTYGlqU2U9ln+glkYyiiwcLDtmpRAmvtMyvF/X3Tzp71GrflSCA6K3yw2z2EvI5VK+Q14ZL6d8KhBSGZ+igErnlBKjg+BC0NUjuQehBvnSfWxgQCPY0jy/MH0EXQiQONwtv+wPqXpqeQYX212OigyH6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umQltqgJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umQltqgJ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430e1e06e75so221931cf.0
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 21:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710909757; x=1711514557; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOiFkCsSh82NJJ1OPmoUof4RsaZcNQDwXob9oPa1+fo=;
        b=umQltqgJvKjISLCQoXswHJ1OmRyYhQQqfidbg/Xg0BLoL9l0YvWui6ATV0qvP+fYFX
         vfUnCrIkFVwhQvncI0vGL4fvEBWeZ3s5OaY54GWA8nLDJgtI19sZ2BEAAPsOSx6MefSJ
         3nLmeNQQNPEDC6VMef8nJOQDdsbWlRaO5If2Kmo2s4jm5cH0WLSfrRMVoTnlrR02gVVl
         QhlrhfiWqjQHRhTMgnJlEmlEA7/E7U1PnPbRazlU4m/n+Oj/pn1KpxiD2qkvUJEZYMpw
         oSw3T7zBCl/lTVwjBDWpwqNfYn13UAg8tAy2mR13i4Zln8igaN47P6chTkbb5le1kGju
         Uiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710909757; x=1711514557;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOiFkCsSh82NJJ1OPmoUof4RsaZcNQDwXob9oPa1+fo=;
        b=WtOSp1TYIHXze8YBR4ugN3Mwb7hPPB5+g7LUW8IP3gSrbcRNa0pfV6MMUzl13wySXg
         jFqOx9f+CIK/OHB+IMyUN9oA+oOqAHOkMNu7L281kO49OVLGx+VsY0KuBmYZcWu63kHC
         MsAGtHO6HoO6jUmC5TDTmL2SPIXt5shTqC+YnbWtEC42KGzXJzIFeHni50zW/p7/lqO2
         uYBf+bbn0BH15VJRBvULX75AyWCqp181BkKFAo2QgggL7Pwt7aGJPLmQ0NkX/2y7tx5F
         1rqe8RaTM3F2eMAgL3Ni9u2gtM70OzRIs/pa6/9xF2N7Vh9H2QEBbRdJKgL9MRqt7exx
         RBSg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ulyObLtJWvtTPMxnXQI0yhzHHfOSbUiuG8GssQzVpdIbuU2NgdkSBUDmHLRYoP6YwjanPZcyYFknL41JrvhPJn9K
X-Gm-Message-State: AOJu0YwMnIxA8vZk3RP5CXigUfFlV/O+Noj4bQ/JUeN/08Yho5epZulW
	FkKTD0hQB2BYfYPeYfKlkAFdsCvsMDNU5EdRMnp08Sk256y6ch3BOC2GdAyXuLJHZ8Mz6UWGS76
	lVcFPN8F+Hx/Sy3qEkX9szNVLL3TgwyOfjirJ
X-Google-Smtp-Source: AGHT+IGvy6ooA+9qkzEhIrOI3gXaBwhszV/McOy/gsH1cWTMSTRqckFGy0rcatNzzbMM7CZUnFl6+FXXBeEblwuCZrg=
X-Received: by 2002:ac8:5c91:0:b0:42e:e40f:fca4 with SMTP id
 r17-20020ac85c91000000b0042ee40ffca4mr136551qta.13.1710909757167; Tue, 19 Mar
 2024 21:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301074639.2260708-1-irogers@google.com> <CAP-5=fX7JDkyPEXwJGmhYf75EA5KsFQpZ3tC-70hNe8kUnZ=rw@mail.gmail.com>
In-Reply-To: <CAP-5=fX7JDkyPEXwJGmhYf75EA5KsFQpZ3tC-70hNe8kUnZ=rw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 21:42:26 -0700
Message-ID: <CAP-5=fW_B-HOU0moGXjesjNaz2FR8emSB1LsadXOh5O71CrWWQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf record: Delete session after stopping
 sideband thread
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Brauner <brauner@kernel.org>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Disha Goel <disgoel@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:50=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Feb 29, 2024 at 11:47=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > The session has a header in it which contains a perf env with
> > bpf_progs. The bpf_progs are accessed by the sideband thread and so
> > the sideband thread must be stopped before the session is deleted, to
> > avoid a use after free.  This error was detected by AddressSanitizer
> > in the following:
> >
> > ```
> > =3D=3D2054673=3D=3DERROR: AddressSanitizer: heap-use-after-free on addr=
ess 0x61d000161e00 at pc 0x55769289de54 bp 0x7f9df36d4ab0 sp 0x7f9df36d4aa8
> > READ of size 8 at 0x61d000161e00 thread T1
> >     #0 0x55769289de53 in __perf_env__insert_bpf_prog_info util/env.c:42
> >     #1 0x55769289dbb1 in perf_env__insert_bpf_prog_info util/env.c:29
> >     #2 0x557692bbae29 in perf_env__add_bpf_info util/bpf-event.c:483
> >     #3 0x557692bbb01a in bpf_event__sb_cb util/bpf-event.c:512
> >     #4 0x5576928b75f4 in perf_evlist__poll_thread util/sideband_evlist.=
c:68
> >     #5 0x7f9df96a63eb in start_thread nptl/pthread_create.c:444
> >     #6 0x7f9df9726a4b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone=
3.S:81
> >
> > 0x61d000161e00 is located 384 bytes inside of 2136-byte region [0x61d00=
0161c80,0x61d0001624d8)
> > freed by thread T0 here:
> >     #0 0x7f9dfa6d7288 in __interceptor_free libsanitizer/asan/asan_mall=
oc_linux.cpp:52
> >     #1 0x557692978d50 in perf_session__delete util/session.c:319
> >     #2 0x557692673959 in __cmd_record tools/perf/builtin-record.c:2884
> >     #3 0x55769267a9f0 in cmd_record tools/perf/builtin-record.c:4259
> >     #4 0x55769286710c in run_builtin tools/perf/perf.c:349
> >     #5 0x557692867678 in handle_internal_command tools/perf/perf.c:402
> >     #6 0x557692867a40 in run_argv tools/perf/perf.c:446
> >     #7 0x557692867fae in main tools/perf/perf.c:562
> >     #8 0x7f9df96456c9 in __libc_start_call_main ../sysdeps/nptl/libc_st=
art_call_main.h:58
> > ```
> >
> > Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Note, after this series I'm seeing parallel perf testing being as
> reliable as serial but parallel testing is nearly 3 times faster. I
> think after these changes land we can make parallel execution the
> default.

Ping.

Thanks,
Ian
