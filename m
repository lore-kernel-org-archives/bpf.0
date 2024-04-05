Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A43161313
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335194; cv=none; b=sSBm9/DVVoLbt061k6vO132tJgj5a3KdNIKWyqMV0OKsy63VVakT/1hdYMo4rwvMQRL7zeoqEGmWFc7SKAswHeYTacrCsdcY/k6aCq51954c8/cVv0RIw+kxJVB/HvRV4/SGIs0/Nw1VSUShF8CTFXlgJ+SONlOj8x+/9FYMK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335194; c=relaxed/simple;
	bh=gDmRqalwtPbYE/IEutBofCfl3KnHCQaTJMOCD64UdR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGefu0wIDYFtUAjbEisDsizKYDCHuikE1iYuQSvcUHD99b/Wae9UEOiy60OAXYrbEM4HeWavWcmxH3/R1jH76buJItLCi+vBp8XwXJrIsNjVvhT8O01i+6Yv1NVqlHXn/tjGL6aH62mv/8ZQmYwe+ISapjHi6KVMmaDiklpuRx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d8Y5VDrQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d8Y5VDrQ"
Message-ID: <c51755cc-2434-4fa3-b245-1fdccf093ecd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712335190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lHyM60ypk5AS+GcsHTS2VW2aSwn2U82ldh/Gy+j2b0=;
	b=d8Y5VDrQNOIg2Sxx86LXtVaBXM7VnYkPottj2ptWx7s/EuQFEBgrxdKY1G9z7JR0AmOn3X
	/72KrSCkiGBd4Ti18OKswzucfrYsGDvC9Itu31nfqt23mQ+YjbZGOcKOjBChkGN91PX0SK
	ljATFvdTmkKgEfv/vzRuBrG9k9bW6jU=
Date: Fri, 5 Apr 2024 09:39:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: add test for
 bpf_for_each_map_elem() with different maps
Content-Language: en-GB
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, xuanzhuo@linux.alibaba.com
References: <20240405025536.18113-1-lulie@linux.alibaba.com>
 <20240405025536.18113-4-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240405025536.18113-4-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/4/24 7:55 PM, Philo Lu wrote:
> A test is added for bpf_for_each_map_elem() with either an arraymap or a
> hashmap.
> $ tools/testing/selftests/bpf/test_progs -t for_each
>   #93/1    for_each/hash_map:OK
>   #93/2    for_each/array_map:OK
>   #93/3    for_each/write_map_key:OK
>   #93/4    for_each/multi_maps:OK
>   #93      for_each:OK
> Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

