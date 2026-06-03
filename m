Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F94DB570;
	Wed,  3 Jun 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527069; cv=none; b=a5jvWo3GSgz4QXvoxSvxgsCcxFuF+5zzprzgU/kFYpQRkNRsg/XOmJXCc9qwW9jOk6Tkz8aSXp1FfypexJTP5JOhg4M90Huo+FlNQOdG3NACbRz3KtgL/cgzYa7tl26zfMvKt/OUYu5yJtN8wNc9Kpk0jSWends3QKOl8oxSKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527069; c=relaxed/simple;
	bh=UNmvRtEcZSRaXgcQydwfgOuoq71fs51rX4nIYd7c2Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmfzc7S7QD0MVNTJ3yjSaQusf/a/3lu92iIoy2pwQ9kG6byfYnrRvc5QXNlmrK69FBwXKyYfgjB2lEWJgapwZlUH4AShY/l40Gx0mXs7eatZkCnEhBqOognC+DFrcf3eh5abkucmFenzVNSJmmLFaD7juVE/aBwjBbYLvCglp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id EBB1B8FD65;
	Wed,  3 Jun 2026 22:51:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 354803D;
	Wed,  3 Jun 2026 22:50:59 +0000 (UTC)
Date: Wed, 3 Jun 2026 18:50:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] tracing: Expose tracepoint BTF ids via
 tracefs
Message-ID: <20260603185057.4a85d5df@fedora>
In-Reply-To: <CAEf4BzY5MTGJyys369qDS3b63-tKq3okCpFMqUdfzy0dXk7vLg@mail.gmail.com>
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
	<20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com>
	<eed59d12-969f-4135-a84b-4965743692cd@gmail.com>
	<20260526215741.1e5b3e42@fedora>
	<CAEf4BzY5MTGJyys369qDS3b63-tKq3okCpFMqUdfzy0dXk7vLg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fnmuaqku3rtbor8iexhcb848tjbb9bee
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 354803D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+3DXqpXVFDZZB/RTNakh8HXKWW/9MbI5g=
X-HE-Tag: 1780527059-188986
X-HE-Meta: U2FsdGVkX1/NqY5FLitBgJyRQg2TAEl2vhdR66lZ1Nr0ap8Cp1d7mQGskpL9i3y7EzXXUETMyS/qOGeEvSPKMD4RBEGVsrUrriir6vGXadw+9d4e7QmH34a+WZsTHSsJRKzLSqSdeZo6WU8JxjYUhfxQu6EIrhIOfn09eLrh5n/fCIKQoO9P/3WFthAwZltNO2PbEGFS6zsgTKHJKvgAby1t8Q7mTG1ef2MKjwp7d2KKI1xgAHRp6ru7GHwcvk9uHHVCVALY7gixaaVAou9ICQNFyk+i/b3O90hAGgzmfLPmY06L5mk/WPYIuenmDoydCASLcETSqJjFQN79YkH8IEQEtoBbK/QJ

On Wed, 3 Jun 2026 15:41:50 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> That's just to say that it would be great to have this in some form of
> shape, so please help getting this into acceptable form, thanks!

As I said, I'm not against it. I was hoping to find something to help
alleviate the memory usage.

I'll likely take these as is, but I'm currently on vacation and it will
have to wait until next week.

-- Steve
 
