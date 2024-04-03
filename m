Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D1138494;
	Wed,  3 Apr 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182533; cv=none; b=Ak3DoD6la1BJjao+A/N2BS5MBeFgtI4WJEXBelmwBpCirCwslTGhcgzUyid8J3EdH6bXC9oluteyYyImg5wzX5qj3X9AiY2w+aVRtK9a1Tl02R1WAdK409PkWWXqHQQUiEPcq8euEKqV/PY138A+YPe128VGsSmp5blruO1mq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182533; c=relaxed/simple;
	bh=wnI9q1XWClk4UoUz4YToEoTPtMP66zcetGjMY6MOWBc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LLpDi3MW4g/bxI7DPc3fmcFXYvvea1tvYdDcJ17RIbAL7Q+hNxVR7lGgKmWN0ylF9n0gq1R5FPy4M5ShqYC11EKaL0t5mnMSKoX/YhjmpOmXgqu+P+JxlJLgamM6nmaktqTWMnmNYiSaiMq/O1GpmWcT/OtI4aecozy7cJ+yuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4myPBuu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4myPBuu"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso213919b3a.2;
        Wed, 03 Apr 2024 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712182531; x=1712787331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa83cO8+E/0MeIPqx8GuMYKFzGCtdUc8JeEyD1W6Oxs=;
        b=J4myPBuu19k2j1U6FmLhHepP4vcYvPxeTabhCPc/0N7tiGJ4PmpEm5VgD3zl3x+LV5
         TUeAntrISOWlt8qIpneD0iELf6y1yz7Yg7OejmvNJBSg9N6pifPyT9POgteWcc+9REi3
         a2OlvRBg7p0cLGfIH3dVhhohoF/1H+48jtEkgT0WClOOulniMAU5JyAS1R/zuWiMPol8
         uC6HsvCT8G6LTB7oPIv5yG9fdADpXCWumLY+QrD7h6lDIi/8MpOyR3GfFQftvMfSf48i
         tPfvS051MfxS4f7DmZ40tFI2RDw6LNIJ7LagLUbqvGOsNl0LjRRYwj8pz+Jjfe9xzIdv
         dT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712182531; x=1712787331;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qa83cO8+E/0MeIPqx8GuMYKFzGCtdUc8JeEyD1W6Oxs=;
        b=qr/K1Y4Fh1aO8X8nr4MQMAXUPIdb8lp4XNQUdPchhrt7jkdIDfGrPvC5eMuameCPbi
         kUyOCo3wsENKahl9WvocijuahkQIYNlXTWnFx7y6EwQG4VqwzTDpjBrMh7PJao15s4g/
         Q28VLeN/LpZOuB0YwWsi//ACPXYBwI8iQwD3y9J2o0OUqHxg+cLptmfXqN/kwwuFgzty
         d4hrTDy3U6iNKVQizL6EC0HlFf3F0TG8p30PK1US8yP0u1WF9dRlvwpujHSNuh7UIWn8
         YHUy3FY2taxSWoDTxNdvNE+eyAgyUsJynMBRU23uOIb1F5MAk3C+IGpfa1Z9UzVF8srA
         59+A==
X-Forwarded-Encrypted: i=1; AJvYcCUpV9CJQLXDKlxYj1RIWhSHSijC00KD9QePmewx+Yr66wtktGoh+xtivzYKvBSnvOQUGiH/UHthNrtf85Mev599Hi6JrUBI8jKz9b4u0ZmzHUG70Ut2TnBU2ZcfVdo9XaCpkse1ro0u
X-Gm-Message-State: AOJu0YzB1LP4Oec6izobKBQI6yFWWxGKxlphu9MG0FIaN0FyGp3Qb1PQ
	J+/izobRyNRYWifsHQ6fpePDXb2SzoBXhvCp4HMqJOCuTdbC93oVuG/PO5va
X-Google-Smtp-Source: AGHT+IF8Y5ziJQ5zIq+S/EAFVHj5xRMePnALmHrqwKFxt146VSMhBJCRz2jN+0ZaWv4mfUQCijRQVw==
X-Received: by 2002:a05:6a20:7f96:b0:1a7:208d:9b4f with SMTP id d22-20020a056a207f9600b001a7208d9b4fmr1099909pzj.16.1712182531138;
        Wed, 03 Apr 2024 15:15:31 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id v186-20020a6261c3000000b006e71e3d1172sm12727853pfb.101.2024.04.03.15.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:15:30 -0700 (PDT)
Date: Wed, 03 Apr 2024 15:15:29 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, 
 mhiramat@kernel.org, 
 martin.lau@linux.dev, 
 kernel-team@meta.com, 
 andrii@kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Cc: sinquersw@gmail.com, 
 kuifeng@meta.com, 
 Kui-Feng Lee <thinker.li@gmail.com>
Message-ID: <660dd501ee0da_21448208d5@john.notmuch>
In-Reply-To: <20240401191621.758056-1-thinker.li@gmail.com>
References: <20240401191621.758056-1-thinker.li@gmail.com>
Subject: RE: [PATCH bpf-next] rethook: Remove warning messages printed for
 finding return address of a frame.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kui-Feng Lee wrote:
> rethook_find_ret_addr() prints a warning message and returns 0 when the
> target task is running and not the "current" task to prevent returning an
> incorrect return address. However, this check is incomplete as the target
> task can still transition to the running state when finding the return
> address, although it is safe with RCU.
> 
> The issue we encounter is that the kernel frequently prints warning
> messages when BPF profiling programs call to bpf_get_task_stack() on
> running tasks.
> 
> The callers should be aware and willing to take the risk of receiving an
> incorrect return address from a task that is currently running other than
> the "current" one. A warning is not needed here as the callers are intent
> on it.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  kernel/trace/rethook.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index fa03094e9e69..4297a132a7ae 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -248,7 +248,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>  	if (WARN_ON_ONCE(!cur))
>  		return 0;
>  
> -	if (WARN_ON_ONCE(tsk != current && task_is_running(tsk)))
> +	if (tsk != current && task_is_running(tsk))
>  		return 0;
>  
>  	do {
> -- 
> 2.34.1
> 
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>
