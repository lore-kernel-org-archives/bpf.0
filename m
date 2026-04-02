Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F963A16A7
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123284; cv=none; b=QboC+t8SjDtxDwnOaHVc4OEIV/N+GQ9WiYQ180KsqvZzIpVhipvAM6xKyP93YlNGtNRdOKyqSxjzt7CZU0nrL+FLMPC9ZQHb46u5iftzWmTzpJQCV+b4du+lf6an9JN5gHlVp0jVP77pDlZiQlKr+IQDf15xTT0H9U4MOptZEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123284; c=relaxed/simple;
	bh=3MNlmfskCwYBwR7CMMQW06KYDtniDQG1Ht8Ze5B6Rbs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlVKA6ChysOLrAdBec+vaH3hPNhlwIOYA6X5zzwI6CiGWG+A2beUj/gwvULcKXsDmxPWaRE7YuE+NNORqfqn16DKgdYc1UPIYOq0yTxeAxiQUZfMXSCgsSsaRgtHYVVDLPBPxlzS3Q9PiwYCTUoqWNCtd/mC10Z0xh7ARXEmmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh2qjTHr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh2qjTHr"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d029f346eso661630f8f.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775123277; x=1775728077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ol8Pk56vvShAuV2VIl+T3q12S1MFkuELXmy9np3CGds=;
        b=fh2qjTHrsLRpM1+CD4qYjffE3wb4ByYem2TQep3XJes8lTJnUcUvrrCWSttwuNA4F/
         bLr18EYvvpL71DhcAoKAvoDIAJnoRxIof5w15Tp7tJw+C3ySFAktUOJGJxPhXbpVs5E6
         rsedP9lLdCMeLjjDW1fW4v+qe5YivPZO5YCLNFbdNLGp3baBfszfj00pRSRYpY4/wVFt
         EW6eGPepib2Dqd7QPekbIvFd7CbKCWWsFHT3sy7rvW4VRlhYF8kmvAYZ9PkO9aiw5orf
         I3i6DkGBN5JzUWt0VDuuEsts+k9hsapTplKcbWSHJAybwkvDMuYy2VQNpMhV+hl+yR7n
         3MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123277; x=1775728077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol8Pk56vvShAuV2VIl+T3q12S1MFkuELXmy9np3CGds=;
        b=idZrin95t35c7xzEpOzsEnF1UuwtBJ/+t6YDFeA30oT9YfggX0FrsAdLUufJ6w3DAB
         gNB7RF5H5Yj2bnZdBNEy5w9tUTt2OBxgB3ReMHZB8tE6AkxegYHNaaTNLfNN0B3EmnfW
         D3x/s2uVQtte+JtSQkkntaCGnU/Dq902lbnYE+j1sDNtAf2Xi3DEmVAIYTL6s6Yl5fnh
         FI+C1hGPu/1gbi1/bIb6y/bbqgrczgSQK1aE2f/NKyZayPVrP07/+aTU9+CCzFO5lxnd
         R+TEidYofEQ0JMYAwgunxS20sVkOMWvuZeW3AXSlInD3dIBRF7/M0Bq6s6aiA9iunhKh
         6jdA==
X-Gm-Message-State: AOJu0Yw0GTCR0qJRZ4CfAL44t+gj+95sAItjrae/dJu1S54/9du9HtXR
	LIARktcUgUyCw+7wi8nAxWiREVEsTWp7/a9bbIRtEZnb09sEg8zn1ZSi
X-Gm-Gg: ATEYQzz47wTcgKYZidctXZnYfWvZwzhRBFCbRGTxTSD6FYOyEe4B9j7Za9tDW9lco8/
	FwZGU/+jYNAGWKfClrl59aeu5C3NOq7oiL0M/uQVmoR14cFxEFchQvtrzv2NY4J+SE1lTHJ6PSd
	I2d23m6W6aWOdNqXtdwdUihelvLgnbKpbwmq/bCtHEcDGUVnoQDFnpxfVtPrLkwcWU1Jr+X4wzV
	aVq5qoy77YNhqoqJ5Sowep2h2NCt+MHdgvBSjsIi85seZ0XSnNMBqVUQ75WINjNYgFDQipTlVbf
	p+p7NVSK8rnPBr87Mb5V7T6HIn4LSF6ZfSsJHxXFAsfFoAG1H7tLvhB3m1AthKez4BdWyFxSKE7
	4FJMU1i40aYrSJiygCXa6MI+Dtt91J3dJef+l0uqkuQ+G2h8yewFR/eE6YBF1Lg/DrVNnZAVY
X-Received: by 2002:a05:6000:24c1:b0:43b:3d4f:e17a with SMTP id ffacd0b85a97d-43d1f25ad1bmr4932336f8f.37.1775123277062;
        Thu, 02 Apr 2026 02:47:57 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c60a2sm6492968f8f.10.2026.04.02.02.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:47:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Apr 2026 11:47:54 +0200
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	memxor@gmail.com, yonghong.song@linux.dev, rostedt@goodmis.org,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject sleepable kprobe_multi programs
 at attach time
Message-ID: <ac47SnLz6WncARyH@krava>
References: <20260401191126.440683-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401191126.440683-1-varunrmallya@gmail.com>

On Thu, Apr 02, 2026 at 12:41:25AM +0530, Varun R Mallya wrote:
> kprobe.multi programs run in atomic/RCU context and cannot sleep.
> However, bpf_kprobe_multi_link_attach() did not validate whether the
> program being attached had the sleepable flag set, allowing sleepable
> helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> context.
> 
> This causes a "sleeping function called from invalid context" splat:
> 
>   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
>   preempt_count: 1, expected: 0
>   RCU nest depth: 2, expected: 0
> 
> Fix this by rejecting sleepable programs early in
> bpf_kprobe_multi_link_attach(), before any further processing.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>

nice catch!

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  kernel/trace/bpf_trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b040a417442..af7079aa0f36 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  	if (!is_kprobe_multi(prog))
>  		return -EINVAL;
>  
> +	/* kprobe_multi is not allowed to be sleepable. */
> +	if (prog->sleepable)
> +		return -EINVAL;
> +
>  	/* Writing to context is not allowed for kprobes. */
>  	if (prog->aux->kprobe_write_ctx)
>  		return -EINVAL;
> -- 
> 2.53.0
> 
