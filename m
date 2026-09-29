Received: from mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584F4E236B
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790719479; cv=none; b=Vty3oVLy5sYYSMFAi0JDXfTtEnuS/ZsxHxnbk4VqWAm3KOb7STppUuQl607ej8HqGBWC5bjUIaw7CszIdqy2TYujf0ZMDWjluPXJ4ntdaWubCxGXMya2pNe6rzju7NFM5LSbGYmJMOjgYwvfS3Y4vZDSvbCjNAVGnZRlaJ634OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790719479; c=relaxed/simple;
	bh=dXnPdOI28iDxZTldeCOGAFTR6Ncx1ALmJPZtGC6EAto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emNvaPLNZ9qjwp9JdpQz98SL/1U3c05olUqdTXsnGLxGREiyzZOQeGthLxRBHjuKbOYB5wq0przgcZSvF64hR++fNlpWB7Qnq+vxThmQy6vVZVnIkiGNoHZm9B2aCfFldchtvivZ3/AzWcM2ptDJAArBbjlkULEX1kYaqqj4aa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vgChrAg9; arc=none smtp.client-ip=91.218.175.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vgChrAg9"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dXnPdOI28iDxZTldeCOGAFTR6Ncx1ALmJPZtGC6EAto=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790719475; v=1; x=1791324275;
 b=vgChrAg9aAeCFd2laHiQ7I4Q2KvgdoYW8LxBXaDzJxnpEqyXZd7kAD7enoacyIC3uTOqrRTG
 DkLkBHepsBwSkv6ra7DqG2nJ+DiwPPL4rxlap98ZGxP2T4LprwviTLMstPTEpriGFuwC+G5qGOo
 XGR/hKWeXeFGVmuKBB9I71iE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 84aa7a27ba1ba801;
	Tue, 29 Sep 2026 22:04:35 +0000
X-Mizu-Trace-ID: 84aa7a27ba1ba801
X-Migadu-Flow: FLOW_OUT
Message-ID: <de76c109-048d-4f7f-8078-3b5addb126e2@linux.dev>
Date: Tue, 29 Sep 2026 15:04:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 05/22] bpf: Prepare for an exception cleanup
 table before the CFG walk
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001628.3247662-1-yonghong.song@linux.dev>
 <20260929003137.041DB1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260929003137.041DB1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 5:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: cleanup_pad adjustment fails for BPF_PATCH_MOVE_TARGET at off=0
> --
>
> commit fc0420a45de5f3cee47a65d96e78244ace4fbf4e
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Prepare for an exception cleanup table before the CFG walk
>
> This patch prepares an exception cleanup table for BPF programs, adding
> landing pads to the instruction auxiliary data for calls that can unwind.
> It introduces the cleanup_pad field to track where execution should resume
> during exception unwinding.
>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index b19fcbf49b7ef..c1779d2d02f05 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
> [ ... ]
>
>> +static int mark_call_sites(struct bpf_verifier_env *env)
>> +{
>> +	u32 i, j;
>> +
>> +	for (i = 0; i < env->cleanup_info_cnt; i++) {
>> +		struct bpf_cleanup_info *rec = &env->cleanup_info[i];
>> +
>> +		for (j = rec->begin_off; j < rec->end_off; j++) {
>> +			struct bpf_insn *insn = &env->prog->insnsi[j];
>> +
>> +			if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn) &&
>> +			    !bpf_is_unwind_kfunc(insn))
>> +				continue;
>> +			env->insn_aux_data[j].cleanup_pad = rec->landing_pad_off + 1;
> [Severity: High]
> How does this new cleanup_pad field handle instruction patching when a
> landing pad is located at instruction 0?
>
> If mark_call_sites() sets cleanup_pad = rec->landing_pad_off + 1, and the
> landing pad is at index 0, cleanup_pad becomes 1.
>
> If bpf_convert_ctx_accesses() in kernel/bpf/fixups.c later inserts a
> prologue at instruction 0 using BPF_PATCH_MOVE_TARGET,
> adjust_insn_aux_data() will try to update the aux data offsets. However,
> its check:
>
>      if (data[i].cleanup_pad > off + 1)
>          data[i].cleanup_pad += cnt - 1;
>
> will evaluate to 1 > 1 (false) when off=0. The required shift is skipped,
> leaving the cleanup_pad pointing to the newly inserted prologue instead of
> shifting to the original instruction. Unwinding to this pad could re-execute
> the prologue and potentially corrupt the frame pointer or stack.
>
> Can this sequence occur and lead to stack issues?

The landing pad cannot be at insn 0. The prog entry starts with non-pad and
until it finds bpf_unwind() and goes to landing pad. In such cases, you will
see landing_pad insn with non-landing-pad and with-landing-pad. This will
be rejected.

>
>> +		}
>> +	}
>> +	return 0;
>> +}

