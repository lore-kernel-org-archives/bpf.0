Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640025;
	b=w4xxtP/bAMqCaiZdtPjNzDoFnB5UPuARLesyphRY0F9b5hR844l0BD5xhYvFe3NaN6yj
	 LheA0ZnBJJE0sbK4Ni2PeyR87UEcDHb8aiZH16BEsVJyTJgkktMoWNcW0PL/yKMVnvUrU
	 JZzwAsGMGda8Hs0d/NC/BWpmq6AgaJiUOqb916hqNL3v6dzhU64MqvvRg97pOGiag3+Ft
	 jPVuLFqBZEu15ZS4tXpX8Dro875txNiSeK5V+OjoTqvj3xwokOZfQcN026Sz8yi18Sjin
	 t3N9vq1YtEE4H9fdvdiQdspIHypmtosSbUO8JuKezHZXMR4UhBiFxsgNCQkHD7l872g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640025;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=g6pc1fQDzYo8LIZ3Sj7DNdz27l4PFMKRWuYTt7q4Z0w=;
	b=u2fpnhy5glcjr7jd/f0TCvd9hNiRRtMyRGGI2wlIi+IApGsPo/DXNmbxQYOo6Ur2ds1f
	 ur5z7GS48L8rZtWSS3Q/1i4yQIJmNIgQ8QQRquao3CfwloPLbjH7p01OuQidZdYATOzdc
	 VN0FyPUJ3HD3YS0Vr8Uk0uaDE16xTlpE4MKKTpZvO6QOqHwD6sv+oYCsIjD8Nl3dF1Lce
	 XeXgiMimsawlv+POU6PPfdDRqGIrMheQEIZXoFI/oeKOuWXQ8M3CsoYlqd6K6CXpuQZex
	 WQ0Fm9uRUJ1Yn6usyl0462dc9fzZLVYZjVC7HV/Lku1h/R23Ttn6B1O7PlfrmlNibZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=szsLEv9T;
	arc=none smtp.remote-ip=91.218.175.235
Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DF606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D1DF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=szsLEv9T
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9FwKodjy2WUetZrat7gSS2lB32jHVe2L5jLOFxiXhxM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792640021; v=1; x=1793244821;
 b=szsLEv9TpkLZM9yh8PvrqQjqMimh67Y/GxZZQlYDRlTZs6S15SDHLjVNITUrhujzAyD4Utjg
 P3QKhvMhfovuCGodMnBxRH5nmuQWkcy6sIbLPj4KBtz/c4TD4l3oyq5cKzOiRyAaUVOwvmYySby
 b8eXP/ycY8wJR2j2Ql2moOcw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 303f6392ea5a033f;
	Thu, 22 Oct 2026 03:33:41 +0000
X-Mizu-Trace-ID: 303f6392ea5a033f
X-Migadu-Flow: FLOW_OUT
Message-ID: <2254edd4-3b97-46d5-9cca-3490f2ea155b@linux.dev>
Date: Thu, 22 Oct 2026 11:33:34 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] tcp: release congestion control reference on
 rejection
To: bpf@vger.kernel.org
References: <cover.1792607608.git.zhilinz@nebusec.ai>
 <2773af2572ff59055933e407a135b39bca537381.1792607608.git.zhilinz@nebusec.ai>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <2773af2572ff59055933e407a135b39bca537381.1792607608.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/22/26 2:57 AM, Zhiling Zou wrote:
> tcp_set_default_congestion_control() takes a reference to the selected
> algorithm before checking whether a non-init netns may select a
> restricted algorithm. When the check fails, the function returns -EPERM
> without dropping the reference.
>
> For BPF struct_ops algorithms this keeps the struct_ops map and its
> programs alive. For module-backed algorithms it leaks the module
> reference as well. A network namespace administrator can repeatedly
> trigger the rejected request after the algorithm has been loaded.
>
> Drop the reference on the rejection path.
>
> Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp cong to a restricted algo")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>   net/ipv4/tcp_cong.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index 8e83ef81fc187..907c63af14785 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -293,6 +293,7 @@ int tcp_set_default_congestion_control(struct net *net, const char *name)
>   	} else if (!net_eq(net, &init_net) &&
>   			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
>   		/* Only init netns can set default to a restricted algorithm */
> +		bpf_module_put(ca, ca->owner);
>   		ret = -EPERM;
>   	} else {
>   		prev = xchg(&net->ipv4.tcp_congestion_control, ca);


Can we just move net_eq before bpf_try_module_get ?

Since we are not allowed to load it, I think we should aslo not touch it ?

