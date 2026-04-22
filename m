Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D91347FFE
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891817; cv=none; b=r9zN8CsNBvZdsLqRFaI3v+0C4IxZngAeEo+3SWzAc6hG6y/nPYuyD8MG+9KbhbH1JQ1tPNCK+hoqIFD0NhwI0Ex8G/Fib4Ml2dplUWGO+nS2WcM4I+4CliIfhuv+wW1wALU4m5Tu30/ZRTJJowr9/SBsWC3YXHvBJjLZo7h3MUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891817; c=relaxed/simple;
	bh=XWLOYO1gKbrrrBDEFkh8O1EcFuPow71n79j2gD5SDlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av9GEBxz1c1Y8FgZO4hntIFMYZvfRLqRcgDy6wAFWfCxLM9cmgVi2Ej/C7kuomJxE/JNUCwFb7/Af1rlfG6EndEgjsH+vOSy/WXnoKnKJCzBghUwghRkmp3k78D4l+FtIW+0hfVazbIrPAoEwD0Ur0dMlZ8XLnjgQUX5TlNJffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqdPfp8j; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqdPfp8j"
Date: Wed, 22 Apr 2026 14:03:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776891803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RYkjy4WCea2cSCblSBZyO98tvVtY1skLCklo2d0JXqM=;
	b=RqdPfp8jkNesnz71XLeUWehb1/ED5gNVGRrMoDkXFwa3EONIQXLPt/Cp98x3clQzJW7h66
	rd/60f+flZHorRlAq1WcLYfv1K800LusVLxNF4a8TJhuVSjGENYmgVl3ph8K5P5HXnO72A
	dXe87x8k7amX3pyNhDZGdoqmbe6k+6w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Werner Kasselman <werner@verivus.ai>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Lawrence Brakmo <brakmo@fb.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v5 1/2] bpf: guard sock_ops rtt_min against
 non-locked tcp_sock
Message-ID: <2026422205858.dBi3.martin.lau@linux.dev>
References: <20260417023119.3830723-1-werner@verivus.com>
 <20260420230030.2802408-1-werner@verivus.com>
 <20260420230030.2802408-2-werner@verivus.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420230030.2802408-2-werner@verivus.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 20, 2026 at 11:00:35PM +0000, Werner Kasselman wrote:
> sock_ops_convert_ctx_access() reads rtt_min without the is_locked_tcp_sock guard used for every other tcp_sock field. On request_sock-backed sock_ops callbacks, sk points at a tcp_request_sock and the converted load reads past the end of the allocation.
> 
> Extract the guarded tcp_sock field load sequence into SOCK_OPS_LOAD_TCP_SOCK_FIELD() and use it for the rtt_min access after computing the sub-field offset with offsetof(struct minmax_sample, v). Reusing the shared helper keeps rtt_min aligned with the other guarded tcp_sock field loads and preserves the dst_reg == src_reg failure path that zeros the destination register when the guard fails.

I think some formatting instruction was not given to the AI this time and
no human bothered to look at the formatting of the commit message
before posting?
