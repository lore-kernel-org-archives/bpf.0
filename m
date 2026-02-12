Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C91E834B
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770861053; cv=pass; b=JtVSeXpwXXD29sHSbkPCeF/kCndXBJeRFfQgkPwy2H5QSqNfLrg2V0aWvbGzIi3wTV8UJKvaDqGNfenlDnIbs19VhrKiEpblW9ZOXtWg9BsiLh/eybHUpK/XACvSB6ZKG5ztQqJXhRbly3r6aIYtSp6OT1o0LyvE0dzTWGwPZM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770861053; c=relaxed/simple;
	bh=N9VaTXpJcAFUMLGUpQQ/AsHV0xjic/FqepdABw0OE+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SouLJguXvgca6QFvkejIw+JriVDLhL1VE0M/pezMYrzir/wEK05MDn//E51SqigvoJwWKP2p+cgy77XxqJxZC83qLASrr5PqedUcDBezi1YsjqY2RDGF007BfUnwyHqQnC5Q6Nqu6FxBv/MH4X7RbxJy/DFIXpLjc3guo5tuPI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygo9WDmb; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygo9WDmb"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43284ed32a0so5067409f8f.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 17:50:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770861051; cv=none;
        d=google.com; s=arc-20240605;
        b=EE3y41sWQwMmfdLePz43JcNZNsJ9OfomBOAZi3/yBXyTg+9o6RUUC+i8GpN4XyC1L3
         fMvtRC0HXu2GzZH1XN/PB4YBxbuRq/8vCGHR/ZxFR7Et5wm2XxhmFPp64FyWxucQa8QQ
         EaNeMSRo4C2DF+OlECHDlUlveRjLrT+/ZjR2Bbv7uD9+y1Jso4eQAOrAmujHOS2h2aAC
         TsNZL1owQgL5B8iuavNKvOOrZnkubTJ993DKhiAhND4xYg0ZlP8ZH5l1L+sA9UjD908C
         b1gNrT3i38HKUWO20NU9XbRNF3j/Wa/qJq26W9VnBQs6OTGJwikluwhleR76aSG7/g8V
         y68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hW1jLKEJu2CXzvb9NvuLQpt6Y245YIl4LJuVa/TdN7g=;
        fh=s6TUpTjjDGAwa5AQOR0h2D/bsBSaj+RyXqWvckwdI5o=;
        b=Q9qjgz/GgAt+6oCQJR3ohgw/wFWF0666PCuN1EkM3Hmu95W18c8XRmbEQ+zcQSBqcz
         6GrAPcwwg3zFqv+mjvgJ8qT4vScKgifY22iXDvLczl9fWz7EXsdUZzt7PBHVTwIKJiSe
         cPHiM7ImCEbMrpfqcm13IpHYXTTnSQvm7y8LGMaF6fyR2kct9KD1vstblMnCFWtKH2Ar
         uEDEc41kthxhtvFXUd2Akd7BshXay4S3GDrRkbkm7y2+4H+NYhjlvfkbl7bjExJdm+nX
         vu9kHgfBe0jVlYFdKfB4b98HdEnCZHd9imTyryM17SmHJ/SfnOu+tI8+CKkp9MKciane
         qi6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770861051; x=1771465851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW1jLKEJu2CXzvb9NvuLQpt6Y245YIl4LJuVa/TdN7g=;
        b=Ygo9WDmbgpG0tPmP1YQ1Ze8i0tVxqLOLuId0psVOA8+TSIczvBi6ZntbI89JKaPrJ5
         dt6ko+z/Bkgnd2M/bbbqvu5lxuPBEVPsyb3wsIHp36mSl1ISWh3LdXLTbjrehg7/5/7N
         l0e57Acl3y7xaz+eG3ivAlzLYK/b3xdtxRRE9MBn82UB451Hi3zM0DSsZIUB6Q7Vyulp
         WJFP33BMuncVXwXkIIrHhXCy4sAv5AI9BTnaduxiFHrDtuqJmGA8tmsO8y9PnOONDo3A
         lYrPQSUBA3FcTPlHjqeO7T4RUBm+B19LuijXkKG/RdFJQTgSqZtFeM8OSVA2+/f2cpY9
         dPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770861051; x=1771465851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hW1jLKEJu2CXzvb9NvuLQpt6Y245YIl4LJuVa/TdN7g=;
        b=P0OdZ0pG84ZTi8uitN9mhltGzp+Lg3Vne1pfXmUxmnI+Cg+T6aVXUbddFSO4L9Gsmk
         u3sV3JsAmKunJKGzngTCEeLvDBsnE1r/Z78JWAAwUoC+B7YjhhKrAijpKO5///t/13I7
         sGII2UxOLrXkjE/w32LVef2cLof7mX7omarv+NF5eNkAj5dmO8ZDLsBp3SshJSOzVUCO
         EIG4aVTfRgdMxx7KSarDk5PgmeN0gqDWfwRggDOKSD0NRvbnbpeAY5HIIrkHBiGfHJEm
         1O7mQxhItDSoSwM42pa4K171au3QD7ki/y06q8anlV8O2S2rqA+AfpxBgc/PeTjPkdnr
         2x+A==
X-Forwarded-Encrypted: i=1; AJvYcCVZYlH4Mq1paueoyTybKnjpjil+XkWNmcy1rNoZ373I8iiOkbSKU13vCcxEDqM0gZFwCks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ew8JPmaRqFePjljN6gKCBIAe1LUYL7en4WPtq99WD993jJ4P
	6lJXfhCI74WKR9eiQiXH8hV8uWWC09Uzw5Bt8Z1eR7gpXG8tRIDS17GLCvES2usdFY88J8DE8vo
	6L9nQVZAulIwaHgp+45427urOJce7exY=
X-Gm-Gg: AZuq6aKxSzGU1ggWf8fEYgqu+ADvMyxMmrGRlLeXfiKnlptpS+jIaR9SGciFC39NLHL
	Jk1MqpS6B/NbmNywyF1NGNWJYTfJjkR4wLvIpgqeNSNiE3mLb1tyNhrhRcQ1kWW2dH3dYKtYgSV
	rG7m5sEvsIKsrv1hTRJvpHyL1d2yLZfppgoDKrGsUaNoGdelx98+ZQgW+Tv1ma2yum8F5JgWP5C
	fKCdi6mZLvSK2mfo124FrKFJYsH30YF609LInUamqOe2FD4KoLjE9T8iIFBraDG6Kw4NT2ChjEB
	za6yCG+s6/obIyNXwOz9N3peZY/BJyE2lAcYOthopaQqGXnWgB+yM90dfJYWsVtrqbzqZa3NC5f
	zYR2u2tCgckz0ZEQzaNlhJAs5Vw==
X-Received: by 2002:a05:6000:381:b0:437:8941:2f7b with SMTP id
 ffacd0b85a97d-4378aa127bcmr1990471f8f.19.1770861050874; Wed, 11 Feb 2026
 17:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208024846.18653-1-pilgrimtao@gmail.com> <20260208024846.18653-3-pilgrimtao@gmail.com>
In-Reply-To: <20260208024846.18653-3-pilgrimtao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 17:50:39 -0800
X-Gm-Features: AZwV_QgQXArdtIYEmbbcfD1bwDb31voO5uw2pqH4zCeeZ4p3zxbpQkEHhdgexR0
Message-ID: <CAADnVQJdwqeoqi+mPjQjmNbUqz2RxAjq-dVsGb7c_MCqpqmwhA@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] bpf/verifier: allow using bpf_kptr_xchg even if
 the NON_OWN_REF flag is set
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 6:49=E2=80=AFPM Chengkaitao <pilgrimtao@gmail.com> w=
rote:
>
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> When traversing an rbtree using bpf_rbtree_left/right, if bpf_kptr_xchg
> is used to access the __kptr pointer contained in a node, it currently
> requires first removing the node with bpf_rbtree_remove and clearing the
> NON_OWN_REF flag, then re-adding the node to the original rbtree with
> bpf_rbtree_add after usage. This process significantly degrades rbtree
> traversal performance. The patch enables accessing __kptr pointers with
> the NON_OWN_REF flag set while holding the lock, eliminating the need
> for this remove-read-add sequence.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  kernel/bpf/verifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 05a6a6606b6c..bb3ff4bbb3a2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9260,7 +9260,8 @@ static const struct bpf_reg_types timer_types =3D {=
 .types =3D { PTR_TO_MAP_VALUE }
>  static const struct bpf_reg_types kptr_xchg_dest_types =3D {
>         .types =3D {
>                 PTR_TO_MAP_VALUE,
> -               PTR_TO_BTF_ID | MEM_ALLOC
> +               PTR_TO_BTF_ID | MEM_ALLOC,
> +               PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF

add a comma, so the next patch doesn't need to add it and
has less churn.
PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU , <-- comma too

Also don't invent new prefixes.
Either "bpf: ..." or "selftests/bpf: ...".

pw-bot: cr
