Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EC33A9F8
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622463; cv=none; b=M/Y9zWXwfhmREf+PxYy/hO0E9Us/2g2iEG+UI/FLOO0EsXgS7qkSuocOdkjomLJQGB5G3UReOES/2o/ZR367Jsf7aY4PksZIN3atgUMAwWTeIgSQixuzr598QleemZEAx4OXDMa1uWYb93VW81yp/N8VY/cfe4aNUfXLfzLcejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622463; c=relaxed/simple;
	bh=GYtH1Xy5T3oE5Rx5NrnYpWpTsAZUmHk+XP4eZBLUCAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmH5aRzo5XL70YQE3YRs3OKk/mqEj0WmCOjXeWpDvoI76LcyOQn7I1S9rU3R/lNMPUHEgbHVLjNgpkpIKh/FxoeU0YypTpxlhHJDuJR2mXCyMhefpeyyy7S2sVrDIFXcIvHRuSuvw9PhVhZG1zKZIijFLaIKmKihdeDzL33cwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rmN1mlIk; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rmN1mlIk"
Message-ID: <8ccf3463-df47-438a-8932-5aeb31749860@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775622450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmPSYmTQOCvBp38jlOX1oOX8MuLtvp/eEvznQjEVDIs=;
	b=rmN1mlIkePNYCR2Y0zZxioJJt8duh0asq1mD3kClhdTHt7XNaQEmG8K3sIode75OeJCXYy
	xwCfZ0NmREaP8JODD9tlO1kyP47JBdsxhog7jSyynopgDYvH2PeVDITcTEW9BZxDnAIjby
	3D3JowO3fbeNHf+X0I4jWnQDniseICE=
Date: Wed, 8 Apr 2026 12:27:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/3] bpf: add the missing fsession
Content-Language: en-US
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260408031416.266229-1-dongml2@chinatelecom.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260408031416.266229-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/4/26 11:14, Menglong Dong wrote:
> Add the missing fsession attach type to the BPF docs, verifier log and
> bpftool.
> 
Acked-by: Leon Hwang <leon.hwang@linux.dev>

[...]

