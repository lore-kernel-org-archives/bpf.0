Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F42E634
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508740; cv=none; b=CIO5PB7KtcwOSQgN1Z7UXkxG2EKAydCbpjDyYVSsn6w1i+l+ojiYy+Uc9rWeERQJHhxSy48pVj4TE3n2GoLOyGe15e60LIzaMzJKcgjX8QrwPW9ga20EyYzPGgXO8Ekt83mNOnuT6GhsVGkFS3vGZl8TnrDMv/9o8fOizdW37xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508740; c=relaxed/simple;
	bh=ZiY5aqBBy4wXdNf9hEy3IAUETg4rPleFD6ZuFW1SLnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL8S3OAj2LQyg7MjG4cIKVy3s7+LEdPf+AjCxHVdt/qYZrTcH1tT/xd5BhpIZpO/SHqM8HegzWXI+9RnCN+JcxvngWQNbyjTFpNX/AE6iFHswbvj4oAFydZrZSupd+v+Q0mauKv+eD5lKvhPiygmDLfh5eZmImSASk51lrssjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=bc2GOJ0B; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="bc2GOJ0B"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41324a16c9eso13369115e9.0
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710508737; x=1711113537; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VTJA5zABiIxu6ju+LJ2Lvn7FiaFJtGeYB6l9FUIHhMY=;
        b=bc2GOJ0BMZSG289ZWG5/G0/IW1fFV0k4XZFL5JUvRz2QDwBLEEzXryWxKwUhprpfAV
         RXKpPImyCvuX/PuaeRz+0gwbLmnTcCXqMI41HIDrIjPUMTfgSItt/OUi88Swv5+WLUOd
         bgFDWN4D5RXIKSPJGWCNjRp1KO0Ne1WIV1f48n02//tNdgqnjyVgkTikeqlwihyMnr0j
         iHi0FvKZ7iVE023zUxm+k9m5T0XaeA7PrP1NxeSOkbJeL8xSaOotSrh+VGzxSh67dXeh
         9aQmz+Z42hye/LH3iVnyAy0Acruz8BI6Kz9Y+WtPGZiKCq9coQ4jgs0rM9HUt3tJ093l
         RpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508737; x=1711113537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTJA5zABiIxu6ju+LJ2Lvn7FiaFJtGeYB6l9FUIHhMY=;
        b=tjylSUr66ab9Loh4iXRZgeRAizDU9/PjVAf8tnKh3r0MV0YOkwEqkylHY0Prj6Npj0
         SA9c4WDOng0fMl288ERNmwiO+uomtrTnElqdJXU6y0MgL5KqIEnVgI8+/BrSwNh+J7bu
         7fwBjB2QnfaT6FU8fqfBNoa0cv9/fe2dzfPyHzVYasBEXoR5z5/pLKNNkpSrYq0g0Pk8
         c6ptwolIMP9iLF6wby7o7Mv/Nl6znzLwBr7BIDIva7AEkazD0VSVyJD3xgsBt28OUqMa
         A1jZOtax81TGzpXfpJ9ANOYRx38N2UBv1xAolc29HP9l4kfVOTrj5p/pcX5ALY9ZN4/f
         pRsA==
X-Forwarded-Encrypted: i=1; AJvYcCUfloo6OLNOGepkaG/vaWGY5Y8qTV1N80CDUoO3rMh+Bmnt+5kBmHUacpu5gRqbWBE3+mRwVXIzmuaNPXb/is1uKGAq
X-Gm-Message-State: AOJu0YzEos9JG8Cw6g5y4gg10aKAaGWCqHvqzZU1IY8zCeokXOZjKVe0
	tAtYPujoXe36nRCnSq9p5BtoNZiq30xlcq6Rkz8wGY+lsRsb4n8Yf3NtajOuwofqCPKqvyd3v7E
	h
X-Google-Smtp-Source: AGHT+IEK5rmAr7FeIzQF8sG3lph0H5kS31lYf/Plo3NMZW0K96gORtuXMJbTNUAwugD+O+0IPqawxA==
X-Received: by 2002:a05:600c:1994:b0:413:f2a1:c47b with SMTP id t20-20020a05600c199400b00413f2a1c47bmr3314789wmq.16.1710508736785;
        Fri, 15 Mar 2024 06:18:56 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id fl22-20020a05600c0b9600b00414013adab2sm1912142wmb.6.2024.03.15.06.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 06:18:56 -0700 (PDT)
Date: Fri, 15 Mar 2024 13:11:11 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
Message-ID: <ZfRI79We8x+n0is0@zh-lab-node-5>
References: <ZcS1ZruKKZ1euzlb@zh-lab-node-5>
 <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
 <Zc9p4e1EccPkMnmY@zh-lab-node-5>
 <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
 <ZehJFP11vi5sv/eW@zh-lab-node-5>
 <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>
 <ZfK9Y5c7RuOu0YiN@zh-lab-node-5>
 <CAADnVQLXok7niyyvpUaJxq4pNFFrBP5Vsk47NNxw1V4ipBdRrg@mail.gmail.com>
 <CAEf4BzbkkrFACwWQQQkESrdRKWUvJz=NyWdrtu4v6m2aOJKztw@mail.gmail.com>
 <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com>

On Thu, Mar 14, 2024 at 02:41:36PM -0700, Alexei Starovoitov wrote:
> On Thu, Mar 14, 2024 at 1:06 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > What could work and what I am proposing is to pass a list of bound
> > > > maps in prog_load attributes. Then such maps can be used during the
> > > > verification. For normal maps
> > > >
> > > >   prog = prog_load(attr={.bound_maps=maps})
> > > >
> > > > will be semantically the same as
> > > >
> > > >   prog = prog_load()
> > > >   bpf_prog_bind_map(prog, maps)
> > >
> > > Instead of a whole new api, let's make libbpf insert
> > > ld_imm64 r0, map
> > > as the first insn for this case for now.
> >
> > This sounds like a big hack and unnecessary complication, tbh. I'd
> > like to avoid having to do this in libbpf.
> >
> > But I think we almost have this already supported. In BPF_PROG_LOAD
> > UAPI we have fd_array property, right? I think right now we lazily
> > refcnt referenced maps. But I think it makes total sense to just
> > define that bpf_prog will keep references to all BPF objects passed in
> > through fd_array, WDYT? Verifier will just iterate all provided FDs,
> > determine kind of BPF object it is (and reject unknown ones), and then
> > just take refcnts on each of them once. On prog free we'll just do the
> > same in reverse and be done with it.
> >
> > It also can be used as a batch and single-step (in the sense it will
> > be done as part of program load instead of a separate command)
> > alternative for bpf_prog_bind_map(), I suppose.
> 
> fd_array approach also works. There can be map and btf fds in there.
> I would only bind maps this way.

Ok, thanks, this approach looks good
