Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEBC42D75E;
	Tue, 11 Aug 2026 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450108; cv=none; b=u1u7UyjtOvkrW8TnAq7eQhLjojKM9+fG35+cQWNOlcPwabmRZiOV4dUc6IhF3gJv4p6+JjZspAVfdq1iMmRgxPxFzNWXLi6WMDqEmSbExtLYgfWST/lDPx3xIr0TCPZ/yWnFbCCc9JYo0TgqZ3mfwNaD8LPHWPeJ06tzhFxle/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450108; c=relaxed/simple;
	bh=nOdG3GEOAIhS+BTOXENo2dxte+PXbMMlKYJCLwWAc2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=up4f2USvJqdN6sZgsNd40maPUQgVQebPh1Y2T0PDEQEMAHK9nohApz+qymjzYHXkT8uDpziidEof9rVubIO4TdIF9g+IMwhloKwSKbNci5vxpDGfxW/TxYkDg8wCa7n4dojH5Qn+5V4pPxCnf5dprpAaarp/muPXJr0vIBGkYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NvcAZYGj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NvcAZYGj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC6991516;
	Tue, 11 Aug 2026 05:08:20 -0700 (PDT)
Received: from [10.57.68.120] (unknown [10.57.68.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46F423F86F;
	Tue, 11 Aug 2026 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786450104; bh=nOdG3GEOAIhS+BTOXENo2dxte+PXbMMlKYJCLwWAc2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NvcAZYGj7W1RZOM8r24q6SdYh94WxBwaTQurPr3Fq1AIq9cH3E/KyBRHkRihM7ZHX
	 7aPsCzJCZc4/29K/f2y6XEPFRlowo5i5AzLzHbK3aIDxtRNnhslfqyugbvVXfhuD1N
	 KA01KCxZcCMbV3UETKlJXggohnqtY6JqIWBmEnLA=
Message-ID: <12843f8d-8c70-477e-904b-ba775eed6345@arm.com>
Date: Tue, 11 Aug 2026 13:08:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
To: Will Deacon <will@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rmikey@meta.com,
 kernel-team@meta.com, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3> <anXqMsJ14r3BAbMG@gmail.com>
 <anYHjvJ1_4dDjuzw@gmail.com> <anm5T9FazACqOWXF@willie-the-truck>
 <2a97f777-d33a-4b3d-8c8c-6f6894f04c29@arm.com>
 <annoxlkkq1NpujsP@willie-the-truck>
 <9b06f274-8db1-48e4-839e-e387c050d328@arm.com>
 <ansIT2PCHq_EKuTE@willie-the-truck>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <ansIT2PCHq_EKuTE@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 12:32, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 05:39:52PM +0100, Vladimir Murzin wrote:
>> On 8/10/26 16:05, Will Deacon wrote:
>>  > So we could probably hack something as you suggest, but maybe the best
>>> option is to take patches 8 and 9 from your FEAT_NMI series? WDYT?
>>>
>> Whatever you prefer, tbh :)
>>
>> Patch 9 codifies my understanding of how things are expected to
>> work. That said, I accept that I could be missing something, hence the
>> RFC tag.
> Those two look fine to me and I already took the preceding changes.
> 
>> In case you decide to take it, we probably need to:
>>
>> - extend the commit message to cover Breno's report (right now, the
>>   commit message makes it look like a refactoring)
>>
>> - add Fixes tags if we want it to be backported
>>
>> Alternatively, I can respin the patch separately with the suggestions
>> above applied - just let me know ;)
> Lemme have a go at picking them up... I'll yell if it all goes horribly
> wrong!
> 

Ready, steady... :D

More than happy to help if those go wrong.

Cheers
Vladimir

> Will
> 

