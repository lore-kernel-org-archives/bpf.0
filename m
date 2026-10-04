Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DE2853F3;
	Sun,  4 Oct 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100380; cv=none; b=lMKkWqM5q7/+oyzd33OGlYFXf1wKV1JIrf8y1kjYJj5qQNYW9St5/FpchOoxtru9V6WDbOVImEJrm6mJ4Z8HxjOHxJBxFSsj7UruA9iUGjucs1HRNhay8dRaLgGd+HFCxYs0nXPNjZErwf+8sZ+7GvWKOBza5m6kctT9ThD079Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100380; c=relaxed/simple;
	bh=qaA3FCUSvghvQp4of7xy8J6K3nfjoP6YXUfDz99COFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2eUoorOCqSadXY9fRaYXCm3ZgBCZ+1QvPk/5PV98j+RH8VWWabdmJ0bR4XbUyhrUWTNoJJffvzRmhC8I3rhxdlquRh7JYrapZjYNQNuVbja1krgIdumZjGRA3Glo3+AI5hyBTHpD6WFH9QPlsRBbJFo904hNf7xLxfQHdonYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=JrSlqiVJ; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="JrSlqiVJ"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 303B61C3E84;
	Sun,  4 Oct 2026 07:45:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 294762002A;
	Sun,  4 Oct 2026 07:45:22 +0000 (UTC)
Date: Sun, 4 Oct 2026 03:45:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Nam Cao
 <namcao@linutronix.de>, K Prateek Nayak <kprateek.nayak@amd.com>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>, Viktor Malik
 <vmalik@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
Message-ID: <20261004034515.3592947c@fedora>
In-Reply-To: <20261002102939.GB2823843@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	<20261001152042.124445-2-gmonaco@redhat.com>
	<20261001154934.GT88198@noisy.programming.kicks-ass.net>
	<d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>
	<20261002102939.GB2823843@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 294762002A
X-Stat-Signature: qfwpz1gpmib1tkbxtes3gznptcofz1at
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+WjOzEIJBMoRLXH/p6Vwn+z72qSKDM+pU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=qaA3FCUSvghvQp4of7xy8J6K3nfjoP6YXUfDz99COFE=; b=JrSlqiVJqG6g/c1IVI6fPZGUsWyQw7uLYL8Y0lkxuDwm83YeSpdR8wlAkEky0s/rybElQfEu0L49azhrOg/a1Hie9uBDiqSifOqY6/+YtK8aQrt8P56Tv2aA9WLcxKT0M/8GdgoHAcBiVjEW+J7cVz5ZEwG9f12qjMgWuUnCYyQ=
X-HE-Tag: 1791099922-219789
X-HE-Meta: U2FsdGVkX1+1LvFSPawVsPnS8oyr2Sx+JjRcNfYLmIG6ky6VrWp9Z1JJsULduW88gQ5JVoVdJFvZUl9ST3X4QVUllBtfr+IqdhkR+cMNFfiebtjXCxcQqSDvQKUnn0RvyimIgbLBr0nbbiBHRHPceLYT1b3xj0iQflDuWntW4aYNxHPgGrVPTtP1LgObsom+Yg+u3MJFLGXUxCEL3XpYURrZStndPiE0TMGr7wB+3JeG4FMxQhooM/5G8OKnJLnjoUCiJ1PVKtXbDjkItl6ixop3WZuRZXjL1XzgkDs3coJaI8girgzgtC+XGTIb95ta+OgecalJdDbLAP55nTS3JZ4DyJU76BaZR01zybRNbBivwKe89vhLUH4NDW8EJIpiPbHN0uvVktmryUdYVXCoaw==

On Fri, 2 Oct 2026 12:29:39 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> ...insert rant on what a piece of shit rst is here...

Rant from grumpy old guy that doesn't like the new stuff ;-)

-- Steve
