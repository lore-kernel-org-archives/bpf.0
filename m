Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87D38F230
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281650; cv=none; b=Dxih4sx6LacjEDGPPvFLFLICEmCLuEvvQ/lVqnPh+E8J1euaiv/0KkYVvVU+RS3cU0IC5dZkSWr/cpB8cZEC1mksHAG1oq8qdR7HhJ06NzSVPmj6KLhEL4SQjZVBp3BU2gdaABtgtATulAS0bPe2ObGHG05mjaeyg4Tom1ZGJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281650; c=relaxed/simple;
	bh=O66MVGU3QDL+Cy3akNBxytOM3P+XmOPScObecOW3hrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNpssJ/MRyhmLc/ovPm1Ee0Ys468bWyjp68CHYjVnTaw66uVU69f2FCzXVgTi6l0q5zDIk90IhBc2BVt45gmemnwiw4BMHv+rskwDXVpG4Fd803eKxEu4edolhRGYU6djL5umM1yEDytcOCmPsuCQItm+2CxeHNaJfREmYuR7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opt3hDoX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opt3hDoX"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-834da62e52dso1153889b3a.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 16:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281649; x=1778886449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/InWrOUOchm9lydjp+lzNN+EzfH6qLQxojHmTQooTE=;
        b=Opt3hDoX/XAFfIw8ewzmF+CpDIEXJidFDYd6iImw+JICCtAhFcrqxE+1SVzwIdqch9
         qg4WZ0mJEmdeiOSmf9n64ydILETDwpNcPCGdS4AGUjI2ARvQY2kWiEkWPIrHab5q+eli
         Rd0Bmko6/AWr6fXZBHhfKbVbg3v0kYvXpoP90or0ua0/mzkTKza2EVM+49onPx4cv31a
         r6kdTGoJ/2VdIHraqe/VJGOeV6Yf2TVUqr9ygPTxWBGoVWT+NwmIxJoDDEML9EPe5PGg
         eKPYMhtFT7Fnm8xPoHQ5BnKquQCPIDKro2VRRAiaoxJjziTmV3ATFne5vPKlwsnb0n96
         WFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281649; x=1778886449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/InWrOUOchm9lydjp+lzNN+EzfH6qLQxojHmTQooTE=;
        b=Z/0VxAfG5LJDBxYi4Vjhbr3JrNktjVfIOZ5T6wbisQeXLQim6zcbzcRiwydmheJhIg
         KvUKSlFjLKDOzaV3eBqy/fPKASad81yadBjRTrIGTTQpnts0zf8apCaL5PkFcggU7XtQ
         4yIEkElsXWL1gd749x5peEwj929GYA/YuCpQC6VoSauJQ8lQGG8EK5I50qdLjB6WQCys
         Ie25/I+QyGNm6aaP9zcOlJDHlQFsEnF+xsKc/iRjW6Aeuune5i0kYcSDMPOY9mcrYEmW
         sIz9um7EZphQruSss8reHa2Vi40CB95cwI/3YjUlIu4ot6+o5es3vLHdSYNd14iYaVm9
         j/ig==
X-Gm-Message-State: AOJu0Yx+B6byCt5fif90f5IhCT+25KeBf0ccNo4GR9qqqgkuJssxbtXS
	hzz43eGACzXbu7+5FB6m3qZ3bpLVB+ORIEh2ek2kShiYpcVF9Q3aDHIj
X-Gm-Gg: Acq92OGylNqp4UeUjurlw6/D+J1KkHKJKWVIdYBRMiQgkuF+mWQP//nYVcrA79XQBbw
	B0P7PV3D3xA9VoZWCTB1jrBk7LLwyiqFwXDAgplOcpDLKoM6qe7Mm6V9HEWzKjwDp73sfMBcNvF
	YMDvJwOBAwmXKRtSruBNcWb7Uw+WB4JYkfMMG4x0VE8u2UQYp824sVEQe6qBu40DcghesPXgw5H
	d5dScUrbLV+nGqQLst8P3w224Wr7IfWGpMoH8MqodNQH7CtGBdYd2uLORJkK08rzWk1fLbyIq3L
	iaz8F+XqixZy5NUHP5FLzjYjw8GUJFnK9ACZgBWFsedbdFHtu0BH/CSBWrOWdNVI/evMs0VbpQp
	vHv7pfhP16S9rkKZFRJgbUOeA5pS32g9pLANgQ36gQtf5JYNmZMwv1g1NJ5B1RLDHfzg9hdz8vk
	dxL4E2pk4AKfzlLaWkEV9uC4K7B7NdHBpXv30CAg==
X-Received: by 2002:a05:6a00:a8d:b0:82f:cfd2:6ca0 with SMTP id d2e1a72fcca58-83a5dd57ddemr13693442b3a.40.1778281648593;
        Fri, 08 May 2026 16:07:28 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9582:1100::c7c9? ([2604:3d08:9582:1100::c7c9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563ac51sm13518919b3a.2.2026.05.08.16.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 16:07:28 -0700 (PDT)
Message-ID: <a51c45c1-852b-41a6-ab59-9da186350e36@gmail.com>
Date: Fri, 8 May 2026 16:07:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/19] unwind_user/sframe: Wire up unwind_user to
 sframe
To: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-8-jremus@linux.ibm.com>
 <20260505185528.8E529C2BCB4@smtp.kernel.org>
 <05adaec0-c2cc-4a16-b2da-ba3ed7437e7d@linux.ibm.com>
Content-Language: en-US
From: Indu Bhagat <ibhagatgnu@gmail.com>
In-Reply-To: <05adaec0-c2cc-4a16-b2da-ba3ed7437e7d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-07 09:18, Jens Remus wrote:
> On 5/5/2026 8:55 PM,sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] Unbounded linear scan of user-controlled sframe entries can cause a CPU hard lockup in NMI context.
>> - [Medium] The commit message claims to refactor `unwind_user_next_common()` by removing an unused `pt_regs` parameter, but this change is entirely absent from the code modifications.
>> --
>>
>> commit 2e1e17bbaa1c0426d41d66ce7930a944f3e86ae7
>> Author: Josh Poimboeuf<jpoimboe@kernel.org>
>>
>> unwind_user/sframe: Wire up unwind_user to sframe
>>
>> This commit hooks up the sframe infrastructure into the unwind_user interface
>> to support user-space stack unwinding via sframe. It adds the
>> UNWIND_USER_TYPE_SFRAME type and updates the unwind_user_next() logic to
>> attempt sframe unwinding when available.
>>
>>>      [ Jens Remus: Remove unused pt_regs from unwind_user_next_common() and
>>>      its callers.  Simplify unwind_user_next_sframe(). ]
>> This isn't a bug, but does this commit message match the changes?
>> Looking at the diff and the code, there are no modifications to
>> unwind_user_next_common() or its callers to remove a pt_regs parameter.
> Sashiko AI review failed to understand this commit message comment.
> 
>>> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
>>> index 90ab3c1a205ef..1fb2724197332 100644
>>> --- a/kernel/unwind/user.c
>>> +++ b/kernel/unwind/user.c
>> [ ... ]
>>> @@ -82,6 +83,16 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
>>>   	return unwind_user_next_common(state, &fp_frame);
>>>   }
>>>   
>>> +static int unwind_user_next_sframe(struct unwind_user_state *state)
>>> +{
>>> +	struct unwind_user_frame frame;
>>> +
>>> +	/* sframe expects the frame to be local storage */
>>> +	if (sframe_find(state->ip, &frame))
>> Can this sequence cause a hard lockup in NMI context?
>>
>> Since this unwinder is often called from NMI context (like perf), sframe_find()
>> eventually calls __find_fre() to search for Frame Row Entries. If __find_fre()
>> performs a linear scan over an unbounded, user-controlled number of entries
>> (fde->fres_num), it could spin for a long time without yielding.
>>
>> If a malicious userspace program maps a large VMA and provides hundreds of
>> millions of FREs, would this loop calling unsafe_get_user() on every
>> iteration tie up the CPU long enough in NMI context to trigger the hard
>> lockup detector?
> Please advise.
> 
> A user could craft .sframe with a large number of FDEs (up to UINT32_MAX)
> and large number of FREs per FDE (up to UINT16_MAX).  Each FDE could point
> at the same FDA and FREs to save section space.  Each FDE would require
> 16 bytes in the FDE table. All FDEs could share a single FDA of 5 bytes
> and share FREs of minimum 5 bytes each (when using the 16-bit start
> address offset to have UINT16_MAX FREs) in the FRE table.

For the case of malicious .sframe with large number of FDEs, wouldnt the 
existing checks of the various offsets being less than sframe section 
size suffice and the following in sframe_read_header suffice:

    if (fres_start < fdes_end || fres_end > sec->sframe_end)

For malicious num fres, should we add a check that a function's num fres 
is less than or equal to func size (available in the FDE index entry)? 
It is an approximate check, but should provide some boundary check.
