Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985895B1EA
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846672; cv=none; b=JDElSVyYyTcvgokvbjlJpi01FQ5kFdUIGTs+K+ElFEByRECmHPNU9pMMFNsEuWlKcBtFT5ierLKpanVw4N28xp/mShhC0U4Vomy6/Cheiysyt3MZWh/bVmX28NVdxcTP1fkTODbvuyT4nXSXs9BMOj4ueUgE8kSlWrSdrmMKVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846672; c=relaxed/simple;
	bh=4QFBE7rZk0IPf7VPYlSy2WPdnRl1g9Sp+m/Evzq5ob4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTapZITL47GbN5SHRewHusNeeNotpvG06NE74PYqaVZS0p1xIdr3Za/VaF6Vs/ou+IJSnUNqIyhbZrYT8cjmShVcoBotENp8OWzro67I/MwESWujnIm6aD6WsskMYE89GVX+9xebjkhQmc5nYvnZ8epMflshd7MS1DtewQwwd2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEDXM7Vb; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEDXM7Vb"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d24a727f78so62898831fa.0
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 04:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710846669; x=1711451469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k5I7ZzFkWyQzGS8T+HSKfTVH33I1amaRJYeUcjVc9ZY=;
        b=AEDXM7VbQNV4iL7DCJmu8q4reY0OnQsMx3Y+EzvdQstQSjSVTj/tqyyNlcaSiOxp7s
         VtdhG/Dw4U6Ar5K5F4DpYRxfXp8OjAudIQh8XeSC1lnPwZhNtH7bQDAYfyiVoCNfpGbw
         e5i8TLiWPRs1xCPyx6AONnpW1YROuB46XCd67BVyk/ael+0jMhtHE1SLxrFY6CFNr1tq
         9CUhw4XbiRlOGKTJi6VkETX1GytlPIRSMW4hzrUsWFNxocbJdbUheQ6QCWnxWwwC+/FU
         n6YJGw3VC2SLf2j3Xae5jMGJCPp2ufU3a1DAUyJCJ8Zv8+g5RuqL0zSpSLuTpnrL2Z4s
         xLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846669; x=1711451469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5I7ZzFkWyQzGS8T+HSKfTVH33I1amaRJYeUcjVc9ZY=;
        b=PwR4vuRIFiWy+Eucd990oSjjB8Dg5ViDwDCcIGakpMjWjNp9eDqDcWCkgKsFnEe5jw
         r/ApLF+8jPds61qyKTFeo9ItprSygNAuKrlGE9Sm8oRugFz5m2TGY8vzhgfiFTzIn8VR
         WCZXKz+E6aFk9v4wCi7HIjTheggfiudvgP0F730WH18oQADAtoZ95K12thEOLMN5FVrg
         XSMP+8sZNMikWwJ4pv99dpxXJOwRAxqD44DgvLYHhdihfSSgHQZw1EtCwSaJKwfkWLiM
         jiAdGgKbMr7TOCu+FbSjOD3vequHq16NhjXmp4pBVXbwLMZTyQwZq7q+Uztq/oSpfbHZ
         0aZw==
X-Forwarded-Encrypted: i=1; AJvYcCV2b7Isb/q/azmoiNmc8I03prVLp23LEREk9Zqk6aK6tIXFh1JjYXnRrgLoNKMJgjuk2P9c6evYeYvYjWbhJU3Ob6Zq
X-Gm-Message-State: AOJu0YwwDjSz0eoOZSE85D/yQyrWurnZBqwfNvIF+eezYe06WwLXVmCS
	EdQ0PDx3x81kfS/iRzPjxG4lrE9dBXRexXkLyr5UDwjaYeM/mS10
X-Google-Smtp-Source: AGHT+IEiE69SGyWDLEX4ig8UvNTxHOpHzwEVCN4aZLZ8ZovAVHQsbJ+kgCf+USuOEgDb3Gd7eWor7A==
X-Received: by 2002:a2e:8187:0:b0:2d4:5d56:e559 with SMTP id e7-20020a2e8187000000b002d45d56e559mr10040824ljg.47.1710846668488;
        Tue, 19 Mar 2024 04:11:08 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p8-20020a50cd88000000b0056851310a04sm5971571edi.16.2024.03.19.04.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:11:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 12:11:06 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/3] selftests/bpf: Mark uprobe trigger
 functions with nocf_check attribute
Message-ID: <Zflyyh-AqtAAlmse@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240318093139.293497-4-jolsa@kernel.org>
 <CAEf4BzZxjRuLES-zu6x1FaBp-ujnqMyVa9g_+BpEWVg9sMFAww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZxjRuLES-zu6x1FaBp-ujnqMyVa9g_+BpEWVg9sMFAww@mail.gmail.com>

On Mon, Mar 18, 2024 at 06:22:02PM -0700, Andrii Nakryiko wrote:
> On Mon, Mar 18, 2024 at 2:32 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Some distros seem to enable the -fcf-protection=branch by default,
> > which breaks our setup on first instruction of uprobe trigger
> > functions and place there endbr64 instruction.
> >
> > Marking them with nocf_check attribute to skip that.
> >
> > Adding -Wno-attributes for bench objects, becase nocf_check can
> > be used only when -fcf-protection=branch is enabled, otherwise
> > we get a warning and break compilation.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/include/linux/compiler.h                     | 4 ++++
> >  tools/testing/selftests/bpf/Makefile               | 2 +-
> >  tools/testing/selftests/bpf/benchs/bench_trigger.c | 6 +++---
> >  3 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
> > index 7b65566f3e42..14038ce04ca4 100644
> > --- a/tools/include/linux/compiler.h
> > +++ b/tools/include/linux/compiler.h
> > @@ -58,6 +58,10 @@
> >  #define noinline
> >  #endif
> >
> > +#ifndef __nocfcheck
> > +#define __nocfcheck __attribute__((nocf_check))
> > +#endif
> 
> Let's preserve spelling of the attribut, __nocf_check ?
> 
> BTW, just FYI, seems like kernel is defining it as:
> 
> #define __noendbr    __attribute__((nocf_check))
> 
> Thought somewhere deep in x86-specific code, so probably not a good
> idea to use it here?

ugh, I missed it.. better to use __noendbr

> 
> > +
> >  /* Are two types/vars the same type (ignoring qualifiers)? */
> >  #ifndef __same_type
> >  # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index e425a946276b..506d3d592093 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -726,7 +726,7 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
> >  # Benchmark runner
> >  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
> >         $(call msg,CC,,$@)
> > -       $(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
> > +       $(Q)$(CC) $(CFLAGS) -O2 -Wno-attributes -c $(filter %.c,$^) $(LDLIBS) -o $@
> 
> let's better use `#pragma warning disable` in relevant .c files,
> instead of this global flag?

ok, will try that

thanks,
jirka
