Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427518DB37
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228777; cv=none; b=pQ9e+36BCQ59939a6L9xsiTB2E5JdcxRXWWs0dLoKEnUHh1kPaGvzhLvBerBfdsxy+W1gdmzTFutALGDd56MT4KT4n8FPCcMzRAwg4lHxKKSqV/uD5HI4Pjb9o/GGdVzB0/VQw1PWlG+xE1rEW7D5qarI3mOejpr0gdS80lBwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228777; c=relaxed/simple;
	bh=GZ0UcpuJOcPx5YPxn+atGYrFUtoKHi9deJ5A0j3TUwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPgWRMYfnqr0NCIJoJKpK+zt7CZpccRMs6woldiDQm6kVAeGef1CTsFBjQgenU7phZtMng9pRWeZmiAgWYWS4OgigPI7dIL/w87j9N8uP6xUMPpSMT8w8h5rYCUOtyro/fUW+unkVO3wbka0pIDjlb7D1+s6P6pqK4qg12zaz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U+A+3ggD; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U+A+3ggD"
Message-ID: <e8c07a73-afb9-4c84-b88b-ed70c643d163@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782228773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLQ4lHT6ck+XZfc8jk5ktioummZdbe29IPwbqOQZ0ck=;
	b=U+A+3ggDitwTbISZDMYKy7Dlig6NTGYTAFiNV8yNpWT+jkXyt5Mtl8IRWW6bDV33Y52+Fw
	TrBQ8G0z1jdMu4RniteYR9aHPxeBDntA2PpCJQjzOFkpq7oPn1tqWKeWDnGNk+2tKbLgvF
	EygzBW1eq58m/0aQ8YX0A5HZL2lTork=
Date: Tue, 23 Jun 2026 23:32:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bpf-next 1/3] bpf: Add tracing_multi link info support
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>
References: <20260623142417.275892-1-jolsa@kernel.org>
 <20260623142417.275892-2-jolsa@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260623142417.275892-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/6/23 22:24, Jiri Olsa wrote:
> Adding BPF_OBJ_GET_INFO_BY_FD support for tracing_multi links.
> 
> We expose following tracing_multi link data:
> - attach_type of the program
> - number of ids
> - array of BTF ids
> - array of its related kernel addresses
> - array of cookies
> 
> The change follows the kprobe_multi and uprobe_multi link-info convention
> of optional output arrays with an in/out count,
> 
> On top of standard tracing link data we also expose addresses, because they
> are useful info for user (especially when the attachment was done via pattern).
> This data is hidden when kallsyms does not allow exposing kernel pointer values.
> 
> Assisted-by: Codex:GPT-5
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
lgtm,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

