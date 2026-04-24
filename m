Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2017D6
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776991329; cv=none; b=GgQ26q/dHN0FjJx1uk1bB+tS+NtUXxk50dZe0vvoYBEJnYEKzHW1qPWuIU2+RtUQxMDgLBhRJKQyhfrFSRi36qScrO/MduKPDDSE4DJALalG6zSQehIL2BaL0H9zS0yiCCpfZRKNaAU+CAxJRTXfwf0Uc+H32n+vJAHPdNeskGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776991329; c=relaxed/simple;
	bh=HxasFVtwjC3AOAksdUMADU4qhgML9rAHGFKuZRPB1Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loR/0HA6a9FtP7xz1YMGebdjkl8784EeGL3Jr17bHSLYC2JsiVXoOaAYn/quGS9N3S/NkrWGmQT4vS/zTIRKP/y26QGyGQxc0sxdVn+UFRaPkvshSltFJJcJGGFnFSB01xAvY+LmNth7c283JHF4i6W/XLYowTTpMrrkOt8Iupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZLSlA2s; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZLSlA2s"
Date: Thu, 23 Apr 2026 17:41:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776991324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=potNxk/pM0MniWtXALjT6MlDua7BAZZZoXk/cZMfdQ4=;
	b=sZLSlA2soQ8pThSVn3XG4aIICFiQLDgQm5dkRFbvhTfKjP0oKC87OMh/0x23uR8xA2u6ZG
	PjD3GUkyivNoonqHC1KyHu6/wmt954V1AoZH+ghMKwgIaeU25fINHtVeWfEkLP2ccVbi3Q
	eKAyX8XCGIH9z2hGaUegBhqiyHcVAL4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, Kees Cook <kees@kernel.org>, 
	Fushuai Wang <wangfushuai@baidu.com>, Menglong Dong <menglong8.dong@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf v3] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
Message-ID: <202642403529.Rc5t.martin.lau@linux.dev>
References: <20260422065411.1007737-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422065411.1007737-2-bestswngs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 21, 2026 at 11:54:12PM -0700, Weiming Shi wrote:
> @@ -668,7 +670,11 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
>  
>  		diag_size += nla_value_size(diag->maps[i]->value_size);

This is the same issue pointed out as v1. diag_size is updated with
a smap in diag->maps[i]...

>  
> -		if (nla_stgs && diag_get(sdata, skb))
> +		smap = rcu_dereference(sdata->smap);
> +		if (!smap)
> +			continue;

... and then nothing is stored in skb, so diag_size is incorrectly inflated.

> +
> +		if (nla_stgs && diag_get(smap, sdata, skb))

diag->maps[i] can be directly used here. I fixed it up before applying.

>  			/* Continue to learn diag_size */
>  			err = -EMSGSIZE;
>  	}
> -- 
> 2.43.0
> 
