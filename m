Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895920;
	b=JYCu9YrBvDB1Yj2+XJEGYPDPxx4WazbXRkQLQMDMyaCRVq+8B4CU+bOd2Z+GcrhMKqz0
	 zrxL+sz63G/BTo5a+Xv74jnA5cL/VF3tKf1Sktr9vc8wFHBcL6zOK4FWKXjXpqqi3rEUv
	 Z7g09ePrVA9mrCDxE/rAOgOZHa/g5dnwV/WeiPANJzSbH3twNkQ+w4j60GfPnn6O42kZg
	 WafduDIji8/X8th5Ns8gMgV4Ptpw9txilt2utUjs+oOvYr6P826URmVpU3j9wTAeLmz6Y
	 9HrWAgFzkSVwWVnqVZpuWDhZ/p+x19lH9LBneg9LWtk/1fnAY6fQipGyBFESTpKjRhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895920;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vnaIhRQS2goqRdb9w4b4AgPWmk2tvK6gk6d/1OO0oMM=;
	b=HzOonqmqnq9Vs2IoD3DI0a0r92dZbFfUpuMTJdnrGm+qdsRkr8lZjdii4R7nhEV4TDJA
	 r6k2ti/xSEWPfvYuV5BLtt57sJBzfCTsGR8Nv3sG5g7X1M0Mo1MUyG+hCJ9mxTRIKHe0c
	 QEmp9UMEzJSZraMVwnq0tqwkThzISl8XJz9111yogBYgZBkce3WiFSvNT+CNZpcmX3Lzg
	 7wPCOtMAaMRegNe/xriRfFKQ5Z6vus9SbYw8tt7qVN4B+IJSMhQkYHwW34b6Ue9PivqLR
	 JNWr+0GEWZ+jEHFuaJAO8pYbEup3lFFshb+6l2mY15SKiqwMhHIJQgo1yUM9WwIpUNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifJxzbNG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFD606A32C;
	Thu,  5 Nov 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifJxzbNG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F208C1F000C1;
	Thu,  5 Nov 2026 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895920;
	bh=vnaIhRQS2goqRdb9w4b4AgPWmk2tvK6gk6d/1OO0oMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ifJxzbNGQeQ9brCZG5+mBVnduFYTwoiA81xkh9wCf1Gjb/ETbwXaXBX/fWfKnDgDe
	 LUjvABY0c07VU2yk8sra7aKZG1Of004cZkUeRV3YBfck/XbwgF92L2w2K2+fTg0l3D
	 CJVVZMSno0QwFqDwpWALT7cCbRMJS4CAQy4+4CippI77uUgniwfwrN48NIF7S3YESC
	 kveuP4Mf+qjQiMsARi5erZ+duCVCNmjEUni863pilr0UQcVE03MNdIXFMwBd10ZZgR
	 LrAB1i9Yb6wF8HE7Z8rRj795skOMQ3TW2h4uVrM+rByL3uTbZh5J5wKkuRYhS5GJTn
	 8x3d4+veLH8YQ==
Date: Thu, 5 Nov 2026 09:25:17 -0700
From: Tycho Andersen <tycho@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Sargun Dhillon <sargun@sargun.me>, Hui Peng <benquike@gmail.com>, 
	Bradley Morgan <brads@mainlining.org>, Cong Wang <cwang@multikernel.io>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] seccomp: wake poll waiters after failed addfd send
Message-ID: <auysN9YTg8Ih8QLZ@tycho.pizza>
References: <20261104103736.71956-1-parri.andrea@gmail.com>
 <20261104103736.71956-2-parri.andrea@gmail.com>
 <autZ5kL0S5MkX_8l@tycho.pizza>
 <20261105153735.5368-1-parri.andrea@gmail.com>
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
In-Reply-To: <20261105153735.5368-1-parri.andrea@gmail.com>

On Thu, Nov 05, 2026 at 04:37:34PM +0100, Andrea Parri wrote:
> On Wed, Nov 04, 2026 at 09:19:10AM -0700, Tycho Andersen wrote:
> > Hm, don't we return success or failure from
> > ioctl(SECCOMP_IOCTL_NOTIF_ADDFD) via kaddfd.ret in
> > seccomp_notify_addfd()?
> >
> > I don't really understand why this is necessary unless you're ignoring
> > the return value from that call.
> 
> Right, the issuing thread gets the error and can recover directly.  The
> edge-triggered example demonstrates the missing wakeup, but does not
> establish that a supervisor needs it to recover.

...

> I don't know of a supervisor that waits for EPOLLOUT from a thread
> other than the one replying ... not to fix a reported hang.

Seems like a solution in search of a problem to me.

Is there a sane action a supervisor can take on failure here besides
killing the thread that made the syscall? If so, perhaps it's
worthwhile. Or maybe it's worth it "for completeness" and I'm just
being grumpy :)

Tycho
