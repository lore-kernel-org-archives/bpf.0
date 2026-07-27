Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6753238D27;
	Mon, 27 Jul 2026 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124751; cv=none; b=dbBiTpFqahmMyNMjtqXRVyY/FveJhcsLMktIlpqr0ii3xm+KyFs1FQvkb9dqG4ROeYPYCKvfSyAeyef5V+hSXT5QOknHybL4LCbk4uqgXqsa1AiYkICMILdP3xpQwg3ZXZFQ1vW++A5hLfbgqAIFr61145tGmJ0wLhnix2pfGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124751; c=relaxed/simple;
	bh=ryRwgBrtSpTg8u/QZ9KC5rA1B4QmqSolpA0CibTf8hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pt9M5LNm/vp5ep30OC6pmkFhaUOxi0M6jZaMt9FFHj8jLTzHxy5kV97T+lPwCa87yca+3OQ3JUP2Vf8fysTOiYapoWudCzbLWtk2iUvCTnCOMv4CZllGb342AnyyJSfiW5sV5o5yhGCXpAIYa2XsB/OdV9t1ovhLKu51N/Y5Q1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lLFmIhob; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lLFmIhob"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SD7rtE56Rqk7oX43V0lx/2SzdS1pIdg2oQ8fjQSCfl4=;
	b=lLFmIhobiMD5Dk0CIfL8uanNhok14EidMTIiJzGxvVlIKO2rIx2DrSdWOSKRBNHYCT3CBOnLY
	E0UhLKpO0p/YpEZ7dYe5eVtbQ172I7WFoBe0f1qRQ1Obk0wsEXDSfX4LhNX1qe4ZHaS10HyllPO
	VvRRIbPPOxQMpV4Sb+d6HYQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h7l313xQFzRhSd;
	Mon, 27 Jul 2026 11:49:33 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id F1E6340537;
	Mon, 27 Jul 2026 11:58:57 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 27 Jul
 2026 11:58:57 +0800
Message-ID: <7065c701-c78c-4694-8b0c-aa029038cd76@huawei.com>
Date: Mon, 27 Jul 2026 11:58:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: roll back stream capacity when
 allocation fails
Content-Language: en-US
To: Jianlin Shi <shijianlin11@foxmail.com>, <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<memxor@gmail.com>, <linux-kernel@vger.kernel.org>
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
 <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/20 13:13, Jianlin Shi wrote:
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
> v2:
> - Retarget to bpf-next as suggested by Pu Lehui.
> 
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


Reviewed-by: Pu Lehui <pulehui@huawei.com>
