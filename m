Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B53D904E
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530374; cv=pass; b=aDCSl0wJXxJuLYOPKGiPHRi4qaqx9Xhdb+1JPJhkOQuUDYG/rJwa/PcNa6cBTvO2ekJ5bQPoYnYCZH2RKoImLdSHEllRdru+m3LbZvbKFHB3XySup6ELbUBxtaElQdeOcnKS/5/3y+5UvluaFzNrdfVXT4TJwh07Ounb9qZv438=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530374; c=relaxed/simple;
	bh=lBXZh2NozQ0exShExkwC/4/tgxNGFEWumpbLV/iaQdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIzjY1aYur8jj9lg2tCpg6uHqFSjwUiTUgwtn+mh7RgjwK8wGqxVIRkw32PCFyE1vxfI0MtqESMGQoYQsDyhwqkE31JXGgIApMiF8EhRU6YFZJu0ZBcOYgX+gyGg6lugqV+ett9542JGS4RIjeOlfOhfQ+SgkYs6TraGRHJvza0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhqMKk1K; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhqMKk1K"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso39612a91.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530373; cv=none;
        d=google.com; s=arc-20240605;
        b=PrkhPrPXkuOdRaBQ8LQPfVe4bgp+3xLIPgiOd2cfW1VnBvGGtgt92AVc/UAkxctkac
         m0HtJZHUCtRBYkWp3Dfj5afLT9D1KLqNs8ZtzcfomcB5HShmWGYK7S/RzMVfhyuVJBYD
         E/Rhl9z5uTzXvClmb5bomm7nHJpNRT+r91R7qy2lmiEW5mYIocDN51gc+UIN8Zcx49YC
         Qf37uyyMNt/MDKnUgl03eheLBUJ4vNNBK9AfCEWQzxegrVOpaIifTDIPfFcqPqAj/WSM
         jaTxyWRWdaFkpqfRe1MtQy+UFBXvrIs/STBC6X9aXO0Ncj963KxM0CLe2QFyFWVjHhaV
         EBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y63ff5AlkUaWhekNyytDJI6efbM0EkMkt6aQJdoaHyE=;
        fh=B/1Lm6ziVCfdsF7iTJN4e7SqZN1GF68S+cqA33MqllM=;
        b=AbwyvZi8R98lK3wr9jj2PZmQnRTjYPSDqB2QD8aydl1F/zAV9kWN4BkrMoRYWCiRwt
         HTnSjptfkGis/WXAJvspUN4gum/80OvQ2pgscr7H/1WRg6CeLlrgmuZ0HayUWyuZSFaT
         YzOUNKr2hc0PpG33ycNmV09RhmiW5SVZJXhIhRgTlVwV3Vb+MMyL7LaNdz7ZHuPLHWes
         bH5Fq9Ldf1mvts9iJRvg1nkN36Mg6qLPK3W4Kj8ZWUoLGAPVyaS3lJXh0OKzuWNnaNdy
         afGg4jinGtpdRx7ym2hQAoWWM9Ua7Xu+AvC6sGfvi3gxe2/IteHrothSvMDDW64G6E1o
         btvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530373; x=1781135173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y63ff5AlkUaWhekNyytDJI6efbM0EkMkt6aQJdoaHyE=;
        b=WhqMKk1K+u2gNKNm+3eYdt/Sn0A7ER4tM+OGndV73FSg7KVx4Pyn+pSpu947kGpwNe
         XO5XsNDHyT46v1CKJ3F7B2j/FezaMm5vdmWZRYEfzG924LDL9mbakfo8adSjMDBInmeG
         dnPJb+LUW1O2fdmgvUXqX4j5YS+Z1y9b083ftY6Rw+7Mka1hd3sdg2vLjtwTnEimUANn
         KZTBFCbPnwp8xli7uxzKU4R8T3dXQ1QWJCuRWE4R+gqxCtpUsZraf49CBm9KR/BKctwJ
         SYl7IIppdAWuDNGp1ift8Y8KPJOJhXr80hpHe2W68BJDeG5fm3DVgxFj/A69wDDQj06y
         pA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530373; x=1781135173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y63ff5AlkUaWhekNyytDJI6efbM0EkMkt6aQJdoaHyE=;
        b=r4uDVzPxti6CwYs5XmTV+F18dpZB/bDXsogReq0svmb8U9a/UbnfrPhyvbo8kExtZo
         oNiNqMgNo7RZVIcs1omZ1swXaDgynsfZdytgawQEcFWUN8QX11zoQfBoeNRMhRz1dgCe
         v8Aw2yonoRkJAyeRVycGKT7W+8DQ2KIJ+rZSPmHzgRhMOSRAiWGiRQtXpWDLV7Ot7syq
         C6OUBp5VNRit1imLvkbcOF+jN/LTeuX6ppuHyf8QEa2VNYmZsxf27+bBbYAx2GrWhrXK
         pEcsF3/cr/UQzJEyz7jhJ0VYcPfepjgWcHydRzuGbaLv2uMBn1e34Q2CmN0SpHBYldzJ
         IiPw==
X-Forwarded-Encrypted: i=1; AFNElJ/4CL7m+vtnA5rl1jA+cxrlMKo+YM1jmGPSmOgXFhyMxu5NP5nrh2gdIzfkesNiVODPcUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgkSJFctLMVJxfz/aY0JV/Jbn0Mv/Gk1e1wAscNTFfRaq3inN7
	ReZ5zQw3o5bN7oS5vJjECzc0O3edvw4NkmFP0aZxDmZrkfn87XEEplgsQO+FHcgN3X8AKN2shhu
	10VEN+fRsS5sq+nuriV1xVihgMxrVJhQ=
X-Gm-Gg: Acq92OGoZw105EoYmaQF2T+Z8KSf3sz2fKxEdKewDJzXjLf3C77aPg1lvlEBa/Yl2dB
	Ck3EK3qjMaCuOKv4TOLA2R++j+OL6Y1Qcrw5SWnTy/bZTAXeHhlxfBLl8BNcgPOhJTT+JRrOicI
	0FdbeDrCr+H/zX8hneerjimYuGSN2lHA1FTpsXNQ5yxiaQe/4zIu4uYMFWIeC6SZoF+UlPx01PE
	oLD6DygQg0NrcRoZjpRAYz3Xsjaw0w8gI76m7uuBA8Cr+WAKkoPBPQhd18oaO0LdvTfT0jZ+gwR
	rnpDw2UONECZbDEhbwKlERlduvoM89cpLgs8LHAfS29VhupQeYUWq0vdI9tLqhJt5Ifrhy9Nb5k
	=
X-Received: by 2002:a17:90b:1e0a:b0:368:b724:6d53 with SMTP id
 98e67ed59e1d1-36e2f2c534bmr5789291a91.4.1780530372809; Wed, 03 Jun 2026
 16:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev> <20260601221805.821394-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-5-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:45:48 -0700
X-Gm-Features: AVHnY4LwPtNevVlaHNv_71moB5w_FpbOcNHZHIo47BShPBdaaGG7ixbGVKHRtuo
Message-ID: <CAEf4BzbywmmyPBcntAAS-=cbBfoXHPN4AZqwwK9K_sN7ejUfBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/14] selftests/bpf: Add kfunc set test to resolve_btfids
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:18=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> Extend the resolve_btfids selftest to cover kfunc sets defined with
> BTF_KFUNCS_START/BTF_KFUNCS_END.
>
> The test verifies that resolve_btfids correctly processes BTF_ID_FLAGS,
> resolves function IDs, and checks the kfunc set is sorted.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/resolve_btfids.c | 56 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/btf_data.c  | 10 ++++
>  2 files changed, 66 insertions(+)
>

[...]

>  static int
>  __resolve_symbol(struct btf *btf, int type_id)
>  {
> @@ -108,6 +129,18 @@ __resolve_symbol(struct btf *btf, int type_id)
>                         test_symbols[i].id =3D type_id;
>         }
>
> +       if (BTF_INFO_KIND(type->info) =3D=3D BTF_KIND_FUNC) {

we have btf_is_func() for this in libbpf's btf.h

> +               str =3D btf__name_by_offset(btf, type->name_off);
> +               if (str) {

can't be NULL in non-corrupted BTF (it will be at least ""), and if
BTF is corrupted then let's crash

> +                       for (i =3D 0; i < ARRAY_SIZE(kfunc_symbols); i++)=
 {
> +                               if (kfunc_symbols[i].id >=3D 0)
> +                                       continue;
> +                               if (!strcmp(str, kfunc_symbols[i].name))
> +                                       kfunc_symbols[i].id =3D type_id;
> +                       }
> +               }
> +       }
> +
>         return 0;
>  }
>

[...]
