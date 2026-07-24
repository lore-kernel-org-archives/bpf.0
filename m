Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE493EF0CD
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890109; cv=none; b=WmNPc0K+eSeqtSuBXA3RShdc5doJR6c7W4f4wPgaMv5re5v8zMZpCVFrInyZiMkbbbiAXX0rvFvBz9rta4sgipRYWO+qRrOt5BUl16AqCRAXOQQ0WF0VN9Ssc/dHJRkLkBvkR5wJbNxkbNn/OkgCNG5Zxb6zc1sx3jIE6pBL/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890109; c=relaxed/simple;
	bh=xYRxLMtZ3/BRx1I4wyTmpchAQbo3mmEcBK6PpJEipNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mw5N8k313Qu8HlvUirdmV+0150lRbkq/urC3QxkK/lyJ7353P6GJ2c3es+dNQs+W6/0l9TDDgUdn95XPYnE6pNvTysTxO5seoAusDpQRBDZ/26GPGRDJEGt9t6KbBC7/dZkFLGX/cHt9+r+WUVrpY7tuscFE0kp5nA1u5MoK7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ub2STd1Q; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ub2STd1Q"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69ea0595598so312096a12.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784890105; x=1785494905; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Am9/owu6l1hJG7i/wElg5Hgmsf9dZWWfn/6yJfdsk+4=;
        b=Ub2STd1QY/Yh0G/HXKAOpIh78GfmhUVVonLK8OK1KNbpiSq0KteOC/Y1Ldnzi7LksB
         5lUsWTyMIJ5Dw9PzXLMVM5dpltes0Yjven2jcR3ZDJgNatXb37VqNBzsvH4zy1gCxhH9
         m/2nw8GoFnVFd2LRD8rjEDxWGbSsLf/xBBRybQ9z4vSBTHrMCINAFfn45FTz/uT1wHxp
         P+C+6EW1J8ZKdn8YR+93xx0jWiBULkj66mEUCpDJAD2mToSLZG46y1hiB/oo7PL7ubPy
         0ERB/uztfhJmYUilHyV0g5jXeBGbHDQiacznv3yazsZTT1vei3ZWVfZYSTILLM7bWNZK
         6ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890105; x=1785494905;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Am9/owu6l1hJG7i/wElg5Hgmsf9dZWWfn/6yJfdsk+4=;
        b=H5G0kKvOZWrbtDdvrUYq1R0ixMKBLsB0Fvhd0VCbJ8aKmMZQxZbrlNhwMv18lNeMyB
         bhDTQb9OG931uaBWcJ3ZK0ZAPqbbZDqson7FQFf+PtbbsqoOZNPYxqdpUd00uPt9R9pg
         T4SVIOr1WpyQ+6lYaLE6KBp3wPGmljg+ChX6khe3MnehHIyiQPBXGuvwdjQSJvf0hm5S
         7xl0+UwwPrE2LQo8WHqkdNGnPsTNz90KpsqBthx8hhC3Infpe5IJ3IceRUxmtxg2PqVO
         gkvgzLzxWkQ0XZ4iLsW9dZHP8csgmAWKFBaU+Ca0JVt1m6iDF4D5wfFH97icve/pXRhs
         FT5w==
X-Forwarded-Encrypted: i=1; AHgh+RqAYpRxrHaVvKg9SrPyGvwYFW7Va+HbHAV8OAztYGCBWnhKTNvdXTK6JwKnEto9JhNPE7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YznCKwNEt62BWb/tHhqOrAR0dsUljaL+tc6jpHz8J6bWFyX5bJM
	99QKCJO4ot1p2tHRig2wTAiD7hGRhmSVdNTsKnNfAVWDlCIL7aYnTvDecV5b+VTiCsE=
X-Gm-Gg: AR+sD10huLz+ijkTur0SWPnopc/CFjcqABuwxPygKzsMiVZPdRnmulIuZdf+gidj6I4
	pZZVmdvHLye9G6quSbSdP5Oaf30WvsfHdZDJsTGaH1MB0sYAPux44lAdbUBeJ3Y6FQccUUFS9zM
	o+w2RrfRjSvmK0x3J0KyEJ5fxQwuWQk2HrYRFXRjbj9Xj77nJiEX2wF7WSTGSWa2cs+ht8hplxF
	hM3DtnLHZHOFVNMXTU26tQ03fbduj2oV7fvt7E6PWQs7+d4WBT2V8GJLeRqnFvtWqcEuiXrDM+K
	3m4mJ6mhCTI5k/WonQk7It3TVbuu+iUpZvq/iJNtW0YG2aOwYYERgfrnEa/C/A+MFpubC3qwJcx
	xIUoHSdHnjR09WLkKbeCoPEPgn53elqiw0Ywx4rJYs+Qa0+JlTTpXcHQL8Z3lGydBuGkEOA0egs
	/O1Ilw
X-Received: by 2002:a05:6402:3513:b0:698:3b7c:7e50 with SMTP id 4fb4d7f45d1cf-69f6ab4956bmr2655292a12.38.1784890105421;
        Fri, 24 Jul 2026 03:48:25 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f350391d2sm2952122a12.28.2026.07.24.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:48:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,  Eric Dumazet
 <edumazet@google.com>,  Neal Cardwell <ncardwell@google.com>,  Kuniyuki
 Iwashima <kuniyu@google.com>,  John Fastabend <john.fastabend@gmail.com>,
  Jiayuan Chen <jiayuan.chen@linux.dev>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v4] bpf, sockmap: Fix cork use-after-free in
 tcp_bpf_sendmsg()
In-Reply-To: <20260724103856.3399001-1-nicoyip.dev@gmail.com> (Chengfeng Ye's
	message of "Fri, 24 Jul 2026 18:38:56 +0800")
References: <87fr18lmzo.fsf@cloudflare.com>
	<20260724103856.3399001-1-nicoyip.dev@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 24 Jul 2026 12:48:22 +0200
Message-ID: <87a4rgll3d.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 24, 2026 at 06:38 PM +08, Chengfeng Ye wrote:
> tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which
> drops and reacquires the socket lock.  Its error path tries to decide
> whether msg_tx names the local temporary message by comparing it with
> the current value of psock->cork.
>
> This comparison is unsafe when two threads send on the same socket:
>
>   Thread A                         Thread B
>   msg_tx = psock->cork
>   sk_msg_alloc() fails
>   sk_stream_wait_memory()
>     releases the socket lock      acquires the socket lock
>                                   completes the cork
>                                   psock->cork = NULL
>                                   frees the cork
>     reacquires the socket lock
>   msg_tx != psock->cork
>   sk_msg_free(msg_tx)
>
> The stale cork is therefore mistaken for the local temporary message
> and freed again.  KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in sk_msg_free+0x49/0x50
>   Read of size 4 at addr ffff88810c908800 by task poc/90
>   Call Trace:
>    sk_msg_free+0x49/0x50
>    tcp_bpf_sendmsg+0x14f5/0x1cc0
>    __sys_sendto+0x32c/0x3a0
>    __x64_sys_sendto+0xdb/0x1b0
>   Allocated by task 89:
>    __kasan_kmalloc+0x8f/0xa0
>    tcp_bpf_sendmsg+0x16b3/0x1cc0
>   Freed by task 91:
>    __kasan_slab_free+0x43/0x70
>    kfree+0x131/0x3c0
>    tcp_bpf_sendmsg+0xec3/0x1cc0
>
> msg_tx can only name the stack-local tmp or the shared cork. Check for
> tmp directly so a changed psock->cork cannot turn a shared message into
> an apparent local one.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---

Thanks!

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
