Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76A3A16BD
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 04:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212595; cv=none; b=drsGG5AtyeOqeWzpupXJSsu7q06MftwLZ1xi7Nrw9ZL3BcGPta+6OrP3pxC7kq28zb1GfgqNJ8rQR35qK/NiF3/cC4IqUjHZnJ0Ua7S+fYPG9D4wpXbIHRtSN7kyc211mbwPTMP/meGIyVxbLncb1XIx+IGhbZLwgUuwHqxE8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212595; c=relaxed/simple;
	bh=TGNUtlzcqY1P0l7Ld9Olaev6+4JPSpGSs0HEs8+9g6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F568nAdn1P4W+/i2rKOVEuJ+AbCb5QW/Z6Lgpo8ooCaCIH0uItulDeamvUcB4jIJooYkCsZqac/wbd5BT45ZpdG9eCj0gFZSLvZYaUD8IuR3soZ5DF8HbQ6tofYHiUl8WLve6KS7HUa+PzS+U3nHAARDOZyiKtzwk2cCOkDXYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UcdmH5j2; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UcdmH5j2"
Message-ID: <1c4223ae-a5ba-48a4-95d3-57c8ff241055@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785212588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=loCaw01zYermZc184KvYX0XdLbykKDciymMOX//UDlY=;
	b=UcdmH5j2VsED5QUt+XL5bhfSLvqApOiKgld0gjO8LbajVxDsLwyxBvIJzUvAjKje1SvX+Q
	Xeq3IRDCbWDVkbi16du6EEJbu0f28K9i2NdBdNEAX9YbB89ix0iVQxhylYN4nTf8BO5OaL
	qdXN36AiiibkeAxhRbJqyxAXwcF8jeg=
Date: Tue, 28 Jul 2026 12:22:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 0/3] bpf: Fix trampoline handling of 128-bit
 values
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260728035437.3007984-1-yonghong.song@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260728035437.3007984-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/7/26 11:54, Yonghong Song wrote:
> The BPF trampoline preserves only 8 bytes of a target function's return
> value (R0), and its register save area under-allocates space for 128-bit
> arguments for x86_64. These two problems lead to memory corruption or
> incorrect values observed by BPF programs and the real caller.
> 
> This series fixes both issues and adds two selftests, otherwise, each of
> them will fail if without the corresponding fix.
> 
> Changelogs:
>   v3 -> v4:
>     - v3: https://lore.kernel.org/bpf/20260710225206.4013062-1-yonghong.song@linux.dev/
>     - Add Ack from Leon Hwang


Seems you changed my tag from Acked-by to Reviewed-by.

No worries, Reviewed-by is fine with me.


>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20260710182204.1085329-1-yonghong.song@linux.dev/
>     - Align __int128 argument at even position enforced by arm64.
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20260710144404.2579671-1-yonghong.song@linux.dev/
>     - Also handle __int128 arguments for x86_64.
> 
> Yonghong Song (3):
>   bpf: Reject >8 byte return values on return-reading trampoline paths
>   bpf, x86: Fix trampoline stack size for 128-bit arguments
>   selftests/bpf: Add tests for >8 byte return value and 128-bit
>     arguments
> 
>  arch/x86/net/bpf_jit_comp.c                   |  7 ++--
>  kernel/bpf/bpf_struct_ops.c                   | 12 +++++++
>  kernel/bpf/verifier.c                         | 25 +++++++++++++
>  .../bpf/prog_tests/tracing_failure.c          | 12 +++++++
>  .../selftests/bpf/prog_tests/tracing_struct.c | 36 +++++++++++++++++++
>  .../selftests/bpf/progs/tracing_failure.c     |  6 ++++
>  .../bpf/progs/tracing_struct_int128.c         | 18 ++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    | 32 +++++++++++++++++
>  8 files changed, 143 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int128.c
> 

