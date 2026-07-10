Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6E3793C1
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660389; cv=none; b=lRFix0jlYxLhBEPBzceprlD7K9X+ti1+y0LHB2mvtOmO2JhCruvS9WHgEzGZsOHA9Qg0qEqBiKODgWt69m/t5A2N2SbiTgFVx5Q0zmshINUgLluOIh1lL3rWbW4wUMiD7bwa9PTsYr/9sbiWvKhmjnfT2EYgkUjAiYH1ogH2RXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660389; c=relaxed/simple;
	bh=PbrS1mt0Wak+sSVRVZcrskp2vaTDCieRub4DO5Eqa6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ua/xILjlZF0K7kYTDldAUFLTjEUeYNjnt6CWWKrpiLu+jgov/7LeC/M0d/vsLzP4RhfthAlut/Hwm+FvlNR5fNyEiHovh0TCLW2g1rVkbw3eLFLp0mVmf4aQ5N83ylVxj997NzWhoEcOpsZn8r2X81tpOhlYPlWEixSp7NfMlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kunpPtfP; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kunpPtfP"
Message-ID: <9b204556-737d-433b-8cae-b7f30ccc8b6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783660385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbrS1mt0Wak+sSVRVZcrskp2vaTDCieRub4DO5Eqa6w=;
	b=kunpPtfPr8HtAoLf8g+YzMp1kY8K8CsEybBxDcqtgi+lDmedkw2I5l6i/BAvRfgURWOa16
	DZi294sRWn3AYy5NyeUQJ/EeqVcB7tKa8EUcpLX74CX9QT+aJyfzMbPjqQ4Xfpvz8tL2ou
	cjX+EecNTZqy19bIs4xdNtEGCUXQM8c=
Date: Thu, 9 Jul 2026 22:12:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 07/12] bpf: Reject >8 byte return values on
 return-reading trampoline paths
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201015.2159760-1-yonghong.song@linux.dev>
 <b571171588e42e40e9bed69fb3f1bc9021573445.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b571171588e42e40e9bed69fb3f1bc9021573445.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 4:08 PM, Eduard Zingerman wrote:
> On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
>> btf_distill_func_proto() builds the function model used for kfunc calls,
>> the fentry/fexit/fmod_ret/fsession trampolines and struct_ops. A following
>> patch relaxes it to accept a >8 and <=16 byte return value, which for the
>> BPF target is passed back in the R0:R2 register pair.
>>
>> But the BPF trampoline cannot preserve such a return. It saves and restores
>> only 8 bytes of the return value (RAX on x86, i.e. R0), so the second half
>> (RDX / R2) is not preserved across a program that observes the return
>> value. A program attached to a function returning a 16-byte value (e.g.
>> current_time() or ns_to_timespec64(), which return struct timespec64)
>> would corrupt the value seen by the real caller and read a partial return
>> value itself. struct_ops trampolines have the same limitation.
>>
>> This only matters for the attach types that actually read the target's
>> return value: fexit, fmod_ret and fsession (plus the _multi variants of
>> fexit and fsession). fentry and fentry_multi run before the target returns
>> and never touch the return value, so they can attach to a >8 byte-returning
>> function safely.
>>
>> Reject a >8 byte return value for the return-reading attach types in
>> bpf_check_attach_target() and bpf_check_attach_btf_id_multi(), and for
>> struct_ops in bpf_struct_ops_desc_init(), ahead of the following patch that
>> would otherwise let such a return through. kfunc and BPF-to-BPF subprogram
>> calls, which the JIT does handle, are unaffected.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Maybe post this independently from the current patch-set?
> Seem to be a standalone fix.

Okay, I will submit this patch separately.


