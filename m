Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64311357CF9
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158323; cv=pass; b=s4oAZ28evbh+Tz4mArna2sTlr/CQ8GAArISd8Yyhfe18Z6/kwOX1x7xP0xuw8+LXwdHewNZG/J9iiIC4L1RCoTPtlJtE50xGX44OShsd2TqSliPdbK43FII3Vf2kK7ZwTZWTfCMvnULuGyI3nNF8aUL6KrsbXNE0NUB6Dwwn+uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158323; c=relaxed/simple;
	bh=6uMDhe3s+8phVycZ4mWnM1+NrBk8YNuTjia1m/TqtqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ab+ciWxFmv0NRGpImhtqMskoh3Kg6TpU5smiKtN2/IycYEUYwhmQOEOFVU1fgVc+bIKhLClxSTsy20cV2gdYcSaf6Q5z7BKthXqCMpJ6Z/4sr5lTyS3UI7UzodTeSCuo3DNA7cUYxiOnPzydieZKlRZ8c6XwGEOdyw+3oQHmZGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbOtbx34; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbOtbx34"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13809ed8fbeso2474264c88.0
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 23:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781158321; cv=none;
        d=google.com; s=arc-20240605;
        b=dMriQ0S+q5MkFBBZVgXPlJHzbTj0XB6KuYkfW3EDI+s5S0sVWbgtdN5PQDN5/WTyLk
         disPUKlHq24X3mE+2wXBi72fri1+keQ4EKgQ3yv/ZCcdvV5KQ1sGhLz+p/nfSDR/Dcwh
         hzb3Io4a+zVpCvesLBtP/UT1GF00TD/Y0AVxKAVtkdPeA3+TU6od44r3C1TW6ONVfmvs
         4xwwXr1Q1b8+EmWVYOPNPseeFlcOuPYD90XbNApwjNm4depqy9Mm6M5auxD7Sr4kfIVv
         RMa7zYTPuz0lWA3tI9DsJs7Bgi3ucAWxnppq20kMi0IDujxVnHkKtwoRvnIvUfkvHSxY
         GPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DVuHM7/3dS9EbFkPJRKrHdVcq08dk1S52xv7iZVtqOg=;
        fh=5oTRDCFYcKeBe/ZyfNVLZTFVv9askqWsjok+DT2cTok=;
        b=WABL2K8Vyt86sIoT4IRlJ8ysqq8xTYU4F7nHOvw/lMeOZC4EtL5DYJ3re4fGRSqEz8
         vkINuWHiFBbIT4HpTsaRsnMUvGlK3saL8UcWrq/8hcjkZ4Ku4BopgHWZl7dgYn7D44RX
         T/5XLz0iwxBcEdGZrZTbBNa/NSsqheKREtUy/AG2k2bcB99EsNaaOZBsqvqjoeXR5XSQ
         U0poE44nIHx2tNFKPnEv+hWoyDcaeZKqVmy63KeIBu7hocEIRktpVsyFGi64n8udssEy
         i9kv3/dKPb1/pXF7SrV9OkLWmP4DDbSMN4UyrgSGE6Y62xS7nLgk0GQappvcj3r9iQzR
         LUfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781158321; x=1781763121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVuHM7/3dS9EbFkPJRKrHdVcq08dk1S52xv7iZVtqOg=;
        b=XbOtbx34nerVx6BCJO1kueaccu76gPo7YuwUXQmtES/8OwWzGxKbMJKi89SlR6xHpF
         Z4kEKfn2B49LT1Ti6bOSksmLW5PQi65JTHxhcBvNAoveeAPHtdZCWQ6aYFR5qUWm8XY1
         I2BiC7kn4Tc1Ma9hi7Bpft032f+TtEgHNISuwd2uqxwbGrOWZ37DgLo+gEbm3ovTbena
         HA88fmQ6P9bPjGkcewlLrcNHZvhRrknLly6Z2JmbzTemDL+3m4QKZYjpk4LWXQ/q6R0W
         ttx+jw4Iza0WQ9MppBWUQAS4Sfr5S0q0EO8PLozN9AzI7Fs5xuHlhardUZ1CuwTGPGw4
         6UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781158321; x=1781763121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DVuHM7/3dS9EbFkPJRKrHdVcq08dk1S52xv7iZVtqOg=;
        b=n5Hkaebao+yna1O7jZSVzjcAgq7AionPQWJ6JtaYnqcshaJwm1Mr1c9DZghCdDvvMN
         lw8AV0P5H8CyqfmaFlvAsaMU3EV6Wj5RrLQ+A27qOz4z8KOhrC99oV/QgBGOs1yGjceW
         BEI01g+DHJwTSUgSwRdpLjjCB9A3HlJlHRJiGImM39dDD7vidlhwdLWy1kKStPacEZJv
         7PX2OlPJ+dxcdWQxRGMG/be+NPkDIaohIBO3kPDVJnRz9gobJrCva3zZ7netQdKGtq82
         NjKNNe4WV8Z7LvATimZFg1vJul3vFmKGi+n1Sw7kmqO152ADwzjsQeYhpuu4GhJphUpz
         eQkA==
X-Forwarded-Encrypted: i=1; AFNElJ9gX1EmaQF3dyO9SoYQgNz2i68MlMbdUw6MASXeOvQ2Kxb6AmcVelGAG4nUIY74eUc6dRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GXlYk2qdEffTxIL/tAFXumTFBmb3IGWMzjqoDKQbmdB31UAG
	oclgSs3+svvkwJDzeAQBKjvrHEo2xqm+9+PQ2s/RTZyw25CNTbEdG3PxwD2/sjoDjYk3D4FS7tN
	tPPCM726qXXzafm0zBaKwyAmiMXbhArU2woKOofS8
X-Gm-Gg: Acq92OE4Yu1SGHa/OSTeZJsLDWBTX3Bhk0kKaLwxeenzABNS2zdePPfJBAIGN7xWwFC
	BhJYfrcwW7sDDBOS44y7K1EPc9u6dURMf6vq8HvwHx1o2e0/NJ+EaqKiz4l+ZB27C9yHiGicLf1
	rDxlSfrdPHMJzYg1F1qSiJ5Vw1OguOnIVWrS3KmLn6bf78/kS8UNt6DH18MohZTVfQp6YQZvAPP
	/cAiXd/OJ3/XhIudgOS8C0VsDIIc3SB/KCiUrGE5M/GZJx7Eb/tmU/JrN5JcxPFneZQyrH7VfGg
	M5z5xGed332jpo49ZVLNm5cv2L/gfF3h9n81us18OenZjBXzqVz+Lcuyc+CEoebIV+YRNk4FzAF
	Zy7Iq/VwhkZUKfgqROXsc7QvM6NOxlulmdHMHiFHDML/ByQ/SS6l1MKkTp3fwOkQ=
X-Received: by 2002:a05:7022:1e05:b0:12d:b7e5:a67b with SMTP id
 a92af1059eb24-138421a9261mr1143508c88.14.1781158320538; Wed, 10 Jun 2026
 23:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610155946.894878-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260610155946.894878-1-rhkrqnwk98@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Jun 2026 23:11:49 -0700
X-Gm-Features: AVVi8CcJX3xqxzypzeI_Nz6IpNCvi1NwKNZ6i4ylbn2um6RtpL6pV7zktRtNHGo
Message-ID: <CAAVpQUC-ibCY8-xSc4RL5M9Zvbm6owpethgBK3-W8GmqbPVTTQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: clear sock_ops cb flags before force-closing
 a child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:00=E2=80=AFAM Sechang Lim <rhkrqnwk98@gmail.com> =
wrote:
>
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state(=
)
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me()=
:
>
>   WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>   RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>   Call Trace:
>    <IRQ>
>    tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>    tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>    tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>    tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>    </IRQ>
>
> The child is freed before it is ever established, so it should run no
> sock_ops callback. Clear its cb flags in inet_csk_prepare_forced_close(),
> which covers all forced-close callers.
>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v2:
>  - move the clearing into inet_csk_prepare_forced_close() (Jiayuan Chen,
>    Simon Horman)
>
> v1:
>  - https://lore.kernel.org/all/20260605094954.1374489-1-rhkrqnwk98@gmail.=
com/
>
>  include/net/tcp.h               | 7 +++++++
>  net/ipv4/inet_connection_sock.c | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 98848db62894..97eac5fa341c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *s=
k, int op, u32 arg1, u32 arg2,
>         return tcp_call_bpf(sk, op, 3, args);
>  }
>
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> +{
> +       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D 0;
> +}
> +
>  #else
>  static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *=
args)
>  {
> @@ -2959,6 +2964,8 @@ static inline int tcp_call_bpf_3arg(struct sock *sk=
, int op, u32 arg1, u32 arg2,
>         return -EPERM;
>  }
>
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk) {}

nit: I think prefered style is

static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
{
}

> +
>  #endif
>
>  static inline u32 tcp_timeout_init(struct sock *sk)
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index dbcd37dfdc15..209f73a61a1d 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1290,6 +1290,7 @@ void inet_csk_prepare_forced_close(struct sock *sk)
>         __releases(&sk->sk_lock.slock)
>  {
>         /* sk_clone_lock locked the socket and set refcnt to 2 */
> +       tcp_clear_sock_ops_cb_flags(sk);

mptcp's ->syn_recv_sock() will trigger the hook in the failure path.

inet_csk_prepare_for_destroy_sock() is a better fit.  We don't
care if the child socket is locked in this path.


>         bh_unlock_sock(sk);
>         sock_put(sk);
>         inet_csk_prepare_for_destroy_sock(sk);
> --
> 2.43.0
>
