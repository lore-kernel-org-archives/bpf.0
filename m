Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E049426C;
	Sat, 17 Oct 2026 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792249404; cv=none; b=e8mQmhnWF9u0ppv3ku36eQeFQQGwJQYcKQv+v4Jm+PjQ2vcULOtg82lwPt7FI7YTu3XrxGcSvoyxWrpipfh2RyHfIcszlBle7shEHh7ZdRtPn4pRluqWX9wvixTW0aWvgvxyjzKmyxdnPvc2GMInmKI1UTl15XqcFFaav3Qhgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792249404; c=relaxed/simple;
	bh=4xGFhMRn3P9lLCC/56FbpG/GnjMBFgcIohX6E4/JfFE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pgvMU4vxkm9y+OQiskQt7E7+F8FCkfenBxWqo1fRl2P3wFTY6odP0PqYSnvioNuAfI8cM/yIsnHVe7YbJm6DaB0n8ar5gAQ+RalSpz2f/HbPhtK61nlaJZ7i4++HmHYe5N/kLO3fzCNOcrRsPzp86NAnlaFGD2TSNyi98mOG0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1nG+lc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1nG+lc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EE01F000C4;
	Sat, 17 Oct 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792249398;
	bh=LSCpfI3XjSFvwMZDfugN2XLoMbh0rkBixbyIIgKzJFM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Q1nG+lc3B6XyVEchLJNsVgd6v8NDSX958wDBLO9KguQfJoRBnVdXhySv/rbx9j8zt
	 iLbyqf3U2yjyvdd1EUeTCWjlDlis8Bf7Q6osB3qmtvBhvBm6LN6oYjGUi73VX/VW41
	 JRRF9krjzYBQkUkcwuVwfBreYCqUhEZJtT85zldV7nOCQ80Qt3cFJ9PrGBbG0TiDDw
	 tf6q9ImIUDtdXUssBrIs7U6JMhbAjutNwvsvE+LMxRnBr2WtxwXFi4ulyUrneKPvv7
	 DrxaNi8LklHKsrx3UMahErCOUjTzEqbOWuJmDsgGp1gfXQtcHqJvMeEr+uaQ09MeM0
	 Phe9lF9OHXTXw==
Content-Type: multipart/mixed; boundary="===============1345561752744576610=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <41c7d03fa06bd4e9439560fac5b3cf4d170b96b5c23946da8a3449e05c482b38@mail.kernel.org>
In-Reply-To: <20261017142649.51047-3-leon.hwang@linux.dev>
References: <20261017142649.51047-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add syscall common attrs support for xdp link_create
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,shuah@kernel.org,kuniyu@google.com,liuhangbin@gmail.com,mkarsten@uwaterloo.ca,masashi.honma@gmail.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 15:03:14 +0000 (UTC)

--===============1345561752744576610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add syscall common attrs support for xdp link_create

TL;DR:
- bpf_log(log, extack._msg) in bpf_xdp_link_attach() may dereference NULL when
  no extack message is set
- bpf_log() may be an undefined reference when CONFIG_BPF_SYSCALL=n

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 18dc88990510..fdc1de21f358 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -10784,6 +10786,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
>  	if (!dev) {
>  		rtnl_unlock();
> +		bpf_log(log, "Invalid target_ifindex.\n");
>  		return -EINVAL;
>  	}
>

Can this fail to link when CONFIG_BPF_SYSCALL is not set?

bpf_xdp_link_attach() is built whenever CONFIG_NET=y, but bpf_log() lives in
kernel/bpf/log.c, which kernel/bpf/Makefile only builds under
CONFIG_BPF_SYSCALL:

  obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o ... log.o ...

include/linux/bpf_verifier.h declares bpf_log() with no stub for the
!CONFIG_BPF_SYSCALL case, and CONFIG_NET only does "select BPF".  A config
with CONFIG_NET=y and CONFIG_BPF_SYSCALL=n looks like it would end with an
undefined reference to bpf_log from both of the new calls in this function.

include/linux/bpf.h provides static inline stubs for bpf_link_init(),
bpf_link_prime(), bpf_link_settle() and bpf_link_cleanup() so that this
function builds without the bpf() syscall.

Should bpf_log() get a similar stub, or should the calls be guarded with
IS_ENABLED(CONFIG_BPF_SYSCALL)?  None of the later patches in the series add
a stub or change the Makefile.

[ ... ]

> @@ -10812,6 +10815,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  	if (err) {
>  		link->dev = NULL;
>  		bpf_link_cleanup(&link_primer);
> +		bpf_log(log, extack._msg);
>  		trace_bpf_xdp_link_attach_failed(extack._msg);
>  		goto out_put_dev;
>  	}

Can extack._msg be NULL here?

extack is zero-initialised (struct netlink_ext_ack extack = {};), and _msg
stays NULL whenever dev_xdp_attach_link() fails without anyone calling
NL_SET_ERR_MSG().  Many ndo_bpf implementations do exactly that.  For
example, ixgbe_xdp() -> ixgbe_xdp_setup() has several -EINVAL and -ENOMEM
returns that don't set an extack message, and mlx5e_xdp_set() ->
mlx5e_xdp_allowed() returns -EINVAL with only a netdev_warn().

If the caller passed BPF_COMMON_ATTRS with log_level != 0
(bpf_verifier_log_attr_valid() accepts log_level=1 even with a NULL log_buf
and a log_size of 0), bpf_verifier_log_needed() is true and the call chain
becomes:

  bpf_log(log, NULL)
    -> bpf_verifier_vlog(log, NULL, args)
      -> vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, NULL, args)
        -> vsnprintf()    /* while (*fmt.str) with fmt.str == NULL */

which dereferences NULL.  The tracepoint on the next line copes with NULL
because __assign_str() substitutes a placeholder string, and the netlink ack
path also checks extack->_msg, so this new bpf_log() call looks like the only
consumer without a NULL check.

Passing the message as the format string also means a '%' in an extack
message would be interpreted as a conversion, and unlike the other bpf_log()
messages in link_create(), this one has no trailing newline.  Would
something like this be better?

  if (extack._msg)
          bpf_log(log, "%s\n", extack._msg);

This isn't fixed later in the series.  Commit 2a63a314e533 ("bpf: Retire
tracepoint bpf_xdp_link_attach_failed") removes the tracepoint but keeps
bpf_log(log, extack._msg), so no NULL-safe consumer is left on this path.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39042048581
--===============1345561752744576610==--
