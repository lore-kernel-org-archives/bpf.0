Received: from mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDB3BA244
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145335; cv=none; b=WqN8APQlrwKXURvIhb+TjAEvM3n+M5K8gMqnWrqEE+CFfwIogjBZkmyIszuO6BI4elKk9ofKCeFGMQSMREHbL7oLHFMoceY4c4wylW60VNIfH0busTTzc+dsiMkTaQhkoEdJYDdHG7afszb+Sk6RDxueRSutZk4Upo2uyNRI+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145335; c=relaxed/simple;
	bh=04VesoL9K07t23PCsT244kiVR/YSIrrH1qqvuw0S7zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTuD+2A1eC1/rUB/KSHZXX8LrLBNI1VVIXwvjsRxNmCBk5c2eiZrEp7TTOuWwCZcYlBs5kDkPs8KNQUAoKgCKZzDvxeB+WVXQa+mjW48ZF1kr7GNjq0qJZdhF0W3cmjuFsTvreZ+uihT24sJVO4Rms5R8F08xPYIPqZMc9jxuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WdBglEyV; arc=none smtp.client-ip=91.218.175.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WdBglEyV"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=04VesoL9K07t23PCsT244kiVR/YSIrrH1qqvuw0S7zk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792145332; v=1; x=1792750132;
 b=WdBglEyVCK+X/mKqSiCCDut4GRVKb+L9ofT8djCagZ6KYBDRRaV9mi9a4hsNByUPMIc50kIj
 1zCNRTrOCUeW3vyOUGSiiJNT0jaMAhmE4ioBkehyTLv6p8hk93fX4dlMz7AE3pW2sN7GpPYeccK
 caZME/6J+8SFM5al4eTxjlyk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e276db02176eba05;
	Fri, 16 Oct 2026 10:08:52 +0000
X-Mizu-Trace-ID: e276db02176eba05
X-Migadu-Flow: FLOW_OUT
Message-ID: <118feacc-7f1b-42bf-8951-986e4d37319d@linux.dev>
Date: Fri, 16 Oct 2026 18:08:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: WARNING in bpf_convert_ctx_accesses on narrow loads of
 bpf_tcp_sock u64 fields
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>,
 =?UTF-8?B?YnBm6YKu5Lu25YiX6KGo?= <bpf@vger.kernel.org>
Cc: "dzm91@hust.edu.cn" <dzm91@hust.edu.cn>,
 "dddddd@hust.edu.cn" <dddddd@hust.edu.cn>,
 "hust-os-kernel-patches@googlegroups.com"
 <hust-os-kernel-patches@googlegroups.com>
References: <7a8ff335.1024c.1a14395f3e5.Coremail.kaiyanm@hust.edu.cn>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <7a8ff335.1024c.1a14395f3e5.Coremail.kaiyanm@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/16/26 3:21 PM, 梅开彦 wrote:
> Our fuzzer tool discovered a verifier-bug (WARNING) vulnerability in the BPF
> subsystem. `bpf_tcp_sock_is_valid_access()` accepts a 4-byte load at offset
> 0x54/0x5c — the middle of the u64 fields `bytes_received`/`bytes_acked` —
> and forwards the instruction unchanged to
> `bpf_tcp_sock_convert_ctx_access()`. The converter has no case for these
> offsets, so it returns 0 and the verifier trips
> `verifier_bug("error during ctx access conversion (0)")`.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> ## Root Cause
>
> A ctx load on a `PTR_TO_TCP_SOCK` register is validated by
> `bpf_tcp_sock_is_valid_access()` (net/core/filter.c) and rewritten by
> `bpf_tcp_sock_convert_ctx_access()` — and the two disagree on which
> offsets exist.
>
> The validator's switch only special-cases the u64 field starts
> `bytes_received` (0x50) and `bytes_acked` (0x58), which require
> `size == 8`; every other offset falls to the default case, which
> accepts any 4-byte-aligned offset in the struct with `size == 4`:
>
> ```c
> 	switch (off) {
> 	case offsetof(struct bpf_tcp_sock, bytes_received):	/* 0x50 */
> 	case offsetof(struct bpf_tcp_sock, bytes_acked):	/* 0x58 */
> 		return size == sizeof(__u64);
> 	default:
> 		return size == sizeof(__u32);
> 	}
> ```
>
> The converter, in contrast, only knows the exact field starts: its
> switch covers every field of `struct bpf_tcp_sock` and has no default
> case — an unmatched offset generates no instructions and returns
> `cnt = 0`, which the fixup pass treats as a verifier-internal error
> (`verifier_bug("error during ctx access conversion (0)")`).



Thanks for your report !



I think the issue is that a program can do:
'''
     tp = bpf_tcp_sock(listener);
     /* +0x54 is in the middle of the u64 bytes_received */
     unsigned hi = *(unsigned *)((char *)tp + 0x54);
'''


bpf_tcp_sock_is_valid_access() allows this, but
bpf_tcp_sock_convert_ctx_access() has no idea how to handle such an
offset.

I think we can just disallow the narrower access:

diff --git a/net/core/filter.c b/net/core/filter.c
index ba536be2915f..f0eae1c14b2f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7600,8 +7600,8 @@ bool bpf_tcp_sock_is_valid_access(int off, int 
size, enum bpf_access_type type,
                 return false;

         switch (off) {
-       case offsetof(struct bpf_tcp_sock, bytes_received):
-       case offsetof(struct bpf_tcp_sock, bytes_acked):
+       case bpf_ctx_range(struct bpf_tcp_sock, bytes_received):
+       case bpf_ctx_range(struct bpf_tcp_sock, bytes_acked):
                 return size == sizeof(__u64);
         default:
                 return size == sizeof(__u32);

