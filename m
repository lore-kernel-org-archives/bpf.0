Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B8401A08;
	Mon,  3 Aug 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763765; cv=none; b=Q+Gf61Lq4NeZJCuL0duOXZv+VRAkZLhSy0dZbLLeib9V+oYIFK2Th/OtkFM8av7yLXQhQcq5hUIvcDQ3FPLSQ+Rn/QkmXLMk7dfCAhbmgG9Wb+MAuVUrdci1mInCsm9W4G1wYus9UOaRPCsO+1PMZtq8k47cDc9NSjEStCQGe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763765; c=relaxed/simple;
	bh=yn8jsw+4QKQ3tHe1ufSA5Y4pVDUfd6U2P4HJKtq+8NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7HTE3XUksIlBuSwQhmmGACd96wNuY7utAZxKthPxQvsDab4K5bg7CAwC9t80RXtboJX4BBmTGRr0DC5yvRPB0TKCDolCszpPfkAHUz4+RI3nJS8Z1Kcg4AFMIVQLCbAXsdptx123K7WL7SvmxSgqvfqanX1D1nii/anUjacyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Cp4s9GJ8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Cp4s9GJ8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DIKEvCjFiUxOaUWyROjjbnCY/A5WneBoEyL145Ck1dI=; b=Cp4s9GJ87k77UmWE3xLa5fGyjx
	AX5zrTMWkDlmQ8Cl9NyGAclBGdmoROijNVFetalMg6sHpkgjq+s2FjHgxKkN+2m3PfgX4e6y+Ryx/
	IIlioH+favDV8cC8//sBat4dO67lKQ0KDmH7ZyFsQvs3KpOWfRWE8qqrE4pzV6JRPM56ANxbPmvc9
	DnPwGh6pE81xxZVp6W+KmNaaF7AJAB9sHl2G5NBsyXK7bIQSXFmELJ0sE/71/CriMsCH5XGNUTQ6g
	fI7hIq5EoE5CP/EmUW9KuvjxnDiE8F//uyyPfj0NEHqhfyz3Ndq8YljzXgtLbl8eSTAsx8a7+Yasr
	lmGDvteQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wqsMR-000O8k-1M;
	Mon, 03 Aug 2026 15:05:43 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wqsMP-0008bI-1u;
	Mon, 03 Aug 2026 15:05:41 +0200
Message-ID: <dc180ce3-e222-4c67-b44b-f792930afd8f@iogearbox.net>
Date: Mon, 3 Aug 2026 15:05:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/9] Fixes for bpf_jit_free
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>,
 Shahab Vahedi <list+bpf@vahedi.org>, Hari Bathini <hbathini@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Naveen N Rao <naveen@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
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
In-Reply-To: <20260725154915.2488611-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28081/Mon Aug  3 08:25:52 2026)

Hi Pu,

On 7/25/26 5:49 PM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Fixes for bpf_jit_free identified by Sashiko, as previously noted in [0].
> 
> Link: https://lore.kernel.org/bpf/28ba19a4-b487-49fd-bbba-04410acdb113@iogearbox.net/ [0]

Given you need to introduce a bpf_jit_free multiple times in the various
JITs, could you rather look into moving this code into the core so core BPF
code can handle this? Then it would also be easier to test in CI if we can
consolidate the subprogram failure handling.

Thanks,
Daniel

> v3:
> - Add fix for private stack leak on arm64. (Sashiko)
> - Some minor fixes.
> 
> v2: https://lore.kernel.org/bpf/20260725102020.2287770-1-pulehui@huaweicloud.com
> - Fix JITs not freeing leftover jit_data when jit_subprogs() aborts. (Sashiko)
> - Drop fix for loongarch as it's applied.
> 
> v1: https://lore.kernel.org/bpf/20260722112754.1615201-1-pulehui@huaweicloud.com
> 
> 
> Pu Lehui (9):
>    bpf: Extract the bpf_jit_binary_hdr helper
>    s390/bpf: Fix memory leak in bpf_jit_free
>    parisc: Fix memory leak in bpf_jit_free
>    bpf, sparc64: Fix memory leak in bpf_jit_free
>    ARC, bpf: Fix memory leak in bpf_jit_free
>    bpf, arm64: Fix memory leak in bpf_jit_free
>    bpf, arm64: Fix private stack leak when JIT failed
>    riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free
>    bpf: Fix double-free RO header in bpf_jit_free
> 
>   arch/arc/net/bpf_jit_core.c      | 19 +++++++++++++++++++
>   arch/arm64/net/bpf_jit_comp.c    |  6 +++---
>   arch/loongarch/net/bpf_jit.c     |  6 ++----
>   arch/parisc/net/bpf_jit_core.c   | 19 +++++++++++++++++++
>   arch/powerpc/net/bpf_jit_comp.c  |  5 +++--
>   arch/riscv/net/bpf_jit_core.c    |  8 +++-----
>   arch/s390/net/bpf_jit_comp.c     | 19 +++++++++++++++++++
>   arch/sparc/net/bpf_jit_comp_64.c | 19 +++++++++++++++++++
>   arch/x86/net/bpf_jit_comp.c      |  7 ++-----
>   include/linux/filter.h           |  2 ++
>   kernel/bpf/core.c                | 19 ++++++++++---------
>   11 files changed, 101 insertions(+), 28 deletions(-)
> 

