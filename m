Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24FEE55A
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774648467; cv=none; b=OY5KHKY8JbM9zlk12Tp8UBDyJdEfaymXKl+twHff0g0JXsLq+4bTmPu90DlC4MGIeLwphZAeGBmHDle19e+GR8609sByDaZ2uuqZYmeg91zWd4D9q3b9IjxcpZZAMU+UidUwHfQFWZikLAZVFXfO85vE2aAhj4PokDoutB+VUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774648467; c=relaxed/simple;
	bh=PzIfT/SGVlPVUFWea3bKtjzb1pPKGOPSS7glYe3VIXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiJ7XX60UuxYR3LAFUsvxKInsCWXNs7RKuBPpqtbr5BWHsULcWdS/7zI756IjfBLawdfUEuCNE5ZWUgRqSvZWU3gI8OCAMq6LUt+u5BvP1C3LMU/05xpNpLJz35+XQMykRDjFq+cjSGCEADUWZc9pK7C9G/ROUHKU/G17+KZAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ig8xmTHo; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ig8xmTHo"
Message-ID: <e3db8a52-e526-403f-9eaa-215e4f364bb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774648463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcKIa6gNr+MZhhhIAoai0/OwIjK0pK6LDuXJ3p5LXYs=;
	b=Ig8xmTHo5qAXb2RyYsWg5+Vy3ZIJGKVKE2vnBKzP/wlYx3CsBuYvvmt96g3SrM+gSCVBMT
	sAA7o/K9GzZrgj6VJMrV8Rtpf704oK5+FKGCgEOCXZZ6cjp5+wMiKyo4vHmUIWhVhYU5gi
	tLXuQkf8uVRzzW9sat/my6e8z57uIJ8=
Date: Fri, 27 Mar 2026 14:54:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] selftests/bpf: make str_has_pfx return pointer past
 the prefix
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, cupertino.miranda@oracle.com
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
 <20260326-selftests-global-tags-ordering-v1-2-5dd2ced5d9ad@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-2-5dd2ced5d9ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/26/26 10:39 AM, Eduard Zingerman wrote:
> Change str_has_pfx() to return a pointer to the first character after
> the prefix, thus eliminating the repetitive (s + sizeof(PFX) - 1)
> patterns.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_loader.c | 41 ++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 338c035c36884c02ac57cd17110122c10b4858e4..f1eb99f829e112f0e738bfe44e7e61a49120ec85 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -11,8 +11,12 @@
>  #include "cap_helpers.h"
>  #include "jit_disasm_helpers.h"
>  
> -#define str_has_pfx(str, pfx) \
> -	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
> +static inline const char *str_has_pfx(const char *str, const char *pfx)
> +{
> +	size_t len = strlen(pfx);
> +
> +	return strncmp(str, pfx, len) == 0 ? str + len : NULL;
> +}
>  
>  #define TEST_LOADER_LOG_BUF_SZ 2097152
>  
> @@ -452,8 +456,8 @@ static int parse_test_spec(struct test_loader *tester,
>  			continue;
>  
>  		s = btf__str_by_offset(btf, t->name_off);
> -		if (str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX)) {
> -			description = s + sizeof(TEST_TAG_DESCRIPTION_PFX) - 1;
> +		if ((val = str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX))) {

Personally, I don't like assignments in the if expressions.
For example, this is annoying when you are stepping in the debugger.
But who does that in 2026, right?..

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> +			description = val;
>  		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
>  			spec->priv.expect_failure = true;
>  			spec->mode_mask |= PRIV;
> @@ -530,29 +534,24 @@ static int parse_test_spec(struct test_loader *tester,
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= UNPRIV;
> -		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
> -			val = s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX))) {
>  			err = parse_retval(val, &spec->priv.retval, "__retval");
>  			if (err)
>  				goto cleanup;
>  			spec->priv.execute = true;
>  			spec->mode_mask |= PRIV;
> -		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV)) {
> -			val = s + sizeof(TEST_TAG_RETVAL_PFX_UNPRIV) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV))) {
>  			err = parse_retval(val, &spec->unpriv.retval, "__retval_unpriv");
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= UNPRIV;
>  			spec->unpriv.execute = true;
>  			has_unpriv_retval = true;
> -		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
> -			val = s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX))) {
>  			err = parse_int(val, &spec->log_level, "test log level");
>  			if (err)
>  				goto cleanup;
> -		} else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
> -			val = s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
> -
> +		} else if ((val = str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX))) {
>  			clear = val[0] == '!';
>  			if (clear)
>  				val++;
> @@ -577,8 +576,7 @@ static int parse_test_spec(struct test_loader *tester,
>  					goto cleanup;
>  				update_flags(&spec->prog_flags, flags, clear);
>  			}
> -		} else if (str_has_pfx(s, TEST_TAG_ARCH)) {
> -			val = s + sizeof(TEST_TAG_ARCH) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_ARCH))) {
>  			if (strcmp(val, "X86_64") == 0) {
>  				arch = ARCH_X86_64;
>  			} else if (strcmp(val, "ARM64") == 0) {
> @@ -596,16 +594,14 @@ static int parse_test_spec(struct test_loader *tester,
>  			collect_jit = get_current_arch() == arch;
>  			unpriv_jit_on_next_line = true;
>  			jit_on_next_line = true;
> -		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
> -			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
> -		} else if (str_has_pfx(s, TEST_TAG_CAPS_UNPRIV)) {
> -			val = s + sizeof(TEST_TAG_CAPS_UNPRIV) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_BTF_PATH))) {
> +			spec->btf_custom_path = val;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_CAPS_UNPRIV))) {
>  			err = parse_caps(val, &spec->unpriv.caps, "test caps");
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= UNPRIV;
> -		} else if (str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX)) {
> -			val = s + sizeof(TEST_TAG_LOAD_MODE_PFX) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX))) {
>  			if (strcmp(val, "jited") == 0) {
>  				load_mask = JITED;
>  			} else if (strcmp(val, "no_jited") == 0) {
> @@ -635,12 +631,11 @@ static int parse_test_spec(struct test_loader *tester,
>  					      &spec->unpriv.stdout);
>  			if (err)
>  				goto cleanup;
> -		} else if (str_has_pfx(s, TEST_TAG_LINEAR_SIZE)) {
> +		} else if ((val = str_has_pfx(s, TEST_TAG_LINEAR_SIZE))) {
>  			switch (bpf_program__type(prog)) {
>  			case BPF_PROG_TYPE_SCHED_ACT:
>  			case BPF_PROG_TYPE_SCHED_CLS:
>  			case BPF_PROG_TYPE_CGROUP_SKB:
> -				val = s + sizeof(TEST_TAG_LINEAR_SIZE) - 1;
>  				err = parse_int(val, &spec->linear_sz, "test linear size");
>  				if (err)
>  					goto cleanup;
> 

