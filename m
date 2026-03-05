Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B1244694;
	Thu,  5 Mar 2026 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677696; cv=none; b=b6mjfdKT0OrDIqHL25CTgRMomZDXnVAeSFR6kWG4tp7ILjj7Nkm+m9w4BFGiADfAKV/2k4zvGOfLZoDoWqpjgJ6izClN2Qjgg7+PJETkqAc6Mpi4NWnMoytyMAxx8IXqvfOQAFEKEA4vwun2mGWvOpAy5E9TwncYkZL1K2CPxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677696; c=relaxed/simple;
	bh=LJ/Sx89AcI05Vjt2qRbR9ewc4OEdTT8jBCOtN/b/dL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGA4KFrvPcQCudOCtWYY8MH+4km+Ww97Cg5A4X9FQ1oiYEanF+OhcxtKspuh6F/A/eNtATwhJwK+rg1QFfuLo0a8xDeW6LobvwjwIFlWzHx/6aVXxp2RAfc2JHMssckL5ltPTlJ1FMmgLnn5x4xS6fyM3eg4s2K9JoP9CujltjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D5CFD8B7BB;
	Thu,  5 Mar 2026 02:28:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id E096418;
	Thu,  5 Mar 2026 02:28:03 +0000 (UTC)
Date: Wed, 4 Mar 2026 21:28:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304212802.458b878e@fedora>
In-Reply-To: <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
	<20260304095415.4d5f2528@pumpkin>
	<20260304155742.7b4de2d1@gandalf.local.home>
	<20260304214447.3e5817ea@pumpkin>
	<CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3mcycfhfyptziiabp1h1wsf7sfyjbwzo
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E096418
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Kis+jeZAL4QVydhjx0E5ezSrAqOAYaYo=
X-HE-Tag: 1772677683-828538
X-HE-Meta: U2FsdGVkX19gaEE0dS5Fct3PliD6Of/Dw9bLTD78VRKG30ES2A+UghvIMmrEG2NNmgpJSu9xQaqX0ZyEiri0Enfnd/hI5BMc/OtRvwzZ/mX6InOOcUz4Unb9rh6zvGh22JeXM52s26r6KUfvEQti6uZ6NprkiRMIMyGpWHn84aFriilz9lM1i2oDz7O+IkYAQnf6tJqaZaLdx+szdvwTW3IJoai4g+0Kzx7CczXf+dfANX4r4ouzTLXi6vrLFmwlbFrIXlXgp1AHRs7Kf9M0745YxYwcpp64g72Da5+6xv3g6hUaMzVV0+WzF30VWAQU7Wsj5+TY122bK6v78/MWuwKkMtMtUWAu

On Thu, 5 Mar 2026 10:17:09 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> bpftrace is a widely used tool for online debugging and dynamic
> tracing. However, sysadmins may unknowingly run multiple bpftrace
> instances concurrently without realizing the potential impact on
> system performance.
> 
> If this is your answer, I believe we should clearly document the
> following warning:
> 
>   Warning: Do not read available_filter_functions concurrently, as
> doing so can significantly degrade system performance and potentially
> impact production workloads.

Or update bpftrace to cache that file. It's only updated on module load
and unload, which isn't done much. There's no reason it needs to
constantly read that file if bpftrace is being used constantly.


-- Steve
