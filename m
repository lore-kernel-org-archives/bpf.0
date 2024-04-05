Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F75695
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712278383; cv=none; b=c0QT/rC/G0y64D1HeR5vfgkTF47nap9HYHvD9K0Y1VCFXJUqWvqLcMZ19+IcdYGGxOiSmKWMwWUMg22/Kr4IrRb2kZZ86/s2KdfD9vZeR0odR6kqSL7qU/gzCQfaUBwn5e1fFO+htE2rpiTQcYO5cA7TR0TlzElJdtPJvjUxEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712278383; c=relaxed/simple;
	bh=Kee0MgXbkUHg7P5r7OocJjrng78TJPJ6fwzSXtx9Cns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LP6Gzn5Gp0yGoS44yCa6uvTHfaJFlkdHsL87y8ltBXHSj2nY5qikzpdvx/3I0W4wFlPGrLiedfRDd0OWjG1ckGr/EleEapegvSNPc0QuxMuXytq6UIPVjAloaZc6WZoJ4p5oa3WxLIqPpRg1nOt0Itt/Wf8HYIsW9nZ8DNAU79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=C8Pvm7xL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="C8Pvm7xL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2987e9d06so14328675ad.2
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 17:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1712278381; x=1712883181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP0iw3RrEfmdaNKTjoD8icGc86aN3gyG5S0vkIYL9uI=;
        b=C8Pvm7xL5OufkpBfnk72h9Y3/NALk40WbsIBB+NdS/5LkTijN+RJrgljh+xFo+fpxK
         5FvhDC05iSSioNb2DvCBYcdW1ssJnJSrg8wWGaw+n+dWguqhLTW+VUVrVvAjb/WoDf+1
         /NKJI13xz72YY+xb2o478f/enkqEfyNqoazKu7IkuP+c6PPF86k8vXuSPnKwhj/7y6Ih
         BYlHKusUrtMLjJoUce/oSwUobLBYUXCuImT1aZQ0wdMrmQw1r9nzWSA07TETR9wDv5Nt
         5Z2BMLF0/P+oNN6E5v5I3Lq0ITbt3gFx3JtjGtUL3jQug3UJ2jzwemUHfC10TrwF8T87
         bM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712278381; x=1712883181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP0iw3RrEfmdaNKTjoD8icGc86aN3gyG5S0vkIYL9uI=;
        b=qjHZ9lh+jfwy4WphBpf5Bl6aii7k/dfcjkT91ZSKh8G0Yl8NBd/DCmaHh+nfiagqMy
         CkM7CTSuXfjyzrzz9RKZ63GcXVtGA4y+KoU61i03ZC+MS+8PZ8DXOOiC/VuQP+t84Fdz
         J5UmHTr3YlJdtBka3eeUPKUlrgI61ts7duX2u/JwZrK/IVXN8AuI3cCNHFc2WG9s2IHR
         oGbAQ3/7NFgprYpEvjBEBsbRPilm0u2CRIwu9NFa7rWGGWlTeoid+cE9ZpbqxK9LsqgZ
         JtajdH2pK638qxVcMf1T4KIMv+Xjaoes2jk6WA4ga9AEHVcokiMVi341GZA3WCRi8p6w
         /7ag==
X-Forwarded-Encrypted: i=1; AJvYcCWIOUERAQaKt1OvvIauZ/zE7eeI2+BC5h8SicDFjXc7LiUnAUUwtCa6JR0J4dBvVbnMY+58ZW8sOkD3jiUeesxB0fDC
X-Gm-Message-State: AOJu0YyI/iy3x/rMjpxy2Nwmmu5Jde7fCOwS61+8ZzaOE1kTiOeJO1cB
	FdO/E5QK62Lxg9GTOcx3TSXqtdzkfO5DNyrF+vptU0I/z+xftrw8AwFIE6LOnhA=
X-Google-Smtp-Source: AGHT+IH6gMEzMnNWQ9Y460NHlMhnEoIrmjckwYujeEe/HK5ppp7TfQSAdBm4VVsOa864SIGCKziirw==
X-Received: by 2002:a17:902:b788:b0:1e1:a54:1fe8 with SMTP id e8-20020a170902b78800b001e10a541fe8mr31168pls.53.1712278380927;
        Thu, 04 Apr 2024 17:53:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001e23e8fd808sm258897plb.217.2024.04.04.17.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:53:00 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:52:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Luca Boccassi
 <bluca@debian.org>, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 bpf@vger.kernel.org
Subject: Re: vmlinux.h overlap/conflict with network protocol definitions
Message-ID: <20240404175258.363f441c@hermes.local>
In-Reply-To: <CAEf4BzbHbXHixPAEJccnrgt5xtV+d1iyvQYdC8Dpzs3cWdCRcQ@mail.gmail.com>
References: <20240404100901.7d6bc10f@hermes.local>
	<3ae7e58f-e62f-4d53-8b39-6e3fe1810014@linux.dev>
	<20240404112710.25d4e99d@hermes.local>
	<CAEf4BzbHbXHixPAEJccnrgt5xtV+d1iyvQYdC8Dpzs3cWdCRcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 14:45:04 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > > This is a known issue as currently vmlinux.h does not support macros.
> > > There are some efforts by Edward Zingerman to support this but this has
> > > not done yet. At the same time, you could have a trivial header file
> > > like
> > > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > > to be used for bpf program and then your bpf program with vmlinux.h can
> > > have much easier CORE support.  
> >
> >
> > That is an example of header surgery which I would rather avoid having to carry
> > as long term technical debt baggage.
> >  
> 
> What's your ultimate goal? As Yonghong said, vmlinux.h is not
> compatible with other headers. So you have to pick either using
> vmlinux.h as a base + adding missing #define's (because those are not
> recorded in types, so can't be put into vmlinux.h), or not use
> vmlinux.h, use linux UAPI/internal headers and then use explicit CO-RE
> helpers/attributes to make your application CO-RE-relocatable.
> 
> It's not clear from your original email why exactly you wanted to
> switch to vmlinux.h in the first place.

Some backstory. There is not an existing TC filter for this, so the
original developer had the idea of using BPF to do it. 

The program is a small BPF program to implement a TC filter that looks at 
SKB and does mapping to queue based on L3 (or L3/L4) header. So not heavily dependent
on kernel data structure, but sk_buff is not necessarily stable; actual layout
depends on kernel config.

But the evolution of BPF has made the old code unusable. I am trying to get it working again,
and cleanup to modern BPF by using BPF skeleton code.

Luca was one who had the suggestion about vmlinux.

> Using bpftool to generate the header at build time is a bit icky,
> because it will look at sysfs on the build system, which is from the
> running kernel. But a build system's kernel might be some ancient LTS,
> and even be a completely different kconfig/build/distro from the actual
> runtime one.
> 
> We have ran in the same problem in systemd recently, and the solution
> is to have distros publish the vmlinux.h together with the kernel
> image/headers, that way we can rely on the fact that by build-depending
> on the right kernel package we get exactly the generated vmlinux.h that
> we want. This has already happened in Centos, Debian, Fedora and Arch,
> and I am trying to get Ubuntu onboard too.
> 
> The annoying thing is that every distro packages differently, so the
> path needs to be configurable with a meson option.
> 
> Feel free to pilfer the systemd meson glue:
> 
> https://github.com/systemd/systemd/pull/26826/commits/d917079e7e320aa281fc4ad6f8073b0814b9cb13
> 
> It's of course file to go to the runtime kernel if no vmlinux.h is
> specified, as a fallback, which is going to be useful for developers
> machines.
> 
> -- 
> Kind regards,
> Luca Boccassi



