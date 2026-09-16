Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA34EBAE1
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559568; cv=none; b=i6S7FsEQwnmwZFPch4rvXLcnlOBESjyPOBRlvc7DrzHjs+TeTpwZO40LK+fksddoU/kKRpaOOmmhQ4qgSMhxrk50KacHsWldl4FDqBCzDVEdTz2emlUsgoW0BevQod8uxLxXM2sISCquzSFfrWN+jZ1/o/ws5y8GLaDIl4G5mvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559568; c=relaxed/simple;
	bh=b0NEGM5P9ejw+y759tU6Ms/7JC3kNCS6nkahtEALWro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKU1iPae6ZFTKUSKKnOBacF0jGOdHcnwjJPF2qt6xFfxc4GztqDzUocM//1oZfpd9IV6gFN9sbaH3stqEYYnCqmMd6ozJeBk57aTVoQ8i9Vv4xc8aZYiGXGjLOwkRKvaKl5PSZdddeHIuqJlJ+RhNJkDU9FaU6znS7VuJe4F4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qZr+we1r; arc=none smtp.client-ip=91.218.175.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qZr+we1r"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b0NEGM5P9ejw+y759tU6Ms/7JC3kNCS6nkahtEALWro=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789559559; v=1; x=1790164359;
 b=qZr+we1rXCmQsDV6ERJV6oMXI0b0vcG5nTuQ9ANKrfp7jGu13M+vPHcIsjFiXH2OweD8HTmO
 KgzrIzUEfZPi4ujo60XuOgWL4ueQo1d3SMmq+GNZLJQCzlpeGBDO4tgZfjKUFBqBU4vyMZ8alCH
 ZAtSGZ5YJFAtndBrgbV9Quos=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 398c99d9fb63ffb8;
	Wed, 16 Sep 2026 11:52:38 +0000
X-Mizu-Trace-ID: 398c99d9fb63ffb8
X-Migadu-Flow: FLOW_OUT
Message-ID: <a6b0f8c6-3564-498d-bef7-2a528333c0a3@linux.dev>
Date: Wed, 16 Sep 2026 19:52:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 01/11] bpf: Fix bounds check for skb-backed dynptrs
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 daniel@iogearbox.net, netdev@vger.kernel.org,
 Nicholas Carlini <nicholas@carlini.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
 <20260916050830.8774-2-emil@etsalapatis.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260916050830.8774-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/16/26 1:08 PM, Emil Tsalapatis wrote:
> The skb_pointer_if_linear() function checks whether a
> memory region of length len starting at offset off into
> the skb is in the linear area, and returns a pointer to
> the region if so. The check currently subtracts between
> skb_headlen and offset of the check, and since skb_headlen
> is unsigned the subtraction can underflow. This causes the
> bounds check to spuriously pass and generate an arbitrary
> pointer of the form *(skb->data + off).
>
> The only user of this helper is currently skb-backed BPF
> dynptr code. Returning the wrong pointer leads to the
> dynptr erroneously being backed with invalid memory.
>
> Ensure the subtraction cannot underflow, and fail the check if
> it would. Use u64 arithmetic to also prevent overflow when
> calculating (skb_headlen(skb) - off) since off is unsigned.
>
> Fixes: 6f5a630d7c57 ("bpf, net: Introduce skb_pointer_if_linear().")
> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>
> While the code for this is in skbuff.h, the only consumer is
> BPF-related, as is the selftest that validates it in the next
> patch. So I think it makes sense to route through BPF. If there
> are any objections I will split the patch off and resend to net.
>
>   include/linux/skbuff.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 421f6fc45..d0c1463db 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4372,7 +4372,8 @@ skb_header_pointer_careful(const struct sk_buff *skb, int offset,
>   static inline void * __must_check
>   skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
>   {
> -	if (likely(skb_headlen(skb) - offset >= len))
> +	if (likely((u64)offset <= skb_headlen(skb) &&

trailing whitespace after "&&"

