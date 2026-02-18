Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984E1EB5F8
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433080; cv=none; b=RwcXiS+HQ/XVcsI2ZRjbqJ8G5lIH/0AOjfo7F6Y9YzCesz3D8YKmtsBQH5xg4w5UPxouDQDnYVQf/ruaeAu1otnYmC36/6fGXIltbg787fwoMzaXJOaNnO0LAUV/uHVxXEtn7R5VQkJtVSRt9jqPeSOeUME4vPTWbFiZUNjcpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433080; c=relaxed/simple;
	bh=vDDK33jEEp5EBnlC1HW/sV8/8MtglVuuHrpA5xFbNiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fR5eG8ezS5sRn8G3cXitIiO11BGRIQakK3NGCGX6dByNL1kvSNhv+eA8dScqg9VCTy3mtRPPXWZCpS/EpsKpdsbeP8If/MaNh2e+y+ZoAYajHZzgIWNRdUlxLss0eNp4KaqD3Z1C5BOw/JP6FGKcpFyq0kZvXKOOugsjefNJmoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiOIjF/B; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiOIjF/B"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43621bf67ceso22711f8f.2
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 08:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771433077; x=1772037877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDPdRiLpk91DL+wD8eFDTLzfQNR/e0JmMVHM/MS0nx4=;
        b=RiOIjF/Bokjyvqe8rDsXL1nOdlpxmmjJqy+scnxxkKNuFi38g03wY72A3cXe0dc4JM
         5BdrP2/Qq8Zx2JlFNIWe7q4aT7VoPWdT3bknOQCGjMA9Gntv8KNLmdP8R2cuoEn2IjEG
         jZfVmrjHSqD4tUOZN7gxNVVT4rIyUgnWF+Tal8bRTZgNbWURpfci81+rsbr1uhV72mQU
         QKh6cYj4JRQ2TenIPDyDIlUMR7+FrfRa0Bq1lbChASiV4FvSSMmWkXLGIiyOzbACOrGF
         6xEXoIUdf24p5Jq9sqAQBXYfK5Kzh8TU/t+Si7w7bvVBSwzQtXgwSg26zTOtlyD+UlT6
         plrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771433077; x=1772037877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDPdRiLpk91DL+wD8eFDTLzfQNR/e0JmMVHM/MS0nx4=;
        b=JjUYBARGbA0RHfICoblVXcKUiNhYD9guIu31su6DV2PE0/O4WIKDCAcWDguEAHr6di
         kXMMokDwKgLAGibJU1dXOmzyy02Z5q/JOrYx3ArV+1xpynUJt574IAGZjvqpWR5DJQ5z
         Gk1/Zyx+xv9scewbdTwDq9hbs90CNjcTDFjkovEaQZojcB5czW9TukeBABM7IKXEOvcJ
         uODx+vMwCVICZzynLgLlGP0W8vfJm3Sdp+kCoDXIWoDm7otn4yWmAKd+YcDisZQ291Ft
         bExU1fC1PETo6g3QroChPaPGHtxJ3EFvnzl7qz/zevD/HEyzz+jVAO4i1CJ3Pn4U3Ske
         ORlA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQ+uXt4tPcx6FrY0ljmSZXP4X2bkYfi0TY2gtalgqHmkIYOKBB1VBeGrihFujL/bM8IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZlcpEfIaPvz2ruZwBKMlInQBzh/y8sDSKLhQ0PuGshxd/ok2
	UdNvg26TNxmjWp+3wkI7cpo9RHRx8nj8LdvA6RDAF14kNOBa/we8YOkN
X-Gm-Gg: AZuq6aJ51S0oxKe6lqvrGpQ70qHqloCfmLxlfK1bi0z2cwiggLovPS5B+cfHN0B2mqe
	7ijKZIG9pcMhOlguZp1bMXx5/iKaweUNxkIYwaLfCsKUgPwtAen5bZKPhQV0DYJHXloqTUjXV6+
	1ASgpvuNeCEnVJwgLwVrBAQHpD019M8HDTZ8ksOJJ0+Ou4D8lrFqSFoyMe6k5O+kFL6A16uBjuM
	MUo3FogWDFph9cqLY2dIL4TTx+arLNv/L2Ty+gva/1qhr6zoXTziv+/OpQvNdCjAXvMT02nl8jS
	RpnnOXoKkXTMaMuyT5m5PaRUUIxB5mQOgg7Pa9yQ360cXbisJ5lUzLFcqaId+uZgdryIUlA/pHJ
	gnH/v3d08ewvuT0CG8kjU8eFkodkLH5Grabdrfqb54y+5VxWGW2utl0Du2bQ15A3Xi0XaRhNv9O
	DZcalUca+UvIM0uwxmsF07bPP7B/4OS/EVPtSWr8KZaWB/I9OWG7MwtfEqdd0/w4oiC7h5NFF7g
	Q==
X-Received: by 2002:a05:6000:40df:b0:437:7168:af52 with SMTP id ffacd0b85a97d-4379db25d28mr29641189f8f.11.1771433077064;
        Wed, 18 Feb 2026 08:44:37 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:93ab:614:2c34:ab35? ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437969fd36dsm45197117f8f.0.2026.02.18.08.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 08:44:36 -0800 (PST)
Message-ID: <31abfaef-f536-4778-8aa1-767fcc3da48b@gmail.com>
Date: Wed, 18 Feb 2026 16:44:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 14/15] selftests/bpf: Check BPFTOOL env var in
 detect_bpftool_path()
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
 <20260218003041.1156774-15-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260218003041.1156774-15-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/26 00:30, Ihor Solodrai wrote:
> The bpftool_maps_access and bpftool_metadata tests may fail on BPF CI
> with "command not found", depending on a workflow.
> This happens because detect_bpftool_path() only checks two hardcoded
> relative paths:
>    - ./tools/sbin/bpftool
>    - ../tools/sbin/bpftool
>
> Add support for a BPFTOOL environment variable that allows specifying
> the exact path to the bpftool binary.
>
> Also replace strncpy() with snprintf() for proper null-termination.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>   tools/testing/selftests/bpf/bpftool_helpers.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
> index a5824945a4a5..d810e73da6c8 100644
> --- a/tools/testing/selftests/bpf/bpftool_helpers.c
> +++ b/tools/testing/selftests/bpf/bpftool_helpers.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   #include "bpftool_helpers.h"
> +#include <stdio.h>
>   #include <unistd.h>
>   #include <string.h>
>   #include <stdbool.h>
> @@ -12,13 +13,24 @@
>   static int detect_bpftool_path(char *buffer)
>   {
>   	char tmp[BPFTOOL_PATH_MAX_LEN];
> +	const char *env_path;
> +
> +	/* First, check if BPFTOOL environment variable is set */
> +	env_path = getenv("BPFTOOL");
> +	if (env_path && access(env_path, X_OK) == 0) {
> +		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", env_path);
> +		return 0;
> +	} else if (env_path) {
> +		fprintf(stderr, "bpftool '%s' doesn't exist or is not executable\n", env_path);
> +		return 1;
> +	}
>   
>   	/* Check default bpftool location (will work if we are running the
>   	 * default flavor of test_progs)
>   	 */
>   	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
>   	if (access(tmp, X_OK) == 0) {
> -		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
> +		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
>   		return 0;
>   	}
>   
> @@ -27,11 +39,11 @@ static int detect_bpftool_path(char *buffer)
>   	 */
>   	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
>   	if (access(tmp, X_OK) == 0) {
> -		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
> +		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
>   		return 0;
>   	}
>   
> -	/* Failed to find bpftool binary */
> +	fprintf(stderr, "Failed to detect bpftool path, use BPFTOOL env var to override\n");
>   	return 1;
>   }
>   
> @@ -71,4 +83,3 @@ int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_l
>   {
>   	return run_command(args, output_buf, output_max_len);
>   }
> -

