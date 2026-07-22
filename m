Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6D435EF0
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706690; cv=none; b=XoL3PKoYaI9tv03XW8rJnwZTI77nx9a9JvJiqTh6UWJH84uIXw/xXl/L7do59ZqsMExG06kXRMtp86ugLTqlEZQBmCzZpn0OBFRApjgJnZ/F4t3q3OsdEYKr/O5R/7/zChlMHy/ycTO7mrDzXzArsZ2KP/Z2pcCDSCefrIYDVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706690; c=relaxed/simple;
	bh=3s6WTKFhhSExzluhud8wBq3Zan2Vs3Rk6iSqpY6kVkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U2l80t9azkSjpfTToRkL/0jABY4hYnVlAM0n+azok4YS68NbA4yXptBtbG29NwIrgjsSn0dN7mfAGnKJ4R8Ls6CB9O1onnWSu6PlSuaKdH2DIn9MLx8ZbVxyqq1/vzNUkKjDguoEQ/9rqpSIMb8MY4jKmnEa9XiLnsYIKqCny5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wsNP8KW6; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wsNP8KW6"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i6448xFg9WY+v8Bm0s0sYviAL+voHoV55VQG6KMWMws=;
	b=wsNP8KW6Dr5mr3C9M4GlhXszBbfVJMbhktLF83f0f6SPfH+K0XGc/E53oFS4sX0aWM9ekBVXi
	8ODHJ14qyoLw1dN4XEiZmpZcgkHJNbOHnCXPB5p5nqZHa4+IiZDyUQEUjv/rgNVfmwdtS+fVW/8
	TIrHMXdS/XVUDSTUAOnp5is=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h4mRJ4DDbz12LDl;
	Wed, 22 Jul 2026 15:41:48 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 7382840538;
	Wed, 22 Jul 2026 15:51:22 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Jul
 2026 15:51:22 +0800
Message-ID: <b47d9d56-6d37-4d67-b636-0c6fdf283598@huawei.com>
Date: Wed, 22 Jul 2026 15:51:21 +0800
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
To: <sashiko-reviews@lists.linux.dev>, Pu Lehui <pulehui@huaweicloud.com>
CC: <bpf@vger.kernel.org>
References: <20260720133049.1289167-1-pulehui@huaweicloud.com>
 <20260720135218.92EE61F00A3D@smtp.kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260720135218.92EE61F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)

sorry for the noise, did not update the send patch script, it should not 
be showed in bpf list.

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
> 
>>   	if (!adapter->hw.hw_addr)
>>   		goto err_ioremap;
> 
