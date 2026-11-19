Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098592;
	b=Hc529XujtliSJk01FqT+w/fWi26d+YDRa5asYllNhzDpFbykZArPe5y7No/N8399JxnK
	 WxhowUthu1KmjHpLp1QsiCU5vd6aCGdwd8sioir1olybYyTa+kZQor3hd57Qd+36tuwfL
	 u004lyRwf1mV8tmi1Fr+x/AP05SgbX58sqtWCgid380+i+4yj8kAgp4WjbOHz6jW9mqiR
	 pV3xHaLSCd5HkX//Icy0lGofG8Qg2s8uRmq83MTharauHG5hClOAnrQLxN/cowuvBLWvd
	 CTfm1M1i3y0Y7Dohgyy/YOuZIowrdEcw+TP3VPx7YTLKz+87vyPB18lcg9i+cSk2vMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098592;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IpS+OvTiHBt9cos72bPyyscFetGZCa8xcAWeKuLcovo=;
	b=Ghv02JeYHlPZl25cNMHJCB0iq+aBEq6V+KQsE8i96qtw/O4WS9zHxc3JvR6cTJFBYZpL
	 3OpEqR6Wa7zUojBM3MdiS9Waz038jp6g6c9NG7/FVjN6bSO0lLVLr+7+Gc+KgZ4MVUIuh
	 l0JwwSfiD8JmaaDEm7tGXYQwJHkBUd6QQkzZovx4CQVIBvxWCuHfBQa/ImVa6y/GDX4BK
	 8dGLZOxzrxvhOJqRtlB38Ta06nCHOE47ZvAOkxdoSORTST4wuCTyDGt7zy9JlF0LrCaBA
	 5XZzExa+6sqGOALaN/pjGGjIlERSe8HYwWQTKQGQUhsyGr8SMuoEaDXOU2vV+1yndkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ugSMqoCk;
	arc=none smtp.remote-ip=91.218.175.180
Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A9606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B1A9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ugSMqoCk
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yiF8K9EPXuxHZY+ZjFT8Mm/qvdcpO8uxIa1zzcDtecw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795098589; v=1; x=1795703389;
 b=ugSMqoCkZvx7zRpLcWqRkrfKZZPhQ6HijDYz7b5lfIVGgOYZtUjwCZdvXDkUDcTrCgV0B9s7
 M7P2I3PxiK7zVEe2I21XlDt8Ef/Mp3la6sQGid0xMRx6C67YUdMZlGHXGd21jPh0iCyF3Rs3bTW
 2lyPk1pnTMxQ5L1Kd5RNtTvE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 04f58529dc36ba04;
	Thu, 19 Nov 2026 14:29:49 +0000
X-Mizu-Trace-ID: 04f58529dc36ba04
X-Migadu-Flow: FLOW_OUT
Message-ID: <8bb22131-7f3b-4b70-a7a6-92f465027350@linux.dev>
Date: Thu, 19 Nov 2026 22:29:39 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: Add "arena" BTF type tag to the __arena
 qualifier
To: Shaojie Sun <sunshaojie@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
References: <20261119102613.811845-1-sunshaojie@kylinos.cn>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261119102613.811845-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Shaojie,

在 2026/11/19 18:26, Shaojie Sun 写道:
> tools/testing/selftests/bpf/libarena marks __arena types with
> btf_type_tag("arena") so that whether a type belongs to an arena can be
> determined from BTF alone:
> 
>   commit a0fa68d8ce75 ("selftests/bpf: libarena: Add "arena" BTF type
>   tag to __arena qualifier")
> 
> tools/sched_ext defines the same __arena qualifier but without the
> "arena" BTF type tag.  Add the tag so that both describe arena types the
> same way.
> 
> checkpatch reports a false positive on the new definition:
> 
>   ERROR: Macros with complex values should be enclosed in parentheses
> 
> The macro value is a sequence of declaration attributes, not an
> expression, so it can neither be parenthesized nor wrapped in a
> do-while loop.  The selftests copy of the qualifier has the very same
> definition and triggers the same warning.
> 
Looks good. Tested on sched_ext for-next: all tools/sched_ext scheds
build and scx_sdt loads and runs fine with the tags present in the
BTF of the loaded program.

One nit: the patch doesn't apply to the current tree since
0a5e9cf2525f ("sched_ext: Sync common and compat headers from the scx
repo") changed the context line to "#elif", please rebase (git am -3
works meanwhile).

Also, this header also lives in the sched-ext/scx repo and the two
copies get reconciled by hand; the most recent reconciliation went
from the scx repo into the kernel tree. The scx repo copy doesn't
have the tag either, so it needs the same change there or the next
reconciliation will overwrite this one.

Tested-by: Tao Cui <cuitao@kylinos.cn>

> Signed-off-by: Shaojie Sun <sunshaojie@kylinos.cn>
> ---
>  tools/sched_ext/include/scx/bpf_arena_common.bpf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
> index 2043d66940ea..fb796b356f86 100644
> --- a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
> +++ b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
> @@ -16,7 +16,7 @@
>  
>  #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
>  #ifndef __arena
> -#define __arena __attribute__((address_space(1)))
> +#define __arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
>  #endif
>  #define __arena_global __attribute__((address_space(1)))
>  #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */

