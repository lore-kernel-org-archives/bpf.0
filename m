Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3404519AE
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788391550; cv=none; b=GERySBuVjC09NlM/VOQ2V6WMEqxmmm6/xwF/S2zfyxvGFMjhz9X25WYWZgrtfGNmFOLXYTDifUEQ7QsmPHW0PNI8RhgouIZxCfjGkNFUSTkStb7lYzXrKrGSddK18dYiOoSI5ZirmgnHxd7qprr2kBmIvjA7RUeepHMvbITzEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788391550; c=relaxed/simple;
	bh=lALBiyAX64XwR3a8XgXGZNugf5c3rTzNcg8R24EuTH0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=L+374W1Nr1ZG1a3fd8a7yf0zvpdn9yPyFxSZPP8802fbAyu5mMAo09b3f6Fkqbv1J3omSod+z1zNlOcS4gLuOt+MY0BoWkE12SsbhjEBruEz23Qmx7Y5/id/kbO1+Od6WtOcV55k/0JiftHDEd0Dj8hUlk/OzC0PXya0c2SCwHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O+z7zh9+; arc=none smtp.client-ip=91.218.175.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O+z7zh9+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lALBiyAX64XwR3a8XgXGZNugf5c3rTzNcg8R24EuTH0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788391545; v=1; x=1788996345;
 b=O+z7zh9+qD/nCAh7rDFYSQWZH6p81jRPFuR++PhfhEkbfJ6WHjPAWn6s7sQWYhCVg8dK0WEm
 soLtuFOOMhpuXcQur0G/klNul5MmWPPCQiS+jyNJ/lQ0PCAD0ZYbyI5uhCTdIIQi75kDXI1h+TM
 sqwY8KeDeGL3eJyloijQ0FCc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c72107b5a07b5213;
	Wed, 02 Sep 2026 23:25:35 +0000
X-Mizu-Trace-ID: c72107b5a07b5213
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 23:25:35 +0000
Message-Id: <DL57W17T3VEC.1EJMWXYOB7JFU@linux.dev>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Jose Fernandez" <jose.fernandez@linux.dev>, "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
From: "Florent Revest" <florent.revest@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com>
 <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>
 <DL2S878KSOI5.1SZMLIAWMCNUJ@gmail.com>
 <DL3FIBQNP6AU.1HO08FMI292UX@linux.dev>
 <CAADnVQLMm43qJxuiHUuuh51wAL4kH0+fRoaM7YfbZEXT7LHn0A@mail.gmail.com>
 <DL4R2YXF9J8G.203VBANYFFSET@linux.dev>
 <CAADnVQJ+OJKmgaDM9B58g30M_-pkZgGmbDuvEWmrg8U_ZkxbSg@mail.gmail.com>
In-Reply-To: <CAADnVQJ+OJKmgaDM9B58g30M_-pkZgGmbDuvEWmrg8U_ZkxbSg@mail.gmail.com>

On Wed Sep 2, 2026 at 10:06 PM UTC, Alexei Starovoitov wrote:
> On Wed, Sep 2, 2026 at 3:15=E2=80=AFAM Florent Revest <florent.revest@lin=
ux.dev> wrote:
> >
> > On Wed Sep 2, 2026 at 5:57 AM UTC, Alexei Starovoitov wrote:
> > > On Mon, Aug 31, 2026 at 1:58=E2=80=AFPM Florent Revest <florent.reves=
t@linux.dev> wrote:
> > > >
> > > > How about having old trampolines skip freed programs instead of kee=
ping
> > > > them alive ?
> > >
> > > Isn't it doing it now?
> > > That was the whole point of patching nop to jmp in a trampoline.
> >
> > Just to be sure we're talking about the same thing, you're referring to=
 the
> > "ip_after_call" patching done in bpf_tramp_image_put, right ?
> >
> > My understanding is that this only helps in the case where a task is in=
 the
> > traced function while a prog is detached. It'd make it skip all fexit p=
rogs.
>
> Right. That's the one I meant.
>
> > But if a task is sleeping in a fexit.s prog for example, it is already =
past
> > ip_after_call, so this patching would not prevent it from calling a sec=
ond,
> > freed, fexit prog lined up after it in the trampoline, no ? The same si=
tuation
> > should happen with a sleeping fentry.s prog followed by a fentry prog.
>
> Hmm. You mean like fexit prog A called a sleepable kfunc and
> another prog B is attached to the same trampoline.
>
> Then the trampoline needs to be freed. ip_after_call patches jmp in,
> and trampoline proceeds to free progs A and B.
> B is freed right away.
> Eventually A's kfunc returns from sleep
> and jmps back into a trampoline
> which is not freed yet, since percpu_ref keeps it,
> but prog B is gone, so it attempts to execute a freed prog B ?

Yep, exactly!

> > I have a reproducer for those scenarios that crashes bpf-next. I will m=
ake it a
> > selftest in v2 like Jiri suggested.
>
> Please narrow down the reproducer (sounds like it's a random stress test
> at this point) to specific steps.
>
> If my guess above is correct the reproducer will be short
> and deterministic.

Indeed. When I originally sent this patch my repro was a stress test but wh=
en I
found out about the above scenario I could make a short and deterministic r=
epro

My only question then is, what kind of fix would you prefer in v2: keeping =
refs
to progs while the trampoline is alive ? (like in this v1, but I think you
nacked this approach already ?) or some other creative solution like having
__bpf_prog_enter*() skip each freed prog individually ? Or maybe something
else ?
