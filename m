Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D2A5111A4;
	Thu,  3 Sep 2026 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465449; cv=none; b=Wyq3JEsAB5RGxZL/79fesRArqpjzoMp7J/EHMoTvTAZRxB3BNPyNykiKbeGJGPQFDklNNjYrzI+/8K5a3jcNd6YhgkiqmvYzcZgTi1wWQ86atP40ULyI0nnceEO3CvO7imAlYAiYikwgpBkekDQOcGuwhUFT16U6YkhW5W68H9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465449; c=relaxed/simple;
	bh=fG/FEDIuLMTivnUz8eK5Qziuhu+vSJp+/obj6mKbnto=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AYPnHSra6/Ui1YAHeGXlq/HdxR+nVGTGYqrLZH3bwOySg17RznbQUyadCJ3IwxB4rLXOyFJ5fmcnaxzifVT5NF5sFaNkUOOMOOzUcbcx6xJGNfPs41FX1x6nZLoNal84BjBD5IhNqPx5aUzvp5fkWJUEGbVUnMeoYvoNsxi1Npk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg0aIPyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg0aIPyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2546F1F00A3D;
	Thu,  3 Sep 2026 19:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465438;
	bh=8ijoOCBsjxqWspNhv9YX1biYRZjC6mdmUxvTF5JNzU0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cg0aIPyzv9afcbCDP6ajcTqOx8wYXAZ9CuSobh44DObVp/+RZ/+gyDce9jCPzC83e
	 PicX4vvIy6/En1JBXt0dcpeEAyUWzLCaNIq8NTfLtjLK3cdnds8P3wQQzT8MihAxS8
	 +p6hMqxJSNWc00Bl0pphsCBjFF8CgnskeBYlBYqYLUiz8sUOJpOrK8LjaJhOMBTVYi
	 cmPF9AqrZgbGP1CaFTNZNI5x8Z7GWQDGsaB4sCSwpOCpoRhTqW/vFRlLRTEF8JuF6q
	 8f/fBdUS1LjYpYoC3JaNP/WPHPenFSx22ZIrq9umTmiTrui87jEmqiCZvd08uPhyN4
	 rVAcehAUYvywg==
Subject: Re: [net-next,v9,2/2] bpf: make tcp_tso_autosize() available to BPF
 congestion controls
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
Date: Thu, 03 Sep 2026 19:57:15 +0000
Message-ID: <178846543569.3394541.18437363003445418761@kernel.org>
In-Reply-To: <20260831165230.2696893-3-chia-yu.chang@nokia-bell-labs.com>
References: <20260831165230.2696893-3-chia-yu.chang@nokia-bell-labs.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] New kfunc `tcp_tso_autosize()` is registered in the TCP
  congestion-control kfunc set (net/ipv4/bpf_tcp_ca.c:197) without any…

--

bpf: make tcp_tso_autosize() available to BPF congestion controls

This exposes tcp_tso_autosize() as a BPF kfunc and registers it in the TCP
congestion-control kfunc set.  It also sanitizes min_tso_segs to at least 1
and returns that sanitized minimum when mss_now is 0.

> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index ed4fea98dfde1..9deed2244c2de 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -194,6 +194,7 @@ BTF_ID_FLAGS(func, tcp_reno_cong_avoid)
>  BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
>  BTF_ID_FLAGS(func, tcp_slow_start)
>  BTF_ID_FLAGS(func, tcp_cong_avoid_ai)
> +BTF_ID_FLAGS(func, tcp_tso_autosize)
>  BTF_KFUNCS_END(bpf_tcp_ca_check_kfunc_ids)

[Severity: Low]
Is there a selftest planned for this new kfunc?  A grep for
tcp_tso_autosize at this commit matches only:

    Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
    include/net/tcp.h
    net/ipv4/bpf_tcp_ca.c
    net/ipv4/tcp.c
    net/ipv4/tcp_bbr.c
    net/ipv4/tcp_output.c

so nothing under tools/testing/selftests/bpf references it.

The other members of bpf_tcp_ca_check_kfunc_ids do have a consumer, for
example in tools/testing/selftests/bpf/progs/bpf_cubic.c:

    extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
    extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;

and the tso_segs struct_ops program in
tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c still calls
bbr_tso_segs(sk, mss_now) rather than the newly exposed kfunc.

Would adding a struct_ops program that declares

    extern __u32 tcp_tso_autosize(struct sock *sk, __u32 mss_now, int min_tso_segs) __ksym;

and calls it be worthwhile, so that the load-time BTF/argument match for
the promoted kfunc is checked?

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b1b493d46b9cf..b7f2ee5e7a6b1 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2252,13 +2252,21 @@ static bool tcp_nagle_check(bool partial, const struct tcp_sock *tp,
>   * in bigger TSO bursts. We we cut the RTT-based allowance in half
>   * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowance
>   * is below 1500 bytes after 6 * ~500 usec = 3ms.
> + *
> + * The min_tso_segs is floored to 1 to avoid surprising conversion. Also,
> + * BPF callers may pass mss_now == 0. In that case the function returns the
> + * sanitized min_tso_segs value and skips autosizing.
>   */
> -u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> -		     int min_tso_segs)
> +__bpf_kfunc u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> +				 int min_tso_segs)
>  {
> +	u32 min_tso = max(min_tso_segs, 1);
>  	unsigned long bytes;
>  	u32 r;
>  
> +	if (unlikely(!mss_now))
> +		return min_tso;
> +

[Severity: Low]
Can either of these two new branches be reached by anything in the tree
today?

tcp_tso_segs() passes sysctl_tcp_min_tso_segs, whose minimum is 1, together
with a non-zero tcp_current_mss() value, and bbr_tso_segs() already filters
out !mss_now before passing 1 or 2:

    net/ipv4/tcp_bbr.c:bbr_tso_segs() {
        ...
        if (mss_now)
            segs = tcp_tso_autosize(sk, mss_now, min_tso_segs);
        ...
    }

That leaves a BPF congestion control as the only caller that can pass
mss_now == 0 or min_tso_segs < 1, and no such program exists in
tools/testing/selftests/bpf.  Would a test that exercises these two paths
be worth adding alongside the kfunc registration?

>  	bytes = READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shift);
>  
>  	r = tcp_min_rtt(tcp_sk(sk)) >> READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tso_rtt_log);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831165230.2696893-1-chia-yu.chang%40nokia-bell-labs.com
