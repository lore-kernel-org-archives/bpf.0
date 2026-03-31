Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD940466B70
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992128; cv=pass; b=cGl7igAtIm6Oy7/iqfiwavgJ/qbcd5xkB4bReY4L6wZTh/SIn9cF15oFXiqdwaSDjhZyDFUBTwhqGeZAZz1Afz3yTHpVImImSH3ozhCt3VP4dqevnPUr6meoPhOry7mHqNHgCWwQd7WoT1gNbu6iktsB9+DTfZCSSw6TPafargY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992128; c=relaxed/simple;
	bh=fodsiWmj2b84Y4IUzha2eC9KzrJftIhNyUruoJBh1Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HynePMzMUIR5nli3cIMoe4ZLT5VGvKf3nsXW5EY612nkL8i3IXIZdzAAzoFCwAOIFj2ejd41oGmDERWczF5/cXIKR9QOAML94XOdUMplhrF3J8rDh8bOtcOW2Gx7mt8Fv7+ejwaomKvB22rWk9BMCWpjoPWUY0Nl5fOBhQfHopI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPP9m6Bo; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPP9m6Bo"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7412b07f22so130888a12.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992126; cv=none;
        d=google.com; s=arc-20240605;
        b=K52qUQCWOViZTPJ+TQg1L82grAzm6zxzpgPk8FxgnJKWmitfWqpgwNC/npBk9WE+Xq
         bqKHdz0PW2s8GpJc+fOZrQdC9vtU1ZocXgqcNuAsgQ1MbgXzZDxKLA0el46tMvczan0n
         BVQVzcj5Ded3OgirPZEbdiGh4TJ5jarSZ+IV+yC2/JrDvv1lRpzKAeEJnaFwWL+cONOl
         6IkDwtbGLUVWsOhhGJa3YjWlSZLS9zllSQ2//hDx4YzdqIdromb9QvM+p12QdRh9Lff/
         DpqJxZmSypfUdZToo+HHpO2EcXaWV7SqlFzSt1dQwoaZsmfz76/Oux2s9ZCUiWcLmqtr
         6rgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GQ+4iWIt7zIgR/TCAD3R3q4CMExq93+oMsnNtXz7LI0=;
        fh=w6YSdmtOf1NKX3w5wFeTCSc6scNeUu2+rBxyHKz+iAw=;
        b=gR4e5zJRUjy+4AW8Xzh9jU2SGHUNOigozUuP5IIiMnAj51+ozPeya1Y5iaTaf7XOaz
         N3WGhzjmqjSnGRSlqOSTHpPh9y6fxMEIVP557Yf5xQaZdkGARBCdKhRmoJm1ElUPWiaA
         thTgS6KX1381bTjqXhsZEV9gx+F/Jnkc2exAEGpGtxzarVMs539NFRSNvhXWd05MoYQa
         17U4WaSYEV+uGFmXMVYUVB1FX8N+dVesbf8Kc4qrJy1Wx6GMaWktbD7OEUIn2oVZUAcp
         iv3zqhgumKqlSAtxwPUXk7s8C8n5jQ6ESTRa3AQzIt/P/KXASd1N0yWJ+8XRaIpeV6bn
         YHDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992126; x=1775596926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ+4iWIt7zIgR/TCAD3R3q4CMExq93+oMsnNtXz7LI0=;
        b=hPP9m6Boo0aUnr74lpivkoq2/RElYAQgJz79pmmpGh4eLrHsyAVZitInizO23T5aj9
         uqDyU5S5X3jUWkd0TzKM2T9OT5rxFogOIDMOYLWP1gBUK9sh0w8WdqYuOQWqNDhQmW/x
         Bq7g3F2k4/w3dY3P5M89MpMIO3a5YOnGGyR+msEYwDuCDp9osCG0IxCfv71Or4rw9CES
         aQQp3/VeytVRhjcfE2wKVvOU3C0WFSdEav2kGw1hdRG57a5t5UjnVziMxdoRc9ek/aIi
         531B4fRUaFOPd022g1x9NLoNl7S2CO1LA5GT9BkaNcdkIoWrbIfglWsuuQC2IiVIxt5b
         KKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992126; x=1775596926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQ+4iWIt7zIgR/TCAD3R3q4CMExq93+oMsnNtXz7LI0=;
        b=QR+n2XUHDehCoYnBUdhOFKGyy49iycI+FFrxW/OvBDZmOZRtZf6bDybU99V+muGUXw
         1DK/H3vsKPJl7fQjwJ751NORilJrFxl5QKby/nB5RniL9awSOvRHK17CbBdb6INON02b
         Ul6/537hBJeVVjGXiB2kAYO4J1/Z2D1NLdT86uXLMUYf92aeXc1AXBJb+Xp5UdnCC+0o
         FQLh3lihkt+Br037qYQcF6kRprUD24ULLn1U4u1qryvihIv5On1leF3uzGK5ebfVDvbA
         WVGdQ7+OmFjE+CYwWLWKQQ8hR7NSeDaSHTpCmppN7UkL9F00l0FwjdMDwH0syd5smJmi
         Dhcw==
X-Gm-Message-State: AOJu0YxaOupWdzuMfQaCnXvd3b9SGIXrtZiEt6YIyiplWm0F0QZehVOT
	mDkkReuXbP3Z4AaKCtpumTelqhgMX4SHDACHTG3DgBH3Zc5fjmEQzf8oexFNig6+/DFKCNzRc96
	fgzy2FhT3EAqT7YqVrcO030LtMM4rOio=
X-Gm-Gg: ATEYQzxM2zKgGCyYoNKBGF3+42lTINKa/ZVo2PLw0s8eWWW8BZdsoduktNqj+Pgp4BU
	mGcOyfXM4h/P4FUQZeS9lLFV+ElptYtH0uKb/MHvei+zPms7qv7VTuLdDlr0g3dyY6MhCc6p4cP
	VMeAXHXyKsc/Yc4V6PPkAKNYZPhKpbX9BcrzKsi91i1Q0VkfkByV+YMDuj1+21W0XJIpnemzamn
	ymmnhWOxJA74bV6TgBL3XAgG5ERZ04D1lwm/UhorgpeGfGQAQKPLxNUbMpRHn7vVvYW+b9jskWb
	dMQlpsvGECKdcP2PFj7dpdc=
X-Received: by 2002:a05:6a20:3d85:b0:39b:ffd1:123a with SMTP id
 adf61e73a8af0-39edc013db3mr5139242637.39.1774992126130; Tue, 31 Mar 2026
 14:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com> <20260330-sleepable_tracepoints-v8-5-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-5-2e323467f3a0@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Mar 2026 14:21:54 -0700
X-Gm-Features: AQROBzAp7Mbjn3_o3oSmZTjRWSHQQWtiQTr9bLbnOWo5RBgovjwmal3wdvAz97U
Message-ID: <CAEf4Bzamw99OPiELzGysyYe-=Hq28-K_Q7n9Mkwf3kkQ11LHzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 5/6] libbpf: Add section handlers for
 sleepable tracepoints
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, peterz@infradead.org, rostedt@goodmis.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add SEC_DEF entries for sleepable tracepoint variants:
>   - "tp_btf.s+"     for sleepable BTF-based raw tracepoints
>   - "raw_tp.s+"     for sleepable classic raw tracepoints
>   - "raw_tracepoint.s+" (alias)
>   - "tp.s+"         for sleepable classic tracepoints
>   - "tracepoint.s+" (alias)
>
> Update attach_raw_tp() to recognize "raw_tp.s" and
> "raw_tracepoint.s" prefixes when extracting the tracepoint name.
>
> Rewrite attach_tp() to use a prefix array including "tp.s/" and
> "tracepoint.s/" variants for proper section name parsing.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 39 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ea41f40dc82..a353dc7a4d41 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9982,11 +9982,16 @@ static const struct bpf_sec_def section_defs[] =
=3D {
>         SEC_DEF("netkit/peer",          SCHED_CLS, BPF_NETKIT_PEER, SEC_N=
ONE),
>         SEC_DEF("tracepoint+",          TRACEPOINT, 0, SEC_NONE, attach_t=
p),
>         SEC_DEF("tp+",                  TRACEPOINT, 0, SEC_NONE, attach_t=
p),
> +       SEC_DEF("tracepoint.s+",        TRACEPOINT, 0, SEC_SLEEPABLE, att=
ach_tp),
> +       SEC_DEF("tp.s+",                TRACEPOINT, 0, SEC_SLEEPABLE, att=
ach_tp),
>         SEC_DEF("raw_tracepoint+",      RAW_TRACEPOINT, 0, SEC_NONE, atta=
ch_raw_tp),
>         SEC_DEF("raw_tp+",              RAW_TRACEPOINT, 0, SEC_NONE, atta=
ch_raw_tp),
> +       SEC_DEF("raw_tracepoint.s+",    RAW_TRACEPOINT, 0, SEC_SLEEPABLE,=
 attach_raw_tp),
> +       SEC_DEF("raw_tp.s+",            RAW_TRACEPOINT, 0, SEC_SLEEPABLE,=
 attach_raw_tp),
>         SEC_DEF("raw_tracepoint.w+",    RAW_TRACEPOINT_WRITABLE, 0, SEC_N=
ONE, attach_raw_tp),
>         SEC_DEF("raw_tp.w+",            RAW_TRACEPOINT_WRITABLE, 0, SEC_N=
ONE, attach_raw_tp),
>         SEC_DEF("tp_btf+",              TRACING, BPF_TRACE_RAW_TP, SEC_AT=
TACH_BTF, attach_trace),
> +       SEC_DEF("tp_btf.s+",            TRACING, BPF_TRACE_RAW_TP, SEC_AT=
TACH_BTF | SEC_SLEEPABLE, attach_trace),
>         SEC_DEF("fentry+",              TRACING, BPF_TRACE_FENTRY, SEC_AT=
TACH_BTF, attach_trace),
>         SEC_DEF("fmod_ret+",            TRACING, BPF_MODIFY_RETURN, SEC_A=
TTACH_BTF, attach_trace),
>         SEC_DEF("fexit+",               TRACING, BPF_TRACE_FEXIT, SEC_ATT=
ACH_BTF, attach_trace),
> @@ -13109,23 +13114,41 @@ struct bpf_link *bpf_program__attach_tracepoint=
(const struct bpf_program *prog,
>
>  static int attach_tp(const struct bpf_program *prog, long cookie, struct=
 bpf_link **link)
>  {
> +       static const char *const prefixes[] =3D {
> +               "tp.s/",
> +               "tp/",
> +               "tracepoint.s/",
> +               "tracepoint/",
> +       };
>         char *sec_name, *tp_cat, *tp_name;
> +       size_t i;
>
>         *link =3D NULL;
>
> -       /* no auto-attach for SEC("tp") or SEC("tracepoint") */
> -       if (strcmp(prog->sec_name, "tp") =3D=3D 0 || strcmp(prog->sec_nam=
e, "tracepoint") =3D=3D 0)
> +       /* no auto-attach for bare SEC("tp"), SEC("tracepoint") and .s va=
riants */
> +       if (strcmp(prog->sec_name, "tp") =3D=3D 0 ||
> +           strcmp(prog->sec_name, "tracepoint") =3D=3D 0 ||
> +           strcmp(prog->sec_name, "tp.s") =3D=3D 0 ||
> +           strcmp(prog->sec_name, "tracepoint.s") =3D=3D 0)
>                 return 0;

it makes no sense to hard-code explicit strcmp() literal strings here
while having prefixes array. why not do what attach_raw_tp() does and
use just prefixes uniformly?

pw-bot: cr


>
>         sec_name =3D strdup(prog->sec_name);
>         if (!sec_name)
>                 return -ENOMEM;
>
> -       /* extract "tp/<category>/<name>" or "tracepoint/<category>/<name=
>" */
> -       if (str_has_pfx(prog->sec_name, "tp/"))
> -               tp_cat =3D sec_name + sizeof("tp/") - 1;
> -       else
> -               tp_cat =3D sec_name + sizeof("tracepoint/") - 1;
> +       /* extract "<prefix><category>/<name>" */
> +       tp_cat =3D NULL;
> +       for (i =3D 0; i < ARRAY_SIZE(prefixes); i++) {
> +               if (str_has_pfx(prog->sec_name, prefixes[i])) {
> +                       tp_cat =3D sec_name + strlen(prefixes[i]);
> +                       break;
> +               }
> +       }
> +       if (!tp_cat) {
> +               free(sec_name);
> +               return -EINVAL;
> +       }
> +
>         tp_name =3D strchr(tp_cat, '/');
>         if (!tp_name) {
>                 free(sec_name);
> @@ -13189,6 +13212,8 @@ static int attach_raw_tp(const struct bpf_program=
 *prog, long cookie, struct bpf
>                 "raw_tracepoint",
>                 "raw_tp.w",
>                 "raw_tracepoint.w",
> +               "raw_tp.s",
> +               "raw_tracepoint.s",
>         };
>         size_t i;
>         const char *tp_name =3D NULL;
>
> --
> 2.52.0
>
