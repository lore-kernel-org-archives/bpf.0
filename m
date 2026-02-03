Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6A3ACF0A;
	Tue,  3 Feb 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131817; cv=none; b=da83gJIqcPTlZg2r0wBwKb3fUoeK5cI9c49d51ETXpPd73v35hoK/SbwBgGEVyTr6LCVlaruOtN0CQdMhnXqlDFQAZ0UoeI+UknW2nHoKBc9Uc0tfC84pYArLoL7LglkSF22iHrdt0qXTg+2hta580E30GBs/BEM6n1OpUariE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131817; c=relaxed/simple;
	bh=MSFxL5BqemVPfYdBffVWaaEGpWr8Tos9N2nxcP6qPcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f//YE6jHd6lrjRuwJ659GPP06WNI1bQ9wETB4HDTDV34R2mHpJvjbhikbQDyyiJrCyAH108CnxC58InLzFWB5RfP563WBumi629qcN82Uj3mYZIKXGoOh+nYEjcQkPR3pOHMavb7IacocguYblN/UFLTEgnF4Ua0MINMaz9uFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id C06078BF00;
	Tue,  3 Feb 2026 15:16:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 4DA6620010;
	Tue,  3 Feb 2026 15:16:39 +0000 (UTC)
Date: Tue, 3 Feb 2026 10:17:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>,
 linux-trace-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
Message-ID: <20260203101707.52965eb0@gandalf.local.home>
In-Reply-To: <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
	<20260202111548.3555306-3-dolinux.peng@gmail.com>
	<20260202111249.649ac338@gandalf.local.home>
	<CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
	<CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8ernxmaa1387t35chuzdz1noy6qndsky
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 4DA6620010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/akkGfYzvrI7Dk0ZpaVf88QCXp2z7sFg4=
X-HE-Tag: 1770131799-747990
X-HE-Meta: U2FsdGVkX19aqvl1qUqWBD/IGDCza8jChhfyo7dsx1wtXEBgKW9RF9mgs8imtsXWFTL+KrerfWBCOp9b4/1nnTX38T8yJDFRHMj2Qd6mbCxjKK7AcoaEHkdYU13KycBNl7N2urdV802zECMGpLNHbr6s37R1wC/a8IEMlo68nFWq9YDiFQZMZf3adNPNmwmwZCJN/Z6hyVxhHL3qsWTPGxq5EUdalHl+DrhoL6FQeSRQ63UuRFp7z/7tk68a2TOrw9l1y572hRmE6GvR5JPuik8kWSRbGqzfInEveXquMtlq2nDPQMH7//ymWg+fi/H0uI1bryNL8GJTkghY7owvpCdBqtPFfw7z

On Tue, 3 Feb 2026 21:50:47 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> Testing revealed that sorting within resolve_btfids introduces issues with
> btf__dedup. Therefore, I plan to move the sorting logic directly into
> btf__add_enum_value and btf__add_enum64_value in libbpf, which are
> invoked by pahole. However, it means that we need a newer pahole
> version.

Sorting isn't a requirement just something I wanted to bring up. If it's
too complex and doesn't achieve much benefit then let's not do it.

My worry is because "cat trace" takes quite a long time just reading the
BTF arguments. I'm worried it will just get worse with enums as well.

I have trace-cmd reading BTF now (just haven't officially released it) and
doing an extract and reading the trace.dat file is much faster than reading
the trace file with arguments. I'll need to implement the enum logic too in
libtraceevent.

-- Steve
