Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D012B171
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055287; cv=none; b=aw8CKJu0pi5OimO9cTk1EVUgdX8CFGZq9b6xvqHot8CZYIFhJMuS/d55fnzA47iJkfqyxeq1j9UNoCPoCnoEvM5oBeVcUHDcwS1zoBrwT+0gO2qIxUqZrUVz2HQmFJXxo5NNeqdVgfjT/hSp2erVsCKEa9UTggmww2H9ehaQDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055287; c=relaxed/simple;
	bh=wVBQrk02vOmDXDQRg5kv0Oe0NW1eShS7MzNU0eSPksI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwHhwtsXtQmyUkbaKBlHzLQ6GTwox1GM3O+Y/2ktagCe/7SwiY9KziAbFKlb4Xx3ZWPA9oHICtMLkzkp3WS6i+7+im+ofTxyIg1oNZbSOvRYZcTMJTzYSIafL5YAYmIDReCCkmmT8AEVIxtsf9AVbVRcMXGNqaVrOaymt7asuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acCNwcON; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acCNwcON"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56b857bac38so784213a12.0
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711055284; x=1711660084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/sXytAJXqW/aFae7/+ve/xOfmUdZ3s0ZAtb/ZKyuy4=;
        b=acCNwcON2dp9n8L+If28dmtxGyKkw4ZT4YEi+nJiBa9xiBaub2ymdLjC9WASXi+1uO
         kIMcPzwTTtuVgZBoEgySQ6KZcdN6JuAh8ofVpPyJROZJZzG5ooRlSSYu7RQQuyvUQjKF
         A3+AllaHcsO5rBRd9LgqMuKqJh+Fi2W5fYvajperpLBKzJadgw/6U1E6B5SYQmtyoiwi
         3RVq0RQXJeoNrs4pxUExAKSnvkrqVNnezSdfLyzEOdyOjBeGr2SJ7T43IaPi5f4WKKQs
         nQebY+O5ZWJTb7jgXmxeecWLnmywCBFQy9b2SP2N5M+BSiRp3m9jLJ8RdU+YNZSycakM
         9rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055284; x=1711660084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/sXytAJXqW/aFae7/+ve/xOfmUdZ3s0ZAtb/ZKyuy4=;
        b=GqbpAeIgs5t/l8uxxaKuZ+YBsx0eZ/CjCIIkFZ03ffcmVww86SbcFEY77lYvZ23n5Z
         ZXKTK0aZgijcxQOpFm7+TXbdbDqnC6oSXV9UjzMCeyTiyMhXFa1hn4P6R27dLgSbyoeT
         +uxeAb9vjY5gCPHWgLWvlMqbKDrbnFZjP+0nrmvVf5a4vSye0GUq57qzAhz65+P4L4fF
         gRBwcYBvIawffKbeVAyuOmq8TgIHLPSW0SuYtRnjA19ki3zsuT3fPKd9M4mSYzQNe3bI
         LQq/ZyiIYo0jT8BFE+SSgqCIY/ocr0uwmoiIkn73it6BJc6TGnf+RVqdcHLOPRwVm3S2
         s3Fg==
X-Gm-Message-State: AOJu0YzCC3SlQR96JAFKcwUpFpJY4U2O51KNTe9HDAqEEPdavcL0PIwx
	UYbP2A5TDPXDMaEhS68JuPKs1qo4gmBEifAge24KgrbMT7IIljzc08OoyGsA
X-Google-Smtp-Source: AGHT+IHrhCxQqgBH7eyAcvolhEdQtxFuJUfH2/5UFvWRCixb5yQ3Y3Yzpai6NWQai/DxDoL2ZN0SeA==
X-Received: by 2002:a50:8e56:0:b0:568:a90f:2e67 with SMTP id 22-20020a508e56000000b00568a90f2e67mr327226edx.34.1711055284322;
        Thu, 21 Mar 2024 14:08:04 -0700 (PDT)
Received: from krava ([83.240.62.66])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b00568d750f7b2sm251648edy.65.2024.03.21.14.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:08:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Mar 2024 22:08:02 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, peterz@infradead.org, song@kernel.org
Subject: Re: [PATCH bpf-next 1/3] bpf: make bpf_get_branch_snapshot()
 architecture-agnostic
Message-ID: <ZfyhspVTGeEB-p2Q@krava>
References: <20240321180501.734779-1-andrii@kernel.org>
 <20240321180501.734779-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321180501.734779-2-andrii@kernel.org>

On Thu, Mar 21, 2024 at 11:04:59AM -0700, Andrii Nakryiko wrote:
> perf_snapshot_branch_stack is set up in an architecture-agnostic way, so
> there is no reason for BPF subsystem to keep track of which
> architectures do support LBR or not. E.g., it looks like ARM64 might soon
> get support for BRBE ([0]), which (with proper integration) should be
> possible to utilize using this BPF helper.
> 
> perf_snapshot_branch_stack static call will point to
> __static_call_return0() by default, which just returns zero, which will
> lead to -ENOENT, as expected. So no need to guard anything here.
> 
>   [0] https://lore.kernel.org/linux-arm-kernel/20240125094119.2542332-1-anshuman.khandual@arm.com/
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/trace/bpf_trace.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 434e3ece6688..6d000332b17b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1182,9 +1182,6 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_tracing = {
>  
>  BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
>  {
> -#ifndef CONFIG_X86
> -	return -ENOENT;
> -#else
>  	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
>  	u32 entry_cnt = size / br_entry_size;
>  
> @@ -1197,7 +1194,6 @@ BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
>  		return -ENOENT;
>  
>  	return entry_cnt * br_entry_size;
> -#endif
>  }
>  
>  static const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
> -- 
> 2.43.0
> 
> 
