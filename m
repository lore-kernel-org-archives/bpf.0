Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C608D42B320
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440677; cv=none; b=FPTHoziV97NBRZ/W5/Ms8xCuNepMVkdWVZ01DI/Qey9LARyZowgM00EMuB68Qd3Wy7jBrPFXCtQvu3LAHGTciEQPWBGx6jkrFK0CvfffMf442rh6URKTm57xuQ3euqg+qobX6jTpkvfuqigg6zU7nj5Ny/VcuY955av+Urh0Z40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440677; c=relaxed/simple;
	bh=vjN382zaD3W3AfZm4S8E60Ezsi7rVCHb6+sxgaIu160=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2OljGCvMZU7zlJvGsUprDly3luh0GlbX5wiQsxQMqmkFryFy9hMlwSggeE8u5Ma/8ALZ2cY8k55Jt0dFS96WwI4NTLsxDV33c4ESO5Lt/moMudUP9RYu18xaglso9BI3GjevGejJIvXAzoL4zKKK0t9u8PdKzjP4ULwH9xCcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kMfAP+ps; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kMfAP+ps"
Message-ID: <e3eabecc-2c7f-4933-81ad-2a51a89da87a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786440671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KITcXi22MZEnWnu4Q+OD0XY/FmQzFgkLflaLpVkQ9WQ=;
	b=kMfAP+psQ3j43S3YTrjhSjiydP48dbmoMC39GiqBDnu19vriCmdE5afmfIVppXjSi2QmOu
	rLZg6L4LDRAdT6cCwaJGz5KuRjHLJwzT5+gw3qY7htIuxL91rA7kvp/bmGf6Y4VFfV7JGM
	rt3hYxWPIAQ4eA4sAxGumfsrZvyWeJY=
Date: Tue, 11 Aug 2026 17:30:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 0/2] bpf: Fix trampoline image UAF on multi
 detach failure
To: Hui Zhu <hui.zhu@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Matt Bobrowski <matt@bobrowski.net>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1786412280.git.zhuhui@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <cover.1786412280.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/8/26 10:46, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> This series fixes a UAF in bpf_trampoline_multi_attach_free() where
> old_image is freed while ftrace still calls into it, and makes
> bpf_trampoline_multi_detach() return void as suggested by Jiri Olsa.
> 
> Patch 1 fixes the UAF.  Patch 2 is an independent cleanup that
> changes the return type to void and drops the WARN_ON_ONCE at the
> call site.


The UAF issue was reported by Sashiko when reviewing "bpf: Add
tracing_multi link support for bpf progs" [1].

The fix and the cleanup look good to me.

Acked-by: Leon Hwang <leon.hwang@linux.dev>

[1]
https://sashiko.dev/#/message/20260809153308.5331D1F000E9%40smtp.kernel.org

> [...]

