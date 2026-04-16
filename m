Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF723328E6;
	Thu, 16 Apr 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360972; cv=none; b=up6bbFrvr+QzHR07ozc42kYPzE2S7LNx0kBlK/DO75Pe7I2hss6Fv+4k/7FAFRC9aTFZKiIHaelyIGXknQO8moBv/HQgCdi9PGyW8fPH/tdRtTxi2Oc/mfqmK+T5PusV97zNEG6dwwjENmTUGDQuhXJzJj6KazhMbC5S48b5P80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360972; c=relaxed/simple;
	bh=RBcdUNeiuxQhZM2AmCxegew49tM6tiBBvfRnq9aHa0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onGiN9Rwj/ZTgJu3mPkxQANzrZH9y4AoRjDWB4J6O1/E1h3fOpQ/T7VTdkA/fs2tXX+fvfYm9rHB4t102rg+okIgPVbHFKtLaAUH5rCbtBPcEF5QM1aCq26vuQOHB3DSQHwINpLBfWhNVgaWvvFkVU/3wbGyd6qcqFb0VIhbu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZPD+uEBB; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZPD+uEBB"
Date: Thu, 16 Apr 2026 10:35:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776360957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+cMC9sJAEt/m6pKNklcs18kvSXvKFvIm/NxmPOPEhQ=;
	b=ZPD+uEBBlyHoCcdRlupt2N4WUxENhYQCZ44ETOUU1s747pMml8MzUKzOP72O+ssEpTJZ/G
	esZrvITraissYGZtxL6KqdLogbiuZW0VBLD63AAwFus57n+Nf+rSosM5hDp5K54VWxuY/3
	VQF+sD/yp4ds41udte6F9ft7vhjKKT0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, jiayuan.chen@linux.dev, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>, 
	Kaiyan Mei <M202472210@hust.edu.cn>
Subject: Re: [PATCH bpf v2 1/2] bpf: Reject TCP_NODELAY in TCP header option
  callbacks
Message-ID: <2026416172759.GIuu.martin.lau@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
 <20260416112308.1820332-2-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416112308.1820332-2-kafai.wan@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 16, 2026 at 07:23:07PM +0800, KaFai Wan wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index fcfcb72663ca..911ff04bca5a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5833,6 +5833,11 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>  	if (!is_locked_tcp_sock_ops(bpf_sock))
>  		return -EOPNOTSUPP;
>  
> +	if ((bpf_sock->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
> +	     bpf_sock->op == BPF_SOCK_OPS_WRITE_HDR_OPT_CB) &&
> +	    IS_ENABLED(CONFIG_INET) && level == SOL_TCP && optname == TCP_NODELAY)

IS_ENABLED(CONFIG_INET) is unnecessary.

pw-bot: cr

> +		return -EOPNOTSUPP;
> +
>  	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
>  }
>  
> -- 
> 2.43.0
> 
