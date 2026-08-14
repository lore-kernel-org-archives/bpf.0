Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66137B01E
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750517; cv=none; b=KfPN15FaKqBAeT6ulxpmnY19FdB1uYnasqGsLfPXoJgCc1FfdDzj9sE3ORy9kekXt/AFxNQmgqhs9JCExUc1+Qs1svEf56aUxqsdiHmwu2XyFTfkl64hr91mLWnEPvnSnxB54ItAqyO5bwLQXDy5rPwiAFl1TNQs2znE2kUDWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750517; c=relaxed/simple;
	bh=lVIfksuXP+kD7f1XyoGFq0sbZ0Xg6nuHTWI861k2jEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMqvQ4p5mxtJop6r3DIDAPR4aro5T7qTt35JtO16IsuINEEUHSiKWzF8ZDtQE3zM4kZ8recnx+eWj8OLqwkvIw0Rr0gm/EoyJZ6CPQtAwRUkFa4YgtRaBotHkqp5ueEJqBTbpIR+zUsZoAm3Mmon1K6A2lWIcFP/A3ArqrI2mfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=h2etPKRO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="h2etPKRO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QpvyrJcnVvC7YxSsRE3B8B80dORtd5yZl4cAZzqWEJI=; b=h2etPKROPegF+x3rWtVPb0YLnR
	GCJ8aU5Km5BuIh3BapQ6LebFyJph2EmSsS/KudxdI9qi1Q+DqfyiNDKQbwh+5AcgdnLsa42qo2nJ4
	mfCAkq4uSxcayhkKC1S2OZ7Jd6HMYLYvawrIvaSAPXa7alCVevD3VZmG1bKWcaz9DWbuBZdbCRph9
	pMFZm0I4iDa3xY2385keLJAHqf0N6+z8HZ/WF/6J7PWJDoK7ybJn+zPB0+fxE0Rknb0NFC7dSjnww
	1QTl0QZdc5jZYjBU+URQx1Sr0mu1aIFf+/YHKDu3TjnjyfmlEC0fcfz8VHWtlnhTj8WFgrG4jO8oO
	/U8KlY5g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wv1Qc-0008um-1W;
	Sat, 15 Aug 2026 01:35:10 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wv1Qb-000OYx-1H;
	Sat, 15 Aug 2026 01:35:09 +0200
Message-ID: <7b7d309e-5f62-408a-b40a-2eb8f0a88867@iogearbox.net>
Date: Sat, 15 Aug 2026 01:35:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 5/6] selftests/bpf: Add tests for pointer type
 merge at a shared load
To: bot+bpf-ci@kernel.org, eddyz87@gmail.com
Cc: memxor@gmail.com, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260814215301.709827-5-daniel@iogearbox.net>
 <51afcc2b1c0704ce7cec1e6ff7aa6423fee6b3afad0ceebc4a118828ea87586b@mail.kernel.org>
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
In-Reply-To: <51afcc2b1c0704ce7cec1e6ff7aa6423fee6b3afad0ceebc4a118828ea87586b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28092/Fri Aug 14 08:27:02 2026)

On 8/15/26 12:56 AM, bot+bpf-ci@kernel.org wrote:
[...]
> However, the other two commits appear untested:
> 
> bcfd0d6a160f changed check_ptr_to_btf_access() from checking
> type_flag(reg->type) & PTR_UNTRUSTED to calling
> bpf_may_fault_on_deref(), so a BPF_STX through a bare PTR_TO_BTF_ID is
> now rejected with "only read is supported". The changelog documents a
> reachable bpf_qdisc panic (next = sch->next_sched; next->limit = 1000;),
> but no __failure / __msg("only read is supported") case is added here or
> in progs/bpf_qdisc_*.c. Only verifier_global_ptr_args.c and
> verifier_netfilter_ctx.c assert that message, and both do so for
> PTR_UNTRUSTED pointers that the old check already caught, so the
> newly-closed hole is untested.

I can either follow-up together with the hid-bpf one or do a v3 and then add
also a qdisc write test if desired.

> bef47cf76444 states that PTR_TO_BTF_ID|PTR_UNTRUSTED|MEM_ALLOC|NON_OWN_REF
> and PTR_TO_BTF_ID|PTR_UNTRUSTED|MEM_RCU were reachable and left as plain
> loads (two Fixes: tags). The added tests only produce
> ringbuf/rdonly/bare-BTF-ID types, all of which the old exact-match list
> in bpf_convert_ctx_accesses() already handled or which the merge path
> covers.

Covered by the selftest in patch 6/6 (PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED |
NON_OWN_REF and PTR_TO_BTF_ID | PTR_UNTRUSTED | MEM_RCU).

> Would it make sense to add tests for the bcfd0d6a160f store-rejection path
> and the bef47cf76444 MEM_ALLOC|NON_OWN_REF and MEM_RCU cases here?
