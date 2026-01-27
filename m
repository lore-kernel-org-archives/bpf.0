Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1171325722
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541995; cv=none; b=nz5omKm3l5unMvncl067LMRFwWVPQ2kLvSpYZvouMimfCcsEBTdjknsVX/u7VlsjMmxBeB6HOEVAmZHNZzTetCRnytqtyrho+nzxzNBonT2ekoxWnvGsJEnx3n4rLjP/I6OqunOyo1SnS7vMQj1RuzwHs7Aot5p/4KL974hS9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541995; c=relaxed/simple;
	bh=fzXP5ARMmZvpyvpN/SiOXKnrNxldRDPrgqo84dFdYG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8Zd/Bpbroct/IKZNmIOH9do6jGqntP+m+eiyp4xrMYyHDz9x3L023T2+UN2Oie72gdXql21QOqdfXu4AqgdiQUlB59iYjFhfspcbSkgxQwHQAdU2SAcrqm4PZUqXiyODbrm3Ne0hcRgocowcVsFzCe1HJm0RFpG0b4Ira88fT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbgHT3h6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbgHT3h6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso9764155e9.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769541992; x=1770146792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nxq5Ny1ONESd3T5tuyz2htEwSHUw396RXNXjhPDaohU=;
        b=mbgHT3h6Qh2WuXyBqdmzItSbbQeBQm5AGH/3mRSEEiT8uZR2svFtts9fjt5agK834f
         AKqf8qNN35bS9aWGaACGL3icgLiALcyWtTBACirSH0dgkDefY2jGiIRw1drt8STr56i9
         POC9WA2JHxcz2X/L5Nt6X27FqIN2pWD/G3j4vol3u4g8tAj513I16v2noT9lsL90R2ML
         Ni2oeQP+zzOz7tMT/7Gv/3fQpWPEJ2aFND6g4hvTlqk4QDsoim6RmK9gmLx87bX4wgPa
         RjfBKaMiDh1nXkHYdWdo9DYwql9t/rvZhoD2oKpTu7pgOVsVUXbRifJLYXeylvhI8I7L
         YS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769541992; x=1770146792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nxq5Ny1ONESd3T5tuyz2htEwSHUw396RXNXjhPDaohU=;
        b=hDOoNwKsCtuqXM4B8hx3HRlGn66UM5aA3IPuE6zeAtAwp36NWH6FksQ7YzfAQsTVT4
         RuxbVnkzpMIXmFZOBWshPJuuVN8Rc+Ctgu89APj36fRl4AgKZES7uIJxH0oONDDoPQ6V
         JvfJlNfIF58LfHbK/RM59giAWB/91qJHKZeeGMT7sNGimR8+hsVey1mKnW3hro+skzyd
         PsFeux7HS5F2aOJ/TsSOTlLTRiSEYqvsEg6/PEPJikdm/JzEg0nsiOQ2hafFwV+OfBoe
         AK2YRxgqZo3jAc/1+Qzee5HW2V7umoEP9v1PiVPNN/2b6NzGQtXzh+VeAwKwPoKmaYb5
         V16w==
X-Forwarded-Encrypted: i=1; AJvYcCXqWxOArZj6x8bxPdWa/XuDEYtwpJzF2VpViLQQpTo/10ZG/pByxWJ79rtnZGq4ffhLZzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjXkHyrQsdNLDpHSlt2vjqhHrADloGURZ6pglF1a8CNd2RSLzZ
	F8Mq/zu6a/s2FpI+fTWav+0xQnuygsiwhuH5eetUggvLDSuQsip27nK4ElHn3OSh
X-Gm-Gg: AZuq6aJKCEIvwtd1KTvYmrwLOV6MoY2p0qiMSwwIWMDJ1LGx1lEhSlRLyR84CidcvP1
	OVNpdlj0o76SRcxP1ITXZkuSuBW4o26QOMKF/jCnWb1lgp6E/o71WrEcohln2+P2FZZi6U5Dm/p
	nFpEB6mfVg0DKImkhmvyHQq5AKUyr7mJCjTdt5YxtZqX2YfOGkmb21O4w4VfJ/g4+k215JPshgN
	Fj5rgWfS2/gsTjxLBoLL0qY8zMQPnJosY4s7xsHIzCZnXYDE7q03sjOVookbL9CmuwwH+yfSjcC
	u9zldX7O575g+PzqnrN0jUbJFCMRXhLS28Jkitarw55K0FZVT93SQE7a/EOiwNL59keV7X+DpUm
	GBddcH1BRvbJafSraGds7TMUtmKH62VJtKmnWqM2wD6sUe1hgvva1TNe8dBE9jmF/K+LGt0/Nu4
	UZJcRIdV2DlOMU5H/yqXoLy8RWfVzp0v2kCSd1EjdkN7Vnm81k+o13bivSLg==
X-Received: by 2002:a05:600c:3105:b0:480:3a72:5238 with SMTP id 5b1f17b1804b1-48069c6098bmr38679265e9.30.1769541992192;
        Tue, 27 Jan 2026 11:26:32 -0800 (PST)
Received: from [172.16.1.11] (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffe9sm23847985e9.4.2026.01.27.11.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 11:26:31 -0800 (PST)
Message-ID: <92fcc97e-1313-424e-b67d-d86effda3481@gmail.com>
Date: Tue, 27 Jan 2026 19:26:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] selftests: bpf: Make WRITE_ONCE macro in
 bpf_atomic.h conditional
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, etsal@meta.com, ihor.solodrai@linux.dev,
 martin.lau@kernel.org, memxor@gmail.com, puranjay@kernel.org,
 song@kernel.org, yonghong.song@linux.dev
References: <20260127181610.86376-1-emil@etsalapatis.com>
 <20260127181610.86376-5-emil@etsalapatis.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260127181610.86376-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/26 18:16, Emil Tsalapatis wrote:
> From: Emil Tsalapatis <etsal@meta.com>
>
> The WRITE_ONCE macro is identically defined both in bpf_atomic.h
> and in bpf_arena_common.h. The bpf_arena_common.h definition is
> guarded with an ifndef to allow for inclusion after bpf_atomic.h,
> but the opposite does not hold. Add an extra guard to avoid requiring
> a specific order for the headers.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>   tools/testing/selftests/bpf/bpf_atomic.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
> index c550e5711967..d89a22d63c1c 100644
> --- a/tools/testing/selftests/bpf/bpf_atomic.h
> +++ b/tools/testing/selftests/bpf/bpf_atomic.h
> @@ -42,7 +42,9 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>   
>   #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
>   
> +#ifndef WRITE_ONCE
>   #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
> +#endif
I wonder if we can avoid duplicating this macros, for example by
including bpf_atomic.h in the bpf_arena_common.h.
>   
>   #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
>   

