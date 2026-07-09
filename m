Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F81607A4
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567020; cv=none; b=orV0b4kuTWfBq7Xv3lFTjzFbg2dOgtz9VkaIf5Wwawth6XOLZ8W8+0STS5jZT726AS5InJpyki9keixT6G56ARouqXT4tws1DY+stYkN2jsawgqWCYUgWd5R6mjWznLMQJSLD2TDFLnGk+eA21pLSbYHRBe2CtoIlTUK153RNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567020; c=relaxed/simple;
	bh=gbmNOcysCc80qJ0seajEtcPfi6jpKNTKyehDc4Yr+oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gExVc4IPI6ey6UOrArvCEhtFWl7PqitoWVWp22bTTjSUTf6cUKu1f0XxkGe9EqVFrLPzTOG9LeTNTas5vBhQnXIq6bPdWZKbvTaOSNq76xtAkyXQTWkAvEIxZB0EmT8wlRgupQfNI+60h9SoaLY3Dc3jvYg2ErIFg3VbuGsHTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQex0ttx; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQex0ttx"
Message-ID: <b1e6bb7d-8729-4baf-b64a-e514118fef75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783567017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbmNOcysCc80qJ0seajEtcPfi6jpKNTKyehDc4Yr+oQ=;
	b=JQex0ttxEgdAxRQrwkGJlcrWlxnlie8XVn0zgmZ4XKeP+IuvOqYIsBpKd4X9KzZ9WgEHdy
	2PvzQLzhVn06VQku6bwqn9L5o64yHPMNld3kflWLUSNhWeOnab0Ojmx78uXE+t8ZO0NNZ6
	aaANTrP9AypbKDIPsllhqoAXf8DiAuc=
Date: Thu, 9 Jul 2026 11:16:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 07/12] bpf: Reject >8 byte return values on
 return-reading trampoline paths
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201015.2159760-1-yonghong.song@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260708201015.2159760-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/7/26 04:10, Yonghong Song wrote:
> btf_distill_func_proto() builds the function model used for kfunc calls,
> the fentry/fexit/fmod_ret/fsession trampolines and struct_ops. A following
> patch relaxes it to accept a >8 and <=16 byte return value, which for the
> BPF target is passed back in the R0:R2 register pair.


Do you have a plan to add >8 byte return value support for them?

Thanks,
Leon

> [...]
