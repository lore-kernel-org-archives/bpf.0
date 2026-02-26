Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD340B6ED
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119093; cv=none; b=dTAEMYYZUzihpB7paZz78Lik8Jjxcw6YQsvqTjfDy5g5ZkX0GUBFanp4Y78OUXjeqRMcdlwUikSQphrTZh12BpsRz1Kz6nrXM1mfSiO1LoAkr3F6MLXa6oWrqyHrbJVJgbBBpt1srTEQeysYAeC43Cy9zZ+eLYiAukWHIMeo+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119093; c=relaxed/simple;
	bh=UtOhj8tACoqtlw1hMQBUUKvYaf1dX1kM+5j0nTLO5r4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a3JWHOoqx2wQi+OGN+OQ52AEyDV+VoBy2jKdeiE9Ol6ih135RLeCXzBtMXok1VXz5qVu5W9AqZoXJvo/7Ewfjztri+OT3Y35y265tsGXYTq9owz6Qqb8VWo6BIBawa9x/EV+h9AsuMBHvFW75vOzTJC6k+wDQnXiwAD+Y6zUWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuXU6Kbl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuXU6Kbl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48372efa020so8449495e9.2
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772119090; x=1772723890; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXMv97b9KNqAU0cNnpTqpEvgdSSxZvM5f/4DMEg70Dk=;
        b=JuXU6Kbl6tU+d/b4+DTt1+J3xPCTEDSaGo5UBHdD+R/fWLWO9+G9Yzxn3q7owIdON/
         uNKFykF/JfkFiAf/VJsoKH04vdwVQZAO0HlLQ60bQZPI1Wa5wHGQ0Wji7LkOOZIxnW0+
         YEvKPJt/dZjAKPitMpvkmBxL93y+RJr6MbJv9XFa/K0usHYpphbGm4dCaO//ful6R4sg
         GsSHHncBsSztba1jRNOUTI9DP9y0pb63uHBRhVrXCcEUuzXziT/jNaGV18wKx/EB9oiY
         Q65VBPCjJ9G6pv+tyyvcw7QJeZ0tUGI4Nrf+YOTZ0GrKBYLtiOo3R4bftG+bN+PsEnH9
         v53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119090; x=1772723890;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXMv97b9KNqAU0cNnpTqpEvgdSSxZvM5f/4DMEg70Dk=;
        b=oaMMfUFnWV4qlyCq8lPBkQc1WwBNergWStR1duTz4CYZSldfp+T9PlJ6MFCdSs03WN
         XmYqHN9hiZ75JRsEFwQ8jfLxwuvQCt5vNjPpnxGdpedcaZXzL20V6rOG1GjOJcuVcfEp
         ZDlUsTCe/dg40Ui/sTttgc8vmTT5s0nmR/7XdBErDlbX+oSoXo0wg7fyPa6yd4l0x9hB
         sJ5bi38ZCubnIFdLhUbJgKg6yJy2TYvB2J+eXrSePvXW1mj2ZEiJh/tykZQUkBvTLwZ9
         cReAy5miTD9z9RMRCaYCQetqAYluwwu/W5rG1Ig5tLtxlTOCCItxjEreNaQePqX3xeBF
         B/rg==
X-Forwarded-Encrypted: i=1; AJvYcCXIb8UZzWqQQgaIDyhYX9fNjfGq+rMeuPEo3DbMPsNBIwO49SkmmIS41UQ04sG4ZqWnE1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95bNvibEGS57/sbjgVZrJfczBAoGKXA/x3nLQm5XK6Z3ZqdC4
	QW7Tk6LAryg/m4gf9AnMdZ9QIcMXvGVEPp38DVqsRY1s9o6+3+ytZNQK
X-Gm-Gg: ATEYQzz8acETVZ6PAq8SRFb1b5E5rzPNcjjpqm15ci2GN7l3TZ0hCnPqsUiLWToyUuz
	XuP184jGsOsEVheT9a79/2s9dfxj0ofn6T6u4CLjdUUZPEA0SIyDAou8ND/b6uz6vaD+YM26vCx
	tJDe/VCps7fwNUdMeLlbJRYWPvP85bDhrG7+YXWQXMNPs12+2DIEX8MV2gaj8qckHdYgahMdWMz
	jnzfqu77i9la+m6AzB2Ac63oGcocMoBkWyEPAVTmiLC6/T8+o16LylD3ldjB7Kl4CnrTQj7h6KA
	GP0cw41e5PJOJZv8w4d45JD1ve3/60JlXDtoB7sAlE4cVgvwcSP4byQHdivuH+q/TXFW4Yer+gN
	B7L4Gq+SHRbf4jiitQ5QZDSw6jmgPJyP4JBJrMz1sPkyde+cEM1KFir6N9JbTK9LxyXwDm65wH0
	MXdDzbVYN9O42hQR4IJm8=
X-Received: by 2002:a05:600c:628d:b0:483:7020:864 with SMTP id 5b1f17b1804b1-483c21a59aemr62238595e9.25.1772119089813;
        Thu, 26 Feb 2026 07:18:09 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:5405])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df9fsm162765655e9.13.2026.02.26.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:18:09 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sun Jian <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH v2 1/2] selftests/bpf: probe_user: filter by pid to
 avoid cross-test interference
In-Reply-To: <20260226093132.437206-2-sun.jian.kdev@gmail.com>
References: <20260226093132.437206-1-sun.jian.kdev@gmail.com>
 <20260226093132.437206-2-sun.jian.kdev@gmail.com>
Date: Thu, 26 Feb 2026 15:18:08 +0000
Message-ID: <87ikbjpm8f.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sun Jian <sun.jian.kdev@gmail.com> writes:

> The test installs a kprobe on __sys_connect and checks that
> bpf_probe_write_user() can modify the syscall argument. However, any
> concurrent thread in any other test that calls connect() will also
> trigger the kprobe and have its sockaddr silently overwritten, causing
> flaky failures in unrelated tests.
>
> Constrain the hook to the current test process by filtering on a PID
> stored as a global variable in .bss. Initialize the .bss value from
> user space before bpf_object__load() using bpf_map__set_initial_value(),
> and validate the bss map value size to catch layout mismatches.
>
> No new map is introduced and the test keeps the existing non-skeleton
> flow.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/probe_user.c     | 27 ++++++++++++++++++-
>  .../selftests/bpf/progs/test_probe_user.c     | 13 +++++++--
>  2 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> index 8721671321de..280dcdb5ddef 100644
> --- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> @@ -20,6 +20,11 @@ void serial_test_probe_user(void)
>  	struct bpf_program *kprobe_progs[prog_count];
>  	struct bpf_object *obj;
>  	static const int zero = 0;
> +	struct test_pro_bss {
> +		struct sockaddr_in old;
> +		__u32 test_pid;
> +	};
> +	struct test_pro_bss results = {};
>  	size_t i;
>  
>  	obj = bpf_object__open_file(obj_file, &opts);
> @@ -34,6 +39,24 @@ void serial_test_probe_user(void)
>  			goto cleanup;
>  	}
>  
> +	{
> +		struct bpf_map *bss_map;
> +		struct test_pro_bss bss_init = {};
> +
> +		bss_init.test_pid = getpid();
> +		bss_map = bpf_object__find_map_by_name(obj, "test_pro.bss");
> +		if (CHECK(!bss_map, "find_bss_map", "no bss map\n"))
> +			goto cleanup;
> +		if (CHECK(bpf_map__value_size(bss_map) != sizeof(bss_init),
> +			  "bss_size", "bss value_size %u != %zu\n",
> +			  bpf_map__value_size(bss_map), sizeof(bss_init)))
> +			goto cleanup;
> +		err = bpf_map__set_initial_value(bss_map, &bss_init,
> +						 sizeof(bss_init));
> +		if (CHECK(err, "set_bss_init", "err %d\n", err))
> +			goto cleanup;
> +	}
> +
>  	err = bpf_object__load(obj);
>  	if (CHECK(err, "obj_load", "err %d\n", err))
>  		goto cleanup;
> @@ -62,11 +85,13 @@ void serial_test_probe_user(void)
>  	connect(sock_fd, &curr, sizeof(curr));
>  	close(sock_fd);
>  
> -	err = bpf_map_lookup_elem(results_map_fd, &zero, &tmp);
> +	err = bpf_map_lookup_elem(results_map_fd, &zero, &results);
>  	if (CHECK(err, "get_kprobe_res",
>  		  "failed to get kprobe res: %d\n", err))
>  		goto cleanup;
>  
> +	memcpy(&tmp, &results.old, sizeof(tmp));
> +
>  	in = (struct sockaddr_in *)&tmp;
>  	if (CHECK(memcmp(&tmp, &orig, sizeof(orig)), "check_kprobe_res",
>  		  "wrong kprobe res from probe read: %s:%u\n",
> diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
> index a8e501af9604..4bc86c7654b1 100644
> --- a/tools/testing/selftests/bpf/progs/test_probe_user.c
> +++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
> @@ -5,13 +5,22 @@
>  #include <bpf/bpf_core_read.h>
>  #include "bpf_misc.h"
>  
> -static struct sockaddr_in old;
> +struct test_pro_bss {
> +	struct sockaddr_in old;
> +	__u32 test_pid;
> +};
> +
> +struct test_pro_bss bss;
>  
>  static int handle_sys_connect_common(struct sockaddr_in *uservaddr)
>  {
>  	struct sockaddr_in new;
> +	__u32 cur = bpf_get_current_pid_tgid() >> 32;
> +
> +	if (bss.test_pid && cur != bss.test_pid)
> +		return 0;
>  
> -	bpf_probe_read_user(&old, sizeof(old), uservaddr);
> +	bpf_probe_read_user(&bss.old, sizeof(bss.old), uservaddr);
>  	__builtin_memset(&new, 0xab, sizeof(new));
>  	bpf_probe_write_user(uservaddr, &new, sizeof(new));
>  
> -- 
> 2.43.0
