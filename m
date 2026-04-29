Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F84C81
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777423925; cv=none; b=OP1RlhVi/hiEZnMMs8GRReanAD56+YMFXVSLBs0Ex75NHqf9garwOSWHznVwzVWJmH9mVi2jFkucV8PLq4EFXN3L/Mho4+C/ZXAKVOI2I10naIkBljSGugSrAUiQ9vw0jQNRSJUtZGOm/6clOzLqmxjwqkz8a+vZFrRGow2rDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777423925; c=relaxed/simple;
	bh=F3iMLnzDCVL0AGVkx9Vua9TGnnLLV2IUyvSTeXlUEXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NP9UQNqx6z1LYoO+ghsKb9sx72mWZ43LnmaUAVvD0PSfkNzAC98kxg7AcdCeEVmnCjr9cyl0XJSTqahg/lYeOsERj9hlyhOD6X7vANQpK0LkyVProdtRdu2gVoHzcLJc+XOI30+GEYtBr4XIzldhZR4nhdbTIVa/D/ESKoRVvlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqOqjGSB; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqOqjGSB"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c8f9846c8so12189925c88.0
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 17:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777423924; x=1778028724; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r7TelQG9XtXH7Rrsr+Br2kygXSvfnbRPi2ccZUEpI2g=;
        b=lqOqjGSBHPrTcBV5NYR06e5WPwMOZiMxXM71TCYWMq7ySHc0O/4sQrSixtmBQJ4doB
         rFhuYn+4FjDd3iVai/6VdwYSH2XX2uhIzh4IV7tcbvBgBP++ZYJrsE6CwmLgDfgtm9hk
         1EKalt9swvS21yumGAO7ZImadEEFE4vLV4RY6CRv+6o/R1pa3or5CoUn+ovaoJkzN0kr
         1aN7R8ho2aU3RimaOGkaGiWE3aFZfandvOUUGBWZ4J0u9tXlrpjQQeD6CeewzxXnHYq0
         XlsCjk5yKGcWwo0kx10E2r3SgWzOb1gXOLMIGYj1z6n+3pmk3QxRbpLMCKPOMxK/ofy7
         iWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777423924; x=1778028724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7TelQG9XtXH7Rrsr+Br2kygXSvfnbRPi2ccZUEpI2g=;
        b=b/Q9a5yUpKBgZAzeNlM5IPUQkIt7dSH5OlNt20hujrCqXE9TaU3tENqmsfpIsAkday
         emiR9U5xyJbY3Mr0HAxat++7Et5D88bMrgBcTJY1UNiI3E0L6XrwAjwq0wQC6X+xX/G/
         LfeyokXUH3GOpAuZQGGRz1R5uf8JofEgQwiboo2dTS5eX5+y097PKOyP86Oug3+ZlqEt
         93ZJ6ZJRo6tpLkdRqU/kPEdYeaq5RxoOyNcM5UUM69c+Lcdc+Byb0O7VuxDHRKlxGZe9
         sk1OZr+sg5Osft6eH0dvAqPxS07KEJW7jB2n/n3jpgk48TX5yG5X0DqxRGoQxOGbyWkB
         MxzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hQZDwnz3HNgundFcrKt687sFQXvOa6/tcsNjkAM1Y+cXqTBTqyY0XKRhhRmixF+ZaxAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkb8KksV+kGNYF4+x+oVrOGT1xv5cB0E1EZ/1aBRcIFC4pqKpv
	lLKcSYjjQjLw3UVgPxty7xzKheRJlh5iRlm1gWD77XPkQsG1A/b5iCdJ
X-Gm-Gg: AeBDiesgociwI+uN2XB3qqhkan5vYqkqfpbARbGohYqnStffLJ+X/kyWmWQt5v1CXEi
	grvlBXOQceWIW3+gTixibndueQEk32T2MeVg718RvoGd+5atwrzdzv1J00uLdjGypg6Gq+xKzU1
	kN90dtPbq3I8+1rv2dK8vPKcs2I92Wbo2xTMyAhDAOkqFUj4FBEJlDKwE50GRRPWXZ8XXWG6o+f
	opogxwgpLmR5WSLMU0MgTuD8Q+DSagKYeXV/bcbe01Q1gizOLwUK3o0BofL2TMFLd8McZ0IsDrJ
	Bn78NEdc+d8ekv26l26nQFN001G24BfmVWVEvUwnKCQ8Qto9aMvo44vj5x9OpswKZGnbJPBFTeX
	6csNiUZY/mThETMdrtTu/Uy2G0wCONAdyU1VFJ5MiwMcJgK18tyM6KJTQezz77wsmY+tUNeuZZl
	J90NleSyEYvbBs89yIJzpZInIwCe8E64jJMaEpqDAKdKzugPFQhLZAuBZGm5g9dfLnBSkw1Jpk
X-Received: by 2002:a05:7022:ec18:b0:12a:713b:8953 with SMTP id a92af1059eb24-12ddd99afaamr2035705c88.12.1777423923465;
        Tue, 28 Apr 2026 17:52:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::142b? ([2620:10d:c090:400::5:b46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de320ed98sm570500c88.3.2026.04.28.17.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 17:52:03 -0700 (PDT)
Message-ID: <06f9e1f9f49dbdb0eb96152c3421e83b9cfb474b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 03/18] bpf: Refactor record_call_access() to
 extract per-arg logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,  Martin KaFai Lau
 <martin.lau@kernel.org>
Date: Tue, 28 Apr 2026 17:51:57 -0700
In-Reply-To: <20260424171449.2035279-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
	 <20260424171449.2035279-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:
> Extract the per-argument FP-derived pointer handling from
> record_call_access() into a new record_arg_access() helper.
>=20
> The existing loop body =E2=80=94 checking arg_is_fp, querying stack acces=
s
> bytes, and calling record_stack_access/record_imprecise =E2=80=94 will be
> reused for stack argument slots in the next patch. Factoring it out
> now avoids duplicating the logic.
>=20
> No functional change.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +static int record_arg_access(struct bpf_verifier_env *env,

[...]

> +		for (int f =3D 0; f <=3D depth; f++) {
> +			err =3D mark_stack_read(instance, f, insn_idx, SPIS_ALL);
> +			if (err)
> +				return err;
> +		}
> +		return 1;

Why having both 0 and 1 as success return codes in this function?


[...]
