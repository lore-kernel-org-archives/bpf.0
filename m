Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977DB3E63AD;
	Tue, 14 Apr 2026 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183954; cv=none; b=VVHx0OanypFNSMDWz4p3/jTbhpC8dorN+0Izl8+b1V5OkvMJRWEx2DwcL5RWFiBuKwc9/972TZz8PaOCOWof3kHzNqGP5Z9Y5PEeZ7DZ6T6NTcvoYACuOxe3cPAPha983+6P0QF/iGud0o8UskeiWTejYgGvAeUgaRqcCFscir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183954; c=relaxed/simple;
	bh=Pcyrn7JG3ewn9GNhB9mdBYsssc5Tuw63EIywbgXW9Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oyu96OSrXirrM7ThElFrtoH5KSK23EE9qzJE+9oK82yTi7aj04onnvkrptsmAWSWYHrJgKf3UljgnpVcIYi8cxAG8Sq0EE2cIWteQuhHonYGs4NCJbz7PJ9LkxrLO5zVnZx4XKPh6QzJIbeYsgM+xdG564Ag6TctVtHnWTo+qQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HmEoCYSZ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HmEoCYSZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5ZT/ZSPaEXQkwRPD3ThOEiS+5XNw6fHfC2qpPZBaJuM=; b=HmEoCYSZMK81/wKbu2y/rD7Y/p
	fhVbiCLOR6uiD7WC9ryDJbxlp+jZ33WlkDGBWKlhdHYqp5tEdJkgqBK/yO31fOh663PF9alVGVS/V
	6JvXBWqFEmN+79mNRa5X0RELQ23gG0SrAk/8Srgw/BOu72BhHt4/rS/icqwKWE58BvFHVOg99uXqn
	xBMHRvtD1qvlROlGpiMsoatcew2uu658EPTq6prrBqKHRxjM1R4Z3IGVKWa51i+jhsVnXgxAJ3GVp
	6gSPOiapOhOR0pwwdcsKaXNbCgeBQVgfxVcb8m1rUeTn1QfJvwQoYxSgCk8mrhU1AcifZSycfzod4
	jWQy3ecw==;
Received: from [179.244.2.202] (helo=[192.168.68.133])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wCga4-00FydE-TD; Tue, 14 Apr 2026 18:25:41 +0200
Message-ID: <aa97dc1f-02d2-4da6-aa17-9619e2b6f999@igalia.com>
Date: Tue, 14 Apr 2026 13:25:34 -0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260410124035.297632-1-koike@igalia.com>
 <zeqb2e3d67as3an4u6h6dgvqymchgiyvx2p7mu5u7ns5rx66xf@j5flwnwsud6b>
Content-Language: en-US
From: Helen Koike <koike@igalia.com>
In-Reply-To: <zeqb2e3d67as3an4u6h6dgvqymchgiyvx2p7mu5u7ns5rx66xf@j5flwnwsud6b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shung-Hsi Yu,


Thanks for your reply,

On 4/14/26 5:26 AM, Shung-Hsi Yu wrote:
> Hi Helen,
> 
> On Fri, Apr 10, 2026 at 09:40:27AM -0300, Helen Koike wrote:
> ...
>> This is a follow-up from discussion:
>>    https://lore.kernel.org/all/7fb97184-baaa-4639-a0b9-ac289bf2e54d@igalia.com/
> 
> Base on the original thread, I see that motivation of the patchset came
> from a Syzkaller reported issue[1]. Can you try to run the reproducer
> again and see if you can still get it to reproduce on the bpf-next tree?

I just tested on bpf-next/master ("71b500afd2f7") and I couldn't 
reproduce the issue from Syzbot anymore. It seems that the branch 
causing the issue is pruned now, fixing the error in that case.

But I still get the failures of the kselftests from patch 2/2:

     * verifier_bounds/deduce64_from_32_block_change:FAIL
     * verifier_bounds/deduce64_from_32_block_change_signed:FAIL
     * 
verifier_bounds/deduce64_from_32_block_change_conservative_signed:FAIL
     * verifier_bounds/deduce64_from_32_wrapping_32bit:FAIL


How do you suggest we should proceed?

> I tried it myself, but I somehow can't get the bpf-next kernel to boot
> when KMSAN enabled.
> 
> Given check_cond_jmp_op showed up the the kernel stack of the report,
> I'm guessing it might have be resolved with Paul's "Fix invariant
> violations and improve branch detection" patchset[2].

Thanks for the pointer!

> 
> Side note: were you able to figure out why we get "KMSAN: uninit-value"
> within reg_bounds_sanity_check() in the original Syzkaller report[1]
> with the follow call?
> 
> 	verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s u64=[%#llx, %#llx] "
> 		     "s64=[%#llx, %#llx] u32=[%#x, %#x] s32=[%#x, %#x] var_off=(%#llx, %#llx)",
> 		     ...);

Unfortunately no. I investigated a bit but I didn't continue :(


Thanks,
Helen

> 
> 1: https://syzkaller.appspot.com/bug?id=6f35b4962ae3653e4190d0ff3e30b882ebe86755
> 2: https://lore.kernel.org/bpf/cover.1775142354.git.paul.chaignon@gmail.com/
> 
>> I didn't tag this as v2 since it is a completely different
>> implementation.
>>
>> I did do an implementation[1] without circular range logic, by using
>> if/elses blocks, but it feels I'm always missing a corner case and using
>> circular range logic feels safer.
>>
>> Eduard, I didn't use the exact code you pointed, since it seems it is
>> covered by your RFC, so I used the logic just for this case while your
>> RFC doesn't move forward.
>>
>> Please let me know what you think.
>>
>> [1]
>> https://github.com/helen-fornazier/linux/commits/bpf-min-max-if-else-solution/
>> (3 last commits)
>>
>> Thanks,
>> Helen
> ...

