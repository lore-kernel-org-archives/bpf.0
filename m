Received: from mta0.migadu.com (out-32.mta0.migadu.com [91.218.175.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538533B7760
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777273; cv=none; b=WsrYkkiBwRtWnPGBdyh9EA8EHI8jxCX15LbtF33NHhqKIZNLAn3pWCOvctxWnCXwB6QQA9A4rcCUc2aKgr7sjKtAIUZy2dBGKsArOrKHrHlhfNg2+7LUOnD3xZ2AQjzPXobcpWR4w9EujrXcSHII87mV7ltqvw84kwK7ky39BR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777273; c=relaxed/simple;
	bh=VZs2PnG1QNMoTbgDEYAbANg+bGalW1NrkV9T6fnDWvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DemitueHeXTrOM9EH6vfDme4GmYhTEadixunf0dX+j1Kzx3i69wQ8gOjYflBurXcoflgnd/uMwEKmfBAgdI6J8TX+YFKq/2aqJkp10Jyf8o6wtUXrcGf/yFvSnItq2ffMs5NZc9j5vFK9LOWnXta21MfIoi0tcdgcuyH+JiBHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hedXXUdM; arc=none smtp.client-ip=91.218.175.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hedXXUdM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VZs2PnG1QNMoTbgDEYAbANg+bGalW1NrkV9T6fnDWvM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787777268; v=1; x=1788382068;
 b=hedXXUdMjrKknlhwgODGe3u3yHlMJPsgAOvseg06qxs+S3ruiJh5hvAhHGtT55DEfygE4Oe+
 vmQ5VHMW9P5/jlv5w+QriiGVb1CtQw4GUKDJGxIo6wSDMkJx/qHCaxe4uFpUs54tbbc4Me5mOsX
 y3qoBCapwuSf/Fya5WULYNGs=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21c1::1576] (2620:10d:c090:400::5:7641)
	by smtp.migadu.com with ESMTPS id 8a3f43ee4ba5cca9;
	Wed, 26 Aug 2026 20:47:48 +0000
X-Mizu-Trace-ID: 8a3f43ee4ba5cca9
X-Migadu-Flow: FLOW_OUT
Message-ID: <d27b2aa8-7b88-4a82-bde4-23ac00a7c77e@linux.dev>
Date: Wed, 26 Aug 2026 13:47:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 12/14] resolve_btfids: Drop KF_ARENA_ARG flag
 support
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com,
 kernel-team@meta.com
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-13-memxor@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260821233516.3426127-13-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-21 4:35 p.m., Kumar Kartikeya Dwivedi wrote:
> Arena argument suffixes now describe the address-space contract at any
> parameter position, while the kernel no longer publishes KF_ARENA_ARG1
> or KF_ARENA_ARG2. Keeping private copies in resolve_btfids would leave an
> obsolete second annotation mechanism and silently accept flags the
> kernel no longer understands.
> 
> Derive arena arguments exclusively from their suffixes and retain
> KF_ARENA_RET for functions returning arena pointers. Update the resolver
> selftest to distinguish return-only flags, unannotated pointer arguments,
> and suffix-annotated arguments.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Assuming Eduard's point re selftest is going to be addressed:

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> ---
>   tools/bpf/resolve_btfids/main.c               | 22 ++-----------------
>   .../selftests/bpf/prog_tests/resolve_btfids.c | 22 ++++++-------------
>   2 files changed, 9 insertions(+), 35 deletions(-)
> 
> [...]
