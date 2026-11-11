Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436158;
	b=g+SqDgx64ENk0lVk12BI7D4gBqTm0L5DpfK3zb7m7dCAWSvlkrOJmWvCM8gVwHdPbtSr
	 ARuw2pvso3N9AsrLQS5DhabeVkank1aB8wuc4XsYVfgpp2dF7x18pDK4RfQaYadHZYMru
	 AWWq3DJr2haqkGfTWhsybH9Q3wmnES3Oj6VvrT8d+fsHA/s6fEVx1o9gZoOJcrYZj6GTK
	 hbHRGFcHhPag26yuPaKk/CfVMRyP8qtkAQJaLu2Sgcx+LcenHh+hKnBClZuboHBn176SA
	 VQoEN1c4F+/IwF/j1US6t/Othp/UuzIIXg0Ldn6fS9zD7LMNQuM/5SkpQdnViXLROQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436158;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=swr3Ra0uYYHhVDT8SV7YWQm5snOjPZHE4+u1z3uEAP4=;
	b=HW7CQ4/JO/1xKrSIalI7NJ2dZ8/5PUV/VnkllcFl4jS6HEfuYC+YeBqiJDVSs+RBq1hU
	 Bpin9nBVM/VtR6Rwhc+qbI1FvGHNd9XmYQTby3v1D8HwJ+KObGwnQDh6YR/lIONuFG4fH
	 gaK1+VjNSZbClf2UPXpieAvo/eJncpvk3TXBFncP1wzV+85IEaCSY4Js7DZ/bigQbdBR0
	 tyIGGVirxVZxC+mK1YhAqH95fU8kfhKNpNmzPL1jNDsEQipS/v3amA4P+ehs+9WMcYdn+
	 dBTv4Sl17mEQAUP9/o/CLghHW8gDmbbOn6KeeACw7Mq4cTA/hqifltL+MyN5I+5ZiEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FHFW1jQ8;
	arc=none smtp.remote-ip=91.218.175.78
Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C75F606A338
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 22:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C75F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FHFW1jQ8
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WNeWuH485eW6BnGDu5zKsDsVjpVFn1cXQI2ek2Qhepw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794436154; v=1; x=1795040954;
 b=FHFW1jQ8gZeq62AyqIat/bVk9+oZJPH+mKkgGwHYatFqvqUcb0jqme3Ckd8RXghvxmEFuymv
 EXnKFgmZpzeJhVQnrdCTsXC8aJbNJvY38EQA7hJs/li1XdYxFrbyl6lBTQG5l25sJHs0Bzfkdgu
 +aqETu4zmziTnVUrlolNq95Y=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a971d7137a0d0f9f;
	Wed, 11 Nov 2026 22:29:14 +0000
X-Mizu-Trace-ID: a971d7137a0d0f9f
X-Migadu-Flow: FLOW_OUT
Message-ID: <9ccfc1f1-1214-4374-bac4-f4d91103d149@linux.dev>
Date: Wed, 11 Nov 2026 14:29:11 -0800
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
Subject: Re: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
To: Breno Leitao <leitao@debian.org>, kuniyu@google.com,
 netdev@vger.kernel.org, llvm@lists.linux.dev
Cc: ast@kernel.org, bpf@vger.kernel.org, kuba@kernel.org, tj@kernel.org
References: <au27Y9m78_3EH2v1@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <au27Y9m78_3EH2v1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/6/26 3:38 AM, Breno Leitao wrote:
> My arm64 KCSAN builds of linux-next fail since next-20261015, because
> bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:
>
>    WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
>    WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
>    Failed to generate BTF for vmlinux
>    Try to disable CONFIG_DEBUG_INFO_BTF
>    make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
>
> This is clang 22.1.3 and pahole 1.31 (current pahole master behaves the
> same), with CONFIG_KCSAN=y, CONFIG_DEBUG_INFO_BTF=y and CONFIG_WERROR=y.
> v7.4-rc1 is affected as well. With pahole 1.31, the same config without
> KCSAN builds fine.
>
> The kfunc came with 5f549c1e49f3 ("bpf: tcp: Add kfunc to adjust
> sk->sk_rcvlowat."), and 201a454df948 ("resolve_btfids: Fix the
> --fatal_warnings exit status") made the missing BTF fatal with
> CONFIG_WERROR. Without CONFIG_WERROR the kernel builds, but bpf_tcp_ops
> is never registered:
>
>    initcall __bpf_tcp_ops_init+0x0/0x70 returned -22 after 302 usecs
>
> This seems similar to pahole behaviour sched_ext hit with a bool
> argument, discussed in [2] and worked around in f2f095c87603
> ("sched_ext: Work around pahole 1.32 dropping
> scx_bpf_task_set_lazy_resched() from BTF").
>
> Here the argument is an int that clang reassigns, its location list has
> no DW_OP_entry_value, and pahole 1.31 drops it as well, so staying on
> pahole 1.31 does not help.
>
> Not reassigning the parameter is a workaround for me, with any pahole: clang
> then describes @rcvlowat in w1 from the entry, the kfunc is back in BTF,
> and __bpf_tcp_ops_init() returns 0 (tested in virtme):
>
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 2ba73dd6c52cce..1afa6bd7f508ef 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -370,10 +370,9 @@ __bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
>   	if (moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
>   		wakeup = true;
>
> -	if (rcvlowat < 0)
> -		rcvlowat = INT_MAX;
> -
> -	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
> +	/* Reassigning @rcvlowat can make pahole drop this kfunc from BTF. */
> +	return __tcp_set_rcvlowat(sk, rcvlowat < 0 ? INT_MAX : rcvlowat,
> +				  wakeup);
>   }
>
>   __bpf_kfunc_end_defs();
>
> Would this be acceptable?

I tried and this change should be okay. The below pahole patch
    https://lore.kernel.org/bpf/20261111222447.322978-1-yonghong.song@linux.dev/
is to ensure that all kfuncs will have their source BTF. So once
the patch patch is merged, you can use pahole master branch to build.

>
> [1] https://lore.kernel.org/all/DLRKT5MG6W2P.2V1P0QD4GQEKY@gmail.com/
> [2] https://lore.kernel.org/all/7c139810be5ffc9764ed4236efc28794@kernel.org/

