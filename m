Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567747;
	b=dTF+Rz9FYzx7hTdyM8Fpe6gSnnpEVcamS2rmp82bHZmbF3TGu6EqUJp5isXmDpLlrgYW
	 KoitDH8ksADIbSag1/p7ztE4Xy6i8XFBofiEqNqyhYc8wpW+ixKqTLTMsBrcF+IrEbJHm
	 PK1EiFLW1ltseXg2EVRPdZ4p/vN//ScAFfnGpB6+6/MfevtT5lbJ2eBwJxsz858Dtaq7c
	 tSymdPMcqrojESqz28AB1BQM9RhWpBzV45K2sE2aOmuuv1Q/3OCCtL0NNXRsj6EpViidQ
	 AHNzs672UR0iJIXozjILntsHs+n3+ceqcod/anQ3xOqQdx7MjlaegLOo1FeycGYP8KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=pZPFd1SYASnwZE8RQDnWSkbWoNyjC9gCBlg7DkYNUyw=;
	b=OGb+4nKn1oLo9OgxvRD+ZKdSh0nL9rOopJ/txzlv+ohHQlq2ncN8nvd0G1mCye+JrBvI
	 UqQ14ppSlj1nhyqYcSbGaOXUMvuouI86EPxC9gv/u1UDKed4h+Sz9e9p+W9TUJ9RGz9c3
	 51wFsVGXvLMpuL8H2OP+krjrKJwXU6tBuaao4DoaLxQU97pKu1sD8XtTxtP9i30/j3nTY
	 XFLFXzuegDJ2DLlfA8F5KMnxW2+vc7LWBKArvnMKmhiiIhQgJ7CfoNvVRDKWAyWWa5nsO
	 C9fwXMtgbeE/6lYt4c4nb/lC5S/kvNe8p73UKKJg41qbl7VALuXx4Xtj7sUjE42LNzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FqkVusjk;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA9606B241
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 11:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28FA9606B241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FqkVusjk
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so4581435e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 03:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567745; x=1795172545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pZPFd1SYASnwZE8RQDnWSkbWoNyjC9gCBlg7DkYNUyw=;
        b=FqkVusjkkXiqr+Cerf83nEtyPWYBrAZhv+mJsQUxyz/818Uu6km9IiuS9O/2xNXXwB
         uQ6Rtv3w8FKXnysw5zqV0EfDyExq5Dhi3FXIyPmWv9hSLGAhbSVLSZ6ee/8UrNgiM6HL
         HTFHLnmLD4Y3LRQaF7Zm5Chk8CoFxxYTfCa+MUPJJ4jhXfvZxofmsCdIxi55MgJ846Aq
         2JPUgtvGsQp+HzrBf+UKvayZbWRH8uyUXYVAoO2D2DRIxeA+UuhlpfcgHMyb9nBXlfkA
         WfMf30PXQt8UUBLzfn0xdltzDDCfPVxNAtrz9lBB/sq9O5qs0QklDWSrPswLD5FLf7Y+
         XW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567745; x=1795172545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZPFd1SYASnwZE8RQDnWSkbWoNyjC9gCBlg7DkYNUyw=;
        b=kgfa1qs+oloyNXUH3rTIqEymE/1uG8Da4zWrp/uuqCz9BGZhWKaaO3WwDvWfHB4LW0
         MNgYpTfTQjgs9y0BNagNhPavbC3hQ2tVU/N8PeSoc3W6scynCJQP5qaBgkOLOJvYq7k2
         V+hvDtFKDoiLsNNUJHeG9ArDR4LII/yBFnpjmACp8cC1uvy/0DHQ9/T8fTwl7+2G7K3Y
         hwTaZnNrviRDdJ52X2DDs0GaMRcXC6xvSKiLmUFJTHjsnkLLp/h0J8pdBlRFke08Asdx
         wEDhYtxbI2wM3LkdWsJ5UY8lYNBOKpOeEXy2E8gwbW9TuXcwRbAP09e0tmAndgNBfDFA
         16gQ==
X-Gm-Message-State: APuU4Z9covLsTSFv1OajEQgCL/MtHh5MFj9bhSg1sbrqXqkKl3JVu/6W
	VamPMXESYcH/gcKDEOT85zj75W8MhWNGR3LhI+DLaVbsSI68IZAGw+1ceBBk2Q==
X-Gm-Gg: AYBFou2e8SekyqBQVksw8rnOpdqL5AHIpjgmpqFSBVxrrcRU2Ug5B/ZmdBYFGJ/sgDr
	0Dl+/BzZ9+Lpvbf9EprKqBoaXEllTAy9QCvDUsYC1toUGcx7R4EP/0ww0Txcm4rO5udclHO+ddm
	1urJFBBJVUIpe379RZD6nQ29xGtn7jc9ShJc5fo+3z4vAbLSHd7EHO83+WTHReM9hkPrI+Ypv19
	E7KNsDHAaqpEN2nJ6ILIu8wcOdQNJFntMVy2yXiRH8Pp96LQhosmv9xH4SVlXLbRGlTgvbrR8xl
	wGEp7lyp34XTpjvHB20BGmd5j12eGCNsS+VG6KbNCKQvcS7uMw9tP08+x44mwddOTHVeyUSl23A
	jg3qLaFzteDDFiIKuUYnKnjpIaISA/YwwYRCTHg1BqBCVtdfjgCJaWxY7I/uG5vgNuz4X77r0e1
	/xWR7XgNsLPPayf4lv3dECI/EEKMF/eAKeyZiz9Wey4GLOG+sL5QO0lwEDE3bGROWwne+svpYWW
	4cevAMJJUfLEhHWgAHKHHkmLmwtDU1LR0ueWdB/qZ03tLTmKrckN/aD0VGkPyFBlrd2DhDOLqsQ
	uSUsgD3CXlqJIGBDvS1xQss47F2q6cD+lX0L1g==
X-Received: by 2002:a05:600c:4f93:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4bb55ab36famr42705415e9.27.1794567745235;
        Fri, 13 Nov 2026 03:02:25 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm5180914f8f.11.2026.11.13.03.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:02:23 -0800 (PST)
Date: Fri, 13 Nov 2026 11:13:39 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH v2 bpf-next 01/13] selftests/bpf: Don't depend on the
 width of a BTF id in verifier_live_stack
Message-ID: <avbw438CHdTWK1BW@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
 <20261113050901.1399091-2-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20261113050901.1399091-2-alexei.starovoitov@gmail.com>

On 26/11/13 05:08AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> kfunc_iter_stack_liveness matches a line of the verifier log:
> 
> 	 6: (85) call bpf_iter_num_new#95448          ; def: fp0-24 ..
> 	" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 .."
> 
> The pattern has "{{.*}}" for the id and then ten spaces. The verifier
> pads the insn to a fixed column. An id of six digits leaves nine spaces,
> and the test fails.
> 
> resolve_btfids sorts BTF by name. The next patches add about 12000 decl
> tags to vmlinux. Their names start with "bpf_fmodret_retval:", so all of
> them come before "bpf_iter_num_new":
> 
> 	                      id of bpf_iter_num_new
> 	before this series      95448
> 	after this series      107433
> 
> Let "{{.*}}" match the spaces too, as other tests in this file do.

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/progs/verifier_live_stack.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> index 2d31868bcfdb..4bc4091b17a5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> @@ -979,9 +979,9 @@ void __kfunc_btf_root(void)
>   */
>  SEC("socket")
>  __success __log_level(2)
> -__msg(" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 may_def: fp0-24{{$}}")
> -__msg(" 9: (85) call bpf_iter_num_next{{.*}}         ; use: fp0-24 may_def: fp0-24{{$}}")
> -__msg("14: (85) call bpf_iter_num_destroy{{.*}}      ; use: fp0-24 may_def: fp0-24{{$}}")
> +__msg(" 6: (85) call bpf_iter_num_new{{.*}}; def: fp0-24 may_def: fp0-24{{$}}")
> +__msg(" 9: (85) call bpf_iter_num_next{{.*}}; use: fp0-24 may_def: fp0-24{{$}}")
> +__msg("14: (85) call bpf_iter_num_destroy{{.*}}; use: fp0-24 may_def: fp0-24{{$}}")
>  __naked void kfunc_iter_stack_liveness(void)
>  {
>  	asm volatile (
> -- 
> 2.55.0
> 
