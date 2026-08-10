Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311403B95EB;
	Mon, 10 Aug 2026 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366307; cv=none; b=l6kXyrpJHAskV+LFLO9cmoDd5KhubSYE7OTSQty3VPb2fhwYaGrnga47xyEX7rK/c3QcNiVaNySYKoWmGooWbdRHgorEPiuZEz8KR+T4ukDwNQuF4+UnUC7dtiqN6+nzhZOmTXQS5FP8pl5BOEqRLK/F0uOKAt8aTNUbUUXri1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366307; c=relaxed/simple;
	bh=IgVqnSwKTRKhY6Oclu5P6MCZ8FlGZs6/7ymoUYPPo4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eoBpBsJhMfs5Xw4X0zz9o8kTFNJzKOspuTKtyh3cWEu9CkEYS8IX83ANsPGm8sTG5qAyxZKJPpwxnfIlrE2AVHIYzBNOgWowWvOEBTyd816TRMQx+Ce2ObLYmd2UEuPuZkgxtRvv+PmgvWPhFbj1YtP67h6Hazi8a2eTHQgkhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RdObbmdF; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RdObbmdF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=n43/aKJ8eBUxUBD79l6UcJWpeqmmhi7C6KTZf2OBbS8=;
	b=RdObbmdFVKOHTKxX52sYHajGprEIe7f7G201ZRemSi9eiJFBr4OCR9QsXnshR/NBpmdDAAXFJ
	m1z7QSOat5nN9rf1iD9RBNqUThFd8TgKUkLigbuWCbQ8/0lHvFq0l5J1hfD5ngLjAXfLaVa3WnB
	V+iOsFZkRHF1hGrBpELsVU8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hJZ9l6vrhzpT0F;
	Mon, 10 Aug 2026 20:40:59 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D96B2025F;
	Mon, 10 Aug 2026 20:51:40 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Aug 2026 20:51:39 +0800
Message-ID: <61786f30-5827-4785-ae68-febbdf0de900@huawei.com>
Date: Mon, 10 Aug 2026 20:51:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
To: Will Deacon <will@kernel.org>, Breno Leitao <leitao@debian.org>
CC: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <rmikey@meta.com>, <kernel-team@meta.com>, Vladimir
 Murzin <vladimir.murzin@arm.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3> <anXqMsJ14r3BAbMG@gmail.com>
 <anYHjvJ1_4dDjuzw@gmail.com> <anm5T9FazACqOWXF@willie-the-truck>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <anm5T9FazACqOWXF@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/8/10 19:43, Will Deacon 写道:
> On Fri, Aug 07, 2026 at 09:29:12AM -0700, Breno Leitao wrote:
>> On Fri, Aug 07, 2026 at 07:58:21AM -0700, Breno Leitao wrote:
>>> Meanwhile, I will try to ftrace the writes to PMR and regs->pmr to get
>>> a better grasp of the states machine we are in (probably on Monday).
>>
>> It seems LLM found a very easy to reproduce this:
>>
>> 	bash-5.1# dmesg
>>
>> 	bash-5.1#  cd /sys/kernel/tracing
>> 	echo 'r:pmr vfs_read bad=+0($retval):u64' >> kprobe_events
>> 	echo 1 > events/kprobes/pmr/enable
> 
> Nice, that triggers straightforwardly in QEMU for me. The diff below
> (which implements my suggestion from [1]) seems to fix the issue, but
> it would be good to hear feedback from one of the Arm folks.
> 
> Will
> 
> [1] https://lore.kernel.org/all/anXgWRmcjwPKG7N5@willie-the-truck/
> 
> --->8
> 
> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
> index 795b35128467..691ee5f86dbe 100644
> --- a/arch/arm64/include/asm/daifflags.h
> +++ b/arch/arm64/include/asm/daifflags.h
> @@ -132,7 +132,7 @@ static __always_inline void local_daif_inherit(struct pt_regs *regs)
>                 trace_hardirqs_on();
> 
>         if (system_uses_irq_prio_masking())
> -               gic_write_pmr(regs->pmr);
> +               gic_write_pmr(regs->pmr & ~GIC_PRIO_PSR_I_SET);

If the DAIF.I is restored below and the GIC_PRIO_PSR_I_SET in the pmr is
cleared here, it seems to introduce inconsistency with current Pseudo
NMI code.

> 
>         /*
>          * We can't use local_daif_restore(regs->pstate) here as
> 

