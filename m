Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132C34FF59;
	Wed,  8 Apr 2026 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624107; cv=none; b=SzsnG819R1ssrK0+CG4leZofbIc77awiTn4JGY7b9vDVv4jCeLf93AZ0CwsrJm46RbZeCZTkgw7ITjRt4VsT8w9vYq+KUqM+BcqP1miuz9AjnBnSYNQCkaydOYQ3W0Ge7gnb9Capa1pGvhw2JpTnnHvgQKSH+wvO13QTTaEUl+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624107; c=relaxed/simple;
	bh=1tL87V+56iBo0sN9ylwGMhdt18UI7EiYrnHO+/gnJo8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F8OgQf+TFCvOw3Dmjr5WGbSRQ+S8p8wdcd3YCGD42WUAMkQRA6+Aa4Mm83XGbCtCm+dTOrAsvB3TDt+Pz/RJvdvWcz7ROp7xOeR6a12tfZEQmlsPsnFS4FmHVCN868LkvErwJP1rFcWPnpDR+3rd/ELcR/3vKVlCr5JSUKbuBcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz8grIyf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz8grIyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9A8C19424;
	Wed,  8 Apr 2026 04:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775624106;
	bh=1tL87V+56iBo0sN9ylwGMhdt18UI7EiYrnHO+/gnJo8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Pz8grIyfxziyj02Hv3x/MK5pc9djbDMC89cNQA6C2VPUXDugDGfLimyeQzD2AZWcG
	 I6yrNQ1UeGp5Y6SF0n4D879q7wHXe+PxZeXgXYYE92j4uVYA6ng7HUOhrbCxPZBILN
	 7leEhbXZo3uNTx30ZsM6587NVe99fM53C3u40Lz6p7CG8xdtn0hjVs6AZJrt6o9ylm
	 TXqq5H5GwejuFuHyfdyIjB6wgi6f0IJglLlLnTtWEkPigc7DkEuVakqTC0YBJn+J+9
	 TS4+JH9dF4mMCfIr/8MOaDgIoPMDqzViTAkeDxk8pQgz0hSVrVwEvdggyp8IS+rHiS
	 QmHaGVr2vhoIw==
Content-Type: multipart/mixed; boundary="===============3016921555867013120=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <772063b0c36262d2bee020fb590eca02ef6bfbfbecebf3a88be540b373c6ed4d@mail.kernel.org>
In-Reply-To: <20260408031416.266229-2-dongml2@chinatelecom.cn>
References: <20260408031416.266229-2-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next 1/3] bpf: add missing fsession to the verifier log
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Apr 2026 04:55:06 +0000 (UTC)

--===============3016921555867013120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> index 84ab73e08b0e6..94a62fcd4543d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> @@ -128,7 +128,7 @@ static void test_exceptions_success(void)
>  			       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
>  			       "exception_cb_mod"), "set_attach_target"))
>  			goto done;
> -	}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> +	}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);

These four selftest locations now expect the string
"FENTRY/FEXIT/FSESSION programs cannot attach to exception callback",
but the verifier message they match against was not updated. In
bpf_check_attach_target() the format string still reads:

    prog_extension ? "Extension" : "FENTRY/FEXIT");

so the kernel produces "FENTRY/FEXIT programs cannot attach to
exception callback". The RUN_EXT macro uses strstr() to match the
expected string against the kernel log buffer, and since
"FENTRY/FEXIT/FSESSION" is not a substring of "FENTRY/FEXIT programs",
strstr() returns NULL and the ASSERT_OK_PTR fails.

Should the verifier message also be updated to include FSESSION, to
match the selftest expectation? As it stands these four subtests will
fail.

> [ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24117471086
--===============3016921555867013120==--
