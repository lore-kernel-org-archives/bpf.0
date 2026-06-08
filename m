Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDD3CC7F3
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930320; cv=none; b=bj7hoyOSJv0my1WDU91v+s4RxlAZPyxhsjkCbbx7rhk366zaIKlNKFcCwNoB+Mh3aG5XStF7Og41kI+JUX5FyYwf+gW6bMEscBVQcl3AzHEpzlE+Lu52jzQsm7x4dMPZwgbkQwmuT+lPh0Zys+q82Bt+6QvRbNIN3Shm8/hk+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930320; c=relaxed/simple;
	bh=jjdoee8A/UvKLL/NSAvBhFmYk3jMveTG0G8NbasCwis=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qB8bffWLprz290cZXPYEFA+w0l3K7WzOZlRd88dXXEB6bf668igZJ5hZUGq8+oRCmzCHiFuIGI8F7vfcm2MawJ/WAVrsX/3s8DxPy8IBA8RmQq+Dm0xzj+h42flgoUXQY2RgxX2y7hPDrrGybhRh/soYsU/sLct1zu3pAw4WSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYjCKBEW; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYjCKBEW"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b7866869so51368145e9.2
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930317; x=1781535117; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjdoee8A/UvKLL/NSAvBhFmYk3jMveTG0G8NbasCwis=;
        b=EYjCKBEWpYnYWGowfNu9rYoJE4wERGpGqcGNzjWwJJgkQHyTx8rXjV78RcM0Ul4LjN
         09kXOnNzve+RUvSpkcaHFiACcmbfKxdmj3+1ny/qTrL/jUA7gs0nGTm/cnlcwxAy5VcW
         ibUXq9lW7wewRzhHGUPsqd3G4wfhF5lZGpSZigW7zPccnf8RX4YdBGdbx0oTzdy3NWo8
         t6ZiMir03FNf9Ewb/uGOorrn4Eo/EdrweXF11jHNpdHIJdzSCLVin/x8I7RfQFK7ZhoA
         j3pF6exQd+/yyaUYLCJXmXp10hVGCqqEZhNjRRw9Efkxy4k5/Yc0Z8hYdPP5Cjw3vHz7
         47RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930317; x=1781535117;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjdoee8A/UvKLL/NSAvBhFmYk3jMveTG0G8NbasCwis=;
        b=cAxTiya9ASjdVoceUMqXwm/dpMWV3VSEzcdc4vozu7k+zuFF0lbXMM2Jx4qLqkPXxA
         xVvOEuGRCu14MDIxJ6Pfe9T5Io3E3jZlH4sHp8L+l7ue4DolZNDdZetI0LzDhrrE/AQi
         3YN27je4BfQbqnTHWq6uadAZ85jPn+VfZRjQIGs72iuG2B9hkv8O2PSNBVafdJq+1P4A
         VcQPtVAaUUG4UFlZZsNJWUPJbqfrBZXNi1yEmibyYOYBxx/1EPOG823tmzbX3JEB06LB
         lmDi1T8zdpQ/php9aVX5bCUrcWnlnuXW3j/gvFHRYfOV/k49e36OfydYjGIKK0syJV2a
         SBog==
X-Forwarded-Encrypted: i=1; AFNElJ+YH0KTAO4eN4LoUfS3ocE6io9QwKQT/TwhEM2b/CXdOFmhLoh5YrF4MMqDsTpCD3/CTo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBgwm652KzcxhgMVvDXT2y+TquSkrpU40u57OqwTBYpq+Atva
	sA4i2meWpgxdCCPIYazgKDdZlfkdRbwvxdroczhZWUJSgMXrUirGzosE
X-Gm-Gg: Acq92OELFyC5cyMp89zj2c4SZ4AlLHSUj81msW1iUuNBx0jhRKlkJ/GakJVju5pYmGh
	BpL52IcladQTwqByVUic/467UHGPYkSAli0Bn6dYSTAIg4L81hNDH26DCOX9aV7QxDdn7vVZV2u
	c1i/ryiweiAibvPtNIwtz1Dj9GHXbjYmgb70bzCAmJOtYUWfNOBVuZStbToeeXRt3K2hs9A6ysm
	Qg3XIFQtzgkblyGXtHA+g4zXxAnhClR8Zd13F5uGT7MyNsFH89bijFSO1c/r/gCpTII3/n7m28D
	xLfA+FS0ZHoyKLVie4r5irklMYpYjyLxfrtqfUW/A6v8DihRYoYvvSo1dJycx66Uoy1F8we7Lc7
	/DAQylizzw5vPH1xAi2jQysJbuRzcgYuqXcs5vXmF8duzcAuiKGtSZ8d4WzGPUMdB+PzKtkBvU2
	MHoTdlJuCY/oHKPgqS58T0S4vEgrSsHNZgkvH/L/kwQhHuFPW1Z1ASL/ol4sDmPMJs/Bx/Akn4m
	8woj85pl1DD0g81gEo2SSCNLlc3omDSjfUKgzHI7ZC+fMTZTBjrecyxGEfjJBoxlNzG5Vecg7+9
X-Received: by 2002:a05:600c:818c:b0:490:b0e1:2161 with SMTP id 5b1f17b1804b1-490c25b39fdmr290749675e9.2.1780930317552;
        Mon, 08 Jun 2026 07:51:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm54980209f8f.28.2026.06.08.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 16:51:56 +0200
Message-Id: <DJ3R3WUVLHHB.3MOBZNZHH5KA9@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Justin Suess" <utilityemal77@gmail.com>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/5] bpf: Treat non-iterator tracing progs
 as tracing
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260608144841.1732406-1-memxor@gmail.com>
 <20260608144841.1732406-2-memxor@gmail.com>
In-Reply-To: <20260608144841.1732406-2-memxor@gmail.com>

On Mon Jun 8, 2026 at 4:48 PM CEST, Kumar Kartikeya Dwivedi wrote:
> The is_tracing_prog_type() predicate omitted BPF_PROG_TYPE_TRACING even
> though fentry, fexit, fmod_ret, raw_tp BTF and similar programs have the
> same execution-context concerns as the tracing program types already
> covered by the helper.
>
> This matters for map compatibility checks that reject bpf_spin_lock,
> bpf_list_head and bpf_rb_root in tracing contexts. BPF_PROG_TYPE_TRACING
> programs can run from arbitrary instrumented contexts, including places
> where taking these locks or manipulating graph roots is not safe.
> BPF_TRACE_ITER is different: iterator programs run from task context, so
> we continue to exclude them.
>
> This can reject existing fentry/fexit-style programs that use map values
> with these fields. Such programs were accepted only because the
> predicate missed this program type; their use depends on semantics the
> verifier already rejects for equivalent tracing hooks.
>
> Move is_tracing_prog_type() checks from check_map_prog_compatibility()
> to points where the fields are actually used to avoid preemptively
> rejecting tracing programs that use maps with such fields but do not
> touch these fields.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

This particular patch causes regressions for at least one production progra=
m
using bpf_spin_lock() from fentry, and a bunch of selftests (which are most=
ly
due to the movement of the checks, and usage of spin locks in tracing progs=
 that
can be adjusted). As such, there is potential of breakage here, but it also
implies the current behavior is broken.
