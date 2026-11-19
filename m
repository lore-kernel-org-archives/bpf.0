Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126222;
	b=CQRWNyHvblMr4URZB58rHBopFsHNLOZIoaJ73Id8Eiu2ZQ9a7NXr174uxKITGrG2OrTt
	 IgXu5saOVA/4xnlIgotW0+2vZmnDLtgVi1JWDqsMnRvLBaaP1Ke9SspzG9LT36TQzXl/K
	 27wMrxmFtN6A9YfbYTE9vlTCozlXdS0e2VcCoKir4vKoWqsko57vwqzPxHggYMF/6MPjg
	 MRC68P4HB40xfb3f+IYH7P01TiNhNCziyy3i8jXx9hG0m9AvluN32c2U50gJREFijVHmI
	 XX+TMm9c4Beyo8uEfpGFR6Y+xAglwVf6Y2FX6oncF85oGs+N2uMywdI8PgA7KqyLJ1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DijvpPerg9iR/CBftr4FcI8/cFREAu6o0TdxhkUHjok=;
	b=IJqZ98efb0F9ZcCAipJmBbdd4P6ZfAdjGr2GHpNXqwIzoPSb+sGEWH6bsoSEgOb6+YmT
	 I4vNB7Hn1FsgDI+foMpKYxfjXrvaldxeAcomtFaCRS5ORmB97KtwmHix6/fiDngTOXwGc
	 8S7gia30cfdhytONlQpqU2uN3tqNIEPzF55Cgd693Q0uegwvAWER1FkAJbWBAs+ajfPH/
	 Gmsrj4+UEDuDcJA7bw5pW5J3aMGIKSLL6K/oh7hDCMt68Jmfe7V5ghDOh9+8ZSdIFmYsq
	 3D/LGJWOC1oaVWdlvNz+AMNbOG1773NVv1enBKkJVB8MXZQWCfIiER9fKCZodjS5ybw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DShG+a65;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD560A2604
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 22:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73CD560A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DShG+a65
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50aaad19fbso35048666b.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:10:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795126220; cv=none;
        d=google.com; s=arc-20260327;
        b=E/VKtl45A3jrPcOe/Csw0gSM/+O4h9521rwU4moS3Bt/6Fe1epbcJNU0zwehH9t9iE
         7ABm4/lRN25P68kpYJIDBCvf2ZQikQgXyNATeKmXNX7U+1lil6NFQkV0pHKBIvoxrez9
         If1+PT0+0IqstbtUBucDqTqSpgjZXzqKgTFXpxjxgiaYvO03Jw+nNPtwzwf3cYvh+uOj
         35NGmOfqxv7pINXS3Fn7xjploIUcVebkMo5S1qu0U5mbamh5tvrEQvMNGr0AarRBkUKt
         IvgRyX/8u4bgQNa5npDjLXZraPqJYqFNhoETPgM17I/Uvff+OayH9MNVX3q67t02H5HK
         1G/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DijvpPerg9iR/CBftr4FcI8/cFREAu6o0TdxhkUHjok=;
        fh=yfI3TdH8rsCfnOuz3CiZbqJsiHBNcFsZImPZxusz+bI=;
        b=B47mNGg38nZKR67R3/DS6LS+ZaGFwe4z2YMNTTMBuMcqgJ6Bnd4wfSI8h0BiUDhADh
         9G5QKqPThgPGhKycCYjlxYZNOpghnKACSKlCSYXBcna4rbgPIKNByjyf4GfynDBME3+e
         IRbzZJJW29vymZb4GRa7BMoFShNkz34cm1DgfQ4/xOWxDrLaFug/blPeulRm23GgXqJv
         bqVucHMs638Y5rvUZP0m9M7VbNUOJLW7KtSbyeSDXpyOIlV84ytlg6G3EW+PFyVY3hzO
         /xOQtiK++c8+ob6yS6XMw9R1ynEKESZLN6+08hn+iGPDwzU8xdUmw/dVTtI0zQ4vmhZs
         uqGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795126220; x=1795731020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DijvpPerg9iR/CBftr4FcI8/cFREAu6o0TdxhkUHjok=;
        b=DShG+a65W39S0v+W7EruwLr6fi4s8GmfkTCbS4tamuFicESHh5/9Fbl703tBu3ez2Z
         hQJo5BU/L0kNweltjQZlSee/AaZzW969ZgNLaqj3J2yxQtPDgRyt7c01W1hLff/DFLZT
         uQRStL4esExVOcKwaLEX8vTW5nlakZKP15tqtS0JkzSx7gcm6FFROKrny3FigD31ZNbJ
         22BsnGBXUTkK7Ud8gAH3sg47FnFIozAl818lotN5VkeFAYsP7jM6j74rNsJdha+X/Uvt
         DFWuY8Tg2gfozZjKJnPZIG5umPepS2il51CeefAxgAB4CoALYkuXO/q6TU/vlFFiNB8B
         TNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126220; x=1795731020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DijvpPerg9iR/CBftr4FcI8/cFREAu6o0TdxhkUHjok=;
        b=NORT2d9yEu4T877r3PrHkZ7v3ffcudyyOOJ2CRTHNe9Z4ObJwbB4rEH1ABMNzgVZj6
         YxLuhH0Ty4yYzFL1qCQkYfBZAbFq4WeybMdmC5VxX0TXUQ4YR/5iRdBpe5C51BAma7Ft
         1dllMW2kenOTczA9PM8kzgrhWm1s6QtoPDjNcBGDiySPhGcFD1iWjHFdPNUb2xXZcnrL
         hXKTOLJBuTDbe5JArMtkW5b2f0lSIHiBeja1y9+XPhTCseMW6kAGOBYCwc6TO1bkkU2i
         bofycSqwC3dcgdrPQEz06X32lMYl40uEBrArmZZKSGROIFkxSDl2xDHrvaQlXSgmoifv
         Kphg==
X-Forwarded-Encrypted: i=1; AL+hErHL01ylhRV5EAWMXF6CJKzuzingVRPkHT0zbM8GkdLMavbtVHXvn9VuXRZ29NsKX06Ci8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jJLOj46qLfplF93J9MLqk1MsLktQSyUCFxadk/V2kfH7ocMwP
	ogWrQQV9AHVSRLIZD2nehPqvnUKYZ2vbPAaA7edaVPLMywT4yNl/YfGpTe6K8FIzaKpDeNWt3gT
	Lr6zD6lx/OKOrm1hYTWyldxyR8sR8pfG5aj33wCtZ
X-Gm-Gg: AYBFou36j/hvGWRduhJDg04+kmxBh1K1qDSlDxEz6xHk/hL4i7SajWUGVE3E5lOZn8U
	/hOCUrnpvs01Qwq96H8LnjJuIJQgWqkZGwb5+Gt1yLV4G8RcDWDMsdjjPvP5chmh48ss2GmlBrP
	9wRid7RREn6UdlGXqDK/kbwl0tjUM2o8I/17jKhC/IazOKbwKTrSg0xe2jzhedI64h3akVoLL5D
	K7+7SSd0m7Z/fWTYTAxKnHbkgGio17bxse2kjcD8Kc102zc6t6IMPp44u9/PFJwOFE+8xt5yzbb
	XPNK0VyKKaqdFzTBbpthbXpRtUmQjbaSd2lRMYEy7tbRa7F0iZctFoifFHyQWfPs1vdo7k3+GaZ
	rJR0ZzkDyXIvMq5qPoIggtKjvcshQCc2H2MefOf8t4TKEsfRFZQnGrv4iJQNu7ZnS7xJj1R7p0e
	Kj9ijvjcAffA==
X-Received: by 2002:a17:907:6eaa:b0:c46:d837:b358 with SMTP id
 a640c23a62f3a-c513a4355afmr140130266b.3.1795126219406; Thu, 19 Nov 2026
 14:10:19 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117103352.1244657-1-david.laight.linux@gmail.com> <20261117103352.1244657-10-david.laight.linux@gmail.com>
In-Reply-To: <20261117103352.1244657-10-david.laight.linux@gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 19 Nov 2026 14:10:07 -0800
X-Gm-Features: AclHuK_Y-AU85AHxk1V46MundLPB4GZLjwueYOKYU_OtYwvOnJvbK7rB7xpyREo
Message-ID: <CAG2Kctr8-+4hV_D=yaQiH3K-k6ip6DwYdALqJbsp+0aLGxU4Zg@mail.gmail.com>
Subject: Re: [PATCH v4 next 09/13] kallsyms: Add a kernel parameter to change
 the kallsyms_markers[] density
To: David Laight <david.laight.linux@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Jim Cromie <jim.cromie@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:34=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> The density is a tradeoff between data size and execution speed.
> Reducing it from 256 to 64 gives a 35% improvement for name lookups.
>
> Change scripts/kallsyms to take the density from a --marker-shift command
> line parameter so that it can be build specific.
> Write the value used to the output file to ensure the kernel uses the
> correct value.
>
> The program's default is unchanged at 1 marker per 256 symbols,
> The kernel config defaults to 1 marker per 64 symbols.
> This increases the static data by a little less than 1 bit for every
> two symbols.
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>
> v3:
> - Previously patches 8 and 9
> v4:
> - Fix rounding of the size of 'markers' array.
>   Allocate oversize, and count the entries added.
>
>  init/Kconfig               | 19 ++++++++++++++
>  kernel/kallsyms.c          | 16 +++++------
>  kernel/kallsyms_internal.h |  1 +
>  scripts/kallsyms.c         | 54 ++++++++++++++++++++++++++------------
>  scripts/link-vmlinux.sh    |  6 +++++
>  5 files changed, 70 insertions(+), 26 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 4013781e0a02..b2db123a51d7 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1908,6 +1908,25 @@ config KALLSYMS
>           symbolic stack backtraces. This increases the size of the kerne=
l
>           somewhat, as all symbols have to be loaded into the kernel imag=
e.
>
> +config KALLSYMS_MARKER_SHIFT
> +       int "Interval between kallsyms markers (6 =3D> 64, 8 =3D> 256)"
> +       depends on KALLSYMS
> +       default 6
> +       range 0 24
> +       help
> +         Set the interval between the kallsyms marker entries as a power=
 of 2.
> +
> +         This bounds the linear search when locating the name of a symbo=
l
> +         from its index in the array of values (and v.v.).
> +
> +         Smaller values speed up the search but increase the memory foot=
print.
> +         Values below 5 (one 32 bit marker every 32 symbols) are unlikel=
y to
> +         make a significant difference because other parts of the code
> +         dominate.
> +
> +         The default of 6 is a reasonable compromise. It makes looking u=
p a
> +         symbol by name around 35% faster than setting it to 8.
> +
>  config KALLSYMS_SELFTEST
>         bool "Test the basic functions and performance of kallsyms"
>         depends on KALLSYMS
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index fd42a1a8ed3e..2c4264a3e0c5 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -147,13 +147,11 @@ static int kallsyms_strcmp_symbol(unsigned int off,=
 const char *name)
>  static unsigned int get_symbol_offset(unsigned long pos)
>  {
>         const u8 *name;
> -       int i, len;
> +       int len;
>
> -       /*
> -        * Use the closest marker we have. We have markers every 256 posi=
tions,
> -        * so that should be close enough.
> -        */
> -       name =3D &kallsyms_names[kallsyms_markers[pos >> 8]];
> +       /* Scan from the marker before the requested symbol number */
> +       name =3D &kallsyms_names[kallsyms_markers[pos >> kallsyms_marker_=
shift]];
> +       pos &=3D (1 << kallsyms_marker_shift) - 1;
>
>         /*
>          * Sequentially scan all the symbols up to the point we're search=
ing
> @@ -161,7 +159,7 @@ static unsigned int get_symbol_offset(unsigned long p=
os)
>          * so we just need to add the len to the current pointer for ever=
y
>          * symbol we wish to skip.
>          */
> -       for (i =3D 0; i < (pos & 0xFF); i++) {
> +       while (pos--) {
>                 len =3D *name;
>
>                 /*
> @@ -185,7 +183,7 @@ static unsigned long get_name_address(unsigned int na=
me_offset)
>         unsigned int low, pos, high;
>
>         low =3D 0;
> -       high =3D ((kallsyms_num_syms - 1) >> 8) + 1;
> +       high =3D ((kallsyms_num_syms - 1) >> kallsyms_marker_shift) + 1;
>
>         while (high - low > 1) {
>                 pos =3D low + (high - low) / 2;
> @@ -196,7 +194,7 @@ static unsigned long get_name_address(unsigned int na=
me_offset)
>         }
>
>         pos =3D kallsyms_markers[low];
> -       for (low <<=3D 8; pos < name_offset; low++) {
> +       for (low <<=3D kallsyms_marker_shift; pos < name_offset; low++) {
>                 unsigned int len =3D kallsyms_names[pos];
>                 if (len & 0x80)
>                         len +=3D (kallsyms_names[pos + 1] << 7) - 0x7f;
> diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
> index 11fb0de92ede..9137870ad00f 100644
> --- a/kernel/kallsyms_internal.h
> +++ b/kernel/kallsyms_internal.h
> @@ -12,6 +12,7 @@ extern const unsigned int kallsyms_num_syms;
>  extern const char kallsyms_token_table[];
>  extern const u16 kallsyms_token_index[];
>
> +extern const unsigned int kallsyms_marker_shift;
>  extern const unsigned int kallsyms_markers[];
>
>  /* Although constant, size is volatile for better code generation. */
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 39426f736cb7..f1c952a94e01 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -59,6 +59,8 @@ static unsigned int table_size, table_cnt;
>  static int all_symbols;
>  static int pc_relative;
>  static int verbose;
> +/* Default to one kallsyms_markers[] entry for each 256 symbols */
> +static unsigned long marker_shift =3D 8;
>
>  static int big_endian; /* Extracted from the elf file */
>
> @@ -410,7 +412,7 @@ static void write_src(void)
>  {
>         unsigned int i, k, len, off, off_size, table_size;
>         unsigned int best_idx[256];
> -       unsigned int *markers, markers_cnt;
> +       unsigned int *markers, markers_cnt, markers_mask;
>         unsigned long bin_offset =3D 0;
>         char buf[1 + KSYM_NAME_LEN];
>         struct sym_entry *se;
> @@ -446,9 +448,10 @@ static void write_src(void)
>         stamp("write token table");
>
>         /* table of offset markers, that give the offset in the compresse=
d stream
> -        * every 256 symbols */
> -       markers_cnt =3D (table_cnt + 255) / 256;
> -       markers =3D xmalloc(sizeof(*markers) * markers_cnt);
> +        * every (1 << marker_shift) (typically 64 or 256) symbols */
> +       markers =3D xmalloc(sizeof(*markers) * ((table_cnt >> marker_shif=
t) + 1));
> +       markers_cnt =3D 0;
> +       markers_mask =3D (1u << marker_shift) - 1;
>
>         output_label("kallsyms_names");
>         write_incbin_header("names", &bin_offset);
> @@ -481,14 +484,14 @@ static void write_src(void)
>                 }
>
>                 if (out_bin_file) {
> -                       if ((i & 0xFF) =3D=3D 0)
> -                               markers[i >> 8] =3D big_endian ? htobe32(=
off) : htole32(off);
> +                       if ((i & markers_mask) =3D=3D 0)
> +                               markers[markers_cnt++] =3D big_endian ? h=
tobe32(off) : htole32(off);
>
>                         fwrite(len, 1, len_len, out_bin_file);
>                         fwrite(se->sym, 1, se->len, out_bin_file);
>                 } else {
> -                       if ((i & 0xFF) =3D=3D 0)
> -                               markers[i >> 8] =3D off;
> +                       if ((i & markers_mask) =3D=3D 0)
> +                               markers[markers_cnt++] =3D off;
>
>                         printf("\t/* n:%u */\t.byte\t%u", off, len[0]);
>                         if (len_len =3D=3D 2)
> @@ -509,6 +512,10 @@ static void write_src(void)
>         printf(".size kallsyms_names, . - kallsyms_names\n");
>         printf("\n");
>
> +       output_label("kallsyms_marker_shift");
> +       printf("\t.long\t%lu\n" , marker_shift);
> +       printf("\n");
> +
>         output_label("kallsyms_markers");
>         if (out_bin_file) {
>                 write_incbin_header("markers", &bin_offset);
> @@ -930,6 +937,7 @@ static void usage(void)
>                 "Usage: kallsyms [options] [vmlinux [out.bin]] > out.S\n"
>                 "       kallsyms --sysmap vmlinux > out.map\n"
>                 "           --all-symbols     Include all local symbols\n=
"
> +               "           --marker-shift=3Dn  Interval between makers (=
6 =3D> 64, 8 =3D> 256)\n"
>                 "           --pc-relative     Output symbol offsets\n"
>                 "           --sysmap=3Dout.map  Text map file\n"
>                 "           --verbose         Extra diagnostic output\n"
> @@ -950,21 +958,33 @@ int main(int argc, char **argv)
>
>         while (1) {
>                 static const struct option long_options[] =3D {
> -                       {"all-symbols",     no_argument, &all_symbols,   =
  1},
> -                       {"pc-relative",     no_argument, &pc_relative,   =
  1},
> -                       {"sysmap",    optional_argument, NULL,           =
's'},
> -                       {"verbose",         no_argument, &verbose,       =
  1},
> +                       {"all-symbols",        no_argument, &all_symbols,=
     1},
> +                       {"marker-shift", required_argument, NULL,        =
   'm'},
> +                       {"pc-relative",        no_argument, &pc_relative,=
     1},
> +                       {"sysmap",       optional_argument, NULL,        =
   's'},
> +                       {"verbose",            no_argument, &verbose,    =
     1},
>                         {},
>                 };
>
> -               int c =3D getopt_long(argc, argv, "", long_options, NULL)=
;
> -
> -               if (c =3D=3D -1)
> +               switch (getopt_long(argc, argv, "", long_options, NULL)) =
{
> +               case -1:
>                         break;
> -               if (c =3D=3D 's')
> +               case 0:
> +                       continue;
> +               case 'm':
> +                       if (!optarg[0])
> +                               continue;
> +                       marker_shift =3D strtoul(optarg, NULL, 10);
> +                       if (marker_shift > 24)
> +                               usage();
> +                       continue;
> +               case 's':
>                         sysmap =3D optarg ?: "";
> -               else if (c !=3D 0)
> +                       continue;
> +               default:
>                         usage();
> +               }
> +               break;
>         }
>
>         stamp(NULL);
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 44b5a6d78ce5..61cf8f287ebe 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -37,6 +37,10 @@ is_enabled() {
>         grep -q "^$1=3Dy" include/config/auto.conf
>  }
>
> +value() {
> +       sed -n "/^$1=3D/{s///;p;q}" include/config/auto.conf
> +}
> +
>  # Nice output in kbuild format
>  # Will be suppressed by "make -s"
>  info()
> @@ -140,6 +144,8 @@ kallsyms()
>                 kallsymopt=3D"${kallsymopt} --pc-relative"
>         fi
>
> +       kallsymopt=3D"${kallsymopt} --marker-shift=3D$(value CONFIG_KALLS=
YMS_MARKER_SHIFT)"
> +
>         info KSYMS "${2}.S"
>         scripts/kallsyms ${kallsymopt} ${1:+"${1}" "${2}.bin"} > "${2}.S"
>
> --
> 2.39.5
>

Reviewed-by: Samuel Wu <wusamuel@google.com>
