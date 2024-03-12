Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61558467
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285116; cv=none; b=OFw640CQDI/5CxWB3NT2HvNg/QW8HY78qog/V1jiT2nteDpXBU0j4lKJOT9STpeQ9eU673aAFCVg2X/6w2usiclG4sxIhyVXvQDGV9atqu1kx4dPpMm96S68S4GAnLXEPFZM9sMiR6Pmo1tAjNLsNohEjLwi/xxzJKeBnsyRocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285116; c=relaxed/simple;
	bh=YSzkwGOtnro7HXMJEZtJcPqoH8oZs2Qkypoqg63lRU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRZlVvKNol0Ot6VXy6D8OaNugz2SzDQu6ydu7d41O9qpXKDABMm7d4TWL306z6GV0jBtylmFKvx4Zpi2dzRD5sbLNQ8iVr2J6KuM6K8PMCZzZd1EVS6NTY7zbao5LxeVXtemGGrLX6Mshtol8UUsfZLkkgAfv3/hCL894AqQc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q23qwikD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q23qwikD"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da202aa138so3986962b3a.2
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710285114; x=1710889914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qLzbSj6iXlswglqhRIGQvEz8KlxmflH62tsbcMWx+0=;
        b=Q23qwikDPXFNzMu9eyNLTn9k0jRleWgrEqDqQn25bY556rOs1jAlnWfhw5zD59OX40
         pIrIGbqmPvR43HADAeoDL7WxhGkvTQ1h57BUXlH/rTlFvama+KOA6lEMoDrefqdqV+kr
         x168Ew+jCzqZwCZV2rLMo/rSsWqJgr7YJiNB7Fotr8YhCyqs90jdVrCyYMRIeG2D+7Cm
         n99v+b03h180kMiMyYNGo1mdp1GlpInAlsDR/ANkHMnESgoiLEKq7vUbxE7m/4MB/W+F
         tyM/vLRmPgXjr0wQGneayapsYhb/XCb2mp+ym2CjZ8SPYmp5eToskvvrUj0oJvWiuJUV
         TF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710285114; x=1710889914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qLzbSj6iXlswglqhRIGQvEz8KlxmflH62tsbcMWx+0=;
        b=lD7DQ6iDpAqVqjkynwqCMvww0lX3gHo0+9mpwj+ovOPXnIS7ziogDTyWBrfscrbP8s
         HFwQCZbezlGCo59HyYFVE2OuIEuckblnJ+xW0HlcUQNIUcGkto5jwO7V0xDJ5u7/WVrJ
         +n1iU0CndFHr+qEkpnJMBS7L5W6kjto2qsxS/X5YYBxcRJIcvMT7Cs3xYaCsOKjQAchH
         gwd8DzyugCqs0F3Hm0GKzzcLmH79FIB994C5hhMOx7q3budP1WwBApWkqlxA/CevTFX1
         3K/M7+K4UMqtRRzS6FYrYtOnPo9bxbPa0SRwxIeyEYE6Rt0WCz3lA9ErX7VEXUeHy6tk
         gCtg==
X-Forwarded-Encrypted: i=1; AJvYcCWdTx4IA2GZbsbhFNACgY/XpVlQz8Nyqr7HlbXQ8CfKiPKGUTPKSPZysE3fPTFnPN3P5TJt3YBoCaCaUOHJMvXjCaGi
X-Gm-Message-State: AOJu0YwxXRF2lBH3h2EzjKe5TuKluiOrqHdHBeYLWzrUbyqj0DzSmRyl
	eUD0s2gkvJ5TvI7Nt0pvqxoHrY7Acj/BTLFH/zS/6USKcjC4AT9oA8R8VdyOOdM9QlWXxoSTwkj
	mv52ECb2cbloTpPzkLy50hXt1i/w=
X-Google-Smtp-Source: AGHT+IG6DtZ33vqm1DWdoto2JdWJmYP9LpEEbXUzmhq/Cb7hpFiXULgR1xqgcf6Qk6g4E06dV72MjWBkAkyZdry2imE=
X-Received: by 2002:a05:6a20:d808:b0:1a3:1d56:ba6c with SMTP id
 iv8-20020a056a20d80800b001a31d56ba6cmr7716895pzb.59.1710285114147; Tue, 12
 Mar 2024 16:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312023249.3776718-1-yonghong.song@linux.dev>
 <c73285ba-57db-4f08-8e77-01c66c98379c@isovalent.com> <53e1eddb-b003-4ae7-be13-55727d03b27f@linux.dev>
In-Reply-To: <53e1eddb-b003-4ae7-be13-55727d03b27f@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Mar 2024 16:11:41 -0700
Message-ID: <CAEf4BzZ-itSprx8AOWAyPbZ6FBLBhz_HKWSyyLWszg40Pi3MRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Fix missing pids during link show
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 8:24=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 3/12/24 7:01 AM, Quentin Monnet wrote:
> > 2024-03-12 02:32 UTC+0000 ~ Yonghong Song <yonghong.song@linux.dev>
> >> Current 'bpftool link' command does not show pids, e.g.,
> >>    $ tools/build/bpftool/bpftool link
> >>    ...
> >>    4: tracing  prog 23
> >>          prog_type lsm  attach_type lsm_mac
> >>          target_obj_id 1  target_btf_id 31320
> >>
> >> Hack the following change to enable normal libbpf debug output,
> >>    --- a/tools/bpf/bpftool/pids.c
> >>    +++ b/tools/bpf/bpftool/pids.c
> >>    @@ -121,9 +121,9 @@ int build_obj_refs_table(struct hashmap **map, =
enum bpf_obj_type type)
> >>            /* we don't want output polluted with libbpf errors if bpf_=
iter is not
> >>             * supported
> >>             */
> >>    -       default_print =3D libbpf_set_print(libbpf_print_none);
> >>    +       /* default_print =3D libbpf_set_print(libbpf_print_none); *=
/
> >>            err =3D pid_iter_bpf__load(skel);
> >>    -       libbpf_set_print(default_print);
> >>    +       /* libbpf_set_print(default_print); */
> >>
> >> Rerun the above bpftool command:
> >>    $ tools/build/bpftool/bpftool link
> >>    libbpf: prog 'iter': BPF program load failed: Permission denied
> >>    libbpf: prog 'iter': -- BEGIN PROG LOAD LOG --
> >>    0: R1=3Dctx() R10=3Dfp0
> >>    ; struct task_struct *task =3D ctx->task; @ pid_iter.bpf.c:69
> >>    0: (79) r6 =3D *(u64 *)(r1 +8)          ; R1=3Dctx() R6_w=3Dptr_or_=
null_task_struct(id=3D1)
> >>    ; struct file *file =3D ctx->file; @ pid_iter.bpf.c:68
> >>    ...
> >>    ; struct bpf_link *link =3D (struct bpf_link *) file->private_data;=
 @ pid_iter.bpf.c:103
> >>    80: (79) r3 =3D *(u64 *)(r8 +432)       ; R3_w=3Dscalar() R8=3Dptr_=
file()
> >>    ; if (link->type =3D=3D bpf_core_enum_value(enum bpf_link_type___lo=
cal, @ pid_iter.bpf.c:105
> >>    81: (61) r1 =3D *(u32 *)(r3 +12)
> >>    R3 invalid mem access 'scalar'
> >>    processed 39 insns (limit 1000000) max_states_per_insn 0 total_stat=
es 3 peak_states 3 mark_read 2
> >>    -- END PROG LOAD LOG --
> >>    libbpf: prog 'iter': failed to load: -13
> >>    ...
> >>
> >> The 'file->private_data' returns a 'void' type and this caused subsequ=
ent 'link->type'
> >> (insn #81) failed in verification.
> >>
> >> To fix the issue, restore the previous BPF_CORE_READ so old kernels ca=
n also work.
> >> With this patch, the 'bpftool link' runs successfully with 'pids'.
> >>    $ tools/build/bpftool/bpftool link
> >>    ...
> >>    4: tracing  prog 23
> >>          prog_type lsm  attach_type lsm_mac
> >>          target_obj_id 1  target_btf_id 31320
> >>          pids systemd(1)
> >>
> >> Fixes: 44ba7b30e84f ("bpftool: Use a local copy of BPF_LINK_TYPE_PERF_=
EVENT in pid_iter.bpf.c")
> >> Cc: Quentin Monnet <quentin@isovalent.com>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpf=
tool/skeleton/pid_iter.bpf.c
> >> index 26004f0c5a6a..1eb756f8d02e 100644
> >> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> >> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> >> @@ -102,7 +102,7 @@ int iter(struct bpf_iter__task_file *ctx)
> >>                                     BPF_LINK_TYPE_PERF_EVENT___local))=
 {
> >>              struct bpf_link *link =3D (struct bpf_link *) file->priva=
te_data;
> >>
> >> -            if (link->type =3D=3D bpf_core_enum_value(enum bpf_link_t=
ype___local,
> >> +            if (BPF_CORE_READ(link, type) =3D=3D bpf_core_enum_value(=
enum bpf_link_type___local,
> >>                                                    BPF_LINK_TYPE_PERF_=
EVENT___local)) {
> > Looks good, thank you! Could you please just realign the
> > BPF_LINK_TYPE_PERF_EVENT___local argument on the next line properly?
>
> Will do. thanks.
>

We can fix it up while applying, so don't send another revision. We
are waiting for trees to converge, so applying patches will be delayed
a bit.

> >
> > With that:
> >
> > Tested-by: Quentin Monnet <quentin@isovalent.com>
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
