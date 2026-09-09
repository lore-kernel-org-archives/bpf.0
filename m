Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3817DFFA;
	Wed,  9 Sep 2026 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788930140; cv=none; b=ZDROfcVGOSlA1nVD6zA9HYQfZhF0yMgIQe3W9pe1F0wNHoeBC7wMOahSCgksWiUmEtGp5txhyz8MLc5UNl5jZZAqh9KRxj2Q3BvErWS7qdkVu1rSVhb247SD5KmT9KxUkzrxMR2wDpkN0QRSED9QfUKjCsJeiMah5HD9ZsjmOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788930140; c=relaxed/simple;
	bh=EbQKPk8Edtr8+SbwXIm5uJcFAa79MqHyJzFocHtRzgk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q+tTKF0XjLJRXzLlwK4wwE2dxt4Zj9MOBiDrvZ13ddoYAASBvfeb0DvcqrHXc6LIiRS9woRFHsrn7UDwTEDvIATjvzfjhBJESpu1NG90vMm+jJzznU2hw1hcA1ULWsJOsmAqvPpblakNzsqcMQXKTeGHpReZXnYRu1EQnGpEosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxBOvtcY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxBOvtcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79551F00A3A;
	Wed,  9 Sep 2026 05:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788930139;
	bh=T8Bla745+w/b0iArnpuRM8La28Hu6qO74a4kNJJ8Du8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cxBOvtcYZZF0grfnjCtt0K6OBFzbzAfYIMbbbld256UPz/LXKoeC5+pyzsCw43MyL
	 /4+txAEaw+wDtW+MgGxZnrp5iIh2RMJ8Fr4g7tnGauiXlfHVHjj3vyQOE8hj/Pk+0U
	 CXosXmz+E7CIwQm4abm/JeyiLj8GXQH2z1RopzamrrDUBIC2CZ9LUDXHNa7vrluT+H
	 LS0GkEGlC2IDDJ/GDljiBmRrP4TOKT17/2eo8ecSEwOl2XH4IxXinf6tGnyZStaBsQ
	 m5h9qMXeUeTr5fn3MN0iaKApjUGB9Vz/gdw7+K0c/k424Ihinw1S6EGgxeq2K3GwVU
	 mBpGM6+5FUaAw==
Content-Type: multipart/mixed; boundary="===============1148094006327105392=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <215847032d4dff7aca8efa133be82c023c10397517d285aac794ecb92622846b@mail.kernel.org>
In-Reply-To: <20260909042433.1775591-1-tweek@google.com>
References: <20260909042433.1775591-1-tweek@google.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpftool: Skip non-autoload programs when generating light skeletons
From: bot+bpf-ci@kernel.org
To: tweek@google.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,tweek@google.com,kpsingh@kernel.org,leon.hwang@linux.dev,emil@etsalapatis.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 05:02:17 +0000 (UTC)

--===============1148094006327105392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521..e9a1a018f270 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -701,9 +710,9 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>  		obj_name);
>  }
>
> -static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *header_guard)
> +static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *header_guard,
> +		     const struct gen_loader_opts *opts)
>  {
> -	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
>  	struct bpf_load_and_run_opts sopts = {};
>  	char sig_buf[MAX_SIG_SIZE];
>  	__u8 prog_sha[SHA256_DIGEST_LENGTH];
> @@ -712,19 +721,6 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  	char ident[256];
>  	int err = 0;
>
> -	if (sign_progs)
> -		opts.gen_hash = true;
> -
> -	err = bpf_object__gen_loader(obj, &opts);
> -	if (err)
> -		return err;
> -
> -	err = bpf_object__load(obj);
> -	if (err) {
> -		p_err("failed to load object file");
> -		goto out;
> -	}
> -
>  	/* If there was no error during load then gen_loader_opts
>  	 * are populated with the loader program.
>  	 */

This isn't a bug, but now that the bpf_object__load() call moved to
do_skeleton(), would this comment be clearer next to the new call site, or
reworded as a precondition on the opts parameter? The comment currently sits
at the top of gen_trace() followed immediately by another unrelated comment,
and a reader has to look at the caller to find the load it refers to.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34311359322
--===============1148094006327105392==--
