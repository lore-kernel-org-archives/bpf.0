Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B374AECF
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198829; cv=none; b=Hekc53RTzUEaT2d790Z6Rl3i7hkQORpsuMcwq3KLVI6vdsBuRYM0KH/ImN+4DmA7yLyMqiKeHXA4BXeLfQC0xF9+E28QLAaZcJngfOzlog+D956ljWa4MRaW2h7tdl4uelSljRdcFZ2CcwFfNGNVCuI6x16LePy8pa/tuTPxgl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198829; c=relaxed/simple;
	bh=lATGukmGNzIjzu7nd4kw7y7mPJib/OtmHeSBq9sDpys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hp/pWPj79Qq7dYpew66TH1KA9djyJfiHaz1Jnf905oeUMcwSuuQ6P5GJTLWF0UEFoW4TAi4jeEsLMgUrNVf/rsiEtjcIij7sIjX5QPntScTIpWQ+q1KXquGqtizKPctc+ZVzmuWO6uLVHSXUy3pOgA0SSMDrmJd1W49XIjiCuo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ymg8HV/Q; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymg8HV/Q"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2321003a12.3
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710198827; x=1710803627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW0zOAlm1TJ3fwWgH7UuARrLlC1EPCs868In7XNVj/E=;
        b=Ymg8HV/Q/IbqvGQOeMY7jSpWrXsYVfDR6N9+dcEPxGxZE+FsiftjmLsFK9fsjd4Ny4
         sAMQr6UHCh9tVbpTSSLCj+fz2wYCAiWc9i6vYbHwXtS+tQ4+veWDY9BtiWbPKBKgh3iM
         FoU/ZjJ6VeNjWbzTp8o6LArHg5mv8lFYvoinNDIr0Fo27k1+2/cov5tOM47HvHjg2ESX
         FUH+ToD5nh9zqbGgKglkP3PUTBkpRsl9ShoQVRN6o/n5GGKG9oVSgU0Wdu8q3FA1ZjPO
         PFxTT/37mBcif+CEQm1QeR0hEf0Gph8gBjdsD7Y5+ndnzCGOAVt3ui9aZ8Cr7DBL0LNv
         B+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710198827; x=1710803627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW0zOAlm1TJ3fwWgH7UuARrLlC1EPCs868In7XNVj/E=;
        b=DhPaVzzd2R+kW2cwBNkOl0I300eTKC2s7PQTaJ5BLnslp3cCkxLAPBPlWLhJaEJBwM
         DmZkUVF4XZ5Y28YNdJUcGh4JSj/zU1G6fyobOAEMzqnhA6EAfc4ZJvqEl9tKr3nCSjrQ
         nN7jAeX02ePnQQzsNLNcpJZEsFhSvYTk3u9wCzbqCdX8QGWQ+/5MUfNxCEqCCdW6zXSy
         Ezn61QlPOEqX87aE7pFaQbGxDoS77D1Z7REscaQZiUFtkC1p+UNn4tBrYZqHAaq+iuHU
         df3w5VKJa9fbmPKORbHp0yHV+FPVoak8UOW/gq4qOdi9vn2/lb/SOitjoUAgPg5hARcL
         FJIg==
X-Gm-Message-State: AOJu0YxPgR2Np+47i1ZrzRHInJdy8Cj/nsDiE6qhtvHfOr9FeA7ffe+Q
	b/cXuU/B2YmnxL2bOBaRUaQ+6pptzrL6SigSP/NpfhBxgdTGnz5Dn+e+1If4W7Czfd+YkQPKgxZ
	P3an8qixmQioQLV6PddKhQot860Y=
X-Google-Smtp-Source: AGHT+IF1Jl4I+4g7/d9p/rHkm673bhuoYOrS8iiKqE5nFPE6sirGXhqLfdvBo0WsT9XMbyVwiivZCCKK/y4Pj9Wi4mE=
X-Received: by 2002:a05:6a20:5485:b0:1a1:4d8b:6f2c with SMTP id
 i5-20020a056a20548500b001a14d8b6f2cmr6364702pzk.2.1710198827014; Mon, 11 Mar
 2024 16:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311214116.2123875-1-yonghong.song@linux.dev>
In-Reply-To: <20240311214116.2123875-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 16:13:35 -0700
Message-ID: <CAEf4BzYU0R=HxFk0h_4rHdfCD=9hX-8NRSr=eGiND_3p=8Syvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Fix missing pids during link show
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:41=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Current 'bpftool link' command does not show pids, e.g.,
>   $ tools/build/bpftool/bpftool link
>   ...
>   4: tracing  prog 23
>         prog_type lsm  attach_type lsm_mac
>         target_obj_id 1  target_btf_id 31320
>
> Hack the following change to enable normal libbpf debug output,
>   --- a/tools/bpf/bpftool/pids.c
>   +++ b/tools/bpf/bpftool/pids.c
>   @@ -121,9 +121,9 @@ int build_obj_refs_table(struct hashmap **map, enum=
 bpf_obj_type type)
>           /* we don't want output polluted with libbpf errors if bpf_iter=
 is not
>            * supported
>            */
>   -       default_print =3D libbpf_set_print(libbpf_print_none);
>   +       /* default_print =3D libbpf_set_print(libbpf_print_none); */
>           err =3D pid_iter_bpf__load(skel);
>   -       libbpf_set_print(default_print);
>   +       /* libbpf_set_print(default_print); */
>
> Rerun the above bpftool command:
>   $ tools/build/bpftool/bpftool link
>   libbpf: prog 'iter': BPF program load failed: Permission denied
>   libbpf: prog 'iter': -- BEGIN PROG LOAD LOG --
>   0: R1=3Dctx() R10=3Dfp0
>   ; struct task_struct *task =3D ctx->task; @ pid_iter.bpf.c:69
>   0: (79) r6 =3D *(u64 *)(r1 +8)          ; R1=3Dctx() R6_w=3Dptr_or_null=
_task_struct(id=3D1)
>   ; struct file *file =3D ctx->file; @ pid_iter.bpf.c:68
>   ...
>   ; struct bpf_link *link =3D (struct bpf_link *) file->private_data; @ p=
id_iter.bpf.c:103
>   80: (79) r3 =3D *(u64 *)(r8 +432)       ; R3_w=3Dscalar() R8=3Dptr_file=
()
>   ; if (link->type =3D=3D bpf_core_enum_value(enum bpf_link_type___local,=
 @ pid_iter.bpf.c:105
>   81: (61) r1 =3D *(u32 *)(r3 +12)
>   R3 invalid mem access 'scalar'
>   processed 39 insns (limit 1000000) max_states_per_insn 0 total_states 3=
 peak_states 3 mark_read 2
>   -- END PROG LOAD LOG --
>   libbpf: prog 'iter': failed to load: -13
>   ...
>
> The 'file->private_data' returns a 'void' type and this caused subsequent=
 'link->type'
> (insn #81) failed in verification.
>
> To fix the issue, do a type cast from 'void *' to 'struct bpf_link *' for=
 file->private_data
> as in this patch, and the 'bpftool link' runs successfully with 'pids'.
>   $ tools/build/bpftool/bpftool link
>   ...
>   4: tracing  prog 23
>         prog_type lsm  attach_type lsm_mac
>         target_obj_id 1  target_btf_id 31320
>         pids systemd(1)
>
> Fixes: 44ba7b30e84f ("bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVE=
NT in pid_iter.bpf.c")
> Cc: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftoo=
l/skeleton/pid_iter.bpf.c
> index 26004f0c5a6a..96ffcc4f0e67 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> @@ -100,7 +100,7 @@ int iter(struct bpf_iter__task_file *ctx)
>         if (obj_type =3D=3D BPF_OBJ_LINK &&
>             bpf_core_enum_value_exists(enum bpf_link_type___local,
>                                        BPF_LINK_TYPE_PERF_EVENT___local))=
 {
> -               struct bpf_link *link =3D (struct bpf_link *) file->priva=
te_data;
> +               struct bpf_link *link =3D bpf_core_cast(file->private_dat=
a, struct bpf_link);

bpf_core_cast() (i.e., bpf_rdonly_cast()) is newer feature, so relying
on it in bpftool will make PID printing not work on older kernels that
generally do support iter/task_file iterators.

>
>                 if (link->type =3D=3D bpf_core_enum_value(enum bpf_link_t=
ype___local,

the problem is that we dropped BPF_CORE_READ() here and went with
`link->type`. Should we restore BPF_CORE_READ(link, type) here and
solve the problem, while also supporting this feature on wider set of
kernels? Quentin?

>                                                       BPF_LINK_TYPE_PERF_=
EVENT___local)) {
> --
> 2.43.0
>
