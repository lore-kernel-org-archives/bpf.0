Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD161552FD
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908616; cv=none; b=E4fveh7ywSkv8AYsaR7LXrcxSCnco9iJ1t6sv+fYZmW7PtLdCMojDLCHhMgTmBjFS7lDqcxSjkBFKjzwKw+rf5a1KCzTA77eqiwBQAwiBTl0incWV0+yq74CBIonQ3NxpwNfAWlDFry69QmP4quxZP8vAOsySwrJUbC4ZtNDQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908616; c=relaxed/simple;
	bh=pjHL6nfFZNmObRUg03oolXUyoA6O+3vFT6CCgLRvuEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqRDeBrxXYH0rIYxzXjkUeuLQf+i5HdDklcExbJTKb/GA9Y4BmHs3lQouyZACaznNBGVwR9itMxKJwiO3LlWObdxI+kDpihklxEDlaYERHM2pFWTC2VVp9UvPIkWDrMo1it70Qu/Dr5xibZhGk21C+SZNQ9PQwa/FHHqdRSuSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQtqVY4i; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQtqVY4i"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so2426556f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770908613; x=1771513413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMm+NpvUYUfUAQQuakZgWuhdBxlfHlslbmoPUfg6rKc=;
        b=bQtqVY4iVFc46uvoRJKL8Y6YECUoAxgr+r3hs0vNxjIlVDeL1aomQY1/qemkF3tQsF
         Shf/nbTEOOAFeuZ7TV2qb6+ivy+ds6IEd6oEy9OLzyXTWFWD2np2rAF6zvesXKWcKWpY
         d4FYjjFc6IOECEr7et/UQ0ruyyX82EX1LcCSVlJrxyo3pqbSCjU16/uIy1LICfeeaejZ
         GU1tmqn7CathB2/tlli7W3V7ZUMQww/T5VjCLOqUQG69s4Yl4z8qv2+VK56vNsESwFKp
         iLPSdVWvCRXAUw7ZAsbNHZD6JA56fK/fqvlpmw2gcw/EqjFTEM8WydNJasu/e5BpJHVy
         F/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770908613; x=1771513413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMm+NpvUYUfUAQQuakZgWuhdBxlfHlslbmoPUfg6rKc=;
        b=Al/opexLjrUxobVwnhDJYWbnAPOdhr0VeTrh8NRAeCd2cyBUJVLzLzzRIhqq1rlj1m
         rZXozNqlKiysIZ5W3F9dzfUf+kj5sEaylFxhZpje85Fj5vFx53+jXTLTRBWfYDId1Vy7
         P6yjoN/+esRIaE5EC2Qco6NdY0wFzLNgkkLA6e7Dmp/QR9G/SJUok3sZ5qtnky+EAW4e
         Va3lmcBRzgU/5U+96CdQ74evJ7J72zz6NhKnarU+MLvmFaqrBgCFzQ/8VqAWYQs/QVqQ
         dzs0myl4XHwQCKG8OM+mPL7yPtRlK0EzYsLHHMuzqLDOfElQlqxZlDS+LU3h+ZPAOdX9
         Q5HA==
X-Forwarded-Encrypted: i=1; AJvYcCU3BVfRZHRcIuyCvICySOacdNGQ30fOnRHW4NZ6XT2dmR+R72OVbJb9zvSkx+P45JKZZw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyhb+cCn6LfErR4LNmAkPBpZm+WWfETOldEcygMG/CXNsA+fDX
	2dRIWxRvzepH5P5gt0kKj9jOwEvgK6gRQNMTBS6GblRX6g9Y4nDuOgUm
X-Gm-Gg: AZuq6aIAp8IbFTcXtca1UXZhnp3kYWFLshJJIs11WcM6lhaa+M1/bBp/i5ql1vZZo9P
	dwwcsQ38gPxQU7LG5qoIdxm4LsYnH6/9gkFhOfNDi0baIytJP300DCSJqhZiU6qItLLc4vRUCgc
	W0GvEKruNlOxKZwMAtp+frinz4BEhgQxQcu4feXUK1m8JTD01CFcxK+RhygLJuMtv0f67gjEagX
	AnBHEIp1jDfI+HzxxWekFVy2Qg+8CkZOllKUE0fA7JN0Nmck3ZwSPycC+p2/WJ/gTSavLZs1SqA
	CeVmmuLLR2UVdtFx7fXxDNmZefbkgvbJuIkhlXl/DR3B3RFYpwpcbTWPIoYB+7WamcgM6+XyTWl
	/tIsD2/EbFchcZTiCnLr9HqiJMEdCna6HrE5j9GyI0srW+tvctVybQL7OOANjcdM0oQ2Fy9HeZ0
	ukurvY/ozmH9lllYzb3ij33uLR8A9qpsQraVuEb5ayJOcForPmjyRb4Rqo5bOejsUxViFRm2j+l
	f13aqX7tqbyhdc=
X-Received: by 2002:a05:6000:18a6:b0:430:fb6d:1442 with SMTP id ffacd0b85a97d-4378f17bdfbmr4668209f8f.62.1770908612949;
        Thu, 12 Feb 2026 07:03:32 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d746a3sm13012472f8f.17.2026.02.12.07.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 07:03:32 -0800 (PST)
Message-ID: <f0181dbc-072e-4d1a-8344-0c6d21c6c0e2@gmail.com>
Date: Thu, 12 Feb 2026 15:03:31 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 14/14] selftests/bpf: Check BPFTOOL env var in
 detect_bpftool_path()
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-15-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260212011356.3266753-15-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 01:13, Ihor Solodrai wrote:
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
> ---
>   tools/testing/selftests/bpf/bpftool_helpers.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
> index a5824945a4a5..5435ecd720d1 100644
> --- a/tools/testing/selftests/bpf/bpftool_helpers.c
> +++ b/tools/testing/selftests/bpf/bpftool_helpers.c
> @@ -12,13 +12,21 @@
>   static int detect_bpftool_path(char *buffer)
>   {
>   	char tmp[BPFTOOL_PATH_MAX_LEN];
> +	const char *env_path;
> +
> +	/* First, check if BPFTOOL environment variable is set */
> +	env_path = getenv("BPFTOOL");
> +	if (env_path && access(env_path, X_OK) == 0) {
nit: we are checking access(path, X_OK) in multiple places in this function,
but never report any failures if those checks fail, it may be confusing 
for user,
as file is there but function fails to find bpftool binary.
> +		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", env_path);
> +		return 0;
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
> @@ -27,7 +35,7 @@ static int detect_bpftool_path(char *buffer)
>   	 */
>   	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
>   	if (access(tmp, X_OK) == 0) {
> -		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
> +		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
>   		return 0;
>   	}
>   

