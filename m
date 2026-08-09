Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFD36194C;
	Sun,  9 Aug 2026 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786292422; cv=none; b=F//dYnSa12vK0M3Q0IhnPMNZoOJwYmRnhxq1qn7xyvM2STiKm+QLlsvnihXm5yQ5ViprQulyMy6KdZW2l49unWfXVsz/HfJdOTGFYRNDNHUxXllKaXT1v4k3K2+dDBI/zOcGfiUX+KHWK91JhpwMCnfURfLenoJ93pBaxrmepq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786292422; c=relaxed/simple;
	bh=ZoMVShsgo5titeaqyaFB4y+qkQWlxQf5qHunHu/TW1Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pDeQQeOvtGXBYxdq9tvsZWzgIbUi4UIRkhho3Dg3bjsx/QDiaYpVUZOozjzdNvw2VUQgETiGbEusirG4eBN1rYfkNanT6Xxw/L8JPGT/HmrZw8YvDh+mJRLGy8d25qe7WUvYAw4aXPm3cQVsC8oemnLKBBqZOsnjMFGf+pVD1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv+B6q+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv+B6q+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137F81F000E9;
	Sun,  9 Aug 2026 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786292420;
	bh=8+IlWCDAvrEay9/16B5gInFJjcrLCbG8LF5/cgg6JA8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jv+B6q+Rcev1sc6wrfs3cyfnl7U0Lb0BUSpEligbf+0+pkkuuq/CxuAeOMh59+buH
	 LtcV/LV1uyX8J+WQMqQJInWQF18U/y2rH7WEobzJz0lgAQsxZqDBj+iqs2Mn+Kr3yO
	 dIG69Vu4ETyOZD2Of+Nqe/gA2C21YH/ktfqq1N3syWyOhDvDgMVPdpGup+4Sc8gwft
	 SCixcOyiQH1c+txT7KDoZacU1X054LId5cUXKH3KoOUeOZy7Hog5/jRdmo3EiVuTAi
	 XHxIeip5HfEhKwdxrFSxGb2cIqF92eNDP2lPocbhzXAtu7xXxy0GQgZklJGhyVHwHK
	 RAmA540xObDig==
Content-Type: multipart/mixed; boundary="===============7933276134542316556=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <64e207da37d7fd430e941082680bc7d32ee40ef7098bc40c5bf2c9d318c37e5c@mail.kernel.org>
In-Reply-To: <20260809150111.45000-11-leon.hwang@linux.dev>
References: <20260809150111.45000-11-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 10/13] selftests/bpf: Add tracing_multi bpf prog cookie test
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,yatsenko@meta.com,avinash.duduskar@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,jordan@jrife.io,rongtao@cestc.cn,eyal.birger@gmail.com,pulehui@huawei.com,tanjingguo@huawei.com,malin89@huawei.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  9 Aug 2026 16:20:19 +0000 (UTC)

--===============7933276134542316556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index 5cf11707eaf89..070266a864d4f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -304,9 +304,12 @@ static int run_bpf_target(struct bpf_program *prog, __u32 retval, const char *na
>  	return 0;
>  }
>
> -static void test_link_api_bpf_prog(void)
> +static void __test_link_api_bpf_prog(bool test_cookies)
>  {
>  	const char *funcs[] = { "target_1", "target_2" };
> +	__u64 fentry_cookies[] = { 0xfeed01, 0xfeed01 };
> +	__u64 fexit_cookies[] = { 0xfeed02, 0xfeed02 };
> +	__u64 fsession_cookies[] = { 0xfeed03, 0xfeed03 };

A subsystem pattern flags this as potentially concerning: every per-target
cookie array holds the same value twice. The test on the BPF side compares
against a single scalar global set from element [0]:

  skel->bss->fentry_cookie = fentry_cookies[0];

and in progs/tracing_multi_bpf.c:

  if (!test_cookies || bpf_get_attach_cookie(ctx) == fentry_cookie)
          test_result_fentry++;

Since cookie[0] == cookie[1] for all three arrays, the test cannot
distinguish a correct cookie-to-target mapping from a permuted one. The
assertions (test_result_fentry == 2, etc.) succeed as long as some
correct-looking cookie value is delivered on both invocations, but swapping
the cookies of target_1 and target_2 in the kernel is invisible.

That matters because the kernel path this commit exercises is exactly a
permutation: bpf_tracing_multi_attach() calls check_dup_keys() which calls
keys_swap_r() in kernel/trace/bpf_trace.c to reorder the cookies, ids, and
progs arrays to follow the sorted trampoline keys:

  id_a    = ids + (key_a - keys);
  if (data->progs) { ... swap(*prog_a, *prog_b); }
  if (cookies) { cookie_a = cookies + (id_a - ids); ... swap(*cookie_a, *cookie_b); }

An indexing mistake in that swap could desynchronise cookies from progs/ids,
yet the test would still pass. Since fds[]/ids[] come from BPF prog FDs, the
sort order is not the array order the caller supplied.

The neighbouring test for kernel-function targets in this same file already
does this correctly: bpf_fentry_test_cookies[] uses ten distinct values
deliberately out of order (8, 9, 7, 5, 4, 2, 3, 1, 10, 6) and
progs/tracing_multi_check.c checks the cookie per-IP with something like:

  err |= test_cookies ? cookie != 8 : 0;

under `ip == &bpf_fentry_test1`.

Can the test use distinct cookies and a bpf_get_func_ip()-based per-target
expectation so it is sensitive to cookie mis-association?

>  	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
>  	struct tracing_multi_bpf *skel = NULL;
>  	int fds[ARRAY_SIZE(funcs)];

[ ... ]

> @@ -356,6 +367,16 @@ static void test_link_api_bpf_prog(void)
>  	tracing_multi_bpf__destroy(skel);
>  }
>
> +static void test_link_api_bpf_prog(void)
> +{
> +	__test_link_api_bpf_prog(false);
> +}
> +
> +static void test_cookies_bpf_prog(void)
> +{
> +	__test_link_api_bpf_prog(true);
> +}

This isn't a bug, but would calling __test_link_api_bpf_prog(false) and
__test_link_api_bpf_prog(true) straight from the two subtest arms read more
consistently? The neighbouring test_link_api_ids() is dispatched directly as
test_link_api_ids(false) and test_link_api_ids(true) just a dozen lines
down, without wrapper functions.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31320427087
--===============7933276134542316556==--
