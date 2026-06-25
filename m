Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41D383980;
	Thu, 25 Jun 2026 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352475; cv=none; b=YVmPHRGyFwAylsCDmRQVt4v3IRhY3zaugaYMsvimh8R+gFzjeDQa3lQA+J5Rvy0iUwAm4cOvEfWZy/IJFVylqBKrQS6tOk29VAaPDks4WhCYKj2CJO85a8S9sOLZ8UQDKw0aSg16I4hpObfT7tOzEvWKmcO9KjN8MR0Tdfc9W3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352475; c=relaxed/simple;
	bh=97fKS2/77xyGAj6E6rnQNr+rlMBH79HuffSZ9p3mgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHM3z1TRMNMhoueN4kaeGlFsaMYWZIDpFAk341o6J5q3cT3ataFl0UskaHxTcW5alKEjUF5abIO06FyB5eD+rgGc6dou59Z7WnT93v7O1Y47JvGrU3E6BioxJQhQtuZEud5sRXwoATA6cXm+e8WGVnqZ1OubISrE4D+rp+hXlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpkAQxuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpkAQxuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59FD1F000E9;
	Thu, 25 Jun 2026 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352474;
	bh=7R6Poq8sjGJXdHlWLk9FmKhkwwl1mLRpvuQp6vXdjOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JpkAQxuMRLKvWMLzENnWMzqNWPedjCxwzoF/vhwwERpDEob+HLiRWcxkE1Ui0LiNJ
	 LCZtvigND+x8B+T9wnJe1T6umMZA9huUYIqg6GJoLqCYeN033YMx7du4j/5KhLBCga
	 X8c2SYoDdSk1aKyZAXkLuM/LaCxOe4cAR1RrZD10rDIPVgq21+XwNV/aavS5kwCKtZ
	 EkrFbxyEv/DSXIU8mNrliRNhzUBBde+jBnMMBrBsJT/QmjVMZ7jKEoKtMFzB41XZBR
	 f/QvR0N/5c0mAKcg/XEOD2Jc0bZHgtoTBfb2UN+BgWbEAuGfcDX9xH3jbbJYBu+bb3
	 Olurw15xzujfw==
Date: Wed, 24 Jun 2026 18:54:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Siddharth C <siddharthcibi@icloud.com>
Cc: ast@kernel.org, hawk@kernel.org, andrii@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
Message-ID: <20260624185432.32d90aa8@kernel.org>
In-Reply-To: <20260620121321.45227-2-siddharthcibi@icloud.com>
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
	<20260620121321.45227-2-siddharthcibi@icloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 12:13:13 +0000 Siddharth C wrote:
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 5e59ab896f05..8f2d7013620f 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>  
>  		rxq.dev = xdpf->dev_rx;
>  		rxq.mem.type = xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index = xdpf->rx_queue_index;

Do you actually need this or you're just trying to address the TODO?
You can always store the info you need in the metadata prepend.

>  		xdp_convert_frame_to_buff(xdpf, &xdp);
>  
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index dc7b859e8bbf..f419fa0e53e5 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -339,7 +339,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
>  				struct net_device *rx_dev)
>  {
>  	struct xdp_txq_info txq = { .dev = tx_dev };
> -	struct xdp_rxq_info rxq = { .dev = rx_dev };
> +	struct xdp_rxq_info rxq = { };
>  	struct xdp_buff xdp;
>  	int i, nframes = 0;
>  
> @@ -349,6 +349,9 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
>  		int err;
>  
>  		xdp_convert_frame_to_buff(xdpf, &xdp);
> +		rxq.dev = rx_dev;
> +		rxq.mem.type = xdpf->mem_type;

Why are you setting mem_type?

> +		rxq.queue_index = xdpf->rx_queue_index;
>  		xdp.txq = &txq;
>  		xdp.rxq = &rxq;
