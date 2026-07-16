Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C37344044
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185660; cv=none; b=N4sc4g9DSf/raoohhw4tZ4zWjTp/EEsYUiTDxxhwSWULB2BpHvmIEqpcf/PEBUeW10TRZhzeh/XLKJ/qqV/mgDsLdOTQ9fRtfNqs7HBw2uaPNltedxvcUEZPmWetyeUK5UDyzg2wFLqylL3cO+H6NqobpBe1Bc/t0P9AF/yox5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185660; c=relaxed/simple;
	bh=7tMd6WkIF1BBW62hYs4otp11CPti6yTRLQq/s5whbPI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AzumFjRvJNJm1aaPp3wSz4gh2lvNkm5dyj2Cn97vQz7B0raUJ0cOt8sI8SpAQIoi5Hd9ngYuKVPXyZWpgA4gEXRh7oWlTPlzLUavBtDCCMbHdAfAdfjHCQoWkenykiUxukmGNyAyoafVKqjh7nUQhkOLRni1CyKwmRJysYEibRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW5XQw5G; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW5XQw5G"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso3133065a91.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 00:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784185658; x=1784790458; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k5TSW8bUR3QKse+jF2w3Ryq06boFFYwT3ZOIircOLQ4=;
        b=dW5XQw5GsvyAvWNsRoptCD/MJegISjyAPWuDoSKpXOra3cxEkSkdbSV2noCXOng+Wf
         6tDMP0Kcc+X+Bk8lwJpVLxd/CYd9A79fQ01+BOBbwde7Slqxk1FigKRGNilqQ2j5SCtX
         LCUen8xVpUQdT4fF/O/yfC6hbtOKKaFMr6jGwhpSgiHx4T9xEVuqNPz/N7nMxSEPjPHZ
         etC4Rax/wefcT+GuF2OJryZvBfyaa9ObNFvBq+1NAZcErtYUZpFPtrqred5IaKuxIDp0
         9wCIqpE0YSUK9jqM7sqTmQc9MqHjoEH4rSbTOu4T6sGppeZKUvrz15LydFShmFfgvG7+
         ceMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185658; x=1784790458;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k5TSW8bUR3QKse+jF2w3Ryq06boFFYwT3ZOIircOLQ4=;
        b=KF6TZjZRqu59GbRvn47o7JP3buYpvXAnBUuusCDTBhZNNzMVgOyqoyNCsd4aEop3Ud
         s25pV/0ZrpdOp0fwx2mqdQeBpXKIy36SVA98/blYkQCGE2fukV/P3RZfXsohH7re8u5W
         916W182JFNf3EtC0rw9N676+dtpVhRUfDTlwmjACu6yfHZw0Mhxqpx4Cxpie+lJGysYn
         q8Bv6/8uvuzcpu3rLGWJM+dj6GkBEgwuXYqmBHlsb1FFY9zBC2R1rBWGbJw7ODFdoEH2
         wU4ivnsbhnFwJpFl4bRgPOpkG7n/HvvIOfXRbNSCc+aW073IlANc8i6fQ46ZB4KLBGEk
         J5PQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq46Gl3vowZkJyfrTHqqKP9K8Rspt9f/qjWXTeC78IOPrmn9qABxuTCO5M2Kby2xAeL6dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46jEquxmZ1cC2sTqTfTvWbniU9V3BmRbfqdU6IOl6qTlDln7g
	LoJBOt9VCTEJlavydawuZLBVSxIU7uvpRd6BCh0igEhsm3E6roxHtLqO
X-Gm-Gg: AfdE7ckPK5pJjZiLS2lo68Tokj6iqihMdjiSOfDdp5hxjn8Lvf6uTcyZeMNbLWbxHrx
	9ywnV1PSx2BRmG00xMHL0526+G4pCVDymHeV7xsvc+JXMZO4HLGLu089XVoJCfxz58YvnqzjxjZ
	rubn+hr//EcVIwpoGfmmh6xgFMgXzJOPPTitEqib3i9bTQyv523U0xcYFwvJIs6WfBcZgLkJ3pa
	/raCamvsB7IrcNI4Y/4r4ewsJcPlatAJee4PmBe3NGiIVVdcTJSf9SFCDnQ9ujyWbjvNIzKTNEO
	RchZkDX7Y9KvEhpSrJ4vW7XF+hgqKmC+nvGl8IVP8k856kZwGMrux6WO/ViYUVA/FruDnBvXyod
	5b7qf9mCJV6DozjSTKwA+9H0iPh9OhO1HX4/JZZmgDpT2FUZ6sONepRiBtV9pgMTjZPl3U0MnEK
	u+EOk3J27TPYrEMrg68LyAPJ8IzHiUHLSyUP0p1fXHdA==
X-Received: by 2002:a17:90b:57c4:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-38e29f97584mr6226912a91.14.1784185658111;
        Thu, 16 Jul 2026 00:07:38 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e0dc14sm818627a91.5.2026.07.16.00.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:07:37 -0700 (PDT)
Message-ID: <f04032bd7eb2c967d5815810fcaf610f281a1ff8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 03/17] bpf: Add verifier diagnostic event log
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 16 Jul 2026 00:07:35 -0700
In-Reply-To: <20260713153910.2556007-4-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
	 <20260713153910.2556007-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 17:38 +0200, Kumar Kartikeya Dwivedi wrote:

...

> +static int diag_append_history(struct bpf_verifier_env *env,
> +			       const struct bpf_diag_history_event *event)
> +{
> +	struct bpf_diag_history_event *events;
> +	struct bpf_diag_log *log;
> +	u32 cap;
> =20
> -	va_start(args, fmt);
> -	bpf_verifier_vlog(&env->log, fmt, args);
> -	va_end(args);
> +	log =3D diag_event_log(env);
> +	if (!log)
> +		return 0;
> +	if (log->error)
> +		return log->error;
> +
> +	if (log->cnt < log->cap) {
> +		log->events[log->cnt++] =3D *event;
> +		return 0;
> +	}
> +
> +	cap =3D log->cap ? log->cap * 2 : 64;
> +	if (cap < log->cap) {
> +		log->error =3D -EOVERFLOW;
> +		return log->error;
> +	}
> +
> +	events =3D krealloc_array(log->events, cap, sizeof(*events), GFP_KERNEL=
_ACCOUNT);

This needs to be kvrealloc, otherwise it can't handle pyperf600.bpf.o.

[1] https://github.com/kernel-patches/bpf/commit/ecb6671190348b56eecc3b1033=
9df4b162de1529

> +	if (!events) {
> +		log->error =3D -ENOMEM;
> +		return log->error;
> +	}
> +	log->events =3D events;
> +	log->cap =3D cap;
> +	log->events[log->cnt++] =3D *event;
> +	return 0;
> +}

...
