Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927593BD62A;
	Tue, 31 Mar 2026 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944835; cv=none; b=cGzC9uf9Z+rPQWOzimGI34yEAYGr/9kkaYcLZPqAUfNJOh78CTy1VFsw4s+OCTlI7o3guv+1K9O2vQFF6TaKDTY9kutfUxOg8wGpgVNXixPeg1DdPvo73xlNwF7GWBv5IFTzNE9ZkZvvghGNaL/ahXlG8/7FbOUVaP5JtbmDzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944835; c=relaxed/simple;
	bh=PDei9lStTkyjDGPKBn5DF0hGklXk7Mi/4+2iHx+KxJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYhKw4yBKcV+wnrNfLJrC+mzCZam84NM85swyWjBuWAzadH53X0bzEynUdXtJz9eGT4grsQl0QSB6+MpP4xAWup1ZKVEOeDZq/jwgyVenCaqlgEYqbsLfRlsJyIp8cH+rsn2yjwEwHSA96GPX+aSsJFd5ESLstAOamXBeGJRYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tZFSdCwg; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tZFSdCwg"
Message-ID: <7ba71bf1-e54f-4478-886b-80908e2b3ad2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774944831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDorUtaLxjoCTRoktKgGTyNBupFJr0hjm9fHUn0Ibkk=;
	b=tZFSdCwgPFz45V0Jv7tfAeda6jIJG3pC5l18BcQr6Q9V94ZudKTP5xM6OGLCM9s4i9J7Yw
	0Jl/ENGDzWkdOkXTl4xR8eTgdAbXxJypK00AzAeJiRne7XEyMYmBzQ7lALSi5u6efJBPu0
	QfMtakri4QekCMTyeF/161dRzAqk3G8=
Date: Tue, 31 Mar 2026 16:13:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] selftests/bpf: test access to ringbuf
 position with map pointer
Content-Language: en-US
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 olsajiri@gmail.com
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260331070434.10037-1-dongml2@chinatelecom.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260331070434.10037-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/3/26 15:04, Menglong Dong wrote:
> Add the testing to access the bpf_ringbuf with the map pointer.
> "consumer_pos" and "producer_pos" is accessed in this testing. We reserve
> 128 bytes in the ringbuf to test the producer_pos, which should be
> "128 + BPF_RINGBUF_HDR_SZ".
> 
> It will be helpful if we want to evaluate the usage of the ringbuf in bpf
> prog with the consumer and producer position.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
lgtm,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

[...]

