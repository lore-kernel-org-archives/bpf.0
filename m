Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4C3D3485
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251006; cv=none; b=kbn4wd8zy2vQOq7g6siN6zDuYvbbNzTS9FMOWFi9y8Ba8//AJpvNYNzibRpDsQw2hx3rvjXbNBp2smY2J5mOC8q8ZbQhw9UiVN1rRz1zEGZ3JrbrRMVIHsBSO0SFjdb8MseE5e8Jq/VA27Ukkbjec7cw0PD6xswUL9I+JOE+1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251006; c=relaxed/simple;
	bh=t1zZ49u4vNM812x0Q94jICYdD69XTAf6sKtn+b8q59w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GDM1ta4OiCTgrfzdnUXIqB5gNj1Ta6rBP5dYwmuB/XcihJqjMy4Fyx0U3kSMCNvWSsqLF77IlKwJttg2YRZHsC24m4xcSab8Q+0IYKGFV4O8scyPi+xgOHyYi8EGovK+FRhnxyUX5jXYddZDg9cpcRC8EbYTV7r026V/EwO9OaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpxceOIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpxceOIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F521F000FF;
	Thu, 24 Sep 2026 11:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251005;
	bh=xb8dsEG977cl85zgGSOztdk7HcvlcziZLroJAwESKHw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MpxceOItXS9qgF0eWNEi/XzntuQx7HzCH5NjLI97b4wBJnpjVWgX4F5aSCu8NDoOd
	 XAbi0Vlx6+no+7WEtrlK9sHRN5UV4liq3lguBG1mT6e/oEJ70bnh1Cl0lQdAv1j1W6
	 w6vCUAi2OsXAUdWI9aNh16KPI36Z/YkPY4S1VGQoVwpMTXuDaYCUbJ3Tecdqd9lQB+
	 JRveio6T8hEYcbqK72aGx+y596o7jk7IPLVMuCG7tBTV8xHREQM0Mb02P80RnNKRmc
	 hqzPs05Nh8dA2VcciTg+OBnU9McNf4njEiXZJhZQmTG3A1p8sQZ2YwP/+PLruqWMbJ
	 TyCbj+3kUVYcQ==
Content-Type: multipart/mixed; boundary="===============6422544623325030083=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c356d962706d392c5d58e2bcba1b735e3659b3a5ac21b106f818efd439c90a01@mail.kernel.org>
In-Reply-To: <20260924111428.75957-11-alan.maguire@oracle.com>
References: <20260924111428.75957-11-alan.maguire@oracle.com>
Subject: Re: [PATCH v4 bpf-next 10/11] selftests/bpf: Test bpftool dump of BTF location info
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,qmo@kernel.org
Cc: jolsa@kernel.org,daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 11:56:42 +0000 (UTC)

--===============6422544623325030083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> index d5b25302b0c8..bed506badc75 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c

[ ... ]

> @@ -155,10 +226,46 @@ static void test_dump(const char *btf_path, bool sorted)
>  	free(dump);
>  }
>
> +static void test_loc_dump(const char *btf_path)
> +{

[ ... ]

>  void test_bpftool_btf_dump(void)
>  {
>  	char path[PATH_MAX];
> -	struct btf *btf;
> +	struct btf *btf = NULL;
>
>  	btf = mk_btf();
>  	if (!btf)

This isn't a bug, but is the '= NULL' initializer on btf needed?
It looks like btf is always assigned by mk_btf() before it is used.

> @@ -171,7 +278,19 @@ void test_bpftool_btf_dump(void)
>  		test_dump(path, true);
>  	if (test__start_subtest("c_unsorted"))
>  		test_dump(path, false);
> +	unlink(path);
> +
> +	btf__free(btf);
> +
> +	btf = mk_loc_btf();
> +	if (!btf)
> +		return;
> +
> +	if (btf_to_tmpfile(btf, path))
> +		goto out_btf;
>
> +	if (test__start_subtest("loc_dump"))
> +		test_loc_dump(path);
>  	unlink(path);
>  out_btf:
>  	btf__free(btf);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35993586374
--===============6422544623325030083==--
