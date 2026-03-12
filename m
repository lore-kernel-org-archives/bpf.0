Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5DF227599
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318286; cv=none; b=ZIBo1vlw3deRnMgeyF9LuOZ4CcdNxaGylnjhE1vmxguQb7apymkkrr0aY/Fc25ldM2F/lDewMH9tR2dMp7Hvv2KyQ48haeHOZI33lQPhlkuAl7OvwaqMvam37uDBOhQQbeY7AA4daY3pAngU/8SolCQPmNeBUOO8vwQzWwWmK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318286; c=relaxed/simple;
	bh=thDU1lc0YZXHDnsXSBJjM7lkH/txuV9wpd4r0xFdGdg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlJyBUGD+mtg5sikBu/8eYhV/3I775Yg4HMaN3asKh63XBX2MBeZLyRpKu0Ti6vLwe4kbjYo91CypskcFSHQWILHG5rqkTh8J7YiitmM8lFrcjX4ZKbGtWOmLe8W6Jxu2SEUJA9Baj+ewG4QUBA5ceS8eDCtQDZAszezRJ8t+YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZHx1K8l; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZHx1K8l"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so8809895e9.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773318284; x=1773923084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8rYdnhSYW1AF/6LzB31WRXHxUO9w4SQomrMEzPi0XY=;
        b=gZHx1K8l5SYgLcJAJueDdFbZ/bmQBY7W5JJlamnbDWX1r0r+5gWety4PbYkonTxD7X
         BtKlZTgNkO8dZTQjGsv7b88xXaPwUYEhISqH12rEMjih/kzqoAUKfuXt+Kf/wYO7Klkk
         4iiKydxl+1KBhhqcQGTFNh9InRleFmV3JAlr4ol//HUO0KbDqdEZl+mo41z2+HwpWA00
         q5908BUBrjd+xJXgavS5+bOaRU+jj5Tz4+e1buSWvmKdUSlK+jAH45nFbzDOBINJySkI
         nWAZWflnxN/IbaFo6CUIrUacPHsUGTRS5i+ReP7GX18CI5zr4Ksdu17eXMaOWk6kwzuD
         wvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318284; x=1773923084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8rYdnhSYW1AF/6LzB31WRXHxUO9w4SQomrMEzPi0XY=;
        b=RbACpoiJueG+uAfvmKFlK4Tu4lDoTKyxZI4pmPtYkYGYJpw01kOyB149xJfq+nWcOl
         90jgiE05praCCn4SfL58/b06Btg4BzKt/zssVILKjgiPXMU0o30251xR8fNYJs649r/3
         ku7pFPvMEOgTSN/aaRogh5zn8hl/PI/lZsXRVcD8S+ThU3qxw3kKN/5OuRZaHylHWDPi
         rHWkGqSkQKFzYvciUrYnGGvi2Gc90vUwZb6Xsr302WCHc68998oIodC5VaHiOPVX4coX
         7LtkixUozkIp7ouPvi/1JhfNNaNt+wRd45ZiPJ7+78jy2ohKUf7YA5LoyS96Z6yzU29S
         nRJQ==
X-Gm-Message-State: AOJu0YywsrXm/p87D1RQHlQMXBSxgxCYiUCjOd+Ktz3+cGb+e8d4w5jQ
	iDsM8A0eXvoCTRcm5xO9coID9/YLqfHbVP5FEM9z3GgQaITNVm0VnwnK
X-Gm-Gg: ATEYQzzUwhCghEM93Ycf41io0sjUKorBuq54j2z7ZcUWcS6RB1uZxRsAOI3OxZuYZvd
	BP3YD6oubgOrhAXZAOheZ7gAIj1DKNqfkBHE+4bq6ml8C9khuSl8snaZy1x8kZ2Oh3s/WMzabf1
	JFZHOUgfIAVVO5/YCcY03U9qGDY05IffB5PoSAnqydglWS0DcQG4Ur2EpNoeIk+A1b5FWr9gir3
	tkbwOlQMktAENXIs7wiB1/FrrW1K+NWSun63cfMgltDi0r5tI74xB2A3uIoehpNALNnYkdsdImE
	gbWRPUc9Fr1McZUBqV7luHY3boRHawyf9Yy3fPTjLRvPBexaV5NtpwUKJ7k3aauZgnfh+pOTbD7
	To/5mwPbSQ8jIS0voHtO6z4VEYaFL2Rd6Nu4dW+4Kyi4pA7XiCkmZJET1eaWpbe2v15j6iqYH
X-Received: by 2002:a05:600c:8b13:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-4854b100b66mr105829985e9.21.1773318283507;
        Thu, 12 Mar 2026 05:24:43 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e9179sm125863655e9.3.2026.03.12.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:24:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Mar 2026 13:24:42 +0100
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, andrii@kernel.org,
	shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, martin.lau@linux.dev
Subject: Re: [PATCH] selftests/bpf: modify_return: isolate fmod_ret hooks by
 pid
Message-ID: <abKwikMNfT0lhfl3@krava>
References: <20260312104219.1208802-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312104219.1208802-1-sun.jian.kdev@gmail.com>

On Thu, Mar 12, 2026 at 06:42:19PM +0800, Sun Jian wrote:

SNIP

> diff --git a/tools/testing/selftests/bpf/progs/modify_return.c b/tools/testing/selftests/bpf/progs/modify_return.c
> index 3376d4849f58..5ff18ddb3050 100644
> --- a/tools/testing/selftests/bpf/progs/modify_return.c
> +++ b/tools/testing/selftests/bpf/progs/modify_return.c
> @@ -7,16 +7,29 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
>  
>  char _license[] SEC("license") = "GPL";
>  
>  static int sequence = 0;
>  __s32 input_retval = 0;
> +__u32 test_pid = 0;
> +
> +static __always_inline bool match_pid(void)
> +{
> +	__u64 pid_tgid = bpf_get_current_pid_tgid();
> +
> +	if (!test_pid)
> +		return false;
> +	return (__u32)(pid_tgid >> 32) == test_pid;
> +}
>  
>  __u64 fentry_result = 0;
>  SEC("fentry/bpf_modify_return_test")
>  int BPF_PROG(fentry_test, int a, __u64 b)
>  {
> +	if (!match_pid())
> +		return 0;

I think just simple pid check like we do in other places
should be enough:

	if (bpf_get_current_pid_tgid() >> 32 != test_pid)
		return 0;

jirka


>  	sequence++;
>  	fentry_result = (sequence == 1);
>  	return 0;
> @@ -26,6 +39,8 @@ __u64 fmod_ret_result = 0;
>  SEC("fmod_ret/bpf_modify_return_test")
>  int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
>  {
> +	if (!match_pid())
> +		return ret;
>  	sequence++;
>  	/* This is the first fmod_ret program, the ret passed should be 0 */
>  	fmod_ret_result = (sequence == 2 && ret == 0);
> @@ -36,6 +51,8 @@ __u64 fexit_result = 0;
>  SEC("fexit/bpf_modify_return_test")
>  int BPF_PROG(fexit_test, int a, __u64 b, int ret)
>  {
> +	if (!match_pid())
> +		return 0;
>  	sequence++;
>  	/* If the input_reval is non-zero a successful modification should have
>  	 * occurred.
> @@ -55,6 +72,8 @@ SEC("fentry/bpf_modify_return_test2")
>  int BPF_PROG(fentry_test2, int a, int *b, short c, int d, void *e, char f,
>  	     int g)
>  {
> +	if (!match_pid())
> +		return 0;
>  	sequence2++;
>  	fentry_result2 = (sequence2 == 1);
>  	return 0;
> @@ -65,6 +84,8 @@ SEC("fmod_ret/bpf_modify_return_test2")
>  int BPF_PROG(fmod_ret_test2, int a, int *b, short c, int d, void *e, char f,
>  	     int g, int ret)
>  {
> +	if (!match_pid())
> +		return ret;
>  	sequence2++;
>  	/* This is the first fmod_ret program, the ret passed should be 0 */
>  	fmod_ret_result2 = (sequence2 == 2 && ret == 0);
> @@ -76,6 +97,8 @@ SEC("fexit/bpf_modify_return_test2")
>  int BPF_PROG(fexit_test2, int a, int *b, short c, int d, void *e, char f,
>  	     int g, int ret)
>  {
> +	if (!match_pid())
> +		return 0;
>  	sequence2++;
>  	/* If the input_reval is non-zero a successful modification should have
>  	 * occurred.
> 
> base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
> -- 
> 2.43.0
> 
> 
