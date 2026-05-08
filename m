Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED13A8746
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281545; cv=none; b=nwSXRBWX4B+1uB0IRMmJD5FZx05Q+Zz9N/PPmvew3mTbbuHV29abGnRmrC/qGNJqQLSIVtDE/pp+1P3PnUscqocJ6i8zNIgyLbwCPJhD35PIea5adkZ01I++V8wQPszAGtHohTGHAMzEzY0Kv8d4L1L1noZi8dRTi4YM3V8NqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281545; c=relaxed/simple;
	bh=BIZ2DEmxQNMSyJO0c3JrhwGrmW3VPJQHd2yM8ypX9H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNaoiRCEutTdW2u8wU3J0g8RKmjKf8GJYK4Mxl238ot9j8WQIaMOGb1T5p5Y38HwGq5LK3ROBV0rVbrITWY/mCl/ismZ49jFbDBZMDsR94ZV6QHMPARHoUhOnUZMgh/yDry0JzMqkox3Ano3kTKCLoE4RdMJqpnz9sLZ5qSJ8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6GyuS7N; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6GyuS7N"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83537a80ab6so1636601b3a.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281544; x=1778886344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xeg4ZJJWFuOVqx92VARGZStirf6XOw1xwpYmdyHRQSw=;
        b=R6GyuS7NH5w1tRK69EEPkCAZXu3zMimFJca11xMmMfI4uGjQBY0LHwv69zIUxZsASa
         mfa4piX9WCP9l1slg+0Q3NB/MahXsn8Wn+Y+b2Ic0DMkjzP+FqfqnfjmE8otcpQ6Gg77
         hE1FUwcWY4bbRdbOJV5ZK3DZ7H9eKI6rNeMcMjaaCxwWrxR7pwE7G0T+a7KluFOc6j20
         yKc2nBxIZ5V8Xk+TH5y189AZx9TVvmE8S2699rswrJCYBZj0A5DiaWw0rmQiPZOR3YGw
         6uFs1L7wDkjQChH4xRcM3mqscI3Th/tLHBY9DWCehc8I7j1QWOicFcMinq1G7HcSk4Wc
         ovtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281544; x=1778886344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xeg4ZJJWFuOVqx92VARGZStirf6XOw1xwpYmdyHRQSw=;
        b=IwFTfxN6jMuY/X5Ci0M37kKYxJ88oBdf5oil7X4uupFmS3tiJHKR+X/px43DI1dywB
         GaAweuhrNnldDlmDRcsbvKARLx6Qb8cy3ILflVNVUhO0lC8wftT1WGm+pdIzsgLj/GMb
         6dEvH1Odh/hTxwIn07gbpKcn5uXGrEuDqSiqQJDknB6//7i7vG6Lt1qFqNYnxb4iQT/k
         StsVHkNU+FbrzlNalMq72nDgNIBc0Q/mfNJugHWUj7hFLmGTbuSKhwTsZvXL+LfKhNhe
         v8xhfB448Uxy1fJ669VkyVrkPNufjJwcER7zFbpZDLgArAVJHkqsYZy/QZLWYpWo3j13
         oEsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BIB2YSC4kjtQ1OjmRC/nlrxXMiZ4SWYBy/8iekahgQ9cxZ/Hv0v9lab8/SJgJA4s4qWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRn6c7cmfKrcWpo7x7BqY8tkj76dtc6CsGjlmUquP3Mz7Pf67
	6v6dCd3sjCy+DYOEV0NPKWLPLBe+wmPnroJm7EiDb2PwK9fO/e3NC9Ur
X-Gm-Gg: AeBDieuOehg0ZWUdbs+H4+ZOTMJ5ULBk/3pEIAChcWXMCxv8Y68OEYJJ5cI1S+oe+TL
	B942th0fCg3A9KgJL1bj4HHQ56ydTXuugdw5PWyC1jJPOlOIRB/qsMnMRn4YC7PCgJ4p6iyrn2M
	EFGoZe8vbkMwbPmLunWI8trppniUo05K6S4sdMs7dXC3oYJqmWhsyWEtN38MB3oXVRSYfDBZZVv
	/3SRtilwKa4/vDQFdb8P4k6kdBtHMBmZJvwJ/UCB1ACe9H++jmHa7b6y8CE176zu4m4zZ83z1hE
	tD48IK4on+mVJ7xSSnxmr6RRBLeq7cifPEHGVxrCJny3na6hS55QFDPo6SZ3pEk6x9lnOx5DDo7
	Mki4Lnvv7wqPY0ghlUyRy38vBwnUIkWMm8XlRV11ZPmY7+7qmCAwRMf0bsxdc/whVE6uoJ7o05E
	7F8SXzsypw/GwsHnFPk7KdDb2wH1R2FdwB+Hxwcw==
X-Received: by 2002:a05:6a00:9a6:b0:837:e9cc:d474 with SMTP id d2e1a72fcca58-83e391509c7mr227285b3a.2.1778281543986;
        Fri, 08 May 2026 16:05:43 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9582:1100::c7c9? ([2604:3d08:9582:1100::c7c9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396594645csm13979079b3a.14.2026.05.08.16.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 16:05:43 -0700 (PDT)
Message-ID: <03b20e60-3249-4f6d-80a6-d21566b6f75f@gmail.com>
Date: Fri, 8 May 2026 16:05:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 06/19] unwind_user/sframe: Detect .sframe sections in
 executables
To: Steven Rostedt <rostedt@kernel.org>, Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, bpf@vger.kernel.org,
 sashiko@lists.linux.dev, "Jose E. Marchesi" <jemarch@gnu.org>
References: <20260505121718.3572346-7-jremus@linux.ibm.com>
 <20260505125336.72A36C2BCB4@smtp.kernel.org>
 <29d28c6e-2909-444e-b22a-7429464056dd@linux.ibm.com>
 <20260506113605.5df32968@fedora>
Content-Language: en-US
From: Indu Bhagat <ibhagatgnu@gmail.com>
In-Reply-To: <20260506113605.5df32968@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-06 08:36, Steven Rostedt wrote:
> On Wed, 6 May 2026 16:56:01 +0200
> Jens Remus<jremus@linux.ibm.com> wrote:
> 
>>>> --- a/fs/binfmt_elf.c
>>>> +++ b/fs/binfmt_elf.c
>>> [ ... ]
>>>> @@ -637,6 +638,21 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
>>>>   	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
>>>>   }
>>>>   
>>>> +static void elf_add_sframe(struct elf_phdr *text, struct elf_phdr *sframe,
>>>> +			   unsigned long base_addr)
>>>> +{
>>>> +	unsigned long sframe_start, sframe_end, text_start, text_end;
>>>> +
>>>> +	sframe_start = base_addr + sframe->p_vaddr;
>>>> +	sframe_end   = sframe_start + sframe->p_memsz;
>>>> +
>>>> +	text_start   = base_addr + text->p_vaddr;
>>>> +	text_end     = text_start + text->p_memsz;
>>> Should text_end be calculated as text_start + text->p_memsz - 1?
>>>
>>> Since the maple tree API strictly expects inclusive ranges [first, last] for
>>> insertions, passing the exclusive text_end would cause the inserted range
>>> to cover one byte beyond the actual segment.
>> Shall we keep the text_end and sframe_end is pointing past the
>> respective section end semantic and just adjust the value passed on the
>> call to mtree_insert_range()?
> Let's keep the end exclusive, and add the "- 1" to text_end before
> passing it to the mtree_insert_range(). I did that to get it working for
> me.
> 
>>> If an ELF binary has adjacent executable PT_LOAD segments, could the first
>>> segment's inclusive end overlap with the next segment's start and fail
>>> subsequent insertions?
>>>    
>>>> +
>>>> +	/* Ignore return value, sframe section isn't critical */
>>>> +	sframe_add_section(sframe_start, sframe_end, text_start, text_end);
>>>> +}
>>>> +
>>> [ ... ]
>>>> @@ -712,6 +729,19 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>>>>   				error = -ENOMEM;
>>>>   				goto out;
>>>>   			}
>>>> +			break;
>>>> +		}
>>>> +		case PT_GNU_SFRAME:
>>>> +			sframe_phdr = eppnt;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (sframe_phdr) {
>>>> +		eppnt = interp_elf_phdata;
>>>> +		for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
>>>> +			if (eppnt->p_flags & PF_X)
>> 			if (eppnt->p_flags & PF_X && eppnt->p_type == PT_LOAD)
>>
>>>> +				elf_add_sframe(eppnt, sframe_phdr, load_addr);
>>> Does this need to verify the segment is loadable (eppnt->p_type == PT_LOAD)?
>>>
>>> If non-loadable segments like PT_GNU_STACK have the PF_X flag set, they
>>> typically have p_vaddr and p_memsz as 0. Processing these segments would
>>> compute bogus text boundaries and bypass VMA validation. If a legitimate
>>> PT_LOAD segment overlaps with these bogus ranges, could its insertion fail
>>> silently and break stack unwinding for the executable?
>> Do you agree?
> Indu or Jose?

I think checking for PT_LOAD makes sense as we want to detect the 
executable text segments.
