Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637323775
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709870989; cv=none; b=Oy/PrHU2Jzre4KJbvCpCMjgsxBmBm3UFt0U1RFEOM3kbKdQY/9E545TK85F1cGTRBoejo1w53cJXARWtODQgrTO2OosTlTFpI48SkIyvCF9X9tLxLw7WzXIQudoMtLnBWOHmfS9rDvDnu0MacEGnMJGXApNvvmUTH3CEoqT//p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709870989; c=relaxed/simple;
	bh=Z+0lSwPRGBipz+vkKEgeoawErffPs6C8E9v5Br9GYrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCyzIgrVa0yLjCsydMRFOifRe5HZstDlv5/ZBaKgRnTLfPrUBOCCguJqbcpvWc9F0JOGRMBKjvWXSoPpjylcg+rLy2w5iYtkIenXSCutfncwdBHdiK50/LaKNFmpY0zjaaKVTJRf1mSsK/VlazSZqHQVcZOSZGQv6Hd2UTHbpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3YpLMZ7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3YpLMZ7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so243519366b.2
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 20:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709870985; x=1710475785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVLdNjTDqhCCPdze1cx12641/sj9S9XJNJqA6uSB1mA=;
        b=f3YpLMZ7CLuPXt3VRCyt7P8Gi6rH8olWeONaB6xC5WmEwwYLFbP6EW7HhJxVqgG7Qn
         nKZQ1wCQWme6rR9GMPJ+TG8JXJqg0PZ333DkwvrB+7hsgqZt2xv4Zujfz+TQOzFCJPN5
         AFuB3bzPgqyINWTsgtfDWlMuI1tcvgY9oTaTng0cNnQueXvatTnUP0nnW139FT3nxgR8
         2o6mJfJXh5KNTKxAun6H0LuF2R+I8m0fAlrmpB5HNNfspUe2C/FzJ9u4xejF20YxQm1x
         Hc83QQp3G96fhvDT0H8DEBqYQgh+gturiKAmZ5h4C8gmLv4xpjYxyN3RiHsEX5pkKtEB
         lcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709870985; x=1710475785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVLdNjTDqhCCPdze1cx12641/sj9S9XJNJqA6uSB1mA=;
        b=SqCpvyyK9mQE8gJy/QXybvImmd57GMh9HsqNfT80PVVp1LvD+mvIWvg1Hu+Wh451CW
         U8kXfT7xwvOm0kfwiWbBmBcnEfUOkBDz8A+tBGbNN6c+CkO6zK0h9FrakHNJVBfj0BPK
         FnJSOd4TATpbnaA6E2ql7RXUPlzKVtnuC8YgTpMYA18/6Wgx9zsRXOArD9s33RpUxmyG
         XpK2PWSLpe3NRLN6n9Bi4rcyTW+0k9F5HIUb5ZjJ2OS1DcC+VszSJuownZ3f6acrl7qF
         tyErkqFk9lfRH7U1KOXKJcicLATebAgXttcZBcPZ+hfx3/LS/ylrOJXlZwMn79wxZvSt
         6nYg==
X-Forwarded-Encrypted: i=1; AJvYcCUgVlmR1EaMjwpzBZhDSFYY/4t9yPVUeT5rRzITedqCxWxo7+oRZ37VwD2mVrgNlsSBauJP7sQdlxXGgbW3ZryXIH8/
X-Gm-Message-State: AOJu0YwBcB/m2e5e1bHgkNrjrADc34xBDubH8dULOwq/X5/jvZ+a8AOE
	yMffTkTPlsOLCvGIA11tnyoruQCQvtD15Bla69BCbrHZJExN0nqBgDWZ6fcO/8lgbvBJSmo6nlv
	b+1nR+Brb4HEFaL67BiDiPui52ik=
X-Google-Smtp-Source: AGHT+IEu0Wc1Uwc3zLYdAvP4i68WBEAUP5dWhz50K+BC42HNPn8QMZn4/R+FqATOHjE2cuYJDGrnxMMEs47Bl2fzx2U=
X-Received: by 2002:a17:906:5953:b0:a44:b90b:3262 with SMTP id
 g19-20020a170906595300b00a44b90b3262mr13536084ejr.5.1709870985422; Thu, 07
 Mar 2024 20:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307120340.99577-1-toke@redhat.com> <20240307120340.99577-3-toke@redhat.com>
In-Reply-To: <20240307120340.99577-3-toke@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Mar 2024 20:09:34 -0800
Message-ID: <CAADnVQLjEeDTmyn2+EsgSy_vkUcOGyUeSPpsLg0ytNnDW+YczQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Fix hashtab overflow check on 32-bit arches
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:03=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> -       err =3D -E2BIG;
> -       /* prevent zero size kmalloc and check for u32 overflow */
> -       if (htab->n_buckets =3D=3D 0 ||
> -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
> +       /* prevent zero size kmalloc */
> +       if (htab->n_buckets > U32_MAX / sizeof(struct bucket))

The comment carried over the wrong half of the comment.
I fixed it up while applying... to bpf-next.
There probably will be no bpf pr,
since the merge window is about to start.

Thanks!
