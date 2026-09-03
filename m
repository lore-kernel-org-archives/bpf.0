Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3D48095A;
	Thu,  3 Sep 2026 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440484; cv=none; b=fPxs44Rwk45FAlypFuWef4g2bIz3wp2e2lfvPW2thMtr+0KOaNNsC4vC5rYoIqmSYMiSuIiuDWZCEYykN+NyPRPom1pHLhB5C9DkfFmo5klWlINJbCboIcXuc1a16ciSMxE3XutCTdmUluPK6DU8ud0ydQ71ujSwfp7fHjB4MM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440484; c=relaxed/simple;
	bh=iJG/s8GGXXXIrvxySAUuH638FurAcqctVoxjhxpgL6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8H+xiIrKVIivnOIYLF6mFXhgy9dMmQjPD6mQyNPfcL+ijvExqafuSFrj2LYp6TOxzGNvSeG6I8GqP8kkJtSGmNX9mqlYOoBjq1QPAvgkmhU0H4JstEA3cGcm9acfrb0Dr98+boFdw5DE6bD83eQUPVD7S6+Lsok/xBRUtPQPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=JRUgXQ3A; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="JRUgXQ3A"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A86ED120426;
	Thu,  3 Sep 2026 13:01:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 5DE8520012;
	Thu,  3 Sep 2026 13:01:08 +0000 (UTC)
Date: Thu, 3 Sep 2026 09:02:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Nam Cao 
 <namcao@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
Message-ID: <20260903090211.50d15220@gandalf.local.home>
In-Reply-To: <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	<87se3sakgi.fsf@yellow.woof>
	<df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
	<DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
	<eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5DE8520012
X-Stat-Signature: 599b17rkjqqaboag1r5zzpsja34bpukq
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/hDX2tycQ0wJ6OosjSOGEEIkQow8xfsuI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=YP1HmGaRtV48egavEcaNf/B8MIIrFxZMcAR9YqngWsc=; b=JRUgXQ3AifLYbcyEiPMjDDTlFTLfMtJCxMk4zNefD7BicPd3HHyGe1GyizkVC1OgKog0KY5+EYJIhR+cQKoDATPyZgRA5johHnmvhYqJ/B3EBeXRgsG2UcOpU9HkDEyktJrf5fnqgyBji4zBLVIjjkdepnqTRRI7+ReEbdkzqUI=
X-HE-Tag: 1788440468-820146
X-HE-Meta: U2FsdGVkX1+/o5eHUAvWbIq34ly2XCcD6ZRuOhKJtTqfR40wgY1VcasY9LguqEVcrXg3FitwBLUK6RK5grbvCyqQ/+rZ/B356aenQJBarJmzBpukWDMHQYXLqhqiVQEdZQsT8BN+vVy/prEzh1Q/KPpuwLf/yHKmbsWNRbzLocF+euoO4KeU1/qUOmxX1DxuPOiNgB67ktypHkWAq0eG6f1TlyA3gM0YS++ewWGVm7i/VCS+coEwrw+IcYtQR8rkAA2SDKLZt6NthK+guE4kMsxezH9XtoaQrzeR80oHGXuXiO+MTgRNpPR5SH8w2VTZAGEiFLVl6wWZJ3+owXbfb/5UDIzE6YeROitbBSothSp69KXtAhrKKJIE35+hD1YIJz0VuBjWL5U=

On Thu, 03 Sep 2026 09:21:18 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> On Wed, 2026-09-02 at 18:57 -0700, Alexei Starovoitov wrote:
> > I don't think bpf fits here. I haven't seen active use of RV and even less
> > so of any request from people who want this kind of programmability.
> > 
> > So Nack for now. Sorry.  
> 
> Thanks for your opinion, however it sounds a bit harsh to me.
> 
> RV is clearly not a popular tool, but I wouldn't say it doesn't have active use:
> we're actively using it to validate the deadline scheduler/server changes and it
> already found a number of issues (e.g. [1], [2]).
> The RTapp monitors are used to validate if userspace real-time applications
> interact with the kernel in the best way for predictability, as far as I'm aware
> that's regularly used [3].
> 
> In my eyes, the missing piece of RV is in fact this programmability. Adding a
> monitor now requires to write in-tree built-in kernel code.
> 
> There are strong use cases for domain-specific rules that aren't general enough
> to belong in the kernel tree:
> * stricter RTapp rules that may not apply to all use-cases
> * verify some exotic system within Linux (e.g. a co-kernel [4])
> * modelling for functional safety certification process (used for in-vehicle
> OSes like RHIVOS)
> 
> BPF seems the natural tool for the job to me. Mind that RV monitors would be
> simple users of BPF, requiring only modifications in the RV subsystem but using
> standard BPF facilities.
> 

As RV would simply be a user of BPF and not modifying BPF infrastructure,
I'm not so sure you have the jurisdiction to NAK it. It would be like me
NAKing how you create a trace event.

RV monitors are a very good way to make sure the system is preforming
properly. This looks exactly like a perfect use case for using BPF instead
of having to install modules.

Either BPF is a tool for the kernel or it isn't. You can't judge where BPF
gets used. You can only judge on modifications to BFP.

-- Steve


> I'm totally open to discuss on this though.
> 
> Thanks,
> Gabriele
> 
> [1] - https://lore.kernel.org/lkml/20260522125833.264145-1-gmonaco@redhat.com
> [2] - https://lore.kernel.org/lkml/20260113085159.114226-3-gmonaco@redhat.com
> [3] -
> https://lore.kernel.org/linux-rt-users/20260826132153.2476006-1-bigeasy@linutronix.de/T/#t
> [4] -
> https://lore.kernel.org/lkml/20260827072400.45734-1-tobias.schaffner@siemens.com

