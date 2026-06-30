Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6232B101
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861655; cv=none; b=Tnpa3rsR1EauyDyzysB8v6rLMISgnwqNgfw9k7st+3wnBNASQB0C9ykeDAXsI1NxGgQQFryPRA+4ztsem+9JCwFns8vH0upeAH5pUNd4wiCr3v7qUGeUF6WKJh+t0Kx1waQVhqROtbd1VCd/XYtLM/IgBr4vOVuLqI0Qqjq/mOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861655; c=relaxed/simple;
	bh=MyCniKPbL+Lqz0L65ltscAhVa5RtLJou0ccIhfIbqqM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=s0r0eKhLC0vmwBGqd8VX1EJfAGjmtBvXlcYcySbzbW1tlyntUW+xVSoh5sdMI+pYkJwI/XfSMC3VZQhN9SH9Z2il2hx1XiAT1yHwoDDNTyy67LZBev9/xCt7AKyOkeeKSj3Go2rhCDI4rTdc3iydiL4DUTB9YPCtS+JDV2VBpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzNNrkAt; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzNNrkAt"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a0b1edbe32so43948eaf.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782861653; x=1783466453; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB/ZP5ypFx7PVtX4ppcUb1XeE8gYOmi+BvjetO5FJh0=;
        b=VzNNrkAtr3vorUdKjBcmEOX/USgnVzzkhlPWtka584Vgz/IoNRu1z9NPYEmrCdpGoD
         T/goRJRJtuLRDQJ2EAvmoLQh3tMkw/G/tHpRw6xVpA7ym1ntBYQd0YAYJZduCLLA5VrP
         oW47bR1oNIrvTTNdZHhQq85wj+x26Tm/yvBdiT3dBR4Q8ChN85UwYC9qd7euygesn8nM
         4XZyxkg3fbj4Dvgj+dobyXV4jCXMZZsNsOvVigmzhpcvqVOadGDCOKLX8PS6m2+QjSCp
         hTlfcPGqoXltU5VRQDdgMB3p7VSyP38DaHsSm+sFnTx7Q28Tzs7LoN+UCuGR9gxrjEAY
         VuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782861653; x=1783466453;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cB/ZP5ypFx7PVtX4ppcUb1XeE8gYOmi+BvjetO5FJh0=;
        b=Uqv5YSlXlRLP1JC/WMTwDG1putmjoYpLbrp+S5+GGICUNMLZRNfRP9BhzaCcF9Hxfy
         kxg+GoxSO69fIvbHBGv6/IHqg58TXWwQluv0WtaEMj3CWRHsNQt8FBaW4hnnovzi4Cxn
         gJFPSMQEjHTN5O6QLfdlZQaXZkd80p1t0yoyHF70cNt7fl9/xFHoJs+E1s9bEQ+hMcI3
         H482xPWlMklej1Yp6imtVy6QPnYeLUh2flJY5G2cI6DPNuFUbQ4tZ++ILcbzisUl0Ytw
         /g6mBDLT/yD4YMnibNp06cTSivDvwJhs1qYvxusIFmqKDt1PG47rTPv9nWQJV+IcLsgB
         duAw==
X-Forwarded-Encrypted: i=1; AFNElJ+pDMslDftCI/rJZIE8FoJ/IBVVUAEXp+NQ35tF+rgDPbZm8bR/3nLSuidgZ2VHrFYWuf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgf3cHIxbaIdkJG59EN0MmYgb/1ogLQNYkCPU3QPHzIADMkyqa
	uNVh/c9HxqOtnjcJoexEu2A61wRpYYHFohXBPt8FJwy5sJNK4qR9MJL+
X-Gm-Gg: AfdE7cnidtY05F/nwpLUz38u+3GXSS9MTmrAvdka/t3UEf44w7H7b7KrPD3HEZEROq9
	C1UXgviEITKmTO6pauNosCPDxdcY8HZfE9YTz3QvTdwPdRXsMM5n03AxIGuaPKBnVIqDIp79fMd
	mut/2t59XSn0iFYVI/NxUxE6fe+IOi71UVgAO+tSypGgVnuTjB45z44sWcpbX7+MZc7TyKedXOY
	VGN5TqmUe/t9RFx+WRUTumUlF5rGXIBGfhu7Sk2a/ZN8BQMxyS/fgS57FQfGKR2TRkb122NF3RJ
	oL1TjV9ukz34qE3Nw/mtf3ivj90ekNciMvrHcdGaJoN2X1jcdE1EGoou71ItK968IfAPhMqPgai
	xVMpbrUQl6Rn1hO2mkEFvTrrmVB6c1oUoqSfVGNFWgBTrzNHODc1cEzedm+INwf8D+txbj09neU
	PRpW0BhSNPlBQZm6ap4g4ZspIYsFjclm2dvW6+T4TLBOrZUDaYk4Axw3MiiDQ7W4Tx9OAY+lhhW
	lwfSAs=
X-Received: by 2002:a05:6820:4df3:b0:6a1:4592:eded with SMTP id 006d021491bc7-6a188e2a5efmr3936292eaf.0.1782861652634;
        Tue, 30 Jun 2026 16:20:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a18949b384sm2986584eaf.15.2026.06.30.16.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 16:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 16:20:50 -0700
Message-Id: <DJMRPJEUTY5G.30HYOMPLBGZOJ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <chia-yu.chang@nokia-bell-labs.com>, <jolsa@kernel.org>,
 <yonghong.song@linux.dev>, <song@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <memxor@gmail.com>, <shuah@kernel.org>,
 <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <horms@kernel.org>,
 <dsahern@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <jhs@mojatatu.com>, <kuba@kernel.org>,
 <stephen@networkplumber.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <donald.hunter@gmail.com>, <kuniyu@google.com>,
 <ij@kernel.org>, <ncardwell@google.com>,
 <koen.de_schepper@nokia-bell-labs.com>, <g.white@cablelabs.com>,
 <ingemar.s.johansson@ericsson.com>, <mirja.kuehlewind@ericsson.com>,
 <cheshire@apple.com>, <rs.ietf@gmx.at>, <Jason_Livingood@comcast.com>,
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
X-Mailer: aerc
References: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>

On Tue Jun 30, 2026 at 5:01 AM PDT, chia-yu.chang wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> This patch replaces existing min_tso_segs() with tso_segs() CC callbak
> for CC algorithm to provides explicit tso segment number of each data
> burst and overrides tcp_tso_autosize().
>
> This change provides below impacts on BPF struct_ops users:
> - The callback is renamed from min_tso_segs to tso_segs
> - The signature gains an extra u32 mss_now argument
> - The return value semantics is changed from "floor value passed into
>   tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing
>
> As a result, BPF programs shall be updated, beccause retuning a small
> constans will now directly limit tso_segs instead of the minimum.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp.h                                | 13 +++++++++++--
>  net/ipv4/bpf_tcp_ca.c                            |  8 +++++---
>  net/ipv4/tcp_bbr.c                               | 13 ++++++++++---
>  net/ipv4/tcp_output.c                            | 13 +++++++------
>  tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
>  5 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6d376ea4d1c0..7fb42a0ce7da 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -824,6 +824,9 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu);
>  unsigned int tcp_current_mss(struct sock *sk);
>  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when);
> =20
> +u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> +		     int min_tso_segs);
> +
>  /* Bound MSS / TSO packet size with the half of the window */
>  static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize=
)
>  {
> @@ -1361,8 +1364,14 @@ struct tcp_congestion_ops {
>  	/* hook for packet ack accounting (optional) */
>  	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
> =20
> -	/* override sysctl_tcp_min_tso_segs (optional) */
> -	u32 (*min_tso_segs)(struct sock *sk);
> +	/*
> +	 * Override tcp_tso_autosize (optional)
> +	 *
> +	 * If provided, this callback returns the final TSO segment number
> +	 * and will bypass tcp_tso_autosize() entirely. The implementation
> +	 * must derive an appropriate value and ensure the result is valid.
> +	 */
> +	u32 (*tso_segs)(struct sock *sk, u32 mss_now);

I don't like this interface change.
It introduces churn for no good reason.
At least I don't see why you cannot live with the existing api.

