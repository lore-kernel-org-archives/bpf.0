Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590540;
	b=SGjKEBSJbDKgjT3ZLDX4wpUb5+ABt0TYeS2tAJI4gvynOr/VfgmRE01DFpvSyY9SXoJ/
	 RE8a7bVmZ8m+PEbTAWfSzXnoEgzZWdGwB5wssRRjkcFJ2UE++Q/GPzVUiINGu0oH+MZfK
	 HtI4LWOwvj8dMaKdULhb0u1xtVdsWxiXTA8gywfxlulD+/SGJW5ocwfCwzzBzlIfmDQJv
	 m/OGZizOzUZOKf5MuQbGPAwAftFxVMsA5OQkA4npzCpoSqdRpHgrTvIbwRyARMThPPm02
	 tVjThNzSHY12RtsOqAX4EK9mTTYrd/y8+jc67qD57Ty5PVSXGHanNlt+gS+AzkXKUmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590540;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=m6ie5JCyR2XxFwtvMIqypZ8n7/2BglhxkFeUrEWwt6s=;
	b=A/t5mN5qdstTHim5yXKUxg7KpJXhBbFwcsc6mP0j8JpnfGJk9IrsHU1PsReEWefl5KkQ
	 7MWf/6RIhzg3+MG29wFdUlyDtoNH5ZS6NH8pPQwuLJMpL//cnKv5qbwYpblwsqlw6tuOZ
	 6Lytig65Tlgk1V85wgLHbQI6ZEGdzfHZRnTWNkCQlmuGqVqR3iDw7h1eLrsQwZxzMPFY8
	 mK64AOHJkab/nvYynFc056gFHsY3jXNhlgfo8vZfhVIVVXUQE1hwgqW65LNdjlbp8hdF0
	 R1SnT6DFQpABBWduvRDHvelj58mSprhIieh718jBrLupTIsmoCvUqXQhsn7xQ4dLKXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=7YHU08uj;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D498D606A320;
	Wed, 21 Oct 2026 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D498D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=7YHU08uj
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 969F08048E;
	Wed, 21 Oct 2026 13:48:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 24FD32001E;
	Wed, 21 Oct 2026 13:48:55 +0000 (UTC)
Date: Wed, 21 Oct 2026 09:48:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Wen Yang 
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
Message-ID: <20261021094853.29b9f7be@gandalf.local.home>
In-Reply-To: <a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	<20261001152042.124445-11-gmonaco@redhat.com>
	<DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	<b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	<DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	<878q3xtptq.fsf@jogness.linutronix.de>
	<8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	<87bj8s8ih9.fsf@jogness.linutronix.de>
	<DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
	<87v770uuyr.fsf@jogness.linutronix.de>
	<DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
	<87ik2zryzo.fsf@jogness.linutronix.de>
	<0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
	<CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
	<8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
	<CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
	<87pkx5q1w4.fsf@jogness.linutronix.de>
	<0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
	<87h5ifqy6w.fsf@yellow.woof>
	<a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 24FD32001E
X-Stat-Signature: 3e8xkmsffyoz5tqfcbp5gzchn195ciz6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/won3QmWO3Ea00n6TVtg5JObWY0ME+wXM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=m6ie5JCyR2XxFwtvMIqypZ8n7/2BglhxkFeUrEWwt6s=; b=7YHU08ujBNK3Sf9GcF9v9OOvNmoZOVKjeSWm26SiC+x4cOWhpKWxS1a/9z1wHgOFyKxv1kdprbIb47P01mLy5cPvZsfG+ZqEfdD12c0XrjkPry4Q5JKlxhi/kU0z9G2Wl7twvLDE/Qv3yxZuHhqBSdwAPdxkT/UgQnd8EVsi7WE=
X-HE-Tag: 1792590535-35345
X-HE-Meta: U2FsdGVkX19cWOGdLkWjMcDfb0lJuNUgOuDab930f5+fzedrDD+DDMLGOlqXXYTRezyRJSDSRbcp/sPe9rzQP2ZlFJouu9+AdFlD0BmJjPrI5dsfs05cDLCVt9LssZnEo3Elup4EVF002qnfwodRVkTdckUSITs1iu2IxBTxNAHDQ4QsWd6Eb0BuGVd3EVV0/vwPoHRirouMyDlnWXHe+XaxiAYtRM/vmpjd9pp6Crmvu7pEFJ3pvba/uutatAPOPGqTZZSUpPiuECwe/TkdqZ3ZVRs1e+N87Z+lkJq7sWkv15HyQDFdvOwBsSacKRQvzpwM24NidLL3NJszxlRmzBd3J7w/KeXZ

On Wed, 21 Oct 2026 13:54:04 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> > I vote 1, much simpler (but maybe I just haven't quite got the issue). I
> > feel a bit ensure about adding RV kfuncs and would only go that route if
> > there is no other way.  
> 
> We can go down that route and see how it behaves.

BTW, I'm curious if it isn't possible to keep both in-kernel and BPF
monitors? That is, for those cases that do not change often and has a well
known model, to simply keep those as modules and hard coded.

But this entire thread started with people that wanted BPF type of
monitors for more flexibility. I would argue that is an entirely separate
use case. For them, it should be a fully BPF solution, with a few hooks
into the RV infrastructure.

It currently is a big unknown if the BPF solution can handle all the use
cases of the current module method. My suggestion is to not try to do so.
Keep the module method for the more static use cases that do not need
dynamic changes. And create a purely BPF method for those that need BPF.

This thread is sounding like there's different requirements between the BPF
and module methods. If that's the case, let's keep them separate.

I agree with Alexei's first comment about not adding BPF to the module
method. But that doesn't mean we need to eliminate the module method
completely in order to use BPF. Instead, just create a new BPF pure method.

Perhaps in the future the BPF method may make the module method obsolete,
but I don't want users of the module method having to do all these
workarounds just to satisfy the BPF method while it is in development.

-- Steve
