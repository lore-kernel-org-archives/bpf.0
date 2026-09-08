Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FAF37F31A
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891591; cv=pass; b=I2nJIdG//j5+a4kqNucNdS+K5OuaNv+dxmaEqudG6QdUA66Uuxj84CtG02d0s78eDGA4lNZX+0kyvpbmUNLM0IaxQBxaQt2lXz7tCwymDagowLvES86baKZ+hkezsNCaPAivN35nsuW/2xVl9rhwrkdkUcbFiaU45C3l0BMwPGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891591; c=relaxed/simple;
	bh=/W4N61SEuCx5FV374iJ+gMt6lUP8hUly3UQeA0fdC8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzS7EszapmuGGDlWFBa00Sqbrsj9uMw30i6HkQEE1j8vOgKqptxQeiZS4jIjkXy/YzASscIxpx/FG6bLHZHrWqY5L/Qol/PPFAy36Ca+rs8/cp79gAxWH9pe88WxlelvNzhf/fu4kS9cqQyUprmXyZAo2l4Fv30xyeQpfJM7gZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Jx6Lfxqs; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Jx6Lfxqs"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdccso3071707b3.1
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 11:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788891588; cv=none;
        d=google.com; s=arc-20260327;
        b=gQf5brr6ZQxLKJh9y4S2o7LtUOdadf5i070cO5ho1I4xs2pSs1Mvr36WbrYjUZoxD9
         ciV3VHPPfCq+0i7XSKOagX44/zxLqSIGcQ8A/BX1by5z2+aXybfdtrk8nyjrwF3QJH4e
         1yHvkshVcbq+LiCeW4AjnnmEwCqWUxzXOzw5SmlVs9W+qZ+E4jS0T3jgKOhilQZiE51T
         ku4YE3aCKUDxkJuu0Udi7YV60k1N+nMwCRR/IK9+HOGeiDygN2Nem0FL04WQ/fFl/ui3
         83yklqWAVef9XtrUSudnwrDFqYsIUxTyFdAcdQYTas3PEcRd0Ch3srJXAljVMzuVvuYP
         jVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PECiLDocJz61w+ia9onjoVBM5wIGRZvaNlac2Te773g=;
        fh=5bG9Ph3wKY1cq0b9UgO3oml+l2PwNGRHDr56ATb400I=;
        b=GOErDMJlu5ieHT9RMfq4FeeMfRJV58l+ZxjHQCKVCJH99BazigjzrUAEmlGyhlK3mR
         ydM6v/gKxbRHlaBjtziBFgfJ1cPLHGL9TXpDQl6NZbwtz7jAgKuuq3S4qPfYAB3E4qNR
         7In0BCasQnh+bFIbNxFlRb/zYwEUhtcouBEAI0xj/X3PPscmPd+FkBRO/jtCRT9g6NMI
         ddByBZwFgDUH3SVjYjDhsWxu5AmLz52XC+kItPCNjmu3WDfIMN4mu4sUNhKChp85tPx3
         OvvLljgTifN7VowQPhAGJHu18XF7XJzL44wl0t4lCxfON4J7dNXe2T3+O8pZZLPcYu1Y
         ksrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788891588; x=1789496388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PECiLDocJz61w+ia9onjoVBM5wIGRZvaNlac2Te773g=;
        b=Jx6Lfxqs+dSIS2Caro0bIxC+g+P9fHMi90VObDpnM9JD499X1tcqw2Ijj8yMjZjjmx
         J8Iq/5Re2ivFqx1eAZs0yfHgZGBrNWjZ1aGllSMwsKsfG02vr7bpnzof2JBnaV7qXMI2
         CZ7mY+FyctffkkjRlWoL4VSM6pe650jzweULwMlKj1E0qNa+Q6qsmD7BO/5bFac9OOJL
         EiLUeFDmLyP1Raw5qLdig9YDwwvmHTVcJViXS1gQuyVB+QMikHo13w/4DtG03x8I5TZL
         joEgAmUWd5d9n2xKP2b8BZINgnroHmSmvd2qkdwNVo09e7XNN5adCgw8+l3p4coLFzjj
         3h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891588; x=1789496388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PECiLDocJz61w+ia9onjoVBM5wIGRZvaNlac2Te773g=;
        b=K3BPMvynjlyKObJOc6mdDiqLYGBZVikmXxG/MrMDgt56PX4h/nA0g0BNKKIsF5tBUi
         LRJ4d0ITVuUTS3AVkHYWqa+iIpLLhNVAf2Q7xqIlOFFzuSMeU1PYEFAq8D5jIy6K04ot
         RszmUIAYonTKtD683Lg4KUDUkWtd9az/x+LOEN56wfA8DYQIAIKWckw0L4IEZ+c9M4em
         PyrUCOTj73rgBcMCnb+TJIKM+5NvkvH3bKknI/ixUZtKuSwPUbhKK6X9oh5xcGTwZhDp
         ObqRvTv1ITcKgQa9GghlSqfR8kh9I/SydwmU9cEKEY1SCbqBIVNLhDqf968xHiUPhQLs
         smPg==
X-Gm-Message-State: AFuF++nhftG17tPY2uT3BtsmLIUaDxpmOeGGSrKBloCCgwriGXE3PoNu
	suImMfIefZ4cKIR0+NDBUVxW8hkpOBxOwCvDlM7HbXrkVmY/VCGr4h9lcwAr2lGQRoJnJDukNDa
	Czlhuc1yRd5QvZ/F+XG5LLmkcHgOJUpRHc1wnhsa6/g==
X-Gm-Gg: AYBFou1jdxHoll+ty23awzMXN6kBlISKUbfvuLT38ncz0rrvoqVvdlFUFt7A6OTwn/l
	Yy+7uQcFtLaNwrOyXLRmd+ws8am4D/ea5yO2kJ6G4Cnvia3JiGtQfEPGy0wuFLFntkJId8WGcNT
	AYTCUSmSnAVWPjj1YBF6xANk+jRv3ikh9qwi9h2p5C19QeaYbOYFT36Dg5F+iMPGXWGFMidN26p
	pkB0T4HXOilMzTTQDyHgSx6819bH0VeE2SAOFG6J5B/k/vwzY2JEzjj+UB9WwtvDDViFu69Ntzh
	oEqzeTNIvjglB049qw0RHhW/J+e53XcVb6LZygEXezxN
X-Received: by 2002:a05:690e:4384:b0:670:4baf:c2b6 with SMTP id
 956f58d0204a3-6710306d0fbmr280749d50.5.1788891586942; Tue, 08 Sep 2026
 11:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830093514.4105972-1-memxor@gmail.com> <20260830093514.4105972-2-memxor@gmail.com>
In-Reply-To: <20260830093514.4105972-2-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 14:19:35 -0400
X-Gm-Features: AcwNN1WWNctEcbQoruoByBHBY-usfOC59vq2D8lkjgHnT1Ain8LO55cDD94qM78
Message-ID: <CABFh=a6w50qG0g7Oa_OAPZom=xZord=mNAbSgBGitPSykHLTcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: Add file descriptor interface for
 program streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:35=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The existing BPF_PROG_STREAM_READ_BY_FD command only supports polling a
> program stream through repeated bpf() calls. It cannot block for new data
> or integrate with poll-based event loops.
>
> Add BPF_PROG_STREAM_OPEN to return a read-only, close-on-exec file
> descriptor for a selected program stream. Reads block by default and
> BPF_F_STREAM_NONBLOCK provides non-blocking behavior. poll reports readab=
le
> data and reports hangup once the program is released.
>
> A stream descriptor deliberately does not retain the program. Move each
> stream into a separately refcounted allocation so program teardown can ma=
rk
> it dead and wake descriptor users while outstanding descriptors drain
> buffered data safely.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Sashiko's point aside:

<SNIP>

> +
> +static const struct file_operations bpf_stream_fops =3D {
> +       .release =3D bpf_stream_release,
> +       .read =3D bpf_stream_file_read,
> +       .poll =3D bpf_stream_poll,
> +       .llseek =3D noop_llseek,
> +};

Why is .llseek a noop here and not -EOPNOTSUPP?

> +
> +int bpf_prog_stream_new_fd(struct bpf_prog *prog, enum bpf_stream_id str=
eam_id, u32 flags)
> +{
> +       struct bpf_stream *stream;
> +       int fd_flags =3D O_RDONLY | O_CLOEXEC;
> +       int fd;
> +
> +       stream =3D bpf_stream_get(stream_id, prog->aux);
> +       if (!stream)
> +               return -ENOENT;
> +       if (flags & BPF_F_STREAM_NONBLOCK)
> +               fd_flags |=3D O_NONBLOCK;
> +
> +       refcount_inc(&stream->refcnt);
> +       fd =3D anon_inode_getfd("bpf-stream", &bpf_stream_fops, stream, f=
d_flags);
> +       if (fd < 0)
> +               bpf_stream_put(stream);
> +       return fd;
> +}
> +
>  __bpf_kfunc_start_defs();
>
>  /*
> @@ -282,28 +383,43 @@ __bpf_kfunc_end_defs();
>
>  /* Added kfunc to common_btf_ids */
>
> -void bpf_prog_stream_init(struct bpf_prog *prog)
> +int bpf_prog_stream_init(struct bpf_prog *prog, gfp_t gfp_extra_flags)
>  {
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(prog->aux->stream); i++) {
> -               atomic_set(&prog->aux->stream[i].capacity, 0);
> -               init_llist_head(&prog->aux->stream[i].log);
> -               mutex_init(&prog->aux->stream[i].lock);
> -               prog->aux->stream[i].backlog_head =3D NULL;
> -               prog->aux->stream[i].backlog_tail =3D NULL;
> +               struct bpf_stream *stream;
> +
> +               stream =3D kzalloc_obj(*stream,
> +                                    bpf_memcg_flags(GFP_KERNEL | gfp_ext=
ra_flags));
> +               if (!stream) {
> +                       bpf_prog_stream_free(prog);
> +                       return -ENOMEM;
> +               }
> +
> +               refcount_set(&stream->refcnt, 1);
> +               atomic_set(&stream->capacity, 0);
> +               init_llist_head(&stream->log);
> +               mutex_init(&stream->lock);
> +               init_waitqueue_head(&stream->waitq);
> +               prog->aux->stream[i] =3D stream;
>         }
> +       return 0;
>  }
>
>  void bpf_prog_stream_free(struct bpf_prog *prog)
>  {
> -       struct llist_node *list;
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(prog->aux->stream); i++) {
> -               list =3D llist_del_all(&prog->aux->stream[i].log);
> -               bpf_stream_free_list(list);
> -               bpf_stream_free_list(prog->aux->stream[i].backlog_head);
> +               struct bpf_stream *stream =3D prog->aux->stream[i];
> +
> +               if (!stream)
> +                       continue;
> +               WRITE_ONCE(stream->dead, true);
> +               wake_up_interruptible_poll(&stream->waitq, EPOLLHUP);
> +               bpf_stream_put(stream);
> +               prog->aux->stream[i] =3D NULL;
>         }
>  }
>
> @@ -366,6 +482,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *=
ss, struct bpf_prog *prog,
>                 list =3D tail;
>         }
>         llist_add_batch(head, tail, &stream->log);
> +       wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM)=
;
>         return 0;
>  }
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af..b5405f7270d1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6300,6 +6300,30 @@ static int prog_assoc_struct_ops(union bpf_attr *a=
ttr)
>         return ret;
>  }
>
> +#define BPF_PROG_STREAM_OPEN_LAST_FIELD prog_stream_open.flags
> +
> +static int prog_stream_open(union bpf_attr *attr)
> +{
> +       struct bpf_prog *prog;
> +       u32 flags =3D attr->prog_stream_open.flags;
> +       int ret;
> +
> +       if (CHECK_ATTR(BPF_PROG_STREAM_OPEN))
> +               return -EINVAL;
> +       if (flags & ~(BPF_F_RDONLY | BPF_F_WRONLY | BPF_F_STREAM_NONBLOCK=
))
> +               return -EINVAL;
> +       if (flags & BPF_F_WRONLY)
> +               return -EINVAL;
> +
> +       prog =3D bpf_prog_get(attr->prog_stream_open.prog_fd);
> +       if (IS_ERR(prog))
> +               return PTR_ERR(prog);
> +
> +       ret =3D bpf_prog_stream_new_fd(prog, attr->prog_stream_open.strea=
m_id, flags);
> +       bpf_prog_put(prog);
> +       return ret;
> +}
> +
>  static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size=
,
>                      bpfptr_t uattr_common, unsigned int size_common)
>  {
> @@ -6472,6 +6496,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uat=
tr, unsigned int size,
>         case BPF_PROG_ASSOC_STRUCT_OPS:
>                 err =3D prog_assoc_struct_ops(&attr);
>                 break;
> +       case BPF_PROG_STREAM_OPEN:
> +               err =3D prog_stream_open(&attr);
> +               break;
>         default:
>                 err =3D -EINVAL;
>                 break;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 732b35cc08d1..da2370036bf0 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -936,6 +936,30 @@ union bpf_iter_link_info {
>   *             0 on success or -1 if an error occurred (in which case,
>   *             *errno* is set appropriately).
>   *
> + * BPF_PROG_STREAM_OPEN
> + *     Description
> + *             Open a file descriptor for one of the BPF streams associa=
ted
> + *             with the program identified by *prog_fd*. The stream is s=
elected
> + *             by *stream_id*.
> + *
> + *             The returned file descriptor supports **read**\ (2) and
> + *             **poll**\ (2). Reads block while the stream is empty unle=
ss
> + *             **BPF_F_STREAM_NONBLOCK** is specified in *flags*. A non-=
blocking
> + *             read of an empty stream fails with **EAGAIN**.
> + *
> + *             **poll**\ (2) reports **POLLIN** when data is available a=
nd
> + *             **POLLHUP** once the program is released. Buffered data r=
emains
> + *             readable after **POLLHUP** and a read returns zero after =
all such
> + *             data has been consumed.
> + *
> + *             The file descriptor is read-only and has the close-on-exe=
c flag
> + *             set. *flags* may contain **BPF_F_RDONLY** and
> + *             **BPF_F_STREAM_NONBLOCK**. **BPF_F_WRONLY** is not suppor=
ted.
> + *
> + *     Return
> + *             A new file descriptor (a nonnegative integer), or -1 if a=
n
> + *             error occurred (in which case, *errno* is set appropriate=
ly).
> + *
>   * NOTES
>   *     eBPF objects (maps and programs) can be shared between processes.
>   *
> @@ -993,6 +1017,7 @@ enum bpf_cmd {
>         BPF_TOKEN_CREATE,
>         BPF_PROG_STREAM_READ_BY_FD,
>         BPF_PROG_ASSOC_STRUCT_OPS,
> +       BPF_PROG_STREAM_OPEN,
>         __MAX_BPF_CMD,
>         BPF_COMMON_ATTRS =3D 1 << 16, /* Indicate carrying syscall common=
 attrs. */
>  };
> @@ -1524,6 +1549,11 @@ enum {
>         BPF_STREAM_STDERR =3D 2,
>  };
>
> +/* flags for BPF_PROG_STREAM_OPEN command */
> +enum {
> +       BPF_F_STREAM_NONBLOCK =3D (1U << 0),
> +};
> +
>  union bpf_attr {
>         struct { /* anonymous struct used by BPF_MAP_CREATE command */
>                 __u32   map_type;       /* one of enum bpf_map_type */
> @@ -1950,6 +1980,12 @@ union bpf_attr {
>                 __u32           flags;
>         } prog_assoc_struct_ops;
>
> +       struct {
> +               __u32           prog_fd;
> +               __u32           stream_id;
> +               __u32           flags;
> +       } prog_stream_open;
> +
>  } __attribute__((aligned(8)));
>
>  /* The description below is an attempt at providing documentation to eBP=
F
> --
> 2.53.0
>
