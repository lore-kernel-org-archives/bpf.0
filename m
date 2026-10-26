Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012310;
	b=QWrTX2WrGL7ahxsGtfAkiAnjfvVgBog1oEL8AW9bqeykWaLFJ6FihjxAt3qhUCbn08k5
	 wktbRkGP55y1k2XJBC47JgGGU67EPs1p1jHqM7QKuO9ItsSCvmIvXBag/BeSynKDlRYaS
	 LpBotOg/9PY6UsoXK4tiM32WNPjDuvmcSf0wZ3M2ZhMdgeE8sNIUP9SJtXvTGsebqajDe
	 UpSoeUGIJKNXU4z2ogwZXThc5vqie08flTW34H2f3q0DV+7eKX9tlnFeRDUbfbg68QTjb
	 YeDImB3xoqgPE7KXIVw31o57xNR5qoI4e+TvA1/+lwuhTiegJGOj7WOaY4n0hQVDiLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012310;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=K+Yo9AfgBYCQQPg349B4iNZddsMgsiAX+VK2TRMdUgA=;
	b=GwSe+p/yZ3YBtoyKNycG6UagJ+gxmvBDFlAP39zaflQYPZUzIEYbpj4XxBIdPQf4KNmp
	 7Ww1h3MKP7yx0+djiyGozgRAs11BNlXwfrdxKtp5dJoKvdnsHAoq4Bfp7VjatKbW07kvY
	 QfnfZV4uQrO1qOPz2cXT7dRLTeL54br8AFXC39/1pScx/KnclAxwidKfdFni+lc4gmm1/
	 7zfmio7opSbwtFRZEaWQUXJZi2aYbcZvYf0QWTVZyhUHKSD59jtHlgw9dswHqdSNTQR2X
	 8rw51z9SGgG3k0wCOcIZ7cx52cY8ddMJK+x9pe9aEwmEVRF1sGjjWtspkJ6/8Vu04IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqbfLLRV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F2606A31B;
	Mon, 26 Oct 2026 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqbfLLRV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE161F01825;
	Mon, 26 Oct 2026 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012309;
	bh=K+Yo9AfgBYCQQPg349B4iNZddsMgsiAX+VK2TRMdUgA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RqbfLLRVlyH7GstXhr6fF9lEhVYgUIapphRe/P81YcGFINT+z6Fhe+lBJsgn3rMWz
	 nwPcI/HcXSZLq4QV6LbqzF9rK8XtphsImEu3BLIYRJovrFr9vyf9Xs6PuuRt+L2lQs
	 Zg3AMz9M2A5pC0eWwAKisCiZWiYxpk5oWXjthXBh8D9qPIyl5orSZle8QQfsbXwzty
	 y2aL31Ujc54I2eI029xYLGpwylZOTerNomlZgooFoQQXYLwHhbKBEq5+v2pEFuCahV
	 J8p3gG36je/h1ao/NDOSxh3pmDCEVX5k5Xo4njrbndApsmsVN2IUyxBoaFjzKwpD9p
	 P9KRVBQabzHVg==
Message-ID: <88626067-69c0-4487-98b0-f68eb8c5e36c@kernel.org>
Date: Mon, 26 Oct 2026 10:58:24 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: fix line info in multi-function CFG dumps
To: Eduard Zateev <hackerowskiy@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261024062329.264086-1-hackerowskiy@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261024062329.264086-1-hackerowskiy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-10-24 08:23 UTC+0200 ~ Eduard Zateev <hackerowskiy@gmail.com>
> The CFG dumper computes BTF line-info offsets relative to each function, but bpf_prog_linfo__lfind() expects offsets from the start of the whole program. As a result, line annotations in later functions can resolve to source lines from the first function.
> 
> Pass the program instruction base to the graph dumper and use the global instruction offset for line-info lookup and display. Keep function-info matching relative to the function as before.


Please wrap your commit description. Also capitalise your title , and
target your patch to the bpf-next tree ("[PATCH bpf-next v2] bpftool:
Fix line info...")


> Add a selftest with a BPF-to-BPF call that checks the second function source line in visual output.
> 
> Link: https://github.com/libbpf/bpftool/issues/178


Thanks for picking up this issue. Since you found that page, you must
also have seen the patch I posted there, and on which yours is based, so
some crediting would be appreciated.


> Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
> ---
>  tools/bpf/bpftool/cfg.c                       | 19 +++++----
>  tools/bpf/bpftool/xlated_dumper.c             | 10 +++--
>  tools/bpf/bpftool/xlated_dumper.h             |  3 +-
>  .../selftests/bpf/prog_tests/bpftool_cfg.c    | 41 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/bpftool_cfg.c | 16 ++++++++
>  5 files changed, 75 insertions(+), 14 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_cfg.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpftool_cfg.c
> 
> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c

> diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h


The fix itself looks good to me.


> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_cfg.c b/tools/testing/selftests/bpf/prog_tests/bpftool_cfg.c
> new file mode 100644
> index 000000000..7d5b80927
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_cfg.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <bpftool_helpers.h>
> +#include <test_progs.h>
> +#include <linux/bpf.h>
> +#include "bpftool_cfg.skel.h"
> +
> +#define MAX_BPFTOOL_OUTPUT_LEN (64 * 1024)
> +
> +void test_bpftool_cfg(void)
> +{
> +	struct bpftool_cfg *skel = NULL;
> +	struct bpf_prog_info info = {};
> +	__u32 info_len = sizeof(info);
> +	char output[MAX_BPFTOOL_OUTPUT_LEN];
> +	char cmd[MAX_BPFTOOL_CMD_LEN];
> +	const char *expected = "return\\ bpf_ktime_get_ns()\\ ?\\ skb->len\\ :\\ 0;";


How did you test this? I would expect bpftool to print "skb-\>len" and
not "skb->len", so the expected string should never be found?


> +	int err;
> +
> +	skel = bpftool_cfg__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "bpftool_cfg__open_and_load"))
> +		return;
> +
> +	err = bpf_obj_get_info_by_fd(bpf_program__fd(skel->progs.bpftool_cfg),
> +				     &info, &info_len);
> +	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
> +		goto cleanup;
> +
> +	err = snprintf(cmd, sizeof(cmd), "prog dump xlated id %u visual linum",
> +		       info.id);
> +	if (!ASSERT_GT(err, 0, "format bpftool command"))
> +		goto cleanup;
> +
> +	err = get_bpftool_command_output(cmd, output, sizeof(output));
> +	if (ASSERT_OK(err, "dump program CFG")) {
> +		ASSERT_HAS_SUBSTR(output, "cluster_1", "second function in CFG");


Escaping issue aside, I don't think this check would catch the issue in
the first place? The string is present in bpftool's output regardless of
your fix. Maybe check that "return\ helper(skb);" does not appear after
the main block, instead? And please make sure to test it.

pw-bot: cr


> +		ASSERT_HAS_SUBSTR(output, expected, "second function line info");
> +	}
> +
> +cleanup:
> +	bpftool_cfg__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpftool_cfg.c b/tools/testing/selftests/bpf/progs/bpftool_cfg.c



Nit: You're not doing a generic validation of the CFG from bpftool here,
so I think the names for the new test files should be more descriptive
to better indicate what the test it about ("bpftool_cfg_func_offset.c"?)



> new file mode 100644
> index 000000000..db01f20c8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpftool_cfg.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +static __noinline int helper(struct __sk_buff *skb)
> +{
> +	return bpf_ktime_get_ns() ? skb->len : 0;
> +}
> +
> +SEC("socket")
> +int bpftool_cfg(struct __sk_buff *skb)
> +{
> +	return helper(skb);
> +}
> +
> +char _license[] SEC("license") = "GPL";

