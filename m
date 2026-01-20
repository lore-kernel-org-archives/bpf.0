Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2BB295DAC
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949409; cv=none; b=HR12VBQmxPEy81o5Vt1XQKr9KvVj4E9kw6Yuz5tZY8aZDt5g7VnfrAGV2FsLscisk54RdG+OINT+tYTTuMq0qZFVEMbcFh2FK1b3WhvPHQYFUyhR/XRevH6OFd3iE61+aeo0IKzShkp+ZwQtMnJpp4Ihg0s7PstPKT22TftM3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949409; c=relaxed/simple;
	bh=LM9sk3nOl2uI95oAFd1Zai2C7EHFufVzGw4j1WSryVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGrEiiDbxJWDYl5WV2DMr4W3wD9fcUpPG2IY0bLNSAyvAIvIC2XhStAmT74Eb63mKBxCVvUOV/9/sT7xILV4z3vBTcEZhrAEB0uLo/j3Ihk8H70l8FSRxfqjxnE8yKjeq/Y6mHAksdvfbvvQSiVK99Lza9O4L9tbRsPiOsjOHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ziftloo4; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ziftloo4"
Message-ID: <7c3f053b-252b-4389-9327-e2b3f2c67c94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768949401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM9sk3nOl2uI95oAFd1Zai2C7EHFufVzGw4j1WSryVM=;
	b=Ziftloo4POu2IIFeZoTYZdsjzfR0psOkZoIi60+kfpNf6cPUxtLzCBR71ebvnUqtXiFSJC
	0VJVd/lIB1IPHkKkpMCgpI6TqrZAHGpqQiuDH1b+LTtcIFKHG5J89an9yzOQnCQqhl63BF
	CnEqGOm7nGy6VmC5VYF2Ezu33XvTzj4=
Date: Tue, 20 Jan 2026 14:49:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260120073046.324342-1-dongml2@chinatelecom.cn>
 <20260120073046.324342-2-dongml2@chinatelecom.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260120073046.324342-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/19/26 11:30 PM, Menglong Dong wrote:
> For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported by
> the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> tracepoint, especially for the case that the position of the arguments in
> a tracepoint can change.
>
> The target tracepoint BTF type id is specified during loading time,
> therefore we can get the function argument count from the function
> prototype instead of the stack.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

