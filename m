Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECDC39BFEF;
	Mon, 20 Jul 2026 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518860; cv=none; b=CsMMitTx9YvBh3lyWyPz8JPkSLJTWgfy8n5OHCPg3Dv7j/DdTXKXDXbqv12U8fArSBUD7p3S7u/7aRdiGFfbQnKF9sxSoLZGNx9D2k6Zoym80DgqW3uZVNJSoqVQPpx1pYGlo6jVesAq0WcMpbV3c6YV6zg6qZAM5KXaHsVOUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518860; c=relaxed/simple;
	bh=M8w3kvYuRSdv0EKawq5Ux1KBlw8ASIqf1trDVKNNunE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qolZJoFSGuvCqgY9s8rx8cpoCCO23z+wQZb6bgyAx7pSof404mSbaQ/qN6DRucXysORUDzDrisGvRz4Z6zZMBv/kLSsKsQEuY+tfiw/wvVEqtN3/ciJvRjlYzoWMXeaNWwCsNlI0ZFcDUNBpnOJsM5sjpVvGQgridElWrIAy+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BDBGjX79; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BDBGjX79"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vmHyB7sEL48iocPNlmpy5NRjKTvUJqdc90idg85Zf4A=;
	b=BDBGjX79SDi4Z0/REPZXT5tf3AkQjoZajXy7gCWbFBimJXekM7O90UGVv9sXOGE68nUstN3a9
	gXyWnjEN54UpB7ZwhzAXAsPlOaARwVK25A+o/kp2XVk90gxJTjs9bQHMIl1TmiFoHdGB7d2eCm2
	iJptl7Q/9J0c1G7gThJuu8Q=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h3Qz45ZFMznTwN;
	Mon, 20 Jul 2026 11:31:12 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E34240572;
	Mon, 20 Jul 2026 11:40:45 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 20 Jul
 2026 11:40:44 +0800
Message-ID: <734259ce-a3e6-495e-9c88-24ab23e781bd@huawei.com>
Date: Mon, 20 Jul 2026 11:40:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: roll back stream capacity when allocation fails
Content-Language: en-US
To: Jianlin Shi <shijianlin11@foxmail.com>, <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<memxor@gmail.com>, <linux-kernel@vger.kernel.org>
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/20 9:23, Jianlin Shi wrote:
> bpf_stream_push_str() accounts the string length before allocating a
> stream element. If the allocation fails, the length remains charged even
> though no element is queued and therefore cannot be released by a reader.
> Repeated failures can exhaust the stream capacity permanently until the
> BPF program is freed.
> 
> Roll back the capacity charge when creating the stream element fails.
> 
> Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
> ---
>   kernel/bpf/stream.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index be9ce98e9..4b8a74b91 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -79,7 +79,14 @@ static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int l
>   {
>   	int ret = bpf_stream_consume_capacity(stream, len);
>   
> -	return ret ?: __bpf_stream_push_str(&stream->log, str, len);
> +	if (ret)
> +		return ret;
> +
> +	ret = __bpf_stream_push_str(&stream->log, str, len);
> +	if (ret)
> +		atomic_sub(len, &stream->capacity);
> +
> +	return ret;
>   }
>   
>   static struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, struct bpf_prog_aux *aux)

looks good to me, but it might be better to target bpf-next, as this 
isn't a critical issue.
