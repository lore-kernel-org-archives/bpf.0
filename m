Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBE33BBDF
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541475; cv=none; b=hXgl5ShBg3PiYYmu3zJdtsyo3FOBZSw6obOusTJ52+r5glq1f+yyjOtS7dQoIBe5JbEQJGPEQz3TGv4WkzsfJUJnPzG0VCRUZSiFHF1IUGTNJmrttgSp0gA8b/2SPIUjAmS66+IJgqD8i3mMFbcm2IaQo5SQeNfdVMxj7IgUXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541475; c=relaxed/simple;
	bh=YaIfLo9ayy6pxGCXftDAbp7ELUaCXBerTOE/3Y1pkYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+u4Mqs/mlqAg4ld6Cczp6SWl+V001e3OlVfPjA2dGASaMnq4wvzpiRUA6+opw62WHYSsAQsB0vQ75Xy8V6pGpohd5UEcKBAZcgKQmz0n0gQdbcpXdOUTyExuWsH8m5ej1z+5opiCuyfcnAMB/KMxOGBwG8ic4AHOFxVP+20XzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvmS8f1j; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvmS8f1j"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b86ed375d37so697546066b.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769541472; x=1770146272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwpQ7AjDYbeZasLmNdJ7h0STwQ7k4AUlLz6dn/p1720=;
        b=KvmS8f1jPZSs2G9bReV1tX0DRX+JN1BdX+y1Eg9/IQ1XyVOUF0knz3My2v6s26C/TV
         y991k9rFGt6DKztOfJSeJCA9q0oXB8eg7P3TJR09PqNh0sWR2gVLuVdoVfG4u30q6NaZ
         FDixSGaspILUGi3BwRQUAyS8M9fPRrj1DuRL23Vn09X2ZGZOfzOM87zjNkPXK6daqlaZ
         SW79yq0U5q/D+n0xCbKoy2EpW2XCERSLBmkBeox++XRN2wTFzRBJ1Ibik5ZPaKcIEMRq
         dKjWq2Dhsz5BHbvdqgtnDkr9KOKdfYfUbJOZCcyf15nNvw3Hk0UVFPD0/hGwl52E/WRk
         PN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769541472; x=1770146272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwpQ7AjDYbeZasLmNdJ7h0STwQ7k4AUlLz6dn/p1720=;
        b=PzU9oqIt9MV2ow3o150bu1ox280/x+M0WZfk+305VzUTrngJIFwugt86/iFOQoMhE4
         LTqMoAXZyDyPA7C8c5lAR/58Zyzj2VnCO4Ds1MUXBiGz27zE5j95Fs1jTsxnbOEYpEX3
         K9rCE+bK5UjP49exTiJIK+PtEk7ieUZCtBrnTvpY1faLw9TsdPQ0fwLb3jGc5PCTmBjd
         yqzydPp/xe8+pldbDxPj3aX//cSeILMzyzs05+5iiMCB+HXRphhCFhd+LzHRXF007PsR
         dJpAVtPCZHmqVdZCxF3NTRtEljuMOilceKcgSMvP3/oppJdy8vGxSb4NYUvDjcTMh3a6
         czNg==
X-Forwarded-Encrypted: i=1; AJvYcCW4CcAiSeuw3SNXKq+mDntEJBbrOwy6pY6T7y++YifP6S9mIxFim8zfJT0Tos9wn/yM90o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvX03KeUELBjHxjExZ0mY6sqDbWrt/nirxHR5OaB98rgJfX0Uy
	xBODVvIjWp0kfFePhIN/lCr+hKkLB7SplycEjnQqfzDgLOruIdXmXVdI
X-Gm-Gg: AZuq6aJhVNE6+kRbsx893dsiFxQp9boa4IFyooW5sG5Rjs0fVz0Gau3fvz9oS9Bq/W7
	7b5wrfDG30eM69eXodVRLA6v4IbcPbeYjnWsM/T7KOeknvxMZuPxBefGWfAtQSdxqC0Jkn9fOON
	GvVzNLlFaNuULiw7THr7cb2yu+VvQFJxKzbg/0PB4zu/MQL+VGLm0NSR/vgIl/F9w8zXgwiEo/8
	xBxqlOmE0g6EbTuwvNA7OHVXeMb8nf556AKX9pf6MWM3ZKNSNp16zpie2T3/Igrrsy++u5ClpIK
	M4WC41j+Zkr3NQVDPhMJZ6xHRVElJG8NQjuxKqMgQ/W44PLpnB36GhqhM/SbrCay028OJPHkRJZ
	tDkc61mt0iu4LWsxTG49sai5tW5AK1MTz4YMwNlhwTPfgI/99cm4CHwuq1IFpPMj04HA2qYNk1c
	hVRW7faSpfCwUusA/aVLqHeE++m7GXYyMtz+QZ9+tp4xleCyw=
X-Received: by 2002:a17:907:7207:b0:b87:206a:a241 with SMTP id a640c23a62f3a-b8dab13028fmr195151466b.11.1769541471594;
        Tue, 27 Jan 2026 11:17:51 -0800 (PST)
Received: from [172.16.1.11] (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1847f9sm21168566b.42.2026.01.27.11.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 11:17:51 -0800 (PST)
Message-ID: <8fa34825-ea90-48e7-82c8-00cf4c7375de@gmail.com>
Date: Tue, 27 Jan 2026 19:17:49 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] bpf: Add bpf_stream_print_stack stack dumping
 kfunc
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, etsal@meta.com, ihor.solodrai@linux.dev,
 martin.lau@kernel.org, memxor@gmail.com, puranjay@kernel.org,
 song@kernel.org, yonghong.song@linux.dev
References: <20260127181610.86376-1-emil@etsalapatis.com>
 <20260127181610.86376-2-emil@etsalapatis.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260127181610.86376-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/26 18:15, Emil Tsalapatis wrote:
> From: Emil Tsalapatis <etsal@meta.com>
>
> Add a new kfunc called bpf_stream_print_stack to be used by programs
> that need to print out their current BPF stack. The kfunc is essentially
> a wrapper around the existing bpf_stream_dump_stack functionality used
> to generate stack traces for error events like may_goto violations and
> BPF-side arena page faults.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>   kernel/bpf/helpers.c        |  1 +
>   kernel/bpf/stream.c         | 13 +++++++++++++
>   tools/lib/bpf/bpf_helpers.h |  2 ++
>   3 files changed, 16 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b54ec0e945aa..c30a9f68af6b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4562,6 +4562,7 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
>   BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>   #endif
>   BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS)
>   BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
>   BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
>   BTF_ID_FLAGS(func, bpf_dynptr_from_file)
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 24730df55e69..6e2cbe5f34e7 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -245,6 +245,19 @@ __bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const vo
>   	return ret;
>   }
>   
> +/* Directly trigger a stack dump from the program. */
> +__bpf_kfunc void bpf_stream_print_stack(struct bpf_prog_aux *aux)
> +{
> +	struct bpf_stream_stage ss;
> +	struct bpf_prog *prog;
> +
> +	prog = aux->main_prog_aux->prog;
> +
> +	bpf_stream_stage(ss, prog, BPF_STDERR, ({
> +		bpf_stream_dump_stack(ss);
> +	}));
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   /* Added kfunc to common_btf_ids */
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index c145da05a67c..6d8ae3887618 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -343,6 +343,8 @@ extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *a
>   /* Helper macro to print out debug messages */
>   #define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
>   
> +extern void bpf_stream_print_stack(void) __weak __ksym;
> +
Is this needed? bpf_stream_print_stack() should be available via 
vmlinux.h, shouldn't it?
>   struct bpf_iter_num;
>   
>   extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;

