Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781315B129
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083784; cv=none; b=ZtODZ7rbPo5t8k1KTL0yxkkbugcN5Wz9//v93pZMbRzw6Lj0X12mRVy+sCzozKwN26kTrwU9ddtcJgN08pQKCwpgVJLY3eVufsQHM4KZ+A6hlGYZCYQfVXM0LhfF/Jju7GTjqZrkEYlr2tNGAc1PWiyyn5wvPJEzB6Z3kpqqdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083784; c=relaxed/simple;
	bh=weISqq2A6RI0H2LbwN7F+0X9UdQ8TvO+tJz9Kd/Hf90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iR6ad6qBY4z/5y0DivnTmDg1UAqcJn14fM2HkxXiQj7DMeUzPgEqsc/45livGoV/TbGRJcC+h93lkPvt5Aex9LqjhE/MmGcZyd/i4llvw8JKYx8GQWx3gEtbMDCZJ7XLWj6jKR41jDWtujWOifJbATluw34ArDksmlzNNkeJyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wis1wMJZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wis1wMJZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e28d7b03e9so9685ad.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712083782; x=1712688582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=588W+WKWGCHDk22Ud5hS9stI2LC3FAq1GuSxHQ/M9as=;
        b=Wis1wMJZR1p7IRF3wzWLzAY99c3OMVlVZ1BsD8n3dNZRnv2JH3OoM1UohlshGO673i
         zNcss4wVhSFndY9Ed5t99BfPy4Q9h7GLrhjnxyD9dns8M23UDz2J7NWW4Nzs34aH5Ldq
         Lyk4lsF2naiZDlWvvbPDCIZaqxMRRqVANJFQ7w2UYmjmY5Gbas9iYIgGScewVO8g3FZO
         GLfZr5zjTzFtFIUoMYGp0RXoxI+KpnZ/kwt5qi/jG9L7MNfSwJU6crSWPpk3W7ivxlFh
         YOn6nl9mdd4pslTDxLNtGw9r5/OvKZ5hSCBQDNjsp6u03lo9jWOaIPUkG4tOYUBzkfHX
         OBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712083782; x=1712688582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=588W+WKWGCHDk22Ud5hS9stI2LC3FAq1GuSxHQ/M9as=;
        b=d2lEzA/IbSTDuI8MbYzHm449IrZdeG8mS1Pn03LRlzKYtEPsNIRpM7Jee3aVVysjX8
         e11UbbXC5q39Jly6gKegtxohmenJa9FB66VObI0gzSB6JC0+t6Z0aqgrkL0uAET4GoUq
         tpakmzqg94RXRdCGHHk/Vcm2ZUqUDEfraqlJcSlP+hlHv5M7so0KPNjzoJr4UZfGaOox
         JuIK1TdiZkAWmYXW09+0H5rEQPalje9ZF1b2CinCuQODxefL/IMJy5jnp1l3ddVuVwXw
         n3NB+UojCQjiMM/c5gLNN7JP2txwF725Z0rMTbXqjaynCswJcDhjMp+FNkuLKo3Yv+BU
         z/jg==
X-Forwarded-Encrypted: i=1; AJvYcCXcOBr/kHmlzKKEuzzfSEik/VpmXbRRRtQY40RPkHCMEGi1XO8yk7Q97QOhhUMaCoUkSzgzprgYe2DDCGKw0J0KUOju
X-Gm-Message-State: AOJu0YxAXSJNxNSljHAHCwUxQT8fAUY+qETyfRU8g5iAI7hDBaf36R5u
	foKx5oJVKGbArIqQc2XM+iJ/c66GfmCYZBSIitrMOpkz3QhZx9QqpnwGonuOXTn7jzzSDBkj9x2
	3tOli+4tldo5dUBDk+PiTjrK/ce9QWaohpWca
X-Google-Smtp-Source: AGHT+IFqE+UQS0RbhVUDfvVWh1jxlaucrKVTE2OWHdxUHvFSzVEw8wbwfhObgRXrJ5KsEFLTxz8yLY320Q5s7zmUQM4=
X-Received: by 2002:a17:902:f645:b0:1dd:8001:d239 with SMTP id
 m5-20020a170902f64500b001dd8001d239mr29669plg.14.1712083781959; Tue, 02 Apr
 2024 11:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402184543.898923-1-namhyung@kernel.org>
In-Reply-To: <20240402184543.898923-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Apr 2024 11:49:28 -0700
Message-ID: <CAP-5=fWh+nrZukmvANf0rmG_Fw11hMgm=dPkHCG79F+tdzsTvQ@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Add a missing NULL check
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:45=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I got a report for a failure in BPF verifier on a recent kernel with
> perf lock contention command.  It checks task->sighand->siglock without
> checking if sighand is NULL or not.  Let's add one.
>
>   ; if (&curr->sighand->siglock =3D=3D (void *)lock)
>   265: (79) r1 =3D *(u64 *)(r0 +2624)     ; frame1: R0_w=3Dtrusted_ptr_ta=
sk_struct(off=3D0,imm=3D0) R1_w=3Drcu_ptr_or_null_sighand_struct(off=3D0,im=
m=3D0)
>   266: (b7) r2 =3D 0                      ; frame1: R2_w=3D0
>   267: (0f) r1 +=3D r2
>   R1 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it fir=
st
>   processed 164 insns (limit 1000000) max_states_per_insn 1 total_states =
15 peak_states 15 mark_read 5
>   -- END PROG LOAD LOG --
>   libbpf: prog 'contention_end': failed to load: -13
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -13
>   Failed to load lock-contention BPF skeleton
>   lock contention BPF setup failed
>   lock contention did not detect any lock contention
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index fb54bd38e7d0..4e5914d7eeaa 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -305,7 +305,7 @@ static inline __u32 check_lock_type(__u64 lock, __u32=
 flags)
>                 break;
>         case LCB_F_SPIN:  /* spinlock */
>                 curr =3D bpf_get_current_task_btf();
> -               if (&curr->sighand->siglock =3D=3D (void *)lock)
> +               if (curr->sighand && &curr->sighand->siglock =3D=3D (void=
 *)lock)
>                         return LCD_F_SIGHAND_LOCK;
>                 break;
>         default:
> --
> 2.44.0.478.gd926399ef9-goog
>
