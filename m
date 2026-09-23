Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206BB413794;
	Wed, 23 Sep 2026 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153265; cv=none; b=T4P9ucpFu/mKQz8FD+scB4seWLeC/L8dSAx/ui8+wglCv5FMQhWEZUNDjYgMDCp3Ond+OaJ3oU1z+A2LS9ejg3TcQr8oDr1QkNraMG4UTryl2L+gS9Nt2RJWLTMjVuN3SHoLEOjuw9OCFSzZRoP6rXLYo1v75YQBKUy6Hhrc9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153265; c=relaxed/simple;
	bh=zpgAuLkT2LOYV8IvxWjEmIqkjervfwmMwojK/9tya6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKKf/E9/w88Jef5e+kyaq0W0h1OGzI0BCnttxqtKPv114Q5NmGuCz5qxIaPkA8cUhMHBggf1CiETQos6XLGpkOS4rQGQfrPL6chJRx1EpvwHsLXR8hRLs3sjr+kTmAGRJH5zY0KhunDdvbNkSZbmasxTcsmO2lcx2RGwwxnOK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=lOjQFhuR; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="lOjQFhuR"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 052DEA6AD3;
	Wed, 23 Sep 2026 08:47:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 1FB7431;
	Wed, 23 Sep 2026 08:47:32 +0000 (UTC)
Date: Wed, 23 Sep 2026 04:47:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/2] tracing: fgraph: Add a cond_resched() to the shadow
 stack retry loop
Message-ID: <20260923044730.1bc0a81c@fedora>
In-Reply-To: <20260922225526.1554758-3-vineet.gupta@linux.dev>
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
	<20260922225526.1554758-3-vineet.gupta@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1FB7431
X-Stat-Signature: 79p416q55bj4hwixcabuekkqwe6tjoqy
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/5YKzK8B5lpzZqrKc7JBcSBUNuwZ7TNMk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=zpgAuLkT2LOYV8IvxWjEmIqkjervfwmMwojK/9tya6E=; b=lOjQFhuRMYa+nvhUAjIuXOnhzjoQ6XTWqkt9z/0Gna0YGltsd1OwDaYXFlP1I2fpUmQ3Zh07NTaVDMoQxdrERgLz+UEo/0PdehETA9QbFjUPoQNRYsHcG4hPKYBwo381zcZVBzQDWBgUjE9SPyyHxpk6fMRqbOwYUDZEGuv2KYE=
X-HE-Tag: 1790153252-226471
X-HE-Meta: U2FsdGVkX19M/zr3w83fZ8KluxjxQtNkZbGYTJ07vaOWA+76DhQAZZFy60SvF9Ue0ZrYjrcHw+FGdzClB7JiZCvs5ac5EKym3rNBZe1blBVTfEWhJH9ialW96XCECmrVQYp9WQcfHsmbLKY2FXmhT7UaN5gHpEKg1hPzwOycVB3wDGGiv5yH647uvoVuvheitf9pKJEF4pA36dUf4ReEwlnqKGRheb6U6rmzNIn2Ke6cTYDc96QHkHTjZ37WWOaJ+zWloZFYlPPT4TXwaLUaSs3UM/ndvk8JXtuWaE9fPHdQdjBF+jQjJFf6qJ+HCxmH

On Tue, 22 Sep 2026 15:55:26 -0700
Vineet Gupta <vineet.gupta@linux.dev> wrote:

> This is supplementary to previous patch and is effective only for
> !PREEMPTION kernels.

FYI, a patch in a series should never mention "the previous patch" as
if it gets committed, order in git history is not easily seen. Thus, a
change log should mention the added functionality itself and not a
patch sent to the mailing list.

But that said, this patch is likely not going to be added because
!PREEMPTION is being deprecated specifically to get rid of
cond_rescheds. Hence, I'm not adding any new ones.

-- Steve

