Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC2372685
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889666; cv=none; b=DBKFeADljkOcTE/OPurucguGGK4bPTr8TKTAv9599Rjy62dIyDbHuDz2HrIzqJcTFwbe8dxk9g1C5Xl8M2lwtAhBqIQCZ5ndxAhpyw8k5UjNfW4lCBM5ctPhIUHFMHHoOdigXn+4x9jaaZqYo2/s63TZQbMgC9/TN9YN2sQlUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889666; c=relaxed/simple;
	bh=Z2pD7SzCnfwOR5N0cjRioBufHqwxBlEZjSb7T01ucEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+b1sfZQNQkBEheyJcX7s/Hf2Mo68BcmoNHeu3o+vYZRNuWXp23nolD2T2jaLRqGI4ZClFZwSPG+Qqf3l1LW2sE2daG1YpFHRiwRvJzc5fyvHxNAFQCnf0TYr2Cy/+UYc+7rnFI8JYbOApTqlRLKQ2LO0tzDMkS7IqsIUtGL4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9yB3agN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9yB3agN"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso77303125e9.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776889663; x=1777494463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICar/pXdHGmmlf+IZ7pyC9kCaI/pqNFA9o2Llqb73rk=;
        b=p9yB3agN9WcRdyXtijq7/Oz7JBrE2jzsQQ7ymtY43U+ie8uoJw0xTCclXS1OPhK92u
         Z6qdAQ3YH4us6+Iqrqp65vMUP3hNy3Qj+MhzMFvtYRslcElzNBRy+MVK1sTDlbz9Zwl4
         W9MKtci//R/tsvv4fAyrqiN6yzYSDnXkwsT3k0DJWNB7OjtEurP3kVRNyfAKP2FBCwtr
         3EVzbPy0KxjZcWsbZ8f02AuQumTQ83pxmYB2dpNeS2dCmWa0Sn+GbCS3mvTB71c3ApSr
         6QkEkELj9SJrMEjvIlFdXPIm43WbIdGNZFsvlV6CcOxokb965F+thFY+TmdnZmpVTU0r
         bmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776889663; x=1777494463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ICar/pXdHGmmlf+IZ7pyC9kCaI/pqNFA9o2Llqb73rk=;
        b=d3dp3AP7vApwX1sghUUWIijJ2oXXktWzS4pApoNgt5tr+xyywGkJWwM0VO6SWBsmvR
         3T35DfZZyMMfRm8uCDlfBs21vkw0yrqAYT+MmV8zR7LggIhxFU0NQwMsBa/I+44fubQx
         v1uHIurguKE2vMCUCC4Xxeqh7uAtOwo+670Ciwm7OOCM2ED/ZH4mPQcYkHjLEot78jwU
         HkAxxk6qHQd3iQ7yzX8a9av/yWc55caySp606asUIZR+93dlCSwtQXuAB03xnnNYnLFv
         UAzo++Gvq2g4uKG7S3fTskIAQmsPwFkvs4jP9yOTjRSFfsAW+QIUtxD/k0rrlK/b1tAc
         KFAw==
X-Forwarded-Encrypted: i=1; AFNElJ+tQkdVrbonpfqsjo1MqtPifz0JI3he9dB88Fu/WtYk7P9FYA//bnbNl2cDQodEwLP1lNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSyvS6B3SnKiS2no16yq1gk30qL/D40g9UVV/ZzwRcuTI6PoW
	RWJi5pSvS7KR88CzR1q3pgv21fILVce9g0WMJsBWYVLEAr8i8HJ02iNs
X-Gm-Gg: AeBDiet1ThK+zCW/ln+Y0wGQ707VdMsAzc9ScyVMudnL3xgV+rnoI7xUO5UD1SF9u2J
	zCBEr+8dWlyIa4tdCmLI6gldxL/u7UJwET0id1Z2tOQvVSePfk5AgvvbIgcxy9+nGuTmg5Hcd0+
	qpUnwOQJQ+Nn4xBrRllgy5eQ/XfrHi6cXXIO806g7HtSYDpA9+EoOZdBb293wVHfP9wve8Y2bQm
	Qsqpykf/EbtauWaP57YOhwpIpNi4wI2RW6L2f6tOIuNFu9Hx/QtUKyWsC1JYhsGkFHLxwvvVQFF
	FLpVnCFH5mrXMuEHSpDoMeCIYjPYXRUH4q7mv801fWmkPNTpxetvI9kqS9k+AZx4GCUAHyY8HPU
	PUqAgQwC92Lc5vmggoAI4MxUCvTdAEuSI8GUcmWXn5lnwLMZKfExpsDhpBvfhp39m8lbad7aHSv
	B+ILEwluaAbrxqugLqbwJI7U/MD0whY5/Vncu6rHtOEw1UDML0DrKbhrnBMc5cZKFEXCQXutQfs
	BY=
X-Received: by 2002:a05:600c:3490:b0:48a:5970:2005 with SMTP id 5b1f17b1804b1-48a597021c6mr75710255e9.2.1776889662899;
        Wed, 22 Apr 2026 13:27:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c68asm147278435e9.3.2026.04.22.13.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:27:42 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:27:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit
 architectures
Message-ID: <20260422212741.50deeb06@pumpkin>
In-Reply-To: <20260422033650.68457-9-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
	<20260422033650.68457-9-kerneljasonxing@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 11:36:50 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> mode the chunk offset is encoded in bits 48-63 of the descriptor
> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> lost entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.

I had a look at how this is used.

I suspect that XSK_UNALIGNED_BUF_OFFSET_SHIFT can just be made smaller.
The 'addr' isn't really a normal address of any kind, it is a really
and offset into an array made up of pages of memory.
The actual address (kernel virtual of dma) is generated by:
	ptr->array[addr >> PAGE_SHIFT] + addr & ~PAGE_MASK
(after removing the unaligned chunk offset from 'addr').

It is actually quite likely that there are enough free high bits
even in 32bit mode.

	David

> 
> Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> strictly stop supporting it at compile time.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> index 71af2febe72a..819aa5795f50 100644
> --- a/net/xdp/Kconfig
> +++ b/net/xdp/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config XDP_SOCKETS
>  	bool "XDP sockets"
> -	depends on BPF_SYSCALL
> +	depends on BPF_SYSCALL && 64BIT
>  	default n
>  	help
>  	  XDP sockets allows a channel between XDP programs and

