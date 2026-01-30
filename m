Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1ED363C47;
	Fri, 30 Jan 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794112; cv=none; b=SJqEtHjU/RmJvcN8XwSoGT9JdZRbLAXJTxf2LfZrsl+dyvqz+RFP/jn0Td+hGjaDjjQhUBko58q2venYL8bJdiS4tAqaqcOxz7ZuLGa4WL4I3Db8biGV48ssPq6L10ezHe+evGF1MFgctcIxtYo5+rH7MRy1vAbjIuRtaPfEBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794112; c=relaxed/simple;
	bh=Hb/tFC1O9mjYqDrANzgG+7fOno6m6bfkkJZd32hYF1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l60c0+U1JzXA3lH/eEpBxwy1lNKW415mU2mj/XgwUtLGLu5yTQOOOWYn008dhHOLZAXP3audEsP98yC+U0qiUPdt7erjl34H8miJOkdnDh2h6IzAZJtsttfeQH37n3hMUiF9JFvV08apOsVWEb/IRO2arLf7LUR4m0xdzbJjXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPIbcFH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPIbcFH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F4CC4CEF7;
	Fri, 30 Jan 2026 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769794111;
	bh=Hb/tFC1O9mjYqDrANzgG+7fOno6m6bfkkJZd32hYF1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IPIbcFH9FVcVhpffxj3Y8YCd4FuB3thCQrhmHIelI2/WReu1c6T7Zlas2T8lky/rx
	 T2HIds+Pf+MzWbDsglJb3Lf4U8qCC0/+EychGRHqLaRyos+vd4KxRPoOiNVHtNkzEy
	 uQZP8iWXFf1NC3JZK6Gu9wEYQZ3hgkSkaiz1Oq2PzElGwARL7pwBD38FMEjyu4ZYSH
	 jw4+5mv0x8bY4cbQICZ+rxwFNumV3yp9Q9IFsmKqR4v0KuE/fV6AjXLzubypUL2xEo
	 L0eEIIBt9g7FpK7hHiWYV+NwkBUlU3caOly2lYjEL/+iMCWZuTX7yT5xDuqZj6QsU5
	 n0wlkNQSJ0vzg==
Date: Fri, 30 Jan 2026 12:28:45 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [for-next][PATCH 3/4] srcu: Fix warning to permit SRCU-fast
 readers in NMI handlers
Message-ID: <20260130122845.04d0444d@gandalf.local.home>
In-Reply-To: <aXzTdOTyxuH-51_t@tardis.local>
References: <20260130154607.755725833@kernel.org>
	<20260130154639.883617005@kernel.org>
	<aXzTdOTyxuH-51_t@tardis.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 07:51:16 -0800
Boqun Feng <boqun@kernel.org> wrote:

> Thank you, Steven! I will drop this in the RCU PR since you already plan
> to carry it via tracing.

Thanks. It was a needed dependency for the last patch.

-- Steve
