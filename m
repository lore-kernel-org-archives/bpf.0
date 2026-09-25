Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75D4AAC77;
	Fri, 25 Sep 2026 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346726; cv=none; b=KAQokgMs6ACGX2YpDYP9VDizez/GAYfbs7d6dFlPWOzhMGjTrLIzMkHUC0L5SV/xz4Wm+1H+ATKfqfLBaVy54eL7+YLvwkym+d+Lpxre2nV1aH4eelN9HsIcy+0uJioxg3Xa3rG/PfZvPLo0PimsRXojKsvordi+G+OIEnQ+1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346726; c=relaxed/simple;
	bh=HRt3ItYXKFYTjx1xmu/QidkPVTIFzninFZNFu8pA15Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl42c+hmlJVQxbQ4SLh00YCriK/4CY/anPTil6Gqvf6rLhcCht1AfkFN47BxWH8XPOf/RVgHcHHvv7//54harHTta8GDgAZVUeJsgN1IvBsq8zwn4HNiV0T3BYEZMDbYp3mLiu5P7lJCKO0wUQ7KA4RnGCM2qsgayFlV98zB1YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TCA6XtXP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1jXvri7n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TCA6XtXP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1jXvri7n"
Date: Fri, 25 Sep 2026 16:31:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790346718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+JIL95sFEZcCx14lpDodVix1cIsP41lmjXHFkrMk1m8=;
	b=TCA6XtXPBrNcIzBwJB1OVxjDwrJMlTQjFnIgkDjDLiuDToIBh6CYJe+ZGIHF0BumDNfCV6
	gckLNBZucUEG7W0vYJ5iI+FisXiK6MgQK+KTufXkTo00upcujKiNh3uRG9iojSOO0qjeNB
	3eSIzO6mz22MIkCy7BbhnhvEt4Zt4crvRzuMAjP4XP6OGSWv7/ps0Jj1tUndZDdjj48NCk
	iQI/f063LdspiE2vCPXQv9c35zwKO/16OL+5gpMuo39Hq6Eiy2zHZivuRs5u6CSZ+Gyv5D
	4qYNfVzSzIVgaubDD9DixCbj/xbZVnhTReo70M9XGFJTNn7y45SQ692UGGQJcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790346718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+JIL95sFEZcCx14lpDodVix1cIsP41lmjXHFkrMk1m8=;
	b=1jXvri7nMuvBw5HCzlHfXy9tg9qEk4Ee6RqN4OBHWMweIUEmb+K7bBYft6Jmw9X0NYdI9z
	Qx0AvOQOmFx7dDAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Harry Yoo <harry@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Amery Hung <ameryhung@gmail.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible
 context on PREEMPT_RT
Message-ID: <20260925143157._HIZ9lrl@linutronix.de>
References: <20260919171443.90512-1-kmehltretter@gmail.com>
 <DLJHZEZMLW0F.27OPPS218CX9Q@gmail.com>
 <arIY0wMQjCCsqidI@gmail.com>
 <DLO3RV3IQUOV.21BNLF4QS9T4W@gmail.com>
 <c2f8eb01-7a10-4ccb-92f1-eece29c06cd4@kernel.org>
 <arZVV6Vq-ZJuCyun@thinkstation>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arZVV6Vq-ZJuCyun@thinkstation>

On 2026-09-25 12:05:50 [+0100], Harry Yoo wrote:
> > e) Introduce raw_local_trylock_t...
> 
> +1 on this :)

maybe consolidate first the existing variants :)

Sebastian
