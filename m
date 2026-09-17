Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F549AA55;
	Thu, 17 Sep 2026 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644269; cv=none; b=TEoeIXLICGfG7FcNJcPLw7IXLBN24oNh2cxGie0bk/b0w3EDdfa4Y9W2/SAkmfLOUaTvWrFAiU6BTT2zOK9In2XtGBYvicYqdyxoXby7eAY5TQ3abm39E2+GhGieE1D2KpOeWzhNg2PPLCWB3l47W49PMnLD9Gbh9KOX1ENhWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644269; c=relaxed/simple;
	bh=YN6QEaGVg6Hw72gxDdgupplCUHH2A75FcUR5OYswHoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOoRGCsniPOdq4Nt9CXmQo8+okG9KYBXUyXsZUY0yQSXJARD2xLohDJ+MNUAFYSHXiD3Aj/qH+ufQ9ApSDztbXG3mOQ5Z9aADiBohzRLk8teQ9RWm18t1Fw8kG7zZmzv1wMefqOjWYthibse0fSihlKFm6GcuazLMJiCEqKYLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWbCdhoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWbCdhoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305DB1F000FF;
	Thu, 17 Sep 2026 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789644268;
	bh=DGeat/iGnBxBnDqVj8Z9zNa44l9jAW8b1Jwg+5H107Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aWbCdhoIILyIH+iLoz5+dNRRk/vQq+4JUWUx3Sp7FaEPciCPjuOOLw2kW6RR3UlQn
	 D3epkf31Vn4aC3vXJi1ALRhMuUFMBI+xR3GEt/7SZxUlrp4kLfJpaP7aYuu44dsjHx
	 fvElwTMLMoqV6G4u36pldoEM60C7ZnJSgyO/KvKqs8Au2H6/Rc1TcIV4CrGGFq9xYF
	 vB7aBAwJI6o+LSzfO3D+Lstx9hDbeyRzWcMT2qwjTfqOLxJ9cRG3i4cJ/+QGh7JR7I
	 GWObAeFjfIWDMaVI0Q4kvaB9sFt7vyvI9fNaJUqIwghZkJVp8Ec26Ic0iNQkAj7GRM
	 upgD9SyoFUsaA==
Message-ID: <b2757705-2056-4024-826e-e2731820978d@kernel.org>
Date: Thu, 17 Sep 2026 12:24:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpftool: Compute map size of light skeletons
 at runtime
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org
References: <20260915161450.96249-1-leon.hwang@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260915161450.96249-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-16 00:14 UTC+0800 ~ Leon Hwang <leon.hwang@linux.dev>
> bpftool rounds memory-mapped data map sizes to the host page size when
> generating a light skeleton. The generated code therefore uses a 64K
> mapping size when bpftool runs on a 64K-page host, even if the skeleton
> runs on a 4K-page target. The target rejects the oversized map mmap(),
> causing failure of loading the light skeleton.
> 
> When try to run 64K-page selftests on 4K-page VM, the error message does
> not provide the reason about page size.
> 
>  test_atomics:PASS:atomics skeleton open 0 nsec
>  test_atomics:FAIL:atomics skeleton load unexpected error: -12 (errno 22)
>  #15      atomics:FAIL
> 
> Pass the original map value size and max entries to the generated code and
> round mmap size to the runtime page size in the user-space light
> skeleton helpers. This keeps generated light skeletons independent of the
> build host page size.
> 
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>


Looks good as far as I can tell, thank you!

Acked-by: Quentin Monnet <qmo@kernel.org>
