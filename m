Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1B33A708
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812802; cv=none; b=KzKPHLHCvnI7w40nrnE15oCrpGTxGtjszTCNcRjDxS2uqd6801aSlsTawCr/rXf3D5WnPt+YFG0Fmg8hPuzrHirmPANwRnCtNB7BU22YbLFUY4Gaq4rJYEiuoPya6+oSSN3sojrpelUtfMXZO1p7w3kdRcgYZOAwxLOat3vPbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812802; c=relaxed/simple;
	bh=LJRpeV/A1fxlnnZUB3wTrAHsDxAi+EZccFnu8ySHu/Y=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=QiWW7Y1bQR5UypgbryzZxmGpfiQV0MxsRQqIrExAl+HyUlHP8NMBAKRSUa+WN0eLh85pd/bNoWKqo9cpV8sy1mB9yeS2xK/IjcF5xUl5nZu34xGhEnkSlhz1kQ1B5skB7L3ykwMqKoC2WSujhAfY608+2GU+5nWUFJW+S5zgfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rwYXqi0/; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rwYXqi0/"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770812788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juP12CPu5no4sJn3GXK23Vcmd+0s4QSQdQ9JTIQubAU=;
	b=rwYXqi0/CVyLw7kczTCLZo8jyq63PuT8zrg+bMz0vGm2UFcucyrJRfSchgEzcnTLO6C/Qu
	pU9Pt8f1MhsJ+89uccS3nooe/wDXJ6bEQDheGN9jq4YRLqadf+A/HS8HwNOKvEmOv7IMZY
	8+Nwtx2YGtkH+DgQcgof2NPIwKgH9Fo=
Date: Wed, 11 Feb 2026 12:26:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <82e29f76816971cfad92167c97afb437e1996aea@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf v1] bpf: cpumap: fix race in bq_flush_to_queue on
 PREEMPT_RT
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "KP Singh" <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri
 Olsa" <jolsa@kernel.org>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, "Clark Williams" <clrkwllms@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Thomas Gleixner"
 <tglx@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260211114418.xnfx8M-t@linutronix.de>
References: <20260211064417.196401-1-jiayuan.chen@linux.dev>
 <20260211114418.xnfx8M-t@linutronix.de>
X-Migadu-Flow: FLOW_OUT

February 11, 2026 at 19:44, "Sebastian Andrzej Siewior" <bigeasy@linutron=
ix.de mailto:bigeasy@linutronix.de?to=3D%22Sebastian%20Andrzej%20Siewior%=
22%20%3Cbigeasy%40linutronix.de%3E > wrote:


>=20
>=20On 2026-02-11 14:44:16 [+0800], Jiayuan Chen wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20=20
>=20>  On PREEMPT_RT kernels, the per-CPU xdp_bulk_queue (bq) can be acce=
ssed
> >  concurrently by multiple preemptible tasks on the same CPU.
> >=20=20
>=20>  The original code assumes bq_enqueue() and __cpu_map_flush() run
> >  atomically with respect to each other on the same CPU, relying on
> >  local_bh_disable() to prevent preemption. However, on PREEMPT_RT,
> >  local_bh_disable() only calls migrate_disable() and does not disable
> >  preemption. spin_lock() also becomes a sleeping rt_mutex. Together,
> >  this allows CFS scheduling to preempt a task during bq_flush_to_queu=
e(),
> >  enabling another task on the same CPU to enter bq_enqueue() and oper=
ate
> >  on the same per-CPU bq concurrently.
> >=20
>=20=E2=80=A6
>=20
>=20>=20
>=20> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> >=20
>=20Can you reproduce this? It should not trigger with the commit above.
> It should trigger starting with
>  3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT=
_RT")


Thanks for the review, Sebastian.

You are right. The race only becomes possible after the softirq BKL is dr=
opped.

> >=20
>=20> Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
> >  Closes: https://lore.kernel.org/all/69369331.a70a0220.38f243.009d.GA=
E@google.com/T/
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >  ---
> >  kernel/bpf/cpumap.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> >  index 04171fbc39cb..7fda8421ec40 100644
> >  --- a/kernel/bpf/cpumap.c
> >  +++ b/kernel/bpf/cpumap.c
> >  @@ -714,6 +717,7 @@ const struct bpf_map_ops cpu_map_ops =3D {
> >  .map_redirect =3D cpu_map_redirect,
> >  };
> >=20=20
>=20>  +/* Caller must hold bq->bq_lock */
> >=20
>=20If this information is important please use lockdep_assert_held() in =
the
> function below. This can be used by lockdep and is understood by humans
> while the comment is only visible to humans.


Will add lockdep_assert_held() in bq_flush_to_queue() and drop the
comment.

> >=20
>=20> static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
> >  {
> >  struct bpf_cpu_map_entry *rcpu =3D bq->obj;
> >  @@ -750,10 +754,16 @@ static void bq_flush_to_queue(struct xdp_bulk_=
queue *bq)
> >=20=20
>=20>  /* Runs under RCU-read-side, plus in softirq under NAPI protection=
.
> >  * Thus, safe percpu variable access.
> >=20
>=20+ PREEMPT_RT relies on local_lock_nested_bh().
>=20
>=20>=20
>=20> + *
> >  + * On PREEMPT_RT, local_bh_disable() does not disable preemption,
> >  + * so we use local_lock to serialize access to the per-CPU bq.
> >  */
> >  static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_fr=
ame *xdpf)
> >  {
> >  - struct xdp_bulk_queue *bq =3D this_cpu_ptr(rcpu->bulkq);
> >  + struct xdp_bulk_queue *bq;
> >  +
> >  + local_lock(&rcpu->bulkq->bq_lock);
> >=20
>=20local_lock_nested_bh() & the matching unlock here and in the other
> places, please.


Makes sense. Since these paths already run under local_bh_disable(),
local_lock_nested_bh() is the correct primitive.

> Sebastian
>
