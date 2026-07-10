Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3B3DB635
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691062; cv=none; b=RivNXb78i34Iw2onZIcS3ObczhQzjxH2uDs4WsONz0x9Ysee/GywqXH4m645gu/LEDT5VYoJABNhbb9Kl7Z9Q/+f0DIWlbEiJZVmf9ODu+WG7YSS/r0+s6pPPkoUOWvamL3wniA9hfOw/JWOsU+nwAgcjyL1TwSeZQXSdnSEoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691062; c=relaxed/simple;
	bh=qwHMDBFWR1k0UWvLNdMIuMrKrhMgKDoR4V6F0IWSv50=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zce3wWOXRRuYfpDF0mxEJTfn7GZfk9dSsaB/sNg8I21gHXsjtPjWQMKR9qCjLHQkhigxc31zle7n6+lj6y+leN3D8LYvT/xvpyC15FZzjGjipnpB9fl1C68AQCaLE29rfaWR34aHGi+oYHF/rmuSx6zNIrrgiufhG7hY8eWEW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G5U0bpbF; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G5U0bpbF"
Date: Fri, 10 Jul 2026 13:44:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783691057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=qwHMDBFWR1k0UWvLNdMIuMrKrhMgKDoR4V6F0IWSv50=;
	b=G5U0bpbF8agEPDE3klPjEPUiVMRwvLWMOCQDLOBiTTFttIkVuITo+SWIKp7K8Z7O+aSQsM
	ia7a1twdK4oDPN2EXFW8J2Sbd6cS4glBsUkcPNiwx+I6hv+a/6cXIh0wAceJlOyz1rbJCT
	8zTWxfRoJNLHUjXvMsCDyrXBKMguYEA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Ben Cressey <ben@cressey.dev>
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
Message-ID: <alD1FJjR5r5n5Eau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi all,

Gentle ping. This has Reviewed-by from Jiayuan Chen and Emil Tsalapatis
and no outstanding objections since Jun 29. Is anything else needed for
bpf-fixes?

On the automated review's flag about the pre-existing double-put on the
bpf_iter_tcp_realloc_batch() failure path (cur_sk/end_sk not reset
before seq_stop, so cookies can be re-put as pointers): agreed it is
real, and it predates this change. As Jiayuan noted, it is a separate,
pre-existing issue best addressed on its own; I kept this patch minimal
for stable.

Thanks,
Jose
