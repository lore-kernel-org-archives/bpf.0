Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED7381B06
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342068; cv=none; b=RgIJmTNScbT6Rj0YTHjiWZsR1wZpo/VTI8/ZuA4ngoVKiWp2HL5eY/U3BH+JUbMGN9MHMhELgY9DU8mU3xb1w/uhFwbJHxxZEaFTvxUHFu7OAShMBAiV7E+bFTZfuTc9yiKJQyUkr2PoN3+FdKXe9TKe8Ox+t5tXzFhVLDBA6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342068; c=relaxed/simple;
	bh=v+ElgCdIUzdyvxv6quR4cK9nrgG1AcM5tnjEVA7iyMw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S09cZhJj66i0zU07eflAnDC4jhEmaBndRYi6iVLuIyolTGvVsJH1gtY50GbCdrJRrmUm58fOGc41vnBb3LdOnOFBXrVnmV3Y3J7LN20agHMYXHA2I/OysT3anVDWvCqxCsWYfwwohsR8TbX7yB3Lp48sgHtXQCxbZbn/cxvFjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=0xNlZDvg; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="0xNlZDvg"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-137dd4cc208so1031218c88.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780342066; x=1780946866; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdEWJVbJhU2BCrrfVvnAm7oZ10W1e6q3Pk/nV/JBLK8=;
        b=0xNlZDvg0tQwpueakfRqG57+dtNsGkpZENWRGm6ERsFh7Qz3PiD0IbT8sSQTQrU0P8
         RMkHbbldaxI7Xl3yAIRwah+wbqtqjUn8XlNyV906PFHMNXaBsitysCnB3GLlKkTx96Jy
         yLZk4/sE/hl3cfNY51Nq1db0nQTtPg8Xv851O4AHO5aOEMoy4e8PfCkQgWub1R578diy
         S/tlsQKM+Tmk+KpuQMLgNfxVcBV0Pe1te9FzU8Xv8IAlI7Zy7bf6PxjO8t98AHvQw9IM
         wZO0AQk3z+DaQTqiEVpDlQZcv6o5dVjlWJdqqlTD0iMJubBzDd77/PBjXF1OmZ6UDVFL
         d+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342066; x=1780946866;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdEWJVbJhU2BCrrfVvnAm7oZ10W1e6q3Pk/nV/JBLK8=;
        b=IzyLIPZEUfS/EsEpmpqtPTGXy9jvu4Usv2e4WbKM4aj0ZdKqEyVijbT1ASsE0XM69U
         Z2pXf/Rkka2Humiq5u8JP4JaVTClFY7Ic7adQCHj8nhKRbaysyG1e/58N6qdL++61RaH
         Ni9Sp56N897/5N2FDxx7yFftrvmMAPRjHWAqQKcuy30LQz1YoNwR5zLT9HkhLk4kT3Lx
         XCT20YE3TkhPZMYQ44MhT2FUY8hT6FVTp7XsyixAmSSIsUxbOgga63+AJxKcHEv2Hqa2
         3B1ZdheCrh58/ePBDqqGqNihrOyPBUmAr7z7yiLszcUucgyA7UZlUyWXXWnTKcr/y2UC
         sKsg==
X-Gm-Message-State: AOJu0YwfbcqD7P0RoBi5z4Om4fS2i6rY/rhdt4Dc4kWYxsde8j/7hal4
	RCIk2agyBSWJWo3DQIu1gI2ZWCM/C8Tl8kLUUjgbpPBGLLwEJwpLGr/2bFKhcxOsHEg=
X-Gm-Gg: Acq92OEnIyDUd05p/FjUMVJDfSzqsMkyHpXOjzMsxDAY4JnwRa+B6GbjWDTfm5Waz23
	9j6aqf9cOh/WneqM0yW5/b2eaBoOr4qW9Chy5F6j1mCEuz/TSA0L8M+oVgQzu2dJ8xzjKgZQja9
	c2EoMTZdk028xtu12l8e9LD6l2SvGV+R1Mz8JsZEuCoYbqx/M02wV8p+DDEG86JCpCnRbwZzVCW
	e9i5z0MkqoCByvyVFtlHTQC0r0ThNZhNzCXRYYJWTEPiSVrkxhzCbkvJhoVoQvtnRa0CUxO5fjE
	BXy0mFLlZd477v5cBC1fsfKhCUY+kjhXyXHkZUhZlQq+MfJN2mp24Xhf5g+qRarwi5VpH7ItWrS
	UlZVXHI5SB7FKHVLg9gR/PtDoNU9XSPnnD2Bi8ssnGs5LGIcC5/7lj3cE18QORZ9zvO5UpvihlI
	/JEF8K79f9zNXpAXfcNuRsdeX7BX5M6o+CuQ==
X-Received: by 2002:a05:7022:2527:b0:133:39b9:9720 with SMTP id a92af1059eb24-137ee2efff4mr364216c88.16.1780342065788;
        Mon, 01 Jun 2026 12:27:45 -0700 (PDT)
Received: from localhost ([163.114.132.129])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7433972c88.9.2026.06.01.12.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 15:27:41 -0400
Message-Id: <DIXYL7ZGEO7C.3HN24VDJYZQOR@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 <jose.marchesi@oracle.com>, "David Faust" <david.faust@oracle.com>
Subject: Re: [PAHOLE v3 1/3] dwarf_loader: Extract die__add_btf_type_tag()
 helper
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
In-Reply-To: <20260601183511.594100-1-vineet.gupta@linux.dev>

On Mon Jun 1, 2026 at 2:35 PM EDT, Vineet Gupta wrote:
> NFC change preparing for DW_TAG_GNU_annotation support.
> Extract the btf_type_tag annotation creation logic from into a helper
> die__add_btf_type_tag().
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
> Changes since v2 [2]
>  - die__add_btf_type_tag() returns pointer not error code.
>
> Changes since v1 [1]
>  - NFC reinstate some original comments

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Minor nit/question below.

>
> [2] https://lore.kernel.org/bpf/20260528223616.2035618-1-vineet.gupta@lin=
ux.dev/
> [1] https://lore.kernel.org/bpf/20260526181818.4159927-1-vineet.gupta@lin=
ux.dev/
> ---
>  dwarf_loader.c | 57 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 16fb7becffee..8b5b526299b5 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1600,14 +1600,43 @@ static struct btf_type_tag_type *die__create_new_=
btf_type_tag_type(Dwarf_Die *di
>  	return tag;
>  }
> =20
> +static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_ty=
pe_tag_ptr_type *tag,
> +							    Dwarf_Die *die, Dwarf_Die *adie,
> +							    struct cu *cu, struct conf_load *conf)
> +{
> +	struct btf_type_tag_type *annot;
> +	uint32_t id;
> +
> +	if (tag =3D=3D NULL) {
> +		tag =3D die__create_new_btf_type_tag_ptr_type(die, cu);
> +		if (!tag)
> +			return NULL;
> +	}
> +
> +	annot =3D die__create_new_btf_type_tag_type(adie, cu, conf);
> +	if (annot =3D=3D NULL)
> +		return NULL;
> +
> +	if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> +		return NULL;
> +
> +	struct dwarf_tag *dtag =3D tag__dwarf(&annot->tag);
> +	dtag->small_id =3D id;
> +	cu__hash(cu, &annot->tag);
> +
> +	/* Prepends: for annotations tag1 -> tag2 -> tag3,

Not familiar with pahole's coding style, do we want to adjust the
comments?

> +	 * the tag->tags list ends up as tag3 -> tag2 -> tag1.
> +	 */
> +	list_add(&annot->node, &tag->tags);
> +	return tag;
> +}
> +
>  static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu=
 *cu,
>  					       struct conf_load *conf)
>  {
>  	struct btf_type_tag_ptr_type *tag =3D NULL;
> -	struct btf_type_tag_type *annot;
>  	Dwarf_Die *cdie, child;
>  	const char *name;
> -	uint32_t id;
> =20
>  	/* If no child tags or skipping btf_type_tag encoding, just create a ne=
w tag
>  	 * and return
> @@ -1627,29 +1656,9 @@ static struct tag *die__create_new_pointer_tag(Dwa=
rf_Die *die, struct cu *cu,
>  		if (strcmp(name, "btf_type_tag") !=3D 0)
>  			continue;
> =20
> -		if (tag =3D=3D NULL) {
> -			/* Create a btf_type_tag_ptr type. */
> -			tag =3D die__create_new_btf_type_tag_ptr_type(die, cu);
> -			if (!tag)
> -				return NULL;
> -		}
> -
> -		/* Create a btf_type_tag type for this annotation. */
> -		annot =3D die__create_new_btf_type_tag_type(cdie, cu, conf);
> -		if (annot =3D=3D NULL)
> -			return NULL;
> -
> -		if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> +		tag =3D die__add_btf_type_tag(tag, die, cdie, cu, conf);
> +		if (tag =3D=3D NULL)
>  			return NULL;
> -
> -		struct dwarf_tag *dtag =3D tag__dwarf(&annot->tag);
> -		dtag->small_id =3D id;
> -		cu__hash(cu, &annot->tag);
> -
> -		/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
> -		 * the tag->tags contains tag3 -> tag2 -> tag1.
> -		 */
> -		list_add(&annot->node, &tag->tags);
>  	} while (dwarf_siblingof(cdie, cdie) =3D=3D 0);
> =20
>  	return tag ? &tag->tag : tag__new(die, cu);

