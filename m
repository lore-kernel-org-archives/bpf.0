Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792536486;
	b=splDGyIkIfk1Iiss7ERQzh3ig57fucQ/+CdFV5KqD6QyRJUTtmsS/r0qzkS65+8ZhW7i
	 U676a48WT9hsfQ0jW6N0lxLQFAqpJQOoekMe4Cf/IEKBGanhAB89Ymmf1KwaEN9WXFlFg
	 7ckJOFRim8NRZ3IgG4ygv67jfx8gltfV3/IenTpPnG2Gy71u/yoDstobJmOKtR/v7YVOi
	 2ucv2BjvbjKCUSsqN7vH4di9gwxRYSdy+FNdqTLlsmZq5kMushXKwAQ2NvXeyiiOZfIwx
	 o0pQeTd8/Ir/dzRo/EqRmax071aWSbVIJ1SVPqDnjwinW9fUMINawloLJKe+Jm3YlTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6yXfb9mjujsVRy/vJZuGdz5kAO1npB7zLQ/d5HyY2C4=;
	b=K50QTKPWv6LPfBswocfn/3kqunJwB2X7TafZtJGkqWS2d414eFyJa4U+PA8/hj+fe7Jg
	 dbQbWq0uDAzmcOGnfhdv+t6lBUCJ9t8dbtYbdGQpOaMt80GUOuJRMMuLRRYWHmHpgmgIU
	 Rqd+rPi52PQrIl6NxtlyJ888N6DZ6C6ZxPGp7RiRb34P+kVJQwf/2lSVHJMxdp4gzKDNH
	 1EPZXRE1Zhcv+cnTc8Lon/m5o8st8xMtpCPzpcLfUrP1kkeu+uenp5rEJs8hE7aPwuFb6
	 6evpvxB25Gadn0EXCTQO+P6A2nwTUscKRJtvGzbkiH36FBMD5XYYp9A0Zi95DNbtTqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wStoV3WS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B02606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 22:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B02606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wStoV3WS
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so61009a12.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792536484; cv=none;
        d=google.com; s=arc-20260327;
        b=VP6puwDvpSMClS/xugdTex4n5CEcpVcNGgrmpzDUHp1Ev34BdzUmZm3srym1ZEWUna
         FXbpRaaYmZvXcdnPCifBq6EgzL6DBHUy+htR00ReCQnSflG9ln2K451jkMqLiq2Gy5YX
         HkPaHUjHfghNDmag4zSigA95bZ0TL7jvoi+PKUzE9DsE5JinOgEWgfHr8dq5fdhwLlEC
         qrw9nRa0DMFdICubK9VI8Gm6TjHYJDG74hKrh6nGZ+nxM+tZh8Fqn+aFy1IgZE2H5L8S
         p9n2g3GOv15eAwWDmX90238Mz+ZJqJCv2wj4F96ZJnLZRca2r6jKeG+8aHlG3eRAOseN
         52dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6yXfb9mjujsVRy/vJZuGdz5kAO1npB7zLQ/d5HyY2C4=;
        fh=PEkDiLhMSCMQdtGR1aj4mlnQrHipeoiz8fWgDNOaeDg=;
        b=IkOUB3rpRrj+bMEDa2ytMmCvWgSVMzYBQ2Q2iPWN+h0QM1yTNsLlcl6p5c9eEDUct6
         oD++Wyv2eR6VTb8COabxyjeNv2dLYfYlaoqh5J9T3zeKa7XarJaGK2AlSBSSxs1u90md
         U1GFh+PZu5zXnzVWYcjBkRMNBUsghe2IW/+2C/sKhGEJTnipVEO+e05iP/UsiGpLuzCr
         zjmR6glTO6zzgHcGOe04z9IQ6OvgxkqOecUljGG+46uy+9wBMRUr9Od+JqMJJ6S3Lsor
         nfNT8nWmeKRSCaQMxLG6NtetIgYpUopdsEQrwU0t0NXDG9Mu46nXrHqDTfZsQAJifnMx
         PquA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792536484; x=1793141284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6yXfb9mjujsVRy/vJZuGdz5kAO1npB7zLQ/d5HyY2C4=;
        b=wStoV3WSPV5rzWT+qtfZtfLiDH5gius5WaC3SxZ7NeM+zdQLgPLL3wMUzjI50SzmQd
         FB0fU8GG8gvfXu9UN8/KoYOUwvE3JMcyOmdjUrfPSVH6WkqvEicaiwtPOWnDSCdJz0EN
         6OTSkL18qrmvvamhqniKnBw0EG+uj8M/W9c7CyNwadvw0PeF/w1Q5GKk77PSL7SU5ExO
         AtA87XCFxLSFfXcwKgTisWsUj1uDJmWD7CCPfLL9ILVWYolY+u5EVLTYKThiFtlXrdch
         VYHFd/WOE/pzteZvgEJEn210ohtLf0Eoe9+aN8M8OWwPbV1zb3JNdFzm+2z91Z9Byaz3
         OyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792536484; x=1793141284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6yXfb9mjujsVRy/vJZuGdz5kAO1npB7zLQ/d5HyY2C4=;
        b=lpDryW4sTH7XoxGze+Tw9++4yDkuHjupuyu0OAixmc6GWLusmq4CCa1NxevYCT/8mP
         vvpqG5I+B+f/WR0qEpFBSRfurwOowz3Xc0tBg7cp57M3A4SxJ1vdLw+1fXkJ7jUgkngU
         mNly3zSjQl/U3MuatAoa2X9Bs6WmI1VOMGsZNTxcwIelRGolNWt4ARzKTawTvQ41cGSD
         WSLlu3sLaemIS8EFMwv1BmoL2rGDFGNgtoXUb00ow4SO/kjayuAPDjPM1GuL2Sk9zLuF
         QdkYJbApRulnPwiPeLbVn2wXnRLDyeGu6VdJlwcZfTzw4R56ljVYoTgF6BGqR1wB+29y
         6Y8Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3ScxMYQg6zrsGyRKdy2bA+WvSZD9P7wQ3qnI6N7IIAWNWpPkLhsSzlO6w3HooCYiUCc0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFyEB8F9eoV614FGiaRfB27F/lQ94G/qNf4n0aO4nPfYRZvJYs
	YXC2Y2gQWMX81OPid10G9puuM9floJ9OoRSHRTVdUU53DJ8MflcjesvVltKKn0NMNmhtwW8m3L5
	3sm/7/HHHW/LbchkwQMn0/eW2/k1LZNjtY8c6yZeq
X-Gm-Gg: AYBFou2/p8CtSUcfgFip+254lFs8PdC4mHzbd68YhVMK9P1TVH1QZvQubFkBqJehWAH
	GzXefKu5o7ZltlVYBdGMYKHBrbi+dw5gqtNmRu3m+pmpD4SrVAPjwZLaXYcnKSXxsphBeOUaqbQ
	sv7wALB2zurj5shhcT1qCUSAnWcsZ0zSQ1iMeixhcD7hy+l2OXeq+4haoNaPxjEWQDre3UHcgyJ
	dS5hXv3z5txjW9D1t08TjY1eiLSiXluuA+DAnPDaceA23XlvoBL7VE49I9CsySjCNQWgAS0hrkb
	wdRlEDUW+WNviBww8gZC0jAdRSjIlcLQrMB+ROiRONm0Tfjg+UY/kTCVnA8pJw44Gcm4tNGPqJ7
	LBndQDR/cig==
X-Received: by 2002:a17:907:8693:b0:c29:4fcb:2886 with SMTP id
 a640c23a62f3a-c46797b975emr38531066b.39.1792536483525; Tue, 20 Oct 2026
 15:48:03 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009130708.1370675-1-wusamuel@google.com> <c090cb17-9bed-4742-a1c1-92cae6ee239e@oracle.com>
 <CAG2KctozPSev+EXSpHitM3JWfjufQaEjsPJHS_1HJ1wSm7sJ1w@mail.gmail.com> <CAEf4BzZQ6uyOOj5gCZyVnqdswtn23wAVWWWsNEH3Ay4drv051Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZQ6uyOOj5gCZyVnqdswtn23wAVWWWsNEH3Ay4drv051Q@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 20 Oct 2026 15:47:51 -0700
X-Gm-Features: AclHuK8bStO7TUz4ooohvy3JJshS0mULX3Tv_T9H4IarvNkAHVHjZ9o7-HaqZX8
Message-ID: <CAG2KctpzyshDMQcztJPUmjUYKKurH5c8+2a0oep0wsG8tR65Cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Resolve typeless ksyms in the kernel
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:55=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Oct 11, 2026 at 8:56=E2=80=AFAM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > On Sat, Oct 10, 2026 at 12:09=E2=80=AFPM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> > >
> > > On 09/10/2026 14:07, Samuel Wu wrote:
> > > > libbpf resolves typeless symbols by parsing /proc/kallsyms, which
> > > > dominates load time for BPF programs with typeless symbols. This mo=
stly
> > > > comes from needing to do thousands of syscalls and a linear scan of
> > > > kallsyms.
> > > >
> > > > Call bpf_kallsyms_lookup_name() from BPF_PROG_TYPE_SYSCALL, such th=
at
> > > > the resolution can be done with a couple of syscalls and a binary
> > > > search. This is a similar approach to what the light skeleton does.=
 The
> > > > fast path passes the name and result through ctx, which requires co=
mmit
> > > > ae5ef001aa98 ("bpf: Support variable offsets for syscall PTR_TO_CTX=
").
> > > >
> > > > Any fast path error (e.g. kernels without ae5ef001aa98) falls back =
to
> > > > the legacy /proc/kallsyms scan, including strong misses, since the
> > > > kernel doesn't match LTO "<name>.llvm.<hash>" symbols. Weak misses
> > > > default to zero.
> > > >
> > > > Depending on the device, I see ~9-11x loading speedup when resolvin=
g a
> > > > BPF program with 11 typeless lock externs.
> > > >   - x86_64 VM, 6.18 + ae5ef001aa98: 147ms -> 17ms
> > > >   - ARM64 phone, 7.1: 626ms -> 55ms
> > > >
> > > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c | 59 ++++++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 58 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index cb09ded90773..7564ec6bde64 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -9590,6 +9590,58 @@ static int bpf_object__read_kallsyms_file(st=
ruct bpf_object *obj)
> > > >       return libbpf_kallsyms_parse(kallsyms_cb, obj);
> > > >  }
> > > >
> > > > +static int bpf_object__resolve_ksyms_in_kernel(struct bpf_object *=
obj)
> > > > +{
> > > > +     struct extern_desc *ext;
> > > > +     int i, prog_fd, err =3D 0;
> > > > +     struct {
> > > > +             __u64 addr;
> > > > +             char name[512];
> > > > +     } ctx =3D {};
> > > > +     LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags =3D BPF_F_S=
LEEPABLE);
> > > > +     LIBBPF_OPTS(bpf_test_run_opts, topts, .ctx_in =3D &ctx, .ctx_=
size_in =3D sizeof(ctx));
> > > > +     /* bpf_kallsyms_lookup_name(ctx.name, sizeof(ctx.name), 0, &c=
tx.addr) */
> > > > +     static const struct bpf_insn insns[] =3D {
> > > > +             BPF_MOV64_REG(BPF_REG_4, BPF_REG_1),
> > > > +             BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
> > > > +             BPF_MOV64_IMM(BPF_REG_2, sizeof(ctx.name)),
> > > > +             BPF_MOV64_IMM(BPF_REG_3, 0),
> > > > +             BPF_EMIT_CALL(BPF_FUNC_kallsyms_lookup_name),
> > > > +             BPF_EXIT_INSN(),
> > > > +     };
> > > > +
> > > > +     if (obj->gen_loader || obj->token_fd)
> > > > +             return -EOPNOTSUPP;
> > > > +
> > > > +     prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL",
> > > > +                             insns, ARRAY_SIZE(insns), &opts);
> > > > +     if (prog_fd < 0)
> > > > +             return prog_fd;
> > > > +
> > > > +     for (i =3D 0; i < obj->nr_extern; i++) {
> > > > +             ext =3D &obj->externs[i];
> > > > +             if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> > > > +                     continue;
> > > > +             if (snprintf(ctx.name, sizeof(ctx.name), "%s", ext->n=
ame) >=3D sizeof(ctx.name)) {
> > > > +                     err =3D -ENAMETOOLONG;
> > > > +                     break;
> > > > +             }
> > > > +             err =3D bpf_prog_test_run_opts(prog_fd, &topts) ?: (i=
nt)topts.retval;
> > > > +             if (err =3D=3D -ENOENT && ext->is_weak) {
> > > > +                     err =3D 0;
> > > > +                     continue;
> > > > +             }
> > > > +             if (err)
> > > > +                     break;
> > > > +             ext->is_set =3D true;
> > > > +             ext->ksym.addr =3D ctx.addr;
> > > > +             pr_debug("extern (ksym) '%s': resolved in kernel to 0=
x%llx\n",
> > > > +                      ext->name, ext->ksym.addr);
> > > > +     }
> > >
> > > Great to see the win in terms of resolution time, but I wonder if we =
could
> > > speed things up further by resolving multiple symbols at once, since =
we have
> > > all the externs available (either by dynamically creating your progra=
m that
> > > does symbol resolution as a side-effect, or adding a more direct reso=
lution method)?
> > >
> > > A single syscall could provide an even faster speedup, so might be wo=
rth a look.
> >
> > I tried resolving multiple symbols in one pass, but unfortunately the
> > impact was negligible and made the code much more complex. I profiled
> > a few numbers, and turns out it's because resolving typeless symbols
> > is down to ~1% of total load time (from ~90%), with the remaining time
> > mostly spent on BTF loading, CORE relocation, and BPF verification.
> >
> > > Another concern would be a lot of production kernels won't have BPF t=
est run
> > > support baked in, so relying on that without fallback would be a prob=
lem.
> >
> > Are you referring to BPF_PROG_TEST_RUN when mentioning "BPF test run
> > support", or something else? And totally agreed in that we need a
> > fallback, of which it currently falls back to reading /proc/kallsyms
> > on any error during the new fast path.
> >
>
> Have you considered adding a faster interface to /proc/kallsyms
> instead? That would benefit not just this particular use case, but
> generally lots of other user space applications that have to deal with
> kallsyms (all kinds of symbolizers, tracers, etc).
>
> A while ago I added PROCMAP_QUERY ioctl()-based interface to
> /proc/PID/maps to query process VMAs and I think it turned out quite
> nicely and is super useful in practice. Back then I was hoping we'll
> eventually also add similar (in principle) extensible ioctl()-based
> interface to /proc/kallsyms as well, so that at least fast
> address-to-symbol and symbol name-to-symbol point query could be done
> quickly. And it actually would finally provide a way to provide more
> information per kernel symbol, if necessary (/proc/kallsyms is
> basically set in stone, besides it being text based and thus slow and
> inconvenient for programmatic access).
>
> Can you please look into that, I think it would be a much more generic
> and desirable outcome instead of this somewhat hacky solution of
> calling BPF program to resolve a symbol.
>
> WDYT?

Thanks for the feedback Andrii. An ioctl for kallsyms makes sense. I
agree it would be useful for userspace outside of libbpf, and it would
probably provide a significant speedup vs today's text based parsing.

I'll send a patchset out when I get something working!

> pw-bot: cr
>
>
> > > > +     close(prog_fd);
> > > > +     return err;
> > > > +}
> > > > +
> > > >  static int find_ksym_btf_id(struct bpf_object *obj, const char *ks=
ym_name,
> > > >                           __u16 kind, struct btf **res_btf,
> > > >                           struct module_btf **res_mod_btf)
> > > > @@ -9863,7 +9915,12 @@ static int bpf_object__resolve_externs(struc=
t bpf_object *obj,
> > > >                       return -EINVAL;
> > > >       }
> > > >       if (need_kallsyms) {
> > > > -             err =3D bpf_object__read_kallsyms_file(obj);
> > > > +             err =3D bpf_object__resolve_ksyms_in_kernel(obj);
> > > > +             if (err) {
> > > > +                     pr_debug("failed to resolve ksyms in kernel: =
%s, falling back to /proc/kallsyms\n",
> > > > +                              errstr(err));
> > > > +                     err =3D bpf_object__read_kallsyms_file(obj);
> > > > +             }
> > > >               if (err)
> > > >                       return -EINVAL;
> > > >       }
> > >
