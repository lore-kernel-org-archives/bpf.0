Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10018B66F
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710220961; cv=none; b=uAnHwUmv6+RU+4lG++5bbpnuj5PRLXuFsvCQa2HnE8idWtnwZmIB8eak6Z6r6Qvn8eKMEtYo9GQwrbS/msoi86YQWAY0RFHspTi6IVqRi38feI4klRxjNyeRFZlJDyOCcnXc3NTg2BsL601ljvRLenMEFY7MBWOlI6zUVR/OurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710220961; c=relaxed/simple;
	bh=p4n3YQ6J6UJeDsNQLm6P/mvpUVDSxZiMpIpUrWivEMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4Q5ZxCN03w8GU9cxxNi/Ct7d6ee5baptMGtJwNTX0mb1DvCNN2PKBsGr6p46+VjoqwVRzbfN+D6gJtowjYGrz8rBY+vxY5WL/yfNuVSp2OvAmY56sds9ZTu+25AspYf5u+sOJioeC/ZSJkCZCb9yMbEAHKoPTQutn48Z/TyE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=btndt4km; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="btndt4km"
Message-ID: <2c0512f4-6bbc-459c-b6e6-7319d59595a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710220957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4n3YQ6J6UJeDsNQLm6P/mvpUVDSxZiMpIpUrWivEMo=;
	b=btndt4km7XcCbBPyh7EKPWMQDY/Ztj13ZBdpuAtidnq5QmPFCOEuH07L6QZyL7TU6euycd
	ijG+eTOuIv5m55jpTh2DG++TIsM8AOnvy0ZNRdkSFxtBcnBR3lHaTxXRFANfSk8LpHqXl0
	veto9Cku96A5j7y/eR7p8wfuWpKL+uk=
Date: Mon, 11 Mar 2024 22:22:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpftool: cast pointers for shadow types
 explicitly.
Content-Language: en-GB
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com, yhs@meta.com
References: <20240312013726.1780720-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240312013726.1780720-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/11/24 6:37 PM, Kui-Feng Lee wrote:
> According to a report, skeletons fail to assign shadow pointers when being
> compiled with C++ programs. Unlike C doing implicit casting for void
> pointers, C++ requires an explicit casting.
>
> To support C++, we do explicit casting for each shadow pointer.
>
> Cc: yhs@meta.com
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

