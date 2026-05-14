Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426233E2742
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768689; cv=none; b=FHTyB28np33yjUhCAGAySaCOF88pNsLyP1YGeDy2F3Pojfi9zmd/jkTyHStYpy7ML61wzPPa1ER0LCwtbuKCxO/P5X+PgrVr2ldAF3KRlHR7BvGDrB7MaQ44vClxkSV7LV1ktWmEcdzynI+nI44ZOrBg7mnHByH2jc1gNDjfsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768689; c=relaxed/simple;
	bh=pzT2Bl8Sif1Shi5PRaSUlrYW4FrrODRjMdm1CqPe/tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEnXs4wTUmzDJTTbfDpQzONg+Gfdxm1aPEUavRXFuCB8NHt7o7wKZwf0ZhEFKbdRVl5P2BXhpLFsCGPElwNdB86Heg+pXfcJjUN7j25MraHTTaxhe0OuR7bRoMfVllvGgc9nyq7NlcGiz3qCnLpGlPHOiH6B0jZixl5CkTr3gV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JM+HgaVm; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JM+HgaVm"
Message-ID: <98c92b19-c6fe-4de1-8caf-c09b04016ee0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778768675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIXH/7Z7nuYLPl5/E6mKjJm3QpEpz0nYc1a1DD3/ua0=;
	b=JM+HgaVmdOC77tD3xQBnsOf3un/NyzRaorE8BT4NUoPFloW/vgGDl9p2CqxHg8SRtx7PKZ
	c9J39BrC1L7NEB6LGXxt97qZCmxv38MqpU4qxzNYay9EU9JWDorfpZncU4lDCDiWhmfe4/
	pZkT1dkLq5OmPASRE3s2MpSIEmfDlr8=
Date: Thu, 14 May 2026 22:24:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v14 1/8] bpf: Extend BPF syscall with common
 attributes support
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260512153157.28382-2-leon.hwang@linux.dev>
 <20260513224823.6494FC19425@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260513224823.6494FC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/14 06:48, sashiko-bot@kernel.org wrote:
[...]
>>  
>> +struct bpf_common_attr {
>> +	__aligned_u64 log_buf;
>> +	__u32 log_size;
>> +	__u32 log_level;
>> +	__u32 log_true_size;
>> +};
> 
> Does this UAPI structure contain implicit trailing padding? With one
> __aligned_u64 (8 bytes) and three __u32 fields (12 bytes), there are 20
> bytes of data. Because of the 8-byte alignment, the compiler will pad the
> structure to 24 bytes.
> 
> If a future kernel extension adds a new 4-byte field, older userspace programs
> allocating this structure on the stack might inadvertently pass uninitialized
> stack garbage into the new field, permanently breaking backward compatibility.
> 
> Should this include an explicit __u32 pad; field, and should the kernel
> explicitly validate that attr_common.pad == 0?
> 

This concern seems valid to me.

Propose my fix here:

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6600e126fbfb..83de8fb9b9aa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6278,7 +6278,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t
uattr, unsigned int size,

        memset(&attr_common, 0, sizeof(attr_common));
        if (cmd & BPF_COMMON_ATTRS) {
-               err = bpf_check_uarg_tail_zero(uattr_common,
sizeof(attr_common), size_common);
+               err = bpf_check_uarg_tail_zero(uattr_common,
+                                              offsetofend(struct
bpf_common_attr, log_true_size),
+                                              size_common);
                if (err)
                        return err;

This is to avoid adding an explicit __u32 pad in struct bpf_common_attr.

> [ ... ]
> 
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
> 
> [ ... ]
> 
>> @@ -6226,6 +6228,20 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
>>  	if (copy_from_bpfptr(&attr, uattr, size) != 0)
>>  		return -EFAULT;
>>  
>> +	memset(&attr_common, 0, sizeof(attr_common));
>> +	if (cmd & BPF_COMMON_ATTRS) {
>> +		err = bpf_check_uarg_tail_zero(uattr_common, sizeof(attr_common), size_common);
>> +		if (err)
>> +			return err;
>> +
>> +		cmd &= ~BPF_COMMON_ATTRS;
> 
> By unconditionally stripping BPF_COMMON_ATTRS from the command here, won't any
> BPF command (such as BPF_MAP_FREEZE) successfully accept the flag but silently
> ignore the provided common attributes?
> 

Correct.

> This might prevent userspace from correctly probing whether the running kernel
> actually supports common attributes for a given command.
> 
> Should __sys_bpf() enforce a whitelist of supported commands before stripping
> the flag, or explicitly reject the flag for commands that do not support it?
> 

If users want to probe for common attributes feature, they can do it by
the way of patch #2.

Thanks,
Leon

[...]

