Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794613158;
	b=nJ+O4gjGNfP7WPsBptNOnKggvmLh8m/bFMMN/3Ftsv+hOdN4zxmE6zeHO0yvvRSQ5dBn
	 9CsUxvSw0G/QDaXGFhNtgWE/bIu4ncItx8aa4645BhqPsc2tFIVLmI973SfMfyN7BS4Uo
	 Z3MaZE+j7/85nwOvlS36NoFhQy7ssEsblTmBz6n6huaJNJBhvLJ4zrmAGVtjRzFDXGpoG
	 4baGgkgPE6Nn9r9hSwzLEMt5lNyZPhe0ZrSIjYXofDrmDQF0N4rGH50kMesYNafrz3Now
	 vMq2VUba4bdT09fdNg4Xh9RLa2+rWpzMJO5iMxVMS2daFf9d/gZm9QmUKEiNiprCYkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=G+DCRJoT2rSliFioAt8IfNe8mKn1BXSOz5GwRKF6mJU=;
	b=J5585PKJEHa6h5kXgIWsX9ExJt9sf8PoviR4JM/y18azNmOwe4BxgmRoWm47GV9k3y97
	 lP8jFeo3oMXJNlnh9iCEz0Wh5s7NN0+QJvtNJh+waZz2L0xXpzLry9KxsanXP7HZcn3td
	 qi3sckLmZOLYl+VkwVcayWlu2AYwWkYKgJMC3G8E2IFLamOAbeWBgaWiGqnEB8KdntEO+
	 ORvKdXfczNWeGizHj3Y23+yPl+SvEe3hKgJ6V0P5h75BjCM1u8XiK8RyUQE2lpp47Cgen
	 WKURsrEBKeF88A1Zz8ml0GID5NPzqf7PjotGBAIgoFdtnq7jEjj7PictxSgxSqYmScQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GKzdNCOt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332A606A332
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8332A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GKzdNCOt
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c45551fa84eso378411966b.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:39:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794613156; cv=none;
        d=google.com; s=arc-20260327;
        b=MMk+C52pBrYn170RHqSAQqvvVmSVh4aSl+ox6zxV6w5H1DjSKwgXTEPBqSqzciCG5R
         AVL4vPkivDKS9uCNmMEKVMqQtNz0eknc+LDVK8+++sJn1ED2mQUrJ/FYlX79qrOPR1zZ
         Fc1d6FlBrFh1alYxtxT9fQ6C+wwmlbCtsCXlfwTPJiKYvWzLLkGuU2ZkLoMSV0ALKWTu
         P84tS+p6EUCvZmrit583XKa1Wab4PHlEjvNOB03YA3G2A5bfNBvnvV0ea51/X9Ntl0QC
         sWyh2JwVzr8EJZJD6wyIbtmXWGW+7ZCaKP1JnHwUCEgODuhXFf8l7b9EX5n8kDB4RFND
         dKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G+DCRJoT2rSliFioAt8IfNe8mKn1BXSOz5GwRKF6mJU=;
        fh=pst/CEnB9IxKBcT1daasgYJmQPjRBlyV+2GSuKnkRQc=;
        b=BGOV5SBf1Vr7PqMwHoh2V/MvBCJ9RRgBBJXAAml8p1FiTOQNKketRxruWnRzY7qtD2
         U2lFPd4lXCyux/BZtXrsYnMsVs6NpnAYBaUD4DUTvcWuu6Dnsl8oReS2Fj50324T/zOw
         i2mHXffEP2iPJP8vwoyKqx5CdgvElisb+7ieoEzTi1MeXtvKDtzmBFEeWULVFvqNQ/Tm
         CjqM9nb0ruqHymfdH+L2VXpoJRgXNjsm1xLDRBxj8XoxCbfxjv03JNq8MvZayYu2T4la
         MgrvyvZ67IZCFreEDY3b1iTFwr6QFyiccUiIdag5eU3sdBHWLEbaKu/d/JB0qbXsT3AY
         Kxvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794613156; x=1795217956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G+DCRJoT2rSliFioAt8IfNe8mKn1BXSOz5GwRKF6mJU=;
        b=GKzdNCOtJPWkmyv8qLZ34TzvbJvMPkkuwQ9UvVoZ21zjdb0FqwQhKM19IEGvUoo9W1
         Aj0T2H4f3wWnAANVH/2wksXyuPuCElCiaQzAcfMMCA2CE7R21PAYI5eaGUk4nXlybp/Y
         WQoltLRy+v3nyRbE7yS4h1P/8zdonuUzN7T+6NHhGSSsTp9dmQEqodS8X5/KicoYVWaI
         NWOVq+eW3ahIqbrMTNlgsW/4LmyafL0i4AdGbirhPODewVw75HkPpbRaBaPQ4jq6Ut6L
         CpzPj/fXvGuQlcyswF/lAdnhi+lWiwB+sCkEW2qHz601p5dWM+KZTdXJMdzJ+xahS1OR
         UWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613156; x=1795217956;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+DCRJoT2rSliFioAt8IfNe8mKn1BXSOz5GwRKF6mJU=;
        b=wD3HgQFXEW02eNciOEhqxrNV68ZkzYZFwIvTqQblKLMQbWBPUNZLJk10cWIdJHJYO/
         Y2dI/uIp4PcFNa2VpI7ueIc6airOFP9yj/Fpj0SJWXctBT+Eb4ac9svBCdMWNeizOn4c
         yZymM1awfKIb0zPp63FOkuH35op652Gl0fqy2K4QeiFLXM2qk20s7WWuZtfpcjIz6hb+
         hxC2ZQlt89rrgBwsLg51rAaVHcb9d5MCwNKVpt3+rD55oX6CWmsfXgDSsgK6mvPZ5PqY
         mK3KHy+017Mtcsb6JeMMEMJ9k46/3rhvyThGS3CcR++SQpJH4QNqaGqO2Elma93WvCNg
         tRLg==
X-Forwarded-Encrypted: i=1; AL+hErHZqgn6SphODslZ3jNsxPYgMCKqQsUT3T7Cofjl3BhaHVA8tebsZYd3XgHuGaNqtiqkrNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V5ohO4VhOq0GlOWR+B8RlJvDeLCXfdDA11+iJMSJMqe0KWx1q
	coRVEikvD9tiHKs1Ww1hSPZpEYnlGvT94kmaHxl12dkMJldkRrUjo9QEofE48H1U71Kcj2QC3fG
	WvxF1BsVIcaCCWYPP9QNfqrTWOKh5wK3Qh1GK/CUH
X-Gm-Gg: AYBFou3iYIi1pbWVamlncor1RryL/bc2NWqwqJSUBNQHfVYUL4PHCkdp0JHMJcmWrGU
	DQDHMYSkJ8Rrq9mOR2kKGchhU6GKwvogaOGAt9y40w9hHj6ISTmNGWNHaL9FA3xpTyCExuuQsL0
	P2P0XOe9qutStIV3fgybMZ3sxc6Ldz+rxBKwd7pKnRCkpeRQK1u0DbF+9IiVUXfn2OLDIW+6iV+
	Do75EQxdJ1jZi8QPLGzNWsWv3YoH0XM+Wd87GFMyHZ2kPwE7n6tz7XnWKIHeTLEnKY+tYtl18fC
	AwBEwHHdoW10hHHHVFl8DHqJA4LZIyxUElPMLTgZzSZrmHcXeKXrfBb7Q5FL7MHG9JV8ZDxM4rR
	frRDQ+gAQRiKzFkKR7lzSDji56VLr52XSP28W898D75aADpbSgO7iznK1gC7I5Ao6ufZoOGw=
X-Received: by 2002:a17:907:72c8:b0:c2d:c98f:4824 with SMTP id
 a640c23a62f3a-c509640e213mr336302366b.30.1794613155422; Fri, 13 Nov 2026
 15:39:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111115911.1142000-1-david.laight.linux@gmail.com> <20261111115911.1142000-8-david.laight.linux@gmail.com>
In-Reply-To: <20261111115911.1142000-8-david.laight.linux@gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 13 Nov 2026 15:39:04 -0800
X-Gm-Features: AclHuK_-P0g2E85AlmiELg2QyC94n8audd5zwRdk4oJx2ijztAtCokHN_9_OxYI
Message-ID: <CAG2KctoB6BudtFRS6AgpBKjSd7oFrtMSU4JmF_WECmArB4GCvA@mail.gmail.com>
Subject: Re: [PATCH v3 next 07/13] kallsyms: Match compressed tokens on the
 fly during binary search
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
> From: Jim Cromie <jim.cromie@gmail.com>
>
> kallsyms_lookup_names() runs a binary search across ~184k tokenized
> (compressed) symbols.  For each of the ~17 comparisons in the search, it
> currently decompresses the candidate symbol into a temporary buffer on
> the stack before calling strcmp().
>
> Comparing tokenized symbols directly in compressed space is
> impossible.  The BPE token table assigns values by frequency, not
> alphabetical order (e.g. token 0x05 might expand to "zebra" while 0x42
> expands to "apple"), so comparing raw token values scrambles
> lexicographical order.  Even sorting the token table alphabetically
> wouldn't help; "bpf_" and "bpf_foo_" do not *have* a determinative
> sorting order, because the suffixes following those tokens would
> matter.
>
> However, full string expansion at every step is equally wasteful: of
> the ~17 strcmps in the binary search, only the last needs to check
> all N chars in both strings, earlier steps will know +/- outcome at
> char 0,1,2..N-1.
>
> However, full string expansion at every step is equally wasteful: of
> the ~17 strcmp()s in the binary search, only the final matching step
> needs to test all characters.  Earlier non-matching steps diverge at
> the first differing character (0..N-1), but the baseline expands every
> candidate symbol to the stack unconditionally, before comparing.
>
> So we introduce kallsyms_strcmp_symbol() to compare ASCII search_name
> against tokenized symbols on the fly.  Like strcmp, it tests the
> strings char by char, but when it hits a token in the symbol-string,
> it continues the char-test against that token-string, which is in
> kallsyms_token_table[].  It returns +- on 1st mismatch.
>
> Measured across all ~184k symbols via CONFIG_KALLSYMS_SELFTEST, this
> shaves ~530 ns (~14%) off average kallsyms_lookup_name() latency (from
> ~3810 ns to ~3280 ns on the default 256:1 baseline) and drops the
> 512-byte namebuf buffer stack-alloc in kallsyms_lookup_names().
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>
> Unchanged from Jim's patch.
> I think this is the latest version of it, but any later changes
> shouldn't cause problems.
>
>  kernel/kallsyms.c | 94 +++++++++++++++++++++++++++++------------------
>  1 file changed, 59 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index aec2f06858af..d18d78e626db 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -34,6 +34,21 @@
>
>  #include "kallsyms_internal.h"
>
> +/*
> + * Get the compressed symbol length and data pointer.
> + */
> +static inline const u8 *get_symbol_data(unsigned int off, unsigned int *=
len)
> +{
> +       const u8 *p =3D &kallsyms_names[off];
> +       unsigned int l =3D *p++;
> +
> +       if (unlikely(l & 0x80))
> +               l =3D (l & 0x7F) | (*p++ << 7);
> +       *len =3D l;
> +
> +       return p;
> +}
> +
>  /*
>   * Expand a compressed symbol data into the resulting uncompressed strin=
g,
>   * if uncompressed string is too long (>=3D maxlen), it will be truncate=
d,
> @@ -42,28 +57,12 @@
>  static unsigned int kallsyms_expand_symbol(unsigned int off,
>                                            char *result, size_t maxlen)
>  {
> -       int len, skipped_first =3D 0;
> +       int skipped_first =3D 0;
>         const char *tptr;
> -       const u8 *data;
> +       unsigned int len;
> +       const u8 *data =3D get_symbol_data(off, &len);
>
> -       /* Get the compressed symbol length from the first symbol byte. *=
/
> -       data =3D &kallsyms_names[off];
> -       len =3D *data;
> -       data++;
> -       off++;
> -
> -       /* If MSB is 1, it is a "big" symbol, so needs an additional byte=
. */
> -       if ((len & 0x80) !=3D 0) {
> -               len =3D (len & 0x7F) | (*data << 7);
> -               data++;
> -               off++;
> -       }
> -
> -       /*
> -        * Update the offset to return the offset for the next symbol on
> -        * the compressed stream.
> -        */
> -       off +=3D len;
> +       off =3D (data - kallsyms_names) + len;
>
>         /*
>          * For every byte on the compressed symbol data, copy the table
> @@ -101,14 +100,43 @@ static unsigned int kallsyms_expand_symbol(unsigned=
 int off,
>   */
>  static char kallsyms_get_symbol_type(unsigned int off)
>  {
> -       /*
> -        * Get just the first code, look it up in the token table,
> -        * and return the first char from this token. If MSB of length
> -        * is 1, it is a "big" symbol, so needs an additional byte.
> -        */
> -       if (kallsyms_names[off] & 0x80)
> -               off++;
> -       return kallsyms_token_table[kallsyms_token_index[kallsyms_names[o=
ff + 1]]];
> +       unsigned int len;
> +       const u8 *data =3D get_symbol_data(off, &len);
> +
> +       return kallsyms_token_table[kallsyms_token_index[*data]];
> +}
> +
> +/*
> + * Compare an uncompressed ASCII string against a compressed symbol tabl=
e entry.
> + * Returns negative if name < sym, positive if name > sym, 0 if equal.
> + * Exits immediately on the first mismatched character without decompres=
sing
> + * the rest of the symbol name.
> + */
> +static int kallsyms_strcmp_symbol(unsigned int off, const char *name)
> +{
> +       const char *tptr;
> +       unsigned int len;
> +       const u8 *data =3D get_symbol_data(off, &len);
> +
> +       tptr =3D &kallsyms_token_table[kallsyms_token_index[*data++]] + 1=
;
> +       while (*tptr) {
> +               int diff =3D (unsigned char)*name++ - (unsigned char)*tpt=
r++;
> +
> +               if (diff)
> +                       return diff;
> +       }
> +
> +       while (--len) {
> +               tptr =3D &kallsyms_token_table[kallsyms_token_index[*data=
++]];
> +               do {
> +                       int diff =3D (unsigned char)*name++ - (unsigned c=
har)*tptr++;
> +
> +                       if (diff)
> +                               return diff;
> +               } while (*tptr);
> +       }
> +
> +       return (unsigned char)*name;
>  }
>
>
> @@ -174,7 +202,6 @@ static int kallsyms_lookup_names(const char *name,
>         int ret;
>         int low, mid, high;
>         unsigned int seq, off;
> -       char namebuf[KSYM_NAME_LEN];
>
>         low =3D 0;
>         high =3D kallsyms_num_syms - 1;
> @@ -183,8 +210,7 @@ static int kallsyms_lookup_names(const char *name,
>                 mid =3D low + (high - low) / 2;
>                 seq =3D get_symbol_seq(mid);
>                 off =3D get_symbol_offset(seq);
> -               kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf))=
;
> -               ret =3D strcmp(name, namebuf);
> +               ret =3D kallsyms_strcmp_symbol(off, name);
>                 if (ret > 0)
>                         low =3D mid + 1;
>                 else if (ret < 0)
> @@ -200,8 +226,7 @@ static int kallsyms_lookup_names(const char *name,
>         while (low) {
>                 seq =3D get_symbol_seq(low - 1);
>                 off =3D get_symbol_offset(seq);
> -               kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf))=
;
> -               if (strcmp(name, namebuf))
> +               if (kallsyms_strcmp_symbol(off, name) !=3D 0)
>                         break;
>                 low--;
>         }
> @@ -212,8 +237,7 @@ static int kallsyms_lookup_names(const char *name,
>                 while (high < kallsyms_num_syms - 1) {
>                         seq =3D get_symbol_seq(high + 1);
>                         off =3D get_symbol_offset(seq);
> -                       kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(n=
amebuf));
> -                       if (strcmp(name, namebuf))
> +                       if (kallsyms_strcmp_symbol(off, name) !=3D 0)
>                                 break;
>                         high++;
>                 }
> --
> 2.39.5
>

Reviewed-by: Samuel Wu <wusamuel@google.com>
