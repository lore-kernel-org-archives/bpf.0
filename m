Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2547CC65
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431302; cv=none; b=IpFe2hOoXVs51xhMIj1lhCvCXPm/bMHbQrtICctHJ6l+Qa9DICHG60pew9/TnPeqMUMqsxS91/Ew92z72V/yZFONafFQ9jvkJM2GvRkJLT8U4STegYG92pgakfVcJCUcGTszvzozuAu/8WxmVBHo1R7REQFF6UScCePoyWu7cIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431302; c=relaxed/simple;
	bh=Hc/+d8JKrbF9Rll2/wvArR2Aj26r3TRoU8M0XLzmrAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOFpG5wGB46TlViSZHYmcbGopI+fOJ2bCjdIfdIp1cWMx+MeB4u1ramJ+j8CDVwlqGCkNzSMRYhHJYHEsMqIeWIQeLo7Fc8q8ncIqwp0DtLPE+TOySnpm1FoVY0/SN/Hu3qO+XvF68WZvhUxPAOuz1NmcjVnjxoPlALcRUwdZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WscFGDMV; arc=none smtp.client-ip=91.218.175.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WscFGDMV"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Hc/+d8JKrbF9Rll2/wvArR2Aj26r3TRoU8M0XLzmrAc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788431280; v=1; x=1789036080;
 b=WscFGDMV0D5RZ+4yKSYTv13zJVRmoc0NR8K8bw3qbBoe3DOTxrmtkOuRM7QNcZ1OG+dsnrtp
 eINg7HxBX37kB0FGnHdPGGCMbRsxk1/6Q4gcoKwioackwUYLugLt+OSwirP2/67UpqX+8xLJAfw
 XnINpuF2oOpzDoMDhoeFIEKs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 38c6c34b8103273a;
	Thu, 03 Sep 2026 10:28:00 +0000
X-Mizu-Trace-ID: 38c6c34b8103273a
X-Migadu-Flow: FLOW_OUT
Message-ID: <0b318536-dcf8-48e0-ba9e-ae6dddcff80c@linux.dev>
Date: Thu, 3 Sep 2026 18:27:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf] selftests/bpf: Add tests to assert that netfilter
 progs cannot write to skb
To: Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com
References: <20260903065845.22762-1-fw@strlen.de>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260903065845.22762-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


on 9/3/26 2:58 PM, Florian Westphal wrote:
> The netfilter framework is allergic to ip header changing after
> validation done by ip/ipv6 stack.
>
> Assert that bpf netfilter programs do not allow skb write access.
>
> Following additional tests are expected to be rejected by verifier:
>
> 1. alter skb->len.
> 2. alter skb->data.
> 3. prog calls bpf_dynptr_slice_rdwr.
> 4. alter location returned by dynptr API.
>
> Add following test case for bpf runtime:
> - alter skb data via bpf_dynptr_write()
>
> Test checks via __retval() that bpf_dynptr_write() returned nonzero value.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>   v2: follow LLM review: rename functions and clarify commit message.
>
>   .../bpf/progs/verifier_netfilter_ctx.c        | 78 +++++++++++++++++++
>   1 file changed, 78 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
> index e2cbc5bda65e..b5d7f567d0d4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
> @@ -113,4 +113,82 @@ int with_valid_ctx_access_test6(struct bpf_nf_ctx *ctx)
>   	return th->dest == bpf_htons(22) ? NF_ACCEPT : NF_DROP;
>   }
>   
> +SEC("netfilter")
> +__description("netfilter test prog with skb write access")
> +__failure __msg("only read is supported")
> +int skb_len_write(struct bpf_nf_ctx *ctx)
> +{
> +	ctx->skb->len = 1;
> +	return 1;
> +}
> +
> +SEC("netfilter")
> +__description("netfilter test prog with skb data write access")
> +__failure __msg("cannot write into rdonly_untrusted_mem")
> +int skb_data_write(struct bpf_nf_ctx *ctx)
> +{
> +	ctx->skb->data[0] = 0;
> +	return 1;
> +}
> +
> +SEC("netfilter")
> +__description("netfilter test prog with bpf_dynptr_write")
> +__success __failure_unpriv
> +__retval(0)
> +int with_dynptr_write(struct bpf_nf_ctx *ctx)
> +{
> +	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
> +	struct bpf_dynptr ptr;
> +	u8 buffer[1] = {};
> +
> +	if (bpf_dynptr_from_skb(skb, 0, &ptr))
> +		return 1;
> +
> +	if (bpf_dynptr_write(&ptr, 0, buffer, sizeof(buffer), 0))
> +		return 0; /* must always fail */
> +
> +	return 1;
> +}
> +
> +SEC("netfilter")
> +__description("netfilter test prog with bpf_dynptr_slice_rdwr")
> +__failure __msg("the prog does not allow writes to packet data")
> +int with_dynptr_rdwr(struct bpf_nf_ctx *ctx)
> +{
> +	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
> +	u8 buffer_iph[20] = {};
> +	struct bpf_dynptr ptr;
> +	struct iphdr *iph;
> +
> +	if (bpf_dynptr_from_skb(skb, 0, &ptr))
> +		return 1;
> +
> +	iph = bpf_dynptr_slice_rdwr(&ptr, 0, buffer_iph, sizeof(buffer_iph));
> +	if (!iph)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +SEC("netfilter")
> +__description("netfilter test prog with bpf_dynptr_slice + write")
> +__failure __msg("cannot write into rdonly_mem")
> +int with_dynptr_store(struct bpf_nf_ctx *ctx)
> +{
> +	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
> +	u8 buffer_iph[20] = {};
> +	struct bpf_dynptr ptr;
> +	struct iphdr *iph;
> +
> +	if (bpf_dynptr_from_skb(skb, 0, &ptr))
> +		return 1;
> +
> +	iph = bpf_dynptr_slice(&ptr, 0, buffer_iph, sizeof(buffer_iph));
> +	if (!iph)
> +		return 0;
> +	iph->protocol = 42;
> +
> +	return 1;
> +}
> +
>   char _license[] SEC("license") = "GPL";
