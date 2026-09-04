Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E440DB4F;
	Fri,  4 Sep 2026 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565520; cv=none; b=pUEXnERcKCUWOD5Dpmljia7DodT3qtOCKU5IHEyjgwZPafqCw3b1PSp6BnkO0V5w35gn0FmaLBdd0Vg/SP4omB7ebrrtsos9kR15E35RDFoTSkrYhYUrSpQUGhc7BTkhdeR196a7kPfRBIR4o9ik177GnZj24oYC1f9BrILaJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565520; c=relaxed/simple;
	bh=DRIvm8JMyWH0yhWZ1i4DJ06/VHavrQpMxrhKX+qQwig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cg/STsH28aQRjKlhJrQGz87FxFP5C6D2sbvsUCuzWQDLK1p34RbiPoydL7EJo0CibTchkgTaR4csQGMAerrNxENl8tsFYbtIt4pV4GO+1dI9wKCAx1FU/8a8BqFNn26VW2kQaacnzr11Jik2SKLV/UO1doI0rH8SlBjXjJuQWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=tflGoJE2; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="tflGoJE2"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A55A0160251;
	Fri,  4 Sep 2026 23:45:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 751A92002A;
	Fri,  4 Sep 2026 23:45:14 +0000 (UTC)
Date: Fri, 4 Sep 2026 19:46:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Gabriele Monaco" <gmonaco@redhat.com>, "Nam Cao"
 <namcao@linutronix.de>, "LKML" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Wen Yang" <wen.yang@linux.dev>, "Tobias Schaffner"
 <tobias.schaffner@siemens.com>, "Viktor Malik" <vmalik@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
Message-ID: <20260904194620.0c7a8363@gandalf.local.home>
In-Reply-To: <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com>
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
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: niifoc6ga8pboxz7zff9h76734an1abp
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 751A92002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+fQ2LWTO1LLuzQ/EHNvkZyd8n8Bvr17tU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=DRIvm8JMyWH0yhWZ1i4DJ06/VHavrQpMxrhKX+qQwig=; b=tflGoJE256cRP8f32PtN1Oip78piFB2DlmVDL4WcKNAiIObZSOO7BKRVaDLM4Dk8X4DJKJZ5/7KW4utU/52UhUdC9pHfSCjVsnt6JIK3mYHp/4mgR3/KCwTJwf9Z7cmsf0dlnIQh8GFHenhqpvI1UYEv4OY9uAptQcR+4m7zHnQ=
X-HE-Tag: 1788565514-449424
X-HE-Meta: U2FsdGVkX198OLv97uxy9LdW/VnQLfsjlDKPAVkyVaO9YVmOb54Yq+M4pGvGkqdMRscY1U6FUD2MmdFEdKnvCTy06clrnzgINyb74jxCmOPf/4ZJ4e8s3wSqdtX09uL5ip65IRgWI5Hu5yiYrorN3TTPLkhF7VOLQCZWU3eHQ5kcW3SR7uNDk1US1dLqqR9mF4r6A3e4A8qvt2mhoBREFEjJBx5Y+7HO8uBvXIPeD9tLPHhRHkhzLXgJs8QklqgCb5NMJGzTKs6cfaq1F3Pm15Ctml3QocRPjbmsGM+SKXt1u81Hl3uSw9vpUN0yCeYqGvcvmspEFuYXVfnFa7sp9Tqu2QYBPC1p

On Fri, 04 Sep 2026 16:34:00 -0700
"Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:

> bpf in 2022 was surely less capable then it is today.
> It took us 2 years of bpf core development to statisfy sched-ext demands
> and we're still adding new features for sched-ext needs.
> If you're trully willing to remove 90% of kernel/trace/rv/ and refactor
> it into tiny shim where all of the core pieces are bpf driven we can
> certainly work together (like we did with sched-ext) and add whatever
> is missing on bpf side. Then all existing monitors will become bpf programs.
> But adding bpf as another 'monitor', sorry but hard NO.
> If hardcoded monitors was a mistake then admit it and fix it by deleting it,
> if it's not a mistake then keep adding hardcoded monitors.

Regardless of whether or not BPF can replace "hardcoded monitors" today, it
wasn't a mistake back then if BPF wasn't able to do it when they were first
being added. sched_ext wanted to use BPF for scheduling as module plugins
were nack'd by the scheduler maintainers for a long time. BPF programs to
handle scheduling was the work-around to that, and basically the only way
forward. And it still required special hooks into the scheduler.

The rv monitors only needed to use tracepoints for hooks. A module was the
easiest way to get there, as BPF at the time wasn't an option.

If you want to use hostile language like "admit you made a mistake" then it
makes it harder to collaborate.

-- Steve
