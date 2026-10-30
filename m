Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793384244;
	b=rBkFdlRJjviYKl6SdC8iidtpIWDJ2YxsiUHOVXpl5tghhtJ+g3XXtLZTjp2DsrNoLYAf
	 ahCOow16RAcY6kn4+2YKfmksR9rTPlGiTee+FR5QGj5lH9ROhAOltra0KqmsO2kggZUUk
	 WG5nvc+36YmkSGVbopG4VNGyOh41D1q0qtMUmxy91Hbwz6KIrTEWrC45UziU3I1ohVyRu
	 IxRuow2g+zNRhAnDl3Qb9iq7DBT1DwRhAcok+8TQMQJ0tFjYtj0RQBRfg7ViDQf586iuA
	 GS8w3UTzceUGFxpDCuqconjWAwMjZeh5zULrjwJOeAuykJmn54kz4xFu+1tXi3JdClQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ODo+8NXfqsBBaujR7OxTQ1HqXDyfIavj4wzkye1DO64=;
	b=QJtfE1x7/0XFEcsku8rOpdELVnUo0uH2J/ZMG+TEuaYgaJSVfK8xFxUHQ37XLoc5iZsA
	 +at41l7bB/KpFkQsDFk0zYFTo4jw6XAt4iDfCPizsvabNph21VBD7Ks13wJDMYz1BmVUH
	 IBpWrLRNrr9ECRFCoE6UVjQsGumVXmK8GYypMUhmSEg80QUItos7fALTKCRUTt8ZU/9XN
	 vt+5PMovfvnGoGu2to6E1IoXXH9qZWWlrgA/COsZ+koH+u+UNeHYPgYOMZEih3K/zlNT4
	 Dly0i51k23vGwQ328xK+mF20gioDae7jQpSYi4MtZhqJw589ggEbeTkS8BeEDnLjkVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rd5o6HKL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85033606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85033606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rd5o6HKL
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so900273a91.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793384244; cv=none;
        d=google.com; s=arc-20260327;
        b=PECp4uXIaG7hei22urruRRTXtUeT4yvsFfRx5ZhePr8Jm2Ec7ujPyJA1vOXgeVmyru
         aWxEZb0/V65En69HNDgRMfrEP9YXV6MoBE1jQDBhEY5YE+4g005ZLiMmvIsxP/CTzDno
         BnTUawTGRLhFtN4HjqCSDthLRYeX19l/AaPBnmjDgWOV4ym8SNaF6ERhdWNJUDMvIYpJ
         4euXZ7qNbLm4TwG+dL+TieFKG6Om4xGrzlTL3bY3Shlc06iSjg+iGUEDfHsyy72IXEHv
         2Gm/U8b/cz4fbroI5U2WyfmVUSPBE2Hl5SFI76ZTrRGv06qpi8ewcBKECJd6z4xFKS01
         vnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ODo+8NXfqsBBaujR7OxTQ1HqXDyfIavj4wzkye1DO64=;
        fh=LSF/NzU2O+BPyfQjmaqd/+LGrBVUdYCL0ORG90FgpTg=;
        b=BcYmd5mddkn+UAwXtLNMIMkSvNJUJmQCA2P6ZF8WmZ22KDpMrJfCy6LuhOYsfuGWnS
         JPYrUxLf1jWb1laJaxtqAq7q9PbADUpxuFhlfQau/Oz9um8mEkgPaGLwq+4FkXBDxUXn
         prAOl8ibE52LKUE1grN2DsGWSNsoFEfpEEGI6ggSa5B/NLHAT8GVmbe12uJiuMzqntZS
         UzWf0fodKhJtQyxuwpJnYibgSjeSXra/vg/Tcxwb0XeUC7T2IdvmHwCw7ZzqLtK0KfFu
         VgFqOCsOTVrufdikyPO0pYJwi19qAJDKy4nSmXIkrzDqGaoQ9itrV9rrcgN7OovbABK1
         VWMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793384244; x=1793989044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ODo+8NXfqsBBaujR7OxTQ1HqXDyfIavj4wzkye1DO64=;
        b=rd5o6HKLrYxSiVS3/P2QktEkt4Y6PIT5NmYks9K8vkKzCxIbmMNEfh6islghlizIIu
         YOJ23Mb70LJkYGaocf9eOIbGEiirBNmjIfBMYcWOMAnVthY0VKhoU+BvdQvwB0DWi0D5
         TfTFiyJ2HIFfFD6Y60HKhNMvx82KD5RetGTyoiBhoWCPRBzLMIE1WsxUjjPUcW0CmyFh
         xF6A5E69Io3xN+uDG4HfDSya82ooMnt2L5UwFPfZB7AoV0jvJ47eTLQPtQ9zPnHhbT6y
         IiXohpgICssgUfCzxf5ckPcft23otjxpCCjAWGbTlMHVkafBqEAUH5mFkjv4+J49EszR
         Dj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793384244; x=1793989044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ODo+8NXfqsBBaujR7OxTQ1HqXDyfIavj4wzkye1DO64=;
        b=KQLC3v15l+2IjHfCecNhJ8h8RGXSdR86LelCPJSyTJ6rhqBAyDUJhityRIuenpCr/b
         ajvGTwH0wAP7YAc6utrpKQNSRFwy4oM+2cuL2SyPjLS/rBiiVE86COcNHGIPaGX4SGqz
         BVp58AsZ15xlj0POhpBRMMf77Yx1msUU+VW/LkUlIC1qmxs6B5BpYc8v/eeXFEEneiV7
         KiSX5gpFGWbQRPsk/yQ97RD0qNjLUBavbWraokogp38BdXIu5rza5coXxwsFzhAqrtSu
         hup8+C7OYEmGfel1pUlOC18YnooSAzfJR5fWa7ZdqPJeXVyG7003hnCSwBHdub0s1L82
         2lBw==
X-Gm-Message-State: AFq9FYL+m6LDtrm5y4QCqWANfHFDz3Vt/k3Lj4wzDKW0FOcDhQ+dkdcE
	NAh+e4+TIefW5gV/VDWwTUCRq4lVSgPdodsDPyeGLH+Bai2DXD0T7viy0miLB9VU4hRnX1FQpvj
	i3Os+meAw5lXoOCAGNhYWSomelFvo22E=
X-Gm-Gg: AYBFou0D+EuFjNnGuAgznewgjH8d8qRdUqlGMF/UwRJjQgdG6Od+gJJ9TJp/tynuSCu
	oBogPc1X73nM6XF5UIO9jwnPlLWNDgTQqBwnuEekYYqg+/MXlOeZ50iL6kPLIFIebm0AKNArMV9
	kxnfScYW0NXyFfW+6pZdAlvFlFKVVtrppixkXHJSHWFmLSv8wxKuVBj90cVjVzhTUFVLyVzaxpD
	sGjohEJOY8BbnwYAV0LoLOshBYnqJ07rMWt6RLXtOq/VhLbzf2VxVam54mVK67kKsgahWNker/3
	4urGReKH33PeXei/7IpnFSXkpPRnfX4vrsfkjXWUboxP3mcJeq0LcdPZzQj0wUo0RTeD8lex8Mp
	xDyjlBlC/JivcKVX5C1BQ4QzbimgxALXWMZYHL3THU79Lgiu+x98mmOoCKwnNF1S5sb1NLrvn9A
	ArN2r1n87qHEgUJKUdVQQPfvCQSeHu/5VDAw==
X-Received: by 2002:a17:90b:5147:b0:3ac:b3e5:428f with SMTP id
 98e67ed59e1d1-3ae897ce445mr2842709a91.53.1793384243713; Fri, 30 Oct 2026
 11:17:23 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com> <20261029-bpf-selftests-branch-order-v1-1-425cc1ef8581@meta.com>
In-Reply-To: <20261029-bpf-selftests-branch-order-v1-1-425cc1ef8581@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Oct 2026 11:17:11 -0700
X-Gm-Features: AclHuK9mvK3B5jtUtwd5P_ZOWuInWBq5mFhp2HOlWeYAIgUnRY6MwXXcP9xyVbM
Message-ID: <CAEf4Bzb-pLa8KSfc5VQJ3LnHvksTzwOgn6PY-xNq5k=zUPJyuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Check the strobemeta variable
 read instead of its location
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	vineet.gupta@linux.dev, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:49=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> With an LLVM change that lets the BPF backend reorder conditional
> branches [1], strobemeta and strobemeta_nounroll{1,2} hit the 1M
> instruction limit. calc_location() is inlined, and the compiler copies
> the "if (!location)" check after it into each of its return paths. When
> a copy makes "variable missing" the fall-through, the verifier first
> explores all later variables with an unchanged payload offset, and the
> paths that read the variable, with wider offsets, can't be pruned.
>
> Check the bpf_probe_read_user() result instead. It fails for a NULL
> location, so missing variables are still skipped, but the compiler
> can't push the check into calc_location()'s paths. Mark the read
> failures in read_map_var() unlikely so that the fully unrolled program
> also keeps them off the fall-through.
>
> Verified insns/states, before -> after (fail: 1M insn limit):
>
>   current LLVM:
>     strobemeta           v3   163591/4755 -> 170708/4780
>     strobemeta           v4   157733/4779 -> 167288/4896
>     strobemeta_nounroll1 v3    55975/1708 -> 50165/1617
>     strobemeta_nounroll1 v4    50745/1728 -> 49286/1656
>     strobemeta_nounroll2 v3   115445/4341 -> 116942/4267
>     strobemeta_nounroll2 v4   108121/4306 -> 109775/4210
>     strobemeta_subprogs  v3    53647/1611 -> 52413/1771
>     strobemeta_subprogs  v4    51204/1573 -> 50749/1795
>     strobemeta_bpf_loop  v3      2624/217 -> 2695/214
>     strobemeta_bpf_loop  v4      2632/213 -> 2668/210
>   patched LLVM [1]:
>     strobemeta           v3   163591/4755 -> 170708/4780
>     strobemeta           v4          fail -> 167813/4892
>     strobemeta_nounroll1 v3          fail -> 51250/1755
>     strobemeta_nounroll1 v4          fail -> 47480/1796
>     strobemeta_nounroll2 v3          fail -> 121092/3969
>     strobemeta_nounroll2 v4          fail -> 117302/3708
>     strobemeta_subprogs  v3    49653/1693 -> 51831/1548
>     strobemeta_subprogs  v4    48305/1649 -> 44104/1577
>     strobemeta_bpf_loop  v3      5017/398 -> 2815/225
>     strobemeta_bpf_loop  v4      5053/394 -> 2792/221
>
> [1] https://github.com/llvm/llvm-project/pull/236189
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/progs/strobemeta.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testi=
ng/selftests/bpf/progs/strobemeta.h
> index 6e1918deaf26..584a68248764 100644
> --- a/tools/testing/selftests/bpf/progs/strobemeta.h
> +++ b/tools/testing/selftests/bpf/progs/strobemeta.h
> @@ -366,10 +366,9 @@ static __always_inline uint64_t read_str_var(struct =
strobemeta_cfg *cfg,
>
>         data->str_lens[idx] =3D 0;
>         location =3D calc_location(&cfg->str_locs[idx], tls_base);
> -       if (!location)
> +       if (bpf_probe_read_user(value, sizeof(struct strobe_value_generic=
), location))
>                 return 0;
>
> -       bpf_probe_read_user(value, sizeof(struct strobe_value_generic), l=
ocation);
>         len =3D bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_S=
TR_LEN, value->ptr);
>         /*
>          * if bpf_probe_read_user_str returns error (<0), due to casting =
to
> @@ -400,11 +399,10 @@ static __always_inline uint64_t read_map_var(struct=
 strobemeta_cfg *cfg,
>         descr->cnt =3D -1; /* presume no value is set */
>
>         location =3D calc_location(&cfg->map_locs[idx], tls_base);
> -       if (!location)
> +       if (unlikely(bpf_probe_read_user(value, sizeof(struct strobe_valu=
e_generic), location)))
>                 return off;
>
> -       bpf_probe_read_user(value, sizeof(struct strobe_value_generic), l=
ocation);
> -       if (bpf_probe_read_user(&map, sizeof(struct strobe_map_raw), valu=
e->ptr))
> +       if (unlikely(bpf_probe_read_user(&map, sizeof(struct strobe_map_r=
aw), value->ptr)))

just off-topic, but it would be interesting to experiment with just
marking all/most error-returning BPF helpers (or at least all the
unsafe memory read ones) as unlikely-to-err-by-default, because that's
really what is expected. Not sure if we have clean way (though we can
do that in bpf_helper_defs.h for sure at codegen time). Can you run
your comparison scripts with such change before/after?

>                 return off;
>
>         descr->id =3D map.id;
>
> --
> 2.53.0-Meta
>
