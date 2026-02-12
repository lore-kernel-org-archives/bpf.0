Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543873587C2
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903440; cv=none; b=gb0cvv2sDo6zb1v9yxe+e+odNNuF9VXWXtuE2Nqk0CzRbZ77Goel2bXS89rxTKPJMLKA+5eFbjPScN+DTTUryHNxytgLPrm8/KPX43p0jNWtG2yWF4A+VE6xmzQxtYz5/SaiqqbQRc7O984OLozk4xwetR6iBgrhhxbG/c8vcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903440; c=relaxed/simple;
	bh=deLFSuAQFSjF6ZGATpkTaOeJvRtelQ8Y2Y5Hs2nqCaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzwwpVaBRG1Y20yG+QycSx5TCNjQnnbGUWkHvhGjyj3X6VITN9PDfsm2BxlNoKHoXqB90UoxjuNLuUaLqJ6CHmnW0kQNSI2Dkt9XF6cBIkWvioWqVxgENTkv4aaJgEFA8ZlgCAjWNDLgHNoS2T2bJJk1D4XsBMVWV0qhjKcT4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwslAq5Z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwslAq5Z"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362197d174so2140759f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770903438; x=1771508238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LL7FfwpzgJtDFMJFq7rnCLZWoWUrp/74XVGsvOhr4jw=;
        b=hwslAq5Za/bVAHfKPkma2CPiMUtlvdH408hP8q6tFE2uigVaon0EuwWRu+hIBXv/o8
         USMezepfI7uTfgPt7k8sMh6o5eBUy/4Qa5sswdnkI7GWshzMWQvn0YDUP38DHM19nRIU
         72iWCAS9Aj3AjjQVXZJ8BUm2ofvdBlvdfVTl2s7hzGNLUOu8msIde8bzBO8Z1FlIPmJq
         0QMSer1ZD845b7Ot0wt0SDJAQ+RG00sY1a1FgMVd12Ra54OV2d8Qntgu4AAsBvM3q6VJ
         Dy0baQGuH4bPsluRKtpl23YEDTmDoq814EEtvEKVeEoiauy9AGJ95YAP+EM4pKXz0BNK
         z00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770903438; x=1771508238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL7FfwpzgJtDFMJFq7rnCLZWoWUrp/74XVGsvOhr4jw=;
        b=rOKdDIBXZ0thVMVsyPnnvYjq6lWtrGkqwOVWyHRl2QNP+2FIu/TNYf46tXDAgQ4qBP
         LVnPMCSnF7LD/f9hHI+ktg5zQH0nPw0iXk/98Hz6C9qVuGhekTNBm/TW6aN2CY01lbw/
         upPHJJz9wStmX9N+3rD0Azv7McGhSQKf/ZXhnrkuW10f5RdiXMALffeH+MnIsZ2+MZ6Q
         V/wgdW1uMtrcJ+uDFoqQx8slWaT+jQkabBV9tJevu9AiuPtfZynNCIHn8RQQsJSZpLd7
         E/pjlIntgcdGnl42fKb58VLJpzwRuvUYW8Xr3TNBDaitzs+3kFuBS89v0JL5A1K0Lkd9
         5ytg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0jpLLenutb8vCCeML4S3YE/GJzZBc84eyVfnhks5NJCjf9M+ozsxlgnVMtcNPoOc6iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lJ2bww2yjxvgZT325WrOnkrwQnhk19BjNB4oxykT4H+EkxVM
	E6oyxSGLDlo87kh1u6pP/0/M5s0MZ3wyy3LcYQ9FN8TNrmdtzwWL1v6p
X-Gm-Gg: AZuq6aJDLtSSygbtXeKhoOcGDhoVvjFQO5EVTsjCnQtaano9ADuSJgu2ToHQzmoKpPY
	wf8IRki7VNr+62AsitU5Fo8BDxAY/0y32OzxOhH0AuNJtbua3lmhxhbXwD1v5uSIJZHsLFrEPng
	gPsQ7+ItwNtV2yCTm0dyF51NeAhJJZCzqhrCbuD/aIctBUxjXTv+u9a7f1mQKFxQh6QN51QMxTb
	XoQA+7L7b2JfNrjuatnQyLkTbXtS+vtVV+lIiawsmm6divYfMriiSbakW6CHRinB8t8uD6GaqCx
	8gG3hvOHFwvJSzVevpqWmuhyfR3tpColZh2fwVVQz7/RTUgAnvI8zm2emT6vJdSjBOIOIJZhjN0
	VZAmUnDoWOkUS+Y9HUpUZyGCE9LuyNfG+0XRa710RGwQRroftrZmxuRrw2sn1C8SiA0QtVms+Pl
	+6pwGm9YuLwcA7tDUSHIp/U3o3m6NNJ5dzAARiIN99xZ+eDgju/GVDBilelPGls+A2dsdMoW3G4
	gwKiV/DlBKdOHU=
X-Received: by 2002:a05:6000:4010:b0:435:94aa:df3c with SMTP id ffacd0b85a97d-4378f17c0c7mr3658596f8f.61.1770903437418;
        Thu, 12 Feb 2026 05:37:17 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc2b0sm11565352f8f.21.2026.02.12.05.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 05:37:17 -0800 (PST)
Message-ID: <71f267cc-97e5-46ce-b1f0-5b2379f9063a@gmail.com>
Date: Thu, 12 Feb 2026 13:37:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 07/14] veristat: Fix a memory leak for preset
 ENUMERATOR
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-8-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260212011356.3266753-8-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 01:13, Ihor Solodrai wrote:
> ASAN detected a memory leak in veristat. The cleanup code handling
> ENUMERATOR value missed freeing strdup-ed svalue. Fix it.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>   tools/testing/selftests/bpf/veristat.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> index 1be1e353d40a..75f85e0362f5 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -3378,6 +3378,8 @@ int main(int argc, char **argv)
>   			}
>   		}
>   		free(env.presets[i].atoms);
> +		if (env.presets[i].value.type == ENUMERATOR)
> +			free(env.presets[i].value.svalue);
>   	}
>   	free(env.presets);
>   	return -err;
Thanks for fixing!
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
