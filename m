Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9B405C49
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686069; cv=none; b=rqlZTdlrpmk4XRTclDUcgSrMDggvylP+5p1IoEHTsJ4W1d/4d3fTc35Jk7n+fNlgUpC9TfCZ6HIHtpmj6V++Aw8UPCIhUestu5kNmaqmGDzmmYeOzwmkPEY3qHmFxKORJp85sWB2ebj40TKHC5vK5m5A7H68VKsprvFZ/tRh2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686069; c=relaxed/simple;
	bh=mlp8CSE6eIaCZluAtk44mGVn3id863qx4RzEygLECPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBeel4N8aRYxsTLV+B7NyEBHbeRm/jl3p41hFyb9flKG4M1X4quAZ5uYNjZxW13VUk00ZBaR4ckUeo0HN3YDT1BC4k82vyVnolE/a6uZsk/N2Xt4RLLVYQxlzv8S3Q5ks/DcDPTYaWWJybuiThbwUKfUGo9+rq60QxJLo3iCwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUr/xk6A; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUr/xk6A"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8423f52af13so1638476b3a.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780686064; x=1781290864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=psZMQqevIRQdslkufaGl1+3b2/q5KJbu8mgWlUYpKrI=;
        b=kUr/xk6AdW+sb5U28iaXmguLNamOTfx17wovXZqdSxqlTCGggIGPVzfdhlJOl8Eix1
         bpCmdRgBoI74AIdNvQxi6CaafOie9rR0vPsEHQxnWTotLP5FcYu2Z7r3Rqb/Kr/l6lV5
         keGV1it2iYNENs3aIPlWg6jPzi+EG3I8GZqmyr3dLGyu88fomaancNHzkBCP0BCQ0GpI
         bAxXa5K3pZxIHgnTewvfNpddkWaKX1JHhVukQsrX44fXEY1LtCI15v81spjKgAdpnL64
         ZsD02FGpArUW/OcGFgoZrY8J5OjJNk4l85yY99UnK3uM5JcXZUi1cfvGypLagTU3fj3z
         +teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686064; x=1781290864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psZMQqevIRQdslkufaGl1+3b2/q5KJbu8mgWlUYpKrI=;
        b=s4xCMPuoAoaw19e6ZI9bLrz3CyU4QGyHcRFA/EEoTgv4safwShY+9/HmkLh4O2pyj7
         HdaoceqaOk77XF7zRIppM+oATgQIn4ZXtXnjzP61yF7AVR98D8xnAoEn0F6Oc7gTfss3
         31Oa6Qd1S2HftmMd1mQRtXbBe3kPCBcSDOIS1xJuQm8Sh8HSxYTkYJfTIrmZrA4r/DwE
         a2bGuA3L/Jdp1IRlspmziSvkNycH1QkF/z8euU+RzzoKBFFTxHDnnC5BhX5WWO0rrm9H
         ixVF24RgZC4/FDsxLLOxBW3sfyS7UgmQUG1TS3a5xOPdy8eKNLs5gcxZUm0P0FVLda/9
         82EQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lmhm+Yku6+bU+yIXmyJ9em2SGhwLdtKxsdfEmSrucxAW1hsGGH6CPjJrnjWGgZGzFrhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAo22hFNxplVUuBDJ2/Waun/ShAtAIekQUKE5u6y1J4ILOhj8
	Fbkup6/uTRwOqJt/ivrCLCwCg6VfIWF2Fn9CqdB43gdMgztRtDEUqG1JyoFcA2D1
X-Gm-Gg: Acq92OGWv8L4GSWhzKGLpsbupAtDHClymCzNhVvPYUsJN48+rkQjILuG1Rwk23MJMym
	cdgpVxQbQhmv3JDFt3L9yE9++nByyxQ7KtzbDPtnxgLqSK4Q+QCRbW6pzPaaugnohUAqEM6kS+J
	A7USy4fIstfJEinu1DBLFtf0fc8jPIqueMfM9MVsDmWkycMgGLTOimM6ysADN53kVWWkp8jH6ZQ
	Of073rbi0rjBBODRlOTYFv41QkUnH8GavZRxBEJr798BUu40zBc+AkhcX/Vp0mztPGR8Qz8x0Uz
	nc6gZu4getT3r91xgJmOjONX8AjQwfPKfg5CQP2Qy9hTth+vpnX4FhCQEqhuqTY2tzPD0VwFOXa
	AropmWdOl8am/IIqwzf0nYFWr+C/VF3l3W5/4nXAN6sR/bO27P5StysBNdnTxi7Ee6SbDp35PNh
	5sZUzclbuIAl1i+qNnfDWODMoSZq+FJ5+IR3eb3tLGZzrB0mndMPty1ssRlitYsRGP/2ZNNXbYr
	z9Xjndg
X-Received: by 2002:a05:6a00:4c0a:b0:842:708f:39a6 with SMTP id d2e1a72fcca58-842b0e1e208mr4693931b3a.10.1780686063875;
        Fri, 05 Jun 2026 12:01:03 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428288002asm9906446b3a.31.2026.06.05.12.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:01:03 -0700 (PDT)
Date: Fri, 5 Jun 2026 19:00:44 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Juntong Deng <juntong.deng@outlook.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
Message-ID: <2xszbykyotvf56kziukek2uocto6ddxu2tygy2ug24dskx375o@o3wdv3nrxacv>
References: <20260603204206.773482-1-rhkrqnwk98@gmail.com>
 <e3e1f8dd-e0f4-4f9c-85cd-22c58571eca7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e3e1f8dd-e0f4-4f9c-85cd-22c58571eca7@linux.dev>

On Fri, Jun 05, 2026 at 09:59:49AM -0700, Yonghong Song wrote:
>In softirq context, I think we should return NULL for this kfunc.
>Your above fix solves crash problem. But even not crash, the
>below task 'p' may not be user expected since the 'current' (and
>its namespace) is random.
>
>Maybe we can do:
>
>+	if (in_interrupt())
>+		return NULL;
>+
>	rcu_read_lock();
>	...
>

Agreed. I'll send a v2 using this approach.

Thanks for the review.

Sechang
