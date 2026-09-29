Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197A51123A;
	Tue, 29 Sep 2026 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677743; cv=none; b=MilUNPAXm9fRfr2rleva3x/vXRsve2GQntg3F1u6HPUUN6P+9p+MYYJhyelV2pBFhc6tHPsoT1aocnLcRh0V3omIl/356wgOOawxMr4nrIQiVIqnmyAZqHmNTybsNg92Hk0LnX8ncOQ85MixE/i7xhMStlBQ6KLPiJzJ6z/djc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677743; c=relaxed/simple;
	bh=BHYNrO8QQj88KS/+WIZ4V9qEvETlrOQ5N7+RYQMkciU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q06uxsVYHeMuTT+Ig7+MQ9jCpN3m2f+ZDd5JsaPqAAgr/OerBXWx5nqMFKgT//MXlXAX9V6UiaYO/H8jaCtlWY97KZY2WvG9jaTt7Wym4bWr97an/raK6d86Ni2KrUGXbWmNBI2amZKGs9TdGhWEwVfXIe90aRVL2qwYtLr9rTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAg1JuKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAg1JuKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517CE1F00898;
	Tue, 29 Sep 2026 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790677736;
	bh=o/enivjbuzdBYTIELdw3QQ5GvFfjNgBfSjbfhZAZT2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CAg1JuKvEEGQC0loGdc0YlQd+MsvjcPVdcfJ5QtYzodzBwil/CKu6jT4ZG5eE6ymn
	 jWl2fVF9oOUz1vAKhPoibdcSKkfmyq0AxfWf6Zvl8NyQ/NA2o6UEPMC3/zq1k83+71
	 goRniisiWAtTZ+LS41ujRnD4pJYYg+TC902VdHyz/oo3YP2dA08AXvpFw//Q/hjQKN
	 w+88l7iq/i5j72BoXWnGDj0Uch7u9QnqnBF6ROb6H7eaR1sJtmeStAEfr1hgyvpoeg
	 Z+FfjAHYvGAuTSJZyCqH2Iaa1f9n2feyrLWVI+XHP3PAXZpzj7sj+tA0QnHH6Liy7v
	 7WGQ5S1w+eTyg==
Message-ID: <0e477c5d-4fa2-464d-bbf0-853804fa07f9@kernel.org>
Date: Tue, 29 Sep 2026 11:28:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpftool: Reset map info before each query in
 show and dump loops
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, skokovmaksimevg@gmail.com
References: <cover.1790615923.git.hi@tychen.cc>
 <14f8779c59411e88bc320f1064a94aa580ca5be8.1790615923.git.hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <14f8779c59411e88bc320f1064a94aa580ca5be8.1790615923.git.hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-29 02:13 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> The kernel copies bpf_map_info from userspace and only fills in the BTF
> fields when a map has BTF. Reusing the structure for a later map without
> BTF therefore retains the preceding map's BTF IDs.
> 
> Clear the structure and restore its length before each query in map
> listing, named-map listing, BTF detection and dumping. This prevents
> reporting stale BTF IDs, choosing BTF output for mixed map selections,
> and formatting a map with another map's key and value types.
> 
> Reported-by: Quentin Monnet <qmo@kernel.org>
> Link: https://lore.kernel.org/r/3acbe829-06f0-4df4-b57c-a8c7b802ec96@kernel.org
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>


Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Fixes: 99f9863a0c45 ("bpftool: Match maps by name")

Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks for this.
