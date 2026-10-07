Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3E4A33F5;
	Wed,  7 Oct 2026 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378001; cv=none; b=tWOWrJTARlIAHSqo8lCy4opTAejjHU36i619QKmt/cbgV6lQVix+tvGXdA/3kILyXYZF1FOr9JZw+XVciNs4a042DI2cHkOXysl9ikhTMO+cb6OY2qFMUIn4xQvN5B4SIy5Krg/Mpx928j/IoAK6m1XRaitloNmrdQzR+VgkI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378001; c=relaxed/simple;
	bh=fj464vjBR2tNbqnS46pUy4Usm7oC7hnfneL/awpF84Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VuDE6cGmTB9rtn3GMfH4C5nlSKFV6O7iyEY+9wJgpCVas2czFtQpunxpyCwUBeJSVPQ+uDUDJT0xjmXQJRydz2yy6WZwKmIOomOVB1EYnqPm4nXefwGymA2IOnzV8ZKZzvTPjmv7sex6pRWS5N+u1g2wOgeSJMpOT2J6pSvOvqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NIOIQOvF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8RmG4i31; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NIOIQOvF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8RmG4i31"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791377988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fj464vjBR2tNbqnS46pUy4Usm7oC7hnfneL/awpF84Y=;
	b=NIOIQOvFKG94r4k9j9XXUpSNN6DLdKuZDzGTY33D/dCbJ0V4PQf/1J3FVEpEnN4X/oxEE5
	7lDOJatLH03r2b3OF/E/BQn0e74ZDEO8P93jWZjYkIz1nfnn2fZVfA0htTsVIZEGx9pB2A
	wN9BNUjVhsXmV3w7prm3VQj4Omxa8G806UsrsuoEylL3QLeZ6yB6vrMgj8r/vs1qXmtoqa
	KTdlxRS/aE3bzgdMHIi2EuUt+7QlVwYgz6Xvej57YH4QbGKK8u2er3d/XZ30Tma7hAb4kc
	X1yQ8ayAwZU9YxT/Ato2/rx/3DVcZSkX5cXkvgmkPiD8HsaZGeoUn5qMuHtz2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791377988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fj464vjBR2tNbqnS46pUy4Usm7oC7hnfneL/awpF84Y=;
	b=8RmG4i31CSVcn/3jS1xzpHNpawYQeXCBTclAuKnJhkH+xxGOk4LrthPmJdOd5d0TOeA9Qo
	BcdLlCEgeFEYCrDQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 09/15] tools/rv: Copy stripped bpf_atomic.h from
 libarena
In-Reply-To: <20261001152042.124445-10-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-10-gmonaco@redhat.com>
Date: Wed, 07 Oct 2026 14:59:46 +0200
Message-ID: <87ld89wtrx.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Add bpf_atomic.h including atomic read/write macros like READ_ONCE() and
> try_cmpxchg(). This version is a stripped down copy of the one currently
> present in selftests/bpf/libarena.

Instead of this, what do you think about using C11's atomic stuffs? I
prefer standardized stuff when it is an option.

Nam
