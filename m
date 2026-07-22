Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A7471275
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705716; cv=none; b=gDlx8XcvTloksWe663q0cYhdlDBIQo3o6FwyZSDdLSAYe4VLKuZq+kHMo/LqTvjgU53WGSPSNHKEhy895jtyuqBjShlI+ioeO0GNqaCV47vQ3S+W00mn9L0KuFVF26y9jRQ0JFP2C029+djQ2JGxIUk50/UmFzJL8sp/NPCSPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705716; c=relaxed/simple;
	bh=HS94+7BkuchokP+U79cpTLhw+IeVl6zPDJwVtQtEuIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R88DpaGxIJ+BbtOMS1aw0B6pw/gK55jE/kZXF0hrRbns+Ob70Al6aX1HJo6K+B06dII0f9XnSZ6PY1NBFVy0Qv/SZIq4JW3rqMFA+GgFwNtZASr9JLBVFKHqd8qTevjncYe+fuuqgWzKk+Tvcxhl3xScyf96OkSse6EhmArPufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h4mGj1ymVzKHMTG
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:34:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9924F4056B
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:35:04 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgD3KVuncmBqPgeJCA--.21322S2;
	Wed, 22 Jul 2026 15:35:04 +0800 (CST)
Message-ID: <e69927a3-a2b0-4a70-bce6-b7cbbd3c8d89@huaweicloud.com>
Date: Wed, 22 Jul 2026 15:35:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] e1000e: Fix out-of-bounds MMIO access by
 validating BAR0 size
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260720133049.1289167-1-pulehui@huaweicloud.com>
 <20260720135218.92EE61F00A3D@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260720135218.92EE61F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3KVuncmBqPgeJCA--.21322S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5Gw43Cw18ZF1xuw1UAwb_yoW8tw4xpa
	95Ga4Y9rn5tr45W34DX3WUWFn8Cw48t343WF45Aw1a9F1YkFy8CF47K3yjgry7A398Cw10
	vr10vas3Aas8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/20 21:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The driver unconditionally maps BAR0 with `ioremap()`, without verifying that BAR0 is an `IORESOURCE_MEM` region. A spoofed PCI device could expose BAR0 as an I/O region, which could bypass the new length check on some architectures and lead to `ioremap()` being called on an I/O port address.
> --
> 
> --- Patch [1]: [PATCH net v2] e1000e: Fix out-of-bounds MMIO access by validating BAR0 size ---
> commit 939eee77005bb32587689d8e06aa2cec8c38f7e9
> Author: Pu Lehui <pulehui@huawei.com>
> 
> e1000e: Fix out-of-bounds MMIO access by validating BAR0 size
> 
> This commit fixes an out-of-bounds MMIO access in the e1000e driver
> by ensuring the length of BAR0 is at least 64K before performing ioremap.
> 
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 844f31ab37ad4..46e58e926f7b4 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> 
> [ ... ]
> 
>> @@ -7450,6 +7450,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   	mmio_len = pci_resource_len(pdev, 0);
>>   
>>   	err = -EIO;
>> +	if (mmio_len < E1000_MMIO_LEN_MIN) {
>> +		dev_err(&pdev->dev, "MMIO len is too small\n");
>> +		goto err_ioremap;
>> +	}
>> +
>>   	adapter->hw.hw_addr = ioremap(mmio_start, mmio_len);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is it possible for ioremap()
> to be called on an I/O port region here?
> 
> Earlier in e1000_probe(), pci_select_bars() filters out non-memory BARs. If
> a device is bound via sysfs and exposes BAR0 as an IORESOURCE_IO region
> instead of IORESOURCE_MEM, the driver fails to request the region but still
> unconditionally passes mmio_start to ioremap() at this location.
> 
> Could this cause a kernel panic on architectures where I/O space is distinct
> from memory space when the returned address is subsequently dereferenced?

make sense to me, but this is a pre-existing issue, will send new patch 
to fix this.

> 
>>   	if (!adapter->hw.hw_addr)
>>   		goto err_ioremap;
> 

