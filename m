Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429712;
	b=kx7WyZrgi1TAqsuS9wC3hvG5RBQC8HJZZoCjR0Qdlk8y6fTIs54/7KNn+TAhZmA7kDeV
	 fyLpEQ/YJN+pSLkRxk73hogCEBRADAtJ0sshs2BbNj7Cd3syOqJnbe0zfI7Nl10O8b8lg
	 x+tObNq6UCvlmZtkZldbceG8DVQO1qPdweWMFJWFwRjTCTGSA8Hwygd0YhYd7GscLIGit
	 38+q4MWzZoL+MAc9+C4W7xMtisflsosYV7FL6+mQyIrSKmZUYsLVDGu9QAnqhXFgyEQNw
	 IYd5Z+sL3j2xXLi18n3hSF2RxFkJvu6cC0aZW4+he+iE+v8ik+fyBr7ZnEpiKFaEX4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429712;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ThuCb0zPa/jmLlwYql4NA54ZpqHiraRbY9NoIHTv5gw=;
	b=pVlgiAccQJR7rSLn9vtTMmNQ68SDeMqLYFEnlmub1Rl1UTFMYGaiYLQv70SE35/BOhm0
	 T85U4Jieuf1eJJp9LxDDvhhpuhuADaDxMDDxvfNCnuMA+Dx5Z6qpc4mMIh23/fg48syl2
	 bgZyLz6F8spY+FLiNSaksvwcXYrMGPkWnPnzgCRlF4vrP2fGk4EffMBkewhIqoTX1mtXW
	 KlbNhwTjZBf7fknTKsw778hjQqxqn79IoSxShhpF6/un/rQDE7r3U39OAhxoT20DrOyNC
	 iTdKaRP9AwF6QKNaXkCgMaxoMLsJVa64zWFrpEn34LJ8eBrHQAuYsVp351ZfnSuj2ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAplpGBy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED9E606A31C;
	Wed, 11 Nov 2026 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAplpGBy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E961F00A05;
	Wed, 11 Nov 2026 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429711;
	bh=ThuCb0zPa/jmLlwYql4NA54ZpqHiraRbY9NoIHTv5gw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aAplpGByy02Xnjj1E1+EAmbaPsXyI6o0AEk38FDvAH0Z9x5rCd7oSXBGkfyvOUcgD
	 /BxQzPREBVq3/aUN2ZfIXhYj0808V0Hx4bPq+h30fNTYooi1wxCPT5bvbY9rRxFfK+
	 /3p79Pc3QK4dTOtptY/8pEFLQ/V0fPlA8rDDCUfmyBvd1bCRqE6hLX6VwxmG4vuloP
	 7KGkolqAH+WdHr+Dwz6YJB8X8+D85AWovl8ltCSrdDNBjp2Gpk+7US0Q5RLNMnitda
	 /R/WmjkeBUBIpDuAEQ9c98VineRtw2AIvmlXZrSUE5CxDxU93yqzlTFcNT33zn3732
	 xkOhFFotRhcfw==
Subject:
 Re: [PATCH net v10 1/2] tun: keep a kernel copy of the socket filter program
From: netdev-bot+sashiko@kernel.org
To: clementwei90@163.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, weirongguang@kylinos.cn,
 willemb@google.com
Date: Wed, 11 Nov 2026 20:41:50 +0000
Message-ID: <179442971051.2199510.17461948089232677295@kernel.org>
In-Reply-To: <20261109023848.59575-2-clementwei90@163.com>
References: <20261109023848.59575-2-clementwei90@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] TUNATTACHFILTER on a device with zero enabled queues saves a
  program that has never been built.
- [Medium] After a partial TUNATTACHFILTER failure, the device's recorded
  filter state no longer matches what the queues enforce, and the reason…

--

tun: keep a kernel copy of the socket filter program

This patch makes TUNATTACHFILTER keep a kernel copy of the classic BPF
instructions in tun->fprog_kern. Each queue gets its own program, built
from that copy with the new sk_attach_filter_kern() helper. The patch
also fixes the inverted error check in tun_attach(), and checks the
program with the new bpf_prog_validate_classic() before the saved filter
is replaced.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e6011..67c8b74d59bde 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -3091,15 +3166,29 @@ static int tun_attach_filter(struct tun_struct *tun)
>  	for (i = 0; i < tun->numqueues; i++) {
>  		tfile = rtnl_dereference(tun->tfiles[i]);
>  		lock_sock(tfile->socket.sk);
> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
> +		ret = sk_attach_filter_kern(fprog_kern, tfile->socket.sk);
>  		release_sock(tfile->socket.sk);
> -		if (ret) {
> -			tun_detach_filter(tun, i);
> -			return ret;
> -		}
> +		if (ret)
> +			goto out_detach;
>  	}
>  
>  	tun->filter_attached = true;
> +	return 0;

[Severity: Medium]
What happens here when tun->numqueues is 0?

The loop body never runs, so bpf_prog_create() is never called on the new
program. Even so, filter_attached is set, and the TUNATTACHFILTER case in
__tun_chr_ioctl() commits the program:

	kfree(tun->fprog_kern.filter);
	tun->fprog_kern = fprog_kern;
	tun->fprog = fprog;

tun_copy_filter() only runs bpf_prog_validate_classic(). A program can pass
that check and still be refused later by bpf_convert_filter(), when a
converted jump offset falls outside the s16 range. It can also be refused
by bpf_prog_select_runtime(), which returns -ENOTSUPP when a JIT is
required but cannot be used.

A usable fd with numqueues == 0 looks reachable on a multiqueue TAP.
tun_set_queue() lets IFF_DETACH_QUEUE detach every queue, and
__tun_detach(tfile, false) keeps tfile->tun. A detached fd can therefore
still issue TUNATTACHFILTER.

The inverted check in tun_attach() is now fixed:

	err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
	release_sock(tfile->socket.sk);
	if (err)
		goto out;

With that fix, wouldn't every later IFF_ATTACH_QUEUE on this persistent
device fail? The same goes for every TUNSETIFF without IFF_NOFILTER.
Before the patch, a new tfile in this situation still attached.

The commit message says "Such a late failure does not replace the saved
program". Here, though, the program is saved without ever being built, so
the late failure happens on every later queue attach instead.

Could the program be built once with bpf_prog_create() even when there
are no queues to attach it to?

> +
> +out_detach:
> +	/* Drop the copies already installed on queues 0..i-1, which leaves
> +	 * them without a filter: their previous sk_filter, if any, was
> +	 * already replaced and released. The caller does not replace the
> +	 * saved program when this fails, so tun->fprog, tun->fprog_kern and
> +	 * filter_attached keep their previous values.
> +	 */
> +	while (i--) {
> +		tfile = rtnl_dereference(tun->tfiles[i]);
> +		lock_sock(tfile->socket.sk);
> +		sk_detach_filter(tfile->socket.sk);
> +		release_sock(tfile->socket.sk);
> +	}

[Severity: Medium]
Does this rollback leave the device's filter state out of sync with what
the queues actually enforce?

Suppose filter P is attached on every queue, and a new TUNATTACHFILTER
fails on queue i > 0. On queues 0..i-1, __sk_attach_prog() has already
replaced and released P. This loop then detaches those queues, so they
run no filter at all. Queues i..n-1 still run P.

tun->fprog, tun->fprog_kern and filter_attached keep their old values, so
TUNGETFILTER still reports P. tun_attach() also installs P on queues
attached later. Meanwhile, queues 0..i-1 pass every packet through
sk_filter() unfiltered.

Before the patch, tun_detach_filter(tun, i) cleared filter_attached on
this path. The device therefore did not claim a filter that some of its
queues lacked.

The commit message says:

    A queue that
    already took the copy is rolled back, which leaves it without a filter,
    because the program it ran before was already released; restoring it
    would need an extra reference per queue.

Is that accurate? P's instructions are still in tun->fprog_kern. It looks
like sk_attach_filter_kern(&tun->fprog_kern, sk) could rebuild P on queues
0..i-1, the same way tun_attach() does for new queues. Another option
would be to clear the saved state when the attach fails partway.

A failure partway through the loop looks reachable in several ways:

  - -ENOMEM from bpf_prog_alloc(), or from kmalloc_obj() in
    __sk_attach_prog()
  - the per-socket optmem check in __sk_filter_charge()
  - under CONFIG_BPF_JIT_ALWAYS_ON, bpf_jit_limit being reached partway
    through, because each queue JITs its own copy

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109023848.59575-1-clementwei90%40163.com
