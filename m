Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6E16430
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964743; cv=none; b=vAvgF8vYy4x6fpR2cIbkpecjWiTrmaUDDrElTXfEIKGpEF6nCObCYt/fQmmpPjHHTfAaZTSXD7wEtQBjVkA3CGT5WEjNLUIqFnPSkU7UljlhtuTaQjQXokuGV7Sr+stfjsYEUKfZyh6whSg4EaieMWZPg9mLDUPH3Que8vGrKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964743; c=relaxed/simple;
	bh=Xnir7bE2MdnVZAz9YFVp0FfbvxDkRagirVcGNWwrTaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLPA0KBHKASGpdmJDOIrCWlsY1xsK022MmDAI0uwmzThhZIh4VtUkBHHz9Hu1YnOacw+5Bpli7+c6M3mRbsXbk4CAqxn2cpC/pFCJhhE/U8I53GUWa8nGpOVEdRbiAIodJGURK2eIIGJVTV0fTwICQPaajWVQHYvemlm8pFyJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=KtxQ10Vk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KtxQ10Vk"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-415515178ceso15112945e9.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711964740; x=1712569540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KTWj/FPi4ObdvvImdKRLHz7YPuEfL9j4fg9pGXL5/lM=;
        b=KtxQ10VkR2X/24TocM1vz0vIHb04UtA+L1Ft7JNlWmJpxEMgu4Ivg1LevxsHr/GQL+
         RrwSZUyKk851fhQKHS0r2YvofQX+skQLwO/TJRBf4dtyz9EvlAFSo7m6bIq6ALnWywjV
         LWoyl43+wbZHAmCKEbVji08m2OYUxhiDAhfeZROKLGQCiOAEZveXJqOhCDc7G4Yu07gD
         IygDgS7JAR+KfvnaHaMLkiEgHhC7PPM4kyJWF1SFLDiTMlWZASLWxikLzFgqO1lIGrWA
         sK+ha9Fx8qg+QWRpWJ/1hXHTSMjyOD8Nbsdojoh1xfS7OWhnNfsVi0T7BdW3E5L/Crtg
         rc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711964740; x=1712569540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTWj/FPi4ObdvvImdKRLHz7YPuEfL9j4fg9pGXL5/lM=;
        b=W/cXC6O4QUR2w2oLBG2LwQTbOJ0Jj0fdRR4kGfZUzuB0f5gGvfL4nMzFlROEKqxxR7
         1W8mAkwJEaflB5/rPuJOBJBjwWUicULVX/2LZLGdYRRvd0rUphgHfjDDR8Y32FaGAszd
         Ve3gHiLAN3Nxz12QGhLE8JafIxmVfuSmDVW3K3bg1Od06tRbOib8rK1cTZhOSXkXbk+3
         kUeG0Ox3beQq55K4Pf/u3UQkhA8sEYwGJG1JxgGI/IwQSnoL4uslxzyVNht5MyCDwpgi
         CENy3A3kirwGpN4LHcnERPQua8aGgsJYKbWgYYjbnr3ykjzulQM6evGUWTOVHK0OksWL
         5RNg==
X-Forwarded-Encrypted: i=1; AJvYcCV1NzNvZX2ZbwGDDTtLdrSw3Aisp+Sxvz7QQKJ0GNYJ6pu5G5NjWdH48QzT1xrH8x3Pxk1rF5KiOL1zlyyqnztwS6Hj
X-Gm-Message-State: AOJu0YyDq23Z99Ia7/KeL6mnHKSGCK6XzRogbqLwNJfO8mK+ewWCfrKV
	VJfWMq6ipUFm6SqCXmNGOvL3eA1kOpaZ+W38yNp3p9i7cc88vPokqnEDcHjqAHg=
X-Google-Smtp-Source: AGHT+IEh7Si4ES1hcx8woq2y2VVXxpXAiDR8CrY77kGuL6BHc+4/QNTCmKKjLe6vbJNYmHevAv+zTA==
X-Received: by 2002:a05:600c:458b:b0:413:1741:28b5 with SMTP id r11-20020a05600c458b00b00413174128b5mr6727686wmo.9.1711964740190;
        Mon, 01 Apr 2024 02:45:40 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0041493aae77esm17451049wms.23.2024.04.01.02.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 02:45:39 -0700 (PDT)
Date: Mon, 1 Apr 2024 09:47:38 +0000
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
Message-ID: <ZgqCuuGSP8cmMvXz@zh-lab-node-5>
References: <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>
 <ZfK9Y5c7RuOu0YiN@zh-lab-node-5>
 <CAADnVQLXok7niyyvpUaJxq4pNFFrBP5Vsk47NNxw1V4ipBdRrg@mail.gmail.com>
 <CAEf4BzbkkrFACwWQQQkESrdRKWUvJz=NyWdrtu4v6m2aOJKztw@mail.gmail.com>
 <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com>
 <CAEf4BzY9wov5rS_MmzPWLErr8RKxKmFGV17Y2zsMCQCz6HKx6Q@mail.gmail.com>
 <CAADnVQLOB6HHgrewH48RWYkx94aA2nkqJfmzrys5pTeQibVo3Q@mail.gmail.com>
 <CAEf4BzbTgEzAv01hLWHJHHN24byEy-VWr32ijrLah-G55OS6Zw@mail.gmail.com>
 <ZgWcsKZR23JIg51e@lavr>
 <CAEf4BzaMtK1D7yo_FWHEbF8E_SE9Pqte0u8uFr56CaBQSbYfeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaMtK1D7yo_FWHEbF8E_SE9Pqte0u8uFr56CaBQSbYfeA@mail.gmail.com>

On Fri, Mar 29, 2024 at 03:44:04PM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 28, 2024 at 9:37 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On 24/03/15 10:29, Andrii Nakryiko wrote:
> > > On Fri, Mar 15, 2024 at 10:23 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Mar 15, 2024 at 9:33 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Thu, Mar 14, 2024 at 2:41 PM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 14, 2024 at 1:06 PM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > >
> > > > > > > > > What could work and what I am proposing is to pass a list of bound
> > > > > > > > > maps in prog_load attributes. Then such maps can be used during the
> > > > > > > > > verification. For normal maps
> > > > > > > > >
> > > > > > > > >   prog = prog_load(attr={.bound_maps=maps})
> > > > > > > > >
> > > > > > > > > will be semantically the same as
> > > > > > > > >
> > > > > > > > >   prog = prog_load()
> > > > > > > > >   bpf_prog_bind_map(prog, maps)
> > > > > > > >
> > > > > > > > Instead of a whole new api, let's make libbpf insert
> > > > > > > > ld_imm64 r0, map
> > > > > > > > as the first insn for this case for now.
> > > > > > >
> > > > > > > This sounds like a big hack and unnecessary complication, tbh. I'd
> > > > > > > like to avoid having to do this in libbpf.
> > > > > > >
> > > > > > > But I think we almost have this already supported. In BPF_PROG_LOAD
> > > > > > > UAPI we have fd_array property, right? I think right now we lazily
> > > > > > > refcnt referenced maps. But I think it makes total sense to just
> > > > > > > define that bpf_prog will keep references to all BPF objects passed in
> > > > > > > through fd_array, WDYT? Verifier will just iterate all provided FDs,
> > > > > > > determine kind of BPF object it is (and reject unknown ones), and then
> > > > > > > just take refcnts on each of them once. On prog free we'll just do the
> > > > > > > same in reverse and be done with it.
> > > > > > >
> > > > > > > It also can be used as a batch and single-step (in the sense it will
> > > > > > > be done as part of program load instead of a separate command)
> > > > > > > alternative for bpf_prog_bind_map(), I suppose.
> > > > > >
> > > > > > fd_array approach also works. There can be map and btf fds in there.
> > > > > > I would only bind maps this way.
> > > > >
> > > > > Any reason why we should have non-uniform behavior between maps and
> > > > > BTFs? Seems more error-prone to have a difference here, tbh.
> > > >
> > > > because maps are only held in used_maps while btfs are held
> > > > in used_btfs and in kfunc_btf_tab.
> > > > And looking at btf_fd it's not clear whether it will be in ld_imm64
> > > > and hence used_btf or it's kfunc and will be in kfunc_btf_tab.
> > > > All btfs can be stored unconditionally in used_btf,
> > > > but that's unnecessary refcnt inc and module_get too.
> > > > Doesn't hurt, but makes it harder to reason about everything.
> > > > At least to me.
> > > > I guess if the whole refcnt of maps and btfs is factored out
> > > > and cleaned up into uniform used_maps/used_btf then it's ok,
> > > > but fd_array is optional. So it feels messy.
> > >
> > > Yeah, I was imagining that we'd iterate fd_array (if it's provided)
> > > and add any map/btf into used_{map,btf}, refcnt. Then during
> > > verification we'll just know that any referenced map or btf from
> > > fd_array is already refcounted, so we wouldn't do it there. But I
> > > haven't looked at kfunc_btf_tab, if that's causing some troubles with
> > > this approach, then it's fine by me.
> > >
> > > The assumption was that a uniform approach will be less messy and
> > > simplify code and reasoning about the behavior, not the other way. If
> > > that's not the case we can do it just for maps for now.
> >
> > fd_array is sent in attrs without specifying its size, so individual
> > fds are copied to kernel as needed. Therefore, this is not possible
> > to pass extra fds (not used directly by the program) without changing
> > the API. So either a pair of new fields, say, (fd_extra,fd_extra_len),
> > or just another field fd_array_len should be added. What sounds better?
> 
> I'd say we should extend fd_array with (optional) fd_array_cnt and
> have the following logic:
> 
>   - if fd_array != NULL and fd_array_cnt == 0, then only maps/btfs
> referenced from BPF program instructions should be refcnt/fetched;
>   - if fd_array != NULL and fd_array_cnt > 0, we can eagerly fetch all
> FDs and refcnt, as discussed. If any instruction uses the fd index
> which is >= fd_array_cnt, that's an error (the user didn't provide a
> big enough FD array and we can now detect this).
> 
> WDYT?

Yes, thanks, I've thought the same way. I will use this API
