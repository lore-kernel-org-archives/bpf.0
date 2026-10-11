Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7F1F2B88;
	Sun, 11 Oct 2026 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791679421; cv=none; b=WTIpkwvOqM4uXaIKcZZMmQofp8Uru/cdz78fXt6an4ySVvTptZ6MplRfgTCK4wqT9SbBsEUhZz0l7E3/RNz13eJ24woDTAvCOHObbowm/D7fEPSrItxWq2em6jXQci4UFcQUHyQQj99mK0wdsRac54upNTur9dIpPm3XsosWin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791679421; c=relaxed/simple;
	bh=/KsFtipBILUNYzNasIl7zE2ZOeBAmnFbRIPAdk5YnUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZpkHXm+T+j4qYdAsOAhcAYrQMYTXFXNeGbrMUC0MswrliFH+C7QD8dJJVg8u/BiIyHy8da9nyAZuvdz6Bk70Sgvu/wYqc/BjtIxVrj/ry52KjABjw2BAmSVFTdl0ZP8FUPNHkY83MwH9HtAiKnqltdfyx++QJGjGXtUBgieIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=ngwJqyHd; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="ngwJqyHd"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D2E45A81FE;
	Sun, 11 Oct 2026 00:43:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id D820220027;
	Sun, 11 Oct 2026 00:43:28 +0000 (UTC)
Date: Sat, 10 Oct 2026 20:43:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Wen Yang  <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 09/15] tools/rv: Copy stripped bpf_atomic.h from
 libarena
Message-ID: <20261010204327.0656cde7@226.227.38.69.naturalwireless.com>
In-Reply-To: <76753c2dd66792ec6eb94d00741e61366df426cb.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	<20261001152042.124445-10-gmonaco@redhat.com>
	<87ld89wtrx.fsf@yellow.woof>
	<4F009BB7-58C2-4AB1-8FEF-61FA4B5281A2@redhat.com>
	<87fqygl9we.fsf@yellow.woof>
	<76753c2dd66792ec6eb94d00741e61366df426cb.camel@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hrppt3w6chs5ba74ce8fgdufydrbtc39
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D820220027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+w6wJ/jUT2Ykjo5cozpi1JEmT/g6EFWGM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=/KsFtipBILUNYzNasIl7zE2ZOeBAmnFbRIPAdk5YnUw=; b=ngwJqyHdMdsq9bsY9ISYUX0iUoSSaSwz4rFcZ2YdcgmH8xsOp0bMltZwrxTSKk7EDDylJaq8itO/VpP7DWnCmZ3NIs7KDI8cQT2KDBG0YtA5BjwYUmNdum8CD4wNgvQTZL/fj3rB7VgTNCsxlKbzQFFVsHGS/xoeproqQxQG6y4=
X-HE-Tag: 1791679408-285809
X-HE-Meta: U2FsdGVkX1+0KjST59GDaeAUM1Hc8Eeyztp3PGY7IcoLbzSiiQGMcni+nuIJBVHaf1hu5JskQk/TfOlbRVs3gGbMhW+a/4njz3e7/X+LdQFNAPhqLOxOnJt1RHeksNHd8deiL+rUemKvxHUZvmtH1+APo+YrrfErgsOvKf5OroCvVG39e56Ni2fZG3EihUuSlCvaNiitXcZv9Prdto/CH+wCrAxr5cKhhoCxaO0YxcmMBSI6tGnXrjabRBohfjrAn5ogbf1yriSl+1w32f8LNuDz31m+lqFqSoelRsY2bckeqaX4U9iFD+KJ9xQgViQWhLRaJ5XRDy0XV2moTp4GQQtc91ELaH0L


Please keep both until you know the BPF side can do everything you need.

On Fri, 09 Oct 2026 12:09:42 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> There's a common belief considering BPF a prototyping playground, where "real"
> things should eventually end up in the kernel.
> Now, I don't agree with it (look at the many sched_ext policies used in
> production), but I'd want to assess if dropping kernel support could drive users
> away (e.g. industry/automotive which keeps popping out) and understand the
> various not purely technical reasons.

Where do you plan on storing the repository of BPF programs?

One issue I have with sched_ext is that it did exactly what many people
were worried about. There's a lot of schedulers out there without much
collaboration. It's the "copy one close to what I want and tweak it".
When I left Google, I heard there was 20 or so sched_ext schedulers
doing various things for various projects.

One of my main motivations for scheduler governors.

-- Steve
