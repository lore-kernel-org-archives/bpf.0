Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA5436359;
	Tue, 20 Jan 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920651; cv=none; b=DiTaPbT0YKX3hVZQLYEjzM11IKwiIwSIlcs5P4dJcSDv+6zIeMRL8EPlZTJx10blwjQ1RiVWF6O/H6Rnz1fOJ3DgCMnqwJ7jjrRi1H4+MOJUoTm8ER5MLVNm/FY7hiLPFzCMoYzjXDfUDq56cEKcfgRqseAmCYf1YldVZN1E8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920651; c=relaxed/simple;
	bh=j2s7KrXtah84ncKFqm6P9gNil0D/ZUpKZab0zw6c9gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOVZHt/V+9xzT0vZ/+KLMcbeu7agYJrS/LS0rlGiUry/SCJ6Y1Dm8ps18oM2duCMKTErRI3f/5wZSgr/KFMwJv44XU3spUp4JS/eqNEGkPDtskNyEB+V2Ey/XEZW/WN0jXwI8jJuA8TyL8+hSKDPO2JhC+X7haHXWv12yOcY5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 98CEE59931;
	Tue, 20 Jan 2026 14:50:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 27D7C2F;
	Tue, 20 Jan 2026 14:50:39 +0000 (UTC)
Date: Tue, 20 Jan 2026 09:50:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Mahe Tardy <mahe.tardy@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi
 program stack unwind to hw_regs path
Message-ID: <20260120095100.399670ef@gandalf.local.home>
In-Reply-To: <CAEf4BzZyF2MsF5CkLEsrd0dumeCJ3-zzP+azCZ4TRoDkzjGLdg@mail.gmail.com>
References: <20260112214940.1222115-1-jolsa@kernel.org>
	<20260112214940.1222115-3-jolsa@kernel.org>
	<20260112170757.4e41c0d8@gandalf.local.home>
	<aWYv6864cdO2PWbb@krava>
	<CAEf4BzZ-sPD4UZF-TL2ep-zQOyeOC3K5XC2o3Gsx4Q6XpN-zQw@mail.gmail.com>
	<aWpme7kBw9xyzRFP@krava>
	<CAEf4BzZyF2MsF5CkLEsrd0dumeCJ3-zzP+azCZ4TRoDkzjGLdg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 27D7C2F
X-Stat-Signature: fsz9h3exq8erwwca18mgppfmfx9s17w8
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/jZgrwp+kmekSs+dRtuYLPQ9P1DydObRg=
X-HE-Tag: 1768920639-502799
X-HE-Meta: U2FsdGVkX1+WKDAd+dNGgzj6JMhuW/Hw8WI6ibpiJ8k0G1Mu2k267SqZl561zQaa51mT9fbkJwWiEbOOEsOnX1l69J2Wz9hxHn5UsFTh/6pXZJUVXKM4d7KeeXxWx2P9RUJAAH5iwvGgZVrQZeYSEOyH3nnNbhF1xMreAW7e0EIEMbn7HrTGbzCLSx05g6IPb1d20QoJeQXc4ZHaZZRysS+h1oQzqPNX6CXdVltCofmXrP9HYnu2WAKitD/Xb0Y+0qS6GH+4is7+n917e1MhCcZcSgUcoIH5tw/AAs2a5zVSTz7V2jJY/D50hX3rUVceO4fkrxCmRGPrWqGaFdqaGPVU/MqGHN+c

On Fri, 16 Jan 2026 14:24:51 -0800
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> I don't insist, but I'm just saying that practically speaking this
> would make sense. Even conceptually, kretprobe is (logically) called
> from traced function right before exit. In reality it's not exactly
> like that and we don't know where ret happened, but having traced
> function in kretprobe's stack trace is more useful than confusing,
> IMO.

It's more useful than confusing for you because you understand it. For
anyone else, it will be very confusing, or worse, miscalculated, to see the
backtrace coming from the start of the function when the function has
already executed.

Sure, having the function is very useful, but the function is already
completed. Technically it shouldn't be in the stacktrace. Having the return
address in the trace should point out that the stacktrace came from the
function right before that address.

-- Steve
