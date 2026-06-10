Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD1388E66
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122471; cv=none; b=RZSK8MlUUZZa+oa7ogutFFipbDFoaMIYJ17XTElEvrsXj23tOjiy2ZrkLh3GslnSb/SBCYIzTdsbeGbmbSJuQTt/29NsAgm9wtBjyjN9oQTU+Ljk0tj8KvdK7s7eAFtWxCatd9yDeEhF60FDDex3SOdWhXNa9F6NELmipZI9sBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122471; c=relaxed/simple;
	bh=+fSNKhc/v+V78FCybaRRV49TM9c7JYGFoTS6dyczZWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqeodeOx/5krM/GCt2qPhvX9uNk/Qi5IiQ13Eyxx3A5Q9jyur5svoVr5rtkaDaclNd03FYoiLj4aRMJ61tcpuLxLME7uVrEVc4p5punH4yVW1YkmAt9S698sWNk9OEeOMsRBwfSk9VLr8CotKN1Iyl3wte8HbNT3ZS1IrbwIEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2ASOEZX; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2ASOEZX"
Message-ID: <dc831f88-1477-4dcc-9ccd-febea540d725@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781122465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fSNKhc/v+V78FCybaRRV49TM9c7JYGFoTS6dyczZWE=;
	b=r2ASOEZXw/BqgiaYYdIWOE0z0lcjQI6r/9S/jWhkuIINGsG8xuLdtzdkPF7/GK8TMXOdeC
	cApSH7VKDIjV2UHN/+jFeFgeBoTE7jyLPN78B1m2tOdjHIl8RDjUz2FGrnaHQcW0L8bipo
	dwAgHsezJHoQ8z5nXFbfsj74COmzeJw=
Date: Wed, 10 Jun 2026 13:14:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Tighten cgroup storage cookie checks
 for prog arrays
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: malin89@huawei.com, ast@kernel.org
References: <20260610105539.705887-1-daniel@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260610105539.705887-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/10/26 3:55 AM, Daniel Borkmann wrote:
> The fix in commit abad3d0bad72 ("bpf: Fix oob access in cgroup local
> storage") is still incomplete. The prog-array compatibility check
> treats a program with no cgroup storage as compatible with any stored
> storage cookie. This allows a storage-less program to bridge a tail
> call chain between an entry program and a storage-using callee even
> though cgroup local storage at runtime still follows the caller's
> context, that is, A -> B(no storage) -> C(storage) path.
>
> Requiring exact cookie equality would break the legitimate case of a
> storage-less leaf program being tail called from a storage-using one.
> Instead, only accept a zero storage cookie if the program cannot
> perform tail calls itself. This keeps A -> B(no storage) working
> while rejecting the A -> B(no storage) -> C(storage) bridge.
>
> Fixes: abad3d0bad72 ("bpf: Fix oob access in cgroup local storage")
> Reported-by: Lin Ma <malin89@huawei.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

