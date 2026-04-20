Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184883264CF
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699160; cv=none; b=GC9ShTeWma3bDyBTiKZoi2vbFm4xoFfIQPwCTYuceN0lXyb0BI2PP+DwrBD/hG0mgQ0owMAA5lErXXUEY8QP+0B3lcFHKOvKZ1RwtveywVneE8XuOpDAiY5D4G6G3RG1rLx2wS3bcKZBJRUdKUcXXf2YtvyI6VYLfRGlMw3Q/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699160; c=relaxed/simple;
	bh=7WD3GmCeQ0sLEmg32isWd1luQ6y+NXA7EMRcFgI8WrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jlhuc2LuR7ZIBseUcCGlKUdrXxKsyiAzHIGICKzImsNCKEq8oCTkj1bcY4VNUI0xioT4vfwnN0r5JmI18iwMowFt6zibIviwaJdDV9NMb9VkG2NkH6OyKOgRVS6c55eEC8enAobFXoGSksKxe+zCWdw/X4DRJnZpROL2R+SZlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du+24gER; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du+24gER"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso9833695e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776699157; x=1777303957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HB9V1tj9sRWi+um1+r+SHFBJjSX2BbsCVyQeyD2SET8=;
        b=du+24gERn2pP1KiwVkIpfRW5OUG912i7/uwJFAsv3LGwZpqsZFdfq+tICy6HJK6Amu
         on/vVwBK4OfPxZO1G5s8AAj/JCJ12tyZRVlJA8AiMbk36RyCCVLMaTYq5QNrcns+MmZz
         XoootCYyVmeR4Lro/S1bQbXM6ypQj1xUhlHhIzwXaTxa+3jJNaRoskViCI2/UjZHJXYF
         T6oc82q9lTqVKplDHRvMUCrpRxSwpiDb+0frD4se0PRcj9R4t9sNkRUDeWq2UWXot1ii
         QLCNqhS2fN1Z7FZAmnq6vJ8/I9HekZLO0GDpPquzcHw0DXLWPrGuAJ98NLunEmj8DT6X
         Ko6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776699157; x=1777303957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HB9V1tj9sRWi+um1+r+SHFBJjSX2BbsCVyQeyD2SET8=;
        b=EmuwT9ksLNAnCXa8LD3dS9M7XKTMW3LA/d8Kkep9xQBSlTMyb83/shjNVMUD0WSUSe
         ZxezB0l8XWU87qvN46E1l5Wi/DKMleYwDhva20o3G+vnggK7KFe5qH0m7Hr+7xLhMNyB
         uKohutXnG41TGETCjjiNIZvrX/bozdS7R3+iF6z8I0YncojbUTv50ppHTRsNAKxOM6RV
         ARv6avSVHoNJ8hTCTifiMN2iN3npladX42Y486J+KXNPliS3FGPDxit3cTPSfYKS0Zo+
         zpGxVKMz86WjkYMhs977y1L8DjFpC6arvKucbMLtPgAHp6Hssl75iJKzluXJIAFLh47f
         jung==
X-Forwarded-Encrypted: i=1; AFNElJ+ENfleZPI57B3H+vSq7fYIhF8PLfafdd7O8Z3kR8alEPaXiqbJCC/MBj4dFPdI/AYhcIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKuK121ZO4uCd5OiuUauQ+D7gWb5ghR6cY9O904dTgYOgL6GF
	1DKdDIXXgjgyRzHNekj8qIiDKVNpPOCKBVoLPI0cvncFJgPrlGxR3Ky0
X-Gm-Gg: AeBDieu8o8QBi8dlfVq9VOH2IPx3apeE2gWV1ki8aYFNTzhjQKtqdrykpwShHODzSno
	++Kx5uXbhH9yuukQx3SjGzeYYSaGt9/+VB1IwqMUChyzMSENJAhFS6WYqPbuMYSlX3SGZc6OGyG
	ssvjvJKwhHw7DA4GI9TykrBcy9MYoGhR/5kI17K1gZd7m0I9puGn7oHqYiOZHR/oNle+FUjfsna
	1C+N4yWvkgjAT7YThiZrjGzgmtjxAcG3NFQ6TieWDWqbjySYtej2duEwYLyFwaqfOBpKB5fwWb1
	F132KBjObHwq1EwFPG3CrA3MjnhWZTPPVtQSJcyQXpAxcK3+WM+5cc9vftNftPNK6ZrTJqAmtaS
	z5yMrS1ydD2VcXiupu8583h4sugyLbxMGjYG/btDObN+PFczUMPt9yPi+nLjs8ktAatfNfwApCz
	9a6Y9gbG5aR2r6snOUjld3bvi1/podv0HkZ4OpcxW1i5oLRLWda2oZ8Svr5seowkLcjWSjIw==
X-Received: by 2002:a05:600c:888b:b0:488:c80c:c236 with SMTP id 5b1f17b1804b1-488fb73d525mr165169965e9.5.1776699157077;
        Mon, 20 Apr 2026 08:32:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5432:2d05:ea5:f7f7? ([2620:10d:c092:500::6:8ffd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c318636sm90474505e9.7.2026.04.20.08.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 08:32:36 -0700 (PDT)
Message-ID: <a16f78df-eec3-40ea-894d-d7768b8642ba@gmail.com>
Date: Mon, 20 Apr 2026 16:32:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 1/6] selftests/bpf: Add bench_force_done()
 for early benchmark completion
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Fei Chen <feichen@meta.com>,
 Taruna Agrawal <taragrawal@meta.com>, Nikhil Dixit Limaye <ndixit@meta.com>,
 "Nikita V. Shirokov" <tehnerd@tehnerd.com>, kernel-team@meta.com
References: <20260420111726.2118636-1-puranjay@kernel.org>
 <20260420111726.2118636-2-puranjay@kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260420111726.2118636-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/20/26 12:17 PM, Puranjay Mohan wrote:
> The bench framework waits for duration_sec to elapse before collecting
> results.  Benchmarks that know exactly how many samples they need can
> call bench_force_done() to signal completion early, avoiding wasted
> wall-clock time.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   tools/testing/selftests/bpf/bench.c | 7 +++++++
>   tools/testing/selftests/bpf/bench.h | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 029b3e21f438..aa146f6f873b 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -741,6 +741,13 @@ static void setup_benchmark(void)
>   static pthread_mutex_t bench_done_mtx = PTHREAD_MUTEX_INITIALIZER;
>   static pthread_cond_t bench_done = PTHREAD_COND_INITIALIZER;
>   
> +void bench_force_done(void)
> +{
> +	pthread_mutex_lock(&bench_done_mtx);
> +	pthread_cond_signal(&bench_done);
> +	pthread_mutex_unlock(&bench_done_mtx);
> +}

nit: We can reuse bench_force_done() in collect_measurements().

> +
>   static void collect_measurements(long delta_ns) {
>   	int iter = state.res_cnt++;
>   	struct bench_res *res = &state.results[iter];
> diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
> index 7cf21936e7ed..89a3fc72f70e 100644
> --- a/tools/testing/selftests/bpf/bench.h
> +++ b/tools/testing/selftests/bpf/bench.h
> @@ -70,6 +70,7 @@ extern struct env env;
>   extern const struct bench *bench;
>   
>   void setup_libbpf(void);
> +void bench_force_done(void);
>   void hits_drops_report_progress(int iter, struct bench_res *res, long delta_ns);
>   void hits_drops_report_final(struct bench_res res[], int res_cnt);
>   void false_hits_report_progress(int iter, struct bench_res *res, long delta_ns);

