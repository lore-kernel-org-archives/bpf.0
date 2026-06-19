Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638218FDBD
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829015; cv=none; b=lQC1HmnFjgm+iv21qpkBwU2YDfA1H7N7sZacKQq38HYJ4NsPJllnqwzdQVGiBLIMweWdUkKVefj6CrIOeEZnYIF7VHoWNPtcj6jQJIEXQxpyZU3CHRpfCUwRKBH1Huq2jCE4wCNza5NUau/eYhwpL3XCiOqs52S8zFT6Qu/A9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829015; c=relaxed/simple;
	bh=FkT+PzJWxq7ZJBIwx9CFmzA6UcqEyKPiDAgAVJt99Go=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sO1wq9OgVfr/IevqxyeHlLJeHKuRrSQMYU7nfI4Pb3QMRecNcpdYYh5h3PBWtCn1GFRmbtDlcxrxC4erJ2Bu301q+2D6hxgBONA+Ee3YLiGW8wqyFALZWhPATQheTV+9xYJZGrUmgwsg9a2cEf6/zv63COstUsxxbD3L6uyI7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTiWl3pE; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTiWl3pE"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bcf74e617so3376212eec.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 17:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781829012; x=1782433812; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rl8vxzNGQQkAE3mqEDnLG1B9cWbhQEBcyRa/1yDKl7A=;
        b=PTiWl3pEjEW5lKf3T44s3MTl6PzyjsvS7cJept8leyHNbHRYNdc4hYaCWcsb/ritqX
         SNpE2RRKjqQa/zAS733sAEgJK2F2mJu8k2yjaL4fTKUlGebefLtvdb1XEdk7FHmjILrC
         jZsLOH33TaAZA58dIqqSEtZvxiz4qUNc/DAnj5y/VQxTDiA9445xsPqpa2kywI4ghHOb
         TNfi1/UaPUZZtJhvUvYAMi4Sg4DkVrsePVs6jEZCwi0Zp1u6Mnjq/zlyk/HfSJpD52jE
         tK0+80gZ8pyYYyBzihSlXAppLtzxMVHQlSDSiszMjr6rNfAp01O8geTwGNioeD6gSpP6
         jywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781829012; x=1782433812;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl8vxzNGQQkAE3mqEDnLG1B9cWbhQEBcyRa/1yDKl7A=;
        b=HyN5CFScUw8Z265THXPLQhK+BKM2mf1hFhW587RQhhd9YsALJwjjF4OZc8P+mnbCaU
         kfA0vqPtNbTOn2ONtjUCBxT1ogR+Ly35EX4SwiIV6YRg4E909EmuYnjnxB0puA7oTotM
         4GtP4fukx2owFTysZvD4yM+cSC778W8Gaa29+uu+wwIRXS4miFEoTvbUG6IZhvDYkiU2
         VbTvFyDfneLd61Qh9ZXUOXMLNFuIutTkyaogFMxdJ6AoLwQ4kUQrshZeazg/u5HXjCb1
         vhBDQEnsYQgY7XMzeQmDfrY+AF0xgZ73M2PxB8C56zn28i3NJ8bTPxWNJ/9vVXqnEm/X
         tCqA==
X-Forwarded-Encrypted: i=1; AFNElJ+PqspGZKoKCBG3WH3xqv4qiyq0UoXZNnDRou0A1YNoIx8M69Pxbz7XiljJqXE7mkvWkJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQDBTYqpL7F38JK0WZSSosaGIzU/kTfS+e7fJZJVl1CSCg7R9O
	4h8DT5ojpAtT+llr8FU+chf+PSvZxKRdsXUaE3SnZslPnJO5ClXxyhcI
X-Gm-Gg: AfdE7cmL0Wg934uGcKH/2zTLSfI6xbEGLABuHHg8LbfZW7uy4T0OCqOhAZKvoQCKfKh
	GYFIGYSd2tUAVuQ0BISbBzzb20ZDoBQ4sUm8QF3ut3rK7xRGTDuaNWHXVCUsWVRy+wj70uxHjTf
	pj4UjtdV8Otxyn7Fto/fT5cADpkwINEyF1grRPV8Fi5AZyH1GeC6NgXCwYQheNeNWPN86gLFw5f
	PWOU7QSosG7805KvfIueejA1JZIZqXaJlpXQ+BwPdnZK4TetZ61BM3r+knziGeodgU5RgwaYz3z
	fiwLSqDtMggQCk5gcPSW/Vo62665P3X0yGd7Do34WOHyMSX292AnwtZHukNMWQUpzB5wcwSEvrD
	2wc5uyxs+0xNSq618XScU6cICoWRbf1IHop7bSkd2YIXbzjqc7Fmdf1SEvKvZbFvp8iN6u2WbFE
	nAbHankhp7zS4DTYHFUegGCAM0vedxi5NbVTiH822grWPZbOR7KaezxczIhXEOHDagIGFr
X-Received: by 2002:a05:7300:220d:b0:2e7:c701:aa85 with SMTP id 5a478bee46e88-30c071dfe31mr1156393eec.17.1781829012067;
        Thu, 18 Jun 2026 17:30:12 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:ae6d:cb3e:a1c:6cba? ([2620:10d:c090:500::3:8ac8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c0682b382sm918298eec.11.2026.06.18.17.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 17:30:11 -0700 (PDT)
Message-ID: <de31cfde013f502e05d6c01a69a49a758a0af51e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] selftests/bpf: Modernize resolve_btfids
 test scaffolding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org
Date: Thu, 18 Jun 2026 17:30:09 -0700
In-Reply-To: <20260617210619.1562858-3-ihor.solodrai@linux.dev>
References: <20260617210619.1562858-1-ihor.solodrai@linux.dev>
	 <20260617210619.1562858-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-17 at 14:06 -0700, Ihor Solodrai wrote:
> Refactor resolve_btfids test in order to:
>   * use newer ASSERT_* macros instead of CHECK
>   * extend the lifetime of loaded BTF to enable additional checks
>   * cleanup unused/unnecessary code
>=20
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -153,15 +136,12 @@ void test_resolve_btfids(void)
>  			break;
>  		}
> =20
> -		ret =3D CHECK(!found, "id_check",
> -			    "ID %d not found in test_symbols\n",
> -			    test_set.ids[i]);
> -		if (ret)
> -			break;
> +		ASSERT_TRUE(found, "id_in_test_symbols");

Nit: 'break' is missing.

> =20
> -		if (i > 0) {
> -			if (!ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check"))
> -				return;
> -		}
> +		if (i > 0)
> +			ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check");
>  	}
> +
> +out:
> +	btf__free(btf);
>  }
