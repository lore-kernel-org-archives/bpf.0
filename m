Received: from mta0.migadu.com (out-167.mta0.migadu.com [91.218.175.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DA37B014
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210429; cv=none; b=mL3T6CLnK1COpGrPdceEn+y18Brco/RI2N64jfpWBZ1nNK4IeDdWvhSOfK/VEyVT2YYtCEVqAUPWDvAA2uyZZBIqKb4F1O2GyVuizEvIWd+Yq5GImn8lKfNGr+J+dzLpxzgKpTMQSpUl89WbWiap8QcN5UQBhJpjHQ4LxNg0laA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210429; c=relaxed/simple;
	bh=uCN0Bv49tEpsDwtHVqN/ZeTuCSUIaYXefe+4PzDgkXw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nQBkiltiGfYPbkR05/9TkGQb45xEYQcwUeXcj12f42219p2/KiK5x9SYpROgFn9J6eeKa1eQa+EuMz4SrFwhq/V9We2/1iyJBEh+WJG+wUlXSxhHuy20KNhh6zUde3OpxTZy9DJVqVFu26aC9CAvjoJAFahDCz5u1idQwehjnxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2E2dZ79; arc=none smtp.client-ip=91.218.175.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2E2dZ79"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uCN0Bv49tEpsDwtHVqN/ZeTuCSUIaYXefe+4PzDgkXw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788210425; v=1; x=1788815225;
 b=q2E2dZ79nKF37EohtHcsw5bA4Svf7Y/I1Pvh7FbhnQCnrgCe9Ojfjno6NhY+4uc8LMtm2nHC
 AhzdEHWnc5/gQhb2nr9bVW9vP5wGTH+ubHk/QigGb+gTvN89CVXt/DeTOfQGVdrUereWMJRgMtI
 ifQXWQxeeQZMfl3HTxQI/5UE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 27bc9bbab941bf81;
	Mon, 31 Aug 2026 21:07:05 +0000
X-Mizu-Trace-ID: 27bc9bbab941bf81
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 21:07:04 +0000
Message-Id: <DL3FOW820JBZ.3W4I50CXVBTI8@linux.dev>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Jose
 Fernandez" <jose.fernandez@linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
From: "Florent Revest" <florent.revest@linux.dev>
To: "Junseo Lim" <zirajs7@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <aocadTp5OaOybxzT@omen-arch>
 <bc0edb11e07e0f6147e9c552805d0029c7aec7fc@linux.dev>
 <aogAKH0PEmuOa--X@omen-arch>
In-Reply-To: <aogAKH0PEmuOa--X@omen-arch>

On Fri Aug 21, 2026 at 7:58 AM UTC, Junseo Lim wrote:
> On Thu, Aug 20, 2026 at 04:06:30PM +0000, florent.revest@linux.dev wrote:
> > 20 ao=C3=BBt 2026 =C3=A0 17:26 "Junseo Lim" <zirajs7@gmail.com mailto:z=
irajs7@gmail.com?to=3D%22Junseo%20Lim%22%20%3Czirajs7%40gmail.com%3E > a =
=C3=A9crit:
> >=20
> > >=20
> > > On Wed, Aug 19, 2026 at 12:22:50PM +0000, Florent Revest (Anthropic) =
wrote:
> > >=20
> > > >=20
> > > > bpf_tramp_image_put() makes sure a trampoline image is not freed wh=
ile
> > > >  a task may still be running in it (call_rcu_tasks() + im->pcref), =
but
> > > >  nothing similar is done for the progs called by that image. Since
> > > >  commit e21aa341785c ("bpf: Fix fexit trampoline."), detach patches=
 the
> > > >  return path so that a task still in the original function skips th=
e
> > > >  fexit progs when it comes back, and counts on the prog's own RCU f=
lavor
> > > >  to cover a task that is inside a prog. On that basis the last prog
> > > >  reference is dropped right away and the prog is freed after a sing=
le
> > > >  RCU / RCU tasks trace grace period.
> > > >=20
> > > >  [...]=20
> > > > =20
> > > >  Fix it by having the image take a reference on every prog it calls=
, in
> > > >  bpf_tramp_image_alloc(), and drop them in bpf_tramp_image_free(). =
A
> > > >  detached prog now stays loaded until the old image is gone, which
> > > >  reverts a deliberate choice of commit e21aa341785c ("bpf: Fix fexi=
t
> > > >  trampoline."). Detached fexit progs still stop being called right =
away
> > > >  since the return path is patched.
> > > >=20
> > > This appears to be the same issue addressed by my earlier patch [1].
> > >=20
> > > I think the flexible-array approach here is cleaner, so I'm fine with=
 this
> > > version going forward. Could you please carry the original Reported-b=
y tag?
> > >=20
> > > Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
> > >=20
> > > [1] https://lore.kernel.org/bpf/20260815071927.147049-1-zirajs7@gmail=
.com/T/
> > >=20
> > Oh wow, sorry, I had no idea we raced on this!
> >=20
> > I also like the idea of guarding this with CONFIG_PREEMPTION and of
> > course=C2=A0I don't mind adding your Reported-by tag in a v2. I'll give=
 a bit
> > of=C2=A0time for others to chime in first.
>
> Just in case it helps with the CONFIG_PREEMPTION angle: Sashiko pointed o=
ut
> on my patch that a CONFIG_PREEMPTION guard would leave the unlink/update
> failure path uncovered on CONFIG_PREEMPTION=3Dn.
>
> So your unconditional version looks right to me.

Actually, the #ifdef CONFIG_PREEMPT guard wouldn't have been enough
anyway. :/ Preemption was one easy way to cause that bug but if a task
sleeps in a sleepable prog and the prog that runs after it in the same
image is detached and freed, the same problem would happen. That could
also happen on PREEMPT_NONE.

But I'll keep your Reported-by in a v2 yep!
