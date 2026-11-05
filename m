Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900530;
	b=RM3DWjBXjaAfd7ALguBnBZHAziNJ+CYE7tJ8Q6Ol/4XPMeOxNvzABe49TTY4fjNrp4NW
	 zaje4PlWEvZDA1w2FIAa4/J0hcSh18jVMvkSeIa4eDZZCnk8HmIJemxSjpZtLUcyVxavT
	 xOiuc0CYMvK0/4tJEgA7SbvvNnuA9EpWAO5IiV97blLr2fccgDb5mUxTQvXGQlTT3mb+t
	 9RnZ/HZKbePY2ycHpuYbCCB0xV9UlM00oGnpTAX4fTnsfPqvSSdTdgRv2inrq+2VyF49Q
	 Qm7+ndz5nAiBncZLPMXQ/xU1KH+EGUrJJuDtMXPzgtP6ozstWktoBayPYeOJlSAsfdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900530;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0rXJbNmYKVxxCLX1v/9lf02/YwIQm3gFrERmrjN+1QM=;
	b=oKGlD7RqT6GNwRmzpImivkTpuKD0D/mB+Q53fk9daF0iBhebGkZbcgiLu0LLVWyB+aIB
	 pNJiSrPmHCr3cLkjI2iH83+Kzpu1jVb1kFmUlLONOWxWUVGazzmj8rw6YLM1A5gSfgWcQ
	 YAjMb5/yuVdsJydTv0yrFtcfl119JXEyipjwsq4fgqE7CnmSPvL/kmx/WhqlYuhV1ahqb
	 owKCWLzhq1sJeADqDTvQrw6mJdL3hV5ldFz1BJMkpKlyauWruWafsuEMVbd9G0o8njR03
	 vk2KliGGyCx3opEjrqacayVf/5qskEJ3cXAI+qAkmFVUk0ml5yVZpJipJwg/9t5b1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qa1DlUGL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E413606A31B;
	Thu,  5 Nov 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qa1DlUGL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDA51F000C1;
	Thu,  5 Nov 2026 17:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900530;
	bh=0rXJbNmYKVxxCLX1v/9lf02/YwIQm3gFrERmrjN+1QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qa1DlUGLxUY/8uO2FRVrri2F8vsGfZl1yWCTUzmA1IApUTonvbCu7kKbl6KAXSMRP
	 fa1CkT6wTADxDzzOA05xKHAxkwETAOpScyUvte2a2qMZrolCiulG5AHR3nxGxQj27i
	 mNHfEWrh+ozaIbdfAHzbuVkiZ0CpMN863R729Mgnb2FBckKNU1ilyztA61Bm/64BZ9
	 yuQtacxXojAIMZVKAkYgFOgbdH068BJGA+d7WCGHOC+YP9Z1+KN7Nzai9RNVEnfKSI
	 x6C0QJDe9lF4u2AUCHbGr6wmJiGa6O+oHk9cKP7+QdjzWE6d3bN4/ILxLQxtHyoDD8
	 8azgLEU5V6rxA==
Date: Thu, 5 Nov 2026 10:42:07 -0700
From: Tycho Andersen <tycho@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Sargun Dhillon <sargun@sargun.me>, Hui Peng <benquike@gmail.com>, 
	Bradley Morgan <brads@mainlining.org>, Cong Wang <cwang@multikernel.io>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] seccomp: wake poll waiters after failed addfd send
Message-ID: <auy_NtEpqMU-g913@tycho.pizza>
References: <20261104103736.71956-1-parri.andrea@gmail.com>
 <20261104103736.71956-2-parri.andrea@gmail.com>
 <autZ5kL0S5MkX_8l@tycho.pizza>
 <20261105153735.5368-1-parri.andrea@gmail.com>
 <auysN9YTg8Ih8QLZ@tycho.pizza>
 <20261105173530.39081-1-parri.andrea@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105173530.39081-1-parri.andrea@gmail.com>

On Thu, Nov 05, 2026 at 06:35:28PM +0100, Andrea Parri wrote:
> On Thu, Nov 05, 2026 at 09:25:17AM -0700, Tycho Andersen wrote:
> > Seems like a solution in search of a problem to me.
> >
> > Is there a sane action a supervisor can take on failure here besides
> > killing the thread that made the syscall? If so, perhaps it's
> > worthwhile. Or maybe it's worth it "for completeness" and I'm just
> > being grumpy :)
> 
> There is: seccomp_handle_addfd() puts the notification back in SENT on
> failure, so the supervisor can still reply.

But what would it reply with other than EMFILE as you note or SIGKILL,
both of which it would do inline with the ioctl?

Tycho
