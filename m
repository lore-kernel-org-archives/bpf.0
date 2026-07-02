Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BCE48124E
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985936; cv=none; b=aop6qnJKbZJvOLy2rBJRWA7od2ljgzUOTJAWoKZT+gmYaFrBoo1KjbRqUyT0hDBrhdR8GRMXC6TCYFbt7rioZaEnEhabF6bhef6xJhmQuCoLBVXIwBwqqMX0ffLgY3OLY8NSN4r4Iax5OQioajVxH+lQAweeb+9LfPAdvrwKVU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985936; c=relaxed/simple;
	bh=//wk7179FguVyasl50g5Wote0Tk9APu7AWvtVlY8tNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+NwJJSyzyldk/MfJTm+BUZyvEs/4XB4Df/UFym1qoPn96Nz3bGxo+x7DQmsyKZCay9A35woiAXqO9PWV7vUU+0vT/KER5ZzTh//ym+hPrfrKmQ603dL6ZICo8JsYW3Djkh0tTSQoFQ/xca7OBLV9tTp2JYvIW6U8XbL2ki/OOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=P/L3o1ie; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="P/L3o1ie"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grXGn24NszF1l;
	Thu,  2 Jul 2026 11:52:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1782985920;
	bh=oEWBJpKZfD92xrQv2OExUZvBrbU2/bp/oFr1oEXgzA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/L3o1ieylcYjqtUNm50SFSz+jYWm6i2JNuzgI5TeEZPavrOaasuRNwmLTrYJbR8e
	 je/WTUIB8Qn32AMybuitq2EGO1G9WXlNhf72tnJWb5TAndvthwjnwbYJbHXba3sf/v
	 x79J33AgbtdZNSf1c6ayNuWLHH+tRIkQwzaAlesk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4grXGk6Xp1znQb;
	Thu,  2 Jul 2026 11:51:58 +0200 (CEST)
Date: Thu, 2 Jul 2026 11:51:54 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	Justin Suess <utilityemal77@gmail.com>, ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org, 
	john.fastabend@gmail.com, andrii@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, 
	m@maowtm.org, eddyz87@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <20260702.wiegh2vahb3O@digikod.net>
References: <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox>
 <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net>
 <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net>
 <akVvkA3kmlv_POsF@zenbox>
 <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com>
 <c9abd9ab-3379-47ab-ad41-79cec8f465c2@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9abd9ab-3379-47ab-ad41-79cec8f465c2@schaufler-ca.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 01, 2026 at 02:41:49PM -0700, Casey Schaufler wrote:
> On 7/1/2026 1:02 PM, Paul Moore wrote:
> > ...
> >
> >> Each LSM calls this once to register its sets. Because registration goes
> >> through the framework, the framework gets to decide whether to actually
> >> register them so you could, for example, run an LSM while explicitly
> >> opting its BPF kfuncs out. (something that should be done at the LSM
> >> framework level).
> > I'm not opposed to the LSM supporting a set of kfuncs, see my comments
> > in other threads, but we should treat these kfuncs just as we treat
> > other LSM hooks today because that is what they are: LSM hooks that
> > happened to be called from within a BPF program.
> 
> As someone who has been working to get the SELinux specific assumptions
> out of the LSM framework for the past 15 years the notion of adding
> Landlock specific interfaces makes me want to cry. Is it really that
> difficult to understand that 5 or 10 years from now something is going
> to come along that makes any LSM specific interface a nightmare?

From my point of view, your work has been, and continue to be, very
valuable and helped improve Linux security tremendously.  Everyone agree
that no LSM should implement their own security hook.  But that's not
the topic here.  See
https://lore.kernel.org/all/20260701.aeghohNoe3ek@digikod.net/

> What
> if there's an LSM that does what Landlock does, but does it better?

Then the eBPF programs will use another kfunc, specific to the *new*
semantic of the other LSM.

> What if the Landlock sponsors decide to quit funding it? Or the maintainers
> get bored?

It is the same for any (kernel) interface: going through a multiplexer
would not help at all.  Your argument is sound for security hooks, but
not here.  Security (or access control) hooks make sense because they
identify a set of specific enforcement points in the kernel, and any LSM
can implement such hook to allow or deny the related operation.  Other
hooks are useful to keep track of the kernel state.  Again, see
https://lore.kernel.org/all/20260701.aeghohNoe3ek@digikod.net/

> 
> I agree with Paul completely. Make the hooks available to any and all
> LSMs, or don't make them at all.

We don't need a security hook but a function call to one specific part
of the kernel with a very clear semantic that only make sense for one
subsystem (i.e. Landlock in this case).  It's the same for other kfunc,
nothing special.  The same way it would be a waste of time to implement
an in-kernel multiplexer for a set of unrelated operations, I really
don't see the value of adding a generic kfunc that might perform an
action according to an operation argument (i.e. multiplexer).  Why
implementing an ioctl-like interface in the kernel?  I'm open to
suggestions (and concrete proposal/examples) but so far I only heard
authoritative arguments that ignored most of my comments.
