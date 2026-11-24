Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795536612;
	b=SXoDq8dMA2hI6q+9fF8/7jiDnMJ2e88EjZMbkG6RpE2GiLimCeEn435griz7HKcUWesa
	 VX2LhNFfP+j8hp/2X1XHqGExtWSEebBUn9SkB5UlBEWSCZt6T+R7PxQUlN0clggUx3rKW
	 meZYb8zSIf1OqnGiNUcGRyeQj4hYZC3ULXsnWhhs2Qiv3o40c/nct4ktqdP8p+F6IBSx+
	 9mMUFtyFJlFb8A2d7udZgUR5X5eRwJ5etGuLhtys1+vcbMm4yEnpV+SasUnCxfPzJu02J
	 eF6eC/BxhaHVoQe/ois0tEXRNFgeLp8pEp6CYqxR/RzAbzt+PQYQxgUr9LJ6PaB48fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=pECHgTEWdmkP4oll75I2OEsbM2jKiS8QbJcrj5sLeos=;
	b=bcA0K/htmqbDZwqLAlpNTfByp9R1L4ozpW5ROUWkC27sJkfCpX1FLKkkpfsMAngKlhaS
	 VfHPtrL2YOXn60YnKhjD9yO49AFj1eHdmLgzQ90WmiZMWOUnP2icY0BWu/6kcAEcIlRd9
	 lkKfMOkcLw6LFOTpeWW1fTE9krl5iLrGj1/4wBluFO4stFBLh0FDB8es5wFa1XXqXDTZA
	 IRV7WUTQfvxB+Dyo2hpGxm4eGV8uh3xhj3A3rynPIOrEmsA/suTjcaLegXmn1kKF8qqfQ
	 b2Y9WKpKhw0MxjwTX3GmDIt7zkl+9WF8igilK3RQ8vWZoNxFG0Wo425pvzw/4TOz/+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=S1yI3LI9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7E606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE7E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=S1yI3LI9
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f083477981so1200295ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 08:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795536611; cv=none;
        d=google.com; s=arc-20260327;
        b=f+GUm2fLZ0tNDF4oU/l8QqBp02GfAxbwIli+/ejvHaLi+vVKT6QBYriEfc/2DYz3/5
         guVdb27PNWRH9FXXjRxTNUbBgW1eaUBZQXrNWu4E8vT33xfH+8hrnfHaIyB83V4+msy/
         Mlrx6/sL7/l+xGC99dJSK80rG4ec17MofIuHl9RY2Wi7FFcFG735lpoZdk9bugTKKjhi
         ln/hJHMpUj7NlG5QOPL7gusgc+KQS3Fr9DtakueWUBMPdTP6OpjyOQ2qFRvfKR9yZtfd
         ATS1ZHDo7pukUPwB7EvzrsAJI9qs+Mnwwx3+a45JGjLdmR1e7Bsq/PJAtDuP9F9gFs55
         nxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pECHgTEWdmkP4oll75I2OEsbM2jKiS8QbJcrj5sLeos=;
        fh=mf5EVZun5581mPQ3B6XU/k1UuOq1dtpbkLbT0av5AvQ=;
        b=JgYKBIpeVEWNwBjl2vLzMFkglh6+fy4uy33WTAZ0pQzv1ruoF+xDz48vFQzPJwC5N4
         xs3E/Chq7vEmRdRJvPuZZQMk33lBYoYFStyqDyvB7tZWQGJVJBgVKU9879rF5OCBF6KJ
         yGRir++O/vq/b2KbPtRHgfBmdaXJ+EEZ+cNqAU1MXBXeTawJiz5glO8C8kDwe2m8p1Kc
         DUpwda4cWD5xdtnliMwnxN8iZqrpp/aoSpJPFIZt3JUiEgqjb/9VstakDaNBiWOp5Fit
         zW1cz7Gxp6ISEUsWiylCIsicsjYy3jeT6h6XvqcEU4p0f6V3PSXPRxztOSsVp0prfLhT
         f8iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795536611; x=1796141411; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pECHgTEWdmkP4oll75I2OEsbM2jKiS8QbJcrj5sLeos=;
        b=S1yI3LI9vJyy+J/lqhmAi/pLCfOkD65WagY1iQb4FqSa9/NQOUQhUC3zXRx2dS0G0a
         j4D6YPfXYa8sQH14m9VdQn+hM9sNDg/nLHQkAwrc6figbutf1C9kToy4FvmxIIZD0zsr
         cm8CZZc7881CCSw+A8DXVSiRKbxJkMPmRa6NRYx6yOLUo1EhsfLvN8qQcBPlIbNFo5Z8
         z4U2YckqEaEffaLTBHFBmQmGuzMbVz/wm+gXCWS4vu5immdXYfMFMiMMqZ+62+upsskT
         Efum+Cj2AWlAyCBJEJZHE2JzKpCBngcJzUFQXSAOKfj854Ev5KdeSdNFCk0bEQPqpgc5
         lu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536611; x=1796141411;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pECHgTEWdmkP4oll75I2OEsbM2jKiS8QbJcrj5sLeos=;
        b=Q5U95D728PNc4fe8otMTd3x6ef2K1n8D1J3yLSYIO8vi/iFK4lr5XW0LaPtuxibo/S
         rAUUQ/h6HXiQs0SEh7a2HRcX2DapnbCXiihlY737VkcDX0b3nLgD7n6XMRWo4lHZzB6B
         qONnTHSyhZHdJnsG6ud4UN35sOM6j2bVFL3u6QVWELMtRbS86ydPjyJLYzqjPgwL75U6
         BFkClhHtWBjkHZ87nD08n7i76hJXif7TKcDdbcJTJr9FSaMdeRTpDNVHMp5349hp2rpP
         Bj7L+KQYSLQIoaOyzLgTSpG1d7tSTou/a+nz3vzXzOtgIAGKf3rXHnTXC/CNN1eM5hBo
         0Z1g==
X-Gm-Message-State: APuU4Z/9HntGte1ereAhPO4KtlrF2/wkjz+kEJJycMyNN8j6wrP01Dni
	4xJzxBYsVWXXCf+mrCMp6SSwDXU8IkhZifXnO9JB99xdrwAXKmlzGzJFFlLdbKouXR671k6vxoh
	c4Y2SkbrIG/eQTJI2ZAGGpOpKz5SBCC1wYEueMlpaAA==
X-Gm-Gg: AZFdTZex1ItwC6Qi7xpUyY8MXnNBLIP3laVtKWa1ag8o7AL5Q0QydocZBZQXMfEPYYT
	iUk0+GNq844osHjXNmw8DFbDOBhkau8IebD5zg7s78T74INR7bX0rlHtsxjS6qT/To2Cf26K4Zf
	4h1+gXkFOvNQd3AWfTtbI9+HNFyZJ6WcAfWLaDpk8/+H7h4L9F2Bz84zBJfn9H76gYnRh1dGdRd
	Xqutca3zBTWB2K5yqQ7anrNjPAEGyZjrnYbV+Ix7mnLmuG8YT2bnBpH8BjsZwFk4Jm9WiUm+9tu
	rkI7pP/V8PJKxlI9nV3R7LyhESqNk0DTkzlJwojntwSlZPoN0jzUpOR/GfGe1yDR9IGw71hMrch
	MN4m1GuXJR6rg3Ogp6+h2ATcj2KVnG0BJqYVniQVUoqWDJrNEcwRc6pSbSQ==
X-Received: by 2002:a17:902:eccf:b0:2e9:9263:a58 with SMTP id
 d9443c01a7336-2f03f0c2295mr244472215ad.1.1795536611297; Tue, 24 Nov 2026
 08:10:11 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
In-Reply-To: <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Tue, 24 Nov 2026 18:10:14 +0200
X-Gm-Features: Aa3M54onkUvGne4r5q9V5OFXU9IrjVkwLVOH89IS09aAR4OuvPfNMfZg3YhBdKs
Message-ID: <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 06:21 AM Alexei Starovoitov wrote:
> I think this should minimize the breakage and fix the issue.

Thanks, I'll do v4 that way. One question:

Timed may_goto sets the mark, so a may_goto loop would run with
preemption off for up to 250 ms, which you ruled out on v1 ("with
may_goto they can take 1/4 sec"). Move count and timestamp per
invocation, in bpf_run_ctx, so that may_goto needs no mark?

Thanks,
Mike
