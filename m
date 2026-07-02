Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993C1A238F;
	Thu,  2 Jul 2026 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782954099; cv=none; b=m6TqTpDp8olaVkVNUGgoIT7uf8a+mekrpnGlBd+n8J5MfhzjqHBAwMW5FlNJ/QdbpT5nc9iTN98WvrHI0Pp/1O+pnASlwQqCzuDT3bh+2FSjmy3dhyFhuGANVEJha04RlQl+xvVjJ7RUEYoV287dEn5W8EhZAv+F3EyKYieS4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782954099; c=relaxed/simple;
	bh=2VzturC/c4skV+avPc/SB6ywVaF3W7c7NKhH9qBMqWE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rLQg9fSOtkTYoJT/88mEduoT8ba//yy2L9npmoKkyrX8JA4Ruy073hJwKvL8zI5N/MKUxqN1tErGk+/2HoQgT2vSkx7IGJsy/D51cvhvfQX4wEG3mmdTcqGnwkVcZFK5/OeV1AlpR/zI+LshIZanfFxa+HUhk2JQxcauVXJVZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0Ze2QTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0Ze2QTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C6F1F000E9;
	Thu,  2 Jul 2026 01:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782954098;
	bh=ILde+frhhB5uO+MBrgCouaBx95T0R/N8xkp6PfSyV5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d0Ze2QTKE+w3oluCsEvtNQvdlWnc/76+U2kraVYXsH7XH4WQSSQE5TuFTVDvp7JMU
	 bfwGSc58WSl81KfMmRP6vOa2DIzu4g+NnAe/69grRt6BuijEX48SRBNjS+Q4hzfrMw
	 smL0wD4NxgbJIGwuHSPAWHesGn5vpzaMtta8HmU1PLmEHy6tSfE6OmOEs+KhBN3MFf
	 +y4nFUbXXVnGssDOE0oRNFdDaWSml72Xg7xqagwEj35mgNaD70MecpwUbX/o9DBy5t
	 x6pay2qbagBCWWk9Z3LPfA8ZHFez2ZSlFI4JIVw2MJ3b7Jn0ag9PKTcs38LXsp950Y
	 87PyY8QtWiTTg==
Date: Thu, 2 Jul 2026 10:01:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
Message-Id: <20260702100135.628a264b6314c701974aaa59@kernel.org>
In-Reply-To: <CAADnVQLUniyTM64gHrLzgjWiNZTB82tT0LCxh8D29YfXG7cZ6w@mail.gmail.com>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
	<178291354144.1566898.14374948740441958770.stgit@devnote2>
	<DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
	<20260702074007.e1047c9d66cbcecc7d4ab3a9@kernel.org>
	<CAADnVQLUniyTM64gHrLzgjWiNZTB82tT0LCxh8D29YfXG7cZ6w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 1 Jul 2026 17:01:01 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Jul 1, 2026 at 3:40 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 01 Jul 2026 11:41:26 -0700
> > "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
> >
> > >
> > > Nack.
> > > I really don't like it.
> > > There were days in the past when the kernel generating bpf directly was appealing.
> > > These days are gone. Performance improvements for fetchargs is not a good reason
> > > to add all this complexity and bypass verifier checks.
> > > bpf insns should come from user space.
> >
> > Thanks for your comment!
> > OK, I don't mind because this is a kind of investigation project. And some
> > people had asked me about the same idea, now I can tell them the result.
> >
> > I'm satisfied with the current outcome, as this development process gave me
> > insight into the implementation of BPF and demonstrated the potential for
> > optimization via JIT. :)
> >
> > And also, as noted in the cover letter, the current performance of fetcharg
> > is better than I thought, and is good enough for debugging. :)
> >
> > BTW, I'm also interested in calling the verifier on this generated code.
> > Even it it is not merged, I think showing the correct way to implement it
> > will be useful in the future.
> 
> The whole feature you're trying to do is imo reinvention of the wheel.
> bpf could do that kind of filtering years ago.
> I don't buy the excuse that embedded environments without any
> kind of user space needs this facility.
> 

Yeah, I understood it. I have no intention to merge this series.
This is totally just for fun and my interest about BPF.

But thanks for your comments. It is good to hear your thought in the RFC
stage. I can stop this series here with peace of mind. :)

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
