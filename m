Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E247A26D4DD;
	Tue, 14 Jul 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018209; cv=none; b=eXdJ2JyEh/uf1K4wUpZbu2XYSvA82Wx4eQvSB0OokvlwpDOk4JbMSYjyEkuSejg09ZoaZqEEduSCIGzMIoCdoEKtFxdQ7z+At6KTLx7nulGRsy465iEw1y8NJS9SdAMhDuRTFCbXgzOwamsrlc36HyWtIMOCiDx7RGE+3mBV7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018209; c=relaxed/simple;
	bh=cd02hRfy7CDID2xulHabqNEjjsM92E+wreWI8wpajcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QLWDTv8VvVfNq0FrM4btDPE1b6Rjw+dASNIiN0YeW5K7fVxp+x9mPTyFrrFmKHZwnDZuG92HXDXSzDUUoOcDE3Qeya+e4iM7bG4g5A848d3XUuzHXh0exANlk7f+onlZFv6WPz8DbPSa6V2Hqyf5zRTZqpCbrjv4+Yd8tuJHoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=P9q7p7vy; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="P9q7p7vy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jPsxZhMfITfueN/hpBnVpqgcXha6+F5s7d28cd95pKc=;
	b=P9q7p7vyO9mEURy+K4XfvD4kkJ+5EnUIA+105Gchqyg+5Q6ruDlP8rPBY9q7WLYmJbMQ5WtKa
	IW4YQ4p1oaqSL+QuMidWudUxuiOCbbYrIGvuUDvEllHLcGsf6QJLFvGfRXMbuuu8cyFeP4GiwJp
	GtDmIXYLIRS554jrhyo5ARg=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gzsqM5SGBzLlTk;
	Tue, 14 Jul 2026 16:27:11 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 79FB14057C;
	Tue, 14 Jul 2026 16:36:29 +0800 (CST)
Received: from kwepemq500003.china.huawei.com (7.202.195.117) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 16:36:29 +0800
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemq500003.china.huawei.com (7.202.195.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jul 2026 16:36:28 +0800
Message-ID: <c44596e9-ae27-4941-9407-a950d6280076@huawei.com>
Date: Tue, 14 Jul 2026 16:36:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: bpf: document BPF_RB_OVERWRITE_POS in
 bpf_ringbuf_query
Content-Language: en-US
To: Jianlin Shi <shijianlin11@foxmail.com>, <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260713013856.1743009-1-shijianlin11@foxmail.com>
 <tencent_22134645443B75ED907D2A85A47AD554A709@qq.com>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <tencent_22134645443B75ED907D2A85A47AD554A709@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500003.china.huawei.com (7.202.195.117)

On 7/13/2026 10:49 AM, Jianlin Shi wrote:
> BPF_RB_OVERWRITE_POS is supported by bpf_ringbuf_query() but was missing
> from the helper documentation. Add it to the flags list in both the
> kernel UAPI header and its tools/ mirror.
> 
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
> ---
>   include/uapi/linux/bpf.h       | 1 +
>   tools/include/uapi/linux/bpf.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c8d400b76..fe2873f6c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4664,6 +4664,7 @@ union bpf_attr {
>    *		* **BPF_RB_RING_SIZE**: The size of ring buffer.
>    *		* **BPF_RB_CONS_POS**: Consumer position (can wrap around).
>    *		* **BPF_RB_PROD_POS**: Producer(s) position (can wrap around).
> + *		* **BPF_RB_OVERWRITE_POS**: Overwrite position (can wrap around).
>    *
>    *		Data returned is just a momentary snapshot of actual values
>    *		and could be inaccurate, so this facility should be used to
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 5e38b4887..7b024da3d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4664,6 +4664,7 @@ union bpf_attr {
>    *		* **BPF_RB_RING_SIZE**: The size of ring buffer.
>    *		* **BPF_RB_CONS_POS**: Consumer position (can wrap around).
>    *		* **BPF_RB_PROD_POS**: Producer(s) position (can wrap around).
> + *		* **BPF_RB_OVERWRITE_POS**: Overwrite position (can wrap around).
>    *
>    *		Data returned is just a momentary snapshot of actual values
>    *		and could be inaccurate, so this facility should be used to

Thanks for updating the docs for this!

Acked-by: Xu Kuohai <xukuohai@huawei.com>
