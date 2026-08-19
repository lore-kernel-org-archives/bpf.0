Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8544239E;
	Wed, 19 Aug 2026 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132154; cv=none; b=SdSLCD/277ByvT+ewIB3bsM2PZ1mytoZ+KTdvdtUwEDiGLNeDdWDrWr7cuyqwkt4aerKfdRyjIeMIRhry0BjwU9UFgHKSE4bgkdVTNR02ZR2cdNJiyHxabrJyKNP26SjxsvjCiFUPMJXKsTzc1XC4O59WkjDqxgDGhPZ3w3s/kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132154; c=relaxed/simple;
	bh=2+BXrGkAiio0Sd9r5bNnuwMyXnKoZKRp9ywHn6QP2Pc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kXJupP1EfpmIbVtozwxoeYz+8A0bTqLMGxnPmg7LZsjzctv0/7SyLM+1Hes4/ZSzdjhgjFWs2QAorBaSmRr0k9+xgtdZSEEVxgrMEo29uTOK1Ii/4Ewb9jwxrTrDwPZLCrVhkk/cHnT72Cc7htDWZSoKKTM/NjJLOpiEAQYy9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyU14YQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyU14YQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F1A1F000E9;
	Wed, 19 Aug 2026 09:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787132151;
	bh=QytQu0s4/CoGlAPgyWbbxu5UnIxMpY2fl1gmp2WZwQY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jyU14YQuoib4XgzV5It6/lKlgNkDeyOlyGAJnk3QOOvkxu3oSTGci/sWa8vmDTBfw
	 HY1vVkFPAkiUxP30rOg+jFjD6KJX6Cgg3gGtx6hFfd7bf0pRK4P3sRTzSz3PJ/GIK3
	 KTLt9HNtRi03AQ1oUrKhxV/CvYDbKJ6O+g0FA/UhJ8xb+rimpZ9U1deb8yFaZX9dc9
	 cA40F1fkYFPM5Reh8lm/13uJdj82b5eXkuvsvg/Z4E1oOnTFG4jbAaAcSXSdrdlmnF
	 P7lIPFDvfQ4vCFnL/UqRcH3Z3Mx8yPiXzFVqf0ZTjxBnExFH6qG3sqzLzWDQaMQeFc
	 IfJuWNLzT7OMg==
Content-Type: multipart/mixed; boundary="===============5804271767251362174=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <150459b74dba9ea3f0bd133f97039f998e25830ada87b803fcbc6c77b17bcf93@mail.kernel.org>
In-Reply-To: <20260819090426.267-2-zhaofuyu@vivo.com>
References: <20260819090426.267-2-zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org,andrii.nakryiko@gmail.com,alan.maguire@oracle.com
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 09:35:50 +0000 (UTC)

--===============5804271767251362174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee..957415341caf 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -782,6 +782,13 @@ struct bpf_object {
>  	char *token_path;
>  	int token_fd;
>
> +	/* kernel module BTFs to load, as specified via bpf_object_open_opts */
> +	struct {
> +		char **names;
> +		size_t nr_names;
> +		struct hashmap *names_map;
> +	} *kmod_btfs;
> +

This isn't a bug, but since this holds module names rather than BTFs,
would a name like kmod_btf_filter read more clearly next to the existing
btf_modules field?

>  	char path[];
>  };

[ ... ]

> @@ -5851,6 +5858,121 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>  	return 0;
>  }
>
> +static size_t mod_name_hash_fn(long key, void *ctx)
> +{
> +	return str_hash((char *)key);
> +}
> +
> +static bool mod_name_equal_fn(long key1, long key2, void *ctx)
> +{
> +	return strcmp((char *)key1, (char *)key2) == 0;
> +}

This isn't a bug, but these look identical to str_hash_fn()/str_equal_fn()
in btf_dump.c - would it be worth hoisting one copy into libbpf_internal.h
instead of adding a second pair?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32236360082
--===============5804271767251362174==--
