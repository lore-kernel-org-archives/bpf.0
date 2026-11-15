Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794762062;
	b=DuWt1KGEj3ufCUypVH4vGaz1O2rf6wTf6dgveg83g0r6sdCIhBFN4AwjOHg0tXGKfJXh
	 DuEzDejj9YIJ6Ia/05zgnZJtkgCefAvnswauxfb9406Cr1rZqlbADxojZ3l+rWoQQjQVx
	 o78wGzX+WFWMAaEMe5g59ZYaLi+4EiOCwYKG6IBuk5wCIcN6BcYcjjVq3/1SpuTY2DnxU
	 uz7xdqp8ciHyIiqSzapBLXms9NDpbiMQRCF7tqN+eY0+r0CnhvF1DRRhFPL80SwpYTukh
	 KeqRySARh3WlT60/2bToNfvazSp/0iBP4NAIYmLqob8zYd341vsfK1UyhhmsMs7D9Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794762062;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BVQg03Ck8W5f6msu4j0hffsFbWEt7ebqOkm96wfPAPM=;
	b=rXcXUv1vzqymZBIENcPOA86t7xmdGnVwyobtM+prb8ok53ba323UJ99CVOqgm7jUZ8fL
	 9BGDLQvI/QLP79XOk+8EZsQ9K3LgLZR1MOv6VZPT5tbwLCG4R7yFBIn0e61pBcCKcfVAP
	 a2MieeBhetrpdt0Y66A+thfuFx9V5Mo6nohkb7WWqEmT0NIMDd7OwsnSj7iHVL+G1AtV6
	 N/z4mPBkobjy+Tp2Ymy3LeeAUt0a/vIRPF1sTxH6f20Zs2cPFOZaj4ahbX1PsJOwdWGCq
	 W11Wr5b/AB8RDZjRhTw1s6vPN8Wx9jeJYUXZSzOKvNRJYddDDd/uqffftBbVSv7d9vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBwKV3W7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A10606A31D;
	Sun, 15 Nov 2026 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBwKV3W7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682291F000C4;
	Sun, 15 Nov 2026 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794762061;
	bh=BVQg03Ck8W5f6msu4j0hffsFbWEt7ebqOkm96wfPAPM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hBwKV3W7mjlnj1VPLEgmTPtsZCbXTmL1PWz+B8u/wXdIyuNKbZLIpUYGLwtH/7ccG
	 bEYhmIGM2Fd2zcIS9jzOwkUCLvZ9yxoUkA0EraUm0N6ir5FDpWh2ApJD138Qfcw+kz
	 EdV+inYIFKCBuLgs665TYm9JkwnYuhVXbM1dhb7zqrN7pgNaKKzjodSLHeSjvOK3cw
	 hAYdwW/ZM/CKoXLQpmvnWDla0asfeyAEDZTkYElBfZ1VoOKim/wm3/ycpmFo6+ImR6
	 2Us2cjFqWoKpeFeFpTRR2BA1hMto+2TFRWQ8v2/PLlHLsS/xwLKtWYWSwJW2u0jw7U
	 1c5s+Idqzz9Ow==
Subject:
 Re: [PATCH net-next 2/3] tcp: convert do_tcp_getsockopt() to sockopt_t
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 ncardwell@google.com, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Date: Sun, 15 Nov 2026 17:00:59 +0000
Message-ID: <179476205975.2199510.5756511034430735330@kernel.org>
In-Reply-To: <20261112-getsockopt_phase7-v1-2-1eb759dd0929@debian.org>
References: <20261112-getsockopt_phase7-v1-2-1eb759dd0929@debian.org>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message identifies a bug class: copy_to_iter() runs
  the hardened-usercopy check on a kernel stack source.
- [Low] TCP_SAVED_SYN now consumes and frees tp->saved_syn before optlen
  is written back.
- [Low] bpf: non-standard multi-line comment style in
  sol_tcp_getsockopt()

--

tcp: convert do_tcp_getsockopt() to sockopt_t

This converts do_tcp_getsockopt() from a sockptr_t optval/optlen pair to
sockopt_t and removes the tcp_ao_get_sockptr() bridge. tcp_getsockopt()
now always writes optlen back. BPF callers go through a new
sol_tcp_getsockopt() helper, which calls do_tcp_getsockopt() with page
faults disabled so the hardened usercopy check skips find_vmap_area().

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9b8d5191c4ba2..0d5afe1c5606b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5686,6 +5686,28 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
>  	return 0;
>  }
>  
> +static int sol_tcp_getsockopt(struct sock *sk, int optname, char *optval,
> +			      int *optlen)
> +{
> +	struct kvec kvec;
> +	sockopt_t opt;
> +	int err;
> +
> +	err = sockptr_to_sockopt(&opt, KERNEL_SOCKPTR(optval),
> +				 KERNEL_SOCKPTR(optlen), &kvec);
> +	if (err)
> +		return err;
> +
> +	/* BPF may call this in softirq: with page faults disabled, the
> +	 * usercopy check skips find_vmap_area() and its lock.
> +	 */
> +	pagefault_disable();
> +	err = do_tcp_getsockopt(sk, SOL_TCP, optname, &opt);
> +	pagefault_enable();

[Severity: Low]
This is a minor style nit. net/core/filter.c follows the BPF comment
style, which wants the opening /* of a multi-line comment on its own
line, with the text starting on the next line. That applies to new code
even where older comments in the file still use the net style.

The new comment in sol_tcp_getsockopt() puts the text on the opening
line. Could it be reformatted as:

	/*
	 * BPF may call this in softirq: with page faults disabled, the
	 * usercopy check skips find_vmap_area() and its lock.
	 */

If the pagefault_disable() moves to a shared BPF entry point, as asked
above, the same applies to the comment wherever it ends up.

[Severity: High]
Is the same softirq problem still present in the SOL_IP and SOL_IPV6 BPF
getsockopt paths in this file?

sol_ip_sockopt() and sol_ipv6_sockopt() build the same kvec-backed
sockopt_t, and they call the converted getters with no guard:

net/core/filter.c:sol_ip_sockopt() {
    ...
		err = sockptr_to_sockopt(&opt, KERNEL_SOCKPTR(optval),
					 KERNEL_SOCKPTR(optlen), &kvec);
		if (err)
			return err;

		err = do_ip_getsockopt(sk, SOL_IP, optname, &opt);
		*optlen = opt.optlen;
		return err;
    ...
}

sol_ipv6_sockopt() does the same with do_ipv6_getsockopt(). Both
do_ip_getsockopt() and do_ipv6_getsockopt() end with:

	if (copy_to_iter(&val, len, &sopt->iter_out) != len)

Here val is a stack local and len is not a compile-time constant.

Take a sock_ops program running from a softirq callback such as
BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, or a TCP CC struct_ops program, that
calls bpf_getsockopt(SOL_IP, IP_TOS). Wouldn't it go down this path?

__bpf_getsockopt()
  sol_ip_sockopt()
    do_ip_getsockopt()
      copy_to_iter()
        check_copy_size()
          __check_object_size()
            check_heap_object()
              find_vmap_area()

The IRQ stack is not current's task stack, and check_heap_object() only
skips the lookup when page faults are disabled:

mm/usercopy.c:check_heap_object() {
    ...
	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
		struct vmap_area *area = find_vmap_area(addr);
    ...
}

On CONFIG_HARDENED_USERCOPY plus CONFIG_VMAP_STACK kernels, this looks
like the same inconsistent lock state on the find_vmap_area() lock. That
lock is taken with plain spin_lock(), so a softirq that interrupts a
process-context holder on the same CPU could also deadlock. The same
applies to bpf_getsockopt(SOL_IP, IP_TRANSPARENT) and to
bpf_getsockopt(SOL_IPV6, IPV6_TCLASS / IPV6_AUTOFLOWLABEL /
IPV6_TRANSPARENT).

The commit message names sol_ip_sockopt() as the model for the optlen
handling, but that function has the same exposure.

Would it be better to put the pagefault_disable() at the shared BPF entry
(__bpf_getsockopt() / _bpf_getsockopt()), or in the kernel-buffer
sockopt_t setup? Otherwise every per-level wrapper has to remember it.

[ ... ]

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 552e8fe22e7e2..de287845e6c0d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c

[ ... ]

> @@ -4904,13 +4859,22 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
>  		   int __user *optlen)
>  {
>  	struct inet_connection_sock *icsk = inet_csk(sk);
> +	sockopt_t sopt;
> +	int err;
>  
>  	if (level != SOL_TCP)
>  		/* Paired with WRITE_ONCE() in do_ipv6_setsockopt() and tcp_v6_connect() */
>  		return READ_ONCE(icsk->icsk_af_ops)->getsockopt(sk, level, optname,
>  								optval, optlen);
> -	return do_tcp_getsockopt(sk, level, optname, USER_SOCKPTR(optval),
> -				 USER_SOCKPTR(optlen));
> +
> +	err = sockopt_init_user(&sopt, optval, optlen);
> +	if (err)
> +		return err;
> +
> +	err = do_tcp_getsockopt(sk, level, optname, &sopt);
> +	if (put_user(sopt.optlen, optlen))
> +		return -EFAULT;
> +	return err;

[Severity: Low]
Can TCP_SAVED_SYN now return -EFAULT after the saved SYN has already been
freed?

In do_tcp_getsockopt(), the TCP_SAVED_SYN success branch copies
tp->saved_syn->data to iter_out, calls tcp_saved_syn_free(tp) and returns
0. Only after that does this put_user() write optlen, and if it fails the
0 becomes -EFAULT.

Before this patch, optlen was written before optval and before
tcp_saved_syn_free(). Every -EFAULT return therefore left tp->saved_syn
in place, and the caller could retry.

Now suppose optlen is readable but not writable. get_user() in
sockopt_init_user() succeeds and the put_user() here fails. The caller
gets -EFAULT, but the one-shot saved SYN has already been freed.

TCP_ZEROCOPY_RECEIVE also writes optlen here after tcp_zerocopy_receive()
has consumed data. That option could already return -EFAULT after
consuming data when optval was unwritable, though.

The commit message mentions that an unwritable optlen now gives -EFAULT.
It does not mention that TCP_SAVED_SYN frees its saved SYN before
returning that error.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-getsockopt_phase7-v1-0-1eb759dd0929%40debian.org
