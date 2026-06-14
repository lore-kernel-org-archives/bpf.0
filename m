Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014830567F
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781469545; cv=fail; b=UogkerY49QjnYFr6De0WDWA4Xhk4509r4aiZmm4cV6j/fmg0LIWnLXrCJlieWkKCFDAZ7hgA+TOiTs3m2FxvwIdDQ+mdUgKsjxxdby0pq9j0bjgUORSLrYEGvcgvDpgnsSqEK2ScEVntv03TGdBXieOAIqHq6gXW39SDmeaiOUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781469545; c=relaxed/simple;
	bh=eHU6HTc6KnTWuuFM2OJtR7l0CvhJwObW7krX8I/yEfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFNg1IvxK1CoHrFFiga3hiRgJcWR8BjpomTqxpAmRblrmah7VRp1VeR/RMj7vvfM3nHMIZEQ7/EUo+26TxV1asloSdkjIX6VrcdeU5njTUSpCgyXu8MUE8s47AKfHsDWx6d+8cekVlsKi4/W6EBFwYYbZVPe2G34Woi4mOgvTCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vQk5E4x1; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vQk5E4x1"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65EJGCLu019480
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 13:39:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=vzkgNRR8Jfjz2ksYou42bR8+4eh3BDLeRQp9bJoabj0=; b=vQk5E4x1p9px
	adYhNTu9fBYlM2+l6IdQfzFTeAMvksj8/I/zMvEYdp62CKauGySxWa9tOvXLqjVF
	PQlGYGb6Chox83ynGT1XVsl5dZOxf/D8Wah7za1H5pYnzePIxHlApEzFU/Xs0/9K
	LTfoY4YbmWZ/1i3xjkKpFpeNH6lDXN4bVps4tXXYUvPAsRHFY7GPEubP7QcpwE1b
	4LCKwqQz8VwzGykULuJxNmT1Vt8bSLXz+Bjy1XaKkYoHIAkhPAp71iqW/sDEJ7h1
	8z5eRwl5bTDNrggcA0ZkR2ihusAraYAUdQB0R+s1ShVeLok8bkgJtQXiXJYnb7Td
	5mBnUJvYpw==
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4esquh1ssa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 13:39:02 -0700 (PDT)
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-68b5941a81bso3299050a12.1
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 13:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781469541; cv=none;
        d=google.com; s=arc-20240605;
        b=QaRwDVKgFGqRF93TzB+SXHe8LEOW5Dm8N2E2nQezTRgbauheeTXjHI1x5zki+oVJtr
         9wlmTrqU3H9HxyDOi81gr4RJwrk7eDe1irDC46Hb+wzmJBxMkeuE2V+Az++6gCNeUkF3
         0ULtTE9z0b1pE0o30ZT3GLiu8R8tvlytsfSIJCid+tZzDWcHf+nUcNMbDvYCJ6GsdAdC
         QRDG0IUMwRXWQnWDXqC3wEm64tUbduZwhfJqucIbGA4c46JRRZCyKB2HqTRwQNFpcrPi
         NRWK3jOUZ0VuK3tyLUlxUe34uLiXXTk3Y4rvvNWuO+CUNjQTKTSDYz9cUOAb0JLvzZTa
         h7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=LgVmeDT2yFFv7D7NHZlGfD46fKi2Kd63IeyevXfF6qg=;
        fh=Nf88hxtLZJtRSdhfvxe3NVxdf8JfuRhbto0fDZuCepo=;
        b=bG4zTSL/MLoRHqLTvktgDlDWurF4Vj05QmGY+P7m3FgY/xNA+bmGPrb5kL8r3ZjxXi
         xeaImfnuF5jtlrreI9FutZv9iL8QXXWkhEwUg7sSugJfMdcJvJyO5Xq+UW0rOiFv2WSU
         Dh2DjXeLW1tC7Ow1J2G5uBEkiQaHgN+i1tfVXVHzZFxAWMQAx+r1VMUaPH+pYxC7p7rJ
         IESYMP7g8y7ym/oNvKiI3I4aHMVfZKpNU+kXuc30qTCRV+1YrA+2mrXHN2J6qvGd4KWC
         4iWogNHwnmmrJisWxhSnbkuSTxwVFUhbDcMQEn+GYxmYNZ8OIAGkTCq/ij66Lq1Z1D4A
         eq4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781469541; x=1782074341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LgVmeDT2yFFv7D7NHZlGfD46fKi2Kd63IeyevXfF6qg=;
        b=oxu4DOYKVPKKYCYrNDsxBtEMRIHng0iNp6/PFSPfFFTDroQ8w6QoJ2+RUiWVOxc+Ce
         RWGzBAavoqqCWBJiml//z2lG8u8Vv4Gwgs/qoBcfrmbgD25ZwV67QTvgY0/TsGjWrDMy
         E4AWU0310K+gBJbuisq1JzmRRi6XD9jqg9CYa2AE58YZRPCqr73WngXWe9WJXrXv1YN1
         jsF4OVrc5pfNdxone3xCsC6+qbaqenwIis/CL9Y6f8eoVBPUzkbywZffqW7tW6GhE7Y7
         uT8LiUg5JAPq/jU0K+8sHC/4BxqDLCkniJJaDQN1i91A/Y4yBe8ds8H4baNvh+Z2ew1s
         SkcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pw2E91pgOiyUyJrtKBvfsKgWU+eE+6biVS4reVTbiTdVI1lScmx3UuRTxyhu+Zd3LsKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweLwGqverv0J9DZw/KpBgh62sX/PgtZHU/iih89aAiz2j2VJA5
	YJDrAVLfjRrBcHnE4oJt/4uvlZonCQZOed9QVY8q66z42sAOsD4ELY1OFVRA5DHIjtCMopIJJ4B
	VMl6akXBJM9vZxTDaxXbvAS0ZhloHtRBwLmpbyxFZw8WM/fBhUL3aHk8EuW3coFM46SXIBakMlS
	WvwDic8yL/fPeeIfFAj6HOF+2z3g==
X-Gm-Gg: Acq92OEzmzdmwHLf6yzJ1Kz31s9+KCf6IolT13nANQ1J9b7hrP7w+8tRDWA5rWV7aFZ
	2yMbBs3xL287Bsr/fNbFqRuiyt+QwNi/r1UBLFCFomOdUIqn6VfKyGP/CuUl5Zwn96z6Vb6h5fr
	7wpgwReo1IaIrneYNdSa6kxNXxrQOVNmD+744uW3fOvpNVakqNTLHcaJZ8jDiuLl5KjIMoPXic2
	ijoaPI=
X-Received: by 2002:aa7:d1cd:0:b0:691:acd4:df83 with SMTP id 4fb4d7f45d1cf-6936890b94cmr3190490a12.5.1781469540769;
        Sun, 14 Jun 2026 13:39:00 -0700 (PDT)
X-Received: by 2002:aa7:d1cd:0:b0:691:acd4:df83 with SMTP id
 4fb4d7f45d1cf-6936890b94cmr3190482a12.5.1781469540353; Sun, 14 Jun 2026
 13:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612010047.1377331-1-ntspring@meta.com> <20260612010047.1377331-2-ntspring@meta.com>
 <6ab86192-f0d4-4a00-83c9-3fd6449dc9dd@redhat.com>
In-Reply-To: <6ab86192-f0d4-4a00-83c9-3fd6449dc9dd@redhat.com>
From: Neil Spring <ntspring@meta.com>
Date: Sun, 14 Jun 2026 13:38:33 -0700
X-Gm-Features: AVVi8CfVyAEglHhJ1KSN0z5otEja-ADCDtBWuoT03y643yoO6doeRS0y2nFQuVQ
Message-ID: <CAGy2EQY0b2y9xCShqM3JVu7FprPn8qNdoH=THJ=MWY+01dBENA@mail.gmail.com>
Subject: Re: [PATCH net-next v13 1/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
        kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
        dsahern@kernel.org, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        martin.lau@linux.dev, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 6V7kcLJddeoaR1ry-_8nkMXoteQUt-hQ
X-Authority-Analysis: v=2.4 cv=RYmgzVtv c=1 sm=1 tr=0 ts=6a2f1166 cx=c_pps
 a=DTy5UCxgudPLKrSn28m7Kw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8
 a=TjoYT3vZz40Pw0TJUQcA:9 a=QEXdDO2ut3YA:10 a=VzYV69SsQLkmnS9OQLw-:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIxOCBTYWx0ZWRfX72iTAXZjXqsH
 GvHMx9RLIH05x+zu0bUou0eYrd7VrleO9CSXSriT6p6zJEuvPnCnRMdtP2rVJZYeZBZ2i9o2Z1K
 Iqf9MFFBHd16rLbIEvM08cy4m8ImoYg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIxOCBTYWx0ZWRfX4zjbBBwv1jxC
 RU2U5ijeJwd7SjdvX4s4+bFuG7FMr/ohnxFN3s/0wFvxl/XeUBG83ckRewow9fGJKRokanzqAFk
 sebr2ITw7E914bCNbNPZoVfInUuNpedZfyfi3OOY9gPkhuq5iltJ+XrA75uuMIW8GHlZ7s/RWxN
 HjFjjMURD/Js6DSeMHGCVi5ULL9dCD1/gx4POdoDlp2a+uCpFQnZfWQEYJbRiVVjo4B4rmOsYit
 gSm0l7byG9bQ6QtBTCqH35TDhTf64SSG5dCcVtqFYeq/jKfHFCNdYn2bdZm/vcenwOrQGd6wca6
 MwT/mYCBlEPmihLl7Uv4aTj3pfvFEs44y4fTgSlZzB5fzlIRDEzafGeksPfjZQ7TLCylPwvsA57
 x3l+Cz8NUmtjM+91NyiWC0oYeCVoHJ9XiJdZpZkeYWz69AijmJsnSWB1Y9vEK8JH/OkpET66Sk8
 zWBnn65rSB76ov9KvGA==
X-Proofpoint-GUID: 6V7kcLJddeoaR1ry-_8nkMXoteQUt-hQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_04,2026-06-12_03,2025-10-01_01

On Sun, Jun 14, 2026 at 6:54=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> >
> On 6/12/26 3:00 AM, Neil Spring wrote:
> > Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
> > and spurious-retransmission events, but the cached route is reused and
> > the new hash is not propagated into the ECMP path selection logic.  Two
> > changes are needed to make rehash select a different local ECMP path:
> >
> > 1. Add __sk_dst_reset() alongside sk_rethink_txhash() in
> >    tcp_write_timeout(), tcp_rcv_spurious_retrans(), and
> >    tcp_plb_check_rehash() so the cached dst is invalidated and the
> >    next transmit triggers a fresh route lookup.
> >
> > 2. Set fl6->mp_hash from sk_txhash (or tcp_rsk(req)->txhash for
> >    SYN/ACK retransmits and syncookies) in tcp_v6_connect(),
> >    inet6_sk_rebuild_header(), inet6_csk_route_req(),
> >    inet6_csk_route_socket(), tcp_v6_send_response(), and
> >    cookie_v6_check() so fib6_select_path() picks a path based on the
> >    new hash.
> >
> > The mp_hash override only applies to fib_multipath_hash_policy 0 (the
> > default L3 policy).  Its hash includes the flow label, but that is 0 by
> > default -- np->flow_label is unset, and auto_flowlabels only computes
> > the on-wire label later, per packet -- so flows to the same peer share
> > one local path.  Keying the hash on sk_txhash makes the local path
> > per-connection and lets a rehash re-select it.  Policies 1-3 are left
> > unchanged.
> >
> > The mp_hash assignment is factored into a small helper,
> > ip6_ecmp_set_mp_hash(), shared by inet6_csk_route_req(),
> > inet6_csk_route_socket(), tcp_v6_connect(), inet6_sk_rebuild_header(),
> > tcp_v6_send_response(), and cookie_v6_check().  It applies
> > (txhash >> 1) ?: 1 for policy 0 (the >> 1 keeps mp_hash in the 31-bit
> > range; ?: 1 keeps it non-zero, since 0 would fall back to
> > rt6_multipath_hash()).  inet6_csk_route_socket() calls it only for
> > sk_protocol =3D=3D IPPROTO_TCP so that non-TCP callers (e.g., L2TP via
> > inet6_csk_xmit) fall through to rt6_multipath_hash() and retain their
> > existing flow-key-based ECMP behavior.
> >
> > tcp_v6_send_response() also sets mp_hash from the response txhash so
> > that a control packet (a RST from the full socket, or an ACK from a
> > time-wait socket) selects the same local ECMP nexthop as the
> > connection's txhash rather than falling back to the flow hash.  The
> > time-wait socket's tw_txhash is copied from sk_txhash when the
> > connection enters TIME_WAIT, so it reflects any rehash that occurred.
> >
> > Setting mp_hash explicitly is necessary because the default ECMP hash
> > derives from fl6->flowlabel via np->flow_label, which is not updated
> > from sk_txhash (REPFLOW is off by default).  ip6_make_flowlabel()
> > cannot help either, as it runs after the route lookup.
> >
> > As a consequence, for policy 0 the local ECMP path of an IPv6 TCP
> > flow follows sk_txhash even when fl6->flowlabel is non-zero, e.g. a
> > reflected (REPFLOW) or explicitly set (IPV6_FLOWLABEL_MGR) flow
> > label.  This is intentional: only local path selection changes, so
> > rehash can recover from a failed path; the on-wire flow label is
> > unchanged.
> >
> > sk_set_txhash() is moved before ip6_dst_lookup_flow() in
> > tcp_v6_connect() so the initial ECMP path is selected by the same
> > txhash that subsequent route rebuilds will use.  This avoids
> > unintended path changes when the cached dst is naturally invalidated
> > (e.g., by PMTU discovery or route changes).
> >
> > The rehash sites (tcp_write_timeout(), tcp_plb_check_rehash(), and
> > tcp_rcv_spurious_retrans()) call __sk_rethink_txhash_reset_dst(),
> > which re-rolls the txhash and, when it changed, drops the cached dst
> > so the next transmit re-runs route selection.  The dst reset is
> > guarded by sk->sk_family =3D=3D AF_INET6 since IPv4 ECMP does not
> > currently use sk_txhash for path selection.  For IPv4-mapped IPv6
> > sockets this produces a redundant dst reset on a cold path
> > (RTO/PLB); the subsequent IPv4 route lookup returns the same result.
> > The helper is deliberately separate from sk_rethink_txhash() itself:
> > dst_negative_advice() calls sk_rethink_txhash() before its own dst op,
> > so resetting the dst inside sk_rethink_txhash() would skip that op
> > (e.g. rt6_remove_exception_rt()).
> >
> > For syncookies, cookie_init_sequence() computes the cookie value
> > before route_req() and sets txhash so the SYN-ACK selects the same
> > ECMP path that cookie_v6_check() will use when the full socket is
> > created.  cookie_tcp_reqsk_init() derives txhash from the cookie so
> > the full socket's ECMP path matches the SYN-ACK.  Both the SYN-ACK
> > assignment in tcp_conn_request() and the full-socket assignment in
> > cookie_tcp_reqsk_init() are keyed on the packet family
> > (skb->protocol =3D=3D ETH_P_IPV6), not sk->sk_family: a dual-stack
> > AF_INET6 listener also serves IPv4 connections, and the v4 cookie has
> > mssind bits that would bias TX queue distribution if used as txhash.
> > IPv4 connections retain net_tx_rndhash().
> >
> > cookie_init_sequence() is split from the former version that also
> > called tcp_synq_overflow() and incremented SYNCOOKIESSENT; those
> > side effects are now in cookie_record_sent(), called after
> > route_req() succeeds so they are not bumped when route_req() fails.
> > cookie_record_sent() is guarded by CONFIG_SYN_COOKIES to
> > match the guard on tcp_synq_overflow().  route_req() receives 0 as
> > tw_isn for the syncookie path so that tcp_v6_init_req() still saves
> > ireq->pktopts for REPFLOW flowlabel reflection and IPv6 cmsg
> > options.  The ecn_ok clear for syncookies without timestamps stays
> > after tcp_ecn_create_request() so it takes precedence.
> >
> > Signed-off-by: Neil Spring <ntspring@meta.com>
>
> This looks good to me, with a minor commit below.
>
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index df479277fb80..cc71d84df42b 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -280,9 +280,18 @@ static int cookie_tcp_reqsk_init(struct sock *sk, =
struct sk_buff *skb,
> >       treq->snt_synack =3D 0;
> >       treq->snt_tsval_first =3D 0;
> >       treq->tfo_listener =3D false;
> > -     treq->txhash =3D net_tx_rndhash();
> >       treq->rcv_isn =3D ntohl(th->seq) - 1;
> >       treq->snt_isn =3D ntohl(th->ack_seq) - 1;
> > +     if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
> > +             /* Use the cookie as txhash so the ECMP path matches
> > +              * the SYN-ACK, where txhash was also set to the
> > +              * cookie.  The original request socket (and its
> > +              * txhash) was freed after sending the SYN-ACK.
> > +              */
> > +             treq->txhash =3D treq->snt_isn;
> > +     } else {
> > +             treq->txhash =3D net_tx_rndhash();
>
> I'm wondering if it would make sense always using snt_isn for txhash in
> the syn cookie case, regardless of the IP protocol. Beyond reducing the
> differences between ipv4 and ipv6 it will make the code a little simpler.

I added the conditional in v11 after the AI review poked at how this wasn't
plumbed for IPv4; it seemed safer and clearer about v6-vs-v4 use of txhash,
but I wasn't weighing a goal of avoiding protocol-specific paths.

I will try no-conditional again in v14 with this feedback, happy to change
back if anyone has a strong opinion.

-neil

>
> Not a blocker in any case.
>
> Still I think this could deserve an explicit ack from Eric.
>
> /P
>
