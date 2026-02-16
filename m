Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DD299948
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262506; cv=none; b=DMqT7cNiAYCXjs0CY6VZEuuaQ36sNS+jGtMcLhhNU/3F05KUysTyw1iTn7LZItz1HK6aVbV7j60YIPtks++mh+G0J98ZjIZ3yyZ59VxFeXNWEMOPYOOE2rMQ8MAN2I4lVfesIbDvXpYpsuwta4yGdEukOYnAMhrbEd1t8eMF8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262506; c=relaxed/simple;
	bh=c6CTslHT4nO1dgMCQ1AI/ki9lcEWwsS0luH2lkZaV/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgngWz/Su6OYcaJphZcZ+aYrBe2gfFR3lHLL9o0ChY1UiY5YrDGBhZ5iqbEmGz2pnD6fQf+qcniHiIvQWkg5d3KlInNdfpxWHdo7bz+rVzRz8VZZNHZhBy3Cv5Uxih+wltxpGsbrcZrtwc6svQM+56ysReNtfjKIPPEb6UbSxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXBYzTze; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXBYzTze"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48371119eacso31503945e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 09:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771262502; x=1771867302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUYsiLQQb1qxD78TUcLFJF8LYak17Djcv7sVzcOMuzc=;
        b=FXBYzTzet7+R4yOtBUKkgyr0JRLyCCVVsHm0e5U8TqzNegfI9F+YvurJNTFCoJRG9q
         6T2HOSDUOleGbLJzQyNmnxTieSMxoBX7RiAk0VT11bghL1dz/y4l+Lf8REsyuergnggk
         5LVIswNSyE24nIKeQziOGsYxipY/FMYLos1MIzYTAQ5l69RSIuMLyRlqzSxjoNs7E1NY
         pI/v/I26nlFLha2OW51crjJPm1ANXYYj71eXTJFDbEQq1V/H5ojPp/5yIlZ4GQcgSbFM
         KRmwoqFj1o6hFDrxe+JY6A6WNpt/PbxLstE1lELzA5pHhDJ5v3eqSN+2/Tq0Pl8EZX8h
         MgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771262502; x=1771867302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUYsiLQQb1qxD78TUcLFJF8LYak17Djcv7sVzcOMuzc=;
        b=tnE1sN6OYnqXNPdTZ/nNBVy7v4dN8vmcY7vUYB2Vk44HzDNjRaEMpEliOjDbRWrZpS
         L0S+ErVZrOW6p27tInhWEkFpylFMsjvt10mRRlsc3Phys48EL3X5uNu7frtvQsnVuxOS
         riWbfooKa5ThUF1dxG9kOrzwXApJ3jWnK+aM0vDWwVBnwev5aoEebaaXGhIw8cFRdD4Y
         hiGU4v5S1TtKudoNXXn/A9qSLLlMhXYbMGBsFvsWsCZB4gGM0OCs/vuFDlul6y7Zfomw
         wGnR4zYARggxdsaBnsr0Ux5eO1Mx5pTxwxZANTyU23/4xBz98JanRGwmfBHx/ND5KyBg
         IXgw==
X-Gm-Message-State: AOJu0YwnaPf29UbAqHk+zIgigxQwuswrRYPf8Q2HulNMFQjnEmtNFhGQ
	vsOQBxcLzVWsbuoM8KeNS112rrht5Zw41Wn9oXfRGSvfb3aNwoBLYdN7
X-Gm-Gg: AZuq6aLwun9sQqEcJT5oRxyg+eRTtRmhvPGW4xPsJShM0wRoE/J5DAfvyCuNkLQ2ECx
	0H7J3Bdq/8cAtOd0Cfx9JSq+rdVXK9Gsz4rkP+yR123NyTrqAMqkWRILMtlai+hQNtjNk/EzTCa
	OkR8yMylxCTgrN56w9+3yDQEYTWmdoGs3fVZBWucG4/JzWlZJGwcTPEjlCqipJkekJeuC/vkkBN
	bK5TgnibfRE2WPOMUR4W9hPx23Fy4/f5MwupclbVwbgA2JS17qDYqGxcyszuyHBurL/TbbGoYv8
	7KfZIsVrtbpbnuLE0F5ToOgbVn3hFnn6OoYXpDvp7hl4vt8Cm+GctjKd0GdhnygulJrNDwCnEHK
	IsZz+kaqFg6wRyjCxhiimsg8VSVp5ZvarzXmhACGrkxYr94W/XWkWTMThBSPjyr/MOD0NO27S+G
	ZWFvBv/awOeU0k6kfUsnZRob3W3bvBYMWLB5q+Bz5H9nBVQs3Wg0qkaP21XuQyP+px
X-Received: by 2002:a05:600c:1c22:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-48373a786f3mr207765765e9.33.1771262502336;
        Mon, 16 Feb 2026 09:21:42 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:b45b:76eb:2b30:c35f? ([2620:10d:c092:500::7:abe1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc21dsm29890450f8f.20.2026.02.16.09.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 09:21:41 -0800 (PST)
Message-ID: <3658dc31-630b-48d2-b47b-d174c73955cb@gmail.com>
Date: Mon, 16 Feb 2026 17:21:40 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] selftests/bpf: Remove hexdump dependency
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260216-bpf-sft-hexdump-od-v1-1-f8cebd8eb9d0@kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260216-bpf-sft-hexdump-od-v1-1-f8cebd8eb9d0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/26 16:30, Matthieu Baerts (NGI0) wrote:
> The verification signature header generation requires converting a
> binary certificate to a C array. Previously this only worked with xxd,
> and a switch to hexdump has been done in commit b640d556a2b3
> ("selftests/bpf: Remove xxd util dependency").
>
> hexdump is a more common utility program, yet it might not be installed
> by default. When it is not installed, BPF selftests build without
> errors, but tests_progs is unusable: it exits with the 255 code and
> without any error messages. When manually reproducing the issue, it is
> not too hard to find out that the generated verification_cert.h file is
> incorrect, but that's time consuming. When digging the BPF selftests
> build logs, this line can be seen amongst thousands others, but ignored:
>
>    /bin/sh: 2: hexdump: not found
>
> Here, od is used with awk, instead of hexdump with sed. od is coming
> from the core utils package, and this new od command produces the same
> output when using od from GNU coreutils, uutils, and even busybox. This
> is more portable, and it produces the same results as what was done
> before with hexdump (without trailing whitespaces as a bonus).
>
> Fixes: b640d556a2b3 ("selftests/bpf: Remove xxd util dependency")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Originally, I was going to add a check to stop the build if hexdump was
> not available, but switching to 'od' seems to be a better solution while
> not adding a new dependency.
>
> Because test_progs was not reporting why it became unusable, I added a
> Fixes tag to have this backported, to help others. Feel free to remove
> it, or even drop the patch if you prefer to stick with hexdump.
> ---
>   tools/testing/selftests/bpf/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index c6bf4dfb1495..5a618d14243e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -723,7 +723,7 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>   # Generates a header with C array declaration, containing test_progs_verification_cert bytes
>   $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>   	$(Q)(echo "unsigned char test_progs_verification_cert[] = {"; \
> -	 hexdump -v -e '12/1 "  0x%02x," "\n"' $< | sed 's/0x  ,//g; $$s/,$$//'; \
> +	 od -v -t 'xC' -w12 $< | awk 'NF > 1 {for (i=2; i<=NF; i++) { printf "  0x%s,", $$i }; printf "\n"}'; \
>   	 echo "};"; \
>   	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < $<);") > $@
>   
>
> ---
> base-commit: 886bf921ecfc30f8f31341bc26560d8bf08b937b
> change-id: 20260216-bpf-sft-hexdump-od-abd07a3bf026
>
> Best regards,
Works well.
Tested-by: Mykyta Yatsenko <yatsenko@meta.com>
