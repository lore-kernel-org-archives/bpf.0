Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B91386A4
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643830; cv=none; b=YRO/yEAyEdJaa8viPJGdzTIcG4nhihfvLxNBe8VbZS9SyDGFhDFDJtnXJyAr8P+TTTF1CqqPxOvzAQbtCqFrXdP34o3yjDrKjj41AIE80YoXD62QG2BCZUIOCiqATgmxcNrotz0QF3lfAdBQuWPIKBsLIYeFyVqmTOQsaWC0WEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643830; c=relaxed/simple;
	bh=GzLx8CXyxdSq5vH7JAZZ7776+FKG2k4AtM3tYluwfLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khKIjY38qNdNIGVMMVX7Pus7VTMkO6+JoCzbg/6mK0KRXbIeiNCRojmYSlKefp0s+kKjrNuu0SpeHVgagQPeluxzfxTqRrCLB8AQy/rki0ppBYwpTBob0Vf4leTzMpZUEXbM1CiRNkKBTRDDl0Qsy5ShLvQ/fbGVXVQ6PqC6tJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iruIjeKb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iruIjeKb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-415482307b0so5567005e9.0
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711643827; x=1712248627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nUDRZCkgx5/3xip2LXBg5gNLMYFvJpvbSrcpUOSNmcA=;
        b=iruIjeKbemX2Z1+ZDSv2RnOKgqcy+d49A9FKAXPfEeWJsVYJiJVU8Npw0buVUfOxjk
         n+kzNcqSnNMyabGKj+apb06gSNrxQ6N1zG/Gw3bgBQcZoygVNaOZgRu32DX+ix3+YpdH
         CDY6oGoHKF/3x0naNAUu2sFf/IihMBBcRV/mpDD0ZY/ys+XO0bjk8VSHHqmLGIFAMch+
         x78D++v07HglfoqbLaOJ3/Q5Z+gIANfVJsYR3U3yueZecLDCFKte2CRGzKSthze1K4Q6
         oWGYiD2dtDOcHR6rjXPHJfhGE/rhr8tD8AF+awmjDvvQC9eWm46mbg+i0bowfD6xZsDe
         2NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711643827; x=1712248627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUDRZCkgx5/3xip2LXBg5gNLMYFvJpvbSrcpUOSNmcA=;
        b=MHk3wCExauhjqX8xINnGqAAU50+lKOwPT1IRtJEEmCKlYeEqP7G0J30quyeUPPbdsU
         ji8uHyDzs/50QXGERdEzTV7mM240wz94xAvdmZrCrEeDp+ZOQ9Q+XbebBv3Pa7lOLY3K
         8sPPIHfns0wQvlXCBl/bmnr0Qu7/Zjh86znsAIReYyQWjQwH8HQ1rP5IyZLVgQ0E0DzR
         iNJPshlzCntPp4ylU7QLjVjAalgGtZ4SaFL2woGQDbh+M8LZP3W83xR8WAifTBKv8zgD
         i+LfP2EDnop7/XJcXuDAspDma56lw0CVtkuQjCYlXwkd/V8WSbP2Kv0u+UMlX+g8y0+K
         6lMA==
X-Forwarded-Encrypted: i=1; AJvYcCVeQJP16qL4KKDJo4/uKpFaLpfZEwbWGGl40OBeCLlk0x5fxPXJY/BZRuV5c8COSFDZJN9SLdadyd2TZcDUERO2NJ8u
X-Gm-Message-State: AOJu0YyYdb0kM+rtD4MZGg69l0HbqeV4xt0Zdy0l78d6PhkoVvzldM2h
	8dJZwguGdY83umrw1vOt3K67101tyFp8tBpworiQ/03u6Dv2TsG9Bg3xebx0Myw=
X-Google-Smtp-Source: AGHT+IFj+4EhHIWdI12xkC1CNl3O7Ra5TfJ01osQVmuu6JAWAAmHjmzs8BM9lrSG6oWkJ6wIyHXPZw==
X-Received: by 2002:a05:600c:4f13:b0:413:ee55:8bba with SMTP id l19-20020a05600c4f1300b00413ee558bbamr3298423wmq.4.1711643826708;
        Thu, 28 Mar 2024 09:37:06 -0700 (PDT)
Received: from lavr ([2a02:168:f656:0:6017:91c3:e5e1:b05])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b00413eb5aa694sm2796737wmo.38.2024.03.28.09.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:37:06 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:37:04 +0100
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
Message-ID: <ZgWcsKZR23JIg51e@lavr>
References: <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
 <ZehJFP11vi5sv/eW@zh-lab-node-5>
 <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>
 <ZfK9Y5c7RuOu0YiN@zh-lab-node-5>
 <CAADnVQLXok7niyyvpUaJxq4pNFFrBP5Vsk47NNxw1V4ipBdRrg@mail.gmail.com>
 <CAEf4BzbkkrFACwWQQQkESrdRKWUvJz=NyWdrtu4v6m2aOJKztw@mail.gmail.com>
 <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com>
 <CAEf4BzY9wov5rS_MmzPWLErr8RKxKmFGV17Y2zsMCQCz6HKx6Q@mail.gmail.com>
 <CAADnVQLOB6HHgrewH48RWYkx94aA2nkqJfmzrys5pTeQibVo3Q@mail.gmail.com>
 <CAEf4BzbTgEzAv01hLWHJHHN24byEy-VWr32ijrLah-G55OS6Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbTgEzAv01hLWHJHHN24byEy-VWr32ijrLah-G55OS6Zw@mail.gmail.com>

On 24/03/15 10:29, Andrii Nakryiko wrote:
> On Fri, Mar 15, 2024 at 10:23 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 15, 2024 at 9:33 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 2:41 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 14, 2024 at 1:06 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > > What could work and what I am proposing is to pass a list of bound
> > > > > > > maps in prog_load attributes. Then such maps can be used during the
> > > > > > > verification. For normal maps
> > > > > > >
> > > > > > >   prog = prog_load(attr={.bound_maps=maps})
> > > > > > >
> > > > > > > will be semantically the same as
> > > > > > >
> > > > > > >   prog = prog_load()
> > > > > > >   bpf_prog_bind_map(prog, maps)
> > > > > >
> > > > > > Instead of a whole new api, let's make libbpf insert
> > > > > > ld_imm64 r0, map
> > > > > > as the first insn for this case for now.
> > > > >
> > > > > This sounds like a big hack and unnecessary complication, tbh. I'd
> > > > > like to avoid having to do this in libbpf.
> > > > >
> > > > > But I think we almost have this already supported. In BPF_PROG_LOAD
> > > > > UAPI we have fd_array property, right? I think right now we lazily
> > > > > refcnt referenced maps. But I think it makes total sense to just
> > > > > define that bpf_prog will keep references to all BPF objects passed in
> > > > > through fd_array, WDYT? Verifier will just iterate all provided FDs,
> > > > > determine kind of BPF object it is (and reject unknown ones), and then
> > > > > just take refcnts on each of them once. On prog free we'll just do the
> > > > > same in reverse and be done with it.
> > > > >
> > > > > It also can be used as a batch and single-step (in the sense it will
> > > > > be done as part of program load instead of a separate command)
> > > > > alternative for bpf_prog_bind_map(), I suppose.
> > > >
> > > > fd_array approach also works. There can be map and btf fds in there.
> > > > I would only bind maps this way.
> > >
> > > Any reason why we should have non-uniform behavior between maps and
> > > BTFs? Seems more error-prone to have a difference here, tbh.
> >
> > because maps are only held in used_maps while btfs are held
> > in used_btfs and in kfunc_btf_tab.
> > And looking at btf_fd it's not clear whether it will be in ld_imm64
> > and hence used_btf or it's kfunc and will be in kfunc_btf_tab.
> > All btfs can be stored unconditionally in used_btf,
> > but that's unnecessary refcnt inc and module_get too.
> > Doesn't hurt, but makes it harder to reason about everything.
> > At least to me.
> > I guess if the whole refcnt of maps and btfs is factored out
> > and cleaned up into uniform used_maps/used_btf then it's ok,
> > but fd_array is optional. So it feels messy.
> 
> Yeah, I was imagining that we'd iterate fd_array (if it's provided)
> and add any map/btf into used_{map,btf}, refcnt. Then during
> verification we'll just know that any referenced map or btf from
> fd_array is already refcounted, so we wouldn't do it there. But I
> haven't looked at kfunc_btf_tab, if that's causing some troubles with
> this approach, then it's fine by me.
> 
> The assumption was that a uniform approach will be less messy and
> simplify code and reasoning about the behavior, not the other way. If
> that's not the case we can do it just for maps for now.

fd_array is sent in attrs without specifying its size, so individual
fds are copied to kernel as needed. Therefore, this is not possible
to pass extra fds (not used directly by the program) without changing
the API. So either a pair of new fields, say, (fd_extra,fd_extra_len),
or just another field fd_array_len should be added. What sounds better?
