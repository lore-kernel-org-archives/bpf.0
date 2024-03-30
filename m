Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A743FF1
	for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711775946; cv=none; b=stsY7t6YxXK0IcJkmyldPKY5pKAbHxdWxJdqRpHJt7tpjuQwv1RNTmVcqbFDOPoPnIIWFvP4YB3MN2l8CC1OzkLT9juf+O7UcYrcrDC97CxB1I3s+vNf29WDhtvz1cKX3fwyQdlLQn2gooxI6QS37plwU0HWneN/ESb2DR26VXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711775946; c=relaxed/simple;
	bh=FXAio+RSU3JddkfLB66d2oKkFNXlOCgqHclyFsp0gCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrywjqU0tXzd63EXjAJ/XfroU1IX6SNiVLMwH0VcY9C4NeweMrQBpiGsBTMbazrqDfABYuyfLQBlnXWfPSIGL1udz+cnI1DtU3H7iC1SjY+Kw06RjdZ12Y3EVeaPf9G/MZu9WIJUsGWqZ4Oz2VJ/wWSrJDDLlBY5UyRUWdaNWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUaE3z+a; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUaE3z+a"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-221e6bf537dso1550544fac.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711775944; x=1712380744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXAio+RSU3JddkfLB66d2oKkFNXlOCgqHclyFsp0gCE=;
        b=QUaE3z+advHY3t53D/Gy/Qww3RfZVGd7nGNMqCFtxKV/0fl+iYGhrcNWCDLy9OGtv/
         9Gl9SyXwj6y0fLJSb9Wxb0dnK2jJecOgox8QQ/r0lFvRuuNJTXPRpwUcp4NL9ccGuBXE
         M9b8CzeF2bZ9Z8mL7JxPYAyDVvsimKPohp9ECAFjoDBLoo2nZrZoMLTT/e22EZll2efU
         piixs6BMdpf+u3pKC3mxpFNrh5y/yVgMxfbBCqfsfcENi5NAlY78LOz+ssYww3avsxw2
         JE3bll1Ix7KDHhlCIL8MibEpiln9/2nGaHTTKiCkn6sPYJ1TOEIlqUzattp6R8VviYyB
         D/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711775944; x=1712380744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXAio+RSU3JddkfLB66d2oKkFNXlOCgqHclyFsp0gCE=;
        b=rzLaKZggFo04nhSjXqHf/OZZgnKOctBtg3f9sQ6m9u5OxzGs5AgSlGVe6kdxwXgTVV
         yGjzEZxct7JNrGq6+A+Ez+RnGoTTKy4xfdbddd+JzLL92EMUQUUYZThS+TR/UIE7Mw5C
         PCudSiI1bK3+N84t+gpwAGQ1x9aEg/gcMuiR5oRTqeGSBBjZ4pag8pLoBBZVirHyxKBH
         QtJ6nCQm9au2hyGLer/xRr5aWb9egl92OZNQpBXUuC92GqEmoDLcmhUWK8gvr65BmDV2
         N1cnnr23XOuObNIEwzQuMwNzV1Nsb3MqyzLhunp7vU+SHWi5f5SFPEOvdqcO/Ha2W0VZ
         qt8A==
X-Forwarded-Encrypted: i=1; AJvYcCXr8cybhX0uUb2j1AiATUwuFP7H5NDqF/fjdxKjkkWaDROG960fIfmMyvnoOE2fzUpmeoRCUIjbGCkHlQWlZmD0kywK
X-Gm-Message-State: AOJu0Yzu/1Cq93fsi9R0k8fCRooUYAfxybR40XU79wLKfZDEq8ILMEO7
	QxDVFLxD/zb4K57KXxLSFs7goqmII11z/Tnx07XRkCu497nbUxaBuvDGv1AF5mak+xpyvOoT0mW
	CpBbjcNUGvsOFU5f6fTni89dyXVc=
X-Google-Smtp-Source: AGHT+IHT+Se/ggr9P9kcCcVzjsOOVaBSXMok5gvgyTwYscJyl7ksutrxrBujAosv9BJPtyO/uv3873IHinJ5gHhY6f8=
X-Received: by 2002:a05:6358:4291:b0:183:5942:c1d3 with SMTP id
 s17-20020a056358429100b001835942c1d3mr4717801rwc.0.1711775943793; Fri, 29 Mar
 2024 22:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <CAADnVQ+Df6dG1JibNrJbwT8VM5aVXJO8D=4_Bh1SK_WxYbYDkQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Df6dG1JibNrJbwT8VM5aVXJO8D=4_Bh1SK_WxYbYDkQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 22:18:51 -0700
Message-ID: <CAEf4BzY3WMhF_-Ab9ndyZFoEL6B4G_ws583F1YgWyQpwH=N7aQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Add internal-only BPF per-CPU instructions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 11:47=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Add two new BPF instructions for dealing with per-CPU memory.
> >
> > One, BPF_LDX | BPF_ADDR_PERCPU | BPF_DW (where BPF_ADD_PERCPU is unused
> > 0xe0 opcode),
>
> ADD or ADDR ?
>

ADDR, typo

> > I also added BPF_LDX | BPF_MEM_PERCPU | BPF_{B,H,W,DW} (BPF_MEM_PERCPU =
using
> > another unused 0xc0 opcode), which can be considered an optimization
> > instruction, which allows to *read* per-CPU data up to 8 bytes in one
> > instruction, without having to first resolve the address and then
> > dereferencing the memory. This one is used in inlining of
> > bpf_get_smp_processor_id(), but it would be fine to implement the latte=
r with
> > BPF_ADD_PERCPU, followed by normal BPF_LDX | BPF_MEM, so I'm fine dropp=
ing
>
> ADD or ADDR ?
> Looking at the rest is probably ADDR.

Yep, it's all ADDR.

>
> Feels weird for BPF_LDX to mean dst =3D src + percpu_off.
> Should it be on BPF_ALU64 side? Like a flavor of BPF_MOV ?

Yeah, it felt a bit out of place. I started with BPF_MEM_PERCPU, which
was true load instruction, then realized I need per-cpu address
instruction, so I just kept them close to each other. I'll look at
BPF_MOV flavor based on off.

Would you like to keep BPF_MEM_PERCPU in addition to BPF_ADDR_PERCPU?
Or should I drop it?

> We have several of such flavors:
> off =3D 1 -> arena
> off =3D 8, 16, 32 - swaps
> off =3D 2 - might be nop_of_goto
