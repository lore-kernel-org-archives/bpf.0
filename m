Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEF2C028F
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302891; cv=none; b=uxzBfmzM+tsDXh8ucVv+J6d24kseVgZ+x7H90cSzTXAhjLpCdZGYiGNJFrV0HSWlIJS9DdH7udibwIzhzZYlCm2bDWHtP5v5Ktl+p11la0JETjauFgyoMe28Gq0m7iKXplEYo5uiEe+tPiwShab7ZUE4baE+muJSn94i987LwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302891; c=relaxed/simple;
	bh=4lBsiXPh5PSJwwZ17GXGSIInD1RzTv/lnsBFp7HEEGE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ea1HsIX5cV9uiBamUk8MRwTGI75ljwxrkH+uu66HoCBmnAovrhWXIteDFj1H2rf3leicXSusIRoEPlWdeKeyHmPSKePu0EawP93bvdbh4kefIdL3hSm2nrIdeJe1r2ffMgi6ZLeMwys/svG/QwnafrmLiR2wgHOlDhpgK4zIbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLTLwffi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLTLwffi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29751F000E9;
	Wed, 24 Jun 2026 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782302889;
	bh=ZwVEK/39LibKgWbbYp2StzrnoGvrAgoyBTzAD45+e8k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aLTLwffiL/8jT0uKei7w+CLbnur9qxYBY0qJBVsQCeHju9u/mOfIfo3iTE4pDeJOs
	 mtu0A4y1ofLpHMDnksi6kcjKNO6yOQ3vJzeZ9hoQUMdK6XJJw4YeIAzifUuoTJRBEy
	 R4TNnTQe8ZK6LM/rpWnY/RMVBrKc6/TzTaq+1IQWrq2upah9GFNQn+8z5DCJIcxgbc
	 o6bSZw8N1zSs4WdsJa7xYTR5Rux4nvLxdPMfv1E17JaFnadwOF8tNBzCD1sMpfUaxo
	 k9OyCV0kf+QDCfvp931na+P0rxGcPk9gxFvf0DwhG1h7yGyiKGV49h9CzBIAkQLzOR
	 X4P5NiOJ2vULw==
Content-Type: multipart/mixed; boundary="===============0348888607812197079=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <edeee3f4b5952b97b36c49dc4be3146882ed97d3d1199efe702e870741e32ab9@mail.kernel.org>
In-Reply-To: <20260624093638.117062-6-lange_tang@163.com>
References: <20260624093638.117062-6-lange_tang@163.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: add tests for bpf_strpbrk
From: bot+bpf-ci@kernel.org
To: lange_tang@163.com,ast@kernel.org,andrii@kernel.org
Cc: yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,tanglongjun@kylinos.cn,lange_tang@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 24 Jun 2026 12:08:09 +0000 (UTC)

--===============0348888607812197079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> index 300032a19445..959ff37110a1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> @@ -20,6 +20,8 @@ static const char * const test_cases[] = {
>  	"strspn_accept",
>  	"strcspn_str",
>  	"strcspn_reject",
> +		"strpbrk_str",
> +		"strpbrk_accept",

This isn't a bug, but should the two new "strpbrk_str" and
"strpbrk_accept" entries use a single tab to match the indentation of
the other entries in test_cases[]?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28095722357
--===============0348888607812197079==--
