Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698424;
	b=asTHail1P96ElgHI6X9WFjxABYZJqkGHFVhp1eY7UOebnLwgktgV7yZnBWQWY+p/Lg+5
	 6+ZBFq6hqDNtSr8vmexKLpyNBj+gORSpP8+db1gd7J1CQ7AaOIsIniI17pH+fqn8FyVV7
	 0FVzSiPLBtZdWD8GUcnvJYd14YOXeSJ3VBvSbxMNusAsuQ6kbvOV5ftPMbZS72gxRFwKp
	 MRAssNeJWSUSgltjXyPVFuSFBa4LZ0YHwmnTRW9/Fbt3Zx4kOyTEdaWiifXZKl5tVbK4X
	 G1Yrha/dX8EnyyswDc+5Adf9xsPfqEEYg2pC6FiR+84pjXmuOj/lsHiy9fyHhg0wwDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZpVCi9UdSntjHN/Hv88jzIgPEfa6hIem2Gl30Fy2TTM=;
	b=cfhEFcCUdTbQOZXz9nC3eCwnBdRSgmaYlqS1pTBD7ZsVki6Lgm38bc8S46ZTvD9bmc3n
	 khEbfHfWmaoySMMhyHk6+L/5z4dCah4SEeF8EBQNl9JmiUnyQ3gYI/ibKdR0AZc9QWepk
	 +KKYbl1JVKSfCTrSOMs0W2B9scqHtp3o1AM9UjwzkgbvZGZM0IhvvAe9ktaEF1H+XIhKP
	 5+3DeOwyT27EEIOdXpyJGDrwBtJyVlHihNQ3j00HIT9ENMnHeQkw4HWfEfQ3+4gYQSECH
	 K4yljEaPPvNyTaK0VEna1hSgFlJ+fM2OTtXxVvXgyq0v6UHCCKJgAj6kgCew118nEOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fzu9Dxkz;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7C606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68A7C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fzu9Dxkz
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so5723832f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795698423; x=1796303223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZpVCi9UdSntjHN/Hv88jzIgPEfa6hIem2Gl30Fy2TTM=;
        b=Fzu9Dxkzyz5r92pTFn+6eNMVyNbK41/jl53o3FSDUQi4gQmyw575gS2F9rGuPRtKsc
         NtJo+2C3bizt3CAr8v78BcCz4GWC/iUiV7dm5Wl0YVxj5RGJY3vN/CmYQFiuUfpFQohn
         iwh5oz7YzQXqgJx+kE9UiXLdHmhz6Rt8UYzc36zO6QNvThd0lo83F9ZsUwcXWNp8bWrz
         LeoVBlsvbIiNyf0YvTmSlf0tNI/WBYWIwlrMOj1JwgaJJfsSI+SM1HYkLqgem1Q81rjZ
         ObtJme10MD/LurEPkiS7gi8KuDfsuCP64mO/EG5wLd0WfmDS94/22Qyrky9bD1ARrxvn
         WxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698423; x=1796303223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpVCi9UdSntjHN/Hv88jzIgPEfa6hIem2Gl30Fy2TTM=;
        b=OZnOgqie1RaiX2cMQBuFzBzx1bxTJWQ9FI/+awX3zgNtTMoUBksyznk/4oqfyP6D0q
         otWBM2VnTU3cQC+XbYBen05oHJdPST8kZWbeVJB2I0te9zUIUCdjuDX8fZ8SzpmJ2KVK
         b2/raAk5VUrZNknyGFMNUtR5CRqZPJUxzux/4LPizy/0wL1V9ZvdAIBdTOBoFaAiMJCd
         JrBIrTpZgoHDB/3dWuvba/PH7ekA/TC/V6c2c0rPV+q9sBTqOv8DPwb/h1inAY7x7A7S
         r8m1spGNBo8qZqQ7f/RUUAKj2tbRok/bZqvWVHe1OXbBTANH2FnyCnAxHbYHIDPo8tcr
         dY/A==
X-Forwarded-Encrypted: i=1; AL+hErF49itCYqgTvA8RMpLgYL5OL6yywjjgZHQbBOCaG8p4Pem6TGa0yUxdlGjuLlf6oQN3Lb4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mUV4/78IUUesLYDEem8683UscEqbsLUGfqpPiuAPmlCoZhajp
	toh6Fi9f3XI+dtfQDDvhkGFip/TBxmN6VBPd8PnmPwsHZzQR3g446p0N
X-Gm-Gg: AZFdTZePanesjScfHnXmhrO88ahBUdnmxKDeBZpGjP3A3WWBtCExAO806ra+eFlJTBL
	j4vkQSS7Pe1l7GNEp87qCZ3Uvfu1eIzV3+3iRRBjovQeLggFr0HKWsGRfESodgflB6WrBTm4/PS
	XFweKWKDlYG2z0Ibf0kTjzslyyoDzqFSjmENwRf9Nw39aZ+CUfLAuJSbNJqhrB8umOFDI+3NNFN
	vOSGOXcX16q+dRsWIQvcNoFDkrljW29IbHAZa1LJe9rU38I19gPIndEvFmjkETUPa2PxxLZBvkZ
	WMBdKFqBM+FCEwLQxw2crQI4xikq3pjiIXrWFCYUFuUAr6ecbFvL5ovRjsqWX9VvM/Lyd/AQ7Rr
	QBQk5WQXJElUYda0ROxHEdGxp9DrE8dyv8/RKa6yjbBdzo/1jBcUEFwXqdNf0UlsXdx/7bFxC/r
	1rPtlK8oqDNj2GzNyUkbqGKB3bNWJhZEqlqHkr+T+79mPW2BauSDuXGnEYc10oNmIVtc2YRSauL
	Ac6vt4Uq+esLPFaMf2+A+rA7GyDdXIPb/WGt0cu79ojr/ZAGdMTXbw6IyamcdRHEEErb0WgyyyN
	mXj5febtJSwp3gBZyi5nxtWq0fAi91bhJVP7Z+M=
X-Received: by 2002:a05:600c:5303:b0:4a2:1655:87db with SMTP id 5b1f17b1804b1-4bb88785d2fmr417142905e9.0.1795698422632;
        Thu, 26 Nov 2026 05:07:02 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm732067565e9.6.2026.11.26.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:07:02 -0800 (PST)
Date: Thu, 26 Nov 2026 13:18:39 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 4/5] resolve_btfids: Exclude the code of
 kernel/bpf and of the JIT
Message-ID: <awgxr-8TOpGGVVra@mail.gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com>
 <20261125212849.868523-5-a.s.protopopov@gmail.com>
 <DN4QDHMFA99A.27B7GAJLQQ7DK@gmail.com>
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
In-Reply-To: <DN4QDHMFA99A.27B7GAJLQQ7DK@gmail.com>

On 26/11/26 12:53AM, Alexei Starovoitov wrote:
> On Wed, Nov 25, 2026 at 01:28 PM Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> > bpf_tramp_ftrace_ops_func() and bpf_arch_text_invalidate(). Read the
> > symbols of kernel/bpf/built-in.a and arch/<arch>/net/built-in.a with
> > the llvm-nm of llvm-config, which reads ELF objects and LTO bitcode,
> > and do not tag these functions.
> 
> bot is correct.
> Let's run ${NM} in gen-btf.sh and give its output to resolve_btfids ?
> kbuild knows the paths and the arch. The tool doesn't have to.
> ${NM} reads what ${CC} writes. HAS_LTO_CLANG requires it to be llvm-nm.
> link-vmlinux.sh runs it for kallsyms already.
> llvm-config can be of another LLVM than the compiler. llvm-mc.sh says so.
> image_func() finds a function by name. No need to copy and sort the names.
> Then LLVM_NM, the nm mode of llvm-mc.sh, bpf_archives[], popen(), qsort()
> and bsearch() go away.
> 
> It replaces patch 4.

Thanks, I will adopt your variant (and add your "Co-developed-by"
and "Signed-off-by").

> [...]
