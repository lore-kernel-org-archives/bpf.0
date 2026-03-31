Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745D2BB13
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958878; cv=none; b=Apjma0OKMhviKEPRLaAncr5jLS5KwY8rAVT9f+IFe7kVoU21bA4OGsWxl6sm7l3g+3bruSd5/FDQjmTnVxbYyoObaQC08RH7CsPsatPHZATh5TMj+SA1QL4Qz4GQK5V+kuQewrfF1lFN4ao4FzG4rPDTpNlTpRsaN34gE1MzAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958878; c=relaxed/simple;
	bh=aSvG8WVAjXr5PAvpVwK5ZrLATzj9ks0y2z/qX/3IZUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2/l59Z3VPQmTQSY3sQgozBPsvOtEYiXxG0nAf4AX0yGBcuBlUFoXI+oXpj4WlvO0XU2a7H5V1He4ZfhbSQQXr1TClGZ1Z7tewDach3WnGcNbdJFg5c9wWS9doSR/KsjyUz5q/Tktzz/eIVtDYtmQu1Pq9tLFByhFVQ4RrjG3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqI3iLR+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqI3iLR+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso2597402f8f.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774958875; x=1775563675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLPWs8y5iNeR1gIn8xdJtxwIx3JKTIULpGBKnCYNDB4=;
        b=kqI3iLR+owRSBrfD1VHJMXp85mdHognHFOzg5v3kvzDZhzfnIolWX6NQbN1l1p7JZ8
         CQwY/ieMpEq0Jd8r/FRg3JDT0VIwWuJm0YISt9ccgU42g7B3MLC9PyymJS8VJKZ6VYPE
         z8cTJHrB3EUpWZSO0K0IDhB5e1xj1WqvttFfZ3vSe1idYBY/J5PnLAuTg25ROvcBY4nY
         mspsHVY8oBN3N1yYgz6Je7Jv6lPOu3O2xGq+bpPLoUpmXRHjrFxeZr2/4FCovHRzOP29
         VypOfIejebS+mIKVbHt4/xWK5E6gjr6I127lRykDksUwvQcDCbvGsG6YOOGA08QZjpsW
         qCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774958875; x=1775563675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLPWs8y5iNeR1gIn8xdJtxwIx3JKTIULpGBKnCYNDB4=;
        b=OgpmP4v/lkVNfbziWvc/INQC7L7gWzAwHvLqK4Y8hdglQoLg61YvGb3bIUHf/ps/mS
         ye+4eGM++ITmlC8KT17y2J1DhaMUxM7RK+5c+m+0555UVi2ZWeLh9167c9PIiZOp8VOh
         AE7B9OKVacAo7eItUkSYmm5Z8+UJs4EmDZREGNW/1mOijId5WqZZttngvEmm/W/+WT65
         Si+PpKvCL/IuAWUUFFK353B15gsHBLiuWLD6Xq1xG1YWUo7wSDdYx4/3aH3rt1jqYFM+
         R49LENBBuH7I6PQwf4DC93IvYv8vtYiqnU3hbYbOav978NOKyan8TLwrOQVJ0EMM6f1N
         44kA==
X-Forwarded-Encrypted: i=1; AJvYcCXdbR1IznEQDBDcYdFq+3VdnhM4TjqjCVlbDPV7sWRB3v045t3pTF91ibEN+4gkpnlgSWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDoS1UDGVi775zXs10ubOMq9txoiIZFgelyidUXbB9B+CWUFb
	0OKNUHstl6SIgb7ZJl/h3qxMU9rC+u5cxCkMTSIWDYMpQVjdG+jAOETB
X-Gm-Gg: ATEYQzwjNkb3aRbas+EUu/XYNqeELxnUC6eBZxoZ3XpWm5J3wqMR/C+zqq2jAQyB1SP
	KfqYMEQq5L9xRMvPQ2i8jLfKLVmSubpwHi7rivPaKTizDDSddzxR7VSCgV6fVKKLHBbpnXEAS5k
	/utuIdfssE1Mz911tF2ubBIApRmwDjT3DYX3jGA6B0EjVSRn7Hd4OuKk5ObwUzTelsSfc0WNsvN
	JiXAhjae1bM713LcUkV6aBQRp5qGcMFAInDX5/fLuor3gn7aobFVGyeLQZ/8qc02TOJafHDSl3t
	1HXg0boLytr7C+qM/FWJYfBGq5cQQW8pzTJJ1E4J69t1Sf44rxS+BULleGdAbWJz/9YUjB858Lb
	RBC6I8LTX3A2gIVA8Y6dSbWPnV1BtXJJBes81Dd4XiByfNL4F0zHYtvDk8vVmhoXpGfXzFVvZ9D
	Z1yrDIa24Y3sR6D8c7Wva9fSwALdsL8jcMrmj0/M+OjVmEQNP7NUVWA5IqJnJbZIi4gS1MNVYch
	j5QpDTM3xE=
X-Received: by 2002:a05:6000:420b:b0:43b:3d80:b0b9 with SMTP id ffacd0b85a97d-43b9e99734dmr27663297f8f.12.1774958875223;
        Tue, 31 Mar 2026 05:07:55 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21ebef9sm28088803f8f.13.2026.03.31.05.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 05:07:54 -0700 (PDT)
Message-ID: <8d5d1ec4-7277-4b11-badd-f61fb1bde10a@gmail.com>
Date: Tue, 31 Mar 2026 13:07:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: make str_has_pfx return
 pointer past the prefix
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com>
 <20260330-selftests-global-tags-ordering-v2-2-c0ac61e81098@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260330-selftests-global-tags-ordering-v2-2-c0ac61e81098@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/26 1:59 AM, Eduard Zingerman wrote:
> Change str_has_pfx() to return a pointer to the first character after
> the prefix, thus eliminating the repetitive (s + sizeof(PFX) - 1)
> patterns.
> 
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/testing/selftests/bpf/test_loader.c | 51 ++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 338c035c36884c02ac57cd17110122c10b4858e4..50ca1b6ec8150efe2cb280667af9ac4972c28657 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -11,8 +11,12 @@
>   #include "cap_helpers.h"
>   #include "jit_disasm_helpers.h"
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
>   #define TEST_LOADER_LOG_BUF_SZ 2097152
>   
> @@ -161,21 +165,21 @@ static void free_test_spec(struct test_spec *spec)
>   static int compile_regex(const char *pattern, regex_t *regex)
>   {
>   	char err_buf[256], buf[256] = {}, *ptr, *buf_end;
> -	const char *original_pattern = pattern;
> +	const char *original_pattern = pattern, *m;

super nit: what does m stand for? Something like `next` would do better, 
wouldn't it?

Overall refactoring looks correct, all callsites of the str_has_pfx() 
are modified, except one in parse_int(), but it's correct anyways.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>   	bool in_regex = false;
>   	int err;
>   
>   	buf_end = buf + sizeof(buf);
>   	ptr = buf;
>   	while (*pattern && ptr < buf_end - 2) {
> -		if (!in_regex && str_has_pfx(pattern, "{{")) {
> +		if (!in_regex && (m = str_has_pfx(pattern, "{{"))) {
>   			in_regex = true;
> -			pattern += 2;
> +			pattern = m;
>   			continue;
>   		}
> -		if (in_regex && str_has_pfx(pattern, "}}")) {
> +		if (in_regex && (m = str_has_pfx(pattern, "}}"))) {
>   			in_regex = false;
> -			pattern += 2;
> +			pattern = m;
>   			continue;
>   		}
>   		if (in_regex) {
> @@ -452,8 +456,8 @@ static int parse_test_spec(struct test_loader *tester,
>   			continue;
>   
>   		s = btf__str_by_offset(btf, t->name_off);
> -		if (str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX)) {
> -			description = s + sizeof(TEST_TAG_DESCRIPTION_PFX) - 1;
> +		if ((val = str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX))) {
> +			description = val;
>   		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
>   			spec->priv.expect_failure = true;
>   			spec->mode_mask |= PRIV;
> @@ -530,29 +534,24 @@ static int parse_test_spec(struct test_loader *tester,
>   			if (err)
>   				goto cleanup;
>   			spec->mode_mask |= UNPRIV;
> -		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
> -			val = s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX))) {
>   			err = parse_retval(val, &spec->priv.retval, "__retval");
>   			if (err)
>   				goto cleanup;
>   			spec->priv.execute = true;
>   			spec->mode_mask |= PRIV;
> -		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV)) {
> -			val = s + sizeof(TEST_TAG_RETVAL_PFX_UNPRIV) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV))) {
>   			err = parse_retval(val, &spec->unpriv.retval, "__retval_unpriv");
>   			if (err)
>   				goto cleanup;
>   			spec->mode_mask |= UNPRIV;
>   			spec->unpriv.execute = true;
>   			has_unpriv_retval = true;
> -		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
> -			val = s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX))) {
>   			err = parse_int(val, &spec->log_level, "test log level");
>   			if (err)
>   				goto cleanup;
> -		} else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
> -			val = s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
> -
> +		} else if ((val = str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX))) {
>   			clear = val[0] == '!';
>   			if (clear)
>   				val++;
> @@ -577,8 +576,7 @@ static int parse_test_spec(struct test_loader *tester,
>   					goto cleanup;
>   				update_flags(&spec->prog_flags, flags, clear);
>   			}
> -		} else if (str_has_pfx(s, TEST_TAG_ARCH)) {
> -			val = s + sizeof(TEST_TAG_ARCH) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_ARCH))) {
>   			if (strcmp(val, "X86_64") == 0) {
>   				arch = ARCH_X86_64;
>   			} else if (strcmp(val, "ARM64") == 0) {
> @@ -596,16 +594,14 @@ static int parse_test_spec(struct test_loader *tester,
>   			collect_jit = get_current_arch() == arch;
>   			unpriv_jit_on_next_line = true;
>   			jit_on_next_line = true;
> -		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
> -			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
> -		} else if (str_has_pfx(s, TEST_TAG_CAPS_UNPRIV)) {
> -			val = s + sizeof(TEST_TAG_CAPS_UNPRIV) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_BTF_PATH))) {
> +			spec->btf_custom_path = val;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_CAPS_UNPRIV))) {
>   			err = parse_caps(val, &spec->unpriv.caps, "test caps");
>   			if (err)
>   				goto cleanup;
>   			spec->mode_mask |= UNPRIV;
> -		} else if (str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX)) {
> -			val = s + sizeof(TEST_TAG_LOAD_MODE_PFX) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX))) {
>   			if (strcmp(val, "jited") == 0) {
>   				load_mask = JITED;
>   			} else if (strcmp(val, "no_jited") == 0) {
> @@ -635,12 +631,11 @@ static int parse_test_spec(struct test_loader *tester,
>   					      &spec->unpriv.stdout);
>   			if (err)
>   				goto cleanup;
> -		} else if (str_has_pfx(s, TEST_TAG_LINEAR_SIZE)) {
> +		} else if ((val = str_has_pfx(s, TEST_TAG_LINEAR_SIZE))) {
>   			switch (bpf_program__type(prog)) {
>   			case BPF_PROG_TYPE_SCHED_ACT:
>   			case BPF_PROG_TYPE_SCHED_CLS:
>   			case BPF_PROG_TYPE_CGROUP_SKB:
> -				val = s + sizeof(TEST_TAG_LINEAR_SIZE) - 1;
>   				err = parse_int(val, &spec->linear_sz, "test linear size");
>   				if (err)
>   					goto cleanup;
> 

