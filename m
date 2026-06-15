Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC53407CF9
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542561; cv=pass; b=FOx5oyBdT+FlEcBISjh6Dt6L0aESUnqdCW/rms7pUc+Gtm/VJRfi5pt1nkAOYM7BaiYQq17zMp5a8/w5EnuUmfjruMNDizfVxu0Nzljq6mttnUP3KmAuXyK2RB1QZdluW7rxhTTJ8nRnW6wmgKSw7FPplLYXkTyrJEDkYhB8xak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542561; c=relaxed/simple;
	bh=4YPWMK+0WYWJceGQjSJj/WOQ+Iz5+dRnHqH63ccwQUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8mledXdZTZGJU2fDQ9iNGgdQzdjHw2LGhWvl42Vq8S0OiKk2UBoQqAa3P9iFaiVti41PhZis/kp/zIL8Fv7JLuIlOI/aMOS+FDledVP3rcX5/pxQ6BhkfRIxvWYsMzE4vVqOzehP17XRaMsjQ3vsC/1nNBjma5vQAk6gTsVUQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcSXSTgB; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcSXSTgB"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5177b1a7441so49835071cf.3
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781542558; cv=none;
        d=google.com; s=arc-20240605;
        b=kx5WkIiBM82h0KZmcHDHeF4HjgKRmghbISoJBCQFp8bzdlBclZDrgbf9YRpw2poTOi
         eWkseYjlalvCVOHPe9KfWMc5UWBC6ZMmyeDodtZD/TykVpPkR+ggZnPz9/SRQZcZ7+RI
         68WVwV+Fsxn/GY/5FKBvjAj+xbBpRYCBricxvqtWVToZJOZ4BPVcjoXrG0vmjnpEhLC/
         g7VVLZEQuyt3OrhzLFjKBs6cM9mLHRAqWTh9hA4Y18iLvOf0i136wohtyancctzOW130
         ZA9KuKjk708jrkiBwrix+oTBxT/sr+GH5DTrdPP3BtHd+4LnUI8imN9dgHSklWXRcUf5
         VLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=op3KaiCmJCT9futuSMniceaWe5Q/wKrwv8uwA7WTvb8=;
        fh=5igHcPyq8v2nqOdLgrmCQXO7v47flVOGDXN9tOcgDGs=;
        b=NctGvEKQKsi22G4rw4w+IRsLqFNVzg4ltuC8X5brI/FVHXUQqFWcyCnLb1JaQZuqKJ
         vwSBE5SksoBRkbVmrJOHRHWuv7Lbl244Rh0dWsE1eSy61UaDYk3d57MVRUuhW1BTTMvN
         BErTg/D+GlZ16hHj+pdLZ+GoWNUNU1IgotQbZDnV9GVWVZMBLsOwD58wxtCRyAObvTwM
         ZkOpWSTqCKmh04CEbulyb9ToC3bg9TrRC4LjKiqAS1Gbr6drwcFfv0bH7Cow7uoGSySo
         u3BeOq3y/VqkpiNCiFqjTxEBlH1kx0q7PrySZM5paePAUSEeY3jHG7CisZgrsh68IpLA
         1F2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542558; x=1782147358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op3KaiCmJCT9futuSMniceaWe5Q/wKrwv8uwA7WTvb8=;
        b=mcSXSTgBoO4O/qL7Qd87hqo3I3Z0I3BGtkW9A2FPKwCQFvqqU09+es8L6ET2ATj6TS
         7Y0ystcfUhQ/69kFzrPWyYo4/gCZKYKTX9HxxAuBBHdMxPhm+t2G5A6hZdnB2nyYOxen
         cj+Dw6ZJfmjy6XyY1hcyb+h/1CJuYTQ0VV0GiRrIFZ8Hj647FS/PEPXYNyij5GXyqWhB
         9iZtnFD/rWWi1xRU0fKOZRhwyEtUxr6w2fgymUImnNv1IGHiMFQdxkid2CVucz4H/za4
         uxWKCbj5fDTA13HQiDMrAaIyoxWuWw99510D2QSPmEa5OkPiBhGLoBdmiacTXBZRJZn0
         //LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542558; x=1782147358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=op3KaiCmJCT9futuSMniceaWe5Q/wKrwv8uwA7WTvb8=;
        b=rVKIpnByRmZ2P/cgNUS1/QmCukI/8Ofm/nfYro2tmipFcvfdqu9UEe2ZhmEU7232an
         di8wSI3WKw9JKnxsFojANB5ZBwooTnsthpjVGJIQD7EyaT3Z+8hQYGxF3gqNCK8kfGef
         qiiX8rrMPcT5eA/UIm1sbakejgVMWFOMu27lo2x4Lk5uj0KH2K2G0m5e7/26M8/gDI47
         h2EJ1rUX2BGfR6xcv5gjOkBQVWr72JPclGnd4O5PdaNMp9YLE+Xyj/Hrf0zUrUDEjt8D
         oBTX/5r0L7rLFA60cuhZX1Z0rS9VaCDUguL5t1WbPuckcZgqzwtC0Fvfru1hc9D+ZyYl
         nRrg==
X-Forwarded-Encrypted: i=1; AFNElJ9pGFzAeFUyiNFCmXoGMKLqPdjJCZmtGeeOJFMuMPEk2o2nwywsioswkQkAqYnANEpwKxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8crG1pw3t+Hspi7UZV0yNquhw5QmybMtwcixUoUlCZTZ8i71
	Zew19oR4JSNo3LY4rTEVt15PzSclfBxn98ysMn19hc3uySTnAu/YOwprV1TzrdF1WDT/Acjpu0C
	PTBW+lNHFTx1MNnykoCHeh/55ze6i9JUy4iM189QV
X-Gm-Gg: Acq92OFVIyuA7iLRiWEpKghpW9qAT9vrXL1VSCBy1DT/ejRt5zFoLf+GwcsrywOh68V
	LEyOFubFupamMEcYQPav1F6WlKwEK6DGUI4V5flmAfZbCB7PDMdn8Lf03qKp4sNxVhtbtofi2xt
	qdgU7CgUqB/HgVbMEWHXaxmgGAC5ize2IyvO/oevu7y+J96rRvjUYyq0JmE/+p3oex/gsnYHLvR
	cLVNdV0xvhR+SN07ymaOK1OM9ggNynK0SWDbAtp0fyiylnsog/79F4BEX7hlrYdFiYWsdtMRDdj
	FtqozpzTZg8/4ojvymt5bd8U0NQKxkProyACfq08txSuwH3Fy28DCvtgBCAbWDP81bx24YkalWc
	/w3yWTuiSAUllnm1lQSol
X-Received: by 2002:a05:622a:1115:b0:50f:b4c0:630f with SMTP id
 d75a77b69052e-5195357c228mr175976161cf.54.1781542556797; Mon, 15 Jun 2026
 09:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615042158.1600746-1-ntspring@meta.com> <20260615042158.1600746-2-ntspring@meta.com>
In-Reply-To: <20260615042158.1600746-2-ntspring@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 09:55:45 -0700
X-Gm-Features: AVVi8CcLt4JINR95JUJ5Pig2rgeZiW8v5j_nnToRd6BeBcgfvgXVPVQccUrwbf4
Message-ID: <CANn89iLjf-d08s1ofLo3fDUQENYji9qwG6fQbiAN3fyvxP=+BA@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] tcp: rehash onto different local ECMP path on
 retransmit timeout
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 9:22=E2=80=AFPM Neil Spring <ntspring@meta.com> wro=
te:
>
> Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
> and spurious-retransmission events, but the cached route is reused and
> the new hash is not propagated into the ECMP path selection logic.  Two
> changes are needed to make rehash select a different local ECMP path:
>
> 1. Add __sk_dst_reset() alongside sk_rethink_txhash() in
>    tcp_write_timeout(), tcp_rcv_spurious_retrans(), and
>    tcp_plb_check_rehash() so the cached dst is invalidated and the
>    next transmit triggers a fresh route lookup.
>
> 2. Set fl6->mp_hash from sk_txhash (or tcp_rsk(req)->txhash for
>    SYN/ACK retransmits and syncookies) in tcp_v6_connect(),
>    inet6_sk_rebuild_header(), inet6_csk_route_req(),
>    inet6_csk_route_socket(), tcp_v6_send_response(), and
>    cookie_v6_check() so fib6_select_path() picks a path based on the
>    new hash.
>
> The mp_hash override only applies to fib_multipath_hash_policy 0 (the
> default L3 policy).  Its hash includes the flow label, but that is 0 by
> default -- np->flow_label is unset, and auto_flowlabels only computes
> the on-wire label later, per packet -- so flows to the same peer share
> one local path.  Keying the hash on sk_txhash makes the local path
> per-connection and lets a rehash re-select it.  Policies 1-3 are left
> unchanged.
>
> The mp_hash assignment is factored into a small helper,
> ip6_ecmp_set_mp_hash(), shared by inet6_csk_route_req(),
> inet6_csk_route_socket(), tcp_v6_connect(), inet6_sk_rebuild_header(),
> tcp_v6_send_response(), and cookie_v6_check().  It applies
> (txhash >> 1) ?: 1 for policy 0 (the >> 1 keeps mp_hash in the 31-bit
> range; ?: 1 keeps it non-zero, since 0 would fall back to
> rt6_multipath_hash()).  inet6_csk_route_socket() calls it only for
> sk_protocol =3D=3D IPPROTO_TCP so that non-TCP callers (e.g., L2TP via
> inet6_csk_xmit) fall through to rt6_multipath_hash() and retain their
> existing flow-key-based ECMP behavior.
>
> tcp_v6_send_response() also sets mp_hash from the response txhash so
> that a control packet (a RST from the full socket, or an ACK from a
> time-wait socket) selects the same local ECMP nexthop as the
> connection's txhash rather than falling back to the flow hash.  The
> time-wait socket's tw_txhash is copied from sk_txhash when the
> connection enters TIME_WAIT, so it reflects any rehash that occurred.
>
> Setting mp_hash explicitly is necessary because the default ECMP hash
> derives from fl6->flowlabel via np->flow_label, which is not updated
> from sk_txhash (REPFLOW is off by default).  ip6_make_flowlabel()
> cannot help either, as it runs after the route lookup.
>
> As a consequence, for policy 0 the local ECMP path of an IPv6 TCP
> flow follows sk_txhash even when fl6->flowlabel is non-zero, e.g. a
> reflected (REPFLOW) or explicitly set (IPV6_FLOWLABEL_MGR) flow
> label.  This is intentional: only local path selection changes, so
> rehash can recover from a failed path; the on-wire flow label is
> unchanged.
>
> sk_set_txhash() is moved before ip6_dst_lookup_flow() in
> tcp_v6_connect() so the initial ECMP path is selected by the same
> txhash that subsequent route rebuilds will use.  This avoids
> unintended path changes when the cached dst is naturally invalidated
> (e.g., by PMTU discovery or route changes).
>
> The rehash sites (tcp_write_timeout(), tcp_plb_check_rehash(), and
> tcp_rcv_spurious_retrans()) call __sk_rethink_txhash_reset_dst(),
> which re-rolls the txhash and, when it changed, drops the cached dst
> so the next transmit re-runs route selection.  The dst reset is
> guarded by sk->sk_family =3D=3D AF_INET6 since IPv4 ECMP does not
> currently use sk_txhash for path selection.  For IPv4-mapped IPv6
> sockets this produces a redundant dst reset on a cold path
> (RTO/PLB); the subsequent IPv4 route lookup returns the same result.
> The helper is deliberately separate from sk_rethink_txhash() itself:
> dst_negative_advice() calls sk_rethink_txhash() before its own dst op,
> so resetting the dst inside sk_rethink_txhash() would skip that op
> (e.g. rt6_remove_exception_rt()).
>
> For syncookies, cookie_init_sequence() computes the cookie value
> before route_req() and sets txhash so the SYN-ACK selects the same
> ECMP path that cookie_v6_check() will use when the full socket is
> created.  cookie_tcp_reqsk_init() derives txhash from the cookie so
> the full socket's ECMP path matches the SYN-ACK.  Both the SYN-ACK
> assignment in tcp_conn_request() and the full-socket assignment in
> cookie_tcp_reqsk_init() set txhash from the cookie for IPv4 and IPv6
> alike.  On IPv6 this drives ECMP path selection; on IPv4, which does
> not use sk_txhash for ECMP, it only affects TX-queue selection.  That
> selection scales the hash by its high bits (reciprocal_scale()), which
> are uniform in the keyed secure_tcp_syn_cookie() output -- the MSS index
> only perturbs the low bits -- so the queue distribution matches
> net_tx_rndhash().
>
> cookie_init_sequence() is split from the former version that also
> called tcp_synq_overflow() and incremented SYNCOOKIESSENT; those
> side effects are now in cookie_record_sent(), called after
> route_req() succeeds so they are not bumped when route_req() fails.
> cookie_record_sent() is guarded by CONFIG_SYN_COOKIES to
> match the guard on tcp_synq_overflow().  route_req() receives 0 as
> tw_isn for the syncookie path so that tcp_v6_init_req() still saves
> ireq->pktopts for REPFLOW flowlabel reflection and IPv6 cmsg
> options.  The ecn_ok clear for syncookies without timestamps stays
> after tcp_ecn_create_request() so it takes precedence.
>
> Signed-off-by: Neil Spring <ntspring@meta.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
