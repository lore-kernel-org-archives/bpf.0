Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5935CB7E
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907754; cv=none; b=m5CKdgLjzubT3iZDr0nYPFoo7gOemrXhqaZYDa7N9+eE5EvRdhe4IBle6agt4ZPnnINK4yTkAtoBMGEYcmt19IUlMeuQut/mDQJkChzwYszE/KjblTYOonVBOioR/Kz1JP2cNb/qj8zBZrZuHd0wlmPX0z+eZunipK31fdS+tN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907754; c=relaxed/simple;
	bh=PK5jjgixGKlQ/vKoNy93k+86pzOAo0ehsGjF099RB2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIBuEtE78ryklmlRweeh67qHMVWfzJZZfFLe9UWlcRJuot96Xc4asgQcAafREvN5FnoLzgkQOMjJT+U7jvaAdQWyoLc6jQP52OGQFd7jIJJsAs85ir12BMzCvoDV96PfH5RsUEgehrmeor/tfV/soN0bBKehuC18nqWOEi37z0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok4B7krf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok4B7krf"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4362507f0feso4247484f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 06:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770907751; x=1771512551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OuJMGPovYQ0mnh7Rx90eYo1i05Ug0FF+c2ji/Q/Pofs=;
        b=Ok4B7krfQkcrI65ZJ7bGFV5BJBrONeEMy+wWfbGuXlhevWdQo+BkCk6Qck4w0mZX7D
         YZj3Hr3rTJGaXZUpWso9BGC6f+Fg1XE+dlgUvQsNG+HqRwcaqKiKEl0sg+D46lmcE5Jl
         NCQQ1rlaKSZOtWsQwEgknbEDaFKzY0GNp4NBPm0mlou+h0Y19FCyBypSl4We5DV2KYhA
         l9YHqtPQtN5nOD0Knt3snKjDSgNiIfnuuXnBN6yrx4tHJ1KIykfNc82gbFxQueZaiXPW
         IW8h2RjwW1srwzYWnlFu2VYiM4UkWAR+9273K5cCA9j43U2qZ/taoE1OgZNGwi6czH6I
         ARvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770907751; x=1771512551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuJMGPovYQ0mnh7Rx90eYo1i05Ug0FF+c2ji/Q/Pofs=;
        b=Y+2T/Nu06+7jKHxq+tZ2J4OQ4GQpKnquFvxsi+gDJ3UPynEcI6gFHHHuHsLSonC/Mz
         syHsSAqThmhPJjSkRLinO7xHO7ewJZLxxe0xeOFjP0CXqm6mmbzUZLX6JQBhEg7NXOdp
         k+mS5uyheV1KwyhH8AJ6yK6j+qDbY3G1zJWBeZPqEi7kGNaTu5w8GrZCtPr0XgaRSkgz
         OmbUSm60S4VMqg2Ppey03jloftbDXdLq42Sz0n8rj4IIAZgs2J/57I7bk91b8MQIIGy8
         SRx6KLoBjUX8+pnZCOvna3jvRIZg2OrREegmGymsMkfzqklHSTy4yNToEZyF/b+t2UfS
         VQzg==
X-Forwarded-Encrypted: i=1; AJvYcCXpW6ZGxwKBrZrMwp9s9t7N0E0Bf4SMAME6j2efyTJLIf5EpL1JdYx7/GKkzjT/u7kTqWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3DMD8euP4kHgok/2XffTvBkwQ95IQvf4wjBcVQiAWPenbNhi
	/d+7sIXPxFXD1hk2WqcxsSWgU6iK12OudPxLp2KMwH/hV1ID4lcYFrN12CY6rQ==
X-Gm-Gg: AZuq6aL/aGDOFGyvZdsHFvXRqoH/n/67FN323LMhvpm3Betidt4zw5RxaaZ/3VuUht6
	bkbCPd19zFOWEd6xkKJRCQd/2cfOYh2NGAbSqTgi3t5YRagEqkfx3cPR2TikbelYu3X7C5KdYrG
	R2NiW2qT2+hITgg9XbZjJ9Dm5QwVbj5jna/pkX92HneURcPIAgXCTtEPoWQUotMntiQz7ipWnVl
	O09uDyOItV5/6PJeVGlqj6OdWT00BwyqcBnt4TPDsgLePISctfNj/Ub2oeb5Ii1BkW1c/oD8KO3
	IjlbTUYhU7bW/D0CXkLxVVIybB+5ZNV4iuo4LcTDqjWEs+n674rgRy/31i4qLrL8dhVDrkroXtC
	iG6RSd1Q66y6VGBCqThIhCLNeBQh0WEuEjefitkgxLKp+JQHOiHjz+tHdJoEyTzrSg5X9XMnfHI
	LgdrkxVjKkbYcLMsRyQC3abvuP0GpL9p/4fn0vobN+eRpvGBpwAiksdj8uKwYMvzzLKFWwg9eep
	3ITmdeB2uPLYOs=
X-Received: by 2002:a5d:430e:0:b0:437:8fd6:d849 with SMTP id ffacd0b85a97d-4378fd6d8femr3226987f8f.54.1770907750844;
        Thu, 12 Feb 2026 06:49:10 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e5be13sm12862720f8f.35.2026.02.12.06.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 06:49:10 -0800 (PST)
Message-ID: <5de2e9e7-2898-49a8-ba1a-253dceddeedd@gmail.com>
Date: Thu, 12 Feb 2026 14:49:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 09/14] selftests/bpf: Fix double thread join
 in uprobe_multi_test
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-10-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260212011356.3266753-10-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 01:13, Ihor Solodrai wrote:
> ASAN reported a "joining already joined thread" error. The
> release_child() may be called multiple times for the same struct
> child.
>
> Fix by setting child->thread to 0 after pthread_join.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>   tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 2ee17ef1dae2..17881e009eee 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -62,8 +62,10 @@ static void release_child(struct child *child)
>   		return;
>   	close(child->go[1]);
>   	close(child->go[0]);
> -	if (child->thread)
> +	if (child->thread) {
>   		pthread_join(child->thread, NULL);
> +		child->thread = 0;
> +	}
>   	close(child->c2p[0]);
>   	close(child->c2p[1]);
>   	if (child->pid > 0)
As far as I understand the problem is due to `static struct child child` in
the test_attach_api(), once we initialize thread field of the child
it's not reset before the next test run.
Maybe we should also add memset(&child, 0, sizeof(child));
in test_attach_api() before each test to make sure all fields are reset.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
