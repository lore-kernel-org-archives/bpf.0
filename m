Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B02BEC2E;
	Wed, 10 Jun 2026 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116543; cv=none; b=DtmB6cCwMYvAOaVbg4CH7uNJb2ETRMa9DONUhCQaJV7mlcO+tVWClbQZTpKQVxnW8yTlt0AyZqF7NB5wytuJp+qypbViO1VdwkMrvKXOJc839cpV0uBMYgev7tj0K8mxb+56qVNKaPUc+e2DQL1BQfsLRnrbdSkcQe6bDpKLg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116543; c=relaxed/simple;
	bh=3VPjY6B26IQMjJx9reh3upopSq7P+roDvoVaW9o9Dl4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nFPSiViRKxtU2egeKiGVIQ42/T4fPzOBHZ/gEkUum+XIh7Fzi8lL3Kv78ztmJ+h2UyeFFzldJauEwoUSpEmtSj3w48CVulFawcBgHykPyt2gjRhxBbyS2yFCtjx9Dif9xkOwoZbNuiyDmtzJe5uUchT34zKjl1VHD/APNhItUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfhDzwkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfhDzwkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050221F00893;
	Wed, 10 Jun 2026 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116542;
	bh=f8g6LjqXziptxh4NhHVOmB7NVF0gyTOHCrskPKDN7FA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YfhDzwkDcC1Co6IUNf9GV7gUKcWXQkDyyQiuFLhsZFv7U3VgX/SfwcAev7jhTP4Es
	 k0QqF81mFZZu1LsuG0c5lt352RV7Qpv8OAeQXKV33Jp1kntzofntFyvFWs53wCd2uI
	 Fc2m3m3lmo/kw6Vhz3mEZnr9URWMxenIV1pL5RWNoxkuTkIHtZRNE7TVXh9VGMtwPL
	 YIW1LnN+0Xz6Zt3b1Uc/Pb9dEW9lFcqoaGC12C6XoYzLbfzRRftwH52jU6Fmx2fQE0
	 DW5RWtmgD34ThP3QWPzWw38/sc30WlqzG0bxoiA1Esk2z7cdERJliS+xZmrHGnmHZ+
	 O3lTxC6sbeCcA==
Content-Type: multipart/mixed; boundary="===============9195040128409769066=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <359e25ff2c110786b600def61a694e1afbd4634b1c047b38b1c20a9ea21156e8@mail.kernel.org>
In-Reply-To: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>
References: <20260610175922.1103871-1-rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: take the socket lock in udp_bpf_recvmsg()
From: bot+bpf-ci@kernel.org
To: rhkrqnwk98@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com
Cc: horms@kernel.org,cong.wang@bytedance.com,ast@kernel.org,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 18:35:41 +0000 (UTC)

--===============9195040128409769066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> udp_bpf_recvmsg() drains the psock ingress_msg queue through
> sk_msg_recvmsg() without holding the socket lock. __sk_msg_recvmsg()
> walks the head sk_msg's scatterlist and updates each entry in place
> (sge->length -= copy, sge->offset += copy), drops the page once an entry
> is consumed, and frees the sk_msg when it is drained. ingress_lock only
> serializes the queue list operations, not this per-entry consume;
> copy_page_to_iter() can fault, so the loop cannot hold a spinlock.
>
> Two threads calling recvmsg() on the same UDP socket then consume the
> same sk_msg at once:
>
>   CPU0                                CPU1
>
>   sk_msg_recvmsg                      sk_msg_recvmsg
>     copy = sge->length                 copy = sge->length
>     copy_page_to_iter(copy)            copy_page_to_iter(copy)
>     sge->length -= copy
>       /* sge->length == 0 */
>                                        sge->length -= copy
>                                          /* underflows to ~0U */
>
> The next pass loads the underflowed length into a signed int, the value
> is negative so the copied + copy > len clamp is skipped, and
> copy_page_to_iter() is handed ~2^64 as its size_t bytes, which trips
> page_copy_sane(). The same race can put_page() one page twice and free
> the sk_msg while the other reader still walks it.
>
> tcp_bpf_recvmsg_parser() already serializes this with lock_sock() around
> __sk_msg_recvmsg(); udp_bpf_recvmsg() does not. Take the socket lock
> around the sk_msg_recvmsg() consume so a given ingress sk_msg is drained
> by one reader at a time. The wait path is left unlocked, as
> udp_msg_wait_data() sleeps without dropping the socket lock.
>
> Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")

Is the Fixes: tag pointing at the right commit?

Commit 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
introduced udp_bpf_recvmsg() with a lock_sock(sk)/release_sock(sk) pair
wrapping the whole function, including the sk_msg_recvmsg() consume, so the
race described here was not present at that point.

The unlocked consume appears to have been introduced later by
9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy"), whose diff
removes both lock_sock(sk) and release_sock(sk) from udp_bpf_recvmsg().

Should the tag instead be:

  Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27296268347
--===============9195040128409769066==--
