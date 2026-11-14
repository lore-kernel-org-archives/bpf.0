Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794618131;
	b=Hh1ruza8ogfGZSEIza/IyEwSZw+p+JscHDUhu7Y9Z0hCs6aoRKfHFunzien0ll7ZuE3i
	 /vbl6GCBWzmI/rLiYJyZyTll6SiPjqcbTVDOcDFKMcRaTnEmRnl7oo2OMnWKAeEApM5Tq
	 0HkexX/b/7XgPHit/4vqQgknCvW4TS8PedTgct+Y6dJPuGHgctsq0dsh8ulumvVl8hxuE
	 1ihKpWeE6Hauos2/960kLZ/VbBb9TA5ero90UBf/qe3TasnNtO/ciBvYm1q4T1S6vfGmZ
	 ZA8h/9s8xI98IuI40PBzOlNsKIqC7+Z2UGOWGpHNDri0bffTXzPv1gElcEOXsr1r/Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/m5d7czP0+mAkTXvCBEQeqM+jQc19scZ/VuN8vwz6lk=;
	b=NtgzPyQV7yv3ieLzsg9o4XT1rydiP8N/ivJC/xDScNIvbcrlhqjFoJoui0KA/DykItNO
	 GxaIa5dKEKiTvSoUTawPmPMQwhgqcubJVQ8tPf1+D/mtpSTCp88DwWPOfg6fQse5r84pj
	 yyMlssREuAXhmDd3LMRqoCCpKGVpFN5IRNytV/9PMKRuwVkWh/4jjnZFnGB/ie3nukV0N
	 IMBwaoU0QmVLhHS2qcg2vCdAzEKG46BloS29ykAFd4ZLaiEKnPAfgJbRwv+9xAt/YWadX
	 hmzYiFGTO567IvEdKXWhDByhBYTXHmEEhKJdAL7NZeA3iBW7mDvAljk8TvfV8i1TSnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BU9q51b+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C585606A332
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 01:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C585606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BU9q51b+
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40f29667e6so344034866b.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794618129; cv=none;
        d=google.com; s=arc-20260327;
        b=PvUqACvd3IQ0KCkApCVizEHO9+8pccIYY2B6n+hvJW4CihrSSwH24SExl1Y2zZU0kB
         Cteqwkni/c45bmRHrrkbi/YfjbbDma+QSXXJgKgVICA/UWWrYnawKg2LrK/e2Y2p4+VC
         GKQKaz3ZyXzQHoa9P/kKam397wpIlnSvUOC/E8htL9m8zchEYbxgTBiEcK2Ps2cUXdZQ
         D1j4apLYXNk0WLi49p/sYp3g+06E53lTbbFNwq+JVlxZsWuCa57++mnRljC5dZgR3Z8e
         d7tyuF25fhWEDDGPkYhe5t+AIPDGYt05S6CPBub06+4V8VZ2JqFur8ShTXeSR71pMLYj
         qQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/m5d7czP0+mAkTXvCBEQeqM+jQc19scZ/VuN8vwz6lk=;
        fh=bDa2c4Mv8kNYipQ3NXFZSDUkJCNBCRU8c5PeLJN54XQ=;
        b=i+iSiLAJho8e/AULyPIWyRAUHKKMVu0Yvtu/ZOqQtHbD87MbJH4Rns7BC9q/hWi3Ft
         AZQ2T2R5qGOTdNwoSkSszaojGkUdR4b6jW9rZNVVbW6/bd32uMcHopLZ3Bf93uajs+zp
         GOKP9wuDPc1kHWmrd8TUf4CGxQgtMsyGgaE+h86fhKIEnk+9aHjuC/CrbkLAhmOxam08
         ID35Lot4AC3RkHvo4rTv1GnMfyB7G9zlHmnlkMTGkEBrhG+cGJWtW/ynjsgKYeUvzZju
         nqh5CkLLkkkTWBNjpMR/fRUou5geyAJgUX4VphLDv8bnq7hq901atibTvMW3Z/MlK5u7
         MX/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794618129; x=1795222929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/m5d7czP0+mAkTXvCBEQeqM+jQc19scZ/VuN8vwz6lk=;
        b=BU9q51b+qIJpzYDPk22/yVpWZX81by8BeuEdqZRj3hJsh1Uf/rZxAT1JLa3NOnUvZJ
         B0B8kgEH5e/8oYq9DXLRNPRbdUqR5nb5RBJa9XPJvkMYd/iUttJpM+hChgj7Rb3nJJm0
         LroCX4V5KWRDi0i9ulgdRMnGoaIMIyWTCb/21zBqu7amw6T3lcIPV6a8ATgEI6ekuSW7
         AeB0haBR2KP1f55/asA5+4kVtwjNfrez12ghsELF+Maq4RytNFl14DC3rdyj8ZmbmFZC
         y5VlNo58HqUjZjqTnPApbbowg90CpsZEG8fQ+MC7XEAlujK94GCAt5WbKlYlsQ3IadmU
         GgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794618129; x=1795222929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/m5d7czP0+mAkTXvCBEQeqM+jQc19scZ/VuN8vwz6lk=;
        b=aDPY7hWhOeiliZ39kbledRMpu0b6D1grXkpPTxtR7hJnwoc9fkgFR1VAFWAgMMUFfJ
         M1HUCjsk4G20n/d02sUTHQbrz11C0moL3iqGzcEERzlfFeYZKD4n8XJlQtxYbWtOTzxy
         9Vns23PCspWOCury2HCd+Ighg+My4BAFe253BFJ1LpU9ct/qevdAk4G+GQMTt5ZfrnKq
         V+w9Zova3PEHkCbLFuKsYiSbh38cmRTbbmRUCa78UtByWegYzXnyHDYJ/VmROR7DImMH
         RxY6/viSYTnGftd4tLc5SX7AWzFWR5qgrMzapvUujDg8XcPEbVhPHIl3WqLaS82qNpsM
         QQOA==
X-Forwarded-Encrypted: i=1; AL+hErG6i1xmkUlLF+MhbfKEUUPxki/e7KAXUqNV4PZHFgEl8O5uLxMYRD90MdJbwMMrpSTdWuI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8UzeHlWQ6RM7um7DHIJRZ5Pci4ifivY6Ow+GK1xPWhCSQ0HfA
	4Kz69+9DTEnu3xXcij+qQsmEw2Ny/rFmNXVGr219Pw/YULfb/65rQDeSa1BgpdLrxOImQ4tBkR8
	KgqBw/ANJ049jaETouWDRyKs6mFDNWyO4HaT87XMO
X-Gm-Gg: AYBFou3KutBSqTuF5TEgVo3/PBbcYF25MhFQQuLS3Z4ODTCmpg8v7GniHtcFhINOctH
	U8XwzmkXYg/siGyKnGSsBv4nY3cf6TD/PXXPIvXSxnwUnOZ3gnqpXnWDl+QFc2eKvMi4/yahG+H
	m7ysaNqVGW70nhksgCVgHKty+v/EFenppeohPgAM4HUBMQ566CopEDpF2+URyyA8Ahw6xM8BwuB
	Sc3fTsGOzicHkYrrWXHmkx1TS4O5KbI/vpMLrX3kasx6dRFqb3WMISRlaXR3ojcsI5NCnxQxijx
	BLor8EgVgkm3Lwo8n1DVV98aukxuLOqyny0rv+UgSc7xk3g1ier081i3Z4CWXV0HpwOEoBjmj74
	/A1r+ff20g74u0CJIhY+8UgFUc99oYDKiMr5sjKLQt9DYAsPuoE0lwE87xJC0UNy4z1HXOg==
X-Received: by 2002:a17:907:72c8:b0:c2d:c98f:4824 with SMTP id
 a640c23a62f3a-c509640e213mr344745266b.30.1794618128439; Fri, 13 Nov 2026
 17:02:08 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111115911.1142000-1-david.laight.linux@gmail.com> <20261111115911.1142000-10-david.laight.linux@gmail.com>
In-Reply-To: <20261111115911.1142000-10-david.laight.linux@gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 13 Nov 2026 17:01:56 -0800
X-Gm-Features: AclHuK92ZDtDkLGXySEyJcsPwdTi7Im-tlh3FuOteUS-nzQ2KxAv8LMSfv9gpak
Message-ID: <CAG2KctruqvRDU46Q58Sk3Bkr=i1yuhs8znqgWWP65ZydBnT+Hw@mail.gmail.com>
Subject: Re: [PATCH v3 next 09/13] kallsyms: Add a kernel parameter to change
 the kallsyms_markers[] density
To: David Laight <david.laight.linux@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Jim Cromie <jim.cromie@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 3:59=E2=80=AFAM David Laight
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
> v3: Previously patches 8 and 9
>
>  init/Kconfig               | 19 +++++++++++++++
>  kernel/kallsyms.c          | 16 ++++++-------
>  kernel/kallsyms_internal.h |  1 +
>  scripts/kallsyms.c         | 49 ++++++++++++++++++++++++++------------
>  scripts/link-vmlinux.sh    |  6 +++++
>  5 files changed, 67 insertions(+), 24 deletions(-)
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
> index 930ec27a53c0..c27aaabccd1b 100644
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
> @@ -441,8 +443,8 @@ static void write_src(void)
>         stamp("write token table");
>
>         /* table of offset markers, that give the offset in the compresse=
d stream
> -        * every 256 symbols */
> -       markers_cnt =3D (table_cnt + 255) / 256;
> +        * every (1 << marker_shift) (typically 64 or 256) symbols */
> +       markers_cnt =3D (table_cnt + 255) >> marker_shift;

Should be (table_cnt + (1 << marker_shift) - 1) >> marker_shift.

Otherwise, looks good to me!

>         markers =3D xmalloc(sizeof(*markers) * markers_cnt);
>
>         output_label("kallsyms_names");
> @@ -476,14 +478,14 @@ static void write_src(void)
>                 }
>
>                 if (out_bin_file) {
> -                       if ((i & 0xFF) =3D=3D 0)
> -                               markers[i >> 8] =3D big_endian ? htobe32(=
off) : htole32(off);
> +                       if ((i & ((1u << marker_shift) - 1)) =3D=3D 0)
> +                               markers[i >> marker_shift] =3D big_endian=
 ? htobe32(off) : htole32(off);
>
>                         fwrite(len, 1, len_len, out_bin_file);
>                         fwrite(se->sym, 1, se->len, out_bin_file);
>                 } else {
> -                       if ((i & 0xFF) =3D=3D 0)
> -                               markers[i >> 8] =3D off;
> +                       if ((i & ((1u << marker_shift) - 1)) =3D=3D 0)
> +                               markers[i >> marker_shift] =3D off;
>
>                         printf("\t/* n:%u */\t.byte\t%u", off, len[0]);
>                         if (len_len =3D=3D 2)
> @@ -504,6 +506,10 @@ static void write_src(void)
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
> @@ -926,6 +932,7 @@ static void usage(void)
>                 "Usage: kallsyms [options] [vmlinux [out.bin]] > out.S\n"
>                 "       kallsyms --sysmap vmlinux > out.map\n"
>                 "           --all-symbols     Include all local symbols\n=
"
> +               "           --marker-shift=3Dn  Interval between makers (=
6 =3D> 64, 8 =3D> 256)\n"
>                 "           --pc-relative     Output symbol offsets\n"
>                 "           --sysmap=3Dout.map  Text map file\n"
>                 "           --verbose         Extra diagnostic output\n"
> @@ -946,21 +953,33 @@ int main(int argc, char **argv)
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
