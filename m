Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA130BB9B
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306373; cv=none; b=jTF5sAvfqapzm9IdHvwjT2yagG74hU6NiEvWz7MOkToMzTnhr9vMTGvV6FLLfcnnxzkn8TIQLUZdjkWDHrNbmOxjVl9oHaWYOj4UhgM73q8esnI1D9c0WSRweQolduaBqZU4fkOJWF3ELTBtPnhmOJgD+9Biv6dehaYIIcJpuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306373; c=relaxed/simple;
	bh=aZo4CfPz64jb8YX9fZTkSmpIjaX3+9pLmtrcV93cUbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq8FNW/pj7L1JeCztoBNWn9gzHPB+E/m2PfNzcqNYo9UvbPL4DTyElSdRWb2GW8HYl9hk1wRL7ePgP9H8gaKpZiGqR60YYajFXxtnVb4JPmyiISLI1W779/wg6jyxQGcEKeAyKLUooSeVd5YYlJT74uEYO1EIpdP9zbB5vMLoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z3e8DwsW; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z3e8DwsW"
Message-ID: <31243215-918a-4f03-917b-de869b7b7bf1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774306370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8Ka4SY63TMkmYUtleL7Ko7Nb4LY2LzQW7pxbDpjBzY=;
	b=Z3e8DwsWLTCq8255/3q/VJFN7cEE632K47hwxkWvDUOUDI6C2DAJb1cLGc1aF6uzI0dGaY
	Jsrh/h9oCbB8mtHMjqLC0VZj7NaraKxZWBLj3/q4fYDuXhSD2M60NDulFMAo4FkrtCV5YP
	/UwiUvmtdy88TGhkLUPe/Tgcm8zmzv8=
Date: Mon, 23 Mar 2026 15:52:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] selftests/bpf: Initialize operation name before use
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
References: <20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com>
 <20260323-tools_build_fix_zero_init_bpf_only-v1-5-d1cfad2f4cd1@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260323-tools_build_fix_zero_init_bpf_only-v1-5-d1cfad2f4cd1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/23/26 8:40 AM, Leo Yan wrote:
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
> index aaa2854974c0a91cbbb9fc13ae0f966de1bcc818..dcbe2ef995c5b211c2b86b9555c02144e11ee7d6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
> @@ -317,6 +317,7 @@ static void verif_btf_log_subtest(bool bad_btf)
>  	res = load_btf(&opts, true);
>  	ASSERT_EQ(res, -ENOSPC, "half_log_fd");
>  	ASSERT_EQ(strlen(logs.buf), 24, "log_fixed_25");
> +	snprintf(op_name, sizeof(op_name), "log_fixed");

You should use strscpy() here.

This patch looks very unrelated.
Did this surface only after the changes in the makefiles?

>  	ASSERT_STRNEQ(logs.buf, logs.reference, 24, op_name);
>  
>  	/* validate rolling verifier log logic: try all variations of log buf
> 

