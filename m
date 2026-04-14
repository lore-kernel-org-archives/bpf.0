Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124E30C629
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198541; cv=none; b=PMWWPcPZ6mYeefTFL7d2TQiB8da65rghVl+BoLVw1PmGsEmo5X81pJ76KGqYGAzovFMPQyBMcSsfiBpAJk3Kq/YhscfA8AMgO/sFYu7MkHfcGV63IeLLTSsvhER1G0rvlDfDjImP8dTPY+Lagt/dojhK20FLCSH2YHzIP2pzvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198541; c=relaxed/simple;
	bh=a3EgQ/G6q2PTzxabY6WD8JWFVutUzpRYI3bAVGyXnbE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n5P1/H6lXt7VRzLgWJI6GhO+doI4jBPFf622Lvs1Bg2KaEKV+KRN0IXe4XPfhFQKdzDphQYhBjYf99FImTe9uUTkCW5AeQUvqK5M/qzxr63CP3OABJvy3ikqAv4hionpTninOD52C+Ia5hirGCP4pQQ87ItPV9zAegrUhQreKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkplo9/4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkplo9/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679B2C19425;
	Tue, 14 Apr 2026 20:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776198541;
	bh=a3EgQ/G6q2PTzxabY6WD8JWFVutUzpRYI3bAVGyXnbE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hkplo9/4CludIhqfwPcbP5kMxEAQyn1c6+iC4vSRW0N6K9sJdbgII8EJ9wR11iNGE
	 ZP7rvuGFPeb0c9lEZzS4W3row0oM4SA+v/7TgPCN2GanNxDZJDHl+3C86axZAzqpNn
	 kxBYLR12HPn+qnEyzDnReEFGHTDjG6nwy1f5476io7ZD687F2evWpR+KHUtHGTSPI9
	 7S+C8TO5LZ01EU8eSx5wKtG91uC3BLXcVFegc7pPT8cCgL7Y33wS2barN8+ph5yJCz
	 kzvsqfce8uNW2kXed6kI7wZvy4q1fLitPEIYfbrtBJ/bDW4IgCkvpG9XDM2v5hdWcJ
	 as4gtVqktrQgA==
Content-Type: multipart/mixed; boundary="===============3946692311901188502=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3980e25bb714eb481b5c90ff23d5ce1beb39f94267394f8459dab233b668ad54@mail.kernel.org>
In-Reply-To: <20260414194804.1428676-2-jolsa@kernel.org>
References: <20260414194804.1428676-2-jolsa@kernel.org>
Subject: Re: [PATCH bpf 2/2] libbpf: Prevent double close of btf objects
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Apr 2026 20:29:01 +0000 (UTC)

--===============3946692311901188502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b60ac8094a9e..33e7a09915dd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5825,7 +5825,7 @@ static int load_module_btfs(struct bpf_object *obj)
>  		if (err)
>  			goto err_out;
>
> -		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
> +		mod_btf = &obj->btf_modules[obj->btf_module_cnt];

[ ... ]

> @@ -5835,6 +5835,7 @@ static int load_module_btfs(struct bpf_object *obj)
>  			err = -ENOMEM;
>  			goto err_out;
>  		}
> +		obj->btf_module_cnt++;
>  		continue;

The fix looks correct.  Would it make sense to add a Fixes: tag?
The double close was introduced when fd tracking and the err_out
error path with close(fd) were added to load_module_btfs():

Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24420241619
--===============3946692311901188502==--
