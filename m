Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85329381B1C;
	Sat, 17 Oct 2026 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201443; cv=none; b=UI2m68emh+hRqOkUuAyYsC/6QErJw78/OzV9mkXNRuKS60c5ArZjpsfLzyEJRbYtIWogPCX9nwCncnh1jU0k878TD/SQyy2GPBz53r+A7ZyxQ0YzAieEs4u4kU92VYRe3dncnqjG9qFL+iuqIdwadxELLSPvUsKZiy9cs3UIpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201443; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+yMMIEOf4DAxYiaRuwYvlLi2MhP/B9b1LBiAXGYyHkr/xQGb+1USB1JNu4+RzOtOu4O+JK4wais1FfdfIsOJ5D+lpPgLuKka31ofEJFKYUDpoxJJNeqjegtjZUoN1QfggKOCiPLn397GP3JzN+Xps58r5mLd6lCf6a+adXCv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhGJBRgZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhGJBRgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BA91F000C4;
	Sat, 17 Oct 2026 01:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201442;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lhGJBRgZJScx0sbSR620wYrF7Cefz1OPLXm5lqbTPc4jlPlH4aweECXeNe60Es6yd
	 mLlJCITDWNhCBaIJPnucbCQ9TpLtn3BzzZWwg0j/q2hq7AXVQXodP11Ub2eNRdY+Un
	 4AfvUVVfJzOokmpQbQq36SqSaQOJ7TtptmucmCC2DEAqKSfFE+80H/qMVzN8o5E//1
	 b86r/juqQkmxTgMVnwVJexVthlJ8gI8VFEaJxVSJYmjlxCwxSxzuHSbMLWHVilmjYz
	 o71t9EGVK7TrKkmgKAhylSQ2Nhc/Df+plHI6oKw12T5vectgEQO1PusHzBHiRC3AbX
	 bM/rxZ6inQaHw==
From: netdev-bot+sinfo@kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, josef@toxicpanda.com,
 mason@kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au
Subject: Re: [PATCH net] net: free the policies if a socket's clone fails late
Date: Sat, 17 Oct 2026 01:44:01 +0000
Message-ID: <179220144134.408196.12133972653281965693@kernel.org>
In-Reply-To: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
References: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
