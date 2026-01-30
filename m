Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA62EB5CD
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810636; cv=pass; b=Chj7gVbM3ZsSUXKaQMe6HSus61DQddOSV5ZR6gpuEUqvk60F2+YWYIpUoGb4Fed9AHBC6EZJbRjrmWWKFnYCsFu8cTaauC79v565eOl2+gHfP0LUu8pyF+cBGTXGhPmp9ofawZAATD3rgsEr7CRGAclptH3DSRUgAjdrMSAT6Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810636; c=relaxed/simple;
	bh=Bb/HK+Jxqu/bZEMHo0VCrEK8yIl/n3wdw03VnyAGl6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOLgBOK/jMqxw234NjOyP2IM/ZpB1b4Hjn1Ud9YA14cyFSjzitrg2Ktyd++LtOEWToyBYZ2u93m1zxRkseWWs+xgFJ07GQnSdA72oy9Fq/4v4Ngwa+WaurmOoOEYo2/G6uZWRnc8740FrAGUkla1I6gO3VtRjjn588xyXhsJINk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAn9q/3E; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAn9q/3E"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso964802a12.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 14:03:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769810634; cv=none;
        d=google.com; s=arc-20240605;
        b=h4VtTIq02auFyW+p0/aMNGxAxS4GalTQ2KbooiTMgCH4SwD9zu4FrioFY53d2HyYA/
         Hfvvp7krzdtVqytq8+2TEctxB+V9Xad68AZGuKVC91TkAJHdkaxk5UOwuvWsAw2nWw2D
         wn4csKmBfqtDC3WzRydgTfXKKMV0uPhLct8uX61vrMnFrwUabflv0F0VyTzqOWNCL6TU
         RYzwpKUJwOjk4vzB08S+E1PUtutMW2Siz7lTEm1o2dZctJS+nRRf8wwII5sDgfKGGgqI
         rtfIYAKFbFBPdkO25jK/jzUH+lLcXHDwH293+tlyAVbYmfeWcsnlLJSZUxXvHq2ZJN/B
         mhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bb/HK+Jxqu/bZEMHo0VCrEK8yIl/n3wdw03VnyAGl6Q=;
        fh=ls6BEsJ1pE4V+FW+opAW0qfiL4O3iHF/Fd9aZUQnThU=;
        b=FDW7FB3z6R7OL7JCbNvDV5lfE6uDiO7dAD0OBdztk2gmXpvZWaZ9Xg8GcRSsc0+D1f
         J1w8K2r0sto8bntDDF8r9YHtkFdOo0bfk/x2NkRakhlO0sV35zE6WY0ajzovRBkTUXBS
         pBdQt6O45SOB3eVLSWhZCLe63zi+0a8w6zB9M8rRlWifUAe14GJwCXU2mneFHkjvk0nd
         7gTrvY0AvSFsMgcKSpOa41gMjVK4yzjY0BODa3T+m+piPsM+N13JDLRHsCBWd6MGztis
         viA5OzYwGvWPw7DGd17YjViYhjb45ovg9DWN7PyGIvrEQkGXtPHHLpXJNqcHSK8NEZIR
         ZNaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810634; x=1770415434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bb/HK+Jxqu/bZEMHo0VCrEK8yIl/n3wdw03VnyAGl6Q=;
        b=WAn9q/3E78IYWtqnug6ST2lU93xf78j60kVvxn8qO/+067An4MQWSAnio9OieA6m7E
         2AghVRQCBUWI5RnM4HOQ6Ov/+StIdQMSSynO7b3mpPSAOXje/51meNsC4Jgg3DQTiQYr
         cgUyU9Se5RSxB7EWYcvwJtieKq4OiC2rA91WOw+6IFEaosok0dbqkqjXSKbVfK5ZCzTI
         Wwh+/hr5OmiGA8fN2MVgihUKbw1rYp/QAPeBuvZptG1w1m+VdyTRInRDFVnsLunhfSKz
         V+SYdbGMq3pfHIdZmCkcU1mVH2SH5UV9x7hpfaquNh/9GboKm7oYJFY1UgbD9z3Jpo5F
         6OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810634; x=1770415434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bb/HK+Jxqu/bZEMHo0VCrEK8yIl/n3wdw03VnyAGl6Q=;
        b=LgF61Nu0LsE/AW0QKTCGo9XhP2WOiHhbfCh9w/Thgspf9z5bX9usYbiRnEM3TURUrz
         H9m07DrZ4C3Ht7lpSEsXMsbOfi8eSNGPq+FqXr+4/tzptFnKmDXzk+gTq15CuN/3eszJ
         mFGg+ZoTqzKC7LIvBIWP14l3IKq9tmvvsXE6oLe2qdSHRU7IVNB1RvYpP1PKruIazP+5
         2h9ELDhj3+/DnpBvG+D3ObB1Ow67lU4n58VaA5Td4e6kBtvkDCZtoJURI5pqjRu98rNt
         B30UFKBX+KXB+CHoivshSfqDmQjdMXhHPOC2vCDUqZljCAQjRYoKMpVuq4r7UC9UIu5g
         y4mw==
X-Forwarded-Encrypted: i=1; AJvYcCW6R4aei1zlo5RkEETr+KVi4UUBmxdFARB88bSjWAWfDPfgF6W96Gd3aHR6S7RKEeHfoec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89FBnRF5JwovYCW9eUSXBJBkZbwBXiHIvu5LTsumVY8LeuCdQ
	s/kEiPTyUMp0MyLEJ/ezZWeZwAvO4L92vdFZasg9+BWflY67X/wekCmskxFl5wQhi/D/3ANOynU
	9nqrTHzz72nBEXD7oNuuItygSUr4hVqE=
X-Gm-Gg: AZuq6aJHOQbz47dvcsnyRSWrTCDCh8qBe4b58DEkJVNEhnVDTa3k1nxvWWX7gq+Wuw0
	qQmr9Fwku75DI+z4aB3OcatDqnyvOsJcWe1UViqUdJ+LfJ70K+8VP7CGqUaVWpunyXHUziwJKLC
	l3+GawY2yB7Lzg3a59TlCIlBc7lLxqRtN2OLTbgd1eJVC+aO7+bWUCRdaKcvoo7NRoCl6QiJcSZ
	1rsTiJ8/1fAJjj1ra4VCwO5etnaEkxumOmmWuNVxGgIq+mT0kPOigOPBcc1eOLwLwE7g7sCTt0Q
	vjsEGAYdPk2A8P0ceq999A==
X-Received: by 2002:a17:90b:2e41:b0:34c:635f:f855 with SMTP id
 98e67ed59e1d1-3543b2ebf18mr4695846a91.7.1769810634135; Fri, 30 Jan 2026
 14:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
 <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
 <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
 <CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com>
 <CAP_z_Choy4Pe_VgdxwFzkUo4P71+TA=xAM8kov8QacGpRS5irg@mail.gmail.com>
 <CAEf4BzaEiQ8FApp1KMrCvsBVs+xLrk_mtQFUCfXZ3co2D6Oayg@mail.gmail.com>
 <20260130152400.6a71abb8@gandalf.local.home> <CAP_z_CjZWFqyKAti_NLtq7QhiJfwVXhohakQh2yEFS_vLsb4zw@mail.gmail.com>
In-Reply-To: <CAP_z_CjZWFqyKAti_NLtq7QhiJfwVXhohakQh2yEFS_vLsb4zw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 14:03:41 -0800
X-Gm-Features: AZwV_Qg3gWgp5O22UD0xDiKnS0RnLl1MrFVWQSRWOqcLOMHi247gJcY3hdyQ2Xs
Message-ID: <CAEf4BzYq117=EbJ1ovpr0YBQr=myvxwF4uetO5umL4P27yAcDw@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Blake Jones <blakejones@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 1:41=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> On Fri, Jan 30, 2026 at 12:23=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > Blake, did I explain that correctly?
>
> Yep Steve, your explanation sounds correct to me. If there was a way
> of storing a non-constant amount of metadata in something like
> task-local storage, I would have a solution.

There isn't (AFAIA), but you can approximate that with a global
hashmap keyed by task's pid + whatever the original per-task key you
needed.

>
> What I'm hearing from Andrii is that fixing this is my problem - that

bpf_get_stackid() and bpf_get_stack() are working and will keep
working as before. Which, for user space stack traces, means capturing
stack traces in a best effort way based on the frame pointer-based
unwinding approach (assuming the user space program was compiled with
-fno-omit-frame-pointer). If it wasn't, or there are some function
calls not preserving frame pointers, those BPF helpers will return
garbage or partial stack traces.

Nothing changes about that.

> "user stack traces can generally be taken synchronously from arbitrary
> places in the kernel" should be thought of as an implementation
> detail, not an interface. To me, this seems like an example of
> https://www.hyrumslaw.com/ - this has been reliably possible for
> decades (modulo paged-out text, which again is probably not

This has never been reliably possible if you didn't have frame
pointers preserved. Are we talking past each other?

> performance-relevant), and so I do think of it as an interface. When
> I'm making interface-breaking (or even "interface"-breaking) changes,

Point me to "interface breakage", please.

> I view it as my responsibility to try to help out consumers that are
> broken by it.

Who and how is breaking you by trying to support asynchronous
SFrame-based stack traces? Do we remove bpf_get_stackid() or
bpf_get_stack()? Do we change how they work?

Or breakage for you is that bpf_get_stack[id]() can't magically
support SFrame stack trace capture **synchronously**? SFrame requires
paging in file contents, which means page faulting, which means it
cannot be supported (not reliably in any case) synchronously from
non-sleepable BPF program types (which pretty much means any tracing
program type).

>
> So again, I'd love to get some ideas for how I can make this profiler
> work under SFrames while still aggregating data in the kernel. I
> strongly suspect that mine is not the only profiler that will be
> broken by this change.

Of course existing profilers will have to come up with ways to support
**asynchronous** stack trace capture. How to do it will depend on
exact data flow and might be completely different in each case. There
is no universal answer, and some models (like those expecting to have
user stack trace as lookup key in any context) are just incompatible
and will have to be rethought.

>
> Blake
