Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCB27BBCE
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337334; cv=none; b=kmucBMvQnL0bmz/V7FSfyfN08+5RG36voHmUUDAEW+BWkAxVMzEIbC0F5Qqqp8ad8TTemjTgE/VGLqDcISfLyBSnvE4lxQeJngziqExhdWHltCKyTBBU3mHXcXncSCsTZaWCi3drHrWZ5HMk8fR3ManZPvEKUzSzO/oBNmnc514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337334; c=relaxed/simple;
	bh=9BuWtnfHXW4qb9RV71L7OdDg9ogm2Q5Nv7okoTAA960=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaXB/SAUZXPmxY9lljuny8fZ44ux3U57qgTDn8/LnUcYU0NcCHJV7VgSI12PEc8DgoP5HZ5V4ca8jysH0B8Fmm3/a4i4pgzDgnBqiCWHIQ49ZBSL1D6IDSO5l2cNmR6s4/xvyztPpX8A9aUWsUitUfOFIc5bXPxZDVVVKQUej0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnX8uFB7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnX8uFB7"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-341cf77b86bso157508f8f.2
        for <bpf@vger.kernel.org>; Sun, 24 Mar 2024 20:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711337331; x=1711942131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIl9frHFEz+c43vQTVRPR40Lrkc53qCPKsTIXp03Baw=;
        b=CnX8uFB7oGzBGeOuxoGsoLYzfBXRv1CmCUuj4i2aXd6gArBk8buNhiWayv3UvO2FB9
         7xt+4K1OL8D1Zi7xlysdwAfnjR6UxXnRLxCBIOGdMAyqIBASyxf8TJFoU5T4ew6ozQfb
         17TSI15XEbb24sGA1SQBRp6yfqRRszmv0xskyUPn5pbkH6cVnsF6iN0bgJPyNkUafcLG
         WqUFZO4qxFYascQi9sXH2GPcqhnV9MvpdZQ1EC+c9Rq9tZZq1rPJz/796K37wZkMuado
         144MlvBABYqWu7mv0cBJm85iAl9oVzOHAHk5Q5zVNYhCTxege5upuC+l4dhI4HOuenkK
         mwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711337331; x=1711942131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIl9frHFEz+c43vQTVRPR40Lrkc53qCPKsTIXp03Baw=;
        b=ms9gDTrga1gtCWMYiXr3RqXEtOxKdmckB8zNuhzf8zY4itOX+1Mn5nmsaeCYbTYe7P
         utR6fayTpSbE2NrxE5ldoeV1VkI8OinNsfzyMzDcYQsGw3P17smjH7zI4N/xVJK2QsQa
         mJ7sDlyXsMNeeJHEh3ds/nW+iXOi03TZB9kwVs6qsZoJn9tps5xFJ+O0aHgQ9RTBdKwx
         hoBhfHYLCwd6TYG6YhnOjFQCiLqXpagiknFT0FPH2XeLGlqqgz0OXu1/SYPUgiT6dgSF
         ru8cJDY1GtwruZj1DvNhCYzNa7iYwpDT03PK4CD0MqyA+RvMgN065rIu/HfTdcWows1d
         dhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/mnxt1wwimoeqGEYKq5lSQ7nkm9+ee55hK+lG7FePI28N99MTjkhblOqOiTTN+IkM0yB8cON9kC6pi3d1nFGRZOOn
X-Gm-Message-State: AOJu0Yx5JdvhWhQH0TkNI2AwUcRjI2sS/5mcu0RFvaoxaEPy7oSeoonl
	csdL+9XjrSqTt9AwBsLG2kSeig47PZtzS/9f/wg9/35dePRo7SUeWFppPiyRvYXNfKZmyyMmr3d
	ImCZ0RnfXZlRRbvwGrVaUJ5JeYQY=
X-Google-Smtp-Source: AGHT+IHkjZ50SkF97FR//3CTHk3LA7YJF0ERIJazfnQEd7fhU0Zi8JvujkkgUCgKF4uwmX7sQUF5YsMNGJeWdqlstVg=
X-Received: by 2002:a5d:65c2:0:b0:341:8c2e:5001 with SMTP id
 e2-20020a5d65c2000000b003418c2e5001mr3751238wrw.64.1711337330669; Sun, 24 Mar
 2024 20:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <20240321180501.734779-4-andrii@kernel.org>
 <CAADnVQLWv4eeKiEEZB1QjorFvNpmPLreBr3TPscf9kry8n25Cg@mail.gmail.com> <CAEf4BzYUZPULju9pnk3hoEb1uGROqSxM9tren9a5VqT7xCTOCw@mail.gmail.com>
In-Reply-To: <CAEf4BzYUZPULju9pnk3hoEb1uGROqSxM9tren9a5VqT7xCTOCw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 20:28:39 -0700
Message-ID: <CAADnVQKkgSQk2jxgYjLgOAHvSoSqB-2HUO2G-0PwEinaBgyJzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf,x86: inline bpf_get_smp_processor_id()
 on x86-64
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:45=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Designing and adding new instruction also sounds fine, but it's a
> separate feature and is more involved and will require careful
> considerations. E.g., we'll need to think through whether all JITs
> will be able to implement it in native code (i.e., whether they will
> have enough free registers to implement this efficiently; x86-64 is
> lucky to not need any extra registers, I believe ARM64 needs one extra
> register, though; other architectures I have no idea). Safety
> considerations as well (do we accept any random offset, or only ones
> coming from per-CPU BTF variables, etc). I don't know if there are any
> differences, but per-CPU access for module per-CPU variables is
> something to look into (I have no clue).

I didn't mean to add an insn that is exposed all the way to
bpf prog and requires verification, addr checks, etc.
But a pseudo insn that the verifier can emit when it inlines
various helpers.
It's ok to add them iteratively and revise as we go, since it
won't be an api.
Like per_cpu_ptr() equivalent insn doesn't need to be added right away.
this_cpu_ptr(offset) will be good enough to start.
JIT-ing that single insn will be trivial and
you implemented it already:
     EMIT3_off32(0x65, 0x8b, 0x05, (u32)offset); else ...

The verifier will emit BPF_THIS_CPU_PTR pseudo insn with
pcpu_hot.cpu_number offset when it inlines bpf_get_smp_processor_id().

At the same time it can inline bpf_this_cpu_ptr() with the same insn.

And we can finally implement map_ops->map_gen_lookup for
per-cpu array and hash map using the same pseudo insn.
Those lookups are often used in critical path and
the inlining will give a noticeable performance boost.

> As an interim compromise and solution, would you like me to implement
> a similar inlining for bpf_this_cpu_ptr() as well? It's just as
> trivial to do as for bpf_get_smp_processor_id(), and would benefit all
> existing users of bpf_this_cpu_ptr() as well, while relying on
> existing BTF information and surrounding infrastructure?

yes via pseudo insn.

after per-cpu maps, various bpf_*redirect*() helpers
can be inlined and XDP folks will enjoy extra performance,
and likely other cases where we used different solutions
instead of emitting per-cpu accesses in the verifier.
