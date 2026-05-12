Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9737DABD;
	Tue, 12 May 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590545; cv=none; b=GzYGHKAKmcmzkTlLCMchiSNXeOStmK2h7pyqgl9XS4epFsPunjYPilTEoiSkvTfyqDfm8vwGQCrvrauifFuvCb9PQwX4Y7uOYTAHVQYuZCYAFL+G/CkXQiiIG0KyyKSdxcywUA+SwfuyJ6MQ1xrqivJ7DgJMmOZqJS8VPlsYldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590545; c=relaxed/simple;
	bh=ZvwjfapDGQuaKnbU2z81fKasUux7FpZEIpj17ocGyPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQKfionHSAOmMwBy4oa4DCttXowZlUptGYUCUHqgrDGqTlYLmk2n6G53sZqohlPqvPCcSVjSjYwOSCGJ+8DzjTdTLTq1IGL1Yh2X3e5bO7JTQvQ3nLjOgky9S4nYYTVjT5basejDLsvQxe87RMRjcjm3CPQhncslF1f2kqmo37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M34P+bsd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M34P+bsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FC3C2BCB0;
	Tue, 12 May 2026 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778590545;
	bh=ZvwjfapDGQuaKnbU2z81fKasUux7FpZEIpj17ocGyPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M34P+bsdqO/3fLNPyq4i4tSWPYBBmwuVLGuDwQzoqYDIl0Hz+PlmxYgt/yJPtulP8
	 TXkRHI85kZj3w8QGTQC2sxyB4kz6csqBUw7RJrvnTIKg8aPd32XNcd1N8jie70cGT4
	 36x//6OlD9EH5VxMZGprCqorOhfb0RNM8VdA9oT+DjpFZ0Kp8nHWhoLuevsBbesv09
	 CaRAgyrX0KwxVtxI3C+WwWeytbt/zTAhtWfsP1XvICuCEjeTxlwqbbejgkpcMBJ9TB
	 ZTUREkmRAcH87UB3IlA1Ug9fjiuLl+t5L4x2pVndmB3obGs9X8nFCyWHL7P4sByxIi
	 BLi0WccAc6gBg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, lorenzo@kernel.org,
 hawk@kernel.org, toke@redhat.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH RFC net-next 0/4] xdp: reuse generic skb XDP handling
 for veth
In-Reply-To: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
Date: Tue, 12 May 2026 14:55:42 +0200
Message-ID: <87ecjgkcs1.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

(veth XDP makes me dizzy...)

> In particular, let's discuss:
>
>   - whether MEM_TYPE_PAGE_POOL_OR_SHARED is an acceptable way to describe
>     skb-backed generic XDP memory that may be page_pool-backed after COW
>     or ordinary page-shared memory otherwise;

Let's start with naming! I'd prefer making it more explicit:

    MEM_TYPE_GENERIC_SKB?
    MEM_TYPE_SKB_XDP?
    ...?


Bj=C3=B6rn
