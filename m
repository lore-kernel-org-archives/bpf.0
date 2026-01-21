Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854E3A7F57
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000149; cv=none; b=lJVx2eWupEunf9HTP9BKERZZFOowNmpRpvX1EfDGx5Hjpy4Mni9gUu2QEFrc7kOnG/BswgVQ8LIgsxsfVKyl2owzI50WFFi+IzF0iygSOur6+O0sYBGvlh/hh5hDPLHyjckH0j7f3mw4UINXG1pWCNEl16jRYgyKrucrT2PdEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000149; c=relaxed/simple;
	bh=DeR56DNZAp+6G89jGfn1KS0/3ZG6njmmnnhqm525Hr8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ZcpIg4IVpVDAvaC6n6BM581nmDqo1tlI32FZk7ref+ukYmb617Z5eu6QhAHbwqsGFCQb1eQ09MLmrQxeI2WKPoq+pUhkbnML1CLNNsJWv/GrMcBo/Dgf525UjazCH8Rx3Yvw4Y66Af8wqxHNJefGg1DHiyMmuDWcr5yiubL1hL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sQfdTUwP; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sQfdTUwP"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769000144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0umGIKsfAe/RKlSYFGWoP6DNJrT3BOI3/bIn0vT00=;
	b=sQfdTUwPdkRIRNBzteK/P0OMTrQn1r7KWAH0Ifhjlago76TOiOPZlD9qIZu+xRSgSSZjkD
	ssathU8ykXUoRcjv0s2NNSxbXh4VBoH0gLFpWnabGroqQHqpUgRblGvYdaqWEOOL0iYZQN
	hK5IkDOd65jLlZxETdt9drPKYU6GKJI=
Date: Wed, 21 Jan 2026 12:55:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <60a0c463ef6dbe38d836c773c5256706c163311c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v7 2/3] bpf, sockmap: Fix FIONREAD for sockmap
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, "John Fastabend" <john.fastabend@gmail.com>, "David 
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "David
 Ahern" <dsahern@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel  Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP  Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao  Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Michal Luczaj" <mhal@rbox.co>, "Cong Wang"
 <cong.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <871pjjux2u.fsf@cloudflare.com>
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
 <20260113025121.197535-3-jiayuan.chen@linux.dev>
 <87a4y8uy67.fsf@cloudflare.com> <871pjjux2u.fsf@cloudflare.com>
X-Migadu-Flow: FLOW_OUT

January 21, 2026 at 17:36, "Jakub Sitnicki" <jakub@cloudflare.com mailto:=
jakub@cloudflare.com?to=3D%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare.=
com%3E > wrote:


>=20
>=20On Tue, Jan 20, 2026 at 04:00 PM +01, Jakub Sitnicki wrote:
>=20
>=20>=20
>=20> On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> >=20
>=20[...]
>=20
>=20>=20
>=20> >=20
>=20> > diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> > >  index 0735d820e413..91233e37cd97 100644
> > >  --- a/net/ipv4/udp_bpf.c
> > >  +++ b/net/ipv4/udp_bpf.c
> > >  @@ -5,6 +5,7 @@
> > >  #include <net/sock.h>
> > >  #include <net/udp.h>
> > >  #include <net/inet_common.h>
> > >  +#include <asm/ioctls.h>
> > >=20=20
>=20> >  #include "udp_impl.h"
> > >=20=20
>=20> >  @@ -111,12 +112,26 @@ enum {
> > >  static DEFINE_SPINLOCK(udpv6_prot_lock);
> > >  static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
> > >=20=20
>=20> >  +static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> > >  +{
> > >  + if (cmd !=3D SIOCINQ)
> > >  + return udp_ioctl(sk, cmd, karg);
> > >  +
> > >  + /* Since we don't hold a lock, sk_receive_queue may contain data=
.
> > >  + * BPF might only be processing this data at the moment. We only
> > >  + * care about the data in the ingress_msg here.
> > >  + */
> > >=20
>=20>  I think we should strive for a design where FIONREAD does not go d=
own
> >  after you add your socket to sockmap, if there was no recvmsg call i=
n
> >  between. To show what I mean, I added this test that's currently fai=
ling
> >  for udp:
> >=20
>=20>  ---8<---
> >  diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c =
b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> >  index 1f1289f5a8c2..123c96fcaef0 100644
> >  --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> >  +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> >  @@ -1229,6 +1229,66 @@ static void test_sockmap_copied_seq(bool strp=
)
> >  test_sockmap_pass_prog__destroy(skel);
> >  }
> >=20=20
>=20>  +/* Test FIONREAD when data exists in sk_receive_queue before sock=
map insertion */
> >  +static void test_sockmap_fionread_pre_insert(int sotype)
> >  +{
> >  + int map, err, sent, recvd, zero =3D 0, avail =3D 0;
> >  + struct test_sockmap_pass_prog *skel =3D NULL;
> >  + int c =3D -1, p =3D -1;
> >  + char buf[10] =3D "0123456789", rcv[11];
> >  + struct bpf_program *prog;
> >  +
> >  + skel =3D test_sockmap_pass_prog__open_and_load();
> >  + if (!ASSERT_OK_PTR(skel, "open_and_load"))
> >  + return;
> >  +
> >  + prog =3D skel->progs.prog_skb_verdict;
> >  + map =3D bpf_map__fd(skel->maps.sock_map_rx);
> >  +
> >  + err =3D bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STR=
EAM_VERDICT, 0);
> >  + if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
> >  + goto end;
> >  +
> >  + err =3D create_pair(AF_INET, sotype, &c, &p);
> >  + if (!ASSERT_OK(err, "create_pair"))
> >  + goto end;
> >  +
> >  + /* Step 1: Send data BEFORE sockmap insertion - lands in sk_receiv=
e_queue */
> >  + sent =3D xsend(p, buf, sizeof(buf), 0);
> >  + if (!ASSERT_EQ(sent, sizeof(buf), "xsend pre-insert"))
> >  + goto end;
> >  +
> >  + /* Step 2: Verify FIONREAD reports data in sk_receive_queue */
> >  + err =3D poll_read(c, IO_TIMEOUT_SEC);
> >  + if (!ASSERT_OK(err, "poll_read pre-insert"))
> >  + goto end;
> >  + err =3D ioctl(c, FIONREAD, &avail);
> >  + ASSERT_OK(err, "ioctl(FIONREAD) pre-insert error");
> >  + ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) pre-insert");
> >  +
> >  + /* Step 3: Insert socket into sockmap */
> >  + err =3D bpf_map_update_elem(map, &zero, &c, BPF_ANY);
> >  + if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
> >  + goto end;
> >  +
> >  + /* Step 4: FIONREAD should still report the data in sk_receive_que=
ue */
> >  + err =3D ioctl(c, FIONREAD, &avail);
> >  + ASSERT_OK(err, "ioctl(FIONREAD) post-insert error");
> >  + ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) post-insert");
> >  +
> >  + /* Verify we can still read the data */
> >  + recvd =3D recv_timeout(c, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEO=
UT_SEC);
> >  + ASSERT_EQ(recvd, sizeof(buf), "recv post-insert");
> >  + ASSERT_OK(memcmp(buf, rcv, recvd), "data mismatch");
> >  +
> >  +end:
> >  + if (c >=3D 0)
> >  + close(c);
> >  + if (p >=3D 0)
> >  + close(p);
> >  + test_sockmap_pass_prog__destroy(skel);
> >  +}
> >  +
> >  /* it is used to send data to via native stack and BPF redirecting *=
/
> >  static void test_sockmap_multi_channels(int sotype)
> >  {
> >  @@ -1373,4 +1433,8 @@ void test_sockmap_basic(void)
> >  test_sockmap_multi_channels(SOCK_STREAM);
> >  if (test__start_subtest("sockmap udp multi channels"))
> >  test_sockmap_multi_channels(SOCK_DGRAM);
> >  + if (test__start_subtest("sockmap tcp fionread pre-insert"))
> >  + test_sockmap_fionread_pre_insert(SOCK_STREAM);
> >  + if (test__start_subtest("sockmap udp fionread pre-insert"))
> >  + test_sockmap_fionread_pre_insert(SOCK_DGRAM);
> >  }
> >  --->8---
> >=20
>=20> >=20
>=20> > + *karg =3D sk_msg_first_len(sk);
> > >  + return 0;
> > >  +}
> > >  +
> > >
> >=20
>=20I've been thinking about this some more and came to the conclusion th=
at
> this udp_bpf_ioctl implementation is actually what we want, while
> tcp_bpf_ioctl *should not* be checking if the sk_receive_queue is
> non-empty.
>=20
>=20Why? Because the verdict prog might redirect or drop the skbs from
> sk_receive_queue once it actually runs. The messages might never appear
> on the msg_ingress queue.
>=20
>=20What I think we should be doing, in the end, is kicking the
> sk_receive_queue processing on bpf_map_update_elem, if there's data
> ready.
>=20
>=20The API semantics I'm proposing is:
>=20
>=201. ioctl(FIONREAD) -> reports N bytes
> 2. bpf_map_update_elem(sk) -> socket inserted into sockmap
> 3. poll() for POLLIN -> wait for socket to be ready to read
> 5. ioctl(FIONREAD) -> report N bytes if verdict prog didn't
>  redirect or drop it
>=20
>=20We don't have to add the the queue kick on map update in this series.
>=20
>=20If you decide to leave it for later, can I ask that you open an issue=
 at
> our GH project [1]?
>=20
>=20I don't want it to fall through the cracks. And I sometimes have peop=
le
> asking what they could help with in sockmap.
>=20
>=20Thanks,
> -jkbs
>=20
>=20[1] https://github.com/sockmap-project/sockmap-project/issues
>


Hi Jakub,

Thanks for taking the time to think through this carefully. I agree with =
your
analysis - reporting sk_receive_queue length is misleading since the verd=
ict
prog might redirect or drop those skbs.

There's no rush to merge this patch.

Since the kick queue on bpf_map_update_elem addresses a closely related i=
ssue,
I think it makes sense to include it in this patchset for easier tracking=
 rather
than splitting it out.

I'll spend more time looking into this and come back with an updated vers=
ion.

Thanks,
Jiayuan
