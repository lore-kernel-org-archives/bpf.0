Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226533F5A7
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532315; cv=none; b=pXaEwqVWVVAIIOPBG95NVtbZiz70SyL501X54LE3bZtwXY/w3S1k9ZiRHIrgf8KYY4Mjeg2ZvKQS2asHKs5JNkUT4gchoWd1CerDPYSojjYaImnCO1i2VdOz31u0vSf4vM9I2e0DUZtn+UyqGc5xQP0QjP3pbgd68WXW1/q+sS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532315; c=relaxed/simple;
	bh=n7bUEP+T0BiDUl9H971x92hiP9J75uOlHxFBoooHXhE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MkeIbR/WeM6reLI3dBW93OQoHHnkzlUIJaSqBk7MnkIxrZ22nVdFzcGC89Qd8B5F1LnIDwWI3rUweG1321ahIsvgR+UXwA2jooIcauEBf3ZOGvjedIvcUXSAgr9IkGIPzGFxFsg8mqVbL16KgJiHykuP4PmX6561utVbO8nIflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=g3UZt0Cv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="g3UZt0Cv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so19322355ad.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785532313; x=1786137113; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=amre6RfBaIhaLEjso+ANbhBwNJKFzvDlfPhWuXg/ZWA=;
        b=g3UZt0CvqScFFKtZ+S/oEu4D1vyx/ad5xhXbmIwh0YUjwHBQmaF2Si1zqJh4Ko1qxw
         L6W4KbpHD//PJvrL5ROj8YTums3cm5IUsFQY7SwYeLaiSFHSUrjgs5g9To9W3GliCkSm
         j13JkeM69baNem42xTILV37IkgtmZ35O6+mMOzSTqiVSS8wdOZwy+OxRPUl7IlNdsRIb
         TxTdb8nCP7K0VdAZ+XOu0GKZkxvO/FA+845BFfPQE5bKNwLRVoF32HlrMKJQbCGOhA58
         /yUcwr5Ms/2kEiMC95OCIRKH2jjedQO7CbPtuBsWLhdpeKTHKXTwk4vgu3oOFVBBH6ML
         hKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785532313; x=1786137113;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=amre6RfBaIhaLEjso+ANbhBwNJKFzvDlfPhWuXg/ZWA=;
        b=qOhNJmE8HBPhPn9ZUMBdyjju90rX000wuFogoWLSnkWmyQi9KLmtUdhx9DDS4K4c2E
         x3TK/tT1BtVMShJUKPiawdjVBqATOvzVr/xyY81aF3cFH9pHx36HUgiDRV0ayH8Zkcan
         uGGnGOkYwYTetCLSk9DDedRfcxXgZ/hG7x99Wj8zx42xIO7+GrEzt4veLzeFB4qOAt2D
         BK2/ZcJcif7prJIEGmgkqr/YO4kZuzSiBf7DoMEiKBpS/wUaad3VN7wI86mi9Vw1Wlf6
         arg+v5EYZRM8xCsM4JPLRDAbjS+azk55E0PI1sKPyGmzrB//ZU/fC3sr0yTZyY0bwQAs
         3usw==
X-Forwarded-Encrypted: i=1; AHgh+Ro48nISNg20QC/VWMGxp+QMXRG8Vg/arHBLt05Y49YCK8TSuKQFHjHghdprWra7GIMn4qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUkMR89154VCFzLqbjtbZXnSG3bdXLJbK6MZd+u/9yxW94Ndk
	E1hDVxed0M4fJtR5LsCZ8V4QoPGyGEkg7xcQtL7VJpLf/s4blQC9CrngkVLBBOlr//c=
X-Gm-Gg: AR+sD12Oz8sKxhiwOKSsKf2cOUxsVPeH005Ki+W0VO2EHRfMewbvLqTXSpAqN8lbqQ6
	ZEsjkmt28mOaw3z5YZrhvfjMcNY2czR8z5Hg1vHrppAnzv+SnOnvPFYA4IcdXBMvjt+ljvu2IX8
	2MbxEw5BeQMnownABb1CjZoySNMKL8NP3CKq/hMrMy/eB3f3s6nKQYDd1A2rN3Qe7n0brY8pZ9/
	naN6ZfuUoKBW3KcyiSuzSKHIPUfwKQUdOwFBI7JtQI38MxxBk35KXng3EbtCHRg82rGeos4sP6+
	dR3fxFg+L0oEPw/zvMLUxsX0kfNN6aoO186poRYK5aOolyHsHh1eSjacHUFIbWrfIgu0ItIrUb2
	Fe2JNYPBWsRCwBp3cwcP7vbf2oZYBDK8wIyNn/80NSxepUhi+hxc/TpJFvDi6PqA8V2KCD7bf1o
	5d3DGhYUCyQ5+hm71L0FmkwWOlw36rAkCLNPOsfAnYBNgRgAs6KSw1ZRf4CL//W8oLEwIqWnhHR
	pkcIUGJHT6OUcARsw==
X-Received: by 2002:a17:903:3843:b0:2ca:d9b3:715e with SMTP id d9443c01a7336-2d0521a55afmr14305445ad.9.1785532312582;
        Fri, 31 Jul 2026 14:11:52 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12101csm10458365ad.63.2026.07.31.14.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 14:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 17:11:51 -0400
Message-Id: <DKD2DNYT38YH.2GNNCMCEA1OKH@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 11/15] bpf: tcp: Support selected sock_ops
 callbacks as struct_ops
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-12-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-12-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> In LSFMMBPF 2025, I have talked about moving the BPF_PROG_TYPE_SOCK_OPS
> to a struct_ops interface [1].
>
> The BPF_SOCK_OPS_*_CB enum interface has grown over time as new TCP
> callback points were added. A BPF_PROG_TYPE_SOCK_OPS program now
> commonly needs a large switch on sock_ops->op, and the shared
> bpf_sock_ops_kern context has become harder to extend because different
> callbacks have different locking, argument, skb, and helper
> requirements. The existing 'union { u32 args[4]; u32 replylong[4]; }' is
> also not reliable in passing args to bpf prog when there are multiple
> progs attached to a cgroup.
>
> The above has already been solved in struct_ops. Add a TCP-specific
> struct_ops type, bpf_tcp_ops, and support attaching it to cgroups.
> This allows each callback have its own func signature and allows
> the verifier to select kfuncs/helpers based on the specific
> struct_ops member being implemented.
>
> This patch wires up the following existing sock_ops callbacks:
> - BPF_SOCK_OPS_TIMEOUT_INIT
> - BPF_SOCK_OPS_RWND_INIT
> - BPF_SOCK_OPS_RTT_CB
> - BPF_SOCK_OPS_STATE_CB
> - BPF_SOCK_OPS_RETRANS_CB
> - BPF_SOCK_OPS_TCP_CONNECT_CB
> - BPF_SOCK_OPS_TCP_LISTEN_CB
> - BPF_SOCK_OPS_RTO_CB
> - BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB
> - BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB
>
> BASE_RTT is ignored as it is not particularly useful. NEEDS_ECN should
> be done in bpf-tcp-cc instead. The tstamp ones should be a separate
> struct_ops (e.g. "bpf_sock_ops") that can work in both TCP and UDP.
>
> timeout_init and rwnd_init could have a request_sock pointer. This patch
> tries a different API and direclty passes the request_sock pointer as
> an arg.
>
> Two other approaches were considered before settling on having
> bpf_get_retval() read the dispatcher's run_ctx via saved_run_ctx. The
> first was to inherit the retval in the trampoline itself: add a helper
> in the four __bpf_prog_enter*() paths that, for struct_ops programs,
> copies the chained value from the caller's run_ctx (now saved_run_ctx)
> into the program's own run_ctx. It works but puts a per-enter
> program-type check on the generic trampoline fast path, taxing all
> fentry/fexit/lsm callers for a cgroup-struct_ops-only feature. The
> second was to do that same inherit only for the int-returning members
> via a gen_prologue that emits a hidden kfunc at the start of
> timeout_init/rwnd_init; this keeps the cost off the generic path and
> scoped to bpf_tcp_ops, but needs a kfunc + BTF_ID + prologue-emission
> machinery. The chosen approach avoids both: it touches neither the
> trampoline nor the program, since saved_run_ctx already points at the
> dispatcher's run_ctx that carries the value.
>
> [1], page 13: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbx=
bAjByp/view?usp=3Dsharing
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Two nits below.

> ---
>  include/linux/bpf.h    |   1 +
>  include/net/tcp.h      | 113 ++++++++++++++++++++++++-
>  net/ipv4/Makefile      |   1 +
>  net/ipv4/af_inet.c     |   1 +
>  net/ipv4/bpf_tcp_ops.c | 188 +++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp.c         |   1 +
>  net/ipv4/tcp_input.c   |   4 +
>  net/ipv4/tcp_output.c  |   2 +
>  net/ipv4/tcp_timer.c   |   1 +
>  9 files changed, 310 insertions(+), 2 deletions(-)
>  create mode 100644 net/ipv4/bpf_tcp_ops.c
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index df95ae690da5..91024d2da4ea 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2597,6 +2597,7 @@ struct bpf_trace_run_ctx {
>  struct bpf_tramp_run_ctx {
>  	struct bpf_run_ctx run_ctx;
>  	u64 bpf_cookie;
> +	int retval;
>  	struct bpf_run_ctx *saved_run_ctx;
>  };
> =20

<SNIP>

The retval is in bpf_tramp_run_ctx is generic, so maybe we can make the
helper for retrieving it generic, too. Should we at least rename it to
make this obvious?

> +{
> +	struct bpf_tramp_run_ctx *ctx =3D
> +		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
> +
> +	/* bpf_get_retval() is only exposed to timeout_init/rwnd_init, which
> +	 * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the int
> +	 * return value chained across the bpf_tcp_ops attached to the cgroup
> +	 * and is this program's saved_run_ctx.
> +	 */
> +	if (WARN_ON_ONCE(!ctx->saved_run_ctx))
> +		return 0;
> +
> +	return container_of(ctx->saved_run_ctx, struct bpf_tramp_run_ctx,
> +			    run_ctx)->retval;
> +}
> +

<SNIP>
