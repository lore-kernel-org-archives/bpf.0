Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A1246768
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286090; cv=none; b=bdfwGkURG0EDJYKNv5ZMwA4RWp/LOUR3CvsGZydTrGm7AeHMjwBB57mwx7x8t6f4ODdvuWq/b3l8JlEHUFifhggZMQgNqNkkW0fNu4oc3pz92gtC2sG9fT4VBPCdkysJT2klfiDtYWLRvQV+M4TTl8NsUimuhW1la6Y6URRAug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286090; c=relaxed/simple;
	bh=/31A7tCuqB7cEwFGSwV84Eyql6EPNKJEJQ11qwCiYlk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQr8dYB9XfGo7x/AFkxttYijY6GJvBlgMHyBh69QhwXtov0Pncqwp2pGB0qBEVB0hmr5Sc5VbPVZ40eFFdxHOuRVWyVzsRWUokCtFOwtxFHDSjmcZ+50ca6wZNDksDOlya1YIjfkZe7CAp35tq6URSQ7S8dVwkpR4leGBrrh4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a2409jzf; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a2409jzf"
Message-ID: <d7f83d2fade487bfff896069dd095958e59e96dc.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776286084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjKCuhIOQMxzsJUyFJ/TMsFtW2TvEux0w0PnvDrNoig=;
	b=a2409jzfdFGbeMpkKiZ69z0sGt7BlfK5vvJRsB7FRhrH3sFX4yc89wLPxhdlqws40iVChT
	rkE4UgeVZ/JCeieULq1A+NkewncdOJuT8CPKBMAbiMDsSJgjEl509mlTQGmhf923ev3Mtj
	Rf9psW8x5ibxpjtTfxW8XGNSIqzkr9c=
Subject: Re: [PATCH bpf] bpf,tcp: avoid infinite recursion in
 BPF_SOCK_OPS_HDR_OPT_LEN_CB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>, Jiayuan Chen
	 <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao
 Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, Dongliang Mu
 <dzm91@hust.edu.cn>, Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,  Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>,  David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 16 Apr 2026 04:47:42 +0800
In-Reply-To: <2026415181939.1bue.martin.lau@linux.dev>
References: <20260414105702.248310-1-jiayuan.chen@linux.dev>
	 <2026415181939.1bue.martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Wed, 2026-04-15 at 11:55 -0700, Martin KaFai Lau wrote:
> On Tue, Apr 14, 2026 at 06:57:00PM +0800, Jiayuan Chen wrote:
> > A BPF_PROG_TYPE_SOCK_OPS program can set BPF_SOCK_OPS_WRITE_HDR_OPT_CB_=
FLAG
> > to inject custom TCP header options. When the kernel builds a TCP packe=
t,
> > it calls tcp_established_options() to calculate the header size, which
> > invokes bpf_skops_hdr_opt_len() to trigger the BPF_SOCK_OPS_HDR_OPT_LEN=
_CB
> > callback.
> >=20
> > If the BPF program calls bpf_setsockopt(TCP_NODELAY) inside this callba=
ck,
> > __tcp_sock_set_nodelay() will call tcp_push_pending_frames(), which cal=
ls
> > tcp_current_mss(), which calls tcp_established_options() again,
> > re-triggering the same BPF callback. This creates an infinite recursion
> > that exhausts the kernel stack and causes a panic.
> >=20
> > BPF_SOCK_OPS_HDR_OPT_LEN_CB
> > =C2=A0 -> bpf_setsockopt(TCP_NODELAY)
> > 	-> tcp_push_pending_frames()
> > 	=C2=A0 -> tcp_current_mss()
> > 		-> tcp_established_options()
> > 		=C2=A0 -> bpf_skops_hdr_opt_len()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* infinite recursion */
> > 			-> BPF_SOCK_OPS_HDR_OPT_LEN_CB
> >=20
> > A similar reentrancy issue exists for TCP congestion control, which is
> > guarded by tp->bpf_chg_cc_inprogress. Adopt the same approach: introduc=
e
> > tp->bpf_hdr_opt_len_cb_inprogress, set it before invoking the callback =
in
> > bpf_skops_hdr_opt_len(), and check it in sol_tcp_sockopt() to reject
> > bpf_setsockopt(TCP_NODELAY) calls that would trigger
> > tcp_push_pending_frames() and cause the recursion.
> >=20
> > Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> > Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4=
e@std.uestc.edu.cn/
>=20
> Thanks for the report and fixes suggested across different threads.
>=20
> Using has_current_bpf_ctx() to avoid tcp_push_pending_frames() should
> work but it may change the expectation for bpf_setsockopt(TCP_NODELAY).
> e.g. A bpf_tcp_iter does bpf_setsockopt(TCP_NODELAY).
>=20
> Adding another bit in the tcp_sock is not ideal either. I agree with
> Alexei that it is better to reuse the existing bit if we go down this pat=
h.
> We also need to audit more closely if there are cases that two different
> type of bpf progs may call bpf_setsockopt(). e.g.
> bpf_tcp_iter does bpf_setsockopt(TCP_CONGESTION) to switch
> to a bpf_tcp_cc and the new bpf_tcp_cc->init() will also do
> bpf_setsockopt(xxx) which then will be rejected.
>=20
> Another fix could be, the bpf_setsockopt(TCP_NODELAY) is always broken
> for BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB unless
> the bpf prog is doing some maneuver to avoid the recursion. Thus,
> this use case is basically broken as is and I don't see a use case
> for bpf_setsockopt(TCP_NODELAY) when writing header also.
> How about checking the bpf_sock->op, level, and optname in
> bpf_sock_ops_setsockopt() and return -EOPNOTSUPP?

Hi Martin, thanks for the review.

I'm working whit return -EOPNOTSUPP. I've completed whit the code of fix an=
d test, and will send the
patch later.

The fix is:

diff --git a/net/core/filter.c b/net/core/filter.c
index fcfcb72663ca..911ff04bca5a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5833,6 +5833,11 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_=
ops_kern *, bpf_sock,
 	if (!is_locked_tcp_sock_ops(bpf_sock))
 		return -EOPNOTSUPP;
=20
+	if ((bpf_sock->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
+	     bpf_sock->op =3D=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB) &&
+	    IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP && optname =3D=3D TCP=
_NODELAY)
+		return -EOPNOTSUPP;
+
 	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
 }

--=20
Thanks,
KaFai
