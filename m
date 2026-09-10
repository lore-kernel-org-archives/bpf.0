Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0A46C835;
	Thu, 10 Sep 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038956; cv=none; b=X8+BPJaGS5UdWqlGdhBrBjK/lmd9S0N5n0xIEgWF2wuoW0k9vTFcWPW5Pk2MMBZz6wQfXSxrb+RxCZHsbiZEL414sdpE46mtpKsIiYigH1UutQkEkYVckv1q3bUUxeQQBaFvmjmkgKEW7Ned/QnVzt1uIR2PJzOFbp3kWRFe67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038956; c=relaxed/simple;
	bh=1YTVDq/mdUrpccGJkEkKc5xC+w/1lymnfmABkq7CdkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qczVaFcH1ATt3nv6To0g2iQKHIebTNTYpuTsZlDY+5n0sJRg2rD+juGOaCuOApzasMc1/ySxi6jbgW096F/aZdWyniHeS0rme/0K3FY+jzLu0xjU0mxBX4zwW/3k5u4NP6F4iBJrrrQgg6QZ1gPwXvqYofRIcs5J7WLVNC+uVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HkOwKv1S; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HkOwKv1S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Q/dVO1hurmYsv9r6dtuBASl/RqXWuN50sq2e8VQMJTc=; b=HkOwKv1S2RBm4S3e3i98Oc6fEV
	glCqvZUEotlt5YhykoTUCTIXgjjMJLDH8KoAVgx45/bsbmJT7sbwkva2jPAqEztNMZz5YEweT3g6b
	ZdMb9j7FezrJQmHAA408f15Yo2vFYUqUk2Dj+HSYJuoZFgYTjxxix4reiebBRfogATfBaUW/SMdLA
	mOjfCktjod1f69rRgjnb1ToEmylDqkAFg40SSPOFzi16ApkKafWKh9W5h8Rf0dKQEjjT24KrI/cPO
	+huoqzRHhP+094HWEYPEcaoQF6PcNnzFlnFmA3L1OG5EHwAmmpIIa3cJ/qbyYB/zayPxzwtCAXmX0
	aSAnxjHw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4ckw-000Pdw-2e;
	Thu, 10 Sep 2026 13:15:50 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4ckw-000KXD-1m;
	Thu, 10 Sep 2026 13:15:50 +0200
Message-ID: <67538d7b-90df-4f77-9791-291968afa742@iogearbox.net>
Date: Thu, 10 Sep 2026 13:15:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/6] bpf: Bound the number of indirect jump edges in a
 program
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260909204035.24289-1-daniel@iogearbox.net>
 <20260909204035.24289-2-daniel@iogearbox.net>
 <20260909205701.9C76C1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20260909205701.9C76C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28119/Thu Sep 10 08:24:09 2026)

On 9/9/26 10:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Integer overflow in jump table size calculation leads to massive out-of-bounds memory access.

false positive

> commit 4185a35dbc8e33f3114fd8855cb5ca01b0ecf5a9
> Author: Daniel Borkmann <daniel@iogearbox.net>
> 
> bpf: Bound the number of indirect jump edges in a program
> 
> Bounds the total number of gotox edges across the program at
> BPF_COMPLEXITY_LIMIT_INSNS to prevent excessive memory and CPU usage
> during program loading.
> 
> Reported-by: STAR Labs SG <info@starlabs.sg>
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
>> index 081f7003eae66..e9910228da587 100644
>> --- a/kernel/bpf/cfg.c
>> +++ b/kernel/bpf/cfg.c
>> @@ -388,6 +390,19 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
>>   			return PTR_ERR(jt);
>>   
>>   		env->insn_aux_data[t].jt = jt;
>> +
>> +		if (check_add_overflow(env->cfg.gotox_edges, jt->cnt,
>> +				       &env->cfg.gotox_edges) ||
>> +		    env->cfg.gotox_edges > BPF_MAX_GOTOX_EDGES) {
>> +			verbose(env, "number of indirect jump edges in the program exceeds %u\n",
>> +				BPF_MAX_GOTOX_EDGES);
>> +			bpf_diag_program_structure(
>> +				env, t, "too many indirect jump edges",
>> +				"Reduce the number of indirect jumps, or the number of distinct targets they can reach.",
>> +				"The program has more than %u indirect jump edges in total, counted over every gotox instruction.",
>> +				BPF_MAX_GOTOX_EDGES);
>> +			return -E2BIG;
>> +		}
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but it is a pre-existing issue
> in the CFG discovery logic that remains unfixed in this patch series.
> 
> Can jt_from_subprog() in kernel/bpf/cfg.c overflow the shift operation
> when calculating the size for memcpy()?
> 
> If a user with CAP_BPF creates an INSN_ARRAY map with a very large
> max_entries (e.g., 0x20000000) and populates it, jt_cur->cnt can be up to
> map->max_entries.
> 
> In kernel/bpf/cfg.c:jt_from_subprog():
> 
>      memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
> 
> If jt_cur->cnt reaches 0x20000000, the expression jt_cur->cnt << 2
> evaluates as a signed 32-bit integer, resulting in -2147483648.

Anything above max entries of 0x1FFFFFFF gets rejected, so this should not
be possible. I tried to reproduce the above and can confirm this is the
case.

> When passed to memcpy(), which expects a size_t, this negative value is
> sign-extended to 0xFFFFFFFF80000000 on 64-bit systems. memcpy() attempts
> to copy over 18 exabytes of data, causing a catastrophic page fault.
> 
> Additionally, if max_entries is 0x40000000, the shift results in 0,
> leaving jt->items uninitialized before it is passed to
> sort_insn_array_uniq().


