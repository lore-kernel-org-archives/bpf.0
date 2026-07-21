Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48321449B32;
	Tue, 21 Jul 2026 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599583; cv=none; b=kruPRJ2cYIAatRQfIqGABQfBEMXg+4ZvAXSQLwhDL8gwAgbLWZ9UE9Y0q+oBzRMDsMsM+7R1FhyXZAliQIqZzxY9entHtF4NVLdULng0ili/ErpW6eqe7O0nOPuLIAhUi+B+4U1YbwyMVGl5Y7nHpOPz4TJQLHsizI6pDefUqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599583; c=relaxed/simple;
	bh=0DXo3Hihyz4FIzmty2pQ86l4BcGXDvyr8RypYC9PwUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trhjud3ZqvWj14yRMGlyjRnnnJlEq2TGql9YH3EeEPLNtB1x0qs4Y2uC4BtS9a3WEYdfBUyNsGGNXpqwKo1aQMepUzXrryJmC7wdGO3FOBu11uzwFgpEst3Wo9Z+xluzs+qMli1sZtFt/HKnkPN5QzhczLHfRax9Caeqos0t1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h411k5YJ7zKHMTv;
	Tue, 21 Jul 2026 10:05:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 164BC4058D;
	Tue, 21 Jul 2026 10:06:12 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDH9lcS1F5qCcDzBw--.34514S2;
	Tue, 21 Jul 2026 10:06:11 +0800 (CST)
Message-ID: <933d745d-712a-4d49-982f-414ccfd69e47@huaweicloud.com>
Date: Tue, 21 Jul 2026 10:06:10 +0800
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeff Garzik <jeff@garzik.org>, Auke Kok <auke-jan.h.kok@intel.com>,
 Breno Leitao <leitao@debian.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pu Lehui <pulehui@huawei.com>
References: <20260720133049.1289167-1-pulehui@huaweicloud.com>
 <d86c6b6a-fa9a-4429-b004-8c54b2232797@lunn.ch>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <d86c6b6a-fa9a-4429-b004-8c54b2232797@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH9lcS1F5qCcDzBw--.34514S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry7Ar1rKrWxKF4rWrWDtwb_yoW8GF13pa
	yvga4Y9w10vFsFga1fZr1DXF93Ga43t3yDKr13trs8uFn8Zw4fJr47GFW5XrnrX397try8
	tr4qgw4fCrs8J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/20 22:52, Andrew Lunn wrote:
>> --- a/drivers/net/ethernet/intel/e1000e/regs.h
>> +++ b/drivers/net/ethernet/intel/e1000e/regs.h
>> @@ -242,4 +242,7 @@
>>   /* PHY registers */
>>   #define I82579_DFT_CTRL	PHY_REG(769, 20)
>>   
>> +/* Smallest BAR0 that covers every register the driver accesses */
>> +#define E1000_MMIO_LEN_MIN	0x10000
> 
> I commented on the previous version. Is I82579_DFT_CTRL the highest
> register? Can E1000_MMIO_LEN_MIN defines based on that?
> 
> 	  Andrew

Hi Andrew,

Thanks for reviewing this! And yeah, I caught your comment on the 
previous version.

I did the math on I82579_DFT_CTRL, and it comes out to 0x6034, so it's 
actually not the highest one. And the registers in regs.h aren't really 
sorted by address anyway.

The highest static address is E1000_SYSSTMPH(0x0B64C)
The highest dynamic address is E1000_TXDCTL(_n), as it define bellow:

#define E1000_TXDCTL(_n) ((_n) < 4 ? (0x03828 + ((_n) * 0x100)) : \
                          (0x0E028 + ((_n) * 0x40)))

But since the maximum _n we use in the e1000e driver is just 1, that 
address maxes out at only 0x3928.

So, since E1000_SYSSTMPH is the highest register offset the driver 
actually accesses, how about we just define E1000_MMIO_LEN_MIN based on 
that? Something like:

/* Smallest BAR0 that covers every register the driver accesses */
#define E1000_MMIO_LEN_MIN	E1000_SYSSTMPH

Thanks,
Lehui

