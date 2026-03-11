Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EB2C21D8
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269552; cv=pass; b=VslQmaL3y9G05mYwbYdB7Yi2GsdJeXy1KBD4SUcHJAIvjFEnwu3NnE9qHQMdINoYrJzEYe8p1sRi0WVGERFthump0usV4i2ew2qgZR/+FEE6VSwW5UEt9f3yr0CYQ/05+CgNa/m7gHfVqRCItDpah9+0INwg/COvThn4t8HTHuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269552; c=relaxed/simple;
	bh=RJ3upMUcK5/29xiEom6Wa3d30SJtfGrIIaWQXLuRUfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APbWD+LaQF2uTko/bZfBoqDOjVCk6AVa/bpP7fZpDaiU5bsnsBqcdYgfdELdPVlRUDDp/B0Lb8jxg4OlVxW+Cv1giDT3jgZc5xMTe/2yXvx/ZQHH5Gym6ykuvSAKZ8CxZnZDPBkhxz3X8IZvTKShbTDvXaaYLuE07y5squY13Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYETL/ML; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYETL/ML"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829a568f3ccso204043b3a.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773269550; cv=none;
        d=google.com; s=arc-20240605;
        b=JY7Px3bOHXptCdBbmDVctpE+t8cVtjtLvMf8PLFF2rVFL4SqxxyVB8vtZWF4/s2DMF
         ZJqwAbEYqG6JlkZIj/KeiK6tSNQTeP0x7m3c5+IFwJmaXhvh+0PRweJYOnbo2tvzN3YR
         gKf31saw5gL6u3/Nlr1mMA+Ovz20QoNtY0AFFn4oqM4/YkY/c9A6c1v1UuCx4iLiI6Sq
         ejoIjVZKz49tIB36e6CbLolzoNflTgKmk8K4+0/qbwTlS7YXh5BhUumCLQ0OuFTim0q8
         U0xv8XmTH2+cxUbMyf5HmXICPmjhgIQkk1Yz/4WUCex3olHvF2koPvZM9LhiZOnpBLrT
         e9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xk0mBrxdp2tbfvGjKsNxjDBnOGfmHDfPY92MGBtbSGw=;
        fh=ZqLy7nsbZPqif3py0IdrWtAscshtLxCQG+vBYqFD3Fg=;
        b=OeoBZJssPBSe0rpmy/KT4OMhYCgVLIdP8IAjc5Uj6HkQElfpgp7PlTlrMUBgQiumvw
         3BN7ffzvp8cLJiARqD+LJqa2QK86DrSyN0gm2fLKdmLUGAs420nOj4IO/BJrCnAbhyw6
         ijUgJPv6QTq+LPiOWB9xu7sKlLLPwDHzoR0+UP3FuP1t+LfSyi30Ln1NK4pGz6sFAtoe
         K56nxTaY/RWJQmCAyywHeNqTCTJXktogVU1bkOmPVq8aU2A6pY1wn5vkMQ5nFpToBRIJ
         Uef7tuXdcO9tuZk7Bd8pgGrFH6Wp1ghrHFxxkccuqpsAI+yVuAeVdbqZMqzSSo5yay8F
         9K1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773269550; x=1773874350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk0mBrxdp2tbfvGjKsNxjDBnOGfmHDfPY92MGBtbSGw=;
        b=hYETL/ML9R+2+FkVrDgceV10zAyvjbscE0scgIy/x67bZ3/8ULPhT7Pr1SsN4lIrw1
         VAnJ41XyJaJ8tQJpsflixHAFND9cuxLdP7KheMlOawn/OYdmglPV8x2g+GLoNlI6Safo
         V1RgQb0NhNwP9KqZmPicscvnSbFySOZz8qLpr8osytYfYdYYUowFDevB7eyXPPbb7C7D
         DfdPq3lQpJlQkfBteyt54N4ijJDDenpgmYUXk2o0+hY+EMH+4m5iyfRcJWtqAg0dOpjV
         Ye5R5GVL4qOVyLwn9hJ0xh4Fpi96XsO841V8hJloyXZnhAC1a8JY5q4TiYUS1EQHaX1h
         KrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773269550; x=1773874350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xk0mBrxdp2tbfvGjKsNxjDBnOGfmHDfPY92MGBtbSGw=;
        b=bc7zZSDyuwjzdq9sIM2GFkUwEGc75G+pP36D34pVb1YHzMJqS+7IqZEDgaWSMgKOBm
         ouBJYzNiylelsI3/Q5g4N4xiN4BU/v42pSlUo8nu9D0S5FltlAcNNGUxsbMEJ0yzphhe
         T7+1boZya5+bnZi6VJlApYKNA4UOiMjNYnZTzxXhwiH6b/PT+jtKMi3NxsKE8/puUC4Y
         JFpfqQXi5Mgd3pwWgaytYL+Cfka0/klDXXRRaGdRQ8Ex0gazwTzU41zXeTrPBJgJd6C8
         BRJWnDi1DfVZgHiBTeKukKzw1767ycPNdccj7WDYwV+c9758LjkZrfm1FQ2FSbhMO2w3
         yFJw==
X-Forwarded-Encrypted: i=1; AJvYcCUdsultgvXQL4S6JwP0d8GT+po+vPshGfdI62Pdwl6aK4/6L5d/zG47kiSMSH+jepDtroM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRN1/wu6dYtkOOpdxs4sv7vEf5Q8eug7wDiEuI86Y3Z6N7rd7d
	0zw2hFEtBsO2OVkoT20rsYmqHb0kPQNeiEWJM8VbyiyhCtdRzzgxEErIzhhJ/OlVI9Pq1BiXGAW
	Vwzflt93Xsgd85Rno57kZUhPH+c3S+kM=
X-Gm-Gg: ATEYQzwNcFlc8JBKFWHph+9CgkFcD6Ss8oXcxfnFaRtl037hPeNFu3nyv2tJ/UxXGab
	rU4iJJTpC4oR5AdIuZtw5e34BK67LYQfehi5jiPVIV6m2Aautpp45A8apeKVxiQtU9nMRftKvAd
	CshLKEgt+qbC0RTMoi3qAm6FKOVr6Ax3t8LvMZgKYnzzKFYL7VFiJQJ76useqdWs1XUM+ohSw4o
	OlHvZ0v8gH2TO/Y/2A1iO2dZOsFEVTO1QYvCpbnEZAWFvO+ZNhiCNsQIzGOqo55qR9b++6dI5ur
	a3dcrbM7QR5J1VG+aA==
X-Received: by 2002:a05:6a00:b51:b0:829:894a:9e83 with SMTP id
 d2e1a72fcca58-829f70687f6mr3265596b3a.30.1773269549732; Wed, 11 Mar 2026
 15:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com> <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
In-Reply-To: <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 15:52:17 -0700
X-Gm-Features: AaiRm50TQEFgGYKnqtWnurhhOiq13l2AAAoPERq1d-Ih0fnFU2b1XkyQ0nzeNYk
Message-ID: <CAEf4BzYbUhpwP3nq=M4Ph12LwRYO+mYSQB8SJjsw0AzZAFqyVQ@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, kernel-team@meta.com, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:22=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> Mykyta and Andrii Hi!
>
> We're evaluating the bpf_object__prepare() +
> bpf_program__clone() API for use in a production BPF
> application that manages hundreds of BPF programs with
> selective (dynamic) loading =E2=80=94 some programs are loaded at
> startup, others loaded/unloaded at runtime based on feature
> configuration.
>
> We have a few questions about the intended usage and
> potential extensions of this API:
>
> 1. Compatibility with bpf_object__load() and object state
>
> After bpf_object__prepare(), the object is in OBJ_PREPARED
> state. Several libbpf APIs (e.g., bpf_program__set_type())
> gate on OBJ_LOADED state.
>
> Is there a recommended way to transition the object to
> OBJ_LOADED after cloning all desired programs? For example,
> would a bpf_object__finalize() or similar API that runs
> post_load_cleanup() and sets OBJ_LOADED be in scope? This
> would allow users to benefit from prepare() + clone() for
> selective loading while keeping the object in a state that
> the rest of libbpf expects. Or, is the new API not intended
> to work with bpf_object in the first place ?

exactly, it's not. It's an escape hatch out of bpf_object into
low-level FD, it was never designed to produce something that should
be put back into bpf_object. This clone stuff if for generic low-level
tooling like veristat and/or maybe bpftool's generic program loading.
And another one is cloning the same fentry program to be attached into
multiple uniform targets (I do a similar hack in retsnoop, for
instance).

In none of those cases cloned FDs are meant to be interoperable with
bpf_object/bpf_program abstractions.

>
> 2. Storing the clone FD back on struct bpf_program
>
> bpf_program__clone() returns a caller-owned FD, but APIs
> like bpf_program__attach() read prog->fd internally.
> Without a way to set the FD back on the program struct, the
> caller must reimplement attach logic (section-type dispatch
> for kprobe, fentry, raw_tp, etc.).
>
> Would a bpf_program__set_fd() setter (similar to the
> existing btf__set_fd()) be acceptable to store the clone FD
> back, making bpf_program__attach() and related APIs usable
> with cloned programs?

technically this could be done, probably, but it just feels too dirty,
tbh... there is so much program-specific information that libbpf
internally preserves (and gives access to most of it through
bpf_program's getter) that would need to be invalidated and/or
re-fetched with this set_fd() approach, that I don't really even want
to consider this too seriously... but see below

>
> 3. Use case: selective program loading from a single BPF
>  object
>
> Our use case involves a single large BPF object (skeleton)
> with hundreds of programs where a subset is loaded at
> startup and others are loaded/unloaded dynamically based on
> runtime configuration. The current approach requires either:
> - Loading all programs upfront (wasteful), or
> - Maintaining out-of-tree patches to libbpf for selective
> loading
>
> Last year we made an attempt to upstream our solution to
> this use case to libbpf[1] but Andrii pointed out how our
> approach was problematic for upstream. He then proposed
> splitting bpf_object__load() into two steps:
> bpf_object__prepare() (creates maps, loads BTF, does
> relocations, produces final program instructions) and then
> bpf_object__load().  We are trying to follow up on his
> input and become more upstream compliant.
>
> The prepare() + clone() API seems similiar to this,
> but the questions above about object state and FD ownership
> are the main gaps for production adoption. Are there plans
> to address these in future revisions, or is this
> intentionally scoped to testing/tooling use cases only?

I remember your use case. I don't think clone is really a great fit
*if* you still want to stay at bpf_object/bpf skeleton high-level of
API (i.e., if you want to use bpf_program__attach() APIs and BPF
links).

While definitely a complication, I think we can add support for
loading BPF program after bpf_object__load() happened. You'd have to
keep your optional programs as non-autoloaded (or
bpf_program__set_autoload(false) explicitly), and I'm thinking we
might want to make this behavior opt-in explicitly through
bpf_object_open_opts(), as there are various points in bpf_object
lifetime where we make some decisions with the assumption that
programs will never be loaded, so we'll need to explicitly indicate
that *all* programs would need to be considered loadable, but maybe
much later.

Another thing that won't (or rather might not) work is declarative
prog_array initialization and struct_ops. Those two steps happen in
bpf_object__load() after all programs are loaded. I don't think that
is the problem for you, but I just want to point out that program
loading is not always the last step.

But other than that, despite added complications, it's probably better
to just allow to load programs lazily after bpf_object__load(), after
all.

>
> Thanks,
> Andrey
>
> [1] -https://lore.kernel.org/all/20250122215206.59859-1-slava.imameev@cro=
wdstrike.com/t/#m93ec917b3dfe3115be2a4b6439e2c649c791686d
>
> On Fri, Feb 20, 2026 at 2:18=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Add bpf_program__clone() API that loads a single BPF program from a
> > prepared BPF object into the kernel, returning a file descriptor owned
> > by the caller.
> >
> > After bpf_object__prepare(), callers can use bpf_program__clone() to
> > load individual programs with custom bpf_prog_load_opts, instead of
> > loading all programs at once via bpf_object__load(). Non-zero fields in
> > opts override the defaults derived from the program and object
> > internals; passing NULL opts populates everything automatically.
> >
> > Internally, bpf_program__clone() resolves BTF-based attach targets
> > (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
> > func/line info, fd_array, license, and kern_version from the
> > prepared object before calling bpf_prog_load().
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
> >  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3=
_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6UokY=
qOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  |  1 +
> >  3 files changed, 82 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 0c8bf0b5cce4..4b084bda3f47 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct bp=
f_program *prog)
> >         return prog->line_info_cnt;
> >  }
> >
> > +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog=
_load_opts *opts)
> > +{
> > +       LIBBPF_OPTS(bpf_prog_load_opts, attr);
> > +       struct bpf_prog_load_opts *pattr =3D &attr;
> > +       struct bpf_object *obj;
> > +       int err, fd;
> > +
> > +       if (!prog)
> > +               return libbpf_err(-EINVAL);
> > +
> > +       if (!OPTS_VALID(opts, bpf_prog_load_opts))
> > +               return libbpf_err(-EINVAL);
> > +
> > +       obj =3D prog->obj;
> > +       if (obj->state < OBJ_PREPARED)
> > +               return libbpf_err(-EINVAL);
> > +
> > +       /* Copy caller opts, fall back to prog/object defaults */
> > +       OPTS_SET(pattr, expected_attach_type,
> > +                OPTS_GET(opts, expected_attach_type, 0) ?: prog->expec=
ted_attach_type);
> > +       OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0)=
 ?: prog->attach_btf_id);
> > +       OPTS_SET(pattr, attach_btf_obj_fd,
> > +                OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_b=
tf_obj_fd);
> > +       OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd, =
0) ?: prog->attach_prog_fd);
> > +       OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: pr=
og->prog_flags);
> > +       OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) ?=
: prog->prog_ifindex);
> > +       OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) ?=
: obj->kern_version);
> > +       OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: obj=
->fd_array);
> > +       OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->t=
oken_fd);
> > +       if (attr.token_fd)
> > +               attr.prog_flags |=3D BPF_F_TOKEN_FD;
> > +
> > +       /* BTF func/line info */
> > +       if (obj->btf && btf__fd(obj->btf) >=3D 0) {
> > +               OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_fd=
, 0) ?: btf__fd(obj->btf));
> > +               OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, NU=
LL) ?: prog->func_info);
> > +               OPTS_SET(pattr, func_info_cnt,
> > +                        OPTS_GET(opts, func_info_cnt, 0) ?: prog->func=
_info_cnt);
> > +               OPTS_SET(pattr, func_info_rec_size,
> > +                        OPTS_GET(opts, func_info_rec_size, 0) ?: prog-=
>func_info_rec_size);
> > +               OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, NU=
LL) ?: prog->line_info);
> > +               OPTS_SET(pattr, line_info_cnt,
> > +                        OPTS_GET(opts, line_info_cnt, 0) ?: prog->line=
_info_cnt);
> > +               OPTS_SET(pattr, line_info_rec_size,
> > +                        OPTS_GET(opts, line_info_rec_size, 0) ?: prog-=
>line_info_rec_size);
> > +       }
> > +
> > +       OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
> > +       OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
> > +       OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
> > +
> > +       /* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
> > +       if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> > +               err =3D prog->sec_def->prog_prepare_load_fn(prog, pattr=
, prog->sec_def->cookie);
> > +               if (err)
> > +                       return libbpf_err(err);
> > +       }
> > +
> > +       fd =3D bpf_prog_load(prog->type, prog->name, obj->license, prog=
->insns, prog->insns_cnt,
> > +                          pattr);
> > +
> > +       return libbpf_err(fd);
> > +}
> > +
> >  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                  =
     \
> >         .sec =3D (char *)sec_pfx,                                      =
       \
> >         .prog_type =3D BPF_PROG_TYPE_##ptype,                          =
       \
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index dfc37a615578..0be34852350f 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -2021,6 +2021,23 @@ LIBBPF_API int libbpf_register_prog_handler(cons=
t char *sec,
> >   */
> >  LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
> >
> > +/**
> > + * @brief **bpf_program__clone()** loads a single BPF program from a p=
repared
> > + * BPF object into the kernel, returning its file descriptor.
> > + *
> > + * The BPF object must have been previously prepared with
> > + * **bpf_object__prepare()**. If @opts is provided, any non-zero field
> > + * overrides the defaults derived from the program/object internals.
> > + * If @opts is NULL, all fields are populated automatically.
> > + *
> > + * The returned FD is owned by the caller and must be closed with clos=
e().
> > + *
> > + * @param prog BPF program from a prepared object
> > + * @param opts Optional load options; non-zero fields override default=
s
> > + * @return program FD (>=3D 0) on success; negative error code on fail=
ure
> > + */
> > +LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const stru=
ct bpf_prog_load_opts *opts);
> > +
> >  #ifdef __cplusplus
> >  } /* extern "C" */
> >  #endif
> > diff --git a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.ma=
p__;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfa=
qSd4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  b/tools/lib/bpf/https:=
//urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl=
_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1=
BiJSjA99yzJZk$
> > index d18fbcea7578..e727a54e373a 100644
> > --- a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!B=
mdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N=
6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
> > +++ b/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!B=
mdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N=
6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
> > @@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
> >                 bpf_map__set_exclusive_program;
> >                 bpf_map__exclusive_program;
> >                 bpf_prog_assoc_struct_ops;
> > +               bpf_program__clone;
> >                 bpf_program__assoc_struct_ops;
> >                 btf__permute;
> >  } LIBBPF_1.6.0;
> >
> > --
> > 2.47.3
> >
> >
