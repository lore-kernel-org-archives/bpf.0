Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B135958
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063421; cv=none; b=ZCaHl2S7ytaYgWYgW2e5YIxmfnZGX16McDECisqFQO3dt3EAA+SzYrnGu9NxSrBUAfylbhr4fzGg9TuJo6/SxhYV6G0/GJcT22Nji2yp9RYqThpeCYA/u8lbtUwFGFrzKe4BlbqwCPPxIddCwY68UU13cirt1cnnarzllKROk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063421; c=relaxed/simple;
	bh=L4Qj7IR6zPbFn6EFjEaKc0VgPNuvo2Iz6EO/8YdDxF8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2zIoaRN5f5k91fnM36VAS3UM1O/CwLaHUA7j63vzW1ZigAZR0kyNkRtre3IvphlGJ/S/f/OvnhG7ANDk5cQjMy3DylEORxlpJxBGFDCcOdknTbm/3uXufOR+rzCkTzXSg2R5chQcYS0u0Y8tLYSSl+A38DBlJoESXnw5Oytcp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8sR/l9G; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8sR/l9G"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso107021285e9.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773063419; x=1773668219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+bRtL9yok0Eg9xnF3qWT3YML7sccPumi5eZAXcjcT8=;
        b=X8sR/l9GH/iRQtsW1TALQ/3OkZ2uAKb4VTC+UL0W3UluW+h8W3IQaivB3YHvBj2KpN
         vUsoSpkjjh3Ky2tEsxrq2gmGvvLRKcN65E/pTyurkrT9XHw7PgI4TwdecDCb8/cqoWil
         Ba+5acsLPlwJC1amkrBHzSquymxfjn6Q5vXt4fQomB3eZ7A9lCu10ZYBQw3372ZBt5vq
         2zoRHmMc/ScPB0btuzpQXPDvRfq2VwvOINnwWAvFzF5YLH61Sj5T9yDAtwxdpnUC7b/r
         6et5Mt2NZuedWBmZu867m3nC01EL+KoxEsXGzrl4sSeOxIyZPVle8PG28XLGIyOxArhm
         ifeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773063419; x=1773668219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+bRtL9yok0Eg9xnF3qWT3YML7sccPumi5eZAXcjcT8=;
        b=nabO/olDP37npAoIdtUbjUUlQ1BYs9w1ko8bt/jlPKJv/D3lWGDxaJZihgxbA6sW6o
         XmiYNeuRV38FKXh8TWQOv8moY/8x6I/jDpfPYyXuuG1fG0SUjhHG5yE31/FY2lXEMKqz
         k4PnX9c8t7gzYvH1c3u3t7PT4CXMKxJ6UA196qADGPjrQ018AHrEwYGV7aVIgiS0lCrH
         RXU1cNMiajdwavBQKrNfmZCUS8nhTX2x+5xpiNLYg//l5dcgwg/MLTWXdMH4Tg+PcU3S
         Ya9HG7Yt1/dtFs10i7b1dd55Kv44GHnnNmQCA2qXE1Lu8sXEcmPyRGhJ0mbLDJ2U5pzW
         pSuQ==
X-Gm-Message-State: AOJu0YzxLc1Vwv8KE5WbhzSFwp8riX3QgtqLoAxlfPYPatR5W2WVxV3j
	mqAsBj3rXzvLBKXm+N0CcuDfi+W9U70CHRKUpbFLg8biBImeoyxc42Ja
X-Gm-Gg: ATEYQzxSv3z/DezuYgQ6QHFfQ10bkIZ+psJ3u1IUYpYAl9EPTcphcePd3au8sU/7eY3
	07XW+EALY/SZ8qSYgzoqIP8wIOk6Ap5hrvaxvwDbxN0EOmNy7HbYlbSLRxRvAObfHS6v5wfhnw5
	WIywLB6eExroGFr4++VUsxVgqf6G2o8KSySCDzzOVrMQpQPVxdtV3if3XUKGbmqQrIcU7sBHYaG
	cPjoNP+p6DEhsk5xoRJxxX3cG/TeCp9GKxa7d695aUbJI6gil2B2r21tbkxn5Bu/RBsu/Q+6foZ
	mecnl66hZcLrgq6JK+rw1ONGCLnyiwxNDhPGeyZEmF7OQp5e39gqwiEuttJYl6zhdGfhaYBgy0t
	oa5Ghc1OJIXUtLU/tBW/fDHBcsM7tHRC9dat/c7wEQKQ/NufN+B5y26pLlnI8eeawkKEZvpikdV
	sD+MevrzUU8cfwjOcJvTwvdAuJ
X-Received: by 2002:a05:600c:4f4a:b0:485:3f58:da6 with SMTP id 5b1f17b1804b1-4853f580fc8mr26791815e9.2.1773063418419;
        Mon, 09 Mar 2026 06:36:58 -0700 (PDT)
Received: from krava ([2a00:102a:5007:2415:42f:f06b:ba32:35b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485244b6e9esm151600455e9.5.2026.03.09.06.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:36:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 9 Mar 2026 14:36:55 +0100
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next] selftests/bpf: livepatch_trampoline: skip
 when prerequisites are missing
Message-ID: <aa7M90H8nssl2CQ0@krava>
References: <20260309104448.817401-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309104448.817401-1-sun.jian.kdev@gmail.com>

On Mon, Mar 09, 2026 at 06:44:48PM +0800, Sun Jian wrote:
> livepatch_trampoline relies on livepatch sysfs and livepatch-sample.ko.
> When CONFIG_LIVEPATCH is disabled or the samples module isn't built, the
> test fails with ENOENT and causes false failures in minimal CI configs.
> 
> Skip the test when livepatch sysfs or the sample module is unavailable.
> Also avoid writing to livepatch sysfs when it's not present.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> v4:
>   - Drop redundant <errno.h> and <unistd.h> includes; both are already included by test_progs.h (per Jiayuan Chen)
>   - Tested: ./test_progs -t livepatch_trampoline -vv (SKIP when livepatch-sample.ko missing)

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> v3:
>   - Skip on -ENOENT from load_livepatch() instead of duplicating module path logic (suggested by Jiri Olsa)
>   - Tested: ./test_progs -t livepatch_trampoline (SKIP when livepatch-sample.ko missing)
> 
> v2:
>   - Skip when /sys/kernel/livepatch is missing
>   - Guard sysfs write in unload_livepatch() when enabled knob is absent
> 
> v3: https://lore.kernel.org/bpf/20260309033712.728133-1-sun.jian.kdev@gmail.com/
> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20260305030258.5273-1-sun.jian.kdev@gmail.com/
> v1: https://patchew.org/linux/20260227042354.20926-1-sun.jian.kdev@gmail.com/
> 
>  .../bpf/prog_tests/livepatch_trampoline.c     | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
> index 72aa5376c30e..0a12af924a99 100644
> --- a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
> +++ b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
> @@ -5,6 +5,8 @@
>  #include "testing_helpers.h"
>  #include "livepatch_trampoline.skel.h"
>  
> +#define LIVEPATCH_ENABLED_PATH "/sys/kernel/livepatch/livepatch_sample/enabled"
> +
>  static int load_livepatch(void)
>  {
>  	char path[4096];
> @@ -19,7 +21,8 @@ static int load_livepatch(void)
>  static void unload_livepatch(void)
>  {
>  	/* Disable the livepatch before unloading the module */
> -	system("echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled");
> +	if (!access(LIVEPATCH_ENABLED_PATH, F_OK))
> +		system("echo 0 > " LIVEPATCH_ENABLED_PATH);
>  
>  	unload_module("livepatch_sample", env_verbosity > VERBOSE_NONE);
>  }
> @@ -81,9 +84,22 @@ static void __test_livepatch_trampoline(bool fexit_first)
>  void test_livepatch_trampoline(void)
>  {
>  	int retry_cnt = 0;
> +	int err;
> +
> +	/* Skip if kernel was built without CONFIG_LIVEPATCH */
> +	if (access("/sys/kernel/livepatch", F_OK)) {
> +		test__skip();
> +		return;
> +	}
>  
>  retry:
> -	if (load_livepatch()) {
> +	err = load_livepatch();
> +	if (err) {
> +		if (err == -ENOENT) {
> +			test__skip();
> +			return;
> +		}
> +
>  		if (retry_cnt) {
>  			ASSERT_OK(1, "load_livepatch");
>  			goto out;
> 
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> -- 
> 2.43.0
> 
