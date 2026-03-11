Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D3333447
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255247; cv=none; b=JrMz/bb7zFOEDNqz1Nq6CbPSVkkbVl3IwE2Uztorx0zCCdaqx3yW1LDbb94Y9Z/iFzfh7AG+rzT5XZCQlppCsB718NwL0ixwF+ax2exMcYqrCV+X4I1VRvs3VakEgkF2CYKjqKar5L2xmCdYRmr9hWr4JHqJE9d28Xas680WetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255247; c=relaxed/simple;
	bh=/Wzgj0IpkJD9lHi8o8gP3WM1B5Lz5XmY9d6kG6hpG9g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=sVpYV2LsagWy4MoczjAse5rWHYh0CFbi0ePIcm4gu7CNoF5jF8yB+cASi0stj0369pOw9J8cy/axAINROO3oYfvnGKgxEFRcvxC+DskJ0xAeoPDO2CWfYqVLK4c6BdjAoB/DccBhW+3wdlUdduwTvBJO+RoiHwg+LqVyfk7Cfgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=A+2IkLO5; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="A+2IkLO5"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-509307e3854so10963591cf.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773255245; x=1773860045; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48Rq386LbFxcTvaBdSS5G9zffMUBLJ5/89qdZgdiUgo=;
        b=A+2IkLO54wYqx24/lph8t6rEicm+QhZlkNPiwv51SbHNsnnExgsOw4uoXwO4LpzH+m
         r+EVCw5/yR0kZ7RnJSmjWi5QyvCkZxhuONUKa6x50RyfFIGqf97VPlmHRAL3ppD3cKDl
         oo10O86q1EnPfatwnIHPEZN1aOTWEb8pO6eGSmTv9VqHLVTbxPXn4uAlB7S7xUqg5bf3
         Rmdr/F4oWPHwL/RCPSCSjDAvNxHvO65XtdC32kGOPkBDNRv/b2xO6UU35ycKboL2XPzW
         jR3pLgSHipgnkHR2W1zNqG1A2+3F0k3qlz+AKEUATvD6V8fSBYV8U3pXePQOdicPLS77
         /DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773255245; x=1773860045;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48Rq386LbFxcTvaBdSS5G9zffMUBLJ5/89qdZgdiUgo=;
        b=DdYJj8H1mVSodqChqkXeQK8ZpQM8eFz111Pj9etgqeCINQTt/baROEZed8P8T1gZb9
         wbwQe5C6Oy8/Gi84reqD/t0O9B5BS5Z9PpV2t4yAfGCEcBTloHklR7dr8ObQJ3W/cJX/
         vJ3uh4NBIY9+pDArj8fpB6zDwhkYtHCmJExoNoach8QjMAYjBNntErBLl04I9t1XLj5x
         nI93xds6KyOhZ0eXojvg7rH31zx7TtRiUyL+qETbOxor07Cwv2g816a0630huNXASGgn
         zXTx/ngdsvTEOSH6a57TBGUILQMdN1MD1+aMU6KnCL2MWteaMtQMRPD7bK5MpTHNf/xR
         A86Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVaUSMWgbL5o0Oy+oz/yko8gEChqICzrnzu+HTPmT6gmgIXGcdPcDoct6GWkpgjwxwiOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbbWhxAKLBzuQ1WOjOz60oaWzUJj89qcWQa144SlY0GxrnPd4
	bLjfVaRQCQRKflTEWlvDECE+ax40vcW19PGvoa/JdUkuESU0SCaNaRRZwUnY5NNPxbs=
X-Gm-Gg: ATEYQzwd2pIDqRX9XnezNAiNO7a8B+Qr+gXih4Ni0j/CYZ+2NuXCiZNEZRAsKLxZTdV
	jzpex3lLITCLDFvG85SM6T60Bvw+3LSeuFfoZr9sJTrsW9/8H7vjEoFUuKgklCgJO9ehI3MqQ8S
	IvprSGCGJoQOpsmC20DjfQv97gSm5Hq6cxvN8ZWeRkHReWcxrfLDSRmKZRKgw7YGYrAuejwAY0h
	46BQtczBIGfKdCo/EElAQp+uMwa1u2BT0UNgGXxXPkNcqT/mJfkhM/kAhOSg8PIElNDDSycPZja
	YNCOhXbSzlCCPd7V291FGiPd84ErIAueS93cMb+Olx8VGpdBk2Ojwehcbkd4jDnPpVx5qWnuo+d
	/Qy3AjP0csytPC9yK9f/B7P5k98EoCV7pr7z/34NVVG1P2lrabDCUVgj01yqnXyn957lZdJsiiw
	uucRSdib64fV0HX/Dq5o+xy/g=
X-Received: by 2002:a05:622a:548:b0:4f7:a06d:c4df with SMTP id d75a77b69052e-509472c6d6bmr9420611cf.33.1773255244852;
        Wed, 11 Mar 2026 11:54:04 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a0f3ae0sm17704181cf.20.2026.03.11.11.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 11:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 14:54:03 -0400
Message-Id: <DH06ISQ4EGAZ.1QCNENWFAIJ22@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Add tp_btf.s section handler
 for sleepable raw tracepoints
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
 <20260311-sleepable_tracepoints-v3-3-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-3-3e9bbde5bd22@meta.com>

On Wed Mar 11, 2026 at 2:22 PM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add SEC_DEF for "tp_btf.s+" section prefix, enabling userspace BPF
> programs to use SEC("tp_btf.s/<tracepoint>") to load sleepable raw
> tracepoint programs. This follows the existing pattern used for
> fentry.s, fexit.s, fmod_ret.s, and lsm.s section definitions.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/lib/bpf/libbpf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0662d72bad20..7b65869f5c8e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9863,6 +9863,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>  	SEC_DEF("raw_tracepoint.w+",	RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, atta=
ch_raw_tp),
>  	SEC_DEF("raw_tp.w+",		RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_=
tp),
>  	SEC_DEF("tp_btf+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_t=
race),
> +	SEC_DEF("tp_btf.s+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF | SEC_S=
LEEPABLE, attach_trace),
>  	SEC_DEF("fentry+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_t=
race),
>  	SEC_DEF("fmod_ret+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attac=
h_trace),
>  	SEC_DEF("fexit+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_tra=
ce),

