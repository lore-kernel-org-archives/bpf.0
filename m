Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C412CD9C
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252658; cv=none; b=BtuyMrTJr2A9R2UwciXOtVrJH49S9bBxB99n3neMwjKYQQeoCndC8+SxUTjh9kMVRct9+XbkDmryGNtcSdJ6ueCHrT9/ovCNsa3I2pwpfi9wj3Hs5/W541rk/rByYkia7LR80bWOuOKKeeYPQXGvxxJWkfJYk+1IZWt2GtcMBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252658; c=relaxed/simple;
	bh=ne8IyFk7/lUGA7fkjtC0yPipEb/1h8MySmrNzt4Yb+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyLSQ3y+OF2yfBX0fh+gW9pazbsbn+D4jAIPNN1rB8+8DVZvUOD72yL/OFYZbXz8hjfA19/V4IXn5PT9j+FtWBOP22f2XAD4gcoqaducRtHeZ7FHivtmaZ+a1KTkeoHK+SQmwLT3ufNzAQJiBo50t2O5+WmAST8p3nt/P7RpKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qbVT8JYO; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qbVT8JYO"
Message-ID: <ed69555b-2afb-4aac-8624-e51b47d537dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712252654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ne8IyFk7/lUGA7fkjtC0yPipEb/1h8MySmrNzt4Yb+o=;
	b=qbVT8JYOfE5s6sMGV0jZotm8TOvSGSKEdA6mFbKWdPkxlhwd2E87q+Z0wNXNb+WFiQAvp1
	bLReF9pfUI2CuIlW0QoJEUOyfloNiupaWYDKDSbyfCxqwBNPDgCeY6phwiLpnB6FrFnik5
	kzVQdesM7z3kP5jD0/VmIJfJ2Boitx8=
Date: Thu, 4 Apr 2024 10:44:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot()
 helper
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, John Fastabend <john.fastabend@gmail.com>
References: <20240404002640.1774210-1-andrii@kernel.org>
 <20240404002640.1774210-3-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240404002640.1774210-3-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/3/24 5:26 PM, Andrii Nakryiko wrote:
> Inline bpf_get_branch_snapshot() helper using architecture-agnostic
> inline BPF code which calls directly into underlying callback of
> perf_snapshot_branch_stack static call. This callback is set early
> during kernel initialization and is never updated or reset, so it's ok
> to fetch actual implementation using static_call_query() and call
> directly into it.
>
> This change eliminates a full function call and saves one LBR entry
> in PERF_SAMPLE_BRANCH_ANY LBR mode.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

