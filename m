Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A9358372;
	Thu,  8 Oct 2026 04:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791432171; cv=none; b=lywHXWhDa98UYR7sBFbxKZ7pE86opR+3X82LkoNe+cFYijsmoMLJMTU7t9d/iGAeVUr5a6KKF8Yp0qyPIeDqxcAs1gSSVV18axftuwy0CvA6S5PZUq3rykn02vdmiXjwxNaLAUg2oiIUcTi3LhtgydgwEQKJ1OlhKj2i6HQ7p7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791432171; c=relaxed/simple;
	bh=ZkBo8ToiY7I4thazMTZytXCyurqMCPnJd7rfuG0xwYs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ElfbfDkNWUkACMT6aEsf01YcoRL/Dd1Ukb7uQua9VV3s6n0NVsA6ZrYuCXQvwp+NcZElXrw8KcKGDowZwWpK6z8CXzgdN990GHfTIfAXo18tK2UzaZCV2tnrKU1WMkAosO0fUF4jHwwO39SNBck+iOMvxa2qAYAe+imRrJ0Xmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKDb1IHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKDb1IHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CDD1F000FF;
	Thu,  8 Oct 2026 04:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791432170;
	bh=hwreTQ9JOx2NE8u667ANEuwuDakt1ugHMtb4WaDk7WU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HKDb1IHUP/muGyHwjYIHrp8Gp8PWXN4z+yVaYxKmBWeKlmKPeyDQHwlgXRBY3ljqt
	 vIcmGrdsBHrZWb0pGzcp+Un2r97SdOYCu2o8fng0w8Pv0OBuAGeoRAR+BhElIiVr0s
	 kOZ/xzrVS10V9WmROcK1qC+yoz80ZbDyH7bF/GAddnIjAax3dpE0qJA6sh7UI5edAg
	 xgFaJWQEpSFzYXTjKbVOVHaEPLGk6Uy77dmEktQKDOe1mC+e9nJP5ccUFzVOu0h2ny
	 NNj1PHqwR9QkfXl2FfMEkEb64WpYGfyBxOwD9xkLAfPjHGwVaKs2yJHsfL2LvjgOb6
	 rvQvFhcDqRHBA==
Content-Type: multipart/mixed; boundary="===============0653454793552695213=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4cb1d1e4819cf8b8a22c977ce1f1166041364baf412016e0abd82ac537151887@mail.kernel.org>
In-Reply-To: <20261008031604.256498-5-kuniyu@google.com>
References: <20261008031604.256498-5-kuniyu@google.com>
Subject: Re: [PATCH v5 bpf-next 04/10] bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: ameryhung@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@kernel.org,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  8 Oct 2026 04:02:47 +0000 (UTC)

--===============0653454793552695213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.

TL;DR: Commit message only: it says the static key is checked in
bpf_tcp_ops_hdr_opt_len() and that __bpf_tcp_ops_call() checks it, but the
code checks it in tcp_bpf_hdr_opt_len() and bpf_tcp_ops_call_flag().

>     bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.
>
>     bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
>     incoming / outgoing skb.
>
>     bpf_tcp_ops.rtt is called once per RTT, which is every
>     incoming skb in ping-pong workloads like tcp_rr.
>
>     Even attaching NULL callbacks in the fast path hurts performance.
>
>     Let's guard them (and write_hdr_opt) with the new per-socket flags.
>
>     __bpf_tcp_ops_call() and bpf_tcp_ops_call_flag() are added to check
>     cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) first and avoid accessing
>     tp->bpf_tcp_ops_flags when no bpf_tcp_ops is attached.
>
>     Note that bpf_tcp_ops_hdr_opt_len() has 3 callers and previously
>     checked the static key both in tcp_established_options() and inside
>     bpf_tcp_ops_call().  Now the static key is checked once at the
>     beginning of bpf_tcp_ops_hdr_opt_len(), and the redundant check in
>     tcp_established_options() is removed.
>
>     tcp_bpf_hdr_opt_len() must use __always_inline, not just
>     inline, otherwise Clang inlines bpf_tcp_ops_hdr_opt_len() to
>     tcp_bpf_hdr_opt_len() instead.
>
[ ... ]
>
>     bpf_skops_write_hdr_opt() is still not free, but it can be
>     optimised later if needed.
>
>     Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

The changelog says the static key is now checked "once at the beginning of
bpf_tcp_ops_hdr_opt_len()", but the code doesn't do that.

The only cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) check on this path is in
the new tcp_bpf_hdr_opt_len() wrapper:

    static __always_inline u32 tcp_bpf_hdr_opt_len(...)
    {
            if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
                    remaining = bpf_tcp_ops_hdr_opt_len(...);

            return remaining;
    }

bpf_tcp_ops_hdr_opt_len() itself now starts with the per-socket flag test
and then calls the unguarded __bpf_tcp_ops_call():

    if (!BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT) ||
        !remaining)
            return remaining;
    ...
    __bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type,
                       &remaining_out);

So bpf_tcp_ops_hdr_opt_len() reads tp->bpf_tcp_ops_flags without checking
the static key, and must only be reached through tcp_bpf_hdr_opt_len().

Should the changelog say tcp_bpf_hdr_opt_len() here?

Similarly, the sentence saying __bpf_tcp_ops_call() and
bpf_tcp_ops_call_flag() are added "to check
cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) first" doesn't match
__bpf_tcp_ops_call(), which is the variant that does not check the static
key.

Could that sentence be reworded to say that only bpf_tcp_ops_call_flag()
does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37723340307
--===============0653454793552695213==--
