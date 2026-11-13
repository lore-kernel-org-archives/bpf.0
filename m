Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567446;
	b=j7KO3cXJc0rxp6SEafwjWqs+uSFef0eEDtiPFl4VMe5C0WeHotblBCjZ9Lkyhm+FEsDK
	 fqcYOlQA7DM/mszru2Wkw4HYKfCI2mbvuu3gtgx8tVnTzqSTrAPuz3I3W35gy+K8yQcyV
	 Rph9DDqJC5uhBVgC4kpdou3u3oW3sJhjVlCg4fRJgUTcD9fZmkKtaLZiuNctWcp1+Y96C
	 2H01X2DXDodx8m5uebQEPVCUogCINV9lK3NbfKM3xGpv2HL/PWOrKKyJfb7wh6+zy5kGu
	 UQy8OcwhEoAoIJj/Q6wBBFyybgd/XqO6hBlRWEoTlIeAj7idPKbgd0aJxHykmaC6NVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lbkgMQC7Zw8kBx4C+tjZuuC1ilPxnyE5d2jDtTeiWe4=;
	b=qGE+tdJgSVjsrVaQAdVV0xqf3dPOX6Exq6RKYxwrhM0lZ2wFu1kP/XcnXrx54Vqxp4Az
	 GHgB2SjpbQ+ezyDSvBI4tYZpZoNyVqFXIRcLoRAKwFYaahipn8bqWKUfNO0H6JEjYpQBi
	 nGSiLX+Q51E34f6yd98L31kcxSsTJ0Ej/cpTA4iQTlOfpX/zDZZ/CgLzrJpWkZENsfCa1
	 sNEKgt4jItvtSSvCO7ee/rGX4Uev3HYmACSO9F/2wN1CUkCQ+lTaDYUzT7Iy7QV79mpbi
	 Vnl3ZjOrLvtixqL+Rsrm7JNBC2QXobSMfgIMTINc6OoQJWwU3VOBxBpG8CpkOmUcBvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEPF7REP;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04C606A8A6
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C04C606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEPF7REP
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so5927475e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567444; x=1795172244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lbkgMQC7Zw8kBx4C+tjZuuC1ilPxnyE5d2jDtTeiWe4=;
        b=SEPF7REPdnWBoaNaI278Hy8wEWH+5+Z+4wBhQEEMceTSn+Cqdz8UrfVFmPLb4GEvui
         fM1R0j8sPFylk7hFHP/gzWwnWjRT0g1PJGX/WFuw9xxjLiNTBqfN1dGOJ5S07I6M809O
         8Pat4nJhcC1XWVONrourDhZgLvVre5MY+So/T4gpOhxmWvj+p/xfPkfZpI4Syuu8ZrTj
         fHIDSHDVs+6onEMr0CT8juKZ2rGCI4md45XogHTFqA3Pc6b0p7DP0OiBIaiD32Ht+Hh+
         eKFpQQQnIDa4YRU0zVOrVEWm053jERxMX+kBjCQ591LQ+PIm+dZvBzw3Ub73sUzp/nyC
         NHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567444; x=1795172244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbkgMQC7Zw8kBx4C+tjZuuC1ilPxnyE5d2jDtTeiWe4=;
        b=iOLOfPkhm1oGWyNo7+GZQwY2V4jrOaEJTb6yoB+KHiMNufHB1XdUhlKkAqs9KbDzoz
         r0VKuaFmkWxIvicS4vXIyesRMcju/9izqnQMZYqDf92PfGbMWl+tC/lkmVY0bh3LKWKe
         LZWX4ZA7YZY2cCrZ4hqCRxI6suS47HVBACYoCIH37ros//stvme+3HbXRB8JW8nhUfWb
         zcn8b8RwGb9qVHg3ACc3kgJWI1awvyepaMPRh7x1jQiCFYF/XFYpQjPDMrg9fn6/Ongt
         OSeSYIZCS9eSo9NGkZ1fkogQo1BgP8XiofH5W2Uat7ufbILhTumEjzJH+FrElmE5tEF5
         4AWw==
X-Gm-Message-State: APuU4Z/ouIbXIL4uAXM55H+hkEAjP6UScfw4nvG7lN7aRbEcawYQHUlH
	CeEAD+XuwLb8OCJoGF6UEvmdwAny87RxKZAMmBlUbafzLWFR2DVa4Cmk
X-Gm-Gg: AYBFou0m70QsTS4IdF4EqyBR6z3XmxJPalVCngeb1t/PIFKGR+3Shkpxjpjt6w9JKNe
	s7i3zOgqgpzVnQTJioU20Ds6iQH5lLk+YrG7aSdho+27WHW2gYbhPD1ouoyHdliaZuPmlR7NpLQ
	MRZdvVpzAlf4egKSk5DasL9scozeryXuvLQvX/qw5+H1ZFbTw+54pU+6lSWgPNJ6reTqMvelil2
	e3YOT7LXIE+Jpponf5uKAAgjXR4V6YNI3GizkeaMgRtptwEo66BxwA0WTipp9sB+tfDA91AL5Tf
	e6Q+niTbeldKgxyzXkP4BgD2ewsuKeWkSY/Nl30gz8Sdl1Mk7nnXvD4A3fIUd0eFxJc74TxHPug
	Sq0m6lsUKWiZdeeSLk1NaiUjeP5VqlPFjxNa0ex5jGAn8FvMqPl3vJ45ql5C88GELA2TOE56Tgb
	+mGlSRFpJw8X3MptKhZpGg0UBbZb3NCuNmSkLCIWFPtxd5b5gGrrpWcwIZHS/bOzMFC2KkeWW/g
	5dRq2zWQyII/VfYIYbwv9H7qLQsN7nOlQe4h0OQ6liRuNG+PIowkWx0eWCS6ud/ENeMm/mNgorf
	jeBnZXGbAL3UpTiq3u7+q02HK2uVvIkTm30m3A==
X-Received: by 2002:a05:600c:4752:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4bb55ab2b89mr40646185e9.22.1794567444155;
        Fri, 13 Nov 2026 02:57:24 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5b4a3fcdsm16449605e9.0.2026.11.13.02.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:57:23 -0800 (PST)
Date: Fri, 13 Nov 2026 11:09:00 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH v2 bpf-next 11/13] bpf: Mark the arguments of fmod_ret
 progs as PTR_UNTRUSTED
Message-ID: <avbvzPFUFQOB4iYj@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
 <20261113050901.1399091-12-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113050901.1399091-12-alexei.starovoitov@gmail.com>

On 26/11/13 05:08AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> fmod_ret attaches to about 12000 kernel functions now. Nobody looked at
> what these functions get. A pointer argument can be NULL, an ERR_PTR(),
> stale, or an object that is not set up yet.
> 
> 	SEC("fmod_ret/tcp_v4_connect")
> 	int BPF_PROG(guard, struct sock *sk, struct sockaddr_unsized *addr,
> 		     int addr_len, int ret)
> 	{
> 		if (bpf_get_socket_cookie(sk) == cookie)
> 
> sk is PTR_TO_BTF_ID without a flag. The verifier does not rely on such
> a pointer: each load through it is BPF_PROBE_MEM, stores are refused,
> kfuncs want a trusted pointer. But helpers take it, for compatibility, and
> dereference it.
> 
> PTR_UNTRUSTED is the flag of a pointer that nobody vouches for. Such
> a pointer can do what PTR_TO_BTF_ID without a flag can, except that
> helpers refuse it:
> 
>   R1 type=untrusted_ptr_ expected=sock_common, sock, tcp_sock, ..
> 
> What is loaded through an untrusted pointer is untrusted too, also a __user
> or a __percpu member.
> 
> That holds for each fmod_ret prog, also on a target that is allowed today:
> security_*(), a syscall, the error injection list. A prog there does not
> load any more if a helper that expects a kernel object gets an argument:
> 
> 	SEC("fmod_ret/security_file_open")
> 		bpf_d_path(&file->f_path, buf, sizeof(buf));
> 
> bpf_probe_read_kernel() takes each address, as before. All fmod_ret progs
> of the selftests, Tetragon, runtime-enforcer and bad-bpf load as before.
> 
> The arguments of fentry and fexit progs keep their type for now.

I am not 100% following why this change is needed without enforcing
this for fentry as well. One can attach fentry before fmodret and
follow all the same args. (But in general, +1 for this and the
following patches.)

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/btf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 228b93d4f8c9..4ed660dc4612 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7618,6 +7618,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  	info->reg_type = PTR_TO_BTF_ID;
>  	if (prog_args_trusted(prog))
>  		info->reg_type |= PTR_TRUSTED;
> +	else if (prog->expected_attach_type == BPF_MODIFY_RETURN)
> +		info->reg_type |= PTR_UNTRUSTED;
>  
>  	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
>  		info->reg_type |= PTR_MAYBE_NULL;
> -- 
> 2.55.0
> 
