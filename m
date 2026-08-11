Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060CE3AD528;
	Tue, 11 Aug 2026 02:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416451; cv=none; b=XfV50DNkJfYMSxKSmi5fxdcmmE9HZiMgP6EihOGAAOlE4gqzxxlrm5Medtar1/ZTmyUsrpxWPIDTESDlzX37A/LPoPXz1sl8FajAHipZZzDAR+dN7daeOO0DA3/4L1ClaU+sWmENPJQhEU3a+/skV6EzWyBV+QBXzzrj98gI7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416451; c=relaxed/simple;
	bh=9SofExLnyCVQ1/35Ld+G/CsqkAZzqTfzyBs05ej/COc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WLoeQKPuGa55AoxBsbWJdCqY0R2ibNb63cuBtvNGGkvj8TzmlwLjbINUsnHeEY3tW+BUil8W+0l3gEfdfx/1QfHYBTB0CVlpIgSuRj7DzZNHwkgLy12Y9OaTAxaUaD4I8E0rE4laVayi/jq3CNA1j1bnJhoZKT9a0sijKuWVfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kiavNp3p; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kiavNp3p"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vt0BRkV4HbKu6MTzBCKXcr3c2dk0SxLej6WBuqUWFI4=;
	b=kiavNp3pAAQTTMMwCIEgcQu4bqVDMCGfSc/BEm6IB+XGTh01sLE2PU+FnDB1DYGpJnpUvoXwj
	pFEJlbs83cAO1hjYcXIOHd5bGCgv49AnO/2I+1AaKx0YP3bMpcIUg1Hq7HgsV3q+HkGqYSC5q25
	IxIMddeF6DscykUqOtBpr8A=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hJwkh6mlhzcb0T;
	Tue, 11 Aug 2026 10:37:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id CB16C4057F;
	Tue, 11 Aug 2026 10:47:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Aug 2026 10:47:20 +0800
Message-ID: <77080aa8-7df1-43f0-8c82-1096db05f745@huawei.com>
Date: Tue, 11 Aug 2026 10:47:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
To: Vladimir Murzin <vladimir.murzin@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Breno Leitao <leitao@debian.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <rmikey@meta.com>, <kernel-team@meta.com>, Ada Couprie
 Diaz <ada.coupriediaz@arm.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3> <0c47125b-6a5e-41c9-b31c-d78643cbe6bd@arm.com>
 <7b16d183-86d5-481e-b212-977ad0598ac7@huawei.com>
 <3e5f1532-ea17-4994-8cd0-5ce1d42e9049@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <3e5f1532-ea17-4994-8cd0-5ce1d42e9049@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/8/10 21:04, Vladimir Murzin 写道:
> On 8/10/26 13:44, Jinjie Ruan wrote:
>>> Agreed on the need for a clearer explanation.
>>>
>>> Perhaps local_irq_disable() isn't the right API here, and we should
>>> use local_daif_restore(DAIF_PROCCTX_NOIRQ) instead?
>> The local_irq_disable() here is pair with the local_irq_enable() in
>> preempt_schedule_irq(). So I think it is not correct to replace them
>> separately.
>>
>> The pseudo NMI does not consider how to do local_irq_disable() /enable()
>> when the interrupt is masked by the DAIF.I bit as I reported before.
> 
> Unless I missed anything local_daif_restore(DAIF_PROCCTX_NOIRQ) would
> clear DAIF.{IF} and set PMR to GIC_PRIO_IRQOFF which is the state we

Hi, Vladimir,

Yes, local_daif_restore(DAIF_PROCCTX_NOIRQ) does indeed clear the
DAIF.IF bit and then set the PMR to IRQOFF.

But there is a side effect that will clear the DAIF.{DA} bit. This will
cause `arch_irqentry_exit_need_resched()` to bypass the DAIF check.
Originally, it could not be preempted, but after this fix, it becomes
preemptible.

As the below comment said, If DAIF.{DA} is set, we may be handling an
NMI or debug context, and preemption should not occur.

30 static inline bool arch_irqentry_exit_need_resched(void)
 31 {
 32 >-------/*
 33 >------- * DAIF.DA are cleared at the start of IRQ/FIQ handling, and
when GIC
 34 >------- * priority masking is used the GIC irqchip driver will
clear DAIF.IF
 35 >------- * using gic_arch_enable_irqs() for normal IRQs. If anything
is set in
 36 >------- * DAIF we must have handled an NMI, so skip preemption.
 37 >------- */
 38 >-------if (system_uses_irq_prio_masking() && read_sysreg(daif))
 39 >------->-------return false;

Best regards,
Jinjie

> expect from local_irq_disable() so we can do local_irq_{en,dis}able()
> later on.
> 
> Cheers
> Vladimir
> 

