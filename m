Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B139B94D
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498996; cv=none; b=Db0ccRbf8rbpeFkTZzHnSneZpBTbKgXeRoNADwGNNe7d8aVfY6J+GSLcKyoPLWbTP2PJBq2aKdAhG6Uu9x00BLgl64gYDT7x5+A1R18fMMaTGYh18KdL1xK7UVhENYOCYpIOdN55k4Y1dZyQ08FnizjU8Cl8Z3fe84KiLUqc2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498996; c=relaxed/simple;
	bh=h5vuphPb1apGqV5bD3P/meZO8Buwf2eaAY5dQ3dLLuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teBURzJ7WYv/ZpQJ0YCFhlhzk/gmCxhsX+lEROQEveIOFCe1fAmF8zjz/Kk8eE8q/RqAIB32f77KvIPHFNiyemIpLjqSNtR+ZAX89p72hThV+W0uxsSNilLW7zz1Clq2ksuLA35a0IJkvnaOOGraXlGHgpWLhzk5fyXBSMFkTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cPJQaJla; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cPJQaJla"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780498980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDKTuk5eBxSEX/cKCTmFa2nbbtpwD16ksPrTH+TcP+0=;
	b=cPJQaJla6UnG1SXyLnEiGJSm5eQG7ExZfhx1jyrWA/xEsp7n4vfN/FFtEO0D4PQ2CQiN86
	m2EzIUyzBK7w36kTCtf2kstZLMfoyEH9jNI+qi8amAlPYpBCkvSnlaSKOeBW36hu+y78h5
	ZB3VU1fwRn7JsRmXY1Fo2iW1HCJT+Xk=
From: Leon Hwang <leon.hwang@linux.dev>
To: Lin Ma <malin89@huawei.com>
Cc: Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	YiFei Zhu <zhuyifei@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amery Hung <ameryhung@gmail.com>,
	Rongzhen Cui <cuirongzhen@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	cenxianlong@huawei.com,
	chenzhe@huawei.com
Subject: Re: [PATCH v2 2/2] selftests/bpf: Cover tail-call cgroup storage prog-array checks
Date: Wed,  3 Jun 2026 23:01:42 +0800
Message-ID: <20260603150213.68746-1-leon.hwang@linux.dev>
In-Reply-To: <20260602073539.1567846-2-malin89@huawei.com>
References: <20260602073539.1567846-1-malin89@huawei.com>  <20260602073539.1567846-2-malin89@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, 2 Jun 2026 15:35:39 +0800, Lin Ma <malin89@huawei.com> wrote:=0D
> Add tail-call selftests for prog-array ownership when cgroup storage is=0D
> in use. Verify that loading succeeds when callers and callees reuse the=0D
> owner's cgroup storage map, and that loading fails for a different=0D
> storage map or for a storage-less bridge program.=0D
>=0D
> Signed-off-by: Lin Ma <malin89@huawei.com>=0D
> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>=0D
> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>=0D
> ---=0D
[...]=0D
> @@ -1777,6 +1874,12 @@ void test_tailcalls(void)=0D
>  		test_tailcall_freplace();=0D
>  	if (test__start_subtest("tailcall_bpf2bpf_freplace"))=0D
>  		test_tailcall_bpf2bpf_freplace();=0D
> +	if (test__start_subtest("tailcall_cgrp_storage"))=0D
> +		test_tailcall_cgrp_storage();=0D
> +	if (test__start_subtest("tailcall_cgrp_storage_diff_storage"))=0D
> +		test_tailcall_cgrp_storage_diff_storage();=0D
> +	if (test__start_subtest("tailcall_cgrp_storage_no_storage"))=0D
> +		test_tailcall_cgrp_storage_no_storage();=0D
>=0D
=0D
These new ones should stay at the tail of test_tailcalls().=0D
=0D
Thanks,=0D
Leon=0D
=0D
>  	if (test__start_subtest("tailcall_failure"))=0D
>  		test_tailcall_failure();=0D
>  	if (test__start_subtest("tailcall_sleepable"))=0D
=0D
[...]=0D
