Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5A3E63B2
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254999; cv=none; b=i9a+qqVuiIRzCGM8AsZyRkilvMB+dEAMD6+6L1QBMPO01393d/YSSK4VgWpywSk2aV7aIpPrXC+B9R1r9+sKpNzeFJ2jLCXLJENqgIZvvfFoJRmEXJ+SF0UmBQipRmIcxmw2vlNpdQsPI9SBLKLbnEv4NgavKC8pgVX4JVaUgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254999; c=relaxed/simple;
	bh=FQ2snvCFGNjpFjkqj50majCx6v3Zs5UuvjLBVsh5MNM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Lp8fxt6nWkvI1T/TsqAl6QCuIUerrS+cWXhKgXrHSglP6POqFluIO6+nwEt4/2kbmk08UywL2oLbd2M2etcHG4pEreePHPSJ9CXCJaOPX/KjBa7rsAIuuxSQBSy04ws/igyqNzoQv/NlPBAMivy4VW98fnVpe6PPJziysRQKOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=c8QhWT3r; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="c8QhWT3r"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb20bcff5aso14587785a.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773254996; x=1773859796; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYMPA+nSOG2vr2CsiQDN7D+dNLMinTtmD9uTmiGyVEc=;
        b=c8QhWT3r9wKGlH2T6mf++9dK99omG5Rec4VqRfcZf+pRERPUGcp7eucBLFBc8M97Jc
         GYfo3o2dMothqz8zSOwUeRsGcxediIvlUWakeBEIxe2Z5U8/YdF9Xyf04xRGFuHXv6Gb
         ubeG79effKL0D3vAub/Gp40Tu+4wpyjRLPtqC/6Wg6L7Jc6fjJGMMnRZlNIqR95j43iJ
         iZMEdb01q7zaKctZLb1MI3XibAAFotivNKkh3nzA709uC7QifyCA1mJHIRJQKvw9jfbT
         vgHsOHlwVTpCflHuy7XbgE7CI9ZN1fCNw231VHVc8zAHZBNZTAizOY8wv28+egKFnATK
         ZSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773254996; x=1773859796;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYMPA+nSOG2vr2CsiQDN7D+dNLMinTtmD9uTmiGyVEc=;
        b=qL7LxDAyU628S2NQs3Y2/iEYtWksuhfMFkYmPRO1GxpO9wakHo25j5hdUYeW3zZTpy
         qDQP0gncbS0qB6y1jsgdMkm7gSXFIyCl8pFwYMbw4+TlRyuwDI02qH2Y9YOnazrEVXPq
         PcnGg4fnsbcGEC3lAszA9Vezj2MVnaINLnEEYYqQ7D23SBheA3n52RjH8zF+r2CXTN3g
         Zm6gtR246d+AZaA48iWuQyrBjMUbiM4k7/pf208gU6l/B068lz6x7bNWcAE1gPiMyD85
         6uO/17C9H2z2GyUgHujftdqyARZjguo4wsEn68PtmbNUbh9ZjlLfTQHRAQQulKfk8s3u
         qbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ER5nOY7BR9RngzmdGMG9kryRNKqbkXQWuMa/EjfV7zCBMMSaJV5z04Qucjml4PD8zrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpk76/a9E+gDzpyE0hmDFlDvB5NglgAhRz7azCbxe2sv8WqaP+
	gnRfNvVefTcndxB1HFztQhiekczEIY//9xBrvWJEmcjAF0czkk2TOMB31l0V6+clPlLGk19o2YE
	xUbBT
X-Gm-Gg: ATEYQzyUifSf0BX7x4/138zQmj2AePTwqcKbgxO45ZKd6k8KaLoOQr+3cHYZOix/DLc
	3fBVy32f7RKWVVo8VtqUDh0Zlyid0g9cnJ9q+FCG7dxTbocW15hFGR5nknXTLMeNmruo9cJASbT
	rWMTp2w3/zOV0MxY9XTSEyyqJn66a+ZE0xk85pP9Tl+DSOxs3QKVau6A0fk9BIq0qOS+YG2yqGN
	MJQKkLtfCjwyLN/RvRTA9R8cNwciIb7/PMlQLLO5aLUWQGwHwW3IR/EX/m9DK2EMX0Un/DChD8/
	iuplbeV7ZYIRiFqLAsIv5mg6BpK/I278OvSspkZAw/HpgPNC+sM576LOr6WdzskVZPUbaRxAWeV
	hVCsEaRyOfhqH8wSX0pw9FEPLri2w02C9vAiOuomLykWaCd7TT1P9I6sPdoTQuAi4JO0vD6CziL
	50NbBRNKD5D5b5bYVHAXw60XE=
X-Received: by 2002:a05:620a:2954:b0:8c7:fdc:e87c with SMTP id af79cd13be357-8cda1a29dd7mr487575585a.51.1773254995886;
        Wed, 11 Mar 2026 11:49:55 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21540f5sm178840885a.45.2026.03.11.11.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 11:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 14:49:54 -0400
Message-Id: <DH06FM9WZ193.2810STKDXGBGK@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw
 tracepoint programs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
 <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>

On Wed Mar 11, 2026 at 2:22 PM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add BPF_TRACE_RAW_TP to the set of tracing program attach types
> that can be loaded as sleepable in can_be_sleepable().
>
> Reject sleepable programs that target non-faultable tracepoints
> at load time in bpf_check_attach_target(), providing a clear
> verifier error message.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/verifier.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e4f69918693..95b33b85698f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -25216,6 +25216,12 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>  		btp =3D bpf_get_raw_tracepoint(tname);
>  		if (!btp)
>  			return -EINVAL;
> +		if (prog->sleepable && !tracepoint_is_faultable(btp->tp)) {
> +			bpf_log(log, "Sleepable program cannot attach to non-faultable tracep=
oint %s\n",
> +				tname);
> +			bpf_put_raw_tracepoint(btp);
> +			return -EINVAL;
> +		}
>  		fname =3D kallsyms_lookup((unsigned long)btp->bpf_func, NULL, NULL, NU=
LL,
>  					trace_symbol);
>  		bpf_put_raw_tracepoint(btp);
> @@ -25432,6 +25438,7 @@ static bool can_be_sleepable(struct bpf_prog *pro=
g)
>  		case BPF_MODIFY_RETURN:
>  		case BPF_TRACE_ITER:
>  		case BPF_TRACE_FSESSION:
> +		case BPF_TRACE_RAW_TP:
>  			return true;
>  		default:
>  			return false;
> @@ -25461,7 +25468,7 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
>  	}
> =20
>  	if (prog->sleepable && !can_be_sleepable(prog)) {
> -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struc=
t_ops programs can be sleepable\n");
> +		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, struct_op=
s, and raw_tp programs can be sleepable\n");
>  		return -EINVAL;
>  	}
> =20

