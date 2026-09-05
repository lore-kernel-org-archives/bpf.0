Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22D264F80;
	Sat,  5 Sep 2026 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567413; cv=none; b=A+NG/ljkQBIMTCIhfw939O8AfGv+N/tSCiWyZGm7+EEWc3BkZ65TkBng/7TN6S+TXf73BRZxNybNXDYgf+DZEpoAH7JzYLN6GQsNGsWzY+AsbcAzKhyIPSDFndEtGaIMRzeuZObD+qOvQI1BQI6jaifgeK1R1nvp0aCk9So1H/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567413; c=relaxed/simple;
	bh=pLv+2SyjfZxcPWRztrF/sBkUPU9/iQ3eNSWoQGAxTWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVifPp1poM835/mmhNEtyzukqsbN9mQFuy1iQYN0CkY6ES5OsdVN6LgJ48DGpLfDbVsJ60GUeI/av1RoXyD6zjEC4EESFk7JiPTKyrReQMQTDXPfn9/gjkZAGMjAl3SHgXullaTWVAv5MJGIEI7jn0SaON0r9rxzzi6N/LM/244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=pPxg2SXJ; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="pPxg2SXJ"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 61914A0244;
	Sat,  5 Sep 2026 00:16:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 5020E2002D;
	Sat,  5 Sep 2026 00:16:40 +0000 (UTC)
Date: Fri, 4 Sep 2026 20:17:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
Message-ID: <20260904201741.2986efca@gandalf.local.home>
In-Reply-To: <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	<87se3sakgi.fsf@yellow.woof>
	<df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
	<DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
	<eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
	<20260903090211.50d15220@gandalf.local.home>
	<CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
	<20260904074317.01b2c0e1@robin>
	<DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
	<20260904123108.1fa1d815@gandalf.local.home>
	<20260904132421.111c0279@gandalf.local.home>
	<DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com>
	<20260904194620.0c7a8363@gandalf.local.home>
	<CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: z4d4bwstn79amrnd3g1qoq6mup4yp5st
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 5020E2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/qwamaypo6TbuC6tWjO86g4VqY8Tv4B4U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=pLv+2SyjfZxcPWRztrF/sBkUPU9/iQ3eNSWoQGAxTWo=; b=pPxg2SXJgwKSVPfHO6bzUa0wOT5VGiAPYSB4FLr4p/2ZFkcCkVu3AMtiCMcureTzoZAesI8Z19k47wHqs0b5159+ls666JAX3h7AWManDibbpUyceX5TejaYYIV7Ji/hPxLrPn+KWmQj6BkpzDijVq6Be1S00xZIIEiEIIYNzvI=
X-HE-Tag: 1788567400-473223
X-HE-Meta: U2FsdGVkX1+ozkwmmqAmsdWFMhF46eR524x491CUTUt6caq18LHLnZhkXdJqseZIcZ2pNTpbeXARje52YBvOcZd0cQ8Lr754fRcYQ2YfXgNX7KBOBnonsYxQna7aSv/veqlCGEP2bjdli11MnLU5QkNCNDVQSPrdpaKIhzriiMZdRxK0EBDpp6iGcPy9ijw3YYuSOu2SI4ioO5EYB274WhtHiLeYJUBE2F/rMYiRaUdvhc/MdMmgKKgORDimKBk2twVyCE6TXoxBVoIM6GGC0EAOC6ycZaN/ZmC1UHwELm7fse4+HlfAiDVui9H+J6GHgHvrZJ5XzpOD2Hr5CKclv77qatfaizKID1h9oqPneLcA2G4/14t6dstjmia9zrqrRik3E2x2YfD3tyUpleGzNw==

On Fri, 4 Sep 2026 16:48:55 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Sep 4, 2026 at 4:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Fri, 04 Sep 2026 16:34:00 -0700
> > "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
> > =20
> > > bpf in 2022 was surely less capable then it is today.
> > > It took us 2 years of bpf core development to statisfy sched-ext dema=
nds
> > > and we're still adding new features for sched-ext needs.
> > > If you're trully willing to remove 90% of kernel/trace/rv/ and refact=
or
> > > it into tiny shim where all of the core pieces are bpf driven we can
> > > certainly work together (like we did with sched-ext) and add whatever
> > > is missing on bpf side. Then all existing monitors will become bpf pr=
ograms.
> > > But adding bpf as another 'monitor', sorry but hard NO.
> > > If hardcoded monitors was a mistake then admit it and fix it by delet=
ing it,
> > > if it's not a mistake then keep adding hardcoded monitors. =20
> >
> > Regardless of whether or not BPF can replace "hardcoded monitors" today=
, it
> > wasn't a mistake back then if BPF wasn't able to do it when they were f=
irst
> > being added. sched_ext wanted to use BPF for scheduling as module plugi=
ns
> > were nack'd by the scheduler maintainers for a long time. BPF programs =
to
> > handle scheduling was the work-around to that, and basically the only w=
ay
> > forward. And it still required special hooks into the scheduler.
> >
> > The rv monitors only needed to use tracepoints for hooks. A module was =
the
> > easiest way to get there, as BPF at the time wasn't an option.
> >
> > If you want to use hostile language like "admit you made a mistake" the=
n it
> > makes it harder to collaborate. =20
>=20
> If you're offended by the word "mistake" then ok. There is no path forwar=
d.
> Keep adding hardcoded stuff.

I'm not offended by the words, I'm offended by your tone. As BPF was
insufficient when RV started, it obviously wasn't a mistake that we didn't
use it. If you are just going to say it was a mistake because we didn't
modify BPF to suite our needs (which I highly doubt you would have wanted
to help us, as you already stated that you don't care about this project),
then you are obviously biased against us.

Your response was fine until you through in that last sentence. As making a
mistake means that the other non-mistake option was viable at the item. It
wasn't.

Look, if BPF has changed so much that it could be re-evaluated to see if it
suits the needs of RV, then sure. We could look into doing that. Perhaps it
can replace the hard-coded monitors. But what we have been doing has not
been a mistake. Saying so is a bit disrespectful to the project and a
direct insult to Daniel.

-- Steve


-- Steve

