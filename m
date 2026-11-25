Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606601;
	b=2zwO3+ZrAl/LSuax9Y6Du+LMijQbOn/9FiQALRdFMEdPX5ERlQSorOS6/0l2TUqYd159
	 OysBxFjG5pMG9/QK4YZ4DqLSA2ZS/vEoRdNlUrLs/iJ37TuCBeH/D7yWo8jTLDW4oNTHJ
	 CSQPAmwKXwgV+F5SaKZSkfdV7oby561yE0IXX9+vVXHutF9VcSa/Fms+Jw9wSIFi0tHSB
	 jjnitIneHbQ4yghBJr1fdMJsefZ3jw1PCTA0xRJadiXHbft78Alo6+diUq3Fy/Zui3LzD
	 u4FxKVApAMZi3/aHMR+RzdmEk4MApovJ+WJbnrJaeDIaRscCgcZRjqCvM8iKkI9L0/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606601;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=8lUtvBf4yp1q4uRBQvvRAWZrQAMHjkc9iS4tTLTfDyA=;
	b=DBnZpzFGBb/WAYP2rPeoeaa43xkfgIXq8yen3D9VEURt1Ut0USno87+GFSLGdWKrQg9v
	 liAqrioODjLA/pj1kbz6ebTnchLJdArVN0siKlObg6QhpaZ8ikP20F2+vALfZrXyZ4kSO
	 sxWMwtRnEAD0hIwOagU4NezT+kZp4SNbmZTgqYqyKs14695bpxXscqKCHhcOBIz5SA/9Z
	 EDiSpxRi2QEWSBkXzRfwgAJfU1kYrocdfaD+7HHlruSyQdJ1DmQ7QN0+yAxsr+Am+7Lw9
	 +48wcaC6bJqS7v6DGgvSs+V6aiqPP5gvjUhHMmpM3qSzq4M9Q/1Mc5A+W2ws/f+xplA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEK+WUgT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54237606A31E;
	Wed, 25 Nov 2026 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEK+WUgT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9D51F000CA;
	Wed, 25 Nov 2026 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795606600;
	bh=8lUtvBf4yp1q4uRBQvvRAWZrQAMHjkc9iS4tTLTfDyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEK+WUgTJdEarfLjej1HEQDPg1tpmClXTWZKCTeuWPyTcUZTsgfsbeVmYw7beWYif
	 SCn5YZyW62ypU6+YGtN40Xm/UGIBnPPVp01hWmUc0KXSHwHxLNPKNiROGjNDjT9FNh
	 0dQjV2DwEIcwBrvnMZGycFinF0L9HNUThcW5z8UTA0s1/q+EBi/JGIr+Tbud0bnsWH
	 uRfUh4yStcTsT8j9CDvLcqoRY7Q8R0/ib7q91r0cBsW0SMgxSrIQK48n12s6b208Eq
	 nQXKyqVc15Y5aBdK3k2ARBhNywi6Ubv4RGlW34ti4WdcyOKEdzvxTdINKeYIZRf0ZM
	 7mpix3n+1kJvA==
Date: Wed, 25 Nov 2026 11:36:34 +0000
From: Simon Horman <horms@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: Meghana Malladi <m-malladi@ti.com>, kees+treewide@kernel.org,
	laixiangwu@cmss.chinamobile.com, philippe.schenker@impulsing.ch,
	haokexin@gmail.com, devnexen@gmail.com, jacob.e.keller@intel.com,
	sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, danishanwar@ti.com
Subject: Re: [PATCH net-next 2/2] net: ti: icssg-prueth: Add ethtool RX flow
 classification support
Message-ID: <20261125113634.GT31322@horms.kernel.org>
References: <20261118184729.2302130-1-m-malladi@ti.com>
 <20261118184729.2302130-3-m-malladi@ti.com>
 <CAAofZF4XYd5z8X56DRARMxbu3t7QX48T7V69MPBw9TW1BQAmKg@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAofZF4XYd5z8X56DRARMxbu3t7QX48T7V69MPBw9TW1BQAmKg@mail.gmail.com>

On Thu, Nov 19, 2026 at 10:19:48AM +0100, Marco Crivellari wrote:
> Hi,
> 
> On Wed, Nov 18, 2026 at 7:50 PM Meghana Malladi <m-malladi@ti.com> wrote:
> > [...]
> > +       mutex_lock(&emac->rxnfc.rxnfc_lock);
> > +
> > +       /* Check max rules */
> > +       if (emac->rxnfc.rxnfc_rule_count >= ICSSG_RXNFC_MAX_RULES) {
> > +               ret = -ENOSPC;
> > +               goto unlock;
> > +       }
> >  [...]
> > +
> > +unlock:
> > +       mutex_unlock(&emac->rxnfc.rxnfc_lock);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(icssg_rxnfc_rule_add);
> 
> nit: instead of mutex_lock() you can use guard() [1]:
> 
>     guard(mutex)(&emac->rxnfc.rxnfc_lock)
> 
> and remove all the "goto unlock", returning directly. This handles the
> automatic cleanup.
> 
> Same for other places where you're using mutex_lock() / mutex_unlock().
> 
> - [1] https://docs.kernel.org/core-api/cleanup.html

Thanks Marco,

That may be good general advice.
But for networking code the explicit approach taken by this patch
is still preferred.

  Using device-managed and cleanup.h constructs

  Netdev remains skeptical about promises of all “auto-cleanup” APIs,
  including even devm_ helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.

  Use of guard() is discouraged within any function longer than 20 lines,
  scoped_guard() is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.

  Low level cleanup constructs (such as __free()) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  __free() within networking core and drivers is discouraged. Similar
  guidance applies to declaring variables mid-function.

  Link: https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
