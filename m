Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84E383C83
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384540; cv=none; b=D+jBT6Su3vE77nT1hwrqauYAkr9m6ogQZrkElwe3ij5W4HgmyL0Qx0SVTia3c4tes/FiWALm4Xm5jIQkK8p5S+GpyEem2LW2qXM4SoPVLnOMpgOtT49lY4b5Fo3Fubs0VrvH0WUTbKX/3RXkgbKE3iCPKHNN6J2VFO3Di6ES7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384540; c=relaxed/simple;
	bh=Ps2PqFYe0uSu8kMn+2yUb7YCUrEj5lUz/Jd3hDbXnNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rw+rdZRTeRzkFCCgBV23Q0TO73fIz5lCX1h2jEgf6ZrexU0kOOKBgEuYvvyWEh5ONm+C7JcNwxk8x1i2gsa14R66E/3LPTAE2mnBCFviIVfK4+0ynX1fdYhzhLiSSMgDdCgkj1K1k8NVPl5Ej6cJ/7aQLhAcJlT+51ENUFURGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Wfwq5q4q; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Wfwq5q4q"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c03a466c96aso27787866b.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 03:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782384537; x=1782989337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhnTEE3eR7tyCRGO7cEDK/PBoNBoXGQu9h1tWf3iFxw=;
        b=Wfwq5q4qdayb+YXK0COgNQ2Ux8sKEDn7v+K7FL2AbxFLROD9uVGJ0IrJIT0ZZZXExW
         jdUSDZbz+aFUR+Eycmh3EZ5WwGMIOFf7WsfURBpfHixqwVqIFvaKryxh3CBCkTaZzIl6
         KH+VObJOTcwPTRIAdogLRy3FnC3JXudHFYHh/g3xjZ3jOYj8BRdD+6PIkJb1+EobDmfP
         2Zzu0zfy9C2pJ1wnYBU0k5ZBbQ1QsRiESjXFEO9SJ77+nhMHOv50zuHEkhQQ9V6XbUaQ
         InCv6e0HSqaZd/RWI93UQK/m33dn8ns+34dxE3StIGhktRQvlbN20v/8vfrUtjXd27G+
         PVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782384537; x=1782989337;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhnTEE3eR7tyCRGO7cEDK/PBoNBoXGQu9h1tWf3iFxw=;
        b=GpearTOEmZ4O0c4l/dakwQ2WC9tUY7mTUUi8+sIjPGURzGBql8GPzLv8qLU6s3veOg
         tZg/1EtO70P9NQT4vUrzuSDiroEJKYLjsP4xzTu195nc/fwmhplaRMh11uc6mqF+iEXu
         HB0cmiKb7kd5rs2Oby7I8Q2ptcfdom5MjC+v+V7tQM5gcZ1prKB5T+UFffW0iIVXXtFK
         wDzoTgMSXag1CTw+bEm35nxr8AQ8YMChlRrazg7pxjL7Ekvz7H+9nWuuuYQHbNpzPHwU
         b5zmXSLnTW8OeLZZieY/z4dtuXfb2pMi5xb6M9GZByBRWaoyeQNLJ2nhU9Yow6xvYXcB
         BPdg==
X-Forwarded-Encrypted: i=1; AHgh+RpZ6fUZ9WbSRohjh/2sYEYWH4Z2TSyrdtBzmwbYNFFUgAUQBRYVy2sUEXTXFGNc9ijlcug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF5lpyCwIVuand5EC9T8eLfxDXYA20Za7rUQhHF0ZeyOe+TaOw
	bh1ePZRJnJ+MfO22abE0SFg5MRUy7xdStw4/DJUTvPcifce4o4oNCsObqcBTdfBbT8E=
X-Gm-Gg: AfdE7cnzUrbFXLpsjoS1VkgH4Dxz5y/8pyL0rsEhCmtcSIniZyIaYRJ7ytuf5MZ1xwU
	zdvJ/BdcU76gKi1dut+WtLrwzBL9ug1kX4TELp2JZziq7eLVEwDyw6n0orYT1TzZHmfTJJ6CTiS
	N+cKcWH/tcDxZQ9X7VpOsya/kdBctFiDy4yE64kAF85jHyy+tCbcw2WzTscoSJIIzRpreoWe3Jm
	P6cuUnRR1cLxwNfLXbmK3eYbRuMZC+JXFopZUogETfMmbZiZHM06rM0c/OqD1ooE1PkohS7sn9g
	0xGSH/CSTEAuMMeH6QPTSmVNWR5cWAnWEkrGthGImQEa1ICHPvl5Ex7KNqPy67E+MybAlQnPI8h
	yaSfNNqsdpVYywGmh90SKS/yb19pqisQeIkSMZoz66K1Hg5xP2ZSvSdmcGTHiBw1bj5TgvT4moO
	6NTqckOKYcsmavxDA=
X-Received: by 2002:a17:907:dab:b0:baa:1d9:66ff with SMTP id a640c23a62f3a-c1205e1fe84mr141629266b.20.1782384536940;
        Thu, 25 Jun 2026 03:48:56 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbba862asm158442066b.9.2026.06.25.03.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:48:56 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Michal Luczaj <mhal@rbox.co>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  John Fastabend
 <john.fastabend@gmail.com>,  Jiayuan Chen <jiayuan.chen@linux.dev>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Cong Wang <cong.wang@bytedance.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Shuah Khan
 <shuah@kernel.org>,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
In-Reply-To: <CAAVpQUAy=EVZcZRmXJPr=neJh7Q+UbYML5L4+nBynVrDPidUkw@mail.gmail.com>
	(Kuniyuki Iwashima's message of "Wed, 24 Jun 2026 14:39:35 -0700")
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
	<20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
	<87wlvoxdq1.fsf@cloudflare.com>
	<willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
	<dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
	<CAAVpQUBHMrSiWqn0Zo_D7sUCLFdkKggduoijRdFtHx5CPiSpsg@mail.gmail.com>
	<CAAVpQUAy=EVZcZRmXJPr=neJh7Q+UbYML5L4+nBynVrDPidUkw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 25 Jun 2026 12:48:55 +0200
Message-ID: <87o6gyyjxk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 02:39 PM -07, Kuniyuki Iwashima wrote:
> On Wed, Jun 24, 2026 at 2:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
>>
>> On Wed, Jun 24, 2026 at 2:26=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wro=
te:
>> >
>> > On 6/24/26 22:01, Willem de Bruijn wrote:
>> > > Jakub Sitnicki wrote:
>> > >> On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
>> > >>> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
>> > >>> sk_is_refcounted(unbound) =3D true, while sk_is_refcounted(bound) =
=3D false.
>> > >>>
>> > >>> Because sockmap accepts unbound UDP sockets, a BPF program can inc=
rement a
>> > >>> socket's refcount via lookup. If the socket is subsequently bound,=
 the
>> > >>> transition from unbound to bound causes bpf_sk_release() to skip t=
he
>> > >>> decrement of the refcount, causing a memory leak.
>> > >>>
>> > >>> unreferenced object 0xffff88810bc2eb40 (size 1984):
>> > >>>   comm "test_progs", pid 2451, jiffies 4295320596
>> > >>>   hex dump (first 32 bytes):
>> > >>>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  .............=
...
>> > >>>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@.........=
...
>> > >>>   backtrace (crc bdee079d):
>> > >>>     kmem_cache_alloc_noprof+0x557/0x660
>> > >>>     sk_prot_alloc+0x69/0x240
>> > >>>     sk_alloc+0x30/0x460
>> > >>>     inet_create+0x2ce/0xf80
>> > >>>     __sock_create+0x25b/0x5c0
>> > >>>     __sys_socket+0x119/0x1d0
>> > >>>     __x64_sys_socket+0x72/0xd0
>> > >>>     do_syscall_64+0xa1/0x5f0
>> > >>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> > >>>
>> > >>> Maintain balanced refcounts across sk lookup/release: (re-)set
>> > >>> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
>> > >>> unbound) as not requiring a refcount increment on (a RCU protected=
) lookup.
>> > >>>
>> > >>> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for =
datagram sockets")
>> > >>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> > >>> ---
>> > >>> Note: this issue is related to commit 67312adc96b5 ("bpf: reject u=
nhashed
>> > >>> sockets in bpf_sk_assign").
>> > >>> ---
>> > >>>  net/ipv4/udp_bpf.c | 3 +++
>> > >>>  1 file changed, 3 insertions(+)
>> > >>>
>> > >>> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
>> > >>> index ad57c4c9eaab..970327b59582 100644
>> > >>> --- a/net/ipv4/udp_bpf.c
>> > >>> +++ b/net/ipv4/udp_bpf.c
>> > >>> @@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, stru=
ct sk_psock *psock, bool restore)
>> > >>>     if (sk->sk_family =3D=3D AF_INET6)
>> > >>>             udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
>> > >>>
>> > >>> +   /* Treat all sockets as non-refcounted, regardless of binding =
state. */
>> > >>> +   sock_set_flag(sk, SOCK_RCU_FREE);
>> > >>> +
>> > >>>     sock_replace_proto(sk, &udp_bpf_prots[family]);
>> > >>>     return 0;
>> > >>>  }
>> > >>
>> > >> There is a side effect that an unhashed (unbound) UDP socket can no=
w be
>> > >> selected in sk_lookup with bpf_sk_assign.
>> > >
>> > > The commit does mention a related fix, beneath the ---, commit
>> > > 67312adc96b5 ("bpf: reject unhashed sockets in bpf_sk_assign").
>> > > That fixes a similar issue by exactly disallowing this:
>> > >
>> > >     Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
>> > >     This matches the behaviour of __inet_lookup_skb which is ultimat=
ely
>> > >     the goal of bpf_sk_assign().
>> > >
>> > > So ..
>> > >
>> > >> Though perhaps that's for the
>> > >> better because TC bpf_sk_assign doesn't reject non-refcounted UDP
>> > >> sockets either, so we would have both socket dispatch sites behave =
the
>> > >> same way.
>> > >
>> > > .. there are two conflicting types of consistency here? Consistent w=
ith
>> > > __inet_lookup_skb or the TC bpf hook. Of those the first is the more
>> > > canonical.
>> > >
>> > >> Also, with this patch, if we insert & remove an unhashed UDP socket
>> > >> into/from a sockmap, we end up with an unhashed non-refcounted UDP
>> > >> socket. Not entirely sure if that is actually a problem or not.
>> > >>
>> > >> Willem, what is your take on having unhashed non-refcoted UDP socke=
ts?
>> > >
>> > > I don't immediately see a problem, but I'm not an expert on SOCK_RCU=
_FREE.
>> >
>> > Perhaps it's worth mentioning that unhashed non-refcounted UDP socket =
is
>> > already possible: first auto-bind via connect(AF_INET) (which also sets
>> > SOCK_RCU_FREE), then unhash via connect(AF_UNSPEC).
>>
>> Setting SOCK_RCU_FREE itself should not cause a problem, but I think
>> we should take a step back.
>>
>> AFAIU, 0c48eefae712 was to allow putting AF_UNIX SOCK_DGRAM sockets
>> into sockmap, not to allow using unconnected UDP sockets in sk_lookup et=
c.
>>
>> Actually, v4 of the patch was implemented as such but did not get any fe=
edback,
>> https://lore.kernel.org/bpf/20210508220835.53801-9-xiyou.wangcong@gmail.=
com/#t
>>
>> ... and v5 (the final commit) somehow removed the restriction for unconn=
ected
>> UDP socket as well.
>> https://lore.kernel.org/bpf/20210704190252.11866-3-xiyou.wangcong@gmail.=
com/
>>
>> Given the initial use case, sockmap redirect, is still blocked by
>> TCP_ESTABLISHED
>> check in sock_map_redirect_allowed(), I feel there is no point in suppor=
ting
>> unconnected UDP sockets in sockmap.  It cannot get any skb from anywhere
>> (without buggy sk_lookup).
>
> s/unconnected/unhashed/g :)

Rejecting unhashed UDP sockets on insert to sockmap SGTM.
It is also in line with disable-problematic-cases strategy.
