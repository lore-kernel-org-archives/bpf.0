Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36CD46DFE7;
	Mon,  5 Oct 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217642; cv=none; b=TQKu7Y0I/TX5zDkrolL0LCy7JW45RsDOn4ruORuEPwoMJkRObFYLA8pOZqUs2IjFJDROB67fmHb54dZBwMz4DMxD2CJfNTMIRDrmAk7REb8EDMxAk2hXo1H6+9LezaCR0rcaMZPBJvPQ0OqxzuJI+FZh9kQRhx1uXOgGtEfsSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217642; c=relaxed/simple;
	bh=PXxTzG0a5CtyD5egP7nH7cEXu9a6n+bK2IolR2cX7fs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SXCHsFykyyRGEkBmdkc5VvU5qvNq1oyklreO5cO54Sq+7kWoXJkTLTTouX0uwV2JGDfA5fNxoAchkgKMeOVkpLyT/xyGTqILSwmAueNLnhvzmo593lqQtP/vjl/9pZnLmPUV5dE8QfUd80BgdgztrkKCxasFIbZlf1Jylbtpk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RffsqITn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RffsqITn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BD21F000FF;
	Mon,  5 Oct 2026 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791217640;
	bh=YaEinOMstfpWavWT40qmD5u6Vfnc3QVy35x6DG5CszI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RffsqITnjixG+9/yO51DEHx3pdhl/BcIh1CTZsBwkudDbhjB1jkYofzoeLAsiBz/Y
	 I5M5jzL1sEwOrowZdwdQrSi3LnoAJWRrXHmpOV8BPVPf+Ps5pTb/VQTFCP/jSUjKmC
	 JkfB8+LZlU6KD53G9wh+LIeuXzIcx69ibkbGERiWaauzqnAsnbPG7xPX3yq5wuiSRe
	 yWaAQuDFGEhYqRxmCwAQlI57Q94sfyh/f2TkoI8PUR2aiM4Pu15KE6XYWnNXotVzut
	 GkXfZeVlMWMF8KY78EcWkidzcgD00xTDwHNEodRauQBgJwc1k0MrkiYFyy3EcfnHtb
	 SOMaiL1AIVMeA==
Content-Type: multipart/mixed; boundary="===============5483039106899521482=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7557423d5efced7e3307ed14a4ad8f364246f3ea738395123f61296ac4cc2284@mail.kernel.org>
In-Reply-To: <20261005154533.4147685-3-kuniyu@google.com>
References: <20261005154533.4147685-3-kuniyu@google.com>
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: ameryhung@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@kernel.org,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  5 Oct 2026 16:27:18 +0000 (UTC)

--===============5483039106899521482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.

TL;DR: The bpf_tcp_ops_set_flags() kfunc filter seems to let cgroup_skb and
sock_ops programs call it too, not just bpf_tcp_ops and cgroup_sockopt; this
is an API scope issue, not memory safety.

> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c

[ ... ]

> +static int bpf_tcp_ops_set_flags_kfunc_filter(const struct bpf_prog *prog,
> +					      u32 kfunc_id)
> +{
> +	if (!btf_id_set8_contains(&bpf_tcp_ops_set_flags_kfunc_set, kfunc_id))
> +		return 0;
> +
> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
> +	    prog->aux->st_ops != &bpf_tcp_ops)
> +		return -EACCES;
> +
> +	return 0;
> +}

[ ... ]

>  static int __init __bpf_tcp_ops_init(void)
>  {
> -	return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
> +	int ret;
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					&bpf_tcp_ops_set_flags_kfunc_id_set);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
> +					       &bpf_tcp_ops_set_flags_kfunc_id_set);

The commit message says the kfunc is exposed to bpf_tcp_ops and
BPF_PROG_TYPE_CGROUP_SOCKOPT. Does this registration limit it to those two
program types?

register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, ...) puts the set
into the shared BTF_KFUNC_HOOK_CGROUP hook.  bpf_prog_type_to_kfunc_hook()
in kernel/bpf/btf.c maps CGROUP_SKB, CGROUP_SOCK, CGROUP_DEVICE,
CGROUP_SOCK_ADDR, CGROUP_SOCKOPT, CGROUP_SYSCTL and SOCK_OPS all to that
one hook.

btf_kfunc_is_allowed() looks the kfunc up in that hook and then only runs
the hook filters, and bpf_tcp_ops_set_flags_kfunc_filter() returns 0 for
every program type except a STRUCT_OPS program that is not bpf_tcp_ops:

    if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
        prog->aux->st_ops != &bpf_tcp_ops)
            return -EACCES;

    return 0;

That seems to let BPF_PROG_TYPE_CGROUP_SKB and BPF_PROG_TYPE_SOCK_OPS
programs call bpf_tcp_ops_set_flags() as well.  Both program types provide
bpf_tcp_sock() (cg_skb_func_proto and sock_ops_func_proto in
net/core/filter.c), and the verifier accepts the returned PTR_TO_TCP_SOCK
as a trusted struct tcp_sock * through reg2btf_ids[].

For cgroup_skb the likely caller is an ingress program running in softirq
context.  The commit message mentions cgroup_skb only as a possible future
use.

The cmpxchg update keeps this memory safe, so this is about API scope:
once programs start using the kfunc from these other program types,
narrowing it later would break them.

bpf_qdisc_kfunc_filter() and scx_kfunc_context_filter() both reject the
program types they do not intend to serve.  If only bpf_tcp_ops and
CGROUP_SOCKOPT are intended, should the filter reject prog->type values
other than BPF_PROG_TYPE_STRUCT_OPS and BPF_PROG_TYPE_CGROUP_SOCKOPT?

Otherwise, could the commit message list the actual set of program types
that can call the kfunc?

This filter is unchanged through 3cb5919af2b2 ("selftest: bpf: Add test for
bpf_tcp_ops.{enqueue,dequeue}_rcvq()."), so no later patch in the series
changes it.

> +	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
> +
> +	return ret;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37336989320
--===============5483039106899521482==--
