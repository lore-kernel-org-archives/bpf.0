Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D12D633
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GTx1GB1M"
Received: from out-199.mta0.migadu.com (out-199.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8E6B0
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:46:13 -0700 (PDT)
Message-ID: <6e2a62c8-5ec5-601f-1c3d-3eb79d8c8a41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698187571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5RhZS2ILbCf9SkA7iWts82XtnOI/rfnd/taKDVc1/Y=;
	b=GTx1GB1MgOzy1MIeKGQTPEnc6Yhbteov2fxBEQ67lZ2dxwjxE6A0rRv69hU61pR42JjMh4
	WS6wuLxOY804aRfna6zenaKTHsJ9pkK5cuPr6dwXIW5oX2ukCMn0xlTjPeuyVkH1ekqnB+
	LBckIXqFYJmsUk+7YCdl4N1Ydh6aSy4=
Date: Tue, 24 Oct 2023 15:45:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 0/7] Add bpf programmable net device
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch
References: <20231024214904.29825-1-daniel@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231024214904.29825-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/24/23 2:48 PM, Daniel Borkmann wrote:
> This work adds a BPF programmable device which can operate in L3 or L2
> mode where the BPF program is part of the xmit routine. It's program
> management is done via bpf_mprog and it comes with BPF link support.
> For details see patch 1 and following. Thanks!

Thanks for the work on this. We have been testing the earlier version in a 
production service and we see at least 3% cpu win when comparing with veth.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

