Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009D3ACF1B;
	Tue,  4 Aug 2026 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832483; cv=none; b=SS7toyfY2fHaXutkvsFNoaRPat0V4RW4oXpcujHmWt/5ZETVqouEc4WWHh61uBBs3ylUGBthykIDJrY/c2zLcklhBssHQ6EuIeBts7S/mcmB2OMcKkk1xRvvdZwqZCwAUMs6LXXokePjMhEEDChSxrKQO3D5kcYDp0x1f6sdPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832483; c=relaxed/simple;
	bh=DdbThYyZ2i6JH1+5AIH3mKL2IbrXS7NtuPr41q3PA54=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JR43lMub9DRU4q1HZHqOXK5DiJoucZ9sWuVdolOHbF+qa6wdYNjI4Ac8KEpY7IY4DaPwT50jgiLumtpHnzDPEU35IJkmJUOFEtBvF0UmKQ+rqJh7NvKUp3jB6/5nMGTA87LIoofCrrz3Vx/sbj2jvmUX/sPwvVe5V3Wocn+Pf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Tr3rnLkJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WBFEQjMN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Tr3rnLkJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WBFEQjMN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12FBA14000E7;
	Tue,  4 Aug 2026 04:34:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 04 Aug 2026 04:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1785832480; x=1785918880; bh=7BxvSjhMK85+4Xb9r01RGNTOzA3NYt3+/ae
	bNQUgKmM=; b=Tr3rnLkJcZUpGf/fdbCjyVeUNkH07umSQhhXUYuVv1fQdgkGCId
	wvaCnxdTMnfh/P/5vvYQkpye419tCYHjTp/FsW6+aGENy1xV6eq/7ACCh3JIEOTv
	uisi42rvtO1M3D1tKDubzmr74DXFnIzm7wnJObHdBovbFK3lZJibE5s9JnKwsnsZ
	8+6WFSceGKQa6Y8Qlb++aM06HaxBN4JR2yKelHS9RpT23y26TkiYwp6tRQxzHkzz
	oxilPCpBbWYBOpO3CytpSZEWBSJTcXJYXk6nVgBTz5i6CUdKJGVVquTA8nHuoKeo
	0/uNImakdeVmuRkGAAewcvuI9EmMmxc+/rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785832480; x=
	1785918880; bh=7BxvSjhMK85+4Xb9r01RGNTOzA3NYt3+/aebNQUgKmM=; b=W
	BFEQjMN1IqjfRwK46833kw27tzNTcL+P/19qiKZSr1UMGVOlXhg5gOKxFJQH9bxO
	XLSf3JPSd8/izBvQtFrfu1Z2gAIi1x9ktf8LUJu1nKDYVb5cFvaLCws/oJXga1Fk
	pwzB5u8ptD2OARAPn1nQEx8tP64WzUt9pLTdhYMAEQ+8nuEXzDzea0JghF3Azswj
	C0M0OwdZEs1wkoG+WCvyuqsdq3LXx/LT007m0oDzTmNIsAbAsgwST52/ETn2Gglr
	A0g1nhyhSz2rXQ2lLF8+cG8bIhJCy2zVmCqRsquSVN5WMlAHL87kqukjlT8N+NGR
	fIIffz4aXH/3aCaR1Iylg==
X-ME-Sender: <xms:H6Rxai6TTBFaPKfUm9u8Gd8vKpqwpuA6uwEUpyF3-TGZn-K4UUv_6w>
    <xme:H6RxasXFqtdxj3rnn4-swspVe7FWbxuTfuZmxxUsDmAuLDI_gdyYD90fkWOU32qYD
    LPqjdHlqEDfJqj5SFKaEBypxIJll2VBkiQVJO5FdUgw7mG0vek>
X-ME-Received: <xmr:H6Rxam52vz2IF13J5HWnLSHaBJyKyicO3Yd8Wa1FZ9oFQQyQ-f-ijVPJtqUGHNsNUTefQ3Z-v15dcUwhszCjRM9Gwm630-g>
X-ME-Proxy-Cause: dmFkZTGI1g8LdolwyzY6xjC2vOf+x7wIUGotHkjulajyJ8r8e+2Io6Ax3XKf6Sa/RG/Ign
    bIUZuicoy7Ypld/mWUMhJg5DpOjYm0A9h2sth9m4IJD67P21ve3rlWFDcBqksUGCRcbO1a
    KYWiqv68HYNfSnnXxBiTo28K4GofBlk8bA2liPUcn2KhhoQXGDJsnEdo0XJuuvRns1EiDI
    KjK7sBvsOG/cLbqYznIw5wQhvmyH3COQ/+q+dtT9vDosuF3QrUuuy2hLfI4vcHAz0K53zw
    VFd+1Gsv5jb7enttyfgZ6i72UAVHc2B0evDGqo4/F0KTFW5L0UhqLx35G0fVdG2f01DGgU
    CxATUaaNOo8oDdjG9v0lp+ZSYPUMPv1VVqk9vMgUpISUaWC1sGBzlThsxTmqzuTPty9Zpv
    h33bajXGe6u8d+OadQlC3ntWuxmrNKCtTq/7XyEHkj5y8wwwdD48xzXcFoo2D4oRJ3U5Fy
    32dt9QXaZLe7T6/Q43VIOqxxHCHalUR7FRXCwobf4eW0ocxhF4gXpi+V0ZQw1OJSUwj+Jg
    Jry7SpyuPln8bQlnSmrZJQys/gYVnW+zejB3j+y7bKeBABlVcROA3GsIp1ir2KlCrQ+WhX
    ACl5PliDwQwcEdnSpYtln1CLVIBc0DdQmdLSL4SkowWhTj/q3eWkWbGMISiQ
X-ME-Proxy: <xmx:H6RxatGXjPbQA7HRQvTEIgWBUDP9NbO08wteuW7ZDQ0C9BBUT3ULCA>
    <xmx:H6Rxap_ipXSPX-ZvV4trK4i3YoTtrazQ4B7Of7oR0JwV0FLpI3uOGg>
    <xmx:H6RxavVemZZG0YzMWG5fZT1DFo_OjH9vKEO9gNpAuCioJ3McNKTCTw>
    <xmx:H6RxarFxO1GQhzHisxjuSw_n2jn8Fl0e4ikjPHaRyESZApkih5VmUQ>
    <xmx:IKRxaqC3coV78FYJIz9UFaBN720ujdpasTHMdOw3jGS6JVWU5y1bwyiD>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:34:31 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: quanyemostima@gmail.com, "Steven Rostedt" <rostedt@goodmis.org>,
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
Subject: Re: [PATCH] bpf: disable lockdep while running BPF on lock_release
In-reply-to: <anEuaSqiCVsQ6I4P@zenbox>
References:
 <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
  <anEuaSqiCVsQ6I4P@zenbox>
Date: Tue, 04 Aug 2026 18:34:26 +1000
Message-id: <178583246611.3252194.4318729338489544399@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Aug 2026, Justin Suess wrote:
> On Mon, Aug 03, 2026 at 06:37:45PM +0800, quanyeyang via B4 Relay wrote:
> > From: quanyeyang <quanyemostima@gmail.com>
> >=20
> > trace_lock_release() runs before __lock_release(), so the lock is
> > still on the held stack when attached BPF programs execute.  If those
> > programs take another lock of the same class, lockdep reports a false
> > recursive locking warning.
> >=20
> > Mark lock_release with TRACE_EVENT_FL_BPF_NO_LOCKDEP and temporarily
> > disable lockdep around bpf_prog_run_array() for that event.
> >=20
> > Fixes: 149212f07856 ("rhashtable: add lockdep tracking to bucket bit-spin=
-locks.")
> > Reported-by: syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Def8d17bae14efb960935
> > Assisted-by: Cursor:GPT-5.6 Sol
> > Signed-off-by: quanyeyang <quanyemostima@gmail.com>
> > ---
> > Hi,
> >=20
> > Small RFC to align on the approach before widening scope. This is the
> > alternative to the rhashtable per-init-site lock-class patch [1], taking
> > the direction NeilBrown floated in that thread [2].
> >=20
> > The problem: trace_lock_release() runs before __lock_release(), so the
> > lock is still on lockdep's held stack when an attached BPF program runs.
> > If that program takes another lock whose class collides with a held
> > lock, lockdep reports a false "possible recursive locking".
> >=20
> > syzbot hits this via pidfs + a BPF hash map, because all rhashtable
> > bucket locks share one lock_class:
> >=20
> >   copy_process -> alloc_pid -> pidfs_add_pid   [pidfs bucket bitlock held]
> >     lock_release tracepoint
> >       trace_call_bpf -> bpf_prog_run_array
> >         rhtab_map_delete_elem -> rhashtable_remove_fast -> rht_lock
> >           [same "rhashtable_bucket" class -> false recursion]
> >=20
> > Why I pivoted from the per-class rhashtable fix: NeilBrown argued (a)
> > sharing one lock_class across instances is common practice (d_lock,
> > bd_holder_lock, kobject list_lock), and (b) BPF on lock_release() can
> > perturb lockdep for *any* lock the program takes, not only rhashtable
> > [2]. Disabling lockdep around the BPF handler addresses that broader
> > surface, not just rhashtable.
> >=20
> > On the concern that this hides real lock-order bugs: BPF programs are
> > user-supplied, sandboxed code; their internal lock ordering is not part
> > of the kernel's lock contract, and lockdep cannot validate it
>=20
> BPF programs are not sandboxed. If a BPF program is able to break the
> kernels locking semantics and trigger a true, non-recoverable deadlock
> like this, that's a bug in the kernel.

I know close enough to nothing about BPF or trace points...

Can BPF programs ever block waiting for a lock that is held across a
tracepoint?
If so, then attaching a BPF program to that trace point could
trivially cause a deadlock.
If not - then how is that ensured?

Thanks,
NeilBrown


>=20
> > meaningfully -- here it only produces a false positive.
> >
> This doesn't seem like the correct fix. And I'd argue it's a true
> positive.
>=20
> What happens if the cpu gets interrupted while lockdep is disabled?
>=20
> Then we become blind to any other locking issues happening in whatever
> NMI context we got plopped into because we disabled lockdep here.
>=20
> It seems more prudent to fix this in rhashtable.
>=20
> Like what 20b6cc34ea74 ("bpf: Avoid hashtab deadlock with map_locked") did
> for hashtab and the subsequent move to rqspinlock did. Basically make
> the implementation tolerant to temporary recursive deadlocks like this
> by detecting it and returning an error.
>=20
> Which is going to be a bit more of an endevour than is done in this
> patch.
>=20
> Justin
> > Scope of this patch (deliberately minimal):
> >   - only lock_release is tagged;
> >   - only the perf-event attach path (trace_call_bpf) is covered.
> >=20
> > Open questions I'd like to align on before doing more:
> >   - lock_acquire can produce a (different, ABBA-shaped) false positive
> >     by the same mechanism -- tag it too?
> >   - raw_tracepoint attaches go through __bpf_trace_run and are not
> >     covered -- extend there too?
> >   - flag vs always-off: should trace_call_bpf disable lockdep for all
> >     BPF programs? The flag keeps blast radius small, but the rationale
> >     applies generally.
> >=20
> > This fixes the reported syzbot path (perf-event attach to lock_release).
> >=20
> > [1]  https://lore.kernel.org/all/20260801-fix-rhashtable-bucket-lockdep-v=
1-1-15a0f8ae094c@gmail.com/
> > [2]  https://lore.kernel.org/r/178572243204.3252194.4367547703856027885@n=
oble.neil.brown.name
> > ---
> >  include/linux/trace_events.h | 3 +++
> >  include/trace/events/lock.h  | 2 ++
> >  kernel/trace/bpf_trace.c     | 6 ++++++
> >  3 files changed, 11 insertions(+)
> >=20
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 308c76b57d13..6f67b5e9e38d 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -330,6 +330,7 @@ enum {
> >  	TRACE_EVENT_FL_FPROBE_BIT,
> >  	TRACE_EVENT_FL_CUSTOM_BIT,
> >  	TRACE_EVENT_FL_TEST_STR_BIT,
> > +	TRACE_EVENT_FL_BPF_NO_LOCKDEP_BIT,
> >  };
> > =20
> >  /*
> > @@ -347,6 +348,7 @@ enum {
> >   *                   This is set when the custom event has not been atta=
ched
> >   *                   to a tracepoint yet, then it is cleared when it is.
> >   *  TEST_STR      - The event has a "%s" that points to a string outside=
 the event
> > + *  BPF_NO_LOCKDEP - Disable lockdep while running attached BPF programs
> >   */
> >  enum {
> >  	TRACE_EVENT_FL_CAP_ANY		=3D (1 << TRACE_EVENT_FL_CAP_ANY_BIT),
> > @@ -360,6 +362,7 @@ enum {
> >  	TRACE_EVENT_FL_FPROBE		=3D (1 << TRACE_EVENT_FL_FPROBE_BIT),
> >  	TRACE_EVENT_FL_CUSTOM		=3D (1 << TRACE_EVENT_FL_CUSTOM_BIT),
> >  	TRACE_EVENT_FL_TEST_STR		=3D (1 << TRACE_EVENT_FL_TEST_STR_BIT),
> > +	TRACE_EVENT_FL_BPF_NO_LOCKDEP	=3D (1 << TRACE_EVENT_FL_BPF_NO_LOCKDEP_B=
IT),
> >  };
> > =20
> >  #define TRACE_EVENT_FL_UKPROBE (TRACE_EVENT_FL_KPROBE | TRACE_EVENT_FL_U=
PROBE)
> > diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> > index 1ded869cd619..5ccf5c54e3d2 100644
> > --- a/include/trace/events/lock.h
> > +++ b/include/trace/events/lock.h
> > @@ -72,6 +72,8 @@ DEFINE_EVENT(lock, lock_release,
> >  	TP_ARGS(lock, ip)
> >  );
> > =20
> > +TRACE_EVENT_FLAGS(lock_release, TRACE_EVENT_FL_BPF_NO_LOCKDEP);
> > +
> >  #ifdef CONFIG_LOCK_STAT
> > =20
> >  DEFINE_EVENT(lock, lock_contended,
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 75495a5c3507..f2460f3c860e 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/key.h>
> >  #include <linux/namei.h>
> >  #include <linux/file.h>
> > +#include <linux/lockdep.h>
> > =20
> >  #include <net/bpf_sk_storage.h>
> > =20
> > @@ -110,6 +111,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_c=
tx *ctx);
> >   */
> >  unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
> >  {
> > +	bool no_lockdep =3D call->flags & TRACE_EVENT_FL_BPF_NO_LOCKDEP;
> >  	unsigned int ret;
> > =20
> >  	cant_sleep();
> > @@ -144,8 +146,12 @@ unsigned int trace_call_bpf(struct trace_event_call =
*call, void *ctx)
> >  	 * rcu_dereference() which is accepted risk.
> >  	 */
> >  	rcu_read_lock();
> > +	if (no_lockdep)
> > +		lockdep_off();
> >  	ret =3D bpf_prog_run_array(rcu_dereference(call->prog_array),
> >  				 ctx, bpf_prog_run);
> > +	if (no_lockdep)
> > +		lockdep_on();
> >  	rcu_read_unlock();
> > =20
> >   out:
> >=20
> > ---
> > base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> > change-id: 20260803-fix-lock-tracepoint-bpf-lockdep-f93e32ea6346
> >=20
> > Best regards,
> > -- =20
> > quanyeyang <quanyemostima@gmail.com>
> >=20
> >=20
>=20
>=20

