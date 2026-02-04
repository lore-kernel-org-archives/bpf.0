Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D33F0776
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208913; cv=none; b=ig/xSlul+SMyYVeQ3KXhQl9za7iPDEI5Py0ha7dwysFZKUiyTa50YfYZ/sB5GMFfUft/TD9Cmf8r8yOFlmhlC2bZkzZbVjdKh7UgYhvzz3IyNfZVYTf+wULc8nH1qlD9fgEbCcuqkxeq2OrhVGfWIM0dFsN+pkHrbo8bSOaTDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208913; c=relaxed/simple;
	bh=JhSyZLf5exlf/95F7gHqaO7ZTGaK3U3qx48Q/8jzcUI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrMfP7aY0JPt0pIGXb13T3rdyjtaUXkStCDQ3h5fJxZRK4acLkauU26gWY74l5fxoyhgY9z9vZkNA3pBOI5+SiC7Nc1slA8SEuQyfozj1XyXJ1YoOnkIauvkLTGzdQ4jKeezFLF+NdG+EN+64oOdaGy1Ren457UiWTx9V1pt14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiOosBKu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiOosBKu"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so91749715e9.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 04:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770208911; x=1770813711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sipdmvJVf7asP1VhJpC4Xbp+ZBzA9tqFuT/7XUNiBl8=;
        b=EiOosBKuEdLIpEZW3rDR6Cw4kAC0XggbEuw/21AG81NfNYE4PRZftayMdJjc/9TrCu
         cA9o4MuxoetDWnVkKMzUrRaRhgmFD/gOF2aGkRL15Z6Tqkklx9s4Is2ICNp3L8F/IHQN
         1qvm2Q6KYBzTcNyrMlHqH7YaQ/pq2U5kt7oBHVwMWn6apX7X+5dN6HjfXBaGyhosJXDd
         W4MomGR6Egkkjh6Rmkdog+1oaNzr2mW5vdBMWCeEYUZkFWbDFa4j4TPJnX6TvSadAvNj
         cKbhuohWqI0nyHpuEYCh6+39Xj5g77cUy2bTdIOYv59AMatDZYHSxjMo9ENnIDUPWVTC
         o9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770208911; x=1770813711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sipdmvJVf7asP1VhJpC4Xbp+ZBzA9tqFuT/7XUNiBl8=;
        b=Y12nEpZ733gZq+CGdPBfnSDs7no3fNK/mWjqZaVRogBmCLddjYPGVzMx8egJNWiz7K
         ijVVlqyvWZFULNz6IIcvcDf54qQsYzNoL8hbCtknRlbGnPOS6V2pY/JLXMKqm1L28u4s
         FrGj25/2mu7cJeVQA09TCygvi4TUVb5ZaH9q/S0mnr+txpPq5v/59pI6ekNpkNCyjerN
         aT0rr1AZZQ8U18bFnCU05GUvyaAm4G5zST7vJkaw1FQZlFV/O9GjIbIkkXwvZeT5xwEk
         orqM2hwugFNqjLS4zzhGsD/vYordf6BrbaSK05DeTURsDRinQKYkN+qvvgEXE3Lq5UqT
         xozg==
X-Forwarded-Encrypted: i=1; AJvYcCVRPOQzYhRr8lUcQSO37UEKuSmm6PxBoc8nrsX4OyLzoGMjB/Pv4RA6z5hRAd5SKOK5k+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3ZhT9pZE49b/awVUIjrqtczv/2Bf5LcshoXKWc/691Nj6vU7
	qsRtogirWgTSX52RUHwDIBQJtMR7+YY56QEv34B1Pch/aoMlRzSygmhK
X-Gm-Gg: AZuq6aKf83S9pdfKtd9mh+FAPjfYruPeELtFfEXVnE7NskhRU2Ks92nkIVgMqhMamc/
	1RE9Nye5fjUEb3B0o5BakdchaQK09CpiGWU0rolBOxrXtTTJuejP8i/QwJ9CKomx+/owryNfkJa
	Ik8zibEBa0uzFsgl3rIDmvlQWLMO4ZET/e3ZWd7Z8DL2v+4XwDTJ5WLzT2yDYWEV5P8DHwsepzc
	JhyO+kBnpaiFyst6z5u7TEJskthG3BXbfL6+MKV9O77B9XkjHcaL6CSJ/pKPJ1/VvZahx6r/5ZJ
	pjDlPy9ZuhQQ47lV0GIcKL8NdF1aM+ITtPRnZ9FXWs/l3nfE0FDMqMkTX63AEtZQXCSYFRIGzl4
	3vZF9HagHptNEFq01W1wWtzUqnXPq+64Wq6dCenUeUcSWgJGxz2smimx7jXfX
X-Received: by 2002:a05:600c:4513:b0:480:699c:abe9 with SMTP id 5b1f17b1804b1-4830e97d784mr37940915e9.37.1770208910979;
        Wed, 04 Feb 2026 04:41:50 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec18706sm34237675e9.0.2026.02.04.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:41:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Feb 2026 13:41:49 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 05/12] bpf: Add multi tracing attach types
Message-ID: <aYM-jeV50WaVik1b@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-6-jolsa@kernel.org>
 <3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev>

On Wed, Feb 04, 2026 at 10:20:29AM +0800, Leon Hwang wrote:
> 
> 
> On 3/2/26 17:38, Jiri Olsa wrote:
> > Adding new attach type to identify multi tracing attachment:
> >   BPF_TRACE_FENTRY_MULTI
> >   BPF_TRACE_FEXIT_MULTI
> > 
> At this point, should we also introduce BPF_TRACE_FSESSION_MULTI
> alongside BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI?

good catch, will add it

thanks,
jirka
