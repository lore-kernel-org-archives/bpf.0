Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1937106A
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321586; cv=pass; b=G9hMp3cAH/a/tmQA9kqBY5FL4UMtJUSw4Gq4bor5ZHoGaszRFY/N1XXBJXJvxmDEhd8hWyVNRwYUEkSCGqe+Mz1/tCyJfSpozMGl5C3eTvoxOcn1RqaVFwTbg2dDgLIu+jw7RGjHrR8MVba3i2wfYK2ZPTc4jTdMsk2V3B+YbG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321586; c=relaxed/simple;
	bh=wzLc2OkCm9weL3b5pE63K0skzjOdso0L8VqRwRaStvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASbvYfXIYGVDHPChI7GRnImnoEnyPcbNb3gTknCsvAYfdzZhiOk8sQJ8WNpyDorV5/Y2Xkc8gr8ZbM6ULI80/1iGD1ozbLzAOZVcPaOEKepmsfOgUpiVhkH/D3LZZ77AAEmBk/dtGDBHUnwAV5Fym8AnsqcoQSjtw17Lmlwjpu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7RPfFS3; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7RPfFS3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c6bb8a5980so8323795ad.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 10:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782321584; cv=none;
        d=google.com; s=arc-20240605;
        b=gf+35jF3eDnWYkfjB4Wph2q7jVZ5wMXTYN6Sru4JR90ooQMczZnuU1F9AGTnpJYzmA
         +bLAX6tzGJU4gPIawi1ZRwUUicdDcGuiWrGDlFLp0zIkUe7m3or7Rcz5johGoOXBluJ/
         rHyxkPrZC1kZu3hujFmdPAQSixGAVj8GjIaBiCDi0qc1WP4YtYa3oAe9XmVgtikL25u7
         kIjJ4fWyEI+ej/Wc8ak04pEeyXBaYHASGPl+x+K9ur1M3RfhqMO8AKmmcoFvzY1M3CoE
         rpSpMCa8yCNTGNIYSCKxBrivqRBKBstj9HGpCW/qj4YXZER9IBebxrZlkY9dCEz+2UF0
         e5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ghs4wflZYD0Pok4qX6gZ3SS9J+36xiGOGnFYsFbNQ2s=;
        fh=cWkILPn7NLNjl/Z99bCMXn1GdI5kN0x/9k5OyuwDmEY=;
        b=fAoyPPmKrnxHzRnwKiTUEthoBv3VlPiurbn7DyptCuFoSFr06f+Qm6VzRM7JwYbTVD
         NWh0T5kBYPmHTaQ1Uq9R5CbOb3JB58PiPVVRw0+JhVjZVtEBjdnKROacdMaWHSCz7Oyi
         kBOBkXVnJkhg0/em3ydoEkX4omk2sK0hfU6yOmxnJyeuR1GFfT6yZcOzIUYjyX+mCENA
         3fLZC7z75scKTlbCL6GaQuBK6pRHKOywPjKSy1CP2RdD9fWrJcjHlC+zSwZjk3FwW7sv
         dRjcty7PimumymGzNiQDx/oumVqsvTMwUbjQByGAXEvwfWkJSD9jZhoVWLaM0m64mU0T
         OU/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782321584; x=1782926384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ghs4wflZYD0Pok4qX6gZ3SS9J+36xiGOGnFYsFbNQ2s=;
        b=H7RPfFS3FrhYVi5JE6Ci5x6kZ6Xh93MsewxOdnCs3VFz040QCHgn8VPIRizrx9LVV4
         LHot0xpKqiDLAsXZ+yAiiPSuBC7BkaJeCuHNor18pDVSv7HcPTjUDOEhcf24JID3N91d
         XU5r5ATI8gvpg/CGovTIVfwkWoiaMDJCzvIMJczv6Lbm3b4yxv+GkBotC2+D9XtRz8PD
         sFtkQb4dnUaF6hRJGTZhIN3wqFM3+RH0KoUP/gfiymdNQZUDrGXbnoiW1gHJliUN3hfB
         AOaSmY2qKbjTP+XAJTEyNZHapRG4v7GeCyenN/O2ltaglP9BBeUJPcJYWzAA4DCFIFh9
         woDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321584; x=1782926384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ghs4wflZYD0Pok4qX6gZ3SS9J+36xiGOGnFYsFbNQ2s=;
        b=R/d+uK10/UKmKksP9td0DAhlxmoTqoumsNPVuwk0YwiypoXAcPUhANrayPI+JIE8ex
         97l7KRd5ZSHPdx3n+t3i82YSnLGn0BApCn3JRU2in4u+LxMQ0Rzyw4hKU+sJs7U8fira
         hBQ4Bl6xRWrTQXS/1hErzYWfzIuNX8rkZZn59OEqJLRiik4/7deSSnB4BNd4t1awVwYl
         QqUwyZJ++jE7eTkdBMGgtWy/v13+TQQArjwwdE4BIPI+VShNyXqAFZNlFGDdBEGYIowW
         TDXbb4Cuwh8RBKHuQryMCel0813zS6KR1SVxgwvXFIDe30DstXCHKFqT578mv8W/55S2
         L2Ww==
X-Forwarded-Encrypted: i=1; AHgh+RqWM4qcW0wTOcXGBCe2hR+lR4wKaU0DpkxV7zhUTxpu5eelx/qVbZvGVuepqsGmrE/1qWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyATo04MNizrOQHiUUopc4H2Ol96eGOJbtugTT05u1zSs1wkXPn
	t4zdSVRgHn6z0ZypCPvh/mBsNIoOOPney7kDvHypO2WDYViUuqmVXFBJEiQ1wfvx0HCAD5CegMf
	IJxAfqJjbsNGqOo5nu52598EIUFB+mXM=
X-Gm-Gg: AfdE7cnHC9kJp7KMkQgEKmg94gaiQd/6g3dfPscDzsuWSxi0dpO5fJuN1nE4Ki6HzZ3
	VdF6U2IrwdUStmESBMuruvMoTaUIIitt4nQg9ttBAdPzJzo202vwidHBDz6Jv0jEN0AwFcahhcm
	wcjjfJ3YBjCf+39O/Q9vL/xbfuoeCc7AH1AKQ7LSPBiPYsoTPYrcjC8kx703Vti8WJNu5hwp1Yi
	lWgrkt+caEiwxES8R9xtKsdD/EM+Z61yXNTtISTHGdScAKlfDUpAX/pJnzY6ZICwSewPBVjxhxP
	c4uTnfrbCbFSBfOH0ox0DWoSIHw/svCz2Yosj7mF1JgY1OeZrRmJduhEJ4+AKEO7niM=
X-Received: by 2002:a17:902:b908:b0:2c0:a373:89bf with SMTP id
 d9443c01a7336-2c7e14429aemr33795255ad.1.1782321583747; Wed, 24 Jun 2026
 10:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623112533.1151502-1-vmalik@redhat.com> <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com>
 <ajq98dm4gAwEzkMb@google.com> <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
 <93e70dc7-e52f-444e-b57e-09d149dc4808@redhat.com>
In-Reply-To: <93e70dc7-e52f-444e-b57e-09d149dc4808@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jun 2026 10:19:31 -0700
X-Gm-Features: AVVi8Cdx9XvjJm3rGt5g4frCGp-zftomP5RJdiB6o2xiZ4f1MI-b0EFRFOr5O8A
Message-ID: <CAEf4BzYWdsBDQ3D41=+n_oCO68bVOtKuqQCqZOEVo=j7nK9Ozg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using bpf_loop
To: Viktor Malik <vmalik@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Michael Petlan <mpetlan@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 3:27=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 6/24/26 08:47, Viktor Malik wrote:
> > On 6/23/26 19:10, Namhyung Kim wrote:
> >> Hello,
> >>
> >> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
> >>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
> >>>> The loop for processing syscall args in augment_raw_syscalls has a
> >>>> history of breaking with Clang updates, see e.g. commit 013eb043f37b
> >>>> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16=
.
> >>>>
> >>>> Now, a similar thing happened between Clang 21 and 22. While the iss=
ue
> >>>> is mitigated on the main line by a recent verifier update, it remain=
s
> >>>> broken on the 6.12 and 6.18 stable branches:
> >>>>
> >>>>     [linux-6.18.y]# sudo perf trace true
> >>>>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
> >>>>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> >>>>     [...]
> >>>>     BPF program is too large. Processed 1000001 insn
> >>>>     processed 1000001 insns (limit 1000000) max_states_per_insn 40 t=
otal_states 37941 peak_states 232 mark_read 0
> >>>>     -- END PROG LOAD LOG --
> >>>>     libbpf: prog 'sys_enter': failed to load: -E2BIG
> >>>>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> >>>>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf'=
: -E2BIG
> >>>>     Error: failed to get syscall or beauty map fd
> >>>>     [...]
> >>>>
> >>>> The reason is that the loop is quite complex and the BPF verifier of=
ten
> >>>> struggles to prove that it terminates.
> >>>>
> >>>> Fix the issue by refactoring the loop body into a callback function =
and
> >>>> calling the bpf_loop helper. This should prevent future breakages of
> >>>> this kind since the callback function has no loops. It also allows t=
o
> >>>> drop a few artificial checks to help the verifier, including the cha=
nges
> >>>> introduced by 013eb043f37b.
> >>
> >> Thanks for working on this.  I encountered this issue before and never
> >> found time to take a deeper look yet.
> >>
> >>>>
> >>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> >>>> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
> >>>> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
> >>>> Cc: stable@vger.kernel.org
> >>>> ---
> >>>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++----=
---
> >>>>  1 file changed, 96 insertions(+), 61 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b=
/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> >>>> index 2a6e61864ee0..6d553ed3ac23 100644
> >>>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> >>>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> >>>> @@ -429,15 +429,96 @@ static bool pid_filter__has(struct pids_filter=
ed *pids, pid_t pid)
> >>>>    return bpf_map_lookup_elem(pids, &pid) !=3D NULL;
> >>>>  }
> >>>>
> >>>> +struct args_loop_ctx {
> >>>> +  struct syscall_enter_args *args;
> >>>> +  unsigned int *beauty_map;
> >>>> +  void *payload_offset;
> >>>> +  int value_size;
> >>>> +  u64 *output;
> >>>> +  bool *do_output;
> >>>> +};
> >>>> +
> >>>> +static long process_arg_cb(u64 i, void *ctx)
> >>>> +{
> >>>> +  /*
> >>>> +   * Determine what type of argument and how many bytes to read fro=
m user space, using the
> >>>> +   * value in the beauty_map. This is the relation of parameter typ=
e and its corresponding
> >>>> +   * value in the beauty map, and how many bytes we read eventually=
:
> >>>> +   *
> >>>> +   * string: 1                          -> size of string
> >>>> +   * struct: size of struct             -> size of struct
> >>>> +   * buffer: -1 * (index of paired len) -> value of paired len (max=
imum: TRACE_AUG_MAX_BUF)
> >>>> +   */
> >>>> +  struct augmented_arg *augmented_arg;
> >>>> +  struct args_loop_ctx *loop_ctx;
> >>>> +  int aug_size, size, index;
> >>>> +  bool augmented;
> >>>> +  void *arg;
> >>>> +
> >>>> +  /* Bounds check for the below map access to help the verifier */
> >>>> +  if (i < 0 || i >=3D 6)
> >>>> +          return 1;
> >>>> +
> >>>> +  loop_ctx =3D (struct args_loop_ctx *)ctx;
> >>>> +  arg =3D (void *)loop_ctx->args->args[i];
> >>>> +  augmented =3D false;
> >>>> +  size =3D loop_ctx->beauty_map[i];
> >>>> +  aug_size =3D size; /* size of the augmented data read from user s=
pace */
> >>>> +  augmented_arg =3D (struct augmented_arg *)loop_ctx->payload_offse=
t;
> >>>> +
> >>>> +  if (size =3D=3D 0 || arg =3D=3D NULL)
> >>>> +          return 0; /* continue */
> >>>> +
> >>>> +  if (size =3D=3D 1) { /* string */
> >>>> +          aug_size =3D bpf_probe_read_user_str(augmented_arg->value=
, loop_ctx->value_size, arg);
> >>>> +          augmented =3D true;
> >>>> +  } else if (size > 0 && size <=3D loop_ctx->value_size) { /* struc=
t */
> >>>> +          if (!bpf_probe_read_user(augmented_arg->value, size, arg)=
)
> >>>> +                  augmented =3D true;
> >>>> +  } else if (size < 0 && size >=3D -6) { /* buffer */
> >>>> +          index =3D -(size + 1);
> >>>> +          barrier_var(index); // Prevent clang (noticed with v18) f=
rom removing the &=3D 7 trick.
> >>>> +          index &=3D 7;         // Satisfy the bounds checking with=
 the verifier in some kernels.
> >>>> +          aug_size =3D loop_ctx->args->args[index];
> >>>> +
> >>>> +          if (aug_size > TRACE_AUG_MAX_BUF)
> >>>> +                  aug_size =3D TRACE_AUG_MAX_BUF;
> >>>> +
> >>>> +          if (aug_size > 0) {
> >>>> +                  if (!bpf_probe_read_user(augmented_arg->value, au=
g_size, arg))
> >>>> +                          augmented =3D true;
> >>>> +          }
> >>>> +  }
> >>>> +
> >>>> +  /* Augmented data size is limited to sizeof(augmented_arg->unname=
d union with value field) */
> >>>> +  if (aug_size > loop_ctx->value_size)
> >>>> +          aug_size =3D loop_ctx->value_size;
> >>>> +
> >>>> +  /* write data to payload */
> >>>> +  if (augmented) {
> >>>> +          int written =3D offsetof(struct augmented_arg, value) + a=
ug_size;
> >>>> +
> >>>> +          if (written < 0 || written > sizeof(struct augmented_arg)=
)
> >>>> +                  return 1; /* break */
> >>>> +
> >>>> +          augmented_arg->size =3D aug_size;
> >>>> +          *loop_ctx->output +=3D written;
> >>>> +          loop_ctx->payload_offset +=3D written;
> >>>> +          *loop_ctx->do_output =3D true;
> >>>> +  }
> >>>> +
> >>>> +  return 0;
> >>>> +}
> >>>> +
> >>>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *=
args)
> >>>>  {
> >>>> -  bool augmented, do_output =3D false;
> >>>> -  int zero =3D 0, index, value_size =3D sizeof(struct augmented_arg=
) - offsetof(struct augmented_arg, value);
> >>>> +  bool do_output =3D false;
> >>>> +  int zero =3D 0, value_size =3D sizeof(struct augmented_arg) - off=
setof(struct augmented_arg, value);
> >>>>    u64 output =3D 0; /* has to be u64, otherwise it won't pass the v=
erifier */
> >>>> -  s64 aug_size, size;
> >>>>    unsigned int nr, *beauty_map;
> >>>>    struct beauty_payload_enter *payload;
> >>>> -  void *arg, *payload_offset;
> >>>> +  void *payload_offset;
> >>>> +  long iters;
> >>>>
> >>>>    /* fall back to do predefined tail call */
> >>>>    if (args =3D=3D NULL)
> >>>> @@ -457,63 +538,17 @@ static int augment_sys_enter(void *ctx, struct=
 syscall_enter_args *args)
> >>>>    /* copy the sys_enter header, which has the syscall_nr */
> >>>>    __builtin_memcpy(&payload->args, args, sizeof(struct syscall_ente=
r_args));
> >>>>
> >>>> -  /*
> >>>> -   * Determine what type of argument and how many bytes to read fro=
m user space, using the
> >>>> -   * value in the beauty_map. This is the relation of parameter typ=
e and its corresponding
> >>>> -   * value in the beauty map, and how many bytes we read eventually=
:
> >>>> -   *
> >>>> -   * string: 1                          -> size of string
> >>>> -   * struct: size of struct             -> size of struct
> >>>> -   * buffer: -1 * (index of paired len) -> value of paired len (max=
imum: TRACE_AUG_MAX_BUF)
> >>>> -   */
> >>>> -  for (int i =3D 0; i < 6; i++) {
> >>>> -          arg =3D (void *)args->args[i];
> >>>> -          augmented =3D false;
> >>>> -          size =3D beauty_map[i];
> >>>> -          aug_size =3D size; /* size of the augmented data read fro=
m user space */
> >>>> -
> >>>> -          if (size =3D=3D 0 || arg =3D=3D NULL)
> >>>> -                  continue;
> >>>> -
> >>>> -          if (size =3D=3D 1) { /* string */
> >>>> -                  aug_size =3D bpf_probe_read_user_str(((struct aug=
mented_arg *)payload_offset)->value, value_size, arg);
> >>>> -                  /* minimum of 0 to pass the verifier */
> >>>> -                  if (aug_size < 0)
> >>>> -                          aug_size =3D 0;
> >>>> -
> >>>> -                  augmented =3D true;
> >>>> -          } else if (size > 0 && size <=3D value_size) { /* struct =
*/
> >>>> -                  if (!bpf_probe_read_user(((struct augmented_arg *=
)payload_offset)->value, size, arg))
> >>>> -                          augmented =3D true;
> >>>> -          } else if ((int)size < 0 && size >=3D -6) { /* buffer */
> >>>> -                  index =3D -(size + 1);
> >>>> -                  barrier_var(index); // Prevent clang (noticed wit=
h v18) from removing the &=3D 7 trick.
> >>>> -                  index &=3D 7;         // Satisfy the bounds check=
ing with the verifier in some kernels.
> >>>> -                  aug_size =3D args->args[index] > TRACE_AUG_MAX_BU=
F ? TRACE_AUG_MAX_BUF : args->args[index];
> >>>> -
> >>>> -                  if (aug_size > 0) {
> >>>> -                          if (!bpf_probe_read_user(((struct augment=
ed_arg *)payload_offset)->value, aug_size, arg))
> >>>> -                                  augmented =3D true;
> >>>> -                  }
> >>>> -          }
> >>>> -
> >>>> -          /* Augmented data size is limited to sizeof(augmented_arg=
->unnamed union with value field) */
> >>>> -          if (aug_size > value_size)
> >>>> -                  aug_size =3D value_size;
> >>>> -
> >>>> -          /* write data to payload */
> >>>> -          if (augmented) {
> >>>> -                  int written =3D offsetof(struct augmented_arg, va=
lue) + aug_size;
> >>>> -
> >>>> -                  if (written < 0 || written > sizeof(struct augmen=
ted_arg))
> >>>> -                          return 1;
> >>>> -
> >>>> -                  ((struct augmented_arg *)payload_offset)->size =
=3D aug_size;
> >>>> -                  output +=3D written;
> >>>> -                  payload_offset +=3D written;
> >>>> -                  do_output =3D true;
> >>>> -          }
> >>>> -  }
> >>>> +  struct args_loop_ctx loop_ctx =3D {
> >>>> +          .args =3D args,
> >>>> +          .beauty_map =3D beauty_map,
> >>>> +          .payload_offset =3D payload_offset,
> >>>> +          .value_size =3D value_size,
> >>>> +          .output =3D &output,
> >>>> +          .do_output =3D &do_output
> >>>> +  };
> >>>> +  iters =3D bpf_loop(6, process_arg_cb, &loop_ctx, 0);
> >>>
> >>> bpf_loop() is old and generally not recommended.
> >>> Please use bpf_for() then the diff will be one line change and
> >>> can scale to any number of args. Not just 6.
> >
> > Thanks Alexei, I didn't know about this preference.
> >
> >> One thing we should take care is to support old kernels.  The oldest
> >> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
> >> 5.17 and bpf_for (bpf_iter_num) was 6.4.
> >
> > The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
> > trace: Collect augmented data using BPF") so we should be good using
> > bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
> >
> > I'll refactor with bpf_for and will send v2.
>
> Or I won't. It turns out that just swapping the for loop for bpf_for
> leads to -E2BIG from the verifier again. Looking at the verifier log, it
> fails to find equivalence between states at the loop head:
>
>     [...]
>     78: (85) call bpf_iter_num_next#84922 [...]
> fp-56=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,imm=3D112)
>     [...]
>     78: (85) call bpf_iter_num_next#84922 [...]
> fp-56=3Dmap_value(map=3Dbeauty_payload_,ks=3D4,vs=3D24688,imm=3D120)
>     [...]
>
> IMHO, the reason is that payload_offset, which points to the
> beauty_payload_enter_map entry, gets updated in every iteration.
>
> This could be probably fixed on the perf side by reworking how augmented
> args are stored but at this point, bpf_loop sounds like an easier and
> more reliable approach.
>
> Let me know if anyone has objections, otherwise I'll send v2 of the
> bpf_loop approach, with suggestions from Sashiko incorporated.
>

I'd still try to adapt bpf_for(), it's a much better code structure.
You probably need to add a bounding checking/confirming `if ()`
condition validating that offset at which you access map_value is
always correct. And/or you might need barrier_var() before using i,
because bpf_for() macro does bounds checking (check the macro itself),
but compiler often will reorder instructions leading to verifier
complaints.

> Thanks,
> Viktor
>
> > It should be then
> > backported to stable kernels down to 6.12 LTS.
> >
> > Viktor
> >
> >>
> >> Maybe we can factor out the loop body and call it from different
> >> mechanisms like open-coded loop, bpf_loop or bpf_for depending on the
> >> kernel version.  But not sure it'd fix the verifier issue though.
> >>
> >> Thanks,
> >> Namhyung
> >>
>
>
