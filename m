Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793314456;
	b=sqXgjOO3pzbAt3cayFgyFyhgMqgyShRkZel0jLa/5CzPLgDHI241jfIHZsKHqgrh8Opk
	 VSpxS76mLsAydJMj3Heeta5EADhD+NHDYruXgIFAAVdmHtFivnRn3EbL5p+Y+awwtKQKB
	 6FvA6ncX2mbgJt2T5GO9qrsthgMt2PF6SMAi6RcXpgGKqWaOfMnOK6DsznG5fO6ZAfeQN
	 Tl225nJUvGZ/oD9oWEoa1R8JPnhs+E8zXQ8t2l+IMXmpBZD1vsyZ4KnopjKUKG/K3+UQZ
	 gwa8+8OEfIQvHlav7WI4J8MtgPPRArQ5fC/OmwQAvELXANLemsgPhKVNjTRt6Bi1ohA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/eFON9pol21Ti2zzs+WKnNaualr+TmOeQ6S7vyh/BJo=;
	b=s4UHKgtAZvaC0B4vNpRE5jAnbhKQiPGhWsvhM9dDahFM4IRivJkDiJg5y+dVHzpDufUD
	 rYLucrMimfwgZlXRUG2YMOPBS7D7FsPG0OIWW3myqgarOpy+451w9yI6mnJnrlPQs2h9i
	 vjk6y3tmlRDJrEC+dyf/hCOj5SpLq6lObULlR0yzh0s7123viE9DT90iyBDhEZwMAsils
	 gYAtVul23bPwyG/VlXZJtHJkPgvOv523bk9OTnYOtNtfxOPxVIi02xHgolTCylcTfO4DL
	 YtdXXW3mqANKh/aZlAvZpTia0vq562p8aBlij7tAbssH+BTzk9+vGZSLnQX6PN+Cx5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MOXJTf0q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D092606A325
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D092606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MOXJTf0q
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso26101a12.3
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793314454; cv=none;
        d=google.com; s=arc-20260327;
        b=sbyhMxS5VxLXIEGQBWoTJxH5iGF7AJePDNT/et92DvR0cPikZH3yPuxBafgGOMdIGG
         4HGmnHh1WQCfTVY/4QlVR04WG/3ugMVPGAsybtIiflBNsEdM9sM8ro2KTavSOJXjT4mY
         q1g2E14xCE9QQK5+1RA+Lxp0947z+lYyFPIdFvApusrPkDmPGEWzqwj7aIp1efRfUVD0
         QVjdIq1r1mdqMVQxLp8LPAiZAnsXG6NxeG42AOnxoJV+CuktuyorAaUsq1srJqgKbOBf
         MYkAJu0u/t6CDXlo0OB+pv4aBNDR0xL1XvQeXYexDUu1fS6I3LGG1KAqmbAmqyfd0XTs
         ndcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/eFON9pol21Ti2zzs+WKnNaualr+TmOeQ6S7vyh/BJo=;
        fh=yqfgOsx349peu3fR6zv3pbJJBTCcRRSYDCqSPaTyLIE=;
        b=sKrM5PwZajpSDufXbsuclsSsWJjHzoQofq7cPLbrlO0WW9dee7BfPGbiv8/5Y+xxZJ
         ojSo6F4tTKt+6lCpOjW59vksbQ4iNru2soui1qnl7GpxD+drSoWKgucBvzJX4Vp0XM02
         eovkjC9J8y4itxcaUjHMrpVIgltlRkbZEkWk/pP7Ib89yypSC3DqJekCEHCtOS8YruQy
         9oo6AlZxPr5O95tJKoj0n7w+Xj/GrbmYUfwp6sTl5H8WPrh3i3ra638gD56LzZzeIoXF
         Kk06yD4m27I1I7wePVJGgtEP6T+HcrcQYBx5wt+6UZYojZRnIyG/TC5vbacOk0vD7B48
         3BOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793314454; x=1793919254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eFON9pol21Ti2zzs+WKnNaualr+TmOeQ6S7vyh/BJo=;
        b=MOXJTf0qJfNPDcP50j0kgh/cpzGgsLjJyjI6SjwjO1EhR0tLIdMXnqj7DS9ELY50TC
         dueFJdIHlYIv1n1xhELj6jOlct3TXa4LGt5jeNZXAo+IMmZ1P12qOzAdE81o4vUzSu4q
         BVsSF9NSEFh9U302Ws1N7rDLWfi8qMp0c4UUrGw+OLP2kIlBnlqUfFd3uYZgo02Rg5q8
         A1qA/ySncmKDSLw0LcG4ZSsHXhlJo1n8wzEinGm77QQUr/avR1s5XxxBWv3DrmWv7QR4
         ntk/SdXmtElTN2MLIGaUkompvjq/uVvFt5ppskkj4aCns7UWvvOq6qoGZlk5ieJVIasR
         YZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793314454; x=1793919254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eFON9pol21Ti2zzs+WKnNaualr+TmOeQ6S7vyh/BJo=;
        b=2iADnTzb4EtiFKGLeVr1g6Dp4vg/gpvC5hlvj00clFY4nwOfJRs2ZZzlc8qGoJJkJC
         Gkiu1O8OehIDgooLii7a33X7dWxwrWi360XS3+5d031SzjsbIbYhIDFLiwilq6T96BF4
         O26Frs4q+pCggNtuu/BYR+0LgO0fpcQY2/t0P8HEetN7c11TaEATkQv7st8UARhpBglh
         T1zaaijjO3sSMB88IKfo91bWCq1XnLWDd+ovMKepmXKkPqhsNpX82wn96bo63J49DLnr
         7yvaHpdwEPwvNpl2OhV76O1zQS35VGo9F4RwY72jVGNTUCXNnnZaCe8VX23C50UwwY7g
         bzGQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9lirCk0iqLiW0MEbUUPIkFnhEejPzXfxIbc+AGV/mhZrGtp8MbkGURbGXsEDgchUx0PA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/3u9gGGX8iveKZ6uHk6w66KihQUdY5UPJ1FSkS4z5ULktMZ2s
	Sct5BsXnzwN3Tf8crUJ7PU9GpQsBiQCIsW5+feLuv+iwYOOdCmuBUOO1Cm9kW8ZCVyYVSa6iP/m
	Z6w2KuYkod2h2LJ1m4Lb3KbSOW+BhtVc=
X-Gm-Gg: AYBFou0ErsLAqsDLDqwxAVz/yPJFzrI7DnHeR87fo8BaVyQ0GrD+bvuuNM0YlMnl5eD
	aRsI712pEX/hb6SaMHnpuKsvZ6siG0tIOmGz+bq5p1NHewEA3HeH/iyZA9brOQ6LUXajuIbuEHt
	9pvyV3PtcBUOaP2Pncjd98u0H0TfJfUR9xmgreIJAdzy/m3osnrCd0u821IZAtNp8dq3YY0R+KB
	HAzO2EE+rfZPI1cRCtfEwA2XtJcGPIkx92ME73NMqqUkRjSJJOhkW2bq3vXcDQjZYS0t+WLT9EQ
	XfMSkOhG9z3YtuJuwzLs9iA2TA0iLCNAuZr3+i+eHUMNc+2PFmycPshdi+FfUfEzfGvSMr1RbYw
	S0Isz+dTAmhYhjGiGYUNkDGri79oS0B2Vy4UZXsiquBzLOtiykhK8iwVG/i0a6xG3eFgxVBVlY2
	j2deErcntobe8DMdPPCLWsQ6hMP3zegaHXpA==
X-Received: by 2002:a17:90b:2e4f:b0:3ac:9a5e:9ce9 with SMTP id
 98e67ed59e1d1-3ae897f3440mr311230a91.29.1793314454260; Thu, 29 Oct 2026
 15:54:14 -0700 (PDT)
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
 <CAG2Kctojb7xiOqTmwWqoAKFaNUECjOzXVc_t6KbG13Pqm2dbng@mail.gmail.com>
 <CAEf4Bzbs8F1DPBz=WXVTExrrNjzvaFsi4L+HEj+zbUTpPSTX5g@mail.gmail.com> <CAG2KctpSTCyWQHgJ8GyFEhHPdFawUa6zy0g7rkfCcujJRN6f6w@mail.gmail.com>
In-Reply-To: <CAG2KctpSTCyWQHgJ8GyFEhHPdFawUa6zy0g7rkfCcujJRN6f6w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 15:54:01 -0700
X-Gm-Features: AclHuK-mI6sS2Ewkug3EKJ5kYTNw9pcZR8L4BHb6wPRIgDwn5oOsXoEZc6Lpnwo
Message-ID: <CAEf4BzbyqPC=RQGWEdpkqu1WDQ2_S0H8pZU2i=_gLuSDQtpFbg@mail.gmail.com>
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

On Thu, Oct 29, 2026 at 3:36=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Thu, Oct 29, 2026 at 3:09=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Oct 29, 2026 at 2:58=E2=80=AFPM Samuel Wu <wusamuel@google.com>=
 wrote:
> > >
> > > On Tue, Oct 27, 2026 at 3:25=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Oct 22, 2026 at 5:17=E2=80=AFPM Samuel Wu <wusamuel@google.=
com> wrote:
> > > > >
> > > > > Add an extensible KALLSYMS_QUERY ioctl() interface to /proc/kalls=
yms
> > > > > to support fast point queries without scanning the entire text fi=
le.
> > > > > Exactly one query mode must be set in query_flags.
> > > > >
> > > > > When KALLSYMS_QUERY_BY_SYMBOL is set in query_flags, KALLSYMS_QUE=
RY
> > > > > resolves a NUL-terminated symbol name in vmlinux or loaded module=
s and
> > > > > then populates sym_addr:
> > > > > - Searches vmlinux first via kallsyms_lookup_names() (binary sear=
ch),
> > > > >   which takes precedence over loaded modules, and falls back to
> > > > >   module_kallsyms_on_each_symbol() under module_mutex for module
> > > > >   symbols
> > > > > - Matches names exactly, like kallsyms_lookup_name(), disregardin=
g the
> > > > >   .llvm.<hash> matching, following precedent set by commit fb6a42=
1fb615
> > > > >   ("kallsyms: Match symbols exactly with CONFIG_LTO_CLANG")
> > > > > - Resolves 0x0 symbol addresses in both vmlinux and modules
> > > > > - Rejects ambiguous symbols (multiple entries with the same name =
at
> > > > >   different addresses within vmlinux, or across loaded modules) w=
ith
> > > > >   -EADDRNOTAVAIL, while allowing same-address aliases
> > > > >
> > > > > Userspace symbolizers resolve kernel addresses to symbol names wi=
th
> > > > > /proc/kallsyms. This is typically done by reading the entire
> > > > > /proc/kallsyms text file, and keeping a compressed sorted copy of=
 it in
> > > > > order to resolve addresses at runtime.
> > > > >
> > > > > When KALLSYMS_QUERY_BY_ADDR is set in query_flags, KALLSYMS_QUERY
> > > > > resolves one address to the symbol that contains it:
> > > > > - sym_addr holds the address to resolve on input.
> > > > > - sym_name_addr must point to a user buffer of sym_name_size byte=
s
> > > > >   that receives the NUL-terminated symbol name. On output,
> > > > >   sym_name_size holds the number of bytes written (including the
> > > > >   terminating NUL). -ENAMETOOLONG is returned if the buffer is to=
o
> > > > >   small; a buffer of KSYM_NAME_LEN (512 at the time of writing) b=
ytes
> > > > >   is always large enough.
> > > > > - Symbols are resolved via kallsyms_lookup(), the same lookup as =
%pS,
> > > > >   covering vmlinux, loaded modules, BPF JIT images, and freed mod=
ule
> > > > >   init functions still tracked by ftrace.
> > > > >
> > > > > On an 8 CPU Cuttlefish (x86-64 VM), using this patchseries to loa=
d a BPF
> > > > > program with 11 typeless ksyms has ~220x speedup (157ms -> 0.7ms)=
.
> > > > >
> > > > > On an 8 CPU x86-64 VM with a 175k line kallsyms, there are broad
> > > > > performance and memory savings for the symbolization and callstac=
k
> > > > > sampling tool, Perfetto:
> > > > > - Init time: ~350x speedup (155.7ms -> 0.44ms)
> > > > > - 50k symbolizations: ~12x speedup (25.2ms -> 2.2ms)
> > > > > - VmRSS: -68% (15.1MB -> 4.8MB)
> > > > >
> > > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > > > ---
> > > > >  include/uapi/linux/fs.h |  41 +++++++++++++
> > > > >  kernel/kallsyms.c       | 132 ++++++++++++++++++++++++++++++++++=
++++++
> > > > >  2 files changed, 173 insertions(+)
> > > > >
> > > > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > > > index 34c6f219462a..b43f227dad0e 100644
> > > > > --- a/include/uapi/linux/fs.h
> > > > > +++ b/include/uapi/linux/fs.h
> > > > > @@ -674,6 +674,47 @@ struct procmap_query {
> > > > >         __u64 build_id_addr;            /* in */
> > > > >  };
> > > > >
> > > > > +/* /proc/kallsyms ioctl */
> > > > > +#define KALLSYMS_QUERY _IOWR(PROCFS_IOCTL_MAGIC, 18, struct kall=
syms_query)
> > > > > +
> > > > > +/* Exactly one query mode must be set in query_flags. */
> > > > > +enum kallsyms_query_flags {
> > > > > +       /*
> > > > > +        * Look up a symbol in vmlinux or loaded modules (vmlinux=
 first; BPF
> > > > > +        * and ftrace symbols are not searched) by exact NUL-term=
inated name
> > > > > +        * at sym_name_addr and return sym_addr. sym_addr and sym=
_name_size
> > > > > +        * must be 0 on input.
> > > > > +        */
> > > > > +       KALLSYMS_QUERY_BY_SYMBOL =3D 0x01,
> > > > > +       /*
> > > > > +        * Look up the symbol covering sym_addr and write its NUL=
-terminated
> > > > > +        * name to the sym_name_addr buffer of sym_name_size byte=
s. The same
> > > > > +        * symbols as %pS are searched: vmlinux, loaded modules, =
BPF JIT
> > > > > +        * images, and freed module init functions still tracked =
by ftrace.
> > > > > +        * A buffer of KSYM_NAME_LEN (512 at the time of writing)=
 bytes is
> > > > > +        * always enough. On success, sym_name_size is set to the=
 number of
> > > > > +        * bytes written (including the terminating NUL).
> > > > > +        */
> > > > > +       KALLSYMS_QUERY_BY_ADDR =3D 0x02,
> > > > > +};
> > > > > +
> > > > > +/*
> > > > > + * Returns -ENOENT if no symbol matches, -EADDRNOTAVAIL if the n=
ame maps to
> > > > > + * more than one address, -ENAMETOOLONG if the name does not fit=
 in
> > > > > + * KSYM_NAME_LEN (512 at the time of writing) or sym_name_size b=
ytes, and
> > > > > + * -EPERM if kallsyms addresses are hidden from the opener of /p=
roc/kallsyms
> > > > > + * (e.g. kptr_restrict).
> > > > > + */
> > > > > +struct kallsyms_query {
> > > > > +       __u64 size;             /* in - struct size for compatibi=
lity */
> > > > > +       __u64 query_flags;      /* in - query mode (enum kallsyms=
_query_flags) */
> > > > > +       __u64 sym_name_addr;    /* in - address of symbol name bu=
ffer */
> > > > > +       __u64 sym_addr;         /* out (BY_SYMBOL) / in (BY_ADDR)=
 */
> > > > > +       __u64 sym_name_size;    /* in/out - name buffer size / by=
tes written */
> > > > > +};
> > > >
> > > > it might be smart to have QUERY_BY_ADDR and QUERY_BY_NAME to be two
> > > > separate ioctl commands with its own query in/out struct. This woul=
d
> > > > remove addr vs name ambiguity in sym_name_addr field, and will allo=
w
> > > > us to evolve APIs independently, if necessary. They should still
> > > > probably reuse the same type to represent symbol information, and h=
ave
> > > > kallsyms_query struct provide a pointer to that struct (and its
> > > > maximum size), which the kernel will fill out and set the size it
> > > > actually knows about.
> > > >
> > > > struct kallsyms_query_by_addr {
> > > >     __u64 size;
> > > >     __u64 query_flags;
> > > >     __u64 sym_addr; /* in */
> > > >     struct kallsyms_sym *sym; /* out */
> > > >     __u64 sym_len;
> > > > };
> > > >
> > > > struct kallsyms_sym {
> > > >     __u64 sym_addr;
> > > >     __u64 sym_name;
> > > >     __u64 sym_name_len;
> > > >     __u64 sym_module;
> > > >     __u64 sym_module_len; /* if zero, no module requested/available=
 */
> > > > };
> > > >
> > > > e.g. for symbol you'd want to return its name, address, but also
> > > > module name. and we should leave a way to extend it further with mo=
re
> > > > optional information (that's the kallsyms extensibility bit I was
> > > > talking about).
> > >
> > > Agree, two ioctls with a shared symbol type is cleaner. v3 plan is to
> > > have QUERY_BY_NAME and QUERY_BY_ADDR both fill a shared struct
> > > kallsyms_sym (address, size, name, module), passed by pointer so it
> > > can grow later.
> > >
> > > > aslo, we should think about adding ways to paginate (or at least le=
ave
> > > > a possibility of that in the future) if there are multiple matches
> > > > (e.g., for static functions with the same name resolving to multipl=
e
> > > > addresses); not sure how it should look like API wise, but it would=
 be
> > > > good to still return "any" or "first" match, but let user know ther=
e
> > > > are multiple, so user can decide how to proceed...
> > >
> > > Makes sense, but I'm thinking v3 doesn't need pagination or batching.
> > > I didn't see any performance wins when profiling libbpf, and it can b=
e
> > > added later without breaking UAPI.
> > >
> > > > on input I'd also add module name as optional input argument, with
> > > > "vmlinux" limiting to just vmlinux, set module name to just that na=
me,
> > > > and NULL/zero meaning "we don't care"
> > >
> > > Makes sense, so here is a possible plan for QUERY_BY_NAME:
> > > - Optional module filter: NULL =3D any, "vmlinux", or a module name
> > > - Returns the first match by default (vmlinux first, then modules). A=
n
> > > ALL_MATCHES flag searches everything and reports the number of matche=
s
> >
> > searches everything as in all modules, or you mean just full linear sca=
n?
>
> I envision ALL_MATCHES to do some form of lower_bound() +
> upper_bound() on vmlinux since it's sorted, and then linear scan of
> all modules. Of course, just one of the two or both aforementioned
> things depending on the module filter (any, vmlinux, module).

no point in upper_bound() if it's sorted, you just start at
lower_bound and go linearly from there. I don't think it's realistic
to assume large number of duplicates, so I wouldn't optize for that,
one log(N) lower bound + linear scan will be faster in most cases,
probably

>
> > >
> > > And an open question I'm unsure about: Should libbpf keep the light
> > > skeleton semantics (take the first match, no ambiguity check), or set
> > > ALL_MATCHES to keep today's check that fails on names with multiple
> > > addresses?
> >
> > I'd say fail on ambiguity
>
> Ack
>
> > >
> > > > for QUERY_BY_ADDR we should have a flag saying whether an exact mat=
ch
> > > > by address is requested or we should find a symbol that covers the
> > > > address (that's most useful for symbolization). maybe even "at or
> > > > after" address mode, so you can paginate (though probably explicitl=
y
> > > > designed batch API would be even more useful later)
> > >
> > > For v3 I think we can keep BY_ADDR to the covering lookup only. The
> > > result can fill in the covering symbol's (start address, size, name,
> > > module), and callers can check for an exact match themselves by
> > > comparing the start address with the queried address. A batch API can
> > > be added later when there is a user for it.
> >
> > There is a user for batch API, that's blazesym, wprof, retsnoop and
> > other applications that use kallsyms for symbolization. I didn't
> > insist on adding it from the get go just to reduce the scope, but
> > there is definitely a use case for having fast way to dump all or
> > parts of kallsyms
>
> Ahh, ok, hopefully reducing the scope for v3 is fine.
>
> > >
> > > > tl;dr, this is the right direction, but I think we should polish AP=
I a
> > > > bit more to be more universally useful and extensible
> > > > > +
> > > > > +#define KALLSYMS_QUERY_SIZE_VER0       40 /* sizeof first publis=
hed struct */
> > > > > +
> >
> > [...]
> >
> > > >
> > > > PROCMAP_QUERY uses offsetofend() for the last defined field, any
> > > > reason to have this #define and BUILD_BUG_ON here?
> > >
> > > David pointed out that the size field in struct kallsyms_query is
> > > redundant. In v3, I can drop the size field and use _IOC_SIZE(cmd),
> > > keep the *_SIZE_VER0 define (since we need minimum size). Perfectly
> > > fine to switch to the PROCMAP_QUERY style though if preferred.
> >
> > I'm not sure how size is redundant, I don't see ioctl subsystem
> > accepting argument size as a separate parameter, so the size has to
> > come from the user and be embedded in user-provided structure, if we
> > want any sort of backward/forward compatibility. At least looking at
> > PROCMAP_QUERY I don't see how we could have avoided it, so not sure
> > how we can do that here.
>
> My understanding is that the size is encoded in the ioctl command
> itself: _IOWR() puts sizeof(struct) into the command number when
> userspace is compiled, so _IOC_SIZE(cmd) is the struct size of the
> header the caller was built against.
>

oh, interesting, I didn't realize we embed struct size into ioctl cmd
and match it exactly. I see that pm_scan_arg has the same __u64 size
in the struct approach, I'd stick to that, and when we extend any of
them we'd need to make sure to either ignore or hard-code the size
part, hm..

> That said, either way is fine. We could mirror PROCMAP_QUERY style for
> consistency.
>
> > >
> > > Thanks Andrii for all the thoughtful feedback!
> > >
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, =
usize);
> > > > > +       if (err)
> > > > > +               return err;
> > > > > +
> > > >
> > > > [...]
