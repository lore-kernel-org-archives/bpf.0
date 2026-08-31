Received: from mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A936E47E
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209035; cv=none; b=qlLcpDuHTsalj+UkMlQcLeHDTIBVESYTnH7lhjRy5p3hgPuXXdNCB+JiFXsmANxYxB2BXpLqgsrEfllEG1mn+mQoH7xWdA6gQ0f8/VHfvALQspo/t4qYlHRGgBfH6bqxMe6zM+hdVa5kkICHlKmkTrbKY2gJ157p7xL+02pzdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209035; c=relaxed/simple;
	bh=wwKpRyXVbXYSGen/QQh+EayThGG0Aiexvg75pCVSLzY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FZ9wmKBAHlJ3Ja1Lef+zQNCUwGuAjppCAbOpaNkq4IsK4lk9m1DVtEjc56qiWIUJUnDWmTlEniPwhe7LS4XEmgM9nzDDimWKrbbtorTWvFN7+z7lgOEvtnV9ZhyfRSSxBp/uvdCwlBwA4uA7VvNh5WtEWdIn99maSckBQD5inZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mENqxQMX; arc=none smtp.client-ip=91.218.175.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mENqxQMX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wwKpRyXVbXYSGen/QQh+EayThGG0Aiexvg75pCVSLzY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788209030; v=1; x=1788813830;
 b=mENqxQMX7SwajIXCabQWXDr4L+q/iuOVY2NpyjNTGd6Sp2H+h9/sWpL643Jy5J0xf8m5ZMjX
 TC7X+iat5NK3CqDZkjZXNm0kIvfXu7XviRI5DtiyDURRSNeyZooyaz0P+CS/PNehNQQYl2FtueC
 i6TDswMnV8j8il7yPXxOayVY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3fedfae76e00b1b5;
	Mon, 31 Aug 2026 20:43:40 +0000
X-Mizu-Trace-ID: 3fedfae76e00b1b5
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 20:43:39 +0000
Message-Id: <DL3F6YTBCK35.3I96GFRVMKE2P@linux.dev>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "John Fastabend" <john.fastabend@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Jose Fernandez" <jose.fernandez@linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
From: "Florent Revest" <florent.revest@linux.dev>
To: "Jiri Olsa" <olsajiri@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <apWuYPCVCvBeaCKr@krava>
In-Reply-To: <apWuYPCVCvBeaCKr@krava>

On Mon Aug 31, 2026 at 4:40 PM UTC, Jiri Olsa wrote:
> On Wed, Aug 19, 2026 at 12:22:50PM +0000, Florent Revest (Anthropic) wrot=
e:
> > bpf_tramp_image_put() makes sure a trampoline image is not freed while
> > a task may still be running in it (call_rcu_tasks() + im->pcref), but
> > nothing similar is done for the progs called by that image. Since
> > commit e21aa341785c ("bpf: Fix fexit trampoline."), detach patches the
> > return path so that a task still in the original function skips the
> > fexit progs when it comes back, and counts on the prog's own RCU flavor
> > to cover a task that is inside a prog. On that basis the last prog
> > reference is dropped right away and the prog is freed after a single
> > RCU / RCU tasks trace grace period.
> >=20
> > That leaves out a task in the trampoline glue itself: between two
> > progs, or already past the patched jump but not yet in the first fexit
> > prog's enter helper. On !PREEMPT kernels this is a few instructions
> > that cannot be preempted, so it did not matter. With CONFIG_PREEMPTION
> > a task can sit there, in no RCU read section of any flavor and holding
> > only im->pcref, for longer than it takes to free the prog it is about
> > to call:
> >=20
> >   CPU 0                               CPU 1
> >   in image I, orig_call() returned
> >   [preempted before lsm.s prog A]
> >                                       bpf_tracing_link_release()
> >                                        -> bpf_tramp_image_put(I)
> >                                       bpf_link_dealloc()
> >                                        bpf_prog_put(A), last ref
> >                                       tasks trace GP, A's text freed
> >   __bpf_prog_enter_sleepable(A)
> >   call A->bpf_func
>
> hi,
> do you have a selftest or another reproducer for this?

I originally only reproduced that with a stress test (an attach/detach
loop during an exec storm).

But actually, preemption isn't needed! If a task sleeps in a sleepable
prog and the prog that runs after it in the same image gets detached,
it calls the freed prog when it wakes up. That case could be made
deterministic with userfaultfd so I could write a selftest for it.
I'll include it in v2. :)
