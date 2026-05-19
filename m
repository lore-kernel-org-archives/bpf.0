Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C01407CEB
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207535; cv=none; b=JbrI8WlhrmdS00zVdekM7XVcHIM0Cx1MOhBalfDyhlqHfdAVzUnZVITeZjEM+WMvovHQPXfofAPlyI9EFyB1v22Nw5DVqjSeBaSkuIpZAFAU4idqVZXZ0SlQulkwf5GSc052vTvGGAK6hC8KgGpIkRy9+WavjVRhgg7fj3Ef3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207535; c=relaxed/simple;
	bh=W5JALzTWFLfur+VIJoH5xyWQGn0wGA/oEmUYZK6HY8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1fq3pOtsuR70rC5VsllAyctZBATJtWwu/rf+3Us0qq684Jg7qcgjTDhChon+Gv1w+JtFWL8zzQGwYO451NIftoMdi58CZ/oeseXFRsYLjlb75950ASLNImAdGdx72OpuZ5ejVEpIc2lJJv2LQ0jIqhf3ncG4wFHZYWLSXjVLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jciUDJHE; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jciUDJHE"
Message-ID: <18a7fe5f-427e-44b8-9e88-b82591e1d2b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779207521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5JALzTWFLfur+VIJoH5xyWQGn0wGA/oEmUYZK6HY8Y=;
	b=jciUDJHENmNGcdL4IosgcMocdq1vmmuwqTHRTWhgJUnqK/2SIUwOXh33PsjzsiM6M+215Z
	5U5ow42ZFaO40F3iiinmt+4SUG/touglLE19s4kaKELR880mWngECoWUQTqHztNNVnMtlD
	Y3E+/aKB2/MT55clkHcQkXmzos3984k=
Date: Tue, 19 May 2026 09:18:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: make bpf_session_cookie() reference optional
Content-Language: en-GB
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515090631.284426-1-arnd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260515090631.284426-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 2:06 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building without CONFIG_BPF_EVENTS produces a build-time
> warning:
>
> WARN: resolve_btfids: unresolved symbol bpf_session_is_return
>
> The function is actually defined in kernel/trace/bpf_trace.o,
> which is built conditionally based on configuration.
>
> Make the reference to this function conditional as well,
> as is already done in the bpf verifier for other functions.
>
> Fixes: 8fe4dc4f6456 ("bpf: change prototype of bpf_session_{cookie,is_return}")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM exception in subject bpf_session_cookie() should be bpf_session_is_return().

Acked-by: Yonghong Song <yonghong.song@linux.dev>

