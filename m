Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28E437857
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783444779; cv=none; b=HXh/94N98PmhHUL8WznYZaH9lWdDE9fGuibqVY4vgV46EzcDPv/Rjk1htAIJCTzbrf2u34bEpNEPxckdPAmlBzBzlEDsZKiMkAizE7t9PgkKshcL9LxZ95oMSKda8PrVoZmxk4vwVu5sH6PEfkjZ++3z5o2T6MJG0TaStptbj80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783444779; c=relaxed/simple;
	bh=uPrZr0iPVAccotWTb0olrTCBCteVhIpn+zqUu39DbfU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XmK33bOC6lX3lfkmzG5BNIzm3SbHzUqnBDgGcUXD2gpxfATdtLCKrDxLuZY/0XGI2HogOXVuVMPjzZcyD90aq8PV82p5XFRREJL1P5CMyzH3U3HstsvfQ5M8tW1OeSb0bs6z2DjvJ9bdzjLdyklZDOeZ+3fJ+o4fHj7VESpdkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uGrBTLTG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="uGrBTLTG"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84347ad88edso5929207b3a.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783444776; x=1784049576; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jfN5epMTrTiNcBZABNNCrA6guMm8dgTEPl6doYRQ6BU=;
        b=uGrBTLTGhrBeqno2q/X6/XjS/TRQN+AFUkqekixE7qH5iUVv0Ct/LxTIE2xb7w6B+O
         5B76dZWbMdU/S9Cm9aZeUOxOPxIN3bGcAKbDBdqH6HrOeok8UaySq5eK8Lc4XtwqXqAk
         wowZ9azz6tPQQ+v25oBM/P3dJL23wtwWM5pjUidqp2wF8y7B1+Y7PLJJ4xKTtA6wNUFt
         6bMPvoWq03kimJz3fSXiC9UUWJJgeXICVTkqc5jCrCuJDmVrQ4ga584EEtIe8QPZYrVV
         iL4BAegQlunlDkEdl7kNEBTAzPm+EXR1oAV5CiAZb+Xy5pg94WDJwXlAYRwX0xe2WUXc
         FGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783444776; x=1784049576;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfN5epMTrTiNcBZABNNCrA6guMm8dgTEPl6doYRQ6BU=;
        b=O65A+tYbTpVSh3wU3HR9ep8MM0g5eLHVFhrjJ2LkpB1eggzvSe7WDMKewkFvWPkMGr
         N+NX6wDZ0jaxlXqjWPM2KKs1YXXbCsJBwE+CcgkfKddVqVRjPexufndUMLIayJqZEU4s
         Ys9eb+GNG0rv+rRtPLb0PLJ1ey2tRYv48dakMgwIHganeg+8LFb1WIBuc90ixnh5xfZl
         SGe3dPssWPMT00VHAs8ayrcCeXJZ8hIXWGYEG9tM+wqcFcKm1el/PCHLBMJc/GuCv1B+
         /Yzj4H5apm82GgnyrsWi+LKonbZJQugr+DxIzTY+/Nwc/rAEA6haHvD4MS1b1JRL7Bmu
         vg/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq7LP8eaMQ0CHLn5UueefEo7O7hM8pJXH1fmY5JNO/aJ88v1edZQvx6zUztI+wQDunWy4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfkGC459A3CDM4+ANsQK71gsQsoCUUhcjnecETpkxjxSVgGpN
	hTx7vGpndP9otqK7zFxSwUw629nVW3t2BxYPwYDdipK25RkjEQUzpiBn2hCUURjsdjo=
X-Gm-Gg: AfdE7ckQDaEIh1kC7x4Tx1HXslTKKB+OXli452bDw7fmh31l1EOQ10/bniH94qxmgEc
	IfIOaBitKdG9w8p4RcNhyTcVEv/zJ0LSpQeVJtJEvMGu+c9EOfkgY1fE5kRDt0tdLXW/qkEhYcu
	3R7c1317IRzmo6iHgtY0UA63MaFWDjLinQizYjI3y4JCotCXttW3QZeyjPYQ2Bs9Vxbeu9wOxLO
	cyO7cTTPzSY7mvQHc1RxbTqJidDp4zO1B8N7WBI47Si9yIZJshe5KIqsAiwiiX8F1fG9+9a8bxN
	BOsKrjq5C8Y72H2MeXJGK/EUhzME0Zfk4AlHigXzhcjM5wyxSNudS+I1l40BZheaLd3mHpOZ1TN
	aXXnwZO/uI5BR7nB7aP3y9t+METxHemRWQ7AwoCHKbj7LBV4UMuQqdrF434PUWvxJNaCK23ICSv
	gL9TKXAHOuGSbpY/UM3xhjIRcEckKjb59HlKnmwZ/URw==
X-Received: by 2002:a05:6a00:4f93:b0:848:2f77:e2d7 with SMTP id d2e1a72fcca58-8482f77f29dmr3429036b3a.64.1783444775844;
        Tue, 07 Jul 2026 10:19:35 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afdb7534sm1321918a12.12.2026.07.07.10.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 10:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 13:19:34 -0400
Message-Id: <DJSIEQSX3AFI.341HNU79LHFEF@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <mattia.meleleo@coralogix.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
In-Reply-To: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>

On Tue Jul 7, 2026 at 12:15 PM EDT, Mattia Meleleo via B4 Relay wrote:
> From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
> tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
> counts bytes in ingress_msg. Without a stream/skb verdict program
> nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
> returns 0 even though read() returns data.
>
> Add tcp_inq() to the reported value when the psock has no verdict
> program. The two queues are disjoint, so bytes redirected into
> ingress_msg from other sockets stay correctly accounted through
> msg_tot_len.
>
> Add a selftest covering FIONREAD without a verdict program.
>
> Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
> Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

I don't think the Sashiko READ_ONCE() recommendation is that important,
we're just checking for the pointers' existence and I don't see how the
reads can be moved/optimized out/merged in a way that breaks this code.

> ---
>  net/ipv4/tcp_bpf.c                                 | 16 ++++++++-
>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 ++++++++++++++++=
++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f3..a001b1fff 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> =20
>  static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>  {
> +	struct sk_psock *psock;
>  	bool slow;
> =20
>  	if (cmd !=3D SIOCINQ)
> @@ -344,7 +345,20 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, i=
nt *karg)
>  		return -EINVAL;
> =20
>  	slow =3D lock_sock_fast(sk);
> -	*karg =3D sk_psock_msg_inq(sk);
> +	psock =3D sk_psock_get(sk);
> +	if (unlikely(!psock)) {
> +		unlock_sock_fast(sk, slow);
> +		return tcp_ioctl(sk, cmd, karg);
> +	}
> +	*karg =3D sk_psock_get_msg_len_nolock(psock);
> +	/* Without a verdict program, ingress data is never diverted to
> +	 * ingress_msg: it stays in sk_receive_queue and is read through
> +	 * the fallback to tcp_recvmsg(), so account for it like
> +	 * tcp_ioctl() does.
> +	 */
> +	if (!psock->progs.stream_verdict && !psock->progs.skb_verdict)
> +		*karg +=3D tcp_inq(sk);
> +	sk_psock_put(sk, psock);
>  	unlock_sock_fast(sk, slow);
> =20
>  	return 0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711..f0f368201 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int sotype=
)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
> =20
> +/* A socket in a sockmap without a verdict program keeps its ingress dat=
a
> + * in sk_receive_queue: FIONREAD must account for it.
> + */
> +static void test_sockmap_no_verdict_fionread(void)
> +{
> +	int err, map, zero =3D 0, sent, avail;
> +	int c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
> +	struct test_sockmap_pass_prog *skel;
> +	char buf[256] =3D "0123456789";
> +
> +	skel =3D test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	map =3D bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err =3D create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
> +	if (!ASSERT_OK(err, "create_socket_pairs()"))
> +		goto out;
> +
> +	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
> +		goto out_close;
> +
> +	sent =3D xsend(p1, &buf, sizeof(buf), 0);
> +	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
> +	avail =3D wait_for_fionread(c1, sizeof(buf), IO_TIMEOUT_SEC);
> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD)");
> +
> +out_close:
> +	close(c0);
> +	close(p0);
> +	close(c1);
> +	close(p1);
> +out:
> +	test_sockmap_pass_prog__destroy(skel);
> +}
> +
>  void test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))
> @@ -1415,6 +1452,8 @@ void test_sockmap_basic(void)
>  		test_sockmap_skb_verdict_shutdown();
>  	if (test__start_subtest("sockmap skb_verdict fionread"))
>  		test_sockmap_skb_verdict_fionread(true);
> +	if (test__start_subtest("sockmap no_verdict fionread"))
> +		test_sockmap_no_verdict_fionread();
>  	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
>  		test_sockmap_skb_verdict_fionread(false);
>  	if (test__start_subtest("sockmap skb_verdict change tail"))
>
> ---
> base-commit: d2c9a99135da931377240942d44f3dea104cedb8
> change-id: 20260707-fionread-no-verdict-a4f8697ac9f9
>
> Best regards,
> -- =20
> Mattia Meleleo <mattia.meleleo@coralogix.com>

