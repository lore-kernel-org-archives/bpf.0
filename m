Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69892D47E6
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257150; cv=none; b=BQwyWI4e0BzfkqMcXIiKv6nmvUxubHddpJ71J1fb3+Ys9XKLhB5rGIAO2+PxZJQ343152dHDTj8hdSuaapGrMN6bWbHu5xthUUENyCcVMmQrUXjtoUD33GeIj9Ytngf9FdYvDKSf/mfn0vgnSVLIq74a0hea06jE5ZH3hVUzlKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257150; c=relaxed/simple;
	bh=r5oaOfML6FxJlKSK67EJ2WyEj+emcyjdTPYo2m/eMwI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=QTSLmR9btrkxF/IQOQuCWbxDuEU8DT9aFUtyIcnZIF5zEHaAgxU8pJ7WXbkVxb0rUDQuXV/dWHmOMLETyun3StPgac5BZbz1Ag5P6LyJbMwTM/6Z0pRNmZJAlNhemRFWNXlu/xCJ7jiK9n4wbkkDbO/lvz89ze0+SYrTgXruU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=WGfwpjKo; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="WGfwpjKo"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd858e860aso26010185a.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773257148; x=1773861948; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VX8//xLjNJJ5RYsA1Ec2YfMWqGMraq5eRlMZrHRKiSo=;
        b=WGfwpjKobqUTyXXs0H+hYFHljTyFItJTfyrbxl2Zjky/G0dQv6ewKS1jn5Nv2YbR+C
         vcgcu1xrgShljA+N1cpNmAciwupp1kXWTzWojbp1wBUclEvcotuycpn9jLwYpax6JOBW
         lKPv1od0yxgXgqbNsOMaqPZ+CJtoTD5F/eV7D6y7oXxx2tMX6WLXvIPbqylxowWnoSqe
         Oc6JnXJOvCIZMqNwg6xfMAEfDEU7L4y/FmoZwuw5AsncVpwtdo4rI79NGa5WlQET5T7+
         Vuf0Yv0iRWxN3mH6siVeSos1rIDkQhIHCvgvtYUCUd2b/l5n/QZ29ZqtNrmbllOx4piO
         Qe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773257148; x=1773861948;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VX8//xLjNJJ5RYsA1Ec2YfMWqGMraq5eRlMZrHRKiSo=;
        b=phSIe1CGB0uIyyhPQFY8zmjsyGSpeXRh4ObXKi28rxLn1BAUOHqZb+Hu+RpQwxJa0K
         mT2XowGx7Wg8Mj8TTucWW6G2/C23mN5UfdtKDSsFg62QwnidOs73mJNqQqeNyvmDKewe
         MFswDXI6bug2wwoi5+V0cPLvdGcVpt2VH25Malk2UFY7TvEHyGj/5khO6wxJxvkF7v7a
         iq7/VHq7DPbCRBM+2ovE8sZZVtppVwalO0k032OUMMKFbJfP4sWXuMoxqqakYHuNu/q0
         nEoAgG8o2AWT8yzEjmq3oPU+x727YFwgB5VxPHzzc/zzYZQnxfC2twpwjHweP13eFakm
         JzZg==
X-Forwarded-Encrypted: i=1; AJvYcCXPgGX4Ljn+n2/T4cBbU/UUZ9xM0CsT5ZN8Rc3SsKpxKh9iEfXXAyqrLcRPxP3AyS07LsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcyl23V1j+K1xC8lgUGt6OJFPIb7jeWqw85Mku/wG1cgOXtJ9
	729by6GsawxIeGvr7abZwoMcvnh53AWGCqY4uZFU82h7ujEHNpXRcVYVE+S1VpbmRUM=
X-Gm-Gg: ATEYQzx40gP2hdFg4eLUlg9QAFnRqDbDUBZaYOyE+b511d4qO4PtpR8hKm+HtyGAEev
	IdAzyTK62jd2rurG63ZixELdC2WgTtLEYAjVbRGu813oLiDjSk26QmKwNIHfNs24+fbvGlvZoDC
	ZP1HTbcDoGbF2S+b0A6CFTGl/5FgNV6PvEvGCr1htRhY6Se6h5h9BfRilhd7uSCi/8RG3pNwISQ
	1Vx5xzqC6cpjI0uug8nwNyWhr4GPNZOEC1rlVyhENg4ELK0zynMuHKw4RUqDG9PcCy4/SKKXFRv
	FdlE3IPySzgYnbB/SPT1gHxfJRcOxyJnXJ+G7GldnBp5g/rbka5PMoMw9KaClQXM/6jKfgz9wsT
	VRX7noBxaesW3NSsr5+WF+JgZ+2T52Hao4LhUSnNqEo1NI8MBh4LXO6Onabcd+WFhwnsI/E8Ac6
	oG9AFD7n1b+6kSUvz0WhJGrUcq1LeoTtDfYw==
X-Received: by 2002:a05:620a:3183:b0:8cd:9863:331f with SMTP id af79cd13be357-8cda185e6c5mr467802885a.0.1773257147568;
        Wed, 11 Mar 2026 12:25:47 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21346a0sm186908685a.34.2026.03.11.12.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 12:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 15:25:45 -0400
Message-Id: <DH0772V1KDE0.MVITO4EWQATO@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Add sleepable execution path for
 raw tracepoint programs
X-Mailer: aerc 0.20.1
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
 <20260311-sleepable_tracepoints-v3-1-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-1-3e9bbde5bd22@meta.com>

On Wed Mar 11, 2026 at 2:22 PM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Modify __bpf_trace_run() to support both sleepable and non-sleepable
> BPF programs. When the program is sleepable:
>
> - Call might_fault() to annotate the faultable context
> - Use migrate_disable()/migrate_enable() instead of
>   rcu_read_lock()/rcu_read_unlock() to allow sleeping while
>   still protecting percpu data access
> - The outer rcu_tasks_trace lock is already held by the faultable
>   tracepoint callback (__DECLARE_TRACE_SYSCALL), providing lifetime
>   protection for the BPF program
>
> For non-sleepable programs, rcu_read_lock_dont_migrate() is replaced
> with explicit migrate_disable()/rcu_read_lock() pairing.
>
> Remove preempt_disable_notrace()/preempt_enable_notrace() from
> __BPF_DECLARE_TRACE_SYSCALL. Per-CPU protection and RCU locking are
> now managed per-program inside __bpf_trace_run().
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/trace/bpf_probe.h |  2 --
>  kernel/trace/bpf_trace.c  | 13 ++++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 9391d54d3f12..d1de8f9aa07f 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -58,9 +58,7 @@ static notrace void							\
>  __bpf_trace_##call(void *__data, proto)					\
>  {									\
>  	might_fault();							\
> -	preempt_disable_notrace();					\
>  	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args))=
;	\
> -	preempt_enable_notrace();					\
>  }
> =20
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b040a417442..3688a7e115d1 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2076,7 +2076,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, =
u64 *args)
>  	struct bpf_run_ctx *old_run_ctx;
>  	struct bpf_trace_run_ctx run_ctx;
> =20
> -	rcu_read_lock_dont_migrate();
> +	migrate_disable();
>  	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>  		bpf_prog_inc_misses_counter(prog);
>  		goto out;
> @@ -2085,12 +2085,19 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link=
, u64 *args)
>  	run_ctx.bpf_cookie =3D link->cookie;
>  	old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> =20
> -	(void) bpf_prog_run(prog, args);
> +	if (prog->sleepable) {
> +		might_fault();
> +		(void)bpf_prog_run(prog, args);
> +	} else {
> +		rcu_read_lock();
> +		(void)bpf_prog_run(prog, args);
> +		rcu_read_unlock();
> +	}
> =20
>  	bpf_reset_run_ctx(old_run_ctx);
>  out:
>  	bpf_prog_put_recursion_context(prog);
> -	rcu_read_unlock_migrate();
> +	migrate_enable();
>  }
> =20
>  #define UNPACK(...)			__VA_ARGS__

