Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710E36F413;
	Tue, 23 Jun 2026 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180835; cv=none; b=gtxV0vYVh1JMucN7jM7UI0aYUK2mtH1fauCzTxBpzqveQYqe2HAG/Wqp6glVNybn+3ZgsB329eG36W/nl/eFLkMgSUzkevnQYCvC/gdoLcS9H0vsQVwmdSNxb7gZPS+8Xj+MFNBvqIsKpPc8tZaW2NWPSJF3qyM6Gefs9nvmZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180835; c=relaxed/simple;
	bh=6N8LU25Gr3jXQ84cltA7ZQw3YCgJkNB+aa+JExVdWxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bfVv+SZZMfkw4hY+Gt1SuhH5p/cFhca+VmG2HT6pQLYLcq8gDWDmsrAprTlnhBolUCoX8DFrTmwlweDn5D9fU0163coexLacPmP74Y5vgPKcOB9+8/TSJpt2rX/kc4NvCTi9yZrfdDH8yY2rdoxjdj2cMUrkc2sLFoy0L/4H1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eeoYL3e0; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eeoYL3e0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3Vb/PnkYOFt85gJn7XLqDp/ZtRTv4hAY9hRhCUGKh4E=;
	b=eeoYL3e0Zu1mP/0OSHxjgDrdU4jVdWeAw7OzSkoccbiHzZNuSraWYKRufOcBtzcBqpqVzpVDY
	3BQWRCe9cJnn/VtDUzKI3wB/hX/2WFoCCZZu+WY4vt/ingytYL6WCvFTLV52P349v073PyrWP+o
	fK0JG+Qv3Y1hNijwrt+8Yd4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gkpLn4jYWzpT05;
	Tue, 23 Jun 2026 10:05:37 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id CB69040569;
	Tue, 23 Jun 2026 10:13:50 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Jun
 2026 10:13:49 +0800
Message-ID: <4a52f4fb-8695-4ef1-a5e4-04d3f2533b9d@huawei.com>
Date: Tue, 23 Jun 2026 10:13:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] riscv, bpf: Remove BPF exceptions from BPF
 CI denylist
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
References: <20260621144259.288135-1-varunrmallya@gmail.com>
 <20260621144259.288135-4-varunrmallya@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260621144259.288135-4-varunrmallya@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/6/21 22:42, Varun R Mallya wrote:
> This patch removes BPF exceptions from riscv64 denylist on
> BPF selftests since support for exceptions has been added now.
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>   tools/testing/selftests/bpf/DENYLIST.riscv64 | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing/selftests/bpf/DENYLIST.riscv64
> index 4fc4dfdde293..9268351ce4c1 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.riscv64
> +++ b/tools/testing/selftests/bpf/DENYLIST.riscv64
> @@ -1,3 +1,2 @@
>   # riscv64 deny list for BPF CI and local vmtest
> -exceptions					# JIT does not support exceptions
>   tailcalls/tailcall_bpf2bpf*			# JIT does not support mixing bpf2bpf and tailcalls

Reviewed-by: Pu Lehui <pulehui@huawei.com>
