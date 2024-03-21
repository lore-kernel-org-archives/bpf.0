Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29A8BE7
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047330; cv=none; b=SQKBFTGJBukxHappb+pqP3hlYvyLYOWIhfA36TgJs65qxZppIYYl3gmphTteydDsNV2DeeVIDt1zOZSuRKbDpWE7QWWxMX4FcIA2IiIZqmg9/TUXuyCVHKCmRT6V2fV0/4UwzxF5GoEv7Uv+H+LPnCollLa54lwbEit5FHgM7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047330; c=relaxed/simple;
	bh=ulLiNdakqcQcLFUuPAx46lZB21Qlxj9GLS9Vt5+Ycpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUfNOzZ54vCKwIHZtV9bbggosMDxE+kvtQr+TYO7/45AP6rubPyPS/6JvbFTo9afSWFzw5QVKaP/tnWzdRaBiWJ7ux1kpgviXvdWxcZYBexYNwtmZ0pjuKe62BEJs7dz3GXn+Voz3UuL/LzfGWmibcFZcu/bko1h+UF1KiuM3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJTbarq7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJTbarq7"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso858392a12.2
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711047328; x=1711652128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNDxhE/ohad9yUUQByM1a906+GRFmJ1hup/+dEfFric=;
        b=OJTbarq70vyHdiUXtD4DVdwktKkfoc9065WEPG6gEdeP2JVkkd6cnolnm9HUfzEL/Z
         VlXN1vhbccEAf4h/hSy1Vr33F9fZ6780hcppAs5mGfCIMf+LOW35CovKathS136/hK65
         6JYSkMCEl9tnnysyTkt4+Mbvqb/6BZuyNckrAeir1iLWg/sd48SUFl0Te8wtBjwh0cNJ
         BfhMgPirvGaroauICRUBzJXkiGAROAf0ZPftRy4xm6DypMbuwvbiwrQxCcPcjjWP4x7w
         eVfk5cUneeDducg05uB1ElnT0L87/OrPLNqUKSGfmaiZqIT7c7YaVER6LWODaOvgHhlQ
         Qhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711047328; x=1711652128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNDxhE/ohad9yUUQByM1a906+GRFmJ1hup/+dEfFric=;
        b=QwMRappq29kEMmwX0dnk6QfQJz6ezwK21fzQCJYVMCVKWhOn/+g4JOWldVDLddnmHZ
         c0MWWqxVJ0TNxu42sHP1MQvnW6fhbq2/ePXQpHwvAPBHixjVfLqL10aah8FsVefoG1vN
         jRwBAVuDR/0RwaolB8XNBdKxbVWmelTHF7BtUpB75waPjbn7U3H0h764z0eMonFSjxpT
         2ctEH0F9qWp557E29ECAD66thjW86V0G8bAmUWd6u509psaxjHVhnvgBWMrA1aTbI6MT
         jm167qrta++TcUBn9XpT3W7yysAgOXW2pI3CgNt/pW906nyRx9gLCc8CL4a6xlK8lE3M
         Fe5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdUB3ABopxn7bx+Urim0ZkziEwR338gp6rtHz43X7iJdRafu7NpqwmEEvBP9HyDgsMN7hOPTv8XS1BMec/rerdArK2
X-Gm-Message-State: AOJu0Yw9gdx1y/y3jo6zhtvlD/gFELIfOS+frBvllPZBjLeflX1LcOxj
	+tuKBSGhqHpYWiOvABWggk/x1QzoGPMpd/g4yi5xSxXZpg2P7DkEnSD1bwVk2R3xcWbtMNLMu42
	h1FD+blOzdUPp2WURLUVU6mI+XZA=
X-Google-Smtp-Source: AGHT+IFqYjAnbpnSWz+APq9HLQPg1KGf499srY770tXmZuCOZcxjyzFqKIYqeZHQPqAoP99WCHlw0+nPbvj/5PCV1Qk=
X-Received: by 2002:a17:90b:681:b0:29f:ed40:4a8a with SMTP id
 m1-20020a17090b068100b0029fed404a8amr252848pjz.29.1711047328492; Thu, 21 Mar
 2024 11:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320014103.45641-1-qmo@kernel.org> <ZfqjiFeHmLoIO-rS@krava>
In-Reply-To: <ZfqjiFeHmLoIO-rS@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 11:55:16 -0700
Message-ID: <CAEf4BzYFC_RMW01mLcehrZ4G64R_uQm9-xj3HLKyC7Z0nX+dYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Clean up HOST_CFLAGS, HOST_LDFLAGS for
 bootstrap bpftool
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	bpf@vger.kernel.org, Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 1:51=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Mar 20, 2024 at 01:41:03AM +0000, Quentin Monnet wrote:
> > Bpftool's Makefile uses $(HOST_CFLAGS) to build the bootstrap version o=
f
> > bpftool, in order to pick the flags for the host (where we run the
> > bootstrap version) and not for the target system (where we plan to run
> > the full bpftool binary). But we pass too much information through this
> > variable.
> >
> > In particular, we set HOST_CFLAGS by copying most of the $(CFLAGS); but
> > we do this after the feature detection for bpftool, which means that
> > $(CFLAGS), hence $(HOST_CFLAGS), contain all macro definitions for usin=
g
> > the different optional features. For example, -DHAVE_LLVM_SUPPORT may b=
e
> > passed to the $(HOST_CFLAGS), even though the LLVM disassembler is not
> > used in the bootstrap version, and the related library may even be
> > missing for the host architecture.
> >
> > A similar thing happens with the $(LDFLAGS), that we use unchanged for
> > linking the bootstrap version even though they may contains flags to
> > link against additional libraries.
> >
> > To address the $(HOST_CFLAGS) issue, we move the definition of
> > $(HOST_CFLAGS) earlier in the Makefile, before the $(CFLAGS) update
> > resulting from the feature probing - none of which being relevant to th=
e
> > bootstrap version. To clean up the $(LDFLAGS) for the bootstrap version=
,
> > we introduce a dedicated $(HOST_LDFLAGS) variable that we base on
> > $(LDFLAGS), before the feature probing as well.
> >
> > On my setup, the following macro and libraries are removed from the
> > compiler invocation to build bpftool after this patch:
> >
> >   -DUSE_LIBCAP
> >   -DHAVE_LLVM_SUPPORT
> >   -I/usr/lib/llvm-17/include
> >   -D_GNU_SOURCE
> >   -D__STDC_CONSTANT_MACROS
> >   -D__STDC_FORMAT_MACROS
> >   -D__STDC_LIMIT_MACROS
> >   -lLLVM-17
> >   -L/usr/lib/llvm-17/lib
> >
> > Another advantage of cleaning up these flags is that displaying
> > available features with "bpftool version" becomes more accurate for the
> > bootstrap bpftool, and no longer reflects the features detected (and
> > available only) for the final binary.
> >
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Quentin Monnet <qmo@kernel.org>
>
> got some fuzz when applying it, but other than that lgtm
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>

this was applied, but PW bot didn't notice it. I marked it as accepted
in patchworks, just FYI.

> jirka
>
> > ---
> >  tools/bpf/bpftool/Makefile | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index e9154ace80ff..972f8d727130 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -89,6 +89,10 @@ ifneq ($(EXTRA_LDFLAGS),)
> >  LDFLAGS +=3D $(EXTRA_LDFLAGS)
> >  endif
> >
> > +HOST_CFLAGS :=3D $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCL=
UDE),\
> > +             $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> > +HOST_LDFLAGS :=3D $(LDFLAGS)
> > +
> >  INSTALL ?=3D install
> >  RM ?=3D rm -f
> >
> > @@ -178,9 +182,6 @@ ifeq ($(filter -DHAVE_LLVM_SUPPORT -DHAVE_LIBBFD_SU=
PPORT,$(CFLAGS)),)
> >    SRCS :=3D $(filter-out jit_disasm.c,$(SRCS))
> >  endif
> >
> > -HOST_CFLAGS =3D $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLU=
DE),\
> > -             $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> > -
> >  BPFTOOL_BOOTSTRAP :=3D $(BOOTSTRAP_OUTPUT)bpftool
> >
> >  BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o jso=
n_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
> > @@ -238,7 +239,7 @@ $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
> >       $(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
> >
> >  $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
> > -     $(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS=
) $(LIBS_BOOTSTRAP) -o $@
> > +     $(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $(BOOTSTRAP=
_OBJS) $(LIBS_BOOTSTRAP) -o $@
> >
> >  $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
> >       $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
> > --
> > 2.34.1
> >
