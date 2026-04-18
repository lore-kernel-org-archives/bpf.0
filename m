Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C61C84BC
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538507; cv=none; b=jAIIiPaMc0vmlknKb3c2qweZ6CQbywsTJ11CKIlPkmVPJIGaAgceO+Yf/DFhbFGWqJEciaD04EZfhrbRwFiAd4IPfFkGwRL3Tvg4GITDB81Rtqax/gqe5Clg1mLD9pEiCLxrmMF4SdHAnIoNwSbMKvCGPxpNjax5TZUXnLLBCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538507; c=relaxed/simple;
	bh=4QHOgoGkpnunO6a0KEImpxzaRBERBDYt2Ai8pUfii6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJs/gb7EHgzce1nvHP4ookA+InoAxAlu02Ib1TEWifVg5vT5DjlBXHr9NbqloK4a8XKGxIqVGXaR03iGIr3PpJ+GRrcfTid5tJpYPbaq2kfZhPGCcdYSYFMrxVr2U9N08zLwVEHtZSFUuVDnMtE03F05gyOVIMV1ZinPVAV6Now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZeAtvDj; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZeAtvDj"
Message-ID: <13ac664b-64a5-4dbe-8c56-0956dbd584d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776538502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y4BlyyFkiX4i03Q6rDytIIO1lBPNdX47hjoxReHsGA=;
	b=GZeAtvDjDPUN7915mmudkqPz3EV3uwfnQFCEJQTK7BbjEy4TRl+HPbtjvA/kMiR1T8NuDv
	w/jlvV2XLuOx1SIookuO09h4UbGxwkRltjZdaOPuqKDzCYFt149nOsBKMFCyjPPKIUaC5E
	/q/ShCPCM3dbKyIdDl++Q1o5x6vS+ZI=
Date: Sat, 18 Apr 2026 11:54:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 00/16] bpf: Support stack arguments for BPF
 functions and kfuncs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay12@gmail.com>
References: <20260417034658.2625353-1-yonghong.song@linux.dev>
 <m2v7do1avc.fsf@kernel.org> <DHWI663IJRCO.CRVLYYK1H7KE@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DHWI663IJRCO.CRVLYYK1H7KE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/18/26 11:47 AM, Alexei Starovoitov wrote:
> On Sat Apr 18, 2026 at 9:39 AM PDT, Puranjay Mohan wrote:
>> +               /* call1: subprog_7args_inner_call(1,2,3,4,5,6,7)
>> +                * internally calls subprog_7args(1,2,3,4,5,100,200)=315
>> +                * which clobbers stack arg registers with 100, 200.
>> +                * Returns 315.
>> +                */
>> +               "r1 = 1;"
>> +               "r2 = 2;"
>> +               "r3 = 3;"
>> +               "r4 = 4;"
>> +               "r5 = 5;"
>> +               "*(u64 *)(r11 - 8) = 6;"
>> +               "*(u64 *)(r11 - 16) = 7;"
>> +               "call subprog_7args_with_inner_call;"
>> +               "r6 = r0;" /* 315 */
>> +               /* call2: reuse r11 stores from call1 (no re-store).
>> +                * subprog_7args(1,2,3,4,5,6,7) should return 28.
>> +                * If clobbered: subprog_7args(1,2,3,4,5,100,200)=315.
>> +                */
>> +               "r1 = 1;"
>> +               "r2 = 2;"
>> +               "r3 = 3;"
>> +               "r4 = 4;"
>> +               "r5 = 5;"
>> +               /*
>> +                * the 6th and 7th arg should be 6, 7 as set above.
>> +                * But the inner call in subprog_7args_inner_call clobbered
>> +                * them and reusing again without a re-store will be wrong.
>> +                */
>> +               "call subprog_7args;" /* should return 28, but will be 315 due to clobber */
> Puranjay is correct.
> The verifier should error here.
> callee can modify 6 and 7th args in place in the stack.
> All args register or stack are caller saved.
> I believe it matches other archs.

Agree. verifier should do invalidation of stack argument slots after 
copying states from caller to callee. I did have invalidation in v4: 
https://lore.kernel.org/bpf/20260412045955.257613-1-yonghong.song@linux.dev/ 
In v5, I tried to do some optimization. But sashiko-bot and bot+bpf-ci 
pointed the issue. I will bring back invalidation in verifier which 
should fix the issue.


