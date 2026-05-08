Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D8221DB3
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281328; cv=none; b=g/Y5aHONYnfHtc9tLOHC7+l1mT43XwQC4o0NFHaVo4HBhmbwxNUuWnucE34bqPZ8eYF2Z7cg1QCFlF2jCazR/2ZAoPFrsvfHkhf6QZDhjszcCoBr7eQMxdD4h0fCMvpXqMHHdQuhzT9rQWMRxmQ1ZyendyDELq0zNKUYsc8yVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281328; c=relaxed/simple;
	bh=WqTEr6P7SFgnQakT6JXZbfbGPNMww6j9VukxRby8an4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwUOHNyTPd6n/sEsta8Nec9gKi2oW0OUBUKBNfPDu2mseVTZaZdeOrBLp8DvReIQvcelqH/VhVUnER+mK66trrzHvT84SVcWv2UzQVHpTf/NVEiFjffpE1LWTQG+eZqobIOxoAnB8y4rTpfekGMpVlDpN3OsbTNHxgDSIApb9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJLE/kg3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJLE/kg3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba4efedbeaso18214865ad.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281326; x=1778886126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6rNXzaWvzDqJsK/a0lBi5Sn7tj+GWzVcJ62JnTUubY=;
        b=QJLE/kg3vMVBVcF6NBxs0zF0TG3Kk3yXsok2ri0Tis4ozHGLMO/EH2BF89wzeV8rjs
         FjVkBelgHwlCW00GWyTF7nHdIbo315/beMTi2lFef1CGXxg4e77TqhE1/D9AVGi/Lnqv
         x+QOKn4V/yfAZerQooDC5vrYka8+/urETHCNt694ZEs4G8YVmceqqeyviv4P0T5Gbzc3
         jBtZ7R/TRH+btyrflHSvsjtFV93ZzG3Dh1KzV8mTHAWXep1/guIZJ5Bv3ajFBRL+g5HM
         EWbmnbBm2Ct2OdNVe3xmS9VXZBQ2ZxaqTXX7HrD3Zr537OHkQhc0CJOFuw+/GRbUGMe0
         biOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281326; x=1778886126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6rNXzaWvzDqJsK/a0lBi5Sn7tj+GWzVcJ62JnTUubY=;
        b=WQ3G3PsGY+BZG09ew3V5mA/HBGdqdZZmc/IaYCYZb5JiLGI48NQbeErZe17xQvM00g
         pBVcD4bTPzFsfbLVL18M6G3YFolmC4Dl1Gqgai2deaJZ/jA+0Nb9zf6k/9iWeuY0un+3
         QPEUiyvzZAUCsGOmMaPKAmT/Z3s638f1DM7AiL3xhz2ZPktlVgMyzgh8ASi0CTy0oYWR
         RcYR3EcH4G7lSU1n6z+yf8ex4gOvVpP2RWa8GZc5rUVWn6R974ztWGnNk19yHpGfbxQx
         5514BM/Cvm7YO8mOZu8kC3+6B1acsKGbcAyzUbKDuxqoUq9xRPN4W/mOOTA2mk8hsUTq
         6dqw==
X-Gm-Message-State: AOJu0YwquGPTWExIu6czoTJHK1RuKx0arglMFwdKKTn4Ea94VRXvEw8S
	61oXrjh6zLfjoxozKbncEVASPvoW15Xrj+ewKW2I2BENudjQj0+3szlH
X-Gm-Gg: Acq92OH2qEWnYT7Zw6YTXPifdjrMryzd/tbWtjIRtwWHYquThFJWOeT+letkrtLZYzt
	NL8LnrnSlKujr6NP5UmKh7JmVolb7HqeWVFY5u0aUmRgYmzXyWcUS6fiZURbRtlHttsxKQgdeq7
	Ko2WDeP/kfGDLWqRazKP36yqgVZOy0VJPtHANEfOjTuMhZoKwBOl/nt/3WCEN/21Ttbo7N+zD8Q
	EIVFNBYR16Vzg3yZZ1xQTWxsVHerW/w/G5KXsN6/y9vMNPYjpLNxb+RYZ/tJb51jZBGm8na8Zm0
	LEn6J0ajzi17lLfRnMil5+vc0IIklzENNwwtE0cQwaAB/QizugFhhOXgEyHeIFArTCoeBQiHmds
	BKo6zWtE6pyzLqOigoVgL6ZxIjbJEd9D01WS0TttXQooXutNS5k0FCqirNX5et8ipyzoZh02FZM
	mLF2dUhTNmWqZ5UOiw+M/U2HeAHAyo+R0ElF2mVQ==
X-Received: by 2002:a17:903:1b07:b0:2b9:eb6a:68b5 with SMTP id d9443c01a7336-2ba7a36022amr140432425ad.38.1778281326002;
        Fri, 08 May 2026 16:02:06 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9582:1100::c7c9? ([2604:3d08:9582:1100::c7c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d3ff52sm32984075ad.26.2026.05.08.16.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 16:02:05 -0700 (PDT)
Message-ID: <68676204-ba32-446d-a0fd-c2f39cea775e@gmail.com>
Date: Fri, 8 May 2026 16:02:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/19] unwind_user/sframe: Add support for reading
 .sframe headers
To: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-3-jremus@linux.ibm.com>
 <20260505124948.669E2C2BCB4@smtp.kernel.org>
 <f106e4a1-4f60-4c65-97bc-2257005765e5@linux.ibm.com>
Content-Language: en-US
From: Indu Bhagat <ibhagatgnu@gmail.com>
In-Reply-To: <f106e4a1-4f60-4c65-97bc-2257005765e5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-06 06:42, Jens Remus wrote:
> On 5/5/2026 2:49 PM,sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> - [Medium] Missing validation of shdr.abi_arch allows parsing SFrame data from mismatched architectures.
>> - [Medium] VMA addresses are incorrectly evaluated as boolean flags to check for zero-length inputs.
>> - [Low] Mixing goto error handling with scoped_guard scope-based cleanup.
>> --
>>
>> commit afe7c9eb6f0e6fc3f73d0b6a555f8d3926cf6ccf
>> Author: Josh Poimboeuf<jpoimboe@kernel.org>
>>
>> unwind_user/sframe: Add support for reading .sframe headers
>>
>> This commit introduces basic infrastructure for unwinding user space stacks
>> with SFrame. It adds support for parsing the .sframe section header.
>>
>> Link:https://lore.kernel.org/all/ 
>> f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org/
>>
>>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>>> new file mode 100644
>>> index 0000000000000..c128c1eeaca20
>>> --- /dev/null
>>> +++ b/kernel/unwind/sframe.c
>> [ ... ]
>>> +static int sframe_read_header(struct sframe_section *sec)
>>> +{
>>> +	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
>>> +	struct sframe_header shdr;
>>> +	unsigned int num_fdes;
>>> +
>>> +	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
>>> +		dbg("header usercopy failed\n");
>>> +		return -EFAULT;
>>> +	}
>>> +
>>> +	if (shdr.preamble.magic != SFRAME_MAGIC ||
>>> +	    shdr.preamble.version != SFRAME_VERSION_3 ||
>>> +	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
>>> +	    !(shdr.preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
> 	    shdr.abi_arch != sframe_abi_arch() ||
> 
>>> +	    shdr.auxhdr_len) {
>>> +		dbg("bad/unsupported sframe header\n");
>>> +		return -EINVAL;
>>> +	}
>> Should we also validate shdr.abi_arch to ensure it matches the expected
>> architecture?
>>
>> If malformed or foreign-architecture SFrame data is passed in (for instance,
>> with an unexpected endianness or register mapping), the kernel might interpret
>> it incorrectly and generate invalid stack traces.
>>
>> Furthermore, accepting arbitrary values here could risk ABI calcification if
>> userspace starts supplying invalid values that we later want to reject.
> I could introduce an architecture-specific sframe_abi_arch() and update
> the SFrame header validation as above.  For x86 the implementation in
> in unwind_user_sframe.h could look as follows:
> 
> #ifdef CONFIG_X86_64
> #define sframe_abi_arch()	SFRAME_ABI_AMD64_ENDIAN_LITTLE
> #endif
> 
> Given sframe.o is only linked in if CONFIG_HAVE_UNWIND_USER_SFRAME and
> that is only selected if X86_64 this should be fine.
> 
> Do you see any value?

I dont see much value.  fs/binfmt_elf.c has done some admission control 
for the user binary already.  For bi-endian systems, this doesnt add 
value (wrt checking correct endianness).

For addressing the concern of a compromised SFrame section, we need to 
ensure checks at SFrame information read/validation time (which the code 
is doing already and additional checks that can be added are currently 
being discussed).  Checking for the abi_arch value does not necessarily 
safeguard much.
