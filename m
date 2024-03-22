Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701DA605A1
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114814; cv=none; b=gVlDEJIkKlXhD/w3uJ3o+Zm3RCtNe1dhTTv0ZqqouFqkEvYePS3PH5NklsbC8QgHsJ7L0mJi2PPlhuRLURr6eo0BQkZgwzW3jJJPFyywfR+5xQcWdpkp4HoOeZHUv6zUwmlD3MtPgwLDbOtMn7ys+kjhgBjKXbkzI7P8GKxzteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114814; c=relaxed/simple;
	bh=vzR+F7iyYIom41zfRX1BWEFpeANzsiGoTmYyJDAmUTI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9rytQuk2MxfHnF4gtK1OCa3xgawt9tNPBu3Q5qC0qNfN34H5NiyH7Fm72ZAqG9Y8+6dRbvu8aH6iXLv0faQGf+uQSYDrMVDOnpFU8YnpEA5JcHZZTDq7mfg/pNDaC/KeCqdts4TzP6tm8jvfUFjFbvIlbSw8Y9bJFtfhYTOdHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOMkriRj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOMkriRj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e1d327595so1571385f8f.2
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711114811; x=1711719611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LxIUTU18nYdhH+N7Mid/anyn+VKLn3fJhKJup/6rCs4=;
        b=EOMkriRjBzUKXDca5fPO4qcBg2Nx37dBB4HsCPiDpOLO4/5937cr/SVdvEQKe3Bx6d
         QWZPgdP+XrCMp6KEROgLL6ivMSbC6IKa9vxh/EswwGjQDc16SCcaLwa3Y9qSGcb8PDXN
         arzBpZRqHUWrX5YUbFi/i/7ePNscixwo4kRhegUWaAyqFM2r+bkYiiX2QX60bEHR3HO+
         KjT0KqikD2ZG6UC+iR60iIej2DbNb82bDAfc8/rzUE4UGa5qaTdZKULi9vlizj72Mr1h
         AymnfKpP0YiERKGo5n3jcnCR3uRkRD9mjRAhNQ5vQt1jWsFtKb3+0s+7r1yK/BFE2qbL
         o+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711114811; x=1711719611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxIUTU18nYdhH+N7Mid/anyn+VKLn3fJhKJup/6rCs4=;
        b=VVR3t65Y+StAmn8BcQ59Pz+BkuVN1L6sN/MQ7v6WlcUDYcZ9iqvD11zTAMXuFvGyIQ
         p3wZ/WR7y4O7Vafhh6tmg1eGrcUz+72f4VQD/EYuMqf+dNcgQJkM4GjPGsFfdwnIPIjE
         PtkAT8BRox3BXgpSdMC2kiZuyE88uxYFoEs5Nol8LiSAiGmQ/0g3frgMZQ0mFsjH8VvK
         PuOYNh/LPYYh7OPcNziQ2cZHNLHw8/SF5dVQepdyhA636hTAiY58wN6EWBzi9RPGOrod
         54EtPWMlOKwn9/MXVLK6omFBU/k3IdTN+UDRR0RgYN1lL1XFujjV2odQd+VwqqGKF4hm
         K77w==
X-Forwarded-Encrypted: i=1; AJvYcCVcEbvmuIhBiveHV3g2Sf3/6JqeFpXrKgyL3DuYQEKrDaGuoKHKKPCV59RINE6YoQGsDVtr525aLoN2HfzsEZAXj66Q
X-Gm-Message-State: AOJu0YyvEXeiAOwOsBNafpoT1ei/hJZXeSCVp6vTaFWBjkYAM+2wuS3E
	EwEp5Uopgb5V49iDBQikExeWxGFmi1ak3GtFbZU8DIre1phsawxu
X-Google-Smtp-Source: AGHT+IFTXmkNI6KlSR17zeF1Tvpgr51gVMcI3a5V9xoCNxJW3GU6xWAtJS4Ur4CffuUIJoxvGMdM5A==
X-Received: by 2002:a5d:5988:0:b0:33d:73de:cd95 with SMTP id n8-20020a5d5988000000b0033d73decd95mr2222177wri.17.1711114810430;
        Fri, 22 Mar 2024 06:40:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id cl1-20020a5d5f01000000b0033e72e104c5sm1076411wrb.34.2024.03.22.06.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 06:40:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Mar 2024 14:40:07 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/3] selftests/bpf: Mark uprobe trigger
 functions with nocf_check attribute
Message-ID: <Zf2KN4nw_JzyUTfF@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240318093139.293497-4-jolsa@kernel.org>
 <CAEf4BzZxjRuLES-zu6x1FaBp-ujnqMyVa9g_+BpEWVg9sMFAww@mail.gmail.com>
 <Zflyyh-AqtAAlmse@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zflyyh-AqtAAlmse@krava>

On Tue, Mar 19, 2024 at 12:11:06PM +0100, Jiri Olsa wrote:
> On Mon, Mar 18, 2024 at 06:22:02PM -0700, Andrii Nakryiko wrote:
> > On Mon, Mar 18, 2024 at 2:32 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Some distros seem to enable the -fcf-protection=branch by default,
> > > which breaks our setup on first instruction of uprobe trigger
> > > functions and place there endbr64 instruction.
> > >
> > > Marking them with nocf_check attribute to skip that.
> > >
> > > Adding -Wno-attributes for bench objects, becase nocf_check can
> > > be used only when -fcf-protection=branch is enabled, otherwise
> > > we get a warning and break compilation.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/include/linux/compiler.h                     | 4 ++++
> > >  tools/testing/selftests/bpf/Makefile               | 2 +-
> > >  tools/testing/selftests/bpf/benchs/bench_trigger.c | 6 +++---
> > >  3 files changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
> > > index 7b65566f3e42..14038ce04ca4 100644
> > > --- a/tools/include/linux/compiler.h
> > > +++ b/tools/include/linux/compiler.h
> > > @@ -58,6 +58,10 @@
> > >  #define noinline
> > >  #endif
> > >
> > > +#ifndef __nocfcheck
> > > +#define __nocfcheck __attribute__((nocf_check))
> > > +#endif
> > 
> > Let's preserve spelling of the attribut, __nocf_check ?
> > 
> > BTW, just FYI, seems like kernel is defining it as:
> > 
> > #define __noendbr    __attribute__((nocf_check))
> > 
> > Thought somewhere deep in x86-specific code, so probably not a good
> > idea to use it here?
> 
> ugh, I missed it.. better to use __noendbr

nah, I'll keep using __nocf_check, __noendbr is bery arch
specific as you said

jirka

> 
> > 
> > > +
> > >  /* Are two types/vars the same type (ignoring qualifiers)? */
> > >  #ifndef __same_type
> > >  # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > index e425a946276b..506d3d592093 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -726,7 +726,7 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
> > >  # Benchmark runner
> > >  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
> > >         $(call msg,CC,,$@)
> > > -       $(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
> > > +       $(Q)$(CC) $(CFLAGS) -O2 -Wno-attributes -c $(filter %.c,$^) $(LDLIBS) -o $@
> > 
> > let's better use `#pragma warning disable` in relevant .c files,
> > instead of this global flag?
> 
> ok, will try that
> 
> thanks,
> jirka
