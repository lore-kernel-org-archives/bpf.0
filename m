Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654409;
	b=YVz6bsTxrIhhnqd4mmkF05ElYrzv9B93QJ+RWUQy630tZbvRAl7jgkUVYiO0iKowTTBF
	 zmqjEUmh0cac1wdiqSXN4kvqZEYlC4FOyzmC0AixyuXMo+piws2yFAC2j+euqyz9gvc02
	 fK2KHP1/gvX1DESNRAlvSgwn4qoTnV1BeWW1u69uJhq1v3DX0PGSXFuGEOrzgemfplH4k
	 l2NE/a5rHa8vMDBoew3GUfqTnSjVo+vkgeGiSzZCkY7AVeE23F7Qw6IQ9D8F4y5gUhXOI
	 Qwfn4aelR6HprqGES/LLY5uRepn9DjT+B3vNWSH2ez/CIAAZJICLmFejE1NDyvs1Gpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
	b=1/swpcwpp9Cl2AzT6RZ2Y8l6Mymaqtnadq2R24t75xyIK/WlAi0nC+wy3ao8a7bks5Xz
	 tOMlrGcPht/NEXvy4K1nRD/PQxmaCmJnzuPOq/oz6ikCgaAu8Yb6IcQdQPZ7APK0W0ays
	 ZDmT1P8VyZtS5+FY/BTrVfV5hU4nG8S1S7f4+54FKQdBY0c0ptV3XxLWhBqxv3+1WIU/7
	 gEqD9XIK4I2AeIVPFx8lI9G5YS+9O0okgo+i7i6OfIZ4+Z/kyI6KavMPSyLR2TAG570pz
	 V0hXOfucWedc5EROVZkb/Lx1eb+DL9guqvPTiJ2Eqq2qRu7Bq6n+mtIpoVXDN77OP8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMbLOmTg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44097606A33A
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44097606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMbLOmTg
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so1038065566b.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:53:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795654408; cv=none;
        d=google.com; s=arc-20260327;
        b=LDg4oAMIg3YY+AEeWg4ohX6gf86pe+BZ1pEOU9xSIsZBaLlBUYZ+ZxfXp+VwjtF53k
         eJoeWOsBhjpJjnf0mjv62HnFF4MWgpMqYrwDRB2HzkEXDipaj/UW28ZeHdujZ4BYtMQO
         24znYit3tmtCtj6/h6mrUDdeklf/0fhhNCkXqTtANY14wqUMuSUlOu7NyFU70BtKLqva
         HiJXLrWURrD7keigM+dFykTgOEmKfJ5uJPwQidnNyeLQSD0o17N97P8T/tOgFyOS5Ddl
         MM4oslazYy2pxak0WMSyuikBZCixMIv1W4ujL/tfHA948vKLQNgN0tmyB6BsZ8KRQBPI
         T6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
        fh=GlYZra/M0ZAff5VFaZuXJvZrs2A1v9LpX5ItNOEWJ/I=;
        b=m10jE0XiGXhVqII1BwsCxZvfHGGW97kzXOgG2LHmMTSr/6nY0d3RESpedzC/bd+Mvg
         i5BnOjhXtB0RItERiBJwCDwqHtlQ33/qUIPi73dEAP+84gUVSPEL31ruTELQ3o585rEL
         cIGKv6lPXXIA1gj37YvzOLAI0j34lqwONNGFPR16PbofLKCUn59NiL20CsQb1RzQa8r/
         2IID6t4J0ItliwTFJsrqA7oT/v7lLh8ZuKif3NZQ1Kjofg4+5370jBw7RQplEIibzzJ0
         vDqpAFG6N9DDnH5Maz73yNKNBlqCfgZ+kSz3WvWN++aVanEWX2AWmYRGqDlnlPGDzSmR
         F1sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795654408; x=1796259208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
        b=OMbLOmTgwkBLdVF5EdkYSC2XrgccLIkkqOXgyFgiuHmBsv8YiKTp9E0NEIyhirgYwo
         BZ+ApH53YZ2KTVkaJNbDjcMue9DCSXid0Du4+70qfpSn/U6BPQcaO0rTHvaEKiMrhjq+
         cgrO6KnCn2xh6qE6NyajQBDq/7N3cmFb2502QyBeGyuN0J8TZ8STFtPa+xPXpE5PEied
         9EIDboORco4TC6wv1vXi5MBxzHo/qEkcV1RPpsCU6P4rl7yl2ijcQhep5KTjor4bMPiQ
         FloIu+x3tOotka6vXyHSWrSW9RsgR8EkvzFkVBto/arghTtNsJHfG3gnYoPBAaEQS9BY
         49RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654408; x=1796259208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssrpjNNwMPYh08mQfz/FC+I2tBSrmUfphBtDGQUYlDo=;
        b=Hzb38XIysGxz50oAFHl/4QT8AiTIU4uzP7PMVQmXCGpUu1lr8r+vsZrwDHsD6gPZLW
         QTd2OlkVUzhekV88k91Ssc4lqBDBrT8mWQ7I2Y9IHBw9hrfkROiwURV2Xb+PUVTJmMZ2
         K9CaTg0x5Nsi1RuQI116jR5uCBdMDn8oM5G0t4z4GBmr7n1NjGioax8utCll0zMm91d9
         0f0Pr+ijQxYXugPYICR70nDLbv+GxTCH/Cx/fLfXPq0YKDgVUh7ReYNx1L5X04zSuPIC
         RKWNtP3dsSKHN9NYpSnjbXMXH7VZ1iEMriQA6CI3JiZIA5n7vscx2tOedwy5Sh1v6Ya1
         AQ0A==
X-Forwarded-Encrypted: i=1; AL+hErEwpgv7xLDHoWs/y8aUrliDWKx4meUsXV/dvcyrwXgNzQWGGlHmxWYIqnhzdng5zXKxMZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GSSv8EsVyBwnmrodjnNXZJh0xoClD1L3iAmi0T6ZN8IjBDyW/
	VdKUPy41yX0MaaoOO7DA1eNxDVzf2tXdrdgMI4i5LT0YPdNYSxMOskdrRKV2wIpSV1YMwKBtC9/
	sFmTmw2aGuQEyZSrIdAvmMwObnHRFQ9gB6zX5eZC4
X-Gm-Gg: AZFdTZfpeQ88L5F1S5K7dKbZktwrHr1GEvK+VhqHaxUGtiu1KGzNRn3qPPAMmvbgdMZ
	ifWb2TPSf2viQJA5cb61ErjXD4+2QcRj3AlKrnaYEwyntSZSSIdyLqPclBKMBYKA001CjnNq4xz
	ykxTwMPFvQ3SBnEvpZJv46uXM0ob0R+rEgLoxinXEvArdMq8CPHgDaFcUpHZTl3djGfHP4LZ254
	8sHI6e9ALdisjNjeP31qj7lWg98F3bWmeRIn4b7VthDVYEo8G1VfhK21sqSgU9miacV5G24kiwy
	dY6vjXBluIku8UTE0HVXDjeqqR5QLcHxttChN6gXmxNEvfyRB8kQrLqk/RU5PZgyQT1u6OTz1fv
	2/o9p/8R51j5LIsNUOAPMfTE+S2oXS2RGK1Bjbb9QtAcVWF0M3OXZ9a1rDJ8TQ513m5k=
X-Received: by 2002:a17:907:c643:10b0:c2e:4292:d27e with SMTP id
 a640c23a62f3a-c513a816d3amr1138026566b.22.1795654407168; Wed, 25 Nov 2026
 16:53:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-19-wusamuel@google.com> <CAEf4Bza48tGhcUhFRhSSv3qijV0uF8YrAQcLM6Qv9az-8zvK_Q@mail.gmail.com>
In-Reply-To: <CAEf4Bza48tGhcUhFRhSSv3qijV0uF8YrAQcLM6Qv9az-8zvK_Q@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:53:16 -0800
X-Gm-Features: Aa3M54rfuKAHSB0QMI506grzDhwAStyJm9gAvy8QXVpNXfEJd-B8LId_HiOPEPc
Message-ID: <CAG2Kctq98pvyV=jmN0Di+p7m0AWQKg8+QF5YBvdLi79kTJaKoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/9] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY_BY_NAME ioctl
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 12:25=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 13, 2026 at 2:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > libbpf parses all of /proc/kallsyms to resolve typeless ksyms.
> >
> > Use KALLSYMS_QUERY_BY_NAME instead: exact names, plus "<name>.llvm."
> > prefix matches. Ambiguous matches at different addresses fail the load.
> > A missing strong extern still fails and a missing weak extern is 0,
> > without a text scan.
> >
> > On any other error (e.g. -ENOTTY on older kernels, or -EPERM), fall bac=
k
> > to the text parser.
> >
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 99 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 44134421bd7d..f3f3475a64d3 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -59,6 +59,34 @@
> >  #define BPF_FS_MAGIC           0xcafe4a11
> >  #endif
> >
> > +#ifndef KALLSYMS_QUERY_BY_NAME
> > +/* 'f' is PROCFS_IOCTL_MAGIC */
> > +#define KALLSYMS_QUERY_BY_NAME _IOC(_IOC_READ | _IOC_WRITE, 'f', 48, 0=
)
> > +
> > +enum kallsyms_query_flags {
> > +       KALLSYMS_QUERY_NAME_PREFIX =3D 0x01,
> > +};
> > +
> > +struct kallsyms_query_sym {
> > +       __u64 sym_addr;
> > +       __u64 sym_size;
> > +       __u64 sym_name;
> > +       __u64 sym_name_len;
> > +       __u64 sym_module;
> > +       __u64 sym_module_len;
> > +};
> > +
> > +struct kallsyms_query_by_name {
> > +       __u64 size;
> > +       __u64 query_flags;
> > +       __u64 query_name;
> > +       __u64 module_filter;
> > +       __u64 pos;
> > +       __u64 sym;
> > +       __u64 sym_struct_size;
> > +};
> > +#endif
> > +
>
> there is no need for this, libbpf in kernel can use kernels' most up
> to date UAPI headers directly, and on Github we sync necessary UAPI
> headers into include/ directory, so libbpf source code can be built
> with latest definitions of kernel UAPI. So you can drop this part

Ack, will drop entire #ifndef block
[...]

> > +
> > +       while (!ioctl(fd, KALLSYMS_QUERY_BY_NAME, &q)) {
> > +               if (!ext->is_set) {
> > +                       ext->is_set =3D true;
> > +                       ext->ksym.addr =3D sym.sym_addr;
> > +                       pr_debug("extern (ksym) '%s': set to 0x%llx\n",
> > +                                ext->name, ext->ksym.addr);
> > +               } else if (sym.sym_addr !=3D ext->ksym.addr) {
> > +                       pr_warn("extern (ksym) '%s': resolution is ambi=
guous: 0x%llx or 0x%llx\n",
> > +                               ext->name, ext->ksym.addr,
> > +                               (unsigned long long)sym.sym_addr);
> > +                       return -EADDRNOTAVAIL;
>
> I think there is ENOTUNIQ which we can utilize here

Ack
[...]

> > +               /* Check exact name and then LTO .llvm.<hash> prefix */
> > +               err =3D query_ksym_by_name(fd, ext, false);
> > +               if (!err)
> > +                       err =3D query_ksym_by_name(fd, ext, true);
>
> err =3D err ?: query_ksym_by_name(fd, ext, true /* lto_prefix */);

Ack- will update in v4. Thanks for the thoughtful review!
