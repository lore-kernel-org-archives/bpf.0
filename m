Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2D36B919
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907721; cv=none; b=Zg8cC/EgKc0DL+oP9VS9ygwtPmH4mZiwSk9MN2xkQh71Shr2rMyAeGLbudOFNpbbXdX83hsNzlRPLk/i81tx4LfT1YtyK/AqAvCATi8lympXFPCQd8ovdIM2rdNMYUti7g0EaPzrf4Y2kUEZNjlYVrzX9KZ9Y54pfufg4ycsp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907721; c=relaxed/simple;
	bh=43NhS+1dN1SBhIVMii3UsQRqPU9xU9BKbrAzhYQSVPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRy/xmRzJIrDfwDgJfVcrW5TdLrAHfTR8LV14Ll9g08vZDPf7L8d9DJ8SB11TbJc2zCESMa6avNa0fxCLIlyQs4Z7VbfvCAjhKKeeXwMMThFqOtk5vB552y903HnA10V18mRHD9LKyoKA3t0fV4IM7c94c7N7n+QYPVIK/bNTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHAjXS2T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n3j55Zv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHAjXS2T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n3j55Zv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784907715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhC7VBU94RNVf/RPwOHCIqX1z+9hNndx3x7FLW8fOjg=;
	b=DHAjXS2TV1gBkero8iKFlnlmQDxPtH0/bskliAeGm52jUHX7W7uqsPdD4HSqN0WUxxSWOQ
	gHXxpl9HfG1TAwzMDzjZqefMBJe5miX0HRikJMYErGaTVdC5hFqfmEiVEpPuo1AMkRc8b/
	KMkfJfB3orUGYHOOYpXd4TAfMIii+/g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-kAUtB2BoOAaZENPpLITq6w-1; Fri, 24 Jul 2026 11:41:53 -0400
X-MC-Unique: kAUtB2BoOAaZENPpLITq6w-1
X-Mimecast-MFC-AGG-ID: kAUtB2BoOAaZENPpLITq6w_1784907713
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-474170b59dfso447061f8f.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784907713; x=1785512513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhC7VBU94RNVf/RPwOHCIqX1z+9hNndx3x7FLW8fOjg=;
        b=n3j55Zv9Yu31aSjC2KPl3wcqfsQZFUH1yD3gVXPW+fcnhujeZxQZzog5575/LJsLlp
         EdkHMw6Y1IvDtRrWDaPudgANvrgcIxB/oXGlP/u2tQ9kldmUwwtuB+TKcf8BIN36x6RL
         +mgpyA+NCwzd5DDiEVlekOK2ufwfmhkPXidivhX0d5myneE4590s8rbLU4LWnFtCzALJ
         IlmWmhj63sYb9fDiOG5p9nkgi2+KzAnHG2wYjR30przvA1Wsc2+Zr3XTUzzYe5ITPC/6
         64mbb2G2IerfV5jBtWWHgz7q8SKYQnxhs26LqzbS2tUAko3ZeBtIngwj8Od7NhbAV7iu
         gjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907713; x=1785512513;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhC7VBU94RNVf/RPwOHCIqX1z+9hNndx3x7FLW8fOjg=;
        b=Vc/g2lrSmzLXOILGBj7N7YSOZOmEbBNxvN0FqxN3/mqdKx/dUXZc0G9b+Kg+swL38i
         6VYTZxHDX4f6p2KDROMfJgqYA2O/3ziRz0FCWMk+wVMyMfbmCGWiLvlVAXEAnBm409it
         7qIfxNuRJqrsXDLmZr71bcWaU+WG7oEvsNDLJ9T4tniudDrfSQ05Fq0Yf8IQ0QvUceUh
         wH98WzGNmF4qk32HkOyZaXdei0ZiLovcAPzpgPe/HJ/Iz2i9Q6ZM52dpATJppqV+vv7q
         c7ZcDlj10bXizlsNQieurkCzzqd5ld4Yy1LE7g3xpebGDL6GceSUnVwhbYeXTuFzl0LH
         6psA==
X-Forwarded-Encrypted: i=1; AHgh+RqphewLd2eW/4Pb4Cex79gMesYerNAWHom+Gla0XO6jd2kB9PYaXAFNmjSh8oTE2BeRpeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4l+uXJ60cs7U0kiqcnO9l/80QnSUofz+F66NfrtzjdtSbnCT
	hqQ4stsbOL/SAej1qB0infhZPN/5QNIuZw8b7kq2qqb19n3lDbXJhmafOz4Vyiv+3PM21D/1va0
	uVMpoS0nlZyqizkxJva0Vu2SbL3T4evJx0yswL3LRyOMWxoX4OV1P
X-Gm-Gg: AR+sD13zXvk0wdwUtEIDgKsSfumDue+80qqrcYDXROicZ4NZIkHD4dBJ9Uj/sUS1jf2
	hon2KvVh+gZx+KUrv9rKz7J+drMOwL6J+e6boYWBXyH+iYzZxsDrrIkSmMNdWQ0KkIBSeyVWRet
	HH43eJPhK3ZvnG3t5WW//rnJISyx+0UyTZpAr6OkBQTTyzDsZRDc05ZG+yZDn3CTskckhDqW34I
	tXNl8j5hWJMRBv2lW5W+mgqsnboWpHkBnWT2A2eLedKFxDDMEl3Me7bgatu52pCFzQf+CSSQX7a
	koPe5btw2PMGaFDz6Wpo+m625LjASGCp4RvZpPm5+Usfc+MzW7bwS/I1bby8VzsEDekdqcxhFsh
	IZAxUcGlMeD1ePfS83vqrdIvIrwCcv1jBYgA=
X-Received: by 2002:a5d:5f86:0:b0:47f:6e23:64d6 with SMTP id ffacd0b85a97d-47f8d871102mr10462255f8f.16.1784907712690;
        Fri, 24 Jul 2026 08:41:52 -0700 (PDT)
X-Received: by 2002:a5d:5f86:0:b0:47f:6e23:64d6 with SMTP id ffacd0b85a97d-47f8d871102mr10462216f8f.16.1784907712287;
        Fri, 24 Jul 2026 08:41:52 -0700 (PDT)
Received: from [192.168.0.199] (adsl-dyn194.91-127-145.t-com.sk. [91.127.145.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f939c1465sm10874976f8f.26.2026.07.24.08.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 08:41:51 -0700 (PDT)
Message-ID: <f13939eb-d8b9-401b-aac6-6004d395a049@redhat.com>
Date: Fri, 24 Jul 2026 17:41:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix sleepable check for tracing prog
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Sechang Lim <rhkrqnwk98@gmail.com>, Varun R Mallya <varunrmallya@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260724141422.10463-1-leon.hwang@linux.dev>
 <20260724141422.10463-2-leon.hwang@linux.dev>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260724141422.10463-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 16:14, Leon Hwang wrote:
> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
> is allowed to attach to '__x64_'-alike prefix symbols.
> 
> It is because the verifier does not verify whether the symbol is a kernel
> function or a bpf prog. That said, a sleepable tracing prog is allowed to
> attach to a bpf prog target whose name has '__x64_'-alike prefix.
> 
> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
> prog, and copies buffer from a user pointer with bpf_copy_from_user()
> helper. After attaching the XDP prog to lo interface, the kernel BUG
> could be triggered by 'ping -c 1 -W 1 127.0.0.1':
> 
> [    3.460756] BUG: sleeping function called from invalid context at kernel/bpf/trampoline.c:1324
> 
> Fix it by disallowing sleepable tracing prog always when its target is
> bpf prog.
> 
> Fixes: 16d9c5660692 ("bpf: Always allow sleepable programs on syscalls")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/verifier.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce..40d567b90d24 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18935,13 +18935,16 @@ static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
>  }
>  
>  static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct bpf_prog *prog,
> -				  const struct btf *btf)
> +				  const struct btf *btf, const struct bpf_prog *tgt_prog)
>  {
>  	const struct btf_type *t;
>  	const char *tname;
>  
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_TRACING:
> +		if (tgt_prog)
> +			return prog->sleepable ? -EINVAL : 0;

The prog->sleepable check is redundant since btf_id_allow_sleepable() is
only called if prog->sleepable is true.

Other than that:

Acked-by: Viktor Malik <vmalik@redhat.com>

> +
>  		t = btf_type_by_id(btf, btf_id);
>  		if (!t)
>  			return -EINVAL;
> @@ -19324,7 +19327,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  		}
>  
>  		if (prog->sleepable) {
> -			ret = btf_id_allow_sleepable(btf_id, addr, prog, btf);
> +			ret = btf_id_allow_sleepable(btf_id, addr, prog, btf, tgt_prog);
>  			if (ret) {
>  				module_put(mod);
>  				bpf_log(log, "%s is not sleepable\n", tname);
> @@ -19575,7 +19578,7 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
>  
>  	/* Check sleepable program attachment. */
>  	if (prog->sleepable) {
> -		err = btf_id_allow_sleepable(btf_id, addr, prog, btf);
> +		err = btf_id_allow_sleepable(btf_id, addr, prog, btf, NULL);
>  		if (err)
>  			return err;
>  	}

