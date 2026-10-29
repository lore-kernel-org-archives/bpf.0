Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793311118;
	b=ceZcji1rD/Jao+d8oECUlYIjQ+68U3VSzhOIEk29dX3jQiz8ngWIZs/SunvqLN8pK+GK
	 FarkgAYh9bBgTnFOdI0ypX+I2p5GKI85kXeXqnjgmtoIMvvtT+HCYWiaRQDXntac3Tdoj
	 J6gOCFfqOOUNektn/exkJeuQjGDOxsjr4H2gbsYtb/vImFdLHHfnIKDWKOtXCvAg31WGG
	 DfkMb7LtwT2/obVtf4Jl2qK/5U+fCPGMa/tx0JV1jQ5AyR0rQ/Agip+yS0J6aAdncrm7Z
	 3i3jPDDJC5wO0LgYTDlzZQJnMA3g2urvqsHZaYDJAbCamsHOL0PDrDbYFZCDdeknPcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B9+gAB8Cjyl4VLckQC54VBSrUBYtxpoBl30X97BtI60=;
	b=VBZSlSwqpZQ/qb7Dq6g26p3WMTApDp5pDW/AGC85PTMaez7vk0jC4Zs/P/r5y3ngftY9
	 o4i2bn6NHYsmYuphFXmkfHZojVex1t+EpJDUIAyi6w7QMEnOm4ES67exEbZB4NkbZbcBf
	 dd4PJDuyd754yALQdRkmUMxwvynp3gtZKRW2G5vRI2LR/cgvazsq5nL1Hj11Kp+qysy5e
	 3eDnzlPRAW/MobfNKOxInssI2HiL0qSZII4FMoMx9kJRdB/psDXvY1dJu9NrwjhohVY2/
	 a5zceI8Tzre4gbNfdgIjdmIu2GVflE4jtI9EROXxdVsiUIN3Bg1t0QWXZVDdgKcV17A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VjfWL3MC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E72606A323
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E72606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VjfWL3MC
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c49c32650adso3313266b.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 14:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311116; cv=none;
        d=google.com; s=arc-20260327;
        b=dpc7rXXVJUQj11E2gPxuV7vb/u8VtlAbZSBxL3WzmRFwABgur+58D11Un9HS5u/ksR
         3sPE1qg78KEkpSHgGueNUeHfR5SMBWQk3M9nEcvtgIYH/A9veXJYfeHZxI7H7Mn4SyiI
         0/dOE5lKIa4OzuOIfjHvQbiV5JokzVD3OM9I5GfC2YxIpPN81i5C3uSxr1ldrdZmXV2O
         gC+TrLdJhdpw0ymOu3wV5dlZZ99ZghWBAVfI9Eduy88geUPa/wYrz9dnQsU3O6c8hWwC
         MrC6JoKtAhPetMM6o+IDUtKeCg/wMpDscDkKx15HmgcBnY7P14c3PMbGagaUAnYr0oOC
         3f/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B9+gAB8Cjyl4VLckQC54VBSrUBYtxpoBl30X97BtI60=;
        fh=2dQBHBbiq7dUNB4GZRROWPMdukrtXwl3gnu52+ZTgvY=;
        b=pMJCdwpregiDl9ciTFtB6+Yp9HWFRPxMGGt708pzxMSVbaNwCUng79xs+zdmQNCE2l
         Uf89FC06fL40YTGWjjIIuKP2GWMhE4ZD1weAIKISgcnoNSygYA62BhH2xOupUe9+4Gil
         /05tKxFzmzWIMmKPMQ2XFCbABBQz4X2QyDBEpGuSChV4KzMmJONNmyM8TLJBJd9F0RUQ
         UVUsjvngIUkc58a8kTSepG04OCeGfkkDJh8p4eLTSM47GeQZkNkeQlVCDYWrUZODjFLp
         FDzsXpY3JHxN0rgu0VLGNi5zYvSfFAOb4q6NAkGYf5ifzwMZZh8/H3Ify/on/I354mPr
         ZNEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793311116; x=1793915916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B9+gAB8Cjyl4VLckQC54VBSrUBYtxpoBl30X97BtI60=;
        b=VjfWL3MCQHgmtdTsMUdVT/rqpu68psBenh5+JCuYyGF3lPR5M/yQZLl90WV2OoCDZg
         Jg42rc7B+OFHBpm1AepennXZtjf8i5xyUVe72eqbT5Uoa5DfgMGcHMG919fY8s/L1YJH
         d8ieC/BLo2m/7P5tfU/fRwBYGYrOa62tA5lKxIARqRT51xhdEcgmoTI5Lz4OGEGpL7F+
         g3zPnmHucBga0p4sKNpSyCbxBZCeAdC4A4pdcgpxZpwT2EaB/qoU86h0nL3YtWblL4p6
         W2jO7v2BhxlrAuor2HisrNjrTQVSsvS8eksa0Oy1J/AcgTs/RL+ZJtGzUhHTOL4a1pfB
         mc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311116; x=1793915916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B9+gAB8Cjyl4VLckQC54VBSrUBYtxpoBl30X97BtI60=;
        b=rsqL5ubnZ+wfpnheb4a7Q6WQwY3Q2G22OwSdaQY0cNrQUJvLB0tI7TuvG3BA6Q+8HL
         EPKCltXdqzD/y79JRPrrqYBmlID61nHr1iFJWiG2tflQbwlNXqLAxMBpFb9B8DEO1mrM
         g9eCNGqj1F7OuXZl/E9o6/SG6l2ddFMlQmz9uof99HZzJnoMfl03ggrobgTG9o68W1/M
         yIm1IGwUC2kpR/NHRAdBcwUBVwH13gXdJ4XuSoDSoYiVuhxeXYCGFONVCa4O5s/Dsxnv
         k5++fD+Q31Z9Eokk0sHkwHbAJw+O8sKvsRjJGshJh2HMmulTD8hgNZdDaR3roDOJEAnq
         fSAA==
X-Forwarded-Encrypted: i=1; AKwUvBzMgcH9Rm/n6TIPRfYcsJ9/2LugX8bImZhsA/ET/TWFtBLIuMBe6LXF69SarOyyhkn4PQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOC1CnfOzIzbDzqK0H9UG3hz5viHN4TYalswwUEPzv33j/JN21
	enKiQ5zyxCYW28JjwCDu18e5vREOrgkRwFYX2JespR9u6SB6WYJoiYRODEz0bkfnMyyU2aBDuX+
	hh3WP5oeFCtETKSEMgQXf62+LZ2CZW+rtI3xG8XpG
X-Gm-Gg: AYBFou2fEROgfq4xT0ZmzfZmbal62l4IKS8eDWazNent/WRJ/6Egbe9oBkLmrVjXSm5
	AqbkwexQto7S8xiLpMgP4izweqQK3KPvwvmLZzK/JEPf7qZJRBB+CLAhJpUNhBZ6n2ntiqzM485
	UDn89vDUfVQW3vD/hzxszUbeEDY8mEosiUrefshUGpAHdfLoAbAktVHeduWbcKzXP2HAy+vZXQM
	P9MHnnyM/R6Wsrs72bPk5SLLAUCA0JFpPHOtDAa5dj8eLYiH6JPbivUk+OxCV7IeMVwkE+9J7Yr
	4VJdPHArgbu851XPqlgdU7LLkjSL5vsWnv5eufyP2hrn+W10kKSOXIqc9i7Hvm7Qea2mxIkYFLy
	02rkmPBmVSg2q80hUeX/8sAR89jmw4soiMttJaOVF+gWc3ToWLVFnjIp1gBuCo7IwAWUlSPE=
X-Received: by 2002:a17:907:18c3:b0:c26:22ae:b66b with SMTP id
 a640c23a62f3a-c4ca7aee966mr31602566b.15.1793311115078; Thu, 29 Oct 2026
 14:58:35 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <CAEf4Bzb--Jzz696u057G9_CgQN7zf6ksvoL80KJacKO2CorsnQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb--Jzz696u057G9_CgQN7zf6ksvoL80KJacKO2CorsnQ@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 29 Oct 2026 14:58:23 -0700
X-Gm-Features: AclHuK8Skd5aK1mpj2aYhCa7McUFcLlkjExMScvtTmOLJycjBhAcAzm-z_wLwRU
Message-ID: <CAG2Kctojb7xiOqTmwWqoAKFaNUECjOzXVc_t6KbG13Pqm2dbng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:25=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 22, 2026 at 5:17=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > Add an extensible KALLSYMS_QUERY ioctl() interface to /proc/kallsyms
> > to support fast point queries without scanning the entire text file.
> > Exactly one query mode must be set in query_flags.
> >
> > When KALLSYMS_QUERY_BY_SYMBOL is set in query_flags, KALLSYMS_QUERY
> > resolves a NUL-terminated symbol name in vmlinux or loaded modules and
> > then populates sym_addr:
> > - Searches vmlinux first via kallsyms_lookup_names() (binary search),
> >   which takes precedence over loaded modules, and falls back to
> >   module_kallsyms_on_each_symbol() under module_mutex for module
> >   symbols
> > - Matches names exactly, like kallsyms_lookup_name(), disregarding the
> >   .llvm.<hash> matching, following precedent set by commit fb6a421fb615
> >   ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
> > - Resolves 0x0 symbol addresses in both vmlinux and modules
> > - Rejects ambiguous symbols (multiple entries with the same name at
> >   different addresses within vmlinux, or across loaded modules) with
> >   -EADDRNOTAVAIL, while allowing same-address aliases
> >
> > Userspace symbolizers resolve kernel addresses to symbol names with
> > /proc/kallsyms. This is typically done by reading the entire
> > /proc/kallsyms text file, and keeping a compressed sorted copy of it in
> > order to resolve addresses at runtime.
> >
> > When KALLSYMS_QUERY_BY_ADDR is set in query_flags, KALLSYMS_QUERY
> > resolves one address to the symbol that contains it:
> > - sym_addr holds the address to resolve on input.
> > - sym_name_addr must point to a user buffer of sym_name_size bytes
> >   that receives the NUL-terminated symbol name. On output,
> >   sym_name_size holds the number of bytes written (including the
> >   terminating NUL). -ENAMETOOLONG is returned if the buffer is too
> >   small; a buffer of KSYM_NAME_LEN (512 at the time of writing) bytes
> >   is always large enough.
> > - Symbols are resolved via kallsyms_lookup(), the same lookup as %pS,
> >   covering vmlinux, loaded modules, BPF JIT images, and freed module
> >   init functions still tracked by ftrace.
> >
> > On an 8 CPU Cuttlefish (x86-64 VM), using this patchseries to load a BP=
F
> > program with 11 typeless ksyms has ~220x speedup (157ms -> 0.7ms).
> >
> > On an 8 CPU x86-64 VM with a 175k line kallsyms, there are broad
> > performance and memory savings for the symbolization and callstack
> > sampling tool, Perfetto:
> > - Init time: ~350x speedup (155.7ms -> 0.44ms)
> > - 50k symbolizations: ~12x speedup (25.2ms -> 2.2ms)
> > - VmRSS: -68% (15.1MB -> 4.8MB)
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >  include/uapi/linux/fs.h |  41 +++++++++++++
> >  kernel/kallsyms.c       | 132 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 173 insertions(+)
> >
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 34c6f219462a..b43f227dad0e 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -674,6 +674,47 @@ struct procmap_query {
> >         __u64 build_id_addr;            /* in */
> >  };
> >
> > +/* /proc/kallsyms ioctl */
> > +#define KALLSYMS_QUERY _IOWR(PROCFS_IOCTL_MAGIC, 18, struct kallsyms_q=
uery)
> > +
> > +/* Exactly one query mode must be set in query_flags. */
> > +enum kallsyms_query_flags {
> > +       /*
> > +        * Look up a symbol in vmlinux or loaded modules (vmlinux first=
; BPF
> > +        * and ftrace symbols are not searched) by exact NUL-terminated=
 name
> > +        * at sym_name_addr and return sym_addr. sym_addr and sym_name_=
size
> > +        * must be 0 on input.
> > +        */
> > +       KALLSYMS_QUERY_BY_SYMBOL =3D 0x01,
> > +       /*
> > +        * Look up the symbol covering sym_addr and write its NUL-termi=
nated
> > +        * name to the sym_name_addr buffer of sym_name_size bytes. The=
 same
> > +        * symbols as %pS are searched: vmlinux, loaded modules, BPF JI=
T
> > +        * images, and freed module init functions still tracked by ftr=
ace.
> > +        * A buffer of KSYM_NAME_LEN (512 at the time of writing) bytes=
 is
> > +        * always enough. On success, sym_name_size is set to the numbe=
r of
> > +        * bytes written (including the terminating NUL).
> > +        */
> > +       KALLSYMS_QUERY_BY_ADDR =3D 0x02,
> > +};
> > +
> > +/*
> > + * Returns -ENOENT if no symbol matches, -EADDRNOTAVAIL if the name ma=
ps to
> > + * more than one address, -ENAMETOOLONG if the name does not fit in
> > + * KSYM_NAME_LEN (512 at the time of writing) or sym_name_size bytes, =
and
> > + * -EPERM if kallsyms addresses are hidden from the opener of /proc/ka=
llsyms
> > + * (e.g. kptr_restrict).
> > + */
> > +struct kallsyms_query {
> > +       __u64 size;             /* in - struct size for compatibility *=
/
> > +       __u64 query_flags;      /* in - query mode (enum kallsyms_query=
_flags) */
> > +       __u64 sym_name_addr;    /* in - address of symbol name buffer *=
/
> > +       __u64 sym_addr;         /* out (BY_SYMBOL) / in (BY_ADDR) */
> > +       __u64 sym_name_size;    /* in/out - name buffer size / bytes wr=
itten */
> > +};
>
> it might be smart to have QUERY_BY_ADDR and QUERY_BY_NAME to be two
> separate ioctl commands with its own query in/out struct. This would
> remove addr vs name ambiguity in sym_name_addr field, and will allow
> us to evolve APIs independently, if necessary. They should still
> probably reuse the same type to represent symbol information, and have
> kallsyms_query struct provide a pointer to that struct (and its
> maximum size), which the kernel will fill out and set the size it
> actually knows about.
>
> struct kallsyms_query_by_addr {
>     __u64 size;
>     __u64 query_flags;
>     __u64 sym_addr; /* in */
>     struct kallsyms_sym *sym; /* out */
>     __u64 sym_len;
> };
>
> struct kallsyms_sym {
>     __u64 sym_addr;
>     __u64 sym_name;
>     __u64 sym_name_len;
>     __u64 sym_module;
>     __u64 sym_module_len; /* if zero, no module requested/available */
> };
>
> e.g. for symbol you'd want to return its name, address, but also
> module name. and we should leave a way to extend it further with more
> optional information (that's the kallsyms extensibility bit I was
> talking about).

Agree, two ioctls with a shared symbol type is cleaner. v3 plan is to
have QUERY_BY_NAME and QUERY_BY_ADDR both fill a shared struct
kallsyms_sym (address, size, name, module), passed by pointer so it
can grow later.

> aslo, we should think about adding ways to paginate (or at least leave
> a possibility of that in the future) if there are multiple matches
> (e.g., for static functions with the same name resolving to multiple
> addresses); not sure how it should look like API wise, but it would be
> good to still return "any" or "first" match, but let user know there
> are multiple, so user can decide how to proceed...

Makes sense, but I'm thinking v3 doesn't need pagination or batching.
I didn't see any performance wins when profiling libbpf, and it can be
added later without breaking UAPI.

> on input I'd also add module name as optional input argument, with
> "vmlinux" limiting to just vmlinux, set module name to just that name,
> and NULL/zero meaning "we don't care"

Makes sense, so here is a possible plan for QUERY_BY_NAME:
- Optional module filter: NULL =3D any, "vmlinux", or a module name
- Returns the first match by default (vmlinux first, then modules). An
ALL_MATCHES flag searches everything and reports the number of matches

And an open question I'm unsure about: Should libbpf keep the light
skeleton semantics (take the first match, no ambiguity check), or set
ALL_MATCHES to keep today's check that fails on names with multiple
addresses?

> for QUERY_BY_ADDR we should have a flag saying whether an exact match
> by address is requested or we should find a symbol that covers the
> address (that's most useful for symbolization). maybe even "at or
> after" address mode, so you can paginate (though probably explicitly
> designed batch API would be even more useful later)

For v3 I think we can keep BY_ADDR to the covering lookup only. The
result can fill in the covering symbol's (start address, size, name,
module), and callers can check for an exact match themselves by
comparing the start address with the queried address. A batch API can
be added later when there is a user for it.

> tl;dr, this is the right direction, but I think we should polish API a
> bit more to be more universally useful and extensible
> > +
> > +#define KALLSYMS_QUERY_SIZE_VER0       40 /* sizeof first published st=
ruct */
> > +
> >  /*
> >   * Shutdown the filesystem.
> >   */
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index aec2f06858af..7caaf3e421c7 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/bsearch.h>
> >  #include <linux/btf_ids.h>
> > +#include <linux/uaccess.h>
> >
> >  #include "kallsyms_internal.h"
> >
> > @@ -922,11 +923,142 @@ const char *kdb_walk_kallsyms(loff_t *pos)
> >  }
> >  #endif /* CONFIG_KGDB_KDB */
> >
> > +struct kallsyms_mod_find_ctx {
> > +       const char *name;
> > +       unsigned long addr;
> > +       bool found;
> > +};
> > +
> > +static int kallsyms_mod_find_cb(void *data, const char *name, unsigned=
 long addr)
> > +{
> > +       struct kallsyms_mod_find_ctx *ctx =3D data;
> > +
> > +       if (strcmp(name, ctx->name) !=3D 0)
> > +               return 0;
> > +       if (ctx->found && ctx->addr !=3D addr)
> > +               return -EADDRNOTAVAIL;
> > +       ctx->found =3D true;
> > +       ctx->addr =3D addr;
> > +       return 0;
> > +}
> > +
> > +static int do_kallsyms_query(struct kallsym_iter *iter, void __user *u=
arg)
> > +{
> > +       char namebuf[KSYM_NAME_LEN];
> > +       struct kallsyms_query karg;
> > +       unsigned long addr;
> > +       unsigned int start;
> > +       unsigned int end;
> > +       unsigned int i;
> > +       __u64 usize;
> > +       long len;
> > +       int err;
> > +
> > +       BUILD_BUG_ON(sizeof(struct kallsyms_query) !=3D KALLSYMS_QUERY_=
SIZE_VER0);
> > +
> > +       /*
> > +        * The text interface shows zero addresses to openers without p=
ermission.
> > +        * A zeroed point query result is useless (and an address-to-sy=
mbol query
> > +        * would leak KASLR), so fail instead.
> > +        */
> > +       if (!iter->show_value)
> > +               return -EPERM;
> > +       if (copy_from_user(&usize, uarg, sizeof(usize)))
> > +               return -EFAULT;
> > +       if (usize > PAGE_SIZE)
> > +               return -E2BIG;
> > +       if (usize < KALLSYMS_QUERY_SIZE_VER0)
>
> PROCMAP_QUERY uses offsetofend() for the last defined field, any
> reason to have this #define and BUILD_BUG_ON here?

David pointed out that the size field in struct kallsyms_query is
redundant. In v3, I can drop the size field and use _IOC_SIZE(cmd),
keep the *_SIZE_VER0 define (since we need minimum size). Perfectly
fine to switch to the PROCMAP_QUERY style though if preferred.

Thanks Andrii for all the thoughtful feedback!

> > +               return -EINVAL;
> > +
> > +       err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, usize)=
;
> > +       if (err)
> > +               return err;
> > +
>
> [...]
