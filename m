Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A41A294;
	Fri, 30 Jan 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741415; cv=none; b=gSSls0nrB534xA6ADFTwJNudheM0/IX+3HaGrbu42+v2Ig2L5VZa+XM1Q8QCILBVI87IiJU2ydJXQ+xdtv19K53QvtKnFpkSc7pLGuH92+TeMjt98SxvBMMzaSne62Qeb2y4bBbW60mJyX52SrBw7AhuiSwi0aNkoirHaL29w/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741415; c=relaxed/simple;
	bh=C0EzNO/s5vOx1RH3r97aHPUX22mFp2XFScqj9bBwRJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cU/xvNNIkbdl0T7h6jbY9NAmN4EKK1Q1kHsvuWbsfFMJC35qyku/bNrrwJAz+vCHwnD6auA3XI6KMsb/b5rPY8AEje8wVNg/QZY+n90Bt48jHFNb5O6731or3A4nJta8cZIJDL0FaJM39qjnt5e1cxBMTiwfXJcIKY5yAm2AF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id F09D2B84D6;
	Fri, 30 Jan 2026 02:50:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id BBEB920025;
	Fri, 30 Jan 2026 02:50:03 +0000 (UTC)
Date: Thu, 29 Jan 2026 21:50:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v6 0/3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260129215002.47fefc88@robin>
In-Reply-To: <1d6300a5-61a8-498a-8d40-b529bacf9a8a@paulmck-laptop>
References: <20260126231145.728172709@kernel.org>
	<20260126213922.0a91bfac@robin>
	<581f0711-9115-44e8-a616-06cd13563f8c@paulmck-laptop>
	<20260129193359.08230ac0@gandalf.local.home>
	<1d6300a5-61a8-498a-8d40-b529bacf9a8a@paulmck-laptop>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BBEB920025
X-Stat-Signature: jdx5oe7zae1oiebwtk99qdb8495ej9fo
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+W40uwtlUQmfwzxqhvqV64hrT80HkowJE=
X-HE-Tag: 1769741403-543040
X-HE-Meta: U2FsdGVkX18m6mVexk2/ZaOy2phXoO07/Ff6F9L0yY51xwdCYcu3xbIGnixvVqZyMpu/BwdJUFkDOKWlIFVcJLFYj7WlzQrW4e/GYdRhkXiUfN8zTwhV9VLh33TfXE7IKeZ/tiKV4sQWpx7eihyV2LbrWcJVS8RulZF2KCqRFiEGpSH+cJ2Q0O3RBACdFfo8VxElKFM5J56P4sbn8MjbcC37Qd6JTKuBS021CDgacb9XbTVCkRGcszXq0dCoinT/dzfIKu+9oVU1FpWaL+Rh7UQs34FIIQWskIFQG/M+BNqZXqXZr4+zW5LVaqH9lC4GbXbvHgkN1W+Gxo7mx9lmQTumr/HbYERjDZjVSkywX3xxmsZk4xsOCA==

On Thu, 29 Jan 2026 17:32:24 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> Thank you, done, and apologies for the hassle!  This should show up
> here in a bit:
> 
> https://lore.kernel.org/all/8232efe8-a7a3-446c-af0b-19f9b523b4f7@paulmck-laptop/

I can get it from there. Also if you Cc
linux-trace-kernel@vger.kernel.org, I would be able to pull it from
patchwork.

-- Steve
