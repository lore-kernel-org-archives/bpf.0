Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0DD125B9
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254604; cv=none; b=rvZtlVBe3IvwHY8DtYkCgZXOcxSsQf0MXEkcc3uGfebu8NiOi+J3bvlbqDgx+1oLo1DuLXS4Eo37Jk7vrLE0lGFP4ioNIzeGDNqBZ1GrfQYQR1hYcuCCEsw8LVdrHESta4qXMWWiAov12jygQFMYmNT1uv5VKaIkV1kwmeQjBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254604; c=relaxed/simple;
	bh=ay9rqbwPdEL3/K0XTM1FN+squGu+MpLVdNAwwh++ujE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOiZ+pVTXrLt7mKdA+CLonEU7/UOYuloRFbIMqs+NG1a7SKVgZVl7w6CBAnmW70m7UK6YZXxpWJoS0R5vlRUi1BmFXkuGRfi/0fOEYTMyJuUZZ0mvMQSRHi9u+Fe93uko+NgVBmbeFASpXBIQPLCFclbemenc9HZ8+MKjFFV2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QshomPNe; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QshomPNe"
Message-ID: <3ae7e58f-e62f-4d53-8b39-6e3fe1810014@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712254600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxXdxC45P5LTjibWhGcxbXK7mvQMrll6M3dPtOtemv0=;
	b=QshomPNeAIvASi+IZHnlD1StsiPntprXnVvvcCsxA176GJPUYsENxfLbXzDmPLSyGiJGWu
	eiX5EFzY0e49JEimhtUQ4FHU3UIFt1ty8qqWr20yzA000eJpcdooefD03GRk2oXFUtvs2Q
	KIFBJFNRvcyDQ+jFGsEjbSxEFZ0ftMM=
Date: Thu, 4 Apr 2024 11:16:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: vmlinux.h overlap/conflict with network protocol definitions
Content-Language: en-GB
To: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Boccassi <bluca@debian.org>, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com
Cc: bpf@vger.kernel.org
References: <20240404100901.7d6bc10f@hermes.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240404100901.7d6bc10f@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/4/24 10:09 AM, Stephen Hemminger wrote:
> I am fixing the use of TC BPF in DPDK to use libbpf and bpftool.
> Luca recommended using vmlinux.h to address possible build and
> CO:RE issues. But it won't work.
>
> There are missing pieces such as definitions of IPV6 next header
> fields (in linux/ipv6.h) and TC actions.
>
> Without major hack surgery, not possible to use vmlinux.h instead.
> Since vmlinux.h defines may things that overlap with other headers.
>
> Using:
>
> $ /usr/sbin/bpftool -V
> bpftool v7.3.0
> using libbpf v1.3
> features:
>
> $ uname -r
> 6.6.15-amd64
>
> The change to BPF program to use vmlinux is:
>
> diff --git a/drivers/net/tap/bpf/tap_rss.c b/drivers/net/tap/bpf/tap_rss.c
> index 888b3bdc24..79f4ee31a1 100644
> --- a/drivers/net/tap/bpf/tap_rss.c
> +++ b/drivers/net/tap/bpf/tap_rss.c
> @@ -2,12 +2,7 @@
>    * Copyright 2017 Mellanox Technologies, Ltd
>    */
>   
> -#include <linux/in.h>
> -#include <linux/if_ether.h>
> -#include <linux/ip.h>
> -#include <linux/ipv6.h>
> -#include <linux/pkt_cls.h>
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
>   
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
>
> Resulting build failure is:
>
>
> ~/DPDK/tap $ ninja -C build
> ninja: Entering directory `build'
> [1/33] Generating drivers/net/tap/bpf/tap_rss.bpf.o with a custom command
> FAILED: drivers/net/tap/bpf/tap_rss.o
> /usr/bin/clang -O2 -Wall -Wextra -DTAP_MAX_QUEUES=16 -target bpf -g -c -idirafter /usr/include -idirafter /usr/include/x86_64-linux-gnu ../drivers/net/tap/bpf/tap_rss.c -o drivers/net/tap/bpf/tap_rss.o
> ../drivers/net/tap/bpf/tap_rss.c:116:8: error: use of undeclared identifier 'IPPROTO_HOPOPTS'
>                  case IPPROTO_HOPOPTS:
>                       ^
> ../drivers/net/tap/bpf/tap_rss.c:117:8: error: use of undeclared identifier 'IPPROTO_ROUTING'
>                  case IPPROTO_ROUTING:
>                       ^
> ../drivers/net/tap/bpf/tap_rss.c:118:8: error: use of undeclared identifier 'IPPROTO_DSTOPTS'
>                  case IPPROTO_DSTOPTS:
>                       ^
> ../drivers/net/tap/bpf/tap_rss.c:126:8: error: use of undeclared identifier 'IPPROTO_FRAGMENT'
>                  case IPPROTO_FRAGMENT:
>                       ^
> ../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
>          if (skb->protocol == bpf_htons(ETH_P_IP))
>                                         ^
> ../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
> ../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
> ../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
> ../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
>          else if (skb->protocol == bpf_htons(ETH_P_IPV6))
>                                              ^
> ../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
> ../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
> ../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
> ../drivers/net/tap/bpf/tap_rss.c:248:10: error: use of undeclared identifier 'TC_ACT_OK'
>                  return TC_ACT_OK;
>                         ^
> ../drivers/net/tap/bpf/tap_rss.c:252:10: error: use of undeclared identifier 'TC_ACT_OK'
>                  return TC_ACT_OK;
>                         ^
> ../drivers/net/tap/bpf/tap_rss.c:256:9: error: use of undeclared identifier 'TC_ACT_PIPE'
>          return TC_ACT_PIPE;
>                 ^
> 15 errors generated.
> ninja: build stopped: subcommand failed.

This is a known issue as currently vmlinux.h does not support macros. 
There are some efforts by Edward Zingerman to support this but this has 
not done yet. At the same time, you could have a trivial header file 
like 
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/bpf_tracing_net.h 
to be used for bpf program and then your bpf program with vmlinux.h can 
have much easier CORE support.

