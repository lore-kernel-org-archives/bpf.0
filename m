Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBC3BFAF7;
	Thu, 30 Jul 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403763; cv=none; b=FRK+OejB8CZoXrPkpMzGRxK013VPPyoaZ/pC8xNCktuT4nZS7MCbo3Nk+1QVliXgUe4R9R4NIBz+SEnEjza45uwF0qek5vIJ0hU19ZvNfWAJJsiMi4VPj7h7wIXMMCZbJEWlkIs6ZWOgtntNWmud5Rbss7LhuUO1yjCVo45yR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403763; c=relaxed/simple;
	bh=cuzr1zU2kJE0gmvpnAT9aOwfYmZscBcmh5BntwzuJl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KzlmVwB6t8R6Wg//wj8lZ5weaLQ8p6seuapwUAMz3Yi5ToXOFEY9mZmAY7wyaLN9hT64EjjNz+JCL2YpFNMV4PtHEInpIWZT5O9cHELRywwRykPMUlqYykrbUreD83vYWuTsnpkvA+a8BKGTHSjLfW3uHfpguo2MxgPOzOnZ9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Z7rNdcLM; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Z7rNdcLM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q7eGxWeUTOOWWJ0HG9Gthaq9w4AqF6dQ7edb4y0jU48=;
	b=Z7rNdcLMVGFYz0ySL4KoOEr1jDgppBZMawlU60R2i3a8jS4Q7sTMJHCH80NPYkKLpglHC+DeB
	tk95OnRThOzqtQ2bcWcTzOBwM8Sfvsxkm60reFdGzE+MgBIAIB9u0rXkH7+aTEGg5fuy1A/Hil3
	BHeipydL41S+yga6NWpLEEg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4h9kDc0bMnzmVWf;
	Thu, 30 Jul 2026 17:19:44 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id DA3734055B;
	Thu, 30 Jul 2026 17:29:11 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 30 Jul
 2026 17:29:10 +0800
Message-ID: <1161edc0-0dca-4317-96cb-9f14bba4a58f@huawei.com>
Date: Thu, 30 Jul 2026 17:29:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/6] riscv, bpf: Remove BPF exceptions from
 denylist
Content-Language: en-US
To: Varun R Mallya <varunrmallya@gmail.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>, <bjorn@kernel.org>
CC: <alex@ghiti.fr>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<puranjay@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260722140015.1982158-1-varunrmallya@gmail.com>
 <20260722140015.1982158-7-varunrmallya@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260722140015.1982158-7-varunrmallya@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/7/22 22:00, Varun R Mallya wrote:
> This patch removes BPF exceptions from riscv64 denylist on
> BPF selftests since support for exceptions has been added now.
> Also, since the file is empty, delete the file.
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>   tools/testing/selftests/bpf/DENYLIST.riscv64 | 2 --
>   1 file changed, 2 deletions(-)
>   delete mode 100644 tools/testing/selftests/bpf/DENYLIST.riscv64
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing/selftests/bpf/DENYLIST.riscv64
> deleted file mode 100644
> index ca1beae7fe8f..000000000000
> --- a/tools/testing/selftests/bpf/DENYLIST.riscv64
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -# riscv64 deny list for BPF CI and local vmtest

let's keep this file with the above comment.

> -exceptions					# JIT does not support exceptions
