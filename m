Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D73783C8
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368228; cv=pass; b=o6qPZAh6P/WNzO8CPYR4iLlWiI7R0NVmuk14buy8vEVhWwci/t5BixW7RimFjiGLb6MxVQUkHBpT3mrFvnthr7OCl55ClY1uMGYQVy16MRJ12vyNul7S6tIOgYf1eNoGAx5KaEkY6wWYVbEPNagyvWIbeAQ/0wruFNZ24uAIaYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368228; c=relaxed/simple;
	bh=ssKZS8qpF/9gRr7EudgqoHQsoM2IqQqobR9GZAXp3jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azOPT+AipKG4z3jO4KQ323UNfRPBe/eaDWnSi7ey6IcAruZmQrsYPaFiaaQjC1pNP0o0bdQgKXsUx+DkNzVFdq4P3VOqvU9Rwqj8SrPlybANW2yeWbl8xT3MMX6g+EbWVkSOcR8h/IeLGAtGMPtS/MmHsNaHa0dSJVa2WdV0Q6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrZMyfGz; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrZMyfGz"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b886fc047d5so2001540866b.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 02:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777368223; cv=none;
        d=google.com; s=arc-20240605;
        b=Y2CLg/Hmc06fAikFdl3sKVBCrNXvywFPDRqH4LQHkFfWu72+zU2U0IjQPkPjsNYWKk
         Qfx8IHRk2SswqH4vuEbTZeXUgSqEVu9RT4fqxw66aM0qMMMhAdccN05LWDp60BFBD21P
         agy/lMfZmZ/VT6E65uNLxlhMj3RMrZdc/ykKmFCLsz9pXDQvcQzRNLby/cTZxDKI3G39
         9Rdb8jovvKrljKysdlnP+nz3FPVxYn5B8vISRZHtZxCHSg0YyaEYAO2i5b7AyfvtU+1R
         BvJCpHe104wYEJswYncTySRUd3UjOnA2m8DvWQWoGH2X2j2GY0FCSpsEUAA1nHDwwWj2
         KDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y0mxmv6zlovaBEyNNFohEBcvoF1iektstSBLVSgu8JQ=;
        fh=PnmYwwIEyGc3uGnzLellVUyTXAaSujwRtCwQxVQ5pwc=;
        b=OWHqSyxV/AGkrGdpTqKzo77oleLqGVDrlJuL8y9hWrtBP0MwDc1C3mx7nivS8uq0LF
         VmpFvHAz5rmLoCpD4FjTHwD7uEjUNLIfnJoxzt3EWI0Kx/z7geqgSnx11qUYE0PLQlDi
         8zBbufz28FHVaO4CJmY8ntNIJkyKau0efjDuu7D3OwMdQnidkLOc625pEtI6nexxnv1R
         XfmXB3oqqYunNzt+MRzBjDC1MF9kCmueOVqXBV7NhAj7LXxImlN/oH0mq4RJ2g7uzqLu
         ASEUy7LFMpP54kZgCLsKpOd/THq6VuD8yiPzIOEwtOPNkm7qCxR1pgv3QdZicuvwcLk1
         RP0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368223; x=1777973023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0mxmv6zlovaBEyNNFohEBcvoF1iektstSBLVSgu8JQ=;
        b=RrZMyfGzNRJGcpbRYAcgex/Th+U/3FkIKFMD0xFyZhAjJZZbNfXwtKqIK1ZJdKsVa1
         I3Y9O2ySgbb1M7qliBTPLhNoDqDI//gpjteeM7YY9H9i/yNnJKjdRinc2lPh5skx5eWe
         Wc/dfTbihG1jsTsbCYIuu0s4z+1x1DHfCm6gSTnTbV9tZJ6MbttVBJ0JC+bEn6tT2Jqg
         bu2mWEHw6Mc1dv/9/FlrAChYXlMDiKrXvk10JCKARzuNWCT0n9THR6m77K+wa3o/LqP0
         uU7zVQ3iuqibdMLDAovHrfhpqtAh16QeLyxn4hOPfPGA8Ju6/PWks4z7qzWK7Mk/4ryC
         OqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368223; x=1777973023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0mxmv6zlovaBEyNNFohEBcvoF1iektstSBLVSgu8JQ=;
        b=KTd7M4iGk3GR3PqJyIlpRLaeKA/iGZAVD/Ip0kHNRqmR81epKMSbMTfgSqHbsQClWM
         AqFkHWnbexu+BFJVDaHm7T3bRuLKvfmHZTsgXtyA4P3N+d/B5zp4neab8MQcohy8pnsL
         5JfUPAEqvyc/IaYDzQCjDzQm61YfHbDk/rnaDVvUrBS7QeSj8in3HpFeUKa9Sj/XZxZt
         LS4XIiXdbtpPYEmjJzsvEFza/Iq7IlA+wCZfqWUYLznzyI9hvLQU4spkvruvOvjo7A9R
         jVaogxM2q/wwKvtMYFm9bfHw0/zCmC3bTNVH0/015NcmHNADCYJ1RT23xtmZV43UNhym
         0p7g==
X-Gm-Message-State: AOJu0YyU3NQEI7YJg+2nGt0gcPiP8OTI6NAL1ZmQi66SrUOBAutX/Jts
	UTQTfm7UNOnqoYpikB5GlzqfnHcxcdXx3lnzfe9AfAdkMeyHxuS+aLPGGgrYeLdjtjXqzrIBWSc
	flLbGgeVD1uBt2514/00XCADf9bJwaxyd86XviPw=
X-Gm-Gg: AeBDieuquhnxYfZ2sQd97/oMJT1tq+X/croY4TJF5iPE0luenX/Ye6f299w7sIIkDCX
	Z5MgyyK7WeJwLAcvnJ06Bb0NuVsKa6bKrTybqRlKqPq5cqAUowXRP1Kxydug03/OZWC6wKN/Mbz
	OZZRgmtLsNoa3q+kq/aZsGoRkDLx3ltTw49ukUtkIUk7VAceA1hRpk5ttZqGe1aIoTuVXewM2oU
	QvFxsimWLN1SUKcwJtn2eUO+kE97jj9bJx0G0T8NbQb70bSMDOAjNUczFsU6ebaRfs9QS+aKp8h
	FxaB5o6pQFw4Ol1CeOXurzBpzFk=
X-Received: by 2002:a17:907:97cb:b0:ba5:216c:56e6 with SMTP id
 a640c23a62f3a-bb7ff35965emr135483866b.0.1777368222785; Tue, 28 Apr 2026
 02:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427232313.1582588-3-puranjay@kernel.org> <825349ab37b5f386b036f5c59476cd61c173f6fcd7632542c57fac1f1facdb9c@mail.kernel.org>
In-Reply-To: <825349ab37b5f386b036f5c59476cd61c173f6fcd7632542c57fac1f1facdb9c@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 28 Apr 2026 10:23:31 +0100
X-Gm-Features: AVHnY4JpI7UQFkDswWEy_KZ66SCph5Gk3XsNzsnGBKBzOoz5kq7H71157Lkguz8
Message-ID: <CANk7y0hRPJ1sO2f+5NBeLb_tubRFNUDsH0qy3YDj3=RhtVZTzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] selftests/bpf: Add BPF batch-timing library
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mykyta.yatsenko5@gmail.com, feichen@meta.com, 
	taragrawal@meta.com, ndixit@meta.com, tehnerd@tehnerd.com, 
	kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 1:18=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c b/to=
ols/testing/selftests/bpf/benchs/bench_bpf_timing.c
> > new file mode 100644
> > index 000000000000..75a39da69655
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
>
> [ ... ]
>
> > +static __u32 compute_batch_iters(__u64 per_op_ns)
> > +{
> > +     __u64 target_ns =3D (__u64)CALIBRATE_TARGET_MS * 1000000ULL;
> > +     __u32 iters;
> > +
> > +     if (per_op_ns =3D=3D 0)
> > +             return CALIBRATE_MIN_BATCH;
> > +
> > +     iters =3D target_ns / per_op_ns;
> > +
> > +     if (iters < CALIBRATE_MIN_BATCH)
> > +             iters =3D CALIBRATE_MIN_BATCH;
> > +     if (iters > CALIBRATE_MAX_BATCH)
> > +             iters =3D CALIBRATE_MAX_BATCH;
> > +
> > +     return iters;
> > +}
> > +
> > +void bpf_bench_calibrate(struct bpf_bench_timing *t, bpf_bench_run_fn =
run_fn, void *run_ctx)
> > +{
> > +     __u64 elapsed, per_op_ns;
> > +     __u64 time_n, time_2n;
> > +     double ratio;
> > +
> > +     elapsed =3D measure_elapsed(t, run_fn, run_ctx, CALIBRATE_SEED_BA=
TCH, CALIBRATE_RUNS);
> > +     if (elapsed =3D=3D 0) {
> > +             fprintf(stderr, "calibration: no timing samples, using de=
fault\n");
> > +             t->batch_iters =3D 10000;
> > +             *t->batch_iters_bss =3D t->batch_iters;
> > +             reset_timing(t);
> > +             return;
> > +     }
> > +
> > +     per_op_ns =3D elapsed / CALIBRATE_SEED_BATCH;
> > +     t->batch_iters =3D compute_batch_iters(per_op_ns);
>
> Will this integer division truncation break calibration for operations
> taking less than 1 ns? If the total elapsed time for 100 iterations is un=
der
> 100 ns, per_op_ns evaluates to 0, forcing compute_batch_iters() to return
> CALIBRATE_MIN_BATCH (100) instead of scaling up to reach the 10 ms target=
.

If individual operations take less than 1 ns then we can't meaninfully
measure them, so returning 100 here is good enough.

>
> > +
> > +     time_n =3D measure_elapsed(t, run_fn, run_ctx, t->batch_iters, CA=
LIBRATE_RUNS);
> > +     time_2n =3D measure_elapsed(t, run_fn, run_ctx, t->batch_iters * =
2, CALIBRATE_RUNS);
>
> [ ... ]
>
> > +static void reset_timing(struct bpf_bench_timing *t)
> > +{
> > +     *t->timing_enabled =3D 0;
> > +     memset(t->samples, 0, sizeof(__u64) * BENCH_NR_CPUS * BENCH_NR_SA=
MPLES);
> > +     memset(t->idx, 0, sizeof(__u32) * BENCH_NR_CPUS);
> > +}
>
> Does this need CPU memory barriers to prevent hardware reordering?
> While timing_enabled is volatile, weakly-ordered architectures like arm64=
 might
> reorder the memory stores across the flag toggle. This could allow backgr=
ound
> BPF executions to write samples while the arrays are being zeroed.

reset_timing() is only called during calibration, which runs in
setup() =E2=80=94 before any producer threads are started. There's no
concurrent BPF execution to race with.

> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h b=
/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
> > new file mode 100644
> > index 000000000000..6a1ad75f1fd7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
>
> [ ... ]
>
> > +static __always_inline void bench_record_sample(__u64 elapsed_ns)
> > +{
> > +     __u32 cpu, idx;
> > +
> > +     if (!timing_enabled)
> > +             return;
> > +
> > +     cpu =3D bpf_get_smp_processor_id() & BENCH_CPU_MASK;
> > +     idx =3D timing_idx[cpu];
> > +
> > +     if (idx >=3D BENCH_NR_SAMPLES)
> > +             return;
> > +
> > +     timing_samples[cpu][idx] =3D elapsed_ns;
> > +     timing_idx[cpu] =3D idx + 1;
> > +}
>
> Can this read-modify-write pattern cause lost samples or out-of-bounds
> writes? If machines have more than 256 logical CPUs, BENCH_CPU_MASK will =
alias
> multiple CPUs to the same index. Concurrent thread executions could race =
and
> overwrite the index, potentially corrupting the timing statistics.

xdp_lb_validate() checks bpf_num_possible_cpus() > BENCH_NR_CPUS and
exits with an error.

>
> > +
> > +/*
> > + * @body:  expression to time; return value (int) stored in __bench_re=
sult.
> > + * @reset: undo body's side-effects so each iteration starts identical=
ly.
> > + *         May reference __bench_result.  Use ({}) for empty reset.
> > + *
> > + * Runs batch_iters timed iterations, then one untimed iteration whose
> > + * return value the macro evaluates to (for validation).
> > + */
> > +#define BENCH_BPF_LOOP(body, reset) ({                                =
       \
> > +     __u64 __bench_start =3D bpf_ktime_get_ns();                      =
 \
> > +     __u32 __bench_i;                                                \
> > +     int __bench_result;                                             \
> > +                                                                     \
> > +     for (__bench_i =3D 0;                                            =
 \
> > +          __bench_i < batch_iters && can_loop;                       \
> > +          __bench_i++) {                                             \
> > +             __bench_result =3D (body);                               =
 \
> > +             reset;                                                  \
> > +     }                                                               \
> > +                                                                     \
> > +     bench_record_sample(bpf_ktime_get_ns() - __bench_start);        \
> > +                                                                     \
> > +     __bench_result =3D (body);                                       =
 \
> > +     __bench_result;                                                 \
> > +})
>
> Should the final untimed iteration also evaluate the reset expression?
> Without calling reset here, any side effects from the last body execution=
 (like
> memory allocations or map modifications) will leak into the next program
> invocation and could violate benchmark isolation.

This is by design, we want to have the last untimed iteration to have
side effects so we can validate output.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/250255=
33577
