Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB426B755
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455288; cv=none; b=Imbb2I0pW57YP58C9yfWkJGF0NtUf6wCLxD6FcaOvT6a8QRg4AAWdPqDmCJGNip4Wc12wR1438vlfYFBA//0CQIT0QGFkPMRKu9i6lSW53F69pNSQM2VTeIssXmBNvoAqXSoDKdLC7o6QV+CEx476attuIqEhdXcMRXSUVB8VrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455288; c=relaxed/simple;
	bh=2QlQekbh+u92By5NEIGvxSV8tsD4aPXS5MlZNCRyjVQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Lo0eG8q2la7hkrvQgZB3jfTxp3AtELycVLs2VWjti9v9h+4qigIJe0T/ghNZ+OxlniZtgGL4lSz/qk1GuqncN2fC/js2ORp5dzburtEUc7RXfwcb9d91u59/HPjyYE6y6eyfRDx1oA/1NwJzMdelRTsGM2lCcM+yhondNewoFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 916CDC2A59;
	Mon, 26 Jan 2026 19:21:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id E2E682000E;
	Mon, 26 Jan 2026 19:21:16 +0000 (UTC)
Date: Mon, 26 Jan 2026 14:21:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>, Blake Jones
 <blakejones@google.com>
Subject: BPF with deferred stacktrace and sframes?
Message-ID: <20260126142118.2ea3cf13@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: E2E682000E
X-Stat-Signature: r7d7d1ew1ctndos95iehqjfx7if4w63k
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19IqM20lkpCauxiBnL2XYh3+QSu5SvUGLg=
X-HE-Tag: 1769455276-326256
X-HE-Meta: U2FsdGVkX18eJKYTXWxqVEhhZ+4qzMoGoNlQc1lVXaWpV8Wkxtze3k1GXucFpElsgWELedpSp9AGk72hC6dEgfAWEq5+A6NpPdj6VOOJjergZu/C8O3T1XsU2obGsGvA4Nl7Bvu3S9WSQF9E9nNUM3alG+md7q7hCxQbwMVB7ySpji9S8E4hioCqGdagsyyaUBHs4rOtHTrDJv7HclQY+MjpRR92hbDzA5v8nHTgvTJCLeRT5XwV5Rs8KFtEd9MH/xnG8NWFE6PH2YiakOLiT40YW4DD6MFdevlx+uqIRg7GrQYZzv82C+nEjpPE274U

Hi folks,

Now that deferred stacktrace is upstream and hopefully sframes will soon
follow, is there any plans to integrate BPF with this facility?

Would there be a way to register a BPF program to request and receive a
user space backtrace when the task goes back to user space?

Basically the API would require a program to register a callback function
that retrieves the backtrace at a later time, and then during runtime (in
any context) request that function to be called when the currently running
task goes back to user space.

I've been Cc'ing the BPF list (and maintainers) on the deferred stack trace
work and did get a few comments. But I haven't heard anything about BPF
utilizing the feature yet. So I'm asking now if that's in the works?

If not, perhaps this would be a good topic to bring up at LSFMMBPF?

Cheers,

-- Steve
