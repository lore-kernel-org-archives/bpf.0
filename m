Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907734AA1FE
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687323; cv=none; b=WCUTucCk1FtfVWWRQYHci5rBVegRCyQuJ+lNbEhwryt3shYNduhZTaBAPGn2CKkypFxGyRENXu2Ver66qsihbAccpdWbtyCqCBFTVIP5CtoloohzhZORjF6IXfgTJSufZDY4f9ldA8BeP8ZjCuGpVn4+JSeQh9o6UvX0adh6O+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687323; c=relaxed/simple;
	bh=BqM9oEDI8dYhlysc/LH5t7hKqrTydeuZJy1Hn5g6Mak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKMasQyb0B+y3Laf0FlPLd8gZKAtaR4/B52fbj+Cjxfeh6becww6TUcAElGHjfhkUuUiOeSzuRDqb3Kj5mUo8mg/qo958EzXmpkxsgPGOheCZE58qMBn/RVPWuzEa67epmmd7UbTT30A3iD2KkSSMsQ9KuSYfagatato40DR+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaiAgDbw; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaiAgDbw"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc1so35629a12.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687320; x=1790292120; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G8JUCHNEpOIsKU1CQQkIgX2zKEAjfF+OlEr7Lyh0p+w=;
        b=JaiAgDbwpsFCV7HK2YNWZoZBpX2WTggeM7hODk6S7R83QThpXRYcSvxTi+DpVD7kXf
         38r0rVYDj+/SmH7C67tJkHIGJMz8nKZhSaFBkhRs8I309CxuSolcbHmYiTgX8PND/eOH
         gupLglXLyqicrniQkRDjEyEjeDxE9d2H+uEYZP9iv+2Oqu/aG3nTyyzRO47WDl4Eilvp
         qjmgpJ//8lI8rjcDNoazT+nWfkyZntBtMrNrWxMxNjnyPeUQS0955Wk6m+zcX2hHtj8G
         0IJh4KrrIXtT713hrPm2fWwDYRqO+pEtjlJjTuP1SZzf/ygzjxsPrcV5GGSWp40mFoAX
         YomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687320; x=1790292120;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8JUCHNEpOIsKU1CQQkIgX2zKEAjfF+OlEr7Lyh0p+w=;
        b=jFD+vyS1Gx6zZh/8R3JzTZk2IkZ1GDFK1J/WQzWEsVyUpm3MXXsrchKGc6sk3SotKu
         SCp5/eL5WjpYSDlLgPoyyYrNI2Sw6GhRnfhAt19M+dZoHQ8fki1WU7tLA1x2eN+UwG3l
         T0wAX1rihhASMO0a6Oz4BzMrKG2JiJ6Gb+R54i/obfpqaypZsGbaFC72U7lHmT6HLT4S
         hFFuro9jrGIkW06+jiilqitA2xKkxTeVryxtT+G/uep3kSZ8XEsOY6XX0dCQNtpNGSvZ
         Hl+AUvSHlz/X64387u599qFAhR/dSU5TikrWCVVAjnjq7RHPVzI7XhnRQLQNri01RLBn
         54EQ==
X-Gm-Message-State: AFuF++l5Zw44Wodf/anHKEComw9YP8mKxEcVN0OElDcjpX6RIeJyujmD
	IS5t3BYArG1EG+A19G+l3CXYlGyG2bclJMHSVi0Rn5GHrJJ0gbbETRMy
X-Gm-Gg: AYBFou2Lm79r7YFeKvsnwHbDKfxXt828R4VX/JVWK+n9BhlhDZavqbE4zrZwG8hAcyF
	7hjvWP8VwYqVE2A2Kh6IjMdPBoiAdKNAPzA9qA7zHIm3CDnnksQNrF78lVasUIg0QyXR1fbo+Po
	saCopfXkWOiN0WQ4kStqNcx9Wl2n507qTE/xR1uJU/EA9f7OHjY60ko+HEtDHr+J9jH3Iz3xAk3
	1eYA+GzoMic0ATjeXS0zBXCVG2ejJ5OgoHsLXwB3nPyryzlL+iPAEf/oot7Ff8O4sgClPCCcUQI
	GQBaer3c7RJPDLGcfxUAA7/S4TBBKM/me5rydTRshLPN6zj1MUQlL6dzKSBY93j3zs20FTKnCry
	Ls7opmF910dW+6JTX+DcyODIoYKWoeJkbU/8FUuKUzofLPkrnoqemkkSaTYxo4momZ00A7wJvj+
	U4p0UVZ16IsetDSTwHbMMrwvS7VgF56Yora/gnLB/O1d9Yolscq6rwpYUBpv8H5qjB7JgZ5k6+8
	pw/4w9kT+YlpN6CG1Paq1MAoxiWBUsO1mWJSP+Ei9aJYvTElA8/CjPVeMjVB3ck0TMT
X-Received: by 2002:a05:6a21:6083:b0:3cd:9f99:3381 with SMTP id adf61e73a8af0-3dd8c1eeb19mr1037132637.0.1789687320329;
        Thu, 17 Sep 2026 16:22:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c47a:decd:950f:5c9d? ([2620:10d:c090:500::7:463c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b030aesm18837125eec.26.2026.09.17.16.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:22:00 -0700 (PDT)
Message-ID: <3b08609cd246f7c23728f4c8df94352b086ee56b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Show the tag kflag in
 the raw BTF dump helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 17 Sep 2026 16:21:58 -0700
In-Reply-To: <20260917012037.1396254-5-ihor.solodrai@linux.dev>
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
	 <20260917012037.1396254-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 18:20 -0700, Ihor Solodrai wrote:
> A kflag on BTF_KIND_DECL_TAG or BTF_KIND_TYPE_TAG means the tag string
> is an __attribute__ list rather than a btf_decl_tag()/btf_type_tag()
> argument. fprintf_btf_type_raw() did not print it, so a tag added with
> btf__add_decl_tag() and an attribute added with btf__add_decl_attr()
> dumped identically apart from their type IDs.
>=20
> Print " kflag=3D1" for those two kinds, only when the flag is set, so no
> existing expected string changes.
>=20
> Add a btf_write subtest for btf__add_decl_attr() and
> btf__add_type_attr().
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_write.c
> index 5c84723cf254..7ddda9348e4f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> @@ -606,6 +606,64 @@ static void test_btf_add_btf_split()
>  	btf__free(base);
>  }
> =20
> +static void test_btf_attrs(void)
> +{
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	int id;
> +
> +	btf =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "new_empty"))
> +		return;
> +
> +	id =3D btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	ASSERT_EQ(id, 1, "int_id");

Note: we have a set of utility macro BTF_*_ENC macros in test_btf.h,
      these are more convenient to use in some contexts.
      (At-least there is no need to assert every time).

...
