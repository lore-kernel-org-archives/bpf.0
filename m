Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57F25A2B4
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625443; cv=none; b=lPFwCvaStFgYaNR1/LkRE8Mg8DTqsaVH5bB9QRXX+xmy3Z9N9XfXPckb/ZN7BmBMPJ6xbqCyiARtlWD4k/sa+vXl/t42LJLDXvDZcuSJPjoRJ43XIA2vduhl46f+qP2RkEpPrUfXGjufzE4QItOsbiGKEMwZcaitNkTaD29k57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625443; c=relaxed/simple;
	bh=4kjkTYxNQW11oVA9POYh0geshLO3N3MT7nsipEm3MaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bT8zc1y5bvgwMA5FUW9UvxYBmPfDRUXRPvELazkClveppjX1d1kgKsvhfO9y5R6yJJGtISaQgdRd3GJlu1XNpMUgGq0MB++iOd1F4/4mhw9dHmePYrOVkNYVdmgiDD7rYn1uu6Qf8uBJJx0mRbKjPZWmKEODlS/pafKG4OkoOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nzQ/l0Gb; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nzQ/l0Gb"
Message-ID: <e989841a-6dc1-49e1-a4e2-773a5a1d144a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769625439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kjkTYxNQW11oVA9POYh0geshLO3N3MT7nsipEm3MaQ=;
	b=nzQ/l0GbaU+NBH+noBsS9SXMu0av8A18VB9MKKlZt0VT+pKwCPE6bJ9kObBuGUej6ofPfz
	kVO91O0HLOGTvHJmIo1QOy4I0Gvkajgbx9oxKt8CIDPib9i2rI9ahmHxTcbYWvSk5xdpOc
	BHpzV72SIVZCKHmvSAf9U5Mb1+ETLKE=
Date: Wed, 28 Jan 2026 10:37:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: don't touch dev->stats in BPF redirect paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 Gal Pressman <gal@nvidia.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dsahern@gmail.com,
 bpf@vger.kernel.org
References: <20260128161030.39870-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260128161030.39870-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/26 8:10 AM, Jakub Kicinski wrote:
> Gal reports that BPF redirect increments dev->stats.tx_errors
> on failure. This is not correct, most modern drivers completely
> ignore dev->stats so these drops will be invisible to the user.
> Core code should use the dedicated core stats which are folded
> into device stats in dev_get_stats().

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
