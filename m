Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051DB3F8243
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739165; cv=pass; b=ZYdBqMY/TBWjSJTtW9OSRISXWmaY7K9fmfwH+wJONuaMk/urnLjB8wcofWVPnT+gk7EtsSnXqbKmOS2f4lV6gs6dMSZUF9yNvz7ovUbvcBl450WFEQTKIQFvfiIxYVnnuCkrTTmpx+leRBD1920CMr3ouch/BQLA5Ru7CqB4H/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739165; c=relaxed/simple;
	bh=VgXa8OotkXsc5lVCPZMWPb/vLUr+lpZ4UKRyqgNrIWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl20epOaOOFmAdbkbh0GqurXYfb9tZ1hnnc/+u4QfvEQFSWrVpKLMq50a+DCG8+lZgQUZhX5qLgvq6rFWyvkm903i2lFBqm3hPXRQPjZsXjl7t4aRv27PKhAngecMkLTMobbzoQHb+uSPqRJt9UzsUjgPAA4IR5BOXye33YBSeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw3zWm9x; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw3zWm9x"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso6168048a12.2
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 06:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782739162; cv=none;
        d=google.com; s=arc-20260327;
        b=WDwFJ8y+HwKE5pA0uxAN0YgoGceT7lpQFeDkIuIsVfknE1FBV//o+Wfj0mgU2Tro6Q
         uISyv1D7ztwxqbtJVQOLX1DEPD1DeIja155ZZQSIetiHEVg/oD3UgJz3VT8rj5a9lOU+
         avZ2aBy0EKfSGIhON/XalVlcSzs6/p8n8ZPs6f2qmoMw10PjEo49m5H56uEE1mQRnajN
         b75y9JsntuQP0VJBQJmJNucR08uqVnxY+19zlevEUG2uZZv49ItiFKs8pzcbf8XdYLgC
         jyvxWZODN/n8kkXFdpuj+Aj9kfd+X/eXAPKl3hfbFLWd8ucpbWfXld+UbbySII7rKKD3
         UYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3h/W0XWiSvohOP1AjCLVTKYd/vmWZejhF/L+6OXH4M=;
        fh=kHfuyYnqkWsbDxMqPD3oJl9U5OvDjfbac+uUVfO6g+c=;
        b=KdMsN05IRLFA6dkfwdcGlsO4p2iCZVGvmwkMdp7WHQ1UeNTKHnVrx//0rID+HwF1j/
         /INDXx7ESZvz80FBn39r1Vs/bPl/COQqpLaHr+Wi/w6W3QW7KQxxxnjvPTccQrhWqESu
         fg0e/yPz6NQpGW/Wxiq6Fv9eG5AzlJzfNeXX97kw/+eBkDVJNhVheZVFVN7eioXIvkHV
         b5G2BPTfwFR3OQjyzlv/v5apu7UGdyvONiohLZohLWsM92kuM0pXROT90e6vklmi2dQI
         pi63wzsHYABUDxne8Zbn6OIkBOHBhHp6fEu26Rsc+bsxpduxlYmnqYwSz/c5QU3lxfX2
         5lVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782739162; x=1783343962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3h/W0XWiSvohOP1AjCLVTKYd/vmWZejhF/L+6OXH4M=;
        b=Uw3zWm9xfKNptCshwtZQ+04/6HVNoduo30w/Yk2BCUqs8ab3PinjCQFJ1cmpLdv39I
         nHxebEL2cPXcXHmNg7SElzgCH4PEw50+ywc44X3sojqzIsMD6uvCQWfp8WhmYVF0za/o
         8+m+qZ7VHkP1uDpsrId1fak+Ip+wXPjoY/XTPVrZWNLF5PmQBnrsrPek+l1DDwBTFXDM
         PepYW/gns+9SXUr8kcAZlUd+nV2OZjxsid9d0+bGFT3zWj5fMRYUQjk1O3WcjJUjICFS
         vEisrTZHo4geiinEiqysYA4sgIH/Zz2F8s5bRamhvr60Bvc8QrG0ZXw6pBpOR2NAu5zk
         cSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739162; x=1783343962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3h/W0XWiSvohOP1AjCLVTKYd/vmWZejhF/L+6OXH4M=;
        b=obfQK+1B5wau/GvbOhxcu4grJabuFQ8x1MBcKnEO2hQuNVaNRqtEiPbYPVAoR7Dd9i
         8yx8p4U8KZTT9HQkdcj4RJcyP2oQszypvwsdDg3r2FAu8VP9lt5VGlgKo6m91HXLCezE
         k5fqRRS5MKU8mNgsAESILlG/MMliNsceXf5DPkPbv9Vgv/1G8gdZJDqKH80SbzMT0Z5O
         dvbQ+Ezq06inyVINHZhTNPVN5WXTR9HA2jGRsHaLiO3R3y1ZPiuIoxwEoaEUj3fPOLYS
         +4uaWCXSYRng3tPFrt1mrgi6sS2uzywfJC09qG0S+OUZr4JUNnkBRAheXQSlugp6KIwR
         vyuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZ9MHNZHgLqJYU58+mXLplR2Kngab5Q4VK17jeX1xH2+M+ceWF9ib84QOue84NcoS+5ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwleFNL2wAVrE6GjclyJfeEVEI/YfZIpXLoHciUwU5f6WjOrGNA
	aYUL3A8AE8QvLVFQ/Ddxwn7i4HF4T5VwJpshD/HuSPkL+4Il82kvpMjLWajSESWu+WqFSrd4rff
	gVbo2eZMKmdv55JbBalGE+7/259BeXaA=
X-Gm-Gg: AfdE7cnAZOrcryztO+n5OHXX3ylf1pkSGaVFV8qSGemw57dO9ppawvBYw1zb57/VewS
	p+UnD3+Kdq2RANdPgGpev7LcGi3BZNNgYZRJmz5gtBvk68S4lq2V9yRL302H55vcOH1OLIef1/0
	UPrIR6k0d7MHquGKkB0h31rhGLEi+bbVt9zAvoVCryTjlIF/JffMQ/egHjqg55s/Di0wuqslClz
	1Jt0Wfu5I/KwuaRitiZZUkLQsmzJswafkFq0oOz5PqdFyLIUkb2EjQ8i8ga/DsKXlwUcKi9Ug==
X-Received: by 2002:a05:6402:a503:10b0:698:2f6d:cce with SMTP id
 4fb4d7f45d1cf-6982f6d0eb5mr3376940a12.4.1782739162411; Mon, 29 Jun 2026
 06:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
 <20251215034153.2367756-3-dolinux.peng@gmail.com> <20260513104758.6e64167e@gandalf.local.home>
In-Reply-To: <20260513104758.6e64167e@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 29 Jun 2026 21:19:11 +0800
X-Gm-Features: AVVi8CdmaMPz_fYrc-qy_9xfZZ5838GuDYDgMwYiajdRa56XDo91baTVPU0Vm5s
Message-ID: <CAErzpmt2wr8AYmfUvR5=Wm8JcLeCJ=W+Uhk5ZkzSKikaUzhn4w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] fgraph: Enhance funcgraph-retval with BTF-based
 type-aware output
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 10:47=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Mon, 15 Dec 2025 11:41:52 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > The current funcgraph-retval implementation suffers from two accuracy
> > issues:
> >
> > 1. Void-returning functions still print a return value, creating
> >    misleading noise in the trace output.
> >
> > 2. For functions returning narrower types (e.g., char, short), the
> >    displayed value can be incorrect because high bits of the register
> >    may contain undefined data.
> >
> > This patch addresses both problems by leveraging BTF to obtain the exac=
t
> > return type of each traced kernel function. The key changes are:
> >
> > 1. Void function filtering: Functions with void return type no longer
> >    display any return value in the trace output, eliminating unnecessar=
y
> >    clutter.
> >
> > 2. Type-aware value formatting: The return value is now properly trunca=
ted
> >    to match the actual width of the return type before being displayed.
> >    Additionally, the value is formatted according to its type for bette=
r
> >    human readability.
> >
> > Here is an output comparison:
> >
> > Before:
> >  # perf ftrace -G vfs_read --graph-opts retval
> >  ...
> >  1)               |   touch_atime() {
> >  1)               |     atime_needs_update() {
> >  1)   0.069 us    |       make_vfsuid(); /* ret=3D0x0 */
> >  1)   0.067 us    |       make_vfsgid(); /* ret=3D0x0 */
> >  1)               |       current_time() {
> >  1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=3D0=
x187f886aec3ed6f5 */
> >  1)   0.352 us    |       } /* current_time ret=3D0x69380753 */
> >  1)   0.792 us    |     } /* atime_needs_update ret=3D0x0 */
> >  1)   0.937 us    |   } /* touch_atime ret=3D0x0 */
> >
> > After:
> >  # perf ftrace -G vfs_read --graph-opts retval
> >  ...
> >  2)               |   touch_atime() {
> >  2)               |     atime_needs_update() {
> >  2)   0.070 us    |       make_vfsuid(); /* ret=3D0x0 */
> >  2)   0.070 us    |       make_vfsgid(); /* ret=3D0x0 */
> >  2)               |       current_time() {
> >  2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
> >  2)   0.312 us    |       } /* current_time ret=3D0x69380649(trunc) */
> >  2)   0.753 us    |     } /* atime_needs_update ret=3Dfalse */
> >  2)   0.899 us    |   } /* touch_atime */
> >
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  kernel/trace/trace_functions_graph.c | 124 ++++++++++++++++++++++++---
> >  1 file changed, 111 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_=
functions_graph.c
> > index 17c75cf2348e..46b66b1cfc16 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -15,6 +15,7 @@
> >
> >  #include "trace.h"
> >  #include "trace_output.h"
> > +#include "trace_btf.h"
> >
> >  /* When set, irq functions might be ignored */
> >  static int ftrace_graph_skip_irqs;
> > @@ -120,6 +121,13 @@ enum {
> >       FLAGS_FILL_END   =3D 3 << TRACE_GRAPH_PRINT_FILL_SHIFT,
> >  };
> >
> > +enum {
> > +     RETVAL_FMT_HEX   =3D BIT(0),
> > +     RETVAL_FMT_DEC   =3D BIT(1),
> > +     RETVAL_FMT_BOOL  =3D BIT(2),
> > +     RETVAL_FMT_TRUNC =3D BIT(3),
> > +};
> > +
> >  static void
> >  print_graph_duration(struct trace_array *tr, unsigned long long durati=
on,
> >                    struct trace_seq *s, u32 flags);
> > @@ -865,6 +873,73 @@ static void print_graph_retaddr(struct trace_seq *=
s, struct fgraph_retaddr_ent_e
> >
> >  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_G=
RAPH_RETADDR)
> >
> > +static void trim_retval(unsigned long func, unsigned long *retval, boo=
l *print_retval,
> > +                     int *fmt)
>
> This function should really be in trace_btf.c and a stub when btf is not
> enabled.

Thanks, I will fix it.

>
> -- Steve
>
> > +{
> > +     const struct btf_type *t;
> > +     char name[KSYM_NAME_LEN];
> > +     struct btf *btf;
> > +     u32 v, msb;
> > +     int kind;
> > +
> > +     if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> > +             return;
> > +
> > +     if (lookup_symbol_name(func, name))
> > +             return;
> > +
> > +     t =3D btf_find_func_proto(name, &btf);
> > +     if (IS_ERR_OR_NULL(t))
> > +             return;
> > +
> > +     t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> > +     kind =3D t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN;
> > +     switch (kind) {
> > +     case BTF_KIND_UNKN:
> > +             *print_retval =3D false;
> > +             break;
> > +     case BTF_KIND_STRUCT:
> > +     case BTF_KIND_UNION:
> > +     case BTF_KIND_ENUM:
> > +     case BTF_KIND_ENUM64:
> > +             if (kind =3D=3D BTF_KIND_STRUCT || kind =3D=3D BTF_KIND_U=
NION)
> > +                     *fmt =3D RETVAL_FMT_HEX;
> > +             else
> > +                     *fmt =3D RETVAL_FMT_DEC;
> > +
> > +             if (t->size > sizeof(unsigned long)) {
> > +                     *fmt |=3D RETVAL_FMT_TRUNC;
> > +             } else {
> > +                     msb =3D BITS_PER_BYTE * t->size - 1;
> > +                     *retval &=3D GENMASK(msb, 0);
> > +             }
> > +             break;
> > +     case BTF_KIND_INT:
> > +             v =3D *(u32 *)(t + 1);
> > +             if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_BOOL) {
> > +                     *fmt =3D RETVAL_FMT_BOOL;
> > +                     msb =3D 0;
> > +             } else {
> > +                     if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_SIGNED)
> > +                             *fmt =3D RETVAL_FMT_DEC;
> > +                     else
> > +                             *fmt =3D RETVAL_FMT_HEX;
> > +
> > +                     if (t->size > sizeof(unsigned long)) {
> > +                             *fmt |=3D RETVAL_FMT_TRUNC;
> > +                             msb =3D BITS_PER_LONG - 1;
> > +                     } else {
> > +                             msb =3D BTF_INT_BITS(v) - 1;
> > +                     }
> > +             }
> > +             *retval &=3D GENMASK(msb, 0);
> > +             break;
> > +     default:
> > +             *fmt =3D RETVAL_FMT_HEX;
> > +             break;
> > +     }
> > +}
> > +
