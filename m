Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793311560;
	b=eEh8Lu7a553chouqCGmjTp+5aZanyYmUETOt9pmUKNEKW6U2TosHm79faJzmFn2jboww
	 Z4LltkJWccOwx1C9A40a0f18+0UdVf69lL4bFepNiQvY+1e5pJa7VS3ACCLmuA8gh+Z9J
	 taq9ACTenkviCZeb0U5zJL561G7Wo8eKjIHQBFo2RqVoprPxIng48pZTOQ4zlXopUklRZ
	 IykZx3edWnZQJamw+NN1HNFZ5bki5lEGEuECTYKsHU3lxg1pa+7DGFHOerbOizq7gzq7O
	 yyl42YWbwjxnVdiNz1KMPf2k6x+ywmknpkWf8vELLfcBegehNyo6RV6gTBfR2YvFWtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UlijXIsaLnzVSRv+wqBpun4qqIgtgBsO16KVodOFrHI=;
	b=knmzf2MP82dloYOfnIub8dnfyBVSZJvUZ0XLZ2qPBss2YtLqdJUmK1Wn09cJhwHRUfal
	 qpTmEckpTYiWPHsHijdTz3PwlMsMa56aovw148ma/eIuZDuPKhiAchk0quItEdpilAlm/
	 w5bwXQRPy8NH8fTh7aVrj3msO4qDLdOlTi5oumKDQRv1zv54JK52GVd+bRcN1oHrNB3cn
	 CzyfLRYyEskbBrsOwVz0RSUWfBAa4O7mrg2By0F8wLJ9vPYLTvDKt3y7OqUWzKIWczP7G
	 bSRTw4iJQ2wHDet2czOmbPoW4uiAnajqyyy8Yw8cNe2jNj3gp0H7nV7dHTpVLorjiTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fL7w7gjD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788C606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8788C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fL7w7gjD
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4c9abc1824so2610266b.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311558; cv=none;
        d=google.com; s=arc-20260327;
        b=AtH0zdL1oFEqP5ugSYm0Q3xReXG2JveqayDww+/YvS2O8FuVnxr8p0x/1uQpnNn0nO
         EvaAOF3zgABTzgyh0wf7BDu5Pzdo1QsSt2ADfVbMRCbyiy1b+AHVrZpf3PhvADabssdY
         H/+Bbu7Nh3STJBH+I2VtzT9ntGD1GLBexA+llFt8b0hflf/6syfuc9gkjMG9rwCDBbzn
         +WvHL0OoaMdpXuh8vy1SxqZTf2qhAXXkG+xvN3kWS+YTuq0bttZHE+0P4KhkaewvQkHE
         d2vmJwaiKPTfTl/tLsP+LYkJqTFvE4tuS668r/GHgKgmY296WLKmwhjRTame1en5Rd0Y
         Ho+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UlijXIsaLnzVSRv+wqBpun4qqIgtgBsO16KVodOFrHI=;
        fh=AjBYTJyyxAPIJ3Q+tFz/w27W8dUiACNhqonamR0oTNI=;
        b=oI+eThQDzkFaoKcdLiJqnbbL3MPLM2PrCSZxqTpWDbnymDjierFwwUT1ghMG4nH6vd
         0/RNE61qBkEBFlmEFdtMUgCufyeXLGS0hbNFtlDOp/s0MEXDQPmE8sgVynNNYVyIu6Is
         sjdRLfuldPhEsfUNE7TgWDv/tqXNiPor3EfVobOJCGFIj0DA11V/GpTOFbK8lLnfRNYr
         dsXGeHQ5ErNNSvDlj2O7Fg4h4BOS6VuoSgWIW4uNt3qF0IWw5y80ICY840MgVR2EbhHl
         G/ieFv5zKI8Q2/MHU1ICiEk/WDAIhFW93wPk5MNd8vttNO2k0bLOlmZATPjsgiAxQJI8
         gOnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793311558; x=1793916358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UlijXIsaLnzVSRv+wqBpun4qqIgtgBsO16KVodOFrHI=;
        b=fL7w7gjDItqvVVe2VFg8FFnMfy0lpC41wTT3Au578nAg1JhtYQz+gsLJm7HZ8gRNzJ
         m6rN9RmtnGK2Toc7nL3S0Hq2N6qi5Uox08LOn0a+YuL9yfU2pcjFNu0pyLC0cnEF8S71
         VuX+WVSc4MCqAlFh6lQhb3S6XqJrv6xgZ+b6ouRkVUKe3HU9w1O66jKBxAzNq4cR/cNH
         j6wW8ZdJRF/z1IH4zGLQezxpe97ZMNwwriWDHnhuDrYTQ76KDBHywQRFVcEuI9sFGsao
         P4uXDNunD8/6tZE+rTznQEVeTkiqDy8QMhOsk5jBZXTo9FiswUZFzmESc5erCWS/ZEs2
         G4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311558; x=1793916358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UlijXIsaLnzVSRv+wqBpun4qqIgtgBsO16KVodOFrHI=;
        b=vtbVcZr7LnrWpPV2crU28kl2HiGaxQDaAn9tr3GNoPwUyz1XWgtMnPZZjnms5gTWIW
         Cy3DTKBUrgFB903BpABR8Q8YvSulkYKcqTCP3F5c4zJOomdyoyKyC+/+MkkIPUYbXX83
         4ZW9wUb2tr1SnbMtTG0HXacy1jWC2hhKj2+U2uxGmrGYvIIbwlXpZvdd5jGtMdbAqt1y
         AbRZ3JUR7mxKpdVvyZHDWvhJUxMHtfpYHpJ1pDeJTchI1MqXkpX0C2wAMVJHNHVnEa+r
         uggW907c8E/R61+t0sXUOKN2a2PG/PdHkC7puJQfhMwSRy8OQogKkvLTDlQdEU+5avct
         Wu+A==
X-Forwarded-Encrypted: i=1; AKwUvBzjK599dkJFUl27nZrYAnlZtdvG7I3RJ5Fryddhl1RF+fH4IXelEBMwWaaMcpyttba1wgs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLHP4RME0ixgelkzQHMWjzkWv/UF4jSa+x5RakTSM76Erx5H8U
	cb1fOL4oaN0rFk82CPCqVBlbIdFk097ijR0xZzv0EH/47Ro7c3pG6ZKQay0VeIh7lLMLk4Ds0lx
	yo3ONMcC5K6TUwPXPFoLNgtA+2o1DdJTHYD8sGuMq
X-Gm-Gg: AYBFou1apBpWK+TFu0+ujFIsrgNR9cBya0wXQj84PaWbWyr1d8cxoYMV8MlpdUsdHUj
	tnfoeUT58MqdO+ZaO2iAt9oksQDWxufLYCoK5gM727TQXUJtleF/tpzWOvyLMy7j77PGuCAxJzV
	SuYglop8I75KeCAr5CrV0j6envFt8DRfLXtKHaipUQBvosiIUayArdBWhxVLHoXVA6MWaT6ZrUH
	TIuQvCcvnBmmaFclfpVKPgONpL6fDL3AgetgxlTSVf+efpEU2E9yNonJgrYdG+zQf2UQbkdj70v
	9TTY0HwM9BIVsvIFhQuMIS4qbNYbggnZsBZNCnzCZCWe/UT8llniSjnh0GZV3x0D9P0owOQlWr8
	xaKRZidXomOrnJFq4e8IkwGmLRqRYkkw752xip4ncUS6gNZVRdxszziwMmWrIwEhDkVeBpkA=
X-Received: by 2002:a17:906:c109:b0:c41:4d5:e97c with SMTP id
 a640c23a62f3a-c4ca7acc1a4mr30459466b.37.1793311557309; Thu, 29 Oct 2026
 15:05:57 -0700 (PDT)
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
 <20261028134012.01d52e94@pumpkin>
In-Reply-To: <20261028134012.01d52e94@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 29 Oct 2026 15:05:45 -0700
X-Gm-Features: AclHuK_v8Vj7L5641e5i4_2efV_6IgHiEGhUNhO-jYSIuhwMtVgyx4Cfre_1Omw
Message-ID: <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: David Laight <david.laight.linux@gmail.com>
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

On Wed, Oct 28, 2026 at 6:40=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 22 Oct 2026 17:16:02 -0700
> Samuel Wu <wusamuel@google.com> wrote:
>
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
>
> Hmmmm....
> What happens when you have functions foo and foo.constprop0
> In some sense they are duplicates.

BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
would be different symbols at different addresses. Please correct me
if I'm missing something here!

> > - Resolves 0x0 symbol addresses in both vmlinux and modules
> > - Rejects ambiguous symbols (multiple entries with the same name at
> >   different addresses within vmlinux, or across loaded modules) with
> >   -EADDRNOTAVAIL, while allowing same-address aliases
> >
> > Userspace symbolizers resolve kernel addresses to symbol names with
> > /proc/kallsyms. This is typically done by reading the entire
> > /proc/kallsyms text file, and keeping a compressed sorted copy of it in
> > order to resolve addresses at runtime.
>
> You could mmap the tables into userspace and have a ioctl that reported
> the offsets of the tables (etc).
> Then user lookup would faster then kernel lookup!
> Especially since you could throw a bit more memory at it to remove the
> linear scans.

I think that would increase the UAPI surface because it would set the
table format, so I'd prefer not to. It would only cover vmlinux and
not modules, and then we'd need to apply kptr_restrict checks to the
mapping.

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
>
> Have you tried measuring it with my patches that speed up the kernel
> 'search by name' code?
> That speeds the lookup by a factor of ~18 (testing the code in userspace)=
.

Not yet. Can you point me to the latest version? Happy to try it out.

> You also should allow for 'find first' and 'find next'.
> As well as letting the code iterate though functions with the same name
> it is absolutely trivial to enhance the 'lookup by name' code to match
> a prefix.

Agreed, that would be useful. In v3, the idea will be to have BY_NAME
return the first match by default, and an ALL_MATCHES flag to report
how many matches exist. Find next and prefix matching can be added
later with breaking UAPI, and best to not include in v3 since there
isn't yet a user.

> (Basically it needs to 'return -index' instead of 'return -1' when the
> binary scan fails.)
>
>
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
> >       __u64 build_id_addr;            /* in */
> >  };
> >
> > +/* /proc/kallsyms ioctl */
> > +#define KALLSYMS_QUERY       _IOWR(PROCFS_IOCTL_MAGIC, 18, struct kall=
syms_query)
> > +
> > +/* Exactly one query mode must be set in query_flags. */
> > +enum kallsyms_query_flags {
> > +     /*
> > +      * Look up a symbol in vmlinux or loaded modules (vmlinux first; =
BPF
> > +      * and ftrace symbols are not searched) by exact NUL-terminated n=
ame
> > +      * at sym_name_addr and return sym_addr. sym_addr and sym_name_si=
ze
> > +      * must be 0 on input.
> > +      */
> > +     KALLSYMS_QUERY_BY_SYMBOL =3D 0x01,
> > +     /*
> > +      * Look up the symbol covering sym_addr and write its NUL-termina=
ted
> > +      * name to the sym_name_addr buffer of sym_name_size bytes. The s=
ame
> > +      * symbols as %pS are searched: vmlinux, loaded modules, BPF JIT
> > +      * images, and freed module init functions still tracked by ftrac=
e.
> > +      * A buffer of KSYM_NAME_LEN (512 at the time of writing) bytes i=
s
> > +      * always enough. On success, sym_name_size is set to the number =
of
> > +      * bytes written (including the terminating NUL).
> > +      */
> > +     KALLSYMS_QUERY_BY_ADDR =3D 0x02,
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
> > +     __u64 size;             /* in - struct size for compatibility */
>
> I'm not sure you need a size here as well as the one in the ioctl command=
.
> It only complicates things when they differ.
>
> If you need a new version they you add an extra case to the switch statem=
ent.
> Simple and easy,

Good find thanks! Will update.

> > +     __u64 query_flags;      /* in - query mode (enum kallsyms_query_f=
lags) */
> > +     __u64 sym_name_addr;    /* in - address of symbol name buffer */
> > +     __u64 sym_addr;         /* out (BY_SYMBOL) / in (BY_ADDR) */
> > +     __u64 sym_name_size;    /* in/out - name buffer size / bytes writ=
ten */
>
> Maybe separate the buffer size from the length of the symbol written?
> The in/out parameter will get annoying in code doing multiple lookups.
> Or just have the buffer size and require it to be '\0' terminated.
> (There is a strncpy_from_user() can that be used.)

That is simpler- in v3, we can have buffer sizes as input only, and
names will always be NUL-terminated.

> The '\0' terminated string handling is likely to be noise against
> all the rest of the lookup code.
>
> David
>
> > +};
> > +
> > +#define KALLSYMS_QUERY_SIZE_VER0     40 /* sizeof first published stru=
ct */
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
> >  #endif       /* CONFIG_KGDB_KDB */
> >
> > +struct kallsyms_mod_find_ctx {
> > +     const char *name;
> > +     unsigned long addr;
> > +     bool found;
> > +};
> > +
> > +static int kallsyms_mod_find_cb(void *data, const char *name, unsigned=
 long addr)
> > +{
> > +     struct kallsyms_mod_find_ctx *ctx =3D data;
> > +
> > +     if (strcmp(name, ctx->name) !=3D 0)
> > +             return 0;
> > +     if (ctx->found && ctx->addr !=3D addr)
> > +             return -EADDRNOTAVAIL;
> > +     ctx->found =3D true;
> > +     ctx->addr =3D addr;
> > +     return 0;
> > +}
> > +
> > +static int do_kallsyms_query(struct kallsym_iter *iter, void __user *u=
arg)
> > +{
> > +     char namebuf[KSYM_NAME_LEN];
> > +     struct kallsyms_query karg;
> > +     unsigned long addr;
> > +     unsigned int start;
> > +     unsigned int end;
> > +     unsigned int i;
> > +     __u64 usize;
> > +     long len;
> > +     int err;
> > +
> > +     BUILD_BUG_ON(sizeof(struct kallsyms_query) !=3D KALLSYMS_QUERY_SI=
ZE_VER0);
> > +
> > +     /*
> > +      * The text interface shows zero addresses to openers without per=
mission.
> > +      * A zeroed point query result is useless (and an address-to-symb=
ol query
> > +      * would leak KASLR), so fail instead.
> > +      */
> > +     if (!iter->show_value)
> > +             return -EPERM;
> > +     if (copy_from_user(&usize, uarg, sizeof(usize)))
> > +             return -EFAULT;
> > +     if (usize > PAGE_SIZE)
> > +             return -E2BIG;
> > +     if (usize < KALLSYMS_QUERY_SIZE_VER0)
> > +             return -EINVAL;
> > +
> > +     err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
> > +     if (err)
> > +             return err;
> > +
> > +     switch (karg.query_flags) {
> > +     case KALLSYMS_QUERY_BY_SYMBOL:
> > +             if (karg.sym_addr || karg.sym_name_size)
> > +                     return -EINVAL;
> > +
> > +             len =3D strncpy_from_user(namebuf, u64_to_user_ptr(karg.s=
ym_name_addr),
> > +                                     sizeof(namebuf));
> > +             if (len < 0)
> > +                     return len;
> > +             if (len =3D=3D 0)
> > +                     return -EINVAL;
> > +             if (len =3D=3D sizeof(namebuf))
> > +                     return -ENAMETOOLONG;
> > +
> > +             if (kallsyms_lookup_names(namebuf, &start, &end)) {
> > +                     struct kallsyms_mod_find_ctx ctx =3D { .name =3D =
namebuf };
> > +
> > +                     err =3D module_kallsyms_on_each_symbol(NULL, kall=
syms_mod_find_cb, &ctx);
> > +                     /* Check first: maps -EOPNOTSUPP (CONFIG_MODULES=
=3Dn) to -ENOENT. */
> > +                     if (!ctx.found)
> > +                             return -ENOENT;
> > +                     if (err)
> > +                             return err;
> > +                     addr =3D ctx.addr;
> > +             } else {
> > +                     addr =3D kallsyms_sym_address(get_symbol_seq(star=
t));
> > +                     for (i =3D start + 1; i <=3D end; i++) {
> > +                             if (kallsyms_sym_address(get_symbol_seq(i=
)) !=3D addr)
> > +                                     return -EADDRNOTAVAIL;
> > +                     }
> > +             }
> > +
> > +             karg.sym_addr =3D addr;
> > +             break;
> > +     case KALLSYMS_QUERY_BY_ADDR:
> > +             if (!karg.sym_name_size)
> > +                     return -EINVAL;
> > +             addr =3D karg.sym_addr;
> > +             /* Reject addresses that do not fit in unsigned long (32-=
bit). */
> > +             if (addr !=3D karg.sym_addr)
> > +                     return -ENOENT;
> > +             if (!kallsyms_lookup(addr, NULL, NULL, NULL, namebuf))
> > +                     return -ENOENT;
> > +
> > +             len =3D strlen(namebuf) + 1;
> > +             if (karg.sym_name_size < len)
> > +                     return -ENAMETOOLONG;
> > +             if (copy_to_user(u64_to_user_ptr(karg.sym_name_addr), nam=
ebuf, len))
> > +                     return -EFAULT;
> > +
> > +             karg.sym_name_size =3D len;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize))=
)
> > +             return -EFAULT;
> > +
> > +     return 0;
> > +}
> > +
> > +static long kallsyms_ioctl(struct file *file, unsigned int cmd, unsign=
ed long arg)
> > +{
> > +     struct seq_file *m =3D file->private_data;
> > +
> > +     switch (_IOC_NR(cmd)) {
> > +     case _IOC_NR(KALLSYMS_QUERY):
> > +             if (!extensible_ioctl_valid(cmd, KALLSYMS_QUERY, KALLSYMS=
_QUERY_SIZE_VER0))
> > +                     return -ENOIOCTLCMD;
> > +             return do_kallsyms_query(m->private, (void __user *)arg);
> > +     default:
> > +             return -ENOIOCTLCMD;
> > +     }
> > +}
> > +
> >  static const struct proc_ops kallsyms_proc_ops =3D {
> >       .proc_open      =3D kallsyms_open,
> >       .proc_read      =3D seq_read,
> >       .proc_lseek     =3D seq_lseek,
> >       .proc_release   =3D seq_release_private,
> > +     .proc_ioctl     =3D kallsyms_ioctl,
> > +#ifdef CONFIG_COMPAT
> > +     .proc_compat_ioctl =3D compat_ptr_ioctl,
> > +#endif
> >  };
> >
> >  static int __init kallsyms_init(void)
>
