Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AC366063
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772777765; cv=none; b=LOPlH1aTD3SwbkoD2beh1kDEU5rgb/0J8UPk7XM+SidlYg5qrc/7+4kFTBsht9nOVVB9jzuOtbaTJtFaTYGxaDMDtEh4isfHdU4S37MDZqbu4I9UOkMQwu+JeXLPF9hwQusKe0fD5KDOPgW9DxbgTzcNJf6sSuD79sbQDE6yPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772777765; c=relaxed/simple;
	bh=hGtRcnWTy/PpFFzdK7d1MHZ61VyPgPTh0NNGxvvrpIw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Ma/0ANk5ipIiwfgzhPnsHZ52dUMDErpev18JsNa1K3LZYIgy8LgH8bw3dqJQRI6SrnfcCUniY1gKKlCX7AIHt2QGvl9dvms40CZq6VBe781y8qobSDHeWrTXVUtRwN+k5vuOnvx/sMbNxvZNvo+k8MuggZqLescFg8ABx5EE8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fAl+knHo; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fAl+knHo"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772777752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqXgGoazXTsI2u6OsAzXa6/DneMpo4x6tpW9FL9NTEU=;
	b=fAl+knHob6eDuMaiQ7kRog26/CIu2cadYe/IsQHXVwIXoDzk9ezDPQrCTZHKwnbPfuJO37
	6QBhpUTUrc0qMzUEf0UtMRuIGZZ/0hxZuFPIo3yhHfZKuvd934sUgz4tQyR6I7vljMn9jh
	ODFAe6dFYYTHQn1gjJxWbG2TQfambIE=
Date: Fri, 06 Mar 2026 06:15:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <c028f0251aeadfad8a76b0c9aa1f46a7e2f81b1a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf v3 3/5] bpf, sockmap: Fix af_unix iter deadlock
To: "Michal Luczaj" <mhal@rbox.co>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Eric Dumazet" <edumazet@google.com>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Willem de
 Bruijn" <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Yonghong Song" <yhs@fb.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Cong Wang" <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <b2218c30-a704-4395-a67e-95c62b75586f@linux.dev>
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-3-2f0c7410c523@rbox.co>
 <b2218c30-a704-4395-a67e-95c62b75586f@linux.dev>
X-Migadu-Flow: FLOW_OUT

March 6, 2026 at 14:04, "Jiayuan Chen" <jiayuan.chen@linux.dev mailto:jia=
yuan.chen@linux.dev?to=3D%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40linux.d=
ev%3E > wrote:


>=20
>=20On 3/6/26 7:30 AM, Michal Luczaj wrote:
>=20

[...]
>=20>  diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >  index 3756a93dc63a..3d2cfb4ecbcd 100644
> >  --- a/net/unix/af_unix.c
> >  +++ b/net/unix/af_unix.c
> >  @@ -3729,15 +3729,14 @@ static int bpf_iter_unix_seq_show(struct seq=
_file *seq, void *v)
> >  struct bpf_prog *prog;
> >  struct sock *sk =3D v;
> >  uid_t uid;
> >  - bool slow;
> >  int ret;
> >  > if (v =3D=3D SEQ_START_TOKEN)
> >  return 0;
> >  > - slow =3D lock_sock_fast(sk);
> >  + lock_sock(sk);
> >  > - if (unlikely(sk_unhashed(sk))) {
> >  + if (unlikely(sock_flag(sk, SOCK_DEAD))) {
> >  ret =3D SEQ_SKIP;
> >  goto unlock;
> >  }
> >=20
>=20Switching to lock_sock() fixes the deadlock, but it does not provide =
mutual
> exclusion with unix_release_sock(), which uses unix_state_lock() exclus=
ively
> and does not touch lock_sock() at all. So a dying socket can still reac=
h the
> BPF prog concurrently with unix_release_sock() running on another CPU.
>=20
>=20Both SOCK_DEAD and the clearing of unix_peer(sk) happen under
> unix_state_lock() in unix_release_sock(). Without taking unix_state_loc=
k()
> before the SOCK_DEAD check, there is a window:
>=20
>=20iter unix_release_sock()
> ---=C2=A0 lock_sock(sk)
> SOCK_DEAD =3D=3D 0(check passes)
>  =C2=A0=C2=A0unix_state_lock(sk)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0unix_peer(sk) =3D NULL
>  =C2=A0=C2=A0sock_set_flag(sk, SOCK_DEAD)
>  =C2=A0=C2=A0unix_state_unlock(sk)
> BPF prog runs
> =E2=86=92 accesses unix_peer(sk) =3D=3D NULL =E2=86=92 crash


Sorry for malformed message.
Here is correct:

iter                              unix_release_sock()
---  lock_sock(sk)
SOCK_DEAD =3D=3D 0  (check passes)
                                  unix_state_lock(sk)
                                  unix_peer(sk) =3D NULL
                                  sock_set_flag(sk, SOCK_DEAD)
                                  unix_state_unlock(sk)
BPF prog runs
=E2=86=92 accesses unix_peer(sk) =3D=3D NULL =E2=86=92 crash
