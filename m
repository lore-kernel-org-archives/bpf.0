Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175763;
	b=1IvErN4iqPiTKItYV3i7jKRkUz+DFv9Qm0BoyKjzpIfQskchopqjht+aTfcUhWrEjhsP
	 8+PqNZf/SXtY/X/ZqEseyPBZEo+l1vLHi+JzaDPEvHMAEEtlc1lP8X6g0Vrry1hxwHglR
	 8d32fDuEo4lENpIygQ8m3llbi9rSzYCgzvata2HZjLajSS/0J8q/+DrzXYe8eXWb9JNmc
	 bYGwLqlfWYbnpw9E2SOaZuy97GOP1ENsINRCYt1tQC6vpoXA4Eg+TT6n4UWSkVRAlKB9x
	 2qUUOv3LsJ9y9X5RUi/FWZ0U+Zr9qMELBrKZCRQoVDhK6xumz0mML8nzjXisBBAsuFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6htAR8msSws0zxXL7Ay6OqVCfSDW7raEhLFDjcxv+dw=;
	b=TmY/43yPO003TOFP1ZkfkxpL2PkIiN+538a4TWxRHqKmusW/UPU9F8rJQKNzpWu9WYYl
	 n0R3/AMKU/7R2ti04znGCtyMDvDO/ccw18xgsZlDcSubRe3PrIe/gnUMG6wRnROVcwxL6
	 hK61BcmhLj/+/Eztt6JhGMQcE9xmjHoE13ut+5l+GJ2Z7QRv5witmRP9aS/10sY5nEOpV
	 Ibw/6tq5BtqteYwQjWxGvn+02KtBRxzxFbtJ2nuOAxnxZ/z/+ujHvCtMJ4mCh4226VfnD
	 vtPy66wgCF4aAHVhFLkEtkE8amk6cwd3z3H7g2nN20LcqUNiAbc09kF0oaHN/bghWxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hcTL3Em7;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC09606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DC09606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hcTL3Em7
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8977f2785so1151213a12.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 03:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795175762; x=1795780562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6htAR8msSws0zxXL7Ay6OqVCfSDW7raEhLFDjcxv+dw=;
        b=hcTL3Em7DvuXsji3eYps7cDO9XX/0OdOF3dxgIfiD6EwuXFfTF80/hXpRKY1dES0je
         EDiLM6KMkzHrdMF/Cu182UqM+ooKiKXloGgCvVihOHEDNr5PdFUGuTMAJLHBWu2q1u9z
         P2ilNQIgDGQPqAhK8CM6a0O8N7p/vjFoc/OEPS+RS0TCgmaxOy8M90RklJP4/j/ootdw
         rD0lO+tbkcGZ/6qcMcqcAFwsNxjPY/6v/waaYQ1AYCIgIhh3MmZK1S+4LaWN5XqkLNW4
         HkeOnROa8BQH9wiAfKCpRDvS2vAy9ww1cvKN3tAnnpq8qVCieHsyTAks6IE42OarrgYx
         88JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795175762; x=1795780562;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6htAR8msSws0zxXL7Ay6OqVCfSDW7raEhLFDjcxv+dw=;
        b=lYyMrij7vxyLSogFvaaApyWCvebaL4fqgzFM/DPmvH+BXTeU+GLL3N5njhro0hZbw8
         WBz8F+F7cDaoXdS4IG40wmupnD6puEVmGxNFSRIvTVrlfWGQsUB+okKOBxynOOSwQ0aA
         JEcj83z95Ty7hcLeW0xYrl9BaaY66BV3XUzvwyQCdfCQF+6ARfRkIwcLQacqDIOOLOfe
         W6YbBEvo85pYJMUCchYqFXzTeqzhingExhd8en25Y8CwaJTT3y09f7B15Eidvy9qT1Gc
         +dZGTe/FwwjugEwwYgrLDR6j8iWK8CxLleC1iZxSLwwJrPCzgxI8aG1z9CX/5cU0kvoj
         Xtlg==
X-Forwarded-Encrypted: i=1; AL+hErHbCCaIwasWwdr2d3tgd4lqGb3ibA74VR2VWY1RhNqE+eCKV3VD27OGpwuwhum+Iuliz3w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GyZrUIk1GPnKYTGFiOVBbhLFafxPkrh/+zsneFS6KAlWfU0Ls
	ieJ0w7y1wZnCpga4PrCcvF/oVGz2oHzdoQQBZ+LmbeG+zcHwH3y/3AnX
X-Gm-Gg: AZFdTZe/mF4xYxxugvoQ5E7E0ChGP7VPdQNdvE6EPaWLbtWw3rTLffjF9Qm/xmXBjRg
	TFq4XfwbTPjhM1CRA1mPsj0nHuOGOZZb9RRBftlKs8Su4niPnPm8GZs91vKWF42HB0wuzqTH6fX
	56CT21Gj+vGMuqYad+9fiBahlBslcayVwavGtAeEYo8OK4EZaz6HNpMTpMBJDPwsG69B1PW5I50
	WobpetRp+l15g9vRR05M9Vbi13IUIU2F/Gi/sL9daKRR3UDXEErjlyXprA5hC7npv/G72WmYTgn
	3Vxsl5VzUHr1BSTQrODjWQnDNGV0Bfjnq+Go5QsUThUtNhDei64uYuTzSoLPURfJNGpDlC5ETy8
	7viBF7OiawRMYipvt19A0jeFz8WsYC4y8OSBjMl8vKivV+7g64wIIWwYlIq4rPKjEsNufTrcv/o
	1P88+ANJYozl+G3LfupsvC2JNf7S1XJQDVpymAfGXaGVRM0dV4VcvDZ5hkSpaj9tg8eJ3FanQPm
	xOSdnJ0O7eiP+tOT+YOTM431mgmUxjuediFx8tBWIxRGvzbrv1XlA1vbP+1VYCUu5V62eT06Erp
	icBuhic/quiVpVQFRa4aYYt/075dovNWrdlPBEkbrItoTUbf4s27Ca5wKgQNxgQHMkBFgfr0VrW
	vN0knPlcW57K/
X-Received: by 2002:a05:6402:4004:b0:6b5:8719:6d51 with SMTP id 4fb4d7f45d1cf-6ba37e6f76amr2060577a12.32.1795175761514;
        Fri, 20 Nov 2026 03:56:01 -0800 (PST)
Received: from ?IPV6:2a02:8109:a307:d900:2e59:c703:9195:689c? ([2a02:8109:a307:d900:2e59:c703:9195:689c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fa8basm1057338a12.20.2026.11.20.03.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 03:56:00 -0800 (PST)
Message-ID: <6551b299-7d2e-4ed9-83c9-fc733d55ee00@gmail.com>
Date: Fri, 20 Nov 2026 11:55:58 +0000
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
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: Test wq callback setup
 after deletion and user release
To: Yun Lu <luyun_611@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org
References: <20261119033051.196177-1-luyun_611@163.com>
 <20261119033051.196177-7-luyun_611@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20261119033051.196177-7-luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/26 3:30 AM, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> Use the existing NO_PREALLOC HASH map and callback to test that
> bpf_wq_set_callback() rejects a deleted value with -ENOENT.
> 
> Keep the map alive through a program fd after dropping its last user
> reference. When bpf_wq_init() returns -EBUSY on a reinserted element,
> the idle callback survived reuse. Check that the setter returns -EPERM.
> On v3 the same test gets 0. Retry only a cache miss and report cleanup
> failures separately after attempting to delete each inserted element.
> 
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/wq.c | 103 +++++++++++++++++++-
>  tools/testing/selftests/bpf/progs/wq.c      |  62 ++++++++++++
>  2 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
> index a4f71bc34fa6..f783a91417e0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -1,11 +1,109 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2024 Benjamin Tissoires */
> +#include <errno.h>
> +#include <sched.h>
> +#include <unistd.h>
>  #include <test_progs.h>
>  #include "wq.skel.h"
>  #include "wq_failures.skel.h"
>  
>  #define CALLBACK_WAIT_RETRIES 10000
>  #define CALLBACK_WAIT_US 1000
> +#define WQ_USERCNT_MAX_ATTEMPTS 256
> +#define WQ_USERCNT_RETRY EAGAIN
> +
> +static int pin_to_first_cpu(cpu_set_t *old_mask)
> +{
> +	cpu_set_t new_mask;
> +	int cpu;
> +
> +	if (sched_getaffinity(0, sizeof(*old_mask), old_mask))
> +		return -errno;
> +
> +	for (cpu = 0; cpu < CPU_SETSIZE; cpu++)
> +		if (CPU_ISSET(cpu, old_mask))
> +			break;
> +	if (cpu == CPU_SETSIZE)
> +		return -EINVAL;
> +
> +	CPU_ZERO(&new_mask);
> +	CPU_SET(cpu, &new_mask);
> +	if (sched_setaffinity(0, sizeof(new_mask), &new_mask))
> +		return -errno;
> +	return 0;
> +}
> +
> +static int run_wq_prog(int prog_fd, __s32 *retval)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	int err;
> +
> +	err = bpf_prog_test_run_opts(prog_fd, &opts);
> +	if (err)
> +		return err;
> +	*retval = (__s32)opts.retval;
> +	return 0;
> +}
> +
> +/* Check callback setup after reusing an idle object with no map uref. */
> +static void test_wq_usercnt_reuse(void)
> +{
> +	struct wq *skel = NULL;
> +	cpu_set_t old_mask;
> +	__s32 retval = 0;
> +	int stage_b_fd = -1;
> +	int err, attempt;
> +
> +	if (!ASSERT_OK(pin_to_first_cpu(&old_mask), "pin"))
> +		return;
> +
> +	for (attempt = 0; attempt < WQ_USERCNT_MAX_ATTEMPTS; attempt++) {
> +		skel = wq__open_and_load();
> +		if (!ASSERT_OK_PTR(skel, "wq__open_and_load"))
> +			break;
> +
> +		err = run_wq_prog(bpf_program__fd(skel->progs.test_deleted_wq),
> +				  &retval);
> +		if (!ASSERT_OK(err, "test_deleted_wq_run") ||
> +		    !ASSERT_EQ(retval, (__s32)-ENOENT, "test_deleted_wq_ret"))
> +			break;

test_deleted_wq is already covered by RUN_TESTS(wq). It's also a deterministic test
there is no need to run and assert it again on each attempt.
Opening and loading the skeleton on each iteration is wasteful, there are other
approaches to dropping usercnt of the map: bpf_map__reuse_fd() or map in map.

> +
> +		stage_b_fd = dup(bpf_program__fd(skel->progs.test_wq_usercnt_reuse));
> +		if (!ASSERT_GE(stage_b_fd, 0, "dup_stage_b"))
> +			break;
> +
> +		/* Drop all target-map user FDs; the retained program FD keeps
> +		 * the map alive through used_maps, but usercnt becomes zero.
> +		 */
> +		wq__destroy(skel);
> +		skel = NULL;
> +
> +		err = run_wq_prog(stage_b_fd, &retval);
> +		close(stage_b_fd);
> +		if (!ASSERT_OK(err, "stage_b_run"))
> +			break;
> +
> +		if (retval == WQ_USERCNT_RETRY) {
> +			/* The cached element was not reused; try again. */
> +			continue;
> +		}
> +		if (retval > 0) {
> +			ASSERT_FAIL("usercnt stage error %d", retval);
> +			break;
> +		}

I think we can remove this hunk, as the next one will fail for the same
case.

> +
> +		ASSERT_EQ(retval, (__s32)-EPERM, "usercnt_setter_ret");
> +		break;
> +	}
> +
> +	if (attempt == WQ_USERCNT_MAX_ATTEMPTS)
> +		ASSERT_FAIL("usercnt reuse not hit after %d attempts",
> +			    WQ_USERCNT_MAX_ATTEMPTS);

ASSERT_LT(attempt, WQ_USERCNT_MAX_ATTEMPTS);

> +
> +	if (skel)
> +		wq__destroy(skel);
> +	sched_setaffinity(0, sizeof(old_mask), &old_mask);
> +}
>  
>  void serial_test_wq(void)
>  {
> @@ -20,7 +118,7 @@ void serial_test_wq(void)
>  
>  	wq_skel = wq__open_and_load();
>  	if (!ASSERT_OK_PTR(wq_skel, "wq__open_and_load"))
> -		return;
> +		goto clean_up;
>  
>  	err = wq__attach(wq_skel);
>  	if (!ASSERT_OK(err, "wq_attach"))
> @@ -37,6 +135,9 @@ void serial_test_wq(void)
>  	ASSERT_EQ(wq_skel->bss->ok_sleepable, (1 << 1), "ok_sleepable");
>  clean_up:
>  	wq__destroy(wq_skel);
> +
> +	if (test__start_subtest("usercnt_reuse"))
> +		test_wq_usercnt_reuse();
>  }
>  
>  void serial_test_failures_wq(void)
> diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
> index 25be2cd9d42c..1543eeb7165f 100644
> --- a/tools/testing/selftests/bpf/progs/wq.c
> +++ b/tools/testing/selftests/bpf/progs/wq.c
> @@ -3,6 +3,7 @@
>   */
>  
>  #include "bpf_experimental.h"
> +#include <errno.h>
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
>  #include "../test_kmods/bpf_testmod_kfunc.h"
> @@ -138,6 +139,67 @@ static int wq_cb_sleepable(void *map, int *key, void *value)
>  	return 0;
>  }
>  
> +SEC("syscall")
> +__retval(-ENOENT)
> +long test_deleted_wq(void *ctx)
> +{
> +	struct hmap_elem empty = {}, *value;
> +	int key = 0;
> +
> +	if (bpf_map_update_elem(&hmap_malloc, &key, &empty, BPF_NOEXIST))
> +		return 1;
> +	value = bpf_map_lookup_elem(&hmap_malloc, &key);
> +	if (!value)
> +		return 2;
> +	if (bpf_map_delete_elem(&hmap_malloc, &key))
> +		return 3;
> +	if (bpf_wq_init(&value->work, &hmap_malloc, 0))
> +		return 4;
> +	return bpf_wq_set_callback(&value->work, wq_callback, 0);
> +}
> +
> +#define WQ_USERCNT_RETRY EAGAIN
> +#define WQ_USERCNT_SETUP_FAIL 1
> +#define WQ_USERCNT_CLEANUP_FAIL 2
> +
> +/*
> + * The host runs this after dropping all user references to hmap_malloc.
> + * Use positive EAGAIN for a reuse miss. Return the setter result only
> + * after deleting the inserted element.
> + */
> +SEC("syscall")
> +long test_wq_usercnt_reuse(void *ctx)
> +{
> +	struct hmap_elem empty = {}, *value;
> +	long init_ret, result;
> +	int key = 0;
> +
> +	if (bpf_map_update_elem(&hmap_malloc, &key, &empty, BPF_NOEXIST))
> +		return WQ_USERCNT_SETUP_FAIL;
> +
> +	value = bpf_map_lookup_elem(&hmap_malloc, &key);
> +	if (!value) {
> +		result = WQ_USERCNT_SETUP_FAIL;
> +		goto delete;
> +	}
> +
> +	init_ret = bpf_wq_init(&value->work, &hmap_malloc, 0);
> +	if (init_ret == -EBUSY) {
> +		result = bpf_wq_set_callback(&value->work, wq_callback, 0);
> +	} else if (init_ret == -EPERM) {
> +		/* The retained idle callback was not reused. */
> +		result = WQ_USERCNT_RETRY;
> +	} else {
> +		/* init 0 or another error is a setup failure, not a miss. */
> +		result = WQ_USERCNT_SETUP_FAIL;
> +	}
> +
> +delete:
> +	if (bpf_map_delete_elem(&hmap_malloc, &key))
> +		return WQ_USERCNT_CLEANUP_FAIL;
> +	return result;
> +}
> +
>  SEC("tc")
>  /* test that workqueues can be used from an array */
>  __retval(0)

