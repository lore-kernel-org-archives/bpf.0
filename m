Received: from mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0541B8F8
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379408; cv=none; b=nbmsUcZKe51eHS9LRh9EAdWIT+UmRD16engXJv1dTzgpOBw9D2vLrge3rxq/Mq0s25ShTszJWmozxyUzjl5n9SdOhYmi6hIwkcAcBbMFragqk5ujFV5QnUGvkqlhiUaZsOTQRi+C49O/zLDJHBCZe13ERSW5HYrlG3Eb9SA8PI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379408; c=relaxed/simple;
	bh=onMNGAUPGzLJbLSPzwwZ94rQt1DWNH1PEWGM/hMEbiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6b37QE21biZUfyhnzObL3XLOJTeSYrbRYJamaFLmGug/L0hFNxTmvHgXUuCBb5VUbOdZ8o3YxUKWQYLG7cz4i+w0ZDjrJnoK5+A85BTKcVyGmCyrIcD75rz6ZstxzkkrAJVkmtItYqjSS8YazC3I0dabgq2XQT/D5fekwzh/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCYKnuft; arc=none smtp.client-ip=95.215.58.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCYKnuft"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=onMNGAUPGzLJbLSPzwwZ94rQt1DWNH1PEWGM/hMEbiw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786379404; v=1; x=1786984204;
 b=iCYKnuftFEKYbmzrErI7koyD4l4UQF+3Rl/6yqg8r6sb6V9de74oJa2dQinNVyySKV01iWjK
 SnAATgV0svmxw0v0a1z/NOFadRLfGLfSokd+cF8DXzqkUxalDWBQN+v6OeMVt5cOaxthZYdQhe9
 6tzhiRYyZetoOcMDB+6IoulA=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::5:2f4a)
	by mta12.migadu.com with ESMTPS id d4309caf9de555b5;
	Mon, 10 Aug 2026 16:29:54 +0000
X-Migadu-Scanner: mta12.migadu.com
Authentication-Results: mta12.migadu.com;
	none
Message-ID: <e465fed4-7014-4d24-9db9-e8762755bf59@linux.dev>
Date: Mon, 10 Aug 2026 09:29:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Wire up JIT support for 16-byte
 kfunc returns
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190337.1898362-1-yonghong.song@linux.dev>
 <20260808193954.645B91F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260808193954.645B91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 12:39 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Uninitialized kernel register state can be leaked to BPF programs when a kfunc returns an aggregate (struct/union) between 9 and 15 bytes in size.
> --
>
> --- Patch [3]: [PATCH bpf-next v3 03/13] bpf: Wire up JIT support for 16-byte kfunc returns ---
> commit f2df1b40e2f3eb74688d20cd37742fe85c667da9
> Author: Yonghong Song <yonghong.song@linux.dev>
> Subject: bpf: Wire up JIT support for 16-byte kfunc returns
>
> This patch adds JIT support for returning structures up to 16 bytes from
> kfuncs in the BPF R0:R2 register pair. It implements the necessary RDX to RSI
> move for x86-64 and adds opt-in capabilities for the x86, arm64, and riscv
> architectures.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 8dddb5d7af21b..01c34114c8502 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>> @@ -2647,6 +2647,22 @@ st:			insn_off = insn->off;
>>   				return -EINVAL;
>>   			if (priv_frame_ptr)
>>   				pop_r9(&prog);
>> +			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
>> +				const struct btf_func_model *fm;
>> +
>> +				/*
>> +				 * A kfunc returning a >8 byte aggregate hands the
>> +				 * second half back in RDX (the native ABI's second
>> +				 * return reg), but BPF expects it in R0:R2. BPF R0
>> +				 * is RAX (no move needed), while BPF R2 is RSI, so
>> +				 * copy RDX into RSI.
>> +				 */
>> +				fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
>> +				if (!fm)
>> +					return -EFAULT;
>> +				if (fm->ret_size > 8)
>> +					emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);
> [Severity: High]
> In do_jit(), when a kfunc returns an aggregate between 9 and 15 bytes in size,
> could this 64-bit move leak uninitialized kernel register state?
>
> According to the native ABI, the upper bytes of the second return register
> (RDX/BPF_REG_3) might contain padding and be uninitialized.
>
> Since the move is a full 64-bit copy to BPF_REG_2, and the BPF verifier allows
> 64-bit reads of BPF_REG_2 without zero-extending the padded bits, a BPF
> program might save the full register to a map and leak the uninitialized bytes
> to userspace.
>
> Should the JIT mask out the uninitialized upper bytes of BPF_REG_2 when the
> return size is between 9 and 15 bytes?
>
> This same question applies to the arm64 and riscv capabilities enabled in this
> patch, where the native registers (x1 and a1) map directly to BPF_REG_2 and
> could similarly leave the upper bits unmasked.

We should be okay here. The return value will do proper narrowing. See
https://reviews.llvm.org/D131598

>
>> +			}
>>   			break;
>>   		}

