Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA783D647F
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787258528; cv=none; b=nANBQulVFjuQXg99BCe46Uv2iXvpYFOpePal6iK+XHw94nPkb5MfZuMaFpASTGPKUT+UPgYmuT+OyvNVMF8x9mRKm0YDGIjue1Q+uDqImD6ACsJgMbhj5sfypiF0EPek+iojZ+X+B3BWwgqEP+jTcjrvXNCLQXcYmEr/eCBWNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787258528; c=relaxed/simple;
	bh=0VyoZ6TJReKcfVdzqeTmOBtoeK17O+B+ahQB7K+O1eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tlJPrLC1pmqUMt5Rnr5b7GCuQYVy3LpHyF8yCvR7Js22KPbPWM9CzbSqd9RKUnpJO3QkO090nGZUJonVlYeRmOdI/wrlsA21xmi11Eq75Hlp8XaCLck6ocS55i1vgqZrzU9WKlw++JR2Vf3KL1gmgfRsBPVx5H+SehTJM0GhUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heWjqsb/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heWjqsb/"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso918515a12.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787258526; x=1787863326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x+ntvOMg2P7buq0TDYJNOA/p+4RtC0V/InyBPrLN8L0=;
        b=heWjqsb/YGkm4dP4F5pZTn/p05BYNRZo4F6YG+DJ196OepBRCTAVWb/cfSd0o4Qw0+
         K5+g1lsJ0tmJdnj8/EiSvJULO64wAIJ56IFVleIgTJw9Ek+C1K27z3XqzRpF3g4aj1PT
         SqtbDF924L8gLjQrlp99XrfP21VxgeVwxjGhRIyOseAzXiZ2WbKzBrOtvxZNPPis+1Ga
         rV8iLF5dDOUDvNttVbq+efy1FJjzI0Y8X29s1wQSNDrAEg6umD203a+j8WjBcEuZcFTw
         Y14GrUMNcXe0WvYj4TZNmIZvf74M3KyqupoxQn1rYUpJfySxmZtMuqZrberIUpz35yuQ
         GMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787258526; x=1787863326;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x+ntvOMg2P7buq0TDYJNOA/p+4RtC0V/InyBPrLN8L0=;
        b=fjPoP9bW7qcj1GxuITvG22tq+ZdEuzHymkcP8RKwegSvETbyW/2zbQcogzAZI6l8Lj
         +ZKs4pjnYkDtKwPFxhcgXjem50k15bQ4heAuPKz0REIYmKrEkxLw3tlZGZlyK0mQsMrl
         kjyNCUkwEdPjZcHK04wULkCCOZ7dd3hvuYC1vXZKoeXpAUxZooHqNsaJhBew1CokL8oe
         bsCj2aN2go1bH7z7zC9aOmOIzgS+0QbuiEL4b6T+eV+5B1+ocPxYPFhJjY5ST6rcUFhY
         3Q86hWgxQwMbQwlyOgHbO9vcuDSzJMd46mpWoLlfTeQ4p26TJhq1DDgCgv5CmxSurxVm
         l3Mg==
X-Gm-Message-State: AOJu0Yz6D/SgSCkayHOlwslcfO9CEFZUA+M/FrEtPdlMphM/q0vYr5zr
	ZJsB3pHSkd7CvT8SFBSCI28gBEtJFJKCOYZnFiPTJX2mQbuXpT867GqI
X-Gm-Gg: AR+sD12WeoiHcUm3LT+uOK+Guz93gdpohXgbw1Jyj1q0UXVg07+GJLo9bgynLCwtosA
	6AdqkvnVZ4osooSgbCDaax2krENfNAawpPzHXtdA+oDeAMCm4zhzy3gXdc0baN5lKK2ISNESqYX
	rzWAquaUfjnr/yG89kXWkWdRXJ1T+k+0jUaFakKsNAp4NDYc62XdjCUKCY8cMXpVI5RICadbZHx
	V17pugCj/d/MJ8opB/xtN5s9F+OIQNxK1V6btAyNouB0BgmIw1BNxp41sdMSCQglCQvDGqbo3ui
	hq732V9J+OK92ZP5bbUjG7XJ9kx5GCPjIshLEe4VSwVC2WhaHgjvkLeUFkkQYmPrdpltv8FOIAm
	siHyGBf6uZjvnWSYJHgN54aVXSAwAXbsRGpvFbfGbdm4epTM9RE/Um2whBfclwKHvAcnlhjzOxq
	BnrZcG0GTImrjgO0MhIxWoM96NFTY6S/yp6YNJEkLMqLm+VToE2d3AOJPHXYXmXK78YgFEuUE81
	DaMyzL32leu8+YbZ8gSPrKiaOY1zxkkpQmZl8Derg8IFA==
X-Received: by 2002:a05:6300:6bdc:b0:3ba:d7b0:fcac with SMTP id adf61e73a8af0-3cd14d2c28bmr10605175637.5.1787258526237;
        Thu, 20 Aug 2026 13:42:06 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10d497sm30715179eec.14.2026.08.20.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 13:42:05 -0700 (PDT)
Message-ID: <6a0a841f4b41032cf69f5ba7d80189cfe7f4c4ab.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Check that sorting
 preserves types in bpftool dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Date: Thu, 20 Aug 2026 13:42:04 -0700
In-Reply-To: <20260820000627.3826188-5-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
	 <20260820000627.3826188-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-19 at 17:06 -0700, Ihor Solodrai wrote:

...

> @@ -87,6 +90,36 @@ static struct btf *mk_btf(void)
>  	if (!ASSERT_OK(err, "holey_tail"))
>  		goto err_out;
> =20
> +	for (i =3D 0; i < 3; i++) {

Testing this locally, a single enum suffices to showcase the bug,
why the complication?

> +		char name[16];
> +
> +		snprintf(name, sizeof(name), "E%d", i);
> +
> +		id =3D btf__add_enum(btf, NULL, 4);
> +		if (!ASSERT_GT(id, 0, "anon_enum"))
> +			goto err_out;
> +
> +		err =3D btf__add_enum_value(btf, name, i + 1);
> +		if (!ASSERT_OK(err, "enum_val"))
> +			goto err_out;
> +	}
> +
> +	id =3D btf__add_struct(btf, "s", 4);
> +	if (!ASSERT_GT(id, 0, "struct_s"))
> +		goto err_out;
> +
> +	err =3D btf__add_field(btf, "f", 1, 0, 0);
> +	if (!ASSERT_OK(err, "s_field"))
> +		goto err_out;
> +
> +	id =3D btf__add_union(btf, "u", 4);
> +	if (!ASSERT_GT(id, 0, "union_u"))
> +		goto err_out;
> +
> +	err =3D btf__add_field(btf, "f", 1, 0, 0);
> +	if (!ASSERT_OK(err, "u_field"))
> +		goto err_out;
> +
>  	btf__set_pointer_size(btf, 4);
> =20
>  	return btf;
> @@ -95,6 +128,42 @@ static struct btf *mk_btf(void)

...

> +static void test_sort_preserves_types(const char *path)
> +{
> +	char *sorted =3D NULL, *unsorted =3D NULL;
> +	int n_sorted, n_unsorted;
> +
> +	sorted =3D dump_c(path, true);
> +	unsorted =3D dump_c(path, false);
> +	if (!sorted || !unsorted)
> +		goto out;
> +
> +	/*
> +	 * Count definitions by the closing brace in their first column. Counti=
ng
> +	 * "struct"/"union"/"enum" openers instead would also count forward
> +	 * declarations, and which types need one depends on emission order.
> +	 */
> +	n_unsorted =3D count_substr(unsorted, "\n}");
> +	n_sorted =3D count_substr(sorted, "\n}");

This does not include e.g. typedef. I'd just match for presence of enum.
Or better yet, compare full expected output with actual one and tailor
several BTF definitions, each for a specific sub-test.

> +	ASSERT_GT(n_unsorted, 0, "types_emitted");
> +	ASSERT_EQ(n_sorted, n_unsorted, "same_type_count");
> +
> +out:
> +	free(sorted);
> +	free(unsorted);
> +}
> +
>  /*
>   * Check only what the selftests build cannot:
>   *   - bpf_helpers.h defines __ksym and __weak as well, and no program u=
ses

...
