Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F325B0AA
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313099; cv=none; b=tlO05cjp4Q/H1vE8ZxCXRqlNIvIiGRi+d0g7rBwJ423qrAidC1cNyU8bcCNDpsJZ3XSDlFDdE8F/TiaFzd/WsDSUzCm/8DOWuCJAibk6BY6sNvLYuTxBoilX44gBVsNByrBHzJl6Gm4ggr9her6waWrOJTyVrROAt/0YPOrl79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313099; c=relaxed/simple;
	bh=3kPALoqciAvx3DHaPPfs5j5t9c/xeTNCPkJPgVQBJKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUY+P6tVwiWq26UB2qFdc3f5DIIvA7oLeYLMSBHKyRqtenlsAkCLoGVAzuLCmcmCYEwPbAzpUEUPOF/8iGpTpH70yVukmI+9qenpn70+XnkHNQJFeNdZUSwUzEG1G/bwPd9MWawH5ewwYVnSUq1MLQZM2uAnQNgtIRA28Q1JkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FCZkdplL; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FCZkdplL"
Message-ID: <d1ea947e-f54c-468f-8e26-7bac59b1d6e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781313095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84+X1Q0jO7Re73KFOwXuIPKLl/X31z7M7p9DFtbZB5s=;
	b=FCZkdplLoWoDhnnXO9ooFuhPvAjAKXbBRnV1zIMKh2nC7GUNzb4MD7xJEz0LLHFeGlscv4
	vqoCiSetjs7TBOLsOSLraj973gOQx+w0vkFb5dW+JhwDhta55c1CwbBXRPxXim4CHN1VQe
	6UiyLJjLKSV10xqRPkXLJLaKn38BVgw=
Date: Fri, 12 Jun 2026 18:11:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 6/8] selftests/bpf: Initialize operation name
 before use
To: Leo Yan <leo.yan@arm.com>, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Lorenz Bauer <lmb@isovalent.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
 <20260602-tools_build_fix_zero_init_bpf_only-v2-6-c76e5250ea1c@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-6-c76e5250ea1c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/2/26 7:47 AM, Leo Yan wrote:
> ASAN reports stack-buffer-overflow due to the uninitialized op_name.
> 
> Initialize it to fix the issue.
> 
> Fixes: 054b6c7866c7 ("selftests/bpf: Add verifier log tests for BPF_BTF_LOAD command")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/verifier_log.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> index c01c0114af1b7476d27885ce380d90400a4bdc89..4542bb586d723b8fda2faf8261066f16102c60c0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> @@ -317,6 +317,7 @@ static void verif_btf_log_subtest(bool bad_btf)
>  	res = load_btf(&opts, true);
>  	ASSERT_EQ(res, -ENOSPC, "half_log_fd");
>  	ASSERT_EQ(strlen(logs.buf), 24, "log_fixed_25");
> +	strscpy(op_name, "log_fixed", sizeof(op_name));

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

>  	ASSERT_STRNEQ(logs.buf, logs.reference, 24, op_name);
>  
>  	/* validate rolling verifier log logic: try all variations of log buf
> 

