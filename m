Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793917012;
	b=v98Rvi1yG9rFbQNn9F2sdyH9sJM37mHGLc9qEc+cQzlFmGd8Bf/pIJHu7z1VqsEFvRuV
	 2UfUd+YLEP6JsilLOCUx56KZ2q9yyPIW3iGMKWOEIRSMErDPa6/vwZ4crq2cc0Qu6T8im
	 GB6c5gikM5hzky8hU197ue++dQYcF7aTc9AO1vpQ7iwbw50aUXVKyJAWJ8H9lLXxGVgmD
	 e6i4CPEsBzvDbWJ64nM2pmxsHi+U5lLdc42iXeEXMrTNShXu0rpuTQMbiJ10TUUrDG8I9
	 /MXszPSjGlsO6/7nx8/Jfe+g+qQ+F1QZ/PmjdPBZpgp7db+jvQRobt8bvUwUo7V45Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YdY2Yydwpq3i9bcvlxMcQCy5kCBYOaA+wcZKGjqCwqo=;
	b=2P13NlStJL2JwooVgmdbD3QEnPL2WrYAxLVOXE+gLnL1R4unBgBXykIZeKZztrYl2/6c
	 ORD+7NgDtk6PBCxan67LcAZsN44il/+j2JHM3yiV3KQoCLiKtX2gZoqf5unoQxyRLqGLp
	 1OqXhVWEH/imJ6Y0hwJd8dZKJUhpDiesVTb48nkEFiRmK6M9uuOdiZXSDu20s8qLDQegg
	 bJ84P8q31o55liD8dbxX7gpeNmRotZ5y7OILF5VxIrjp2G4HtaoW8I5QN1dapHRDRVBiR
	 tksAOO8oIlXU5/CIipEnCfDr6GEDDBiIdYH/4zS12szxsWrm/2j6O/qTbP1VVvpqdfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iP9BgBAa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B9606A32C
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 221B9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iP9BgBAa
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso14174995ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 14:16:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793917011; cv=none;
        d=google.com; s=arc-20260327;
        b=iBUfiz4oCTEWwNAtg2q//iP/h9YYrfu2MXev2aUWvU1fwZfKclaZIeDaxb2qghPhmU
         hICSG8s1iGZk2qS+EN5BasRWrlGFnCzCd3VOMYlPK2zCOKE4tLEfjk8pJQtO5y9v3I29
         SAw7ESsrCc/+xHUVocWp79H64SOpRRLF54KRujclkLhmWVt0CtfE0iuGewtUmBbp2Ga8
         Hjl5QM1LIrijcRAGk4Xnr/9573X9MUME84eaIS81a7jHBqP0AWrkYYOMmHWsvO+9epxo
         VyDvYeYZTl40XiVhCNuRx1wkHHxbQBp2xNRudMT98fUhvEtEqmmt+8sYoDrLctv3oKv4
         6a0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdY2Yydwpq3i9bcvlxMcQCy5kCBYOaA+wcZKGjqCwqo=;
        fh=cEZxJ00OZkx7ABOpyxBfqRrfMz87d+9w2xJBPyewiNc=;
        b=Ewy/55VDGgBnyjPLETqVn0ltAXXrRR7WYhqE0snkfFeZJTguRdMUaKU6iZQbDpcszV
         gSRwEkoTC7QcDCv1VAuTWl4PDm19htf1i8QMvcNWj1TL9/+4D7HXdem+x80X4/Qg88XC
         5TLU1hAZjVwEPzla0IoGoeh6Gk7bM5U1WbPSSwBpTRQ/XDqHiE9zfh6kXBA9A40lPbaO
         DcgiSmWUem+PJTIRUis8DkMpkSuCOr+pR0Ss+XPvw0TzJfE780wrlgTSMKGAFzkOKCoP
         WsCKuiQm0KX86iwXsbAOtpOEWR14y7h/p5a1owBQhDEOL2zk1Of3Rl5KIKioNi2GUOx+
         +J5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917011; x=1794521811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YdY2Yydwpq3i9bcvlxMcQCy5kCBYOaA+wcZKGjqCwqo=;
        b=iP9BgBAaZ+4A+3RimSD9ZonOApr8s4gWmYWTaABf/aDdyfTq8bRD2jcxwy7ugyBGhj
         KiltjQF+2poLmDHsSb98LsTJA2j25xqN/YKk8wL5KNfTpCuwsuUCXvsw5XVRCINuSS87
         9Fe/uVAtkXQWuxBGlwUR7w5pOKMvt6sUtwZ0/XTEZH4RXCvj1eaGVWk6nVdOQISu8eAs
         a3qUFOlDzQ32mSsKtYeSLRebVLyGj5dYoTFgvRqT71GMNu/pvBWVp1ufljtIfOxyhAvY
         D6w9HDHlVw2G2SbkTjq5/jHBgHtc1aFqrZrAUwWg/9N7QCTa6tfm8piShp6wY/d4n3D0
         MMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917011; x=1794521811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdY2Yydwpq3i9bcvlxMcQCy5kCBYOaA+wcZKGjqCwqo=;
        b=rBle+z6cs2/UY67AA+jCTxa1V3bHEf2uvzeSFoK7DxjSVv7f6MZ8aidNpAP/6hZgWX
         lW+1xIRpEXivTCalL2RLqzMuzpRXyRkg5/9+9yfJtEBhZJoWSBFn0g/cUqMq1C9Lg9YK
         ERyVcy3e0kboGeGh6o4lJXY9XHvkbCmITllD2dhrNjeUlhlBYRK2xEQbx1aq50kofEKO
         S4iIiOQvni1zyYFZP+3RLGdcRi4iLPyHUMBNI5zqkufZw2rXPLuXBJjzsE6H7yKmyH0W
         hdAwkNG9H8FjpBsvM76odo357VWJSBN0ib3rRyBZAWugWyOypdB+SgliZbrH0g7HuTn4
         R9YQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCfUq01ACWuuRyAI/rGqKXrahGysY7zZCPfzQlre35RYf5Pyqix7lR/bXEBTy/gTWLezU=@vger.kernel.org
X-Gm-Message-State: APuU4Z92+j7xcVvQJLQpb65a0UXgw/QBCBd1RPs2+M8fu5gHIyjRLtJb
	VD4A7WhkzasG/7XweIu4wBkXjZv+92vR3k0lRAsHeei99dZA6Dbi474ym0S2ygTLUGcI8lmz2RH
	rQZvdlXCnwwmgzp+DqmcEthYy/8RKB80=
X-Gm-Gg: AYBFou1gEpDe4+gMuqBVj+1eUwQzhD0mgSh796JVjUE7148xg2N0xKvsH9qvABRRz1J
	ZAURmMtUPe7d+lPQr44a/S3s0NCyj1WwyuzK9oJqJHAJUmq05Zl4opybIwiqGKpVvkgL+9o/J2V
	GEdOdoid6cxwwokSjj0ZRl/BtxoXmVPae5K6NHlLtRK+LALLxW+mAxiv4hPQ0DuyK6iJ9bHSRbr
	WPHuA1mK88F+Colsvd8x+QASbMwdj3TxSFVY63NNEqd0tjq8Lmn8TuAl0ZvOd06J3YrIhixTGvF
	Cajs6lERpnvbkAfgLGQcgS+ybozJaXVYx4t3GZ8nBFeuR4MTPy0nrASCoAPhDlWxuT9sONLDFMp
	INOIKbBmC+UhV4fOqKr8tgm7tShckGkGThklqJC9C8kzDkV54v+X+evTWnnrzgnajyaeNhtPSba
	rjATVhX3cHm/x1yD2AZjzZsrRLEnD68uxJKg==
X-Received: by 2002:a17:902:f605:b0:2e9:a090:dd69 with SMTP id
 d9443c01a7336-2ed40dbd792mr10719095ad.39.1793917011326; Thu, 05 Nov 2026
 14:16:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101103221.51534-1-dennylin0707@gmail.com> <20261101103221.51534-2-dennylin0707@gmail.com>
In-Reply-To: <20261101103221.51534-2-dennylin0707@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 14:16:39 -0800
X-Gm-Features: AclHuK8Q4YahT7MssTrhujdgEAS5UbVDPCCKhtVvtn_dsDLqpOo6lwdZkjFPtNA
Message-ID: <CAEf4Bza9Q5AyzdybDwdQzAJKUJujAb_c7jtSAg=dpOPVWXo_uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: Normalize enum values according
 to signedness
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, qmo@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, eddyz87@gmail.com, 
	ihor.solodrai@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 2:32=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com> =
wrote:
>
> BTF_KIND_ENUM stores enumerators in a signed 32-bit field even for
> unsigned enums. btf_dump_enum_data() compares unsigned data against that
> signed field, so values with bit 31 set fail to match their names.
> get_map_field_long() also sign-extends the field: for example,
> __ulong(map_extra, 0x80000000) becomes 0xffffffff80000000 instead of the
> requested arena mapping address.
>
> Add btf_enum_value() to extend an enumerator according to kflag and use
> it in both places.
>
> For data dumps, keep the original comparison as well. Older BTF producers
> did not record enum signedness; an eight-byte BTF_KIND_ENUM can contain
> signed data such as -1 with kflag clear. Using only the helper would lose
> an existing name match. This compatibility comparison does not truncate
> the data value or change the numeric fallback.
>
> For an eight-byte BTF_KIND_ENUM with kflag clear, a negative stored
> enumerator can therefore match both its sign- and zero-extended values.
> The record cannot distinguish legacy signed metadata from unsigned
> metadata with the same bits.
>
> Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
> Fixes: d147357e2e59 ("libbpf: Allow specifying 64-bit integers in map BTF=
.")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Link: https://lore.kernel.org/bpf/DMJG1R2YIJRK.16CZLV9S5U7Z7@gmail.com/
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  tools/lib/bpf/btf.h      | 6 ++++++
>  tools/lib/bpf/btf_dump.c | 3 ++-
>  tools/lib/bpf/libbpf.c   | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 57f12630c5d1..eeb4984d6c57 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -636,6 +636,12 @@ static inline struct btf_enum *btf_enum(const struct=
 btf_type *t)
>         return (struct btf_enum *)(t + 1);
>  }
>
> +/* btf_enum->val is signed even for unsigned enums; kflag records the si=
gn. */
> +static inline __s64 btf_enum_value(const struct btf_type *t, const struc=
t btf_enum *e)

btf_enum64_value() return __u64, why not make btf_enum_value() return
__u64 for consistency, and then cast to s64 in callers if kflag=3D1?

pw-bot: cr

> +{
> +       return btf_kflag(t) ? (__s64)e->val : (__u32)e->val;
> +}
> +
>  struct btf_enum64;
>
>  static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index ea9a34db4c00..b636dc4185a0 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -2373,7 +2373,8 @@ static int btf_dump_enum_data(struct btf_dump *d,
>                 const struct btf_enum *e;
>
>                 for (i =3D 0, e =3D btf_enum(t); i < btf_vlen(t); i++, e+=
+) {
> -                       if (value !=3D e->val)
> +                       /* Keep names from legacy signed enums without kf=
lag. */
> +                       if (value !=3D e->val && value !=3D btf_enum_valu=
e(t, e))
>                                 continue;
>                         btf_dump_type_values(d, "%s", btf_name_of(d, e->n=
ame_off));
>                         return 0;
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 02e75b183ed0..cecd6b5f27de 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2627,7 +2627,7 @@ static bool get_map_field_long(const char *map_name=
, const struct btf *btf,
>         if (btf_is_enum(t)) {
>                 const struct btf_enum *e =3D btf_enum(t);
>
> -               *res =3D e->val;
> +               *res =3D btf_enum_value(t, e);
>         } else {
>                 const struct btf_enum64 *e =3D btf_enum64(t);
>
> --
> 2.43.0
>
