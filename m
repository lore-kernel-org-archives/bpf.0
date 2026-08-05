Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2303E4C99;
	Wed,  5 Aug 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920639; cv=none; b=l1kbp7b7KGpfVEukUlnmIQm7v3Eex5Qx5+7CqZOekx94M3yIr35NwV1rVnXLviAr3iuFKDW5qf63Aqy+MAtuO3wh50d5+Z1kVsR4/rt57AcRd0+nFv8fBf0zaAMpGXb7O6RMtNcr6GEH61JBcGeXNHUZ7eLVpUZKH1+JMfGU+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920639; c=relaxed/simple;
	bh=e+FFkj2vki9ssVlwHoF3OwMJDa3+gvinGWWqtGkNyac=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=A95aJc2JlalokQAPJLjebqH048OQrxJaSog9LAXtPaWBDfD77UzHktAOJWj3oyivFtTYy1+pRgml6NYoIeIP/7/ZBU7kVQCuCRjiwEIRaOehOfUleMQFwqwwSHbMKMf06XvxWPilG75aMEQpscbCWy7ur5DsW3sbF88e9AhzESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nJPuamzr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VlKQ0Vbf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nJPuamzr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlKQ0Vbf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 169AB1400093;
	Wed,  5 Aug 2026 05:03:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Aug 2026 05:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1785920637; x=1786007037; bh=V8NILqoS4glB3mLmuiSRUg+9KPSrPGxF7I6
	ZBjRPSCc=; b=nJPuamzrR1Alu8VuLUnXBIATQyaoiUiX93JhRvhwMoGVFSwC60f
	YHf67hIjXELsrMXOJOU7Gl+sOwdJhAO//suV7jmR8tPR2hNsJIV0nLUx2gwlktf6
	7dl7dVd6rs41i31kZEnEl/PXTGjn+YlTCAoWzMnvkXveF993L8bMU2I6P993Dyif
	mi7iQ2cmmxVi762tko8YILgncUO3cNPHErHccgCRhLXmhQ4KB68S+w7eViQCKCBz
	iHjxAbDDYvcsBj7PY6T7LbwxSNPFwWcU2GjBWJM1TcsZlD2YEPimciSz2svqeIBm
	bTntUISCT2byZn1nzy+y1KwU6+bfkd1yzoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785920637; x=
	1786007037; bh=V8NILqoS4glB3mLmuiSRUg+9KPSrPGxF7I6ZBjRPSCc=; b=V
	lKQ0VbfT0P6agmPGoqvWqlBPjWM1JkfiHAXrZKyrPQY4VO20ycpu2TD/T60kyimo
	dR/f7YAkrTi24m6N6EJ9SabYYDonflPVeuVhTqDGM3Q9RuipljJ3N/G6sfZwXZoJ
	8npmOaRtEEpPjwMq+6tWy7TdZk7tF1/Q/wokHDCu1T+6dA6fnpL62Z11ofy3BZL3
	YDnDFa+6FoS7qJiuiV+Z/gg9JQrJhWUtcCUorgBbx0x/3pwyPa6lxyUzEa3H6rtd
	ppqykbmLbFdX5GQXU79nJ8W5mhoc+mG2p7wvzwAEDiWDsEbmNH1IpeKOGGHuH3GF
	7xiVOA/A4tK6HxK/k87/A==
X-ME-Sender: <xms:fPxyavxDkL_OtxPuMaTok_pgkRJZLUmDitoBhlE2u-0j4SLBaReQkg>
    <xme:fPxyai0B4ycqpIA_KG6HSuhHVQPBGOdvdvqRMPKEyXbcYTquGwbLd1HgZtRMmMyVX
    b94-1tyMY5Otca3jjAXoHmKLnTZwLTnGUMsH7PvQfpumwQ>
X-ME-Received: <xmr:fPxyapWKLNjJvbWac86VE-9nMjUVS6mIh_rqsQCcAHX0oJ5PhLg_AQyshlLaTtmxBL9_xJylFqSg1Vs_VEMfvaTl7VHZX7I>
X-ME-Proxy-Cause: dmFkZTEMRELEGXJKK4rvJ+Dj/tUdstLzds6uJnfi+y1lukhwX2+9u+uluDc5PTwcmqUyzs
    l5kJbIn4wkEzvVuPGFyMEvdgDiW9RVp4E3822V9L8AoMLys6WW6Zb+g0mwW4B9yjgvsrzT
    ruDarXomdmNDoQDOCw/1tsFrKKNg7e9orBBMmtF8NMVLZhDpor10sFPIrJ9l7WzhAeR73q
    GFkd085cCQkwjvrT+XBcFbmoTmJyNpIsYtkl44VmE8XaS2CqyDUv2WP6VOfs6DzUu/SntR
    /yOQG5l8oWt7/g7AOv3t+U8w4QfMfbHybcOpmdXlfmByBXcHDccNtRG2I3bS78QrkF/oWD
    eWP7ungPcsoRDrFg2kPu/U9CvjIjVMKsTBYQXJ6Ry8QLZ/ngNEmfmrctHXkH1WFTFIIplH
    8z0lKJ+KbImV0q5eaiGlVY0htsh6nIfkrS6oFed9xGcErAdIsXwOt3quNRfFgohViSKLXj
    qB2zU3gRvlPv5Knn+G5AqvxqqZfV6blpg673G7WaHoubVYtfG5ICJerdNZZFifNSOamAGv
    D51fLgF7i6vz70PlhD3mGEWdxPkc7Q02JvvpPCX3dlrdFHiGpLlNObhmMCciEpF2aaYjPX
    24kpjwZkkXYxHrxuNsYz4QdsVxJaY5OR/yT9xeUuqC0amP0qDxK0TNYXJcaA
X-ME-Proxy: <xmx:fPxyaufSJQlFBgLGJgLgKLl6g5xNT_w8j7sblvBIfmrhWXxSgpT2yQ>
    <xmx:fPxyai9ntvfSil1t2pwxzPeSxN55tYQQ9eGjmpQGyFy0IL8nnx1T9A>
    <xmx:fPxyaub4VEdNLRYf3q9wYV2EpwWhDHfgUmnAVb2fPJuu9XGkH_qIvA>
    <xmx:fPxyaiv3HDuOWWW8gT-I1_RYYyUoGwrv_WHFDCtnX45-U1IhbfKzjA>
    <xmx:ffxyanzria7ia9QAka6aAv1VQsaU9gikAUHIV8Fx5XrLa6wbew9le7yV>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:03:49 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "quanyeyang" <quanyeyang@proton.me>
Cc: "Quanye Yang" <quanyemostima@gmail.com>,
 "Justin Suess" <utilityemal77@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Song Liu" <song@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>,
 "KP Singh" <kpsingh@kernel.org>, "Matt Bobrowski" <mattbobrowski@google.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "Emil Tsalapatis" <emil@etsalapatis.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
Subject: Re: =?utf-8?b?5Zue5aSN77ya?= Re: [PATCH] bpf: disable lockdep while
 running BPF on lock_release
In-reply-to: <46Fu_iB0xOxZXb0l5G6pslLArj7TrP_AOICffhfZKoviSn7zVUVVVSMfWaVBYNqt9RiCWWHhSAvlMc3RaJvRFSnvbV2EcBz9VUBQzb2wSkw=@proton.me>
References:
 <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
  <anEuaSqiCVsQ6I4P@zenbox>
  <178583246611.3252194.4318729338489544399@noble.neil.brown.name>
  <CABcBDJuznu=BgDhevsD6PybX8+6fcaO1xyTcuGuv8F_+MfeZoQ@mail.gmail.com>
  <178588373680.3252194.4414470901360919775@noble.neil.brown.name>  <46Fu_iB0xOxZXb0l5G6pslLArj7TrP_AOICffhfZKoviSn7zVUVVVSMfWaVBYNqt9RiCWWHhSAvlMc3RaJvRFSnvbV2EcBz9VUBQzb2wSkw=@proton.me>
Date: Wed, 05 Aug 2026 19:03:45 +1000
Message-id: <178592062568.3252194.6464683099845305898@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 05 Aug 2026, quanyeyang wrote:
> On Wed, Aug 5, 2026 at 6:49=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> > I don't think that detecting recursive acquisition is a scalable
> > solution.  You'll keep finding new locks that you need to enhance.
>=20
> Yes, it makes sense.
>=20
> >
> > If I step back a bit, it looks like TP-BPF (BPF attached to tracepoints)
> > introduces a new execution context, similar to SOFTIRQ and HARDIRQ.
> > i.e.  it is something that can start running at almost any point and
> > blocks the currently running code until it completes.
> > I suspect it would be good to handle it in a similar way.
>=20
> Thanks for the detailed explanation.
>=20
> >
> > So I suggest adding a new
> >   LOCKDEP_STATE(TP_BPF)
> > to kernel/locking/lockdep_states.h, and teaching lockdep to understand
> > it.  Then it could help avoid all these problems.
> >
> > An important part of this would be the ability to temporarily disable
> > TP_BPF much as we can disable interrupts.  What happens at present if
> > there is tracepoint that happens in BPF code, and a BPF handler is attach=
ed
> > to that.  Does it get called recursively?
> > Would there be a problem with disabling new TP_BPF handlers while TP_BPF
> > code is running?  Maybe this is already done?
>=20
> It's already partly done, but it differs by attach type.
>=20
> The perf-event tracepoint path -- trace_call_bpf(), and the perf-overflow
> (PMI) path bpf_overflow_handler() -- share a global per-CPU counter,
> bpf_prog_active: while a BPF program is running on a CPU, any further
> BPF on that CPU is skipped (the prog_array is re-entered only to bump
> the miss counter). So a tracepoint firing inside BPF code does not
> recurse there; the handler is dropped. That is already the "disable
> TP_BPF while TP_BPF runs" behaviour, analogous to disabling interrupts.
>=20
> The raw_tracepoint path is different: __bpf_trace_run() uses
> bpf_prog_get_recursion_context(), which is per-program -- only the *same*
> program is prevented from recursing; *different* programs can nest. So a
> raw_tp handler can run nested inside another raw_tp handler on the same
> CPU.
>=20
> So the recursion/disabling mechanism exists, but it isn't uniform: the
> perf path is already "disable-like", raw_tp is not. That asymmetry is
> itself part of what makes the lockdep picture messy.
>=20
> >
> > Circling back the original patch to rhashtables that was proposed - had
> > you said that you needed to use rhashtables in a different context
> > similar to HARDIRQ or SOFTIRQ, then I think I would have had a different
> > response.  That is a well-specified problem with well-understood
> > solutions.
> >
> > I would likely be OK with making is possible for lockdep to see locks
> > from different tables as different locks, because they need to be taken
> > in different lockdep contexts.
> >
> > I would then see if the new lock_class_key could be declared in the
> > rhashtable_params struct.  This is already passed around everywhere, so
> > this would be much less intrusive.  We would have to use some cast to
> > get rid of the 'const' attribute when passing the lock_class_key to
> > lockdep, but I think that is justifiable.
>=20
> On the per-table lock_class_key in rhashtable_params: that sounds right
> to me. I'll rework the rhashtable patch so each table can declare its own
> key in params -- framed as "different tables live in different lockdep
> contexts" (not per-init-site, as in my first attempt) -- and resend.
>=20
> Two small notes:
>  - if the field is a `struct lock_class_key *` pointer, the params struct
>    can stay const: lockdep writes to the pointed-to key, not the struct,
>    so no cast-away-const is needed;

I hoped that the keys would be embedded in the params.  That would work
nicely if all users simply used a global params structure.  But a few
copy the structures around (I cannot imaging why, but maybe there is a
good reason).  Copying lockdep keys doesn't work.

(And some use extern references....  I wonder home much performance they
lose because the hash/cmp functions cannot be inlined....)

One thing I didn't like about the original patch is that it seemed to add
a lot of noise to the code, passing keys around in multiple places.
Maybe the cleanest approach would be to embed the keys in the "struct
rhashtable" so each table gets its own key.
Then use lockdep_register_key() in rhashtable_init and use it as needed.

You could even have just one key and use the different subclasses for
the different locks.
 0 for rhashtable.mutex
 1 for rhashtable.lock
 2 for the bit locks

but maybe that is needless complexity.

All of the rest of your email is interesting and useful - thanks.

NeilBrown


>  - callers that don't set it would fall back to the shared class (current
>    behaviour), so it's opt-in and doesn't churn existing users.
>=20
> On LOCKDEP_STATE(TP_BPF): it reads as the more general fix, but it's a
> larger change in the locking core and would need the recursion gate made
> uniform across attach types first (raw_tp currently runs despite the
> global gate). I'd lean toward starting with the per-table-key change for
> the reported false positive and treating the TP_BPF-context modelling as
> the longer-term direction -- happy to take guidance from you and the
> locking folks on scope.
>=20
> >
> > NeilBrown
> Note: Sending from an alternate address because Gmail is
> temporarily rejecting my mailing-list replies.
> Thanks,
> quanyeyang
>=20

