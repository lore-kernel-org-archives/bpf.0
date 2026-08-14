Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559453624D3
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689721; cv=none; b=DzN8EKxh0e9UPEwaa0LKGd80D7Q+Fy23ite20ZX7+hc7TqKZrYkugin4WtFX4bdsn9rnzXpsMFLpmOcKozOiSDfVjkA8UUrBMBLQM8yvG54AggwsCsFhJMGKkiMvXU7W+LyxtZ8gtpKfKRgpQu4lsxv01qi+shw2a11Y3z1rTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689721; c=relaxed/simple;
	bh=EhU5ntbF5ZVPig3+eai5EYdsEAcnpFxToIveVI0VhOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F9bSDRVeMTfCFGGtgxKSdltESG6/udPy2GsjvvdCNj0zytffO9BB1IFVQAgN2a9QV2eLguGRcy2OZ9m16AaOAOl9XWjkYRX5ZRpSKfmRW4CmEdGk2vNv9I8uGBzhPGSQLp+t6sXmJRTJD6noUG7eYTYng5XhUchNQhfZybzao94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=echo9JD8; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="echo9JD8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Etm1dExoxbg95nSk01fYdACr0XMUzsCauo3cz6sCBFw=;
	b=echo9JD8D/zLWAQFC1rcldtO8pYSA9bYlgUWkxq31fOMRnAL80m9Hc1ByWtP4LgtjDUTPuND8
	N1hgYdr/ipDNjDgq3hfaQ54Z73DZXmag8V9VpcCy031dB3svY7/eIGB67u7+8+8ptDfPeWcMKZD
	7gfEUpz90h64Jshpu96pcs8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hLspB6Pwmz1T4Fq;
	Fri, 14 Aug 2026 14:32:02 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id E985240575;
	Fri, 14 Aug 2026 14:41:55 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 14 Aug
 2026 14:41:55 +0800
Message-ID: <67cf9707-7ca0-41d3-887f-be78b38efd93@huawei.com>
Date: Fri, 14 Aug 2026 14:41:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftest/bpf: make pyperf600 a success again
Content-Language: en-US
To: Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>
CC: <kernel-team@meta.com>
References: <20260813232943.581283-1-andrii@kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260813232943.581283-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/8/14 7:29, Andrii Nakryiko wrote:
> pyperf600 has been running into 8K BPF_COMPLEXITY_LIMIT_JMP_SEQ limitations
> for a long while now, after some internal compiler changes.
> 
> Until BPF verifier is bestowed with scalar evolution logic, make that test
> actually work by doing what would anyone should do in such situations: by
> moving repeatable per-iteration work into independently verified global
> functions.
> 
> `void *` argument is a problem for global funcs, but a static function wrapper
> doing necessary casts and a bit of __arg_nonnull magic dust is all it takes.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/testing/selftests/bpf/progs/pyperf.h | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
> index 86484f07e1d1..fd93a96e5901 100644
> --- a/tools/testing/selftests/bpf/progs/pyperf.h
> +++ b/tools/testing/selftests/bpf/progs/pyperf.h
> @@ -85,9 +85,11 @@ static void *get_thread_state(void *tls_base, PidData *pidData)
>   	return thread_state;
>   }
>   
> -static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
> -					   FrameData *frame, Symbol *symbol)
> +__weak bool __get_frame_data(long frame_ptr_, PidData *pidData __arg_nonnull,
> +			     FrameData *frame __arg_nonnull, Symbol *symbol __arg_nonnull)
>   {
> +	void *frame_ptr = (void *)frame_ptr_;
> +
>   	// read data from PyFrameObject
>   	bpf_probe_read_user(&frame->f_back,
>   			    sizeof(frame->f_back),
> @@ -119,6 +121,12 @@ static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
>   	return true;
>   }
>   
> +static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
> +					   FrameData *frame, Symbol *symbol)
> +{
> +	return __get_frame_data((long)frame_ptr, pidData, frame, symbol);
> +}
> +
>   struct {
>   	__uint(type, BPF_MAP_TYPE_HASH);
>   	__uint(max_entries, 1);

riscv bpf suffers this issue too, happy to see this fix.

feel free to add:

Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Pu Lehui <pulehui@huawei.com> # riscv
