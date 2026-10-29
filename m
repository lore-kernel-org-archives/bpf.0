Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793312201;
	b=BuL7C/MoxGs9VImE5Fe2VOqZSHgIEGyhrU6Rk/0HOPp6xlzJ7TOULq4jw8nO7UnX7yoU
	 TXS/TyVYq83UWbjJU0veYvv/AuTR7sRY/R7SP9vMoC/Zo6S0Ywflwdwd3h5u6vpZcswND
	 hywo8TzZDNlarrlPjVayurZXQBAXRY2V+NImmkS2su5jQDKVge2gL3tlUhH01wbYEOwQZ
	 D7npBs6B6SB4aCwuiBXmKzNs9NrYq1BG5LxM9ilWIWTgCqA05/HPqYo1bgtolfXGNSl74
	 B8YNGC6eedHXTek8vZMhDJrqiVMFS+LHbRkfdFvsMD1MIUKS+KNjP+cyU59UgsTZoAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=koZpx6vqHKuQYrxobP/d4PhoSM1zd0NfzqrWj5/V+0E=;
	b=Zb+D4Zne/uKNENfOz9XIQMOdrWJtNEW68+oj1teT9A+Qtr5HtFKE2EQHHoC9uyXAVkoM
	 1tzd4kmZEX4vLhEKeiq04QAVYwvv0MWGv4+WvYQpCeESS7KsyAImDLy3GiyTdO6bY7Q1V
	 JMttIN6LDzEwKDnvv4SgaQCIvQw/TivDo3+6Pi6NUNTrqb5dA6ZbXoEuSyG/1B2U1scOq
	 LLyr9dovuhOCKOdOixNBkGFeMP2jhz8FHdelNoX3OHnZPu3B7BHJGxgg0WdUJmrFsi3v9
	 jmjZmMb16pzLJM5ytm8TAmVLrxAGlbXrLQi0r5yeMz+noeFPWB9xZ2ANWdYoqPmfO6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr2L+YSV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78B606A31E
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF78B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xr2L+YSV
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso26558a91.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793312200; cv=none;
        d=google.com; s=arc-20260327;
        b=c2fY0/8KgyhH6zez9+fXDjibp8fbnHo+oA2q8c3dXMbwK5uqs52qt0/QImgIdGVgj/
         D4MMW04R5F1s1pZa7VFuEQ1Tl4SI8iCQpUuJNS5uRQ6ZcDVAzCox7z/NseBzkpAy8KOp
         BIr1OcP3PjYdPwN+0hQmAB5xQcO9tfHJzRIjDXBG6otsx5Njcsv2GIsbgpI/WxilzvD5
         EEXs8JGPKoRWKJI2veHOxiGIX7fsHkALX0bDgbKtd2lZXdpxcdcI1wx7LqE80x2S9llL
         A613pou24wUqNo07Jjak2Mqx6Vy+3o10fSUFSF33aKtio/Wnld5O11TnV11mMRG20SjP
         hY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=koZpx6vqHKuQYrxobP/d4PhoSM1zd0NfzqrWj5/V+0E=;
        fh=phUVL/2SXtlCRnmcMLEY2EHS7B3IBxJOMcdiKpuxrG4=;
        b=VVFl9zMO5eDAvG3o4zix4zlxseCYv4U7NycpOg+TZKBuIVgQCviY7lCe7erZdseX2e
         Jf4+qWB9wVVOpMTZBvGPbVRRQhoyEAGDGBwmWxegoyepVgWd47Ye2uSaDVvVKGbm7cJn
         IU1eoxA2jqAX5lS1+EUske2IVPR5/38vII0JASQ+jVmKVFx1eWEZHunyKdNEAssJlmwj
         6Om6sDgx50/Dl/gKdYsKq0z2ojMSwwW4l165AijCYMysNNvZC7ylw3Jqyv5H30WA0C5Q
         s5tTSXHd6d1+joZxb0xbzjih6ZM+55qk+Zy4kB3HP75TjI+oKjMcQdgrZmaCFmeZRPgt
         7Q8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312200; x=1793917000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=koZpx6vqHKuQYrxobP/d4PhoSM1zd0NfzqrWj5/V+0E=;
        b=xr2L+YSVfPIi5bsK0sQduGMgmae01aKgXSUseaJikh3GJOXYKaCpT7MugONeWoy1Wy
         L0fdYaceEriICAikAcMys9iLe0NuSQyGQTELjt2Ft54mZK0Ea2rsg22LaEwXUnKKsovd
         kL7PGxEK47e2qujKLsgE9yrTo5lfZKx8nHxgb3r/PIxi0YchvNvUoe5g+rWm0xrJEUse
         9DRaJt4wWvOsq/laKci0C89PCBiI5SJb3D52TcFto6hBRRY+AOb0prFHVuz6lvt3uQIn
         O911UfpGGIIYXaSbBrKrO1+qB14+el9UMLEsR0DWmN+bb465NXDjwcUKwy1uZCPx7BeO
         Va8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312200; x=1793917000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koZpx6vqHKuQYrxobP/d4PhoSM1zd0NfzqrWj5/V+0E=;
        b=zq4FcOcdXCPjlOM6wgDrBG4GVAJFCaVdaJWRI789G5JLkaV0g0Md5XJ2ew0RN2MIzp
         ww/uf0EwE56lFgUTT/gyaGWtaIqeqoVmDyv/3AKUWgF4PaPUvrPzhtpI5YIvXB4oDH1m
         7FZ7qrBoyZ9nAJzXT6nujdA07bnLg3kxl+EEqukjXcrkM41XW0Dh1o4V8V18Cz8EJhTK
         t3Ykvsf5wBxV2ovuVyX3uAJ0XdnDE3aVdBjqr0GfzaBsVgBy2+tB8/CQmWfXwncZdG3M
         uNohWEeiAeNcpT/MKisx3i2dL/Ic+yzmPjqG7ngkt0hYJbwfl6khKjbzcNCdh+lNTimn
         AVsQ==
X-Forwarded-Encrypted: i=1; AKwUvBynQZJtdNyOO8RDV28hTu36u8EHdWXzbx2L7/jvhdmYlLMwmxkUDe3m0GFXoyOha9Sph3s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgE6UhuDT+tK4NmoNLVSfJWwaM2rqB9isGhTwAzRmi2+Kc45tp
	X615wObDQk5GHvSYXizR61CGeguVIzhN2geEl/jZqPucWHoSvNTdfKmVL6RbAV+3LUkLmXLNKPZ
	dCnPIAh129JLV2Cg+KAGqr8mN+b3O8Bc=
X-Gm-Gg: AYBFou1XN/k6/wHZn6w2Rx6YM/pJdy3IP41ZgLNwfm06dz9piFFnpn696412sySMVUI
	VXagIB61hguPRWgvp160qnMG4q8f9Y2Lo7ItLAUuVvogSK8zzFrOUIG1xGkjLdXdAAEiAW44VFM
	lkm0nE3hlMTjEKYULha7jfgOhTXI2XXA33un8J8K/63CipfsUJ1xOLETfu3XzrdTiYzncQug4Bv
	8Mu7lxbTNL/u9ePMSH2QQtj7zv99NQINqCtGPu0liLLpwyGFFOjSdNcg+lJawYrAkkx+s7wXijP
	3sqq+riy6Y+waEtPVgBL51mDWWkzD0bqMezWzc1I9V7nZu52LmYG8ZFa2xgsCEgRvCrTISOinu6
	MKZHwhEIEkCZilHoBMzz0tikEAAElRgrh6rDgehNmxaMbGGSGpf+gSabWo61DNBnOv89Dl9+K0Y
	LD97cvLkxeII3vmV69H7QufbZvkKaWTlPiEQ==
X-Received: by 2002:a17:90b:380c:b0:3a7:250:333e with SMTP id
 98e67ed59e1d1-3ae896f8315mr277145a91.11.1793312200139; Thu, 29 Oct 2026
 15:16:40 -0700 (PDT)
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
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
In-Reply-To: <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 15:16:27 -0700
X-Gm-Features: AclHuK9av7Er2dEcOWg6hJWIv2K2TpdNYpqUpTLgWkKxe-dORmBpAAvoyO4hh00
Message-ID: <CAEf4BzYT4rvKwbOJ6UQ3zcp4wdsSBqRsMz-2=U1DA2RyUA3XSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:06=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Wed, Oct 28, 2026 at 6:40=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Thu, 22 Oct 2026 17:16:02 -0700
> > Samuel Wu <wusamuel@google.com> wrote:
> >
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
> >
> > Hmmmm....
> > What happens when you have functions foo and foo.constprop0
> > In some sense they are duplicates.
>
> BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> would be different symbols at different addresses. Please correct me
> if I'm missing something here!
>

foo and foo.constprop0 are different functions with different
arguments, so I think we should distinguish them. The only special
case is .llvm.<hash> because that suffix is added by compiler for LTO
and I don't think the function itself is any different from the
original

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
> >
> > You could mmap the tables into userspace and have a ioctl that reported
> > the offsets of the tables (etc).
> > Then user lookup would faster then kernel lookup!
> > Especially since you could throw a bit more memory at it to remove the
> > linear scans.
>
> I think that would increase the UAPI surface because it would set the
> table format, so I'd prefer not to. It would only cover vmlinux and
> not modules, and then we'd need to apply kptr_restrict checks to the
> mapping.
>
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
> >
> > Have you tried measuring it with my patches that speed up the kernel
> > 'search by name' code?
> > That speeds the lookup by a factor of ~18 (testing the code in userspac=
e).
>
> Not yet. Can you point me to the latest version? Happy to try it out.
>
> > You also should allow for 'find first' and 'find next'.
> > As well as letting the code iterate though functions with the same name
> > it is absolutely trivial to enhance the 'lookup by name' code to match
> > a prefix.
>
> Agreed, that would be useful. In v3, the idea will be to have BY_NAME
> return the first match by default, and an ALL_MATCHES flag to report
> how many matches exist. Find next and prefix matching can be added
> later with breaking UAPI, and best to not include in v3 since there
> isn't yet a user.

I do think it would be good to spend a bit of thought on how to
support at least one-by-one pagination from the get go. The same
mechanism can then be used by batch version. I.e., think what can we
use to provide data back to user which they can use to continue search
after the symbol we just returned (at least for fixed set of symbols
in vmlinux and modules; we also have dynamic symbols added for [bpf]
"module", etc, we should support those as much as possible with the
least possible deviation, IMO)

>
> > (Basically it needs to 'return -index' instead of 'return -1' when the
> > binary scan fails.)
> >
> >
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
> > >       __u64 build_id_addr;            /* in */
> > >  };
> > >
> > > +/* /proc/kallsyms ioctl */
> > > +#define KALLSYMS_QUERY       _IOWR(PROCFS_IOCTL_MAGIC, 18, struct ka=
llsyms_query)
> > > +
> > > +/* Exactly one query mode must be set in query_flags. */
> > > +enum kallsyms_query_flags {
> > > +     /*
> > > +      * Look up a symbol in vmlinux or loaded modules (vmlinux first=
; BPF
> > > +      * and ftrace symbols are not searched) by exact NUL-terminated=
 name
> > > +      * at sym_name_addr and return sym_addr. sym_addr and sym_name_=
size
> > > +      * must be 0 on input.
> > > +      */
> > > +     KALLSYMS_QUERY_BY_SYMBOL =3D 0x01,
> > > +     /*
> > > +      * Look up the symbol covering sym_addr and write its NUL-termi=
nated
> > > +      * name to the sym_name_addr buffer of sym_name_size bytes. The=
 same
> > > +      * symbols as %pS are searched: vmlinux, loaded modules, BPF JI=
T
> > > +      * images, and freed module init functions still tracked by ftr=
ace.
> > > +      * A buffer of KSYM_NAME_LEN (512 at the time of writing) bytes=
 is
> > > +      * always enough. On success, sym_name_size is set to the numbe=
r of
> > > +      * bytes written (including the terminating NUL).
> > > +      */
> > > +     KALLSYMS_QUERY_BY_ADDR =3D 0x02,
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
> > > +     __u64 size;             /* in - struct size for compatibility *=
/
> >
> > I'm not sure you need a size here as well as the one in the ioctl comma=
nd.
> > It only complicates things when they differ.
> >
> > If you need a new version they you add an extra case to the switch stat=
ement.
> > Simple and easy,
>
> Good find thanks! Will update.

think about user space application compiled against UAPI headers from
older kernel version. For that application size will be smaller and
that's ok, newer kernel should honor this and only fill out smaller
part of v2 struct. Versioning is done by appending fields. This is a
well established pattern that provides a pretty good forward/backward
compat story, let's keep it.

>
> > > +     __u64 query_flags;      /* in - query mode (enum kallsyms_query=
_flags) */
> > > +     __u64 sym_name_addr;    /* in - address of symbol name buffer *=
/
> > > +     __u64 sym_addr;         /* out (BY_SYMBOL) / in (BY_ADDR) */
> > > +     __u64 sym_name_size;    /* in/out - name buffer size / bytes wr=
itten */
> >
> > Maybe separate the buffer size from the length of the symbol written?
> > The in/out parameter will get annoying in code doing multiple lookups.
> > Or just have the buffer size and require it to be '\0' terminated.
> > (There is a strncpy_from_user() can that be used.)
>
> That is simpler- in v3, we can have buffer sizes as input only, and
> names will always be NUL-terminated.
>

user code can be easily written by always setting buffer size, even if
kallsyms_query is reused. This is the pattern with PROCMAP_QUERY,
let's keep it consistent.

also, returning actual size even if buffer is too short is a good way
for user space to "probe" and increase buffer if necessary. unless it
adds tons of complexity, this is a good and flexible UAPI

> > The '\0' terminated string handling is likely to be noise against
> > all the rest of the lookup code.
> >
> > David
> >

[...]
