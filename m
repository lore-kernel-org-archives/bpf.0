Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554C2DF132
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660724; cv=pass; b=BSodn02jVQxMcnMu3Cx+56JWnl7dfhRmkD2BaGpu2OUSI6XudtXrS4isz4iTSg0dETRWTNlz+PGJ7aox1j8vR7gNykFvp0hlHmm9tO76e4SKvTFenMz/YurLbFu74u0x4hVC1jGrYrwlT0O1rjtJlLtnR441lgeO+DUZ/3ZpWAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660724; c=relaxed/simple;
	bh=eIWhpYdj1kMRCnEpam1JKhwrBgE718KgDAZKvy4/iGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zw/biD0zPcGSZnimelkmpxOHN8nscnXlpTQh7OSiGsBJb5qlN12rx+H802f7tdtZIbH3BnacoNgd5htqTS1hADkTPCyihRfmBH8Sk0pkyrPZtpabgg8BwvL1IMQH1mppgjhs4RP9hUGN0ywbo82Cnq5vvvtt/i35XNz8sirtdw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQhUlIRI; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQhUlIRI"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfd832155so4021830f8f.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775660721; cv=none;
        d=google.com; s=arc-20240605;
        b=FR4G+MnS9yPrxOA1s4D3HYlQDM30WPjD2BLd47opnt1DC3ZRBMzdCFgt0uyWAjdvHA
         Jeex0RvoeHfD6030ygXnJJYmU8UJcgE9c9PrnTwquKcE/ZaC1s5dl0FM6Hrv3oKBErXn
         63hYe/UP8oBVqbH/jVqf43EoLJVA6ysSxils0qWKEr0bYO1lzE94DQhZFacQR5N5I3ug
         o5BpdoJclEvKG46dKA/ukvqw12QwW1jKKu+hj/axV52Wfs82c7ldDp6DdEON1Cu6JCh5
         Zr03Y3R2/5hU4XA+sYz0H64YvEh3mp1jlPJYRIW1T1MAtvMqjD7Vs/uWuG1DS0a3v/Bv
         Blcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eIWhpYdj1kMRCnEpam1JKhwrBgE718KgDAZKvy4/iGU=;
        fh=7MTYTQbBnMRJ9GMrTfqTRoTowOS38XYTYZdUwlqJTQE=;
        b=ZEZtO0IIJcBL15fdnJbgi3EqymCXJ6O0AQ3D963OxKtcUkZ/DPhGMbe97gwIk1kyLJ
         999JJ1Icxoru+ixrJWCUNbNxJTR5L2XqWztI151c/3tSjV6Nj+ldxmz8urROdJ2rxMFe
         /Fn1oCCHPS1zIYyNBUl3WYu9XlCxJFX6K9mI4bmxmLqycxS1LyJrFKC2jx0RbRufkrud
         /XiL+H3lrRFbqOIylGVk0cr+G+oPDzpilw0WgeBwKTF1BmlHWBcU46ODqJ6JCKHyXXbi
         sr509+pRR/SQHOjdp+K4uR8EZ9XDW+c6S22yBKPJ6TPT4P8fUuDUpXLHLITp1xZuyLbJ
         NnzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775660721; x=1776265521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIWhpYdj1kMRCnEpam1JKhwrBgE718KgDAZKvy4/iGU=;
        b=PQhUlIRIvifOaOBuAAr/qOA3DK7H3YG3DaF9tC0VZyVlAxPC+Sft38HBMAjRj4wZAT
         E2yR4C4M5fZOiVKCEcs+FwgBxoHNChxu4laEE/tnpDDKHBtRFHtSiWw8Tsh8gWwljJ5/
         IhXq/nhhuDqw9z9LBzOudnCcnYSmGioGK3+ye3OSq+ddZ4RVFViv6oRSjsS2kwyRfHHS
         ZtUP4zh424yq9vidYjGMj4ZMk58V+R5MYAgENIXuMZ/tjE+8Xjl7yAQ8uItdwV8sYFMR
         DjE1WzxVtv7vdpzMo/T/NqmIcvNErDZ+BKbiyApv8BRO9L6VfZKEVuk5NC5Xt0o+aOpF
         e23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775660721; x=1776265521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eIWhpYdj1kMRCnEpam1JKhwrBgE718KgDAZKvy4/iGU=;
        b=iGXZ/hdEuzlECAQ+0wgTRJHUcN0N9XGx7FTaHOZH6YPZETOgUVmSJI8QxaJJ1BGqe/
         EGaq2KRdaQqv+XWUTr7lCXyCN01EcWR90tqaASRmlWSxQM8xQWrbOTX23EW4ywS2LzEf
         zH5VFbjSIfvWCZIKRc+E3LGrwTfgKMgFOcPhutTbHrXtqpyp8fOpS85Q+760MSODv+Wf
         I3fZ3N1WHshSqXYK9l7qgTJ9jgxgTGgJWIcmCdkLc00qyuiauiOW2LaKjWnf2WXDp/s9
         iK6PRxlELzP3vd78ZjWQ3zL8IViBVAXnUwesqAjdDPJZXKJ/6nfss8qaw++MQxaaODSH
         PYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF0q91gE6/DU/u+b64tdQS2nGcAwPPaJuwduhlMPOWI7WFKwNBwb34kj+j+yDLzGdWuyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIVqeWbQCtvyjqhAjPP4gI+/Z9LzJ4UXHpsF5xm1RXsJ86m8S
	xTV9IIT64N99RGyEWyPNXDMiWJxKnTWEheTlxn7mYg2+mtjm/9IwXRohyywY9X4S6StjwKESaD6
	ADzGscBuyM7vIAO2ZkllKDdCr5/u+RfE=
X-Gm-Gg: AeBDietTIDNf7pBQqupG7SsEK9Thiwd6rY2+qwKKdIfv2rbmwKsBPHs8wz107BOvyHr
	glbhDf5As8TsPIDf+7k/GDQlyRDgBTD4apDAa75qRCZVyOPf8O6M3eWO5DyHx+nIJD8rqohPVzf
	IWc8eY0kORrmuar3OIyUChI4nbVaID9teXwVGo0dDMdmmGdDtRae01fjgaENcayDSOWm0LIQ+Xq
	t6kIVATA6I4dX572A/AX0KMZfRmZHx/RMaKjsWnSo3niVbxBE2LxFFxaUvqzin5TnYxnnx0so75
	NW0HCakok8Do5DFSUROi8GrgVKibTA67T5reyDg84B6PaX2OXUp+owzaG9NqskwCJ8SHhtL/A2P
	zWS1BzubUvvU/XFNXjnXLrhC30g==
X-Received: by 2002:a5d:5d0f:0:b0:439:bdba:56be with SMTP id
 ffacd0b85a97d-43d2927707dmr29383091f8f.10.1775660719956; Wed, 08 Apr 2026
 08:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405172611.1336162-1-yonghong.song@linux.dev>
 <adcc0eb54109467ffa3e970608a73ba0b39230928555d09663cd771441c010dd@mail.kernel.org>
 <2701e70f-826c-4e85-a577-e6358401b44f@linux.dev>
In-Reply-To: <2701e70f-826c-4e85-a577-e6358401b44f@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Apr 2026 08:05:07 -0700
X-Gm-Features: AQROBzDIoeH_703QO9jB-H0bW0BlSdP1jikNnfnG24yw1DBRxOv9pxzbFPSJhrE
Message-ID: <CAADnVQLY2Ff-mVG4a8cVvmJ=HYPWQR6-NZWYz0-NnrLaVpb_BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 05/11] bpf: Support stack arguments for kfunc calls
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 9:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> In the next revision, I will discard this patch and implement it properly=
.
> In most cases, for related functions w.r.t. stack argument validation,
> I will ensure functions has parameters like (reg_state, regno, argno).
> If the argument is a stack argument, regno will be -1 (not a register).
> In cases where argno is not really available, argno will be -1. But in
> any case, at least one of them is positive. The verification log will
> print out message properly. If regno is non-negative, log 'regno' is need=
ed.
> Otherwise, log 'argno'.

that also sounds quite hacky.
Just pass two reg_states for reg and for next reg,
and argno of the first reg. That's it.
argno is always valid for printing and argno+1 is also correct number.
Both reg and next_reg are also always valid pointers
that get_kfunc_arg_reg() returned.
