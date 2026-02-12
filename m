Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9DE329392
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905318; cv=none; b=ry2ppYiqLda5tWD7gco01u+DOMYan2uvP95N9sNVyHR/oROmauG15H1IMioMTsy2eW5BQoaUQgfBi8fxkDMDdseuWejBzybsn1Jtnwp3CGxL1RsctbvzBoVdCyPeCITi6q1kQwhCuK9KVu74HRvGvE0GyH+FwgSvYPR5pf9aLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905318; c=relaxed/simple;
	bh=BABOwnLidNmL4sEecG9G+5OdAqQiNm1wEXRvcJvWxRM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4jcZCap5BuUkBGr8LXIOjU1B55W05/9siFN4qbDmqBR1vpOpsd6cta6EWJsKGAGFkTqry1vtZ3FzpWFuSy3M4vTPdRsQm56BjHBaeWrTdLELNjNFlvAJtJCCx0+kmhNqnBWuGAR1S0FXQhjzrQlIVrUPgFcmaV7OTZHEpvPIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsQM4+uj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsQM4+uj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4807068eacbso28990675e9.2
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770905315; x=1771510115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eMEuxtwyIGE57M7rnPRpb5C9mv94nB7nm2gHJHVMXag=;
        b=LsQM4+ujZqDekArYLCGZUWLbkr0MWpAhm/nos/h/3h/6ZzZ+BO9B+UAu7+Qv2Ni8Y/
         b3nNvuWizr1bZ3aR42747TPzSxgwJC5RKbxVchkkeL37lNPFr0mJ+47ygSLKGSK5xJRb
         9PBm72cc1uak/0CurW0ItSjmvVefeDf+Q9aqmVf0JnDesLJOmUKFjx7qO7qkVZU1dagD
         Gx4Ho4NaikQYsofbKQcwBGif7gqUVCEQlhrOaJZ71/RRVpHt08+erJtVKgaZEjRzMwBI
         yD849qxSbeUyf1KB11dTJ0jr4rZYxWzyQl/xRm1PhGrw8fRTferTKRXa6tGyULtze9zb
         QI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905315; x=1771510115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMEuxtwyIGE57M7rnPRpb5C9mv94nB7nm2gHJHVMXag=;
        b=dmhSilqROffEs2Vrjb0DcKYSCmwnrBtHgPZsYePt7Q9Jc3HoJyG6IiWPRThQMyPqJY
         nXh3SobpUU02dhKPv7Zmt6WW/cK1drbGKoqnwWnxwqmdHoY9vg+fMs82J3fiUSSnqDfx
         OYYJmITJ8X1OFxNEimxvUnGNauSgSOTyLR/aBH2iGPNZnX88GxeT09X01S4NFuT5W4tV
         cCLUDRkLQnqw0jFUqwpxXpQ1JHEYyEEi6k4A5bROSvbnsPK6b/qD71VdOQfdFBugJK3I
         sLmEymLtfwBCNtBLglZ38xJf4kJlE7C74kADq/Nar3V7soz7HQFzT8cRuo0gJswDkbkK
         ACxA==
X-Forwarded-Encrypted: i=1; AJvYcCUFHF1msN6EGd7w2NuMBv5gMZ9kQlpsaGsmNJJj5ZJ+fMFA2ODbISc89lUn6F6FmroC5jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydpXUlP3eVLMI2L9LC2CM6Np0dHDqz6M3TvUUeuHZ8MHOpPoIK
	9vdDaL7QwpxLdw4thFHISRtKpA5E+akeD/hFoXJeN1Nc15mwS6Hiri5r
X-Gm-Gg: AZuq6aJ+enJy18Oo4Sb2vwKutodqOpbisxhA9nZGrU6VT6WTSDMhwsZdS+VNRuSxYTD
	RKddbMLf7S7T3o1vwSurAgwWWKTVfS/TyXvSh2q7QjCcpXL0uRPWbVEcb24tKAlIDshtF4SSVIR
	mxd+ImNW/r+8NMnbn5AwN17io7O61XhE1dd3pGi0OuOHkTQ9NrdAYADkz7euVCq3znddQReMBjV
	/kDByFqDSLNF0Sj+AXdOD/UbbhOrhvcOUi+Mhg7jWPDuQv3F/vu8KNdseJlL9yUIUx2VCPQ2cUP
	VIhcZAqCRUfZVb/ImTUqbua/vMYOaExhdYP0qRhiUgaA3yns0LJ1BS3BkvZTOyJxwyQWW82jAOX
	3V3+qWiEjy1yq23+tE1ERA7cV86ynyb/9XGps81/gzRL+TqeBWFEBNRMclR8a8rq2hrcqbjQP
X-Received: by 2002:a05:600c:1c26:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-48367085b66mr34639025e9.0.1770905314732;
        Thu, 12 Feb 2026 06:08:34 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a60ee40sm97756055e9.1.2026.02.12.06.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:08:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Feb 2026 15:08:32 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCHv3 bpf-next 3/5] libbpf: Add support to detect nop,nop5
 instructions combo for usdt probe
Message-ID: <aY3e4F51mNpqMMOO@krava>
References: <20260211084858.750950-1-jolsa@kernel.org>
 <20260211084858.750950-4-jolsa@kernel.org>
 <CAEf4BzbFjXDiQUcZbxpceVTGLa4UGvm76sAuGXEFVREj9FLoJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbFjXDiQUcZbxpceVTGLa4UGvm76sAuGXEFVREj9FLoJw@mail.gmail.com>

On Wed, Feb 11, 2026 at 01:45:12PM -0800, Andrii Nakryiko wrote:
> On Wed, Feb 11, 2026 at 12:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to detect nop,nop5 instructions combo for usdt probe
> > by checking on probe's following nop5 instruction.
> >
> > When the nop,nop5 combo is detected together with uprobe syscall,
> > we can place the probe on top of nop5 and get it optimized.
> >
> > [1] https://github.com/libbpf/usdt
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/usdt.c | 55 ++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 51 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index d1524f6f54ae..4e5f70bb4c31 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -262,6 +262,7 @@ struct usdt_manager {
> >         bool has_bpf_cookie;
> >         bool has_sema_refcnt;
> >         bool has_uprobe_multi;
> > +       bool has_uprobe_syscall;
> >  };
> >
> >  struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> > @@ -301,6 +302,13 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> >          * usdt probes.
> >          */
> >         man->has_uprobe_multi = kernel_supports(obj, FEAT_UPROBE_MULTI_LINK);
> > +
> > +       /*
> > +        * Detect kernel support for uprobe() syscall, it's presence means we can
> > +        * take advantage of faster nop5 uprobe handling.
> > +        * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
> > +        */
> > +       man->has_uprobe_syscall = kernel_supports(obj, FEAT_UPROBE_SYSCALL);
> >         return man;
> >  }
> >
> > @@ -585,13 +593,42 @@ static int parse_usdt_note(GElf_Nhdr *nhdr, const char *data, size_t name_off,
> >
> >  static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note, __u64 usdt_cookie);
> >
> > -static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *path, pid_t pid,
> > -                               const char *usdt_provider, const char *usdt_name, __u64 usdt_cookie,
> > -                               struct usdt_target **out_targets, size_t *out_target_cnt)
> > +#if defined(__x86_64__)
> > +static bool has_nop_combo(int fd, long off)
> > +{
> > +       static unsigned char nop_combo[6] = {
> > +               0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> > +       };
> > +       unsigned char buf[6] = {};
> > +
> > +       /*
> > +        * We are using file descriptor that backs Elf object,
> > +        * let's dup it to be on the safe side.
> > +        */
> > +       fd = dup(fd);
> > +       if (fd < 0)
> > +               return false;
> > +       if (lseek(fd, off, SEEK_SET) == off)
> > +               read(fd, buf, 6);
> > +       close(fd);
> 
> ugh, use pread() instead of all this ? I wouldn't bother with short
> read handling, if we didn't get 6 bytes, so be it, no nop5.

ok, that's simpler, will change

thanks,
jirka

> 
> > +       return memcmp(buf, nop_combo, 6) == 0;
> > +}
> > +#else
> > +static bool has_nop_combo(int fd, long off)
> > +{
> > +       return false;
> > +}
> > +#endif
> > +
> 
> [...]
