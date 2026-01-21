Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2F301012;
	Wed, 21 Jan 2026 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010229; cv=none; b=YrJupn8pjXrnuqTxg8xEpqfG1t1oxiQAiGu36Hcw5J4IvJ6LF9YFzouwG5BKx6xmgqu9hgCU4e3/U96O3NqhvC/t9B7kehca+43bHRWoI1B57YgH7axOKr3S0lGN2AnBqrWEW14UUclFz7Nsz1cpUM9cKemJonLIIE4Z40SXfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010229; c=relaxed/simple;
	bh=G2vXtamRnDg/R6VxZv/8GQoGBLBxTn2hiPT+ehj/sQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIxK719XhT30sBBrVaUXPER9RVS9lJuZmg/lZQ0b/bjQZiwWbSDHfHe1qyg4If3OPQSRHZ3WVBnV0tRObJmHf3oOw8s3a4QBjoyobRzxmK2JoZMRxTu9kR0oY3k/08OqO+FHvsCiJmP49x5JqMeShGHXkgdGMj2HxgRhD8nEwDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=cya2h7Zn; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="cya2h7Zn"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dx7lD6mKvz9v1F;
	Wed, 21 Jan 2026 16:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1769010217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2vXtamRnDg/R6VxZv/8GQoGBLBxTn2hiPT+ehj/sQ0=;
	b=cya2h7ZnKNVdyoq38V87Hg1+4xa7pV6mt68ib34yDgOX1b7H2FS/R8knCqLWkiwLpgmW/p
	hKlDohRf3N1vLRcXtrfneRAVxyTAOM2bYHJhsSSzq/ZmSHIa5Rh0x5LKFi3yP7e9kx7zza
	MIA01oo6s4BGU90ImwEoEBxyDKX5/f7UYgSunP/+6Qv29tzwF/MjAt8VjvnYWGSwbIE1O/
	OCzgfULIu5058b0LUdVdOt2fpAZQK/wfTUhZF9rRkWXFB2v849ZCxPnlE9zu35zq79wn1N
	hENJTOz17rWVIaem2DURlhE80ROBe9FQ01DcTR/eraK7nRxazE/zwudN+evutw==
Date: Wed, 21 Jan 2026 16:43:29 +0100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	kees@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>, 
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v3 6/7] seccomp: allow nested listeners
Message-ID: <2026-01-21-tame-yapping-name-paste-hnBZQp@cyphar.com>
References: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com>
 <20251211124614.161900-7-aleksandr.mikhalitsyn@canonical.com>
 <CANaxB-z8+UhZ+smuocN8h+YZY9tdKobhAu3H6fmzq+WzFmMrjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dvwmdfxdfvedm6q"
Content-Disposition: inline
In-Reply-To: <CANaxB-z8+UhZ+smuocN8h+YZY9tdKobhAu3H6fmzq+WzFmMrjg@mail.gmail.com>


--6dvwmdfxdfvedm6q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 6/7] seccomp: allow nested listeners
MIME-Version: 1.0

On 2026-01-20, Andrei Vagin <avagin@gmail.com> wrote:
> On Thu, Dec 11, 2025 at 4:46=E2=80=AFAM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > Now everything is ready to get rid of "only one listener per tree"
> > limitation.
> >
> > Let's introduce a new uAPI flag
> > SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS, so userspace may explicitly
> > allow nested listeners when installing a listener.
>=20
> I am not sure we really need SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS.
> If nested listeners are completely functional, why would we want to
> implicitly allow or disallow someone from using them?

It can be quite easy to deadlock a process using seccomp-notify (even
in the single-notifier case) so especially in the case of container
managers I can see the argument for wanting this to be an opt-in thing
once container runtimes have verified their notifier won't break
nesting.

Then again, you can also use seccomp to block
SECCOMP_FILTER_FLAG_NEW_LISTENER directly, so you don't really need a
separate flag to allow nested listeners (unless I'm missing something)?
That would make it opt-out but presumably filters that allow seccomp
already use an allow-list for flags.

> Actually, even the current behavior of SECCOMP_RET_USER_NOTIF looks a
> bit illogical. I think the following behavior would be more expected:
> instead of running all filters and picking the most restrictive result,
> the kernel should execute them one by one (most recent fist). If a filter
> returns USER_NOTIF, the kernel pauses immediately to let the listener
> handle the call. If that listener then issues "CONTINUE", the kernel
> resumes by running the remaining older filters in the chain.

I guess there is a philosophical argument that earlier filters are "more
trusted" but the seccomp security model has always been that the
strictest filter return wins and I don't really see a strong argument
for deviating from that for USER_NOTIF.

--=20
Aleksa Sarai
https://www.cyphar.com/

--6dvwmdfxdfvedm6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaXD0IRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9GZAD+OeLuY2g8jjqiEU9GTpbb
m5NL9jva/A/TDqUxpakrP4oA/1zVQiJMYb5EuTZN452sDAKb0/26IXnWlVIinty9
9jIG
=mdF0
-----END PGP SIGNATURE-----

--6dvwmdfxdfvedm6q--
