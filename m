Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809154;
	b=Lyj8HJhbbi1arK6kRMO/nBEXndkeoqVKo4m/Z6TWOR/UMaL6ItC3/U5I3w2o4MbVxaGa
	 Yj/EKVoygWXf4U10lko9BYzdy9ivrzxb/czE8R+BDN/fqQQMHWMsKakmsRcp/ajbx6Bja
	 O4Vo9HeUYuVejKAocAixGL8E9Ra7F/h4Dh39G9D+SBPZ6wRKWSkd402jdJ6FHArVFs50o
	 cRxbWp+d2+QrMunEB1JaXQXi5kWLL1dySsF6ypI/lL1XSXwVyAEeBsYbfthlgFj8K8sde
	 opIUGqF4uLef+6NOUKZBpjHz9OuV65dROPquIbX7iVFhtEVpXkV73dePzZtTE8e7eIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809154;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ucz2SBPoB9uUFee5k/Js6Kv19gdEkvehuLh1RFosZOM=;
	b=Rkw3Eddb0+5HW2/EavwhVS4lmAhD4NIrsZY/+4bmnPZ5D7kqevIYc2D4t1GQhqH/G5Zj
	 hdAjVAEfOd9vJHDBiufwd2udMQ9cJiUNpQhYtgldAijoATTqTsPnXvOFSSNvt6iTIIokF
	 grhRhHBj3t0J0h8hSK7F2CT9m2cGGl9OnK/YDkrZ5ryD573rUnxyyh59DxdSr++oJS2hA
	 SybXbTR2kbdm0fL7/pYBxUMDldelfO0dEL36hqYQp8jIsFclJi822y2l4JVUfFuVDOM99
	 /91jLlSScLp/4pGF0dLScbWty4HWHo2eMgyrek98tWf26Ba10qs1B32G3yvB4zuNVLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZLvHVa8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB419606B8D1;
	Wed,  4 Nov 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZLvHVa8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6C01F00A17;
	Wed,  4 Nov 2026 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809153;
	bh=Ucz2SBPoB9uUFee5k/Js6Kv19gdEkvehuLh1RFosZOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fZLvHVa8GSDamZHM6d9h556tpGedVZFITBTUyMhQiUSzexv5beamo1kC5Vy8KI/N4
	 uHSZ1okkeKMvlA68VAKVqPgRZU0Ui5nDZiySWbZhtvL3OO/FC/iFTHEzwCsJBt/j3X
	 naDGtOzc003VOuFSr4ASOyqDfCjuYhFZWqr141iCspMXlefeBXDSl2inwMz1ptNVMJ
	 7kcjMIbQzqAob2ZR0LzP9SgJgyRoPOqg2CuJ0IvVAYcredXCQK1Q+pOWhZ+Lq8lFvr
	 L6f/wOVN8inQ5fzt3ZbA6xMBG7ExJS8Pjw0nMprKt6bl+IjlgOiO+ukbSMLi6+Z5Qr
	 x1F9+y3HwrwtQ==
Date: Wed, 4 Nov 2026 09:19:10 -0700
From: Tycho Andersen <tycho@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Rodrigo Campos <rodrigo@kinvolk.io>, Christian Brauner <brauner@kernel.org>, 
	Sargun Dhillon <sargun@sargun.me>, Hui Peng <benquike@gmail.com>, 
	Bradley Morgan <brads@mainlining.org>, Cong Wang <cwang@multikernel.io>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] seccomp: wake poll waiters after failed addfd send
Message-ID: <autZ5kL0S5MkX_8l@tycho.pizza>
References: <20261104103736.71956-1-parri.andrea@gmail.com>
 <20261104103736.71956-2-parri.andrea@gmail.com>
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
In-Reply-To: <20261104103736.71956-2-parri.andrea@gmail.com>

On Wed, Nov 04, 2026 at 11:37:31AM +0100, Andrea Parri wrote:
> An atomic SECCOMP_IOCTL_NOTIF_ADDFD request stops the listener from
> reporting EPOLLOUT for its notification while the request is pending.  If
> installing the file descriptor fails, the notification becomes writable
> again, but poll waiters are not woken.  A supervisor waiting for EPOLLOUT
> can then remain asleep, leaving the target blocked in the trapped syscall.
> 
> This affects edge-triggered epoll if the supervisor consumed the event
> before the request, and level-triggered epoll, poll() and select() if a
> concurrent waiter found no EPOLLOUT while the request was pending.
> 
> The atomic path changes the state from SENT to REPLIED before asking the
> target to install the descriptor.  seccomp_handle_addfd() restores SENT on
> failure, but unlike seccomp_notify_recv(), it does not wake poll waiters.
> 
> Wake EPOLLOUT waiters on that failure path.  Extend the RLIMIT_NOFILE
> test to consume the initial edge and require another after a failed
> ADDFD+SEND.

Hm, don't we return success or failure from
ioctl(SECCOMP_IOCTL_NOTIF_ADDFD) via kaddfd.ret in
seccomp_notify_addfd()?

I don't really understand why this is necessary unless you're ignoring
the return value from that call.

Tycho
