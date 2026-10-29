Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793311793;
	b=m5qZmSPW7N/vSfZRxGZPiclawsILGf4XNa24sOw1OtP4gwRxeCd0IwEJ0tIBX6GS7mLf
	 GedZDRrc0HrL1S+f9FiRC66eisOpKh73XVLKBdrID8IFHPh4WCn4FOikm/B0MYghQdr6j
	 BHCyxVSRBE6fTdIsY3zt5sJhXCOghW9yoK1spunA9ChoAC6RUIBBMGfGzbX4cVZkMO8+t
	 vTkisxbA27JpcGVNwcG4jROTOzc1onWEzPSljQlWOEjvsX78/mmurnfwA6B0dcm7qlp7b
	 p/KcoCQRj9TvYehK9ajq85mLwFAKSdal+5q6skEfkGBbQJwdPx6RQXMs998MzDsOCzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=klnniweN/7Eouuq66n4HntB9LJ2LsLXbCtNDgI1VObE=;
	b=zkYN4U/QkoTfOprbPxDLpSeDeMeahWArq5EWgT4Vl5tnX7D9BaovEydCPkmbiO8deR7s
	 D/EbNsjYwpU40c6v3aRUrlRbgGVb+mkFvAy7BV3gkxR+/ROvvc1hkjOR1n08U8Hm8X2Z1
	 O6e0Dgql1hl+0Z9FJ3NaAGsA485klR2dnCEq8ZyZfIXo18/BIncQh4bypMzHRQPtaGXvD
	 j99bQkf4VUpzlfn/5XLuf91hChIJKtRCi/i731Woelnq49EEj7+0pRFFyzeknSzcXZ2ye
	 /wzY47byd9+pRL2Q5Dpdcc93tRp/ko9Yx7V2F7Yiu47kVbpBUC3Py2NlXXjkDa7yAQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6AIF1J+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1686606A31F
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1686606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6AIF1J+
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c169ae1cb26so200220366b.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311791; cv=none;
        d=google.com; s=arc-20260327;
        b=my+9GjcWb3pMMiPmVPFOyoOw4k7i2MJ893IROajpSZ+4d8S25eZxLgSLRcacNKnsWx
         3ul4gryipWKGZCqM19ea9WNmM5C5oiI2RajrdAXoPX09DKtkBVBisFDNfsVh+FMqhkX9
         U9tcvjBT0taLwZpDcGpxNdPsOe7o1f1gChfF5N078lDGmlNLrQwwXHwhPGqKv83mLmn0
         DcGVmu35v4jbWQ1Sl7MVeLRkV5eoZbXvcsvzNu9JA+2VxPORKd+C6brpMf46HyEs4xDq
         6mOfib78WowVosLxZQajVqarUgYSYMkRHxieBraTSN/zSdhrAyfA4LMkm4eGkpke87tZ
         c+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=klnniweN/7Eouuq66n4HntB9LJ2LsLXbCtNDgI1VObE=;
        fh=fzn8hFxk73AOUQ9kMPk6VIhvTDhMt+N5phuN7WjuuJU=;
        b=S2a5UARR7FKORS1l8NWzMSGZDYBLXmvN7cL4iuTmv/Z/rF86Cmbovv9o74IoPOYpG7
         FlppXwElCM19A+JWkGeWaIbYKQLzb5h/9JrkXuzDqQzuDLjTD7bs+N9zAXWzlJ98WMhe
         /5hIKU4nN/oKa4ly287JTrXaupV6a0ZAToj3FZx5i802kC46wv453N1wZvFGS/yoQi44
         whwyVYLLtXOwa+NxQtt2svIm+ZvcHm+qmiDBHpiqShzYYLI3pp0c75ibx7Q7MBRsvmR0
         H3aCjTjgN43W5qIMD91IDU7h1+C+t7faplOIWb4vBmIVTFi5kPGdfQsz5urUyHt86diy
         NeCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311791; x=1793916591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=klnniweN/7Eouuq66n4HntB9LJ2LsLXbCtNDgI1VObE=;
        b=V6AIF1J++KNR0EzyqyJ4Gyh7upnDl4rjCh+QQ/3VvtjHmFoHz+WC4QHwELjrygwy7y
         Uq3K6spS2HJWxbQ1851Wo80oYqxyzhOPeqxX6LgHs4dwoA4qk9lA/3yaFQg1VGX6wfnS
         Y9LfsD+PU4k/iV+EcFLHHnxX+5HGBv/tQ/nDU2HHtXwDW5W1J/cQUtGTsgEqp674mZRL
         Xuktz5frprNU2crLomMf6elKxlz2iWESFunXS7oi0ou6yeqv1UMOvqyMPsT8sfdJjzq7
         /vDiqDtUekiTzaW3TvC+esBMX//qgykhxzKpPjhZR6xa8O+OA0m7jjj1H5YpgqWX0ial
         ncTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311791; x=1793916591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=klnniweN/7Eouuq66n4HntB9LJ2LsLXbCtNDgI1VObE=;
        b=u4Thjj2liMADXmJS81QHVt6bjd96bt61jzMndJrdhDJJ6lAlrX7ijC2cfDyumtepJu
         HPqvYV03Kvsq6v+n0ezStLlG4g6KM5kvVmV4Y3PRdP2O004wT8Lpbj7kD7TahV5qhm5S
         EQ4iI6/bMRiJt89ZevR7XgN4vVY9GjJyZMT6Gw+tuy9IhKP67b1o846WxMHcBqxXf3gn
         1AMYiiIiJI/po0bkuSlSyT/XwZbvWrdfz321UyF4Tp39qodTOA431JD4mDHySOXr5D6l
         4FsBZ+b7Ss6fMj6cGxnQ0YVqpsWRrclhuCpE4b5IpT0mvWxNk/5xXiW4iYVWytNypciR
         KO4g==
X-Forwarded-Encrypted: i=1; AKwUvBxZXuOvvXK2qdYdrYgDBEfYefUpSTFt7ewA6P89Z54lsoZyh1XoK9QrnZad0hMfeZgiQr8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZfOSRiZxDmqT5ovq4ePITY6huJXNFRB4WVyDkLltGjn/J1+rA
	UCjVn7CQRnhLlxux2rO9xf5JYwj7peGPTz/dHCfFZUglkTyIYN9XtF9wBHl4nhFDiIYqBBL8SyK
	933BssQ5jwpaIdbL/3o7/9L+MBg8dp+c=
X-Gm-Gg: AYBFou32mMOkDCOo28MQXuD9L9dlQPRfWzkCGeoRgV52V/cQkq/z+/aE1Mh8aIE6gSd
	2+JvVqwHTp+ye2Rsg6TsnrdUJpfQ1xu8oTeHpPHj/nJF7yieNI3Qg6FptIQO88dwOZaTl8V7j5a
	RSm7c5Nm3RZXzt1HaJJruP7kLfvd35ZE0nSrzZea2V2qHBSPEW2lkPUwa/WgBLSD/490RPFAA3b
	yrPI24SAYJ06rUzzxeSmZ2CQO6pyogNzIaYUURe6OX061Iym/exREeu6RRoDXL29Y0JmWfbTmhu
	aLIjk2bOgvaP0x4t66ECUpxYTu1+IgURPCpM2NNezq7DcWZnTPNuZmUScI3c0lmxzP0ESIK6/um
	NUW4pYjIG45CQ1GpKcQg5P6rnceb6eFlGtocELK2t88ci+JtlsJyT/SStyYN9BVHx0C1obtTfaW
	/qpjWp56fGghtiz16MwBV76AlJXgRIFm5v9Q==
X-Received: by 2002:a17:906:ee82:b0:c25:4d9e:bb28 with SMTP id
 a640c23a62f3a-c49d10fc56bmr388618366b.3.1793311790722; Thu, 29 Oct 2026
 15:09:50 -0700 (PDT)
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
 <CAEf4Bzb--Jzz696u057G9_CgQN7zf6ksvoL80KJacKO2CorsnQ@mail.gmail.com> <CAG2Kctojb7xiOqTmwWqoAKFaNUECjOzXVc_t6KbG13Pqm2dbng@mail.gmail.com>
In-Reply-To: <CAG2Kctojb7xiOqTmwWqoAKFaNUECjOzXVc_t6KbG13Pqm2dbng@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 15:09:32 -0700
X-Gm-Features: AclHuK8b_NQk66zPyLe0mnlgCDvf_BQIKT3sqXOmGivpH50Q3Vo8FHerkHLYA98
Message-ID: <CAEf4Bzbs8F1DPBz=WXVTExrrNjzvaFsi4L+HEj+zbUTpPSTX5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>
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

On Thu, Oct 29, 2026 at 2:58=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Tue, Oct 27, 2026 at 3:25=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Oct 22, 2026 at 5:17=E2=80=AFPM Samuel Wu <wusamuel@google.com>=
 wrote:
> > >
> > > Add an extensible KALLSYMS_QUERY ioctl() interface to /proc/kallsyms
> > > to support fast point queries without scanning the entire text file.
> > > Exactly one query mode must be set in query_flags.
> > >
> > > When KALLSYMS_QUERY_BY_SYMBOL is set in query_flags, KALLSYMS_QUERY
> > > resolves a NUL-terminated symbol name in vmlinux or loaded modules an=
d
> > > then populates sym_addr:
> > > - Searches vmlinux first via kallsyms_lookup_names() (binary search),
> > >   which takes precedence over loaded modules, and falls back to
> > >   module_kallsyms_on_each_symbol() under module_mutex for module
> > >   symbols
> > > - Matches names exactly, like kallsyms_lookup_name(), disregarding th=
e
> > >   .llvm.<hash> matching, following precedent set by commit fb6a421fb6=
15
> > >   ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
> > > - Resolves 0x0 symbol addresses in both vmlinux and modules
> > > - Rejects ambiguous symbols (multiple entries with the same name at
> > >   different addresses within vmlinux, or across loaded modules) with
> > >   -EADDRNOTAVAIL, while allowing same-address aliases
> > >
> > > Userspace symbolizers resolve kernel addresses to symbol names with
> > > /proc/kallsyms. This is typically done by reading the entire
> > > /proc/kallsyms text file, and keeping a compressed sorted copy of it =
in
> > > order to resolve addresses at runtime.
> > >
> > > When KALLSYMS_QUERY_BY_ADDR is set in query_flags, KALLSYMS_QUERY
> > > resolves one address to the symbol that contains it:
> > > - sym_addr holds the address to resolve on input.
> > > - sym_name_addr must point to a user buffer of sym_name_size bytes
> > >   that receives the NUL-terminated symbol name. On output,
> > >   sym_name_size holds the number of bytes written (including the
> > >   terminating NUL). -ENAMETOOLONG is returned if the buffer is too
> > >   small; a buffer of KSYM_NAME_LEN (512 at the time of writing) bytes
> > >   is always large enough.
> > > - Symbols are resolved via kallsyms_lookup(), the same lookup as %pS,
> > >   covering vmlinux, loaded modules, BPF JIT images, and freed module
> > >   init functions still tracked by ftrace.
> > >
> > > On an 8 CPU Cuttlefish (x86-64 VM), using this patchseries to load a =
BPF
> > > program with 11 typeless ksyms has ~220x speedup (157ms -> 0.7ms).
> > >
> > > On an 8 CPU x86-64 VM with a 175k line kallsyms, there are broad
> > > performance and memory savings for the symbolization and callstack
> > > sampling tool, Perfetto:
> > > - Init time: ~350x speedup (155.7ms -> 0.44ms)
> > > - 50k symbolizations: ~12x speedup (25.2ms -> 2.2ms)
> > > - VmRSS: -68% (15.1MB -> 4.8MB)
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > ---
> > >  include/uapi/linux/fs.h |  41 +++++++++++++
> > >  kernel/kallsyms.c       | 132 ++++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 173 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > index 34c6f219462a..b43f227dad0e 100644
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -674,6 +674,47 @@ struct procmap_query {
> > >         __u64 build_id_addr;            /* in */
> > >  };
> > >
> > > +/* /proc/kallsyms ioctl */
> > > +#define KALLSYMS_QUERY _IOWR(PROCFS_IOCTL_MAGIC, 18, struct kallsyms=
_query)
> > > +
> > > +/* Exactly one query mode must be set in query_flags. */
> > > +enum kallsyms_query_flags {
> > > +       /*
> > > +        * Look up a symbol in vmlinux or loaded modules (vmlinux fir=
st; BPF
> > > +        * and ftrace symbols are not searched) by exact NUL-terminat=
ed name
> > > +        * at sym_name_addr and return sym_addr. sym_addr and sym_nam=
e_size
> > > +        * must be 0 on input.
> > > +        */
> > > +       KALLSYMS_QUERY_BY_SYMBOL =3D 0x01,
> > > +       /*
> > > +        * Look up the symbol covering sym_addr and write its NUL-ter=
minated
> > > +        * name to the sym_name_addr buffer of sym_name_size bytes. T=
he same
> > > +        * symbols as %pS are searched: vmlinux, loaded modules, BPF =
JIT
> > > +        * images, and freed module init functions still tracked by f=
trace.
> > > +        * A buffer of KSYM_NAME_LEN (512 at the time of writing) byt=
es is
> > > +        * always enough. On success, sym_name_size is set to the num=
ber of
> > > +        * bytes written (including the terminating NUL).
> > > +        */
> > > +       KALLSYMS_QUERY_BY_ADDR =3D 0x02,
> > > +};
> > > +
> > > +/*
> > > + * Returns -ENOENT if no symbol matches, -EADDRNOTAVAIL if the name =
maps to
> > > + * more than one address, -ENAMETOOLONG if the name does not fit in
> > > + * KSYM_NAME_LEN (512 at the time of writing) or sym_name_size bytes=
, and
> > > + * -EPERM if kallsyms addresses are hidden from the opener of /proc/=
kallsyms
> > > + * (e.g. kptr_restrict).
> > > + */
> > > +struct kallsyms_query {
> > > +       __u64 size;             /* in - struct size for compatibility=
 */
> > > +       __u64 query_flags;      /* in - query mode (enum kallsyms_que=
ry_flags) */
> > > +       __u64 sym_name_addr;    /* in - address of symbol name buffer=
 */
> > > +       __u64 sym_addr;         /* out (BY_SYMBOL) / in (BY_ADDR) */
> > > +       __u64 sym_name_size;    /* in/out - name buffer size / bytes =
written */
> > > +};
> >
> > it might be smart to have QUERY_BY_ADDR and QUERY_BY_NAME to be two
> > separate ioctl commands with its own query in/out struct. This would
> > remove addr vs name ambiguity in sym_name_addr field, and will allow
> > us to evolve APIs independently, if necessary. They should still
> > probably reuse the same type to represent symbol information, and have
> > kallsyms_query struct provide a pointer to that struct (and its
> > maximum size), which the kernel will fill out and set the size it
> > actually knows about.
> >
> > struct kallsyms_query_by_addr {
> >     __u64 size;
> >     __u64 query_flags;
> >     __u64 sym_addr; /* in */
> >     struct kallsyms_sym *sym; /* out */
> >     __u64 sym_len;
> > };
> >
> > struct kallsyms_sym {
> >     __u64 sym_addr;
> >     __u64 sym_name;
> >     __u64 sym_name_len;
> >     __u64 sym_module;
> >     __u64 sym_module_len; /* if zero, no module requested/available */
> > };
> >
> > e.g. for symbol you'd want to return its name, address, but also
> > module name. and we should leave a way to extend it further with more
> > optional information (that's the kallsyms extensibility bit I was
> > talking about).
>
> Agree, two ioctls with a shared symbol type is cleaner. v3 plan is to
> have QUERY_BY_NAME and QUERY_BY_ADDR both fill a shared struct
> kallsyms_sym (address, size, name, module), passed by pointer so it
> can grow later.
>
> > aslo, we should think about adding ways to paginate (or at least leave
> > a possibility of that in the future) if there are multiple matches
> > (e.g., for static functions with the same name resolving to multiple
> > addresses); not sure how it should look like API wise, but it would be
> > good to still return "any" or "first" match, but let user know there
> > are multiple, so user can decide how to proceed...
>
> Makes sense, but I'm thinking v3 doesn't need pagination or batching.
> I didn't see any performance wins when profiling libbpf, and it can be
> added later without breaking UAPI.
>
> > on input I'd also add module name as optional input argument, with
> > "vmlinux" limiting to just vmlinux, set module name to just that name,
> > and NULL/zero meaning "we don't care"
>
> Makes sense, so here is a possible plan for QUERY_BY_NAME:
> - Optional module filter: NULL =3D any, "vmlinux", or a module name
> - Returns the first match by default (vmlinux first, then modules). An
> ALL_MATCHES flag searches everything and reports the number of matches

searches everything as in all modules, or you mean just full linear scan?

>
> And an open question I'm unsure about: Should libbpf keep the light
> skeleton semantics (take the first match, no ambiguity check), or set
> ALL_MATCHES to keep today's check that fails on names with multiple
> addresses?

I'd say fail on ambiguity

>
> > for QUERY_BY_ADDR we should have a flag saying whether an exact match
> > by address is requested or we should find a symbol that covers the
> > address (that's most useful for symbolization). maybe even "at or
> > after" address mode, so you can paginate (though probably explicitly
> > designed batch API would be even more useful later)
>
> For v3 I think we can keep BY_ADDR to the covering lookup only. The
> result can fill in the covering symbol's (start address, size, name,
> module), and callers can check for an exact match themselves by
> comparing the start address with the queried address. A batch API can
> be added later when there is a user for it.

There is a user for batch API, that's blazesym, wprof, retsnoop and
other applications that use kallsyms for symbolization. I didn't
insist on adding it from the get go just to reduce the scope, but
there is definitely a use case for having fast way to dump all or
parts of kallsyms

>
> > tl;dr, this is the right direction, but I think we should polish API a
> > bit more to be more universally useful and extensible
> > > +
> > > +#define KALLSYMS_QUERY_SIZE_VER0       40 /* sizeof first published =
struct */
> > > +

[...]

> >
> > PROCMAP_QUERY uses offsetofend() for the last defined field, any
> > reason to have this #define and BUILD_BUG_ON here?
>
> David pointed out that the size field in struct kallsyms_query is
> redundant. In v3, I can drop the size field and use _IOC_SIZE(cmd),
> keep the *_SIZE_VER0 define (since we need minimum size). Perfectly
> fine to switch to the PROCMAP_QUERY style though if preferred.

I'm not sure how size is redundant, I don't see ioctl subsystem
accepting argument size as a separate parameter, so the size has to
come from the user and be embedded in user-provided structure, if we
want any sort of backward/forward compatibility. At least looking at
PROCMAP_QUERY I don't see how we could have avoided it, so not sure
how we can do that here.

>
> Thanks Andrii for all the thoughtful feedback!
>
> > > +               return -EINVAL;
> > > +
> > > +       err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, usiz=
e);
> > > +       if (err)
> > > +               return err;
> > > +
> >
> > [...]
