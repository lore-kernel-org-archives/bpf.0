Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCA314B63;
	Thu,  3 Sep 2026 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465454; cv=none; b=ZvWL/I9WKWBZNB3FNf4P75hRZThBjYg8Ezucw9tael2/o5E0MWpsSxaHu1M2RhCFeIGbdrhyo3FLBlqDDwBexPXaxsfmCz4P9NkTQhuLHmBDHepiJ8EyQZSTGe72WC0BnYatH3zkcMbG4ewB39uJonrGNKvsJE8040UzUvmkVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465454; c=relaxed/simple;
	bh=fmxBut2r/MdOgNLJ7AkgWTHL/DFaVyUjRO6GdYPY9IQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GaIO1HmZlpQvmAWCtKUuPESxSUcOtTJfBV+TzeJR1gUCv+MWaL0ZXSugVzzSxGztz122KPzjtJn2CzbsSJO7jstk8gZpgF2dBxYhZCyAvsmgEoElaA5f3h7aEMHSe4Dp6RdHEQwOmtHmbsEAciPVE2HOvn90OhmV7H4I05K5dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mShBYE5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mShBYE5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7649A1F000E9;
	Thu,  3 Sep 2026 19:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465435;
	bh=VzbwYl2+rL3MNbaIw+TeYvTAUnrzEvaim7JN8m2R0Gs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mShBYE5aJW9JG1EmqmMUmqc/UnFnoV8s8EW4POCIvmyiB2gXIEJ92JLSwDZkF3Dpp
	 bSjtHZu5RyA/tEp5J7b2VLNStylWuV3DQObuBfN6H/R7C+v02S7fcE745BAHPg8kwu
	 C0uRxkz4RD7rF6pOHWXi+nx9CXX+hBe0PaemqEniTfcIry6f7gkXG5W/4xUB0VVztN
	 HvOlicmPQJs5Iyh8Ee1yJJrKosx28x5EwL7UQhHzPPs6bBDfC578p4tlzM3+S3d1Uo
	 jIwyzSnm2tgNBU8qvUXAfIc/p/L4y7vAzt8mVsRm+OrdxkKSP2D6+mwEVXqfnoyoGp
	 8HXGhEE2j1E1g==
Subject:
 Re: [net-next,v9,1/2] tcp: Replace min_tso_segs() with tso_segs() CC callback
From: netdev-bot+sashiko@kernel.org
To: chia-yu.chang@nokia-bell-labs.com
Cc: ihor.solodrai@linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com,
 jiayuan.chen@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org, dsahern@kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, stephen@networkplumber.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 kuniyu@google.com, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Mike_Rudolph@comcast.com, Jeff_Howe@comcast.com,
 srichard@netapp.com, kuba@kernel.org
Date: Thu, 03 Sep 2026 19:57:13 +0000
Message-ID: <178846543301.3394541.455246755221753943@kernel.org>
In-Reply-To: <20260831165230.2696893-2-chia-yu.chang@nokia-bell-labs.com>
References: <20260831165230.2696893-2-chia-yu.chang@nokia-bell-labs.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The patch silently removes the `bbr_min_tso_segs` BPF kfunc
  without a deprecation window and without mentioning it in the commit…

--

tcp: Replace min_tso_segs() with tso_segs() CC callback

The min_tso_segs() congestion control callback is replaced by a new
tso_segs() callback that takes mss_now and returns the final TSO segment
count, bypassing tcp_tso_autosize().  tcp_tso_autosize() is exported so
modules can still do the autosizing themselves, and BBR is converted to
the new callback.

> diff --git a/include/net/tcp.h b/include/net/tcp.h

[ ... ]

> diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
> index 82378a2bfd1e1..ecf11be46f382 100644
> --- a/net/ipv4/tcp_bbr.c
> +++ b/net/ipv4/tcp_bbr.c
> @@ -297,11 +297,18 @@ static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
>  }
>  
>  /* override sysctl_tcp_min_tso_segs */
> -__bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
> +static u32 bbr_min_tso_segs(struct sock *sk)
>  {
>  	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
>  }
>  
> +__bpf_kfunc static u32 bbr_tso_segs(struct sock *sk, u32 mss_now)
> +{
> +	if (unlikely(!mss_now))
> +		return bbr_min_tso_segs(sk);
> +	return tcp_tso_autosize(sk, mss_now, bbr_min_tso_segs(sk));
> +}
> +

[ ... ]

> @@ -1163,7 +1170,7 @@ BTF_ID_FLAGS(func, bbr_sndbuf_expand)
>  BTF_ID_FLAGS(func, bbr_undo_cwnd)
>  BTF_ID_FLAGS(func, bbr_cwnd_event_tx_start)
>  BTF_ID_FLAGS(func, bbr_ssthresh)
> -BTF_ID_FLAGS(func, bbr_min_tso_segs)
> +BTF_ID_FLAGS(func, bbr_tso_segs)
>  BTF_ID_FLAGS(func, bbr_set_state)
>  BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)

[Severity: Medium]
Dropping the __bpf_kfunc annotation from bbr_min_tso_segs() and replacing its
BTF_ID_FLAGS() entry with bbr_tso_segs() takes the bbr_min_tso_segs kfunc out
of the kernel BTF kfunc set in one step.  Should this go through a
deprecation release instead?

Any out-of-tree BPF congestion control containing:

    extern u32 bbr_min_tso_segs(struct sock *sk) __ksym;

now fails to load with "kernel function bbr_min_tso_segs not found in kernel
BTF", and that applies to programs calling it from any callback, not only
from the renamed one.

The helper is still present and still called internally, both from
bbr_tso_segs() and from bbr_tso_segs_goal():

net/ipv4/tcp_bbr.c:bbr_tso_segs_goal() {
    ...
	segs = max_t(u32, bytes / tp->mss_cache, bbr_min_tso_segs(sk));
    ...
}

so would keeping the BTF_ID_FLAGS(func, bbr_min_tso_segs, KF_DEPRECATED)
entry for a release work here?  Documentation/bpf/kfuncs.rst says "It's
expected that the common case will be that kfuncs will go through a
deprecation period rather than being changed or removed without warning".

The v8 changelog of this submission said "Deprecate bbr_min_tso_segs() kfunc
instead of removing it", and v9 said "Remove deprecated flag on
bbr_min_tso_segs()", so the deprecation flag appears to have been dropped
again between revisions.  Was that intentional?

The commit message lists the BPF struct_ops impacts as:

    - The callback is renamed from min_tso_segs() to tso_segs()
    - The signature gains an extra u32 mss_now argument
    - The return value semantics is changed from "floor value passed into
      tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing

Could the disappearance of the bbr_min_tso_segs kfunc be added to that list?

On the replacement side, the follow-up commit in this series, "bpf: make
tcp_tso_autosize() available to BPF congestion controls", marks
tcp_tso_autosize() as __bpf_kfunc and adds it to bpf_tcp_ca_check_kfunc_ids,
so a BPF congestion control can reproduce the old "raise the floor, keep
autosizing" behaviour by calling tcp_tso_autosize(sk, mss_now, my_floor)
from there on.  At this commit alone that kfunc is not yet registered, so
bbr_tso_segs() with BBR's hardcoded 1-or-2 floor is the only substitute.

In-tree users were updated in
tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c and no other in-tree
reference to the old kfunc remains.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831165230.2696893-1-chia-yu.chang%40nokia-bell-labs.com
