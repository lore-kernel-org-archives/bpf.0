Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF8638AC75
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324432; cv=none; b=WTJibrwRXsNYMyc8el4Z7qi/Jaj4ii3pR+oFn8drhWXGFOB2slc5NtV/TwkCKxoNo+Or/J9S8mrfdeLM9zK5zeu0g3wiA441XImXJ6oBAM181FiytTHcba45CiFjxqFAwUC5kyEEp3NvblBnhkjx/kTOZaHDuS79ht/xrd1FbS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324432; c=relaxed/simple;
	bh=St1pov/zO72pZVPMTwmGDh1KZ6yCH2bMT6rRjrkhycw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfuCaiZa5RfO4yweGtPI4sUv5S8s/LCdwvWLPkl/Us9PMhAcI9FAuJNoFZgHBzCim+Vi7s0OpHHQGu4XkzaihPp0//jet4JNI9g72KOVLPTuCNmiJziX834nPcT1iltUTcPm2qo2p4eYVZV1eW4+hlpmQiJYr4lL+NzqVy0LuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnLfzmxt; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnLfzmxt"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e5ff875c6aso827845ad.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324428; x=1791929228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jAq9XlswImcUY3VmzzuQYBjeBCXyaGsgZxIoIOD7uhI=;
        b=pnLfzmxt6cDj9EVzXSIL+qHA64jHVp/7NcXyE3xbsijyGOeTJcby94nw1kkPqzGETu
         O46JJUeQwfii6QlFkobmb9RaGKDyVFTyoCOzvsgOP1oaTfMJHXQ+SgQqfSzwFKUFyX5n
         D5s35/H8JAfhTSnORHeKv+fp1FL8pkLZBw30r8+B1/DNEE2AcC/KGDpNEJRM7/b7kmmB
         sNT9fOKXQ1Jn4GxARxg8ZhAQv0BnytqDJ2oDW93o0OC6bcGTR2mBc2GecjUNFalLundH
         W7HxFSbVlL2dd5OgUhle2ztKr1jdgVh4wT/cLn8luP0QUGM+MMnip88AodqXPaQbsePP
         m70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324428; x=1791929228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAq9XlswImcUY3VmzzuQYBjeBCXyaGsgZxIoIOD7uhI=;
        b=2KuukdEBtCpYEDp7P1QpeoRwMZ0n3fwD7igiEOTC3F9TBqGWDEFxomBk1CPsJcAoPa
         IINdIOpucEfdBaJEv7qPJWbUiqCPRcZ+vh0xe3LyZyfK8W4rucSvKuGK48AfJlRycCyH
         9OEoRcXbrpIa8J8x76voTutFU1V48OQPdTiUZCUBEV7kBrnmCs7iIwmA3KcIjGIwsgI1
         GU8LnnSZwytQWxgto7O3wiR+1aiPZHJHXzX2GK+Vov7vAUrvvc0YWVANNTeRzhaY8sSp
         yKDlwzgjr425eTJdpMCtqk3eld+tkcyb6nOsnmS7qfcOOSuXFQ3n4IjdGdIuGFuRo5Li
         tCiA==
X-Forwarded-Encrypted: i=1; AKwUvBzbzcuAQu4JUQATwTDSRAmxosIkRUJga2gGiTpQpuaoqw40ODUI5WVDYDOTtmsfLyHTu8c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhl0ecg7rOPvO6eTgBT8wYmoBro+oaMrYLUNbmE36WgvW6TDfT
	8Nt8pLA/CNG+Lt7/KoJ/ceWq15X7tnFMm1O5rUz3PDkFhbX0yIGSNT3G
X-Gm-Gg: AYBFou0MRlazpgZgELVWFzDs6L8L9Ip6Q0jUmuvlVh3uAUG9IKQgbSVOauzYJQJOgll
	+WdQROaidnl7y56P/JLTVZARr6MJNz3lKGGyV6fgbI26Iwhb0wTUVlTNFdO0jOmE1HAX0wAVk1R
	RsLlc9Mt+VRgME8aKpKsGugmdv/n6znDS7N7uv7CTNT89dSecSHmOC0tIhT9yMi3CvExo30Tv3k
	UxCOScAoXTm5F/V2VIiJ6Mq1JbXLcQSGbv3afNtjqMNBivds3lYr1/bGX1eWcL9NCCL6Oc5LbTY
	kqtEulryl5qsvp9xv1YyKRTLuY+kKp8cj0FjEUiQObpHUblDzqD+3QsW+e1sndGuL9RhVWU3buF
	Hx3ngObLd6vlwgW1K1RRX9cMmuBQK54Xq2KBRv0+Kbc2/16owm3mTuZzVEv5poyXyyETSqWRoMd
	i4vLSfLsNAcMeok2G7DDEjezZwpXRyNNS6KVeal/le7SHFCreu7KMt816orAym0SU=
X-Received: by 2002:a17:903:3c45:b0:2e5:d6b8:ad1a with SMTP id d9443c01a7336-2e6003b2732mr4635835ad.35.1791324428329;
        Tue, 06 Oct 2026 15:07:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604720106sm1564685ad.31.2026.10.06.15.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:07 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:05:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 05/10] bpf: tcp: Check
 BPF_SOCK_OPS_TEST_FLAG() after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
Message-ID: <asVwtYlgiKUlQSSg@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-6-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
> BPF_CGROUP_RUN_PROG_XXX() macros guard __cgroup_bpf_run_filter_XXX()
> with cgroup_bpf_enabled().
> 
> However, even when no SOCK_OPS prog is attached, callers still
> initialise struct bpf_sock_ops_kern (memset(), etc.) or evaluate
> BPF_SOCK_OPS_TEST_FLAG(), which loads tp->bpf_sock_ops_cb_flags
> from a cold cacheline near the end of struct tcp_sock.
> 
> Similar to bpf_tcp_ops, let's check cgroup_bpf_enabled() before
> BPF_SOCK_OPS_TEST_FLAG() and struct bpf_sock_ops_kern setup, and
> rename BPF_CGROUP_RUN_PROG_SOCK_OPS{,_SK}() with __ prefix.
> 
> Since all direct callers of tcp_call_bpf() pass 0 and NULL for
> nargs and args, they can be folded into the new tcp_call_bpf()
> macro.
> 
> All callers of tcp_call_bpf_{2,3}arg() check BPF_SOCK_OPS_TEST_FLAG()
> and do not need the return value.  These are replaced with the new
> tcp_call_bpf_flag() macro.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
