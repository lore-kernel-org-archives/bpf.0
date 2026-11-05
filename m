Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893071;
	b=N0DcbdRTIhe5s17eRI9L6hdvxP1ComK5DjYlDaCeoqiNqsSET2s2RhMOt6cQsSU3g+By
	 48EV+59R6p4nejaXhWBWzFf/IV8pIuy6xKnI+zWy0NEOc7tVOwQLXFjQwZLbn7h7eE+mp
	 O6uIfANWoI36C1B6qER6ouY/mnssDzq8R+KFmXpVFE3c9n0DaYS9sh7gzcKocwSHmS6RD
	 sB6sjnSJu5Byd43xbprA93OkegWgfEpmckqCa/NloPsB91DN9Pwa01TMwA9FV35yoAQOm
	 6h8pIoQljGuPQm8mfGxqsMEyLITrrkAfPwH+q2fbyquq6EbwF8ILKaqVZ+e+JUB76VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fet26sVrxKqTmXFV5z0zr0pfRaJkw61an1sCfVShooQ=;
	b=EiVwt4B0gcRo34Aa6h7EFVDVQxdBl8aFgrjrPLgQu9LlzwBTR6ZWFlt/1+wvQqHRh6QV
	 zhq1ZWFEaemPWGLq/JN5Bl6mxyGbCyUEZXitc4Vt4QqG3fdyPjeH2T2h7OY0jVqK+mRkD
	 O6wMNhUt8Dr8aEIX5KeZRtxm5hIGpCWkeDn1wyusmeDSFSK0Czcr/CQ6E66JFDzCnyAyp
	 2/uurmR45gS4PwmsgTMzH8/1g5lKxs5Kz/fHlRmu0QjXAsphVNdKFpQf/Z5cAR48ttyWj
	 y1EfKNtC6048t8le8fYQJ5+/7DBmWZOMds6aJjINtcYYcegZMVWJozt0/0yLaOkbhtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MI7FeziX;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3C606A333
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 15:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C3C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MI7FeziX
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so4669755e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793893064; x=1794497864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fet26sVrxKqTmXFV5z0zr0pfRaJkw61an1sCfVShooQ=;
        b=MI7FeziX2e+PiUMoRCZ1LaVg8Ln7yDJ5UrS1YIsru6G3Vz6euXAONYeEpVryTIQrcF
         hukPnwTDZoGv0MG2l34dSNeapvlrO+NSQXuQenpe4A2lbX6LBo0Dx7oENYMZuvTOXtBc
         h3dPRN3mL5q1gHJYHQOJzI9l6uvbhyqui/Fe47QvccQEvupfXKAVC4CG+xfKQj7lKYvQ
         14CK/TzKtYYhNWrAWI+EG2hRBoIMZpjcHXY4et7icjQJFvtcBOhcuFrO1VYzwR8uWvb9
         Gm0sLXjwCX7C9J4JTm4vTwqm36Ky5zg9AN+IxYdue4DbWTQHG1PlqB3zvoxH8mbF4q74
         iI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893064; x=1794497864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fet26sVrxKqTmXFV5z0zr0pfRaJkw61an1sCfVShooQ=;
        b=c+SX535y3ak92UYa1VTwqSoGhtJpBC/9Ouvh5c+Aa5Dy6nWzPcr1JdbPay/awrKUjv
         EDrdlrJGehze2XpjhHTxIB+OQEGgiF6gd2CsJV9mLDbkA6jILzjhu4AwXTC6AyCRYAmt
         64SEqvUAVDCp5HuwLpvKmj4WCPEcdbILByNsSfrS5xYoG85hdgZMuf+CRI35n/p/1MJ3
         QtheQ2AT6CPOr4lgnqUhRcTnRg5CcZAtpOtyln78p90hQPF7he3tv+Kamj4n4NnEMDJ3
         0qOJT5noegQjtb771qFURZ7FOlCiyotPrEHF5la4memXQfWDNEkjKFrwKv4cQIsvqc9N
         Mqzg==
X-Forwarded-Encrypted: i=1; AKwUvBwH6QHV+DfjxQLeNs/n9KF+0nPCNRUVK/fAINBJ/7VXwIgs8OZl0m0pI0xvAi4uTBAsX4o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AxjaDS/lO1IkZ5B4fQu8LRuzZS+RnHEtvhmOqUF0ATBbHbjMH
	yn3yzDTx7BiPcdW8dsaFnHjXYZz9W6+f2nfCeA5hDTZ/5jUWUdISUBIZc6kQ8Hz+
X-Gm-Gg: AYBFou3AbNsIJP2Zx+nrAjsJn8lfDewhDZXMOO8VZKP9TN32VtvAMITI0qDXW/ptXOI
	F+3+zCdPVXt6FbrIjIF5PML0TaZ+uOxBpXWCnpAC4SreVfT0rOuW0am0b2HSjeAnAixyNLS2sYA
	iJRH/kDdvjxLmuPYf7sIyWvWA6Wx60CMZVgxE1j8Z38DLwVxqnIj3uwWomADkvD+/dqdByhI9xz
	wU5xqO9likl2PAzppYlKP2f+CQ9N0YPOhL6x6fFdV+DiaUa6IGvNO7rPXDShTl9GDy9+bEfUD7+
	OQvKF3Msg38OYALYU5j9AjFd6Eb8GX1b3XDV1RkWRgmlOiCQ9JBSt+mhrNrRPW5bsommPXsjq8t
	jjjaMOSko72ZfsDVdMlV4jz8GK2y48WWxnnFSujZY9T5KP8zBf/5kRv3xc/pRQatIFYygjIzYrI
	drbGzVeTB6OHghTEEJiRP3+vcpzHMYlor6F6TCMjd1i8u3sW5iMmK3Kzvf/lbLioOCbvP94Gjo9
	fbSA6oYhzQufbtIidVrw+G1Ut2mqTxEPeeJrGMP7Y4QemfF5ljeN4ed99pcg52YkCORYBoKO3kj
	C15ae9GvuJvI5prKwDqgiAhdVJ2qLYcJOjRhJKLJWynmGkacsBeO0XLmGKJNP6/qwCX92IkhaGY
	2SFQAJXazvgxw4dm2JL5c9D7sL0G9Mw==
X-Received: by 2002:a05:600d:82e2:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4b55d7d7a2amr57882865e9.10.1793893063915;
        Thu, 05 Nov 2026 07:37:43 -0800 (PST)
Received: from andreayoga.localdomain ([151.43.242.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f5e59d3sm79741485e9.10.2026.11.05.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:37:43 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Tycho Andersen <tycho@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sargun Dhillon <sargun@sargun.me>,
	Hui Peng <benquike@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Cong Wang <cwang@multikernel.io>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] seccomp: wake poll waiters after failed addfd send
Date: Thu,  5 Nov 2026 16:37:34 +0100
Message-ID: <20261105153735.5368-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <autZ5kL0S5MkX_8l@tycho.pizza>
References: <20261104103736.71956-1-parri.andrea@gmail.com> <20261104103736.71956-2-parri.andrea@gmail.com> <autZ5kL0S5MkX_8l@tycho.pizza>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 09:19:10AM -0700, Tycho Andersen wrote:
> Hm, don't we return success or failure from
> ioctl(SECCOMP_IOCTL_NOTIF_ADDFD) via kaddfd.ret in
> seccomp_notify_addfd()?
>
> I don't really understand why this is necessary unless you're ignoring
> the return value from that call.

Right, the issuing thread gets the error and can recover directly.  The
edge-triggered example demonstrates the missing wakeup, but does not
establish that a supervisor needs it to recover.

The wakeup matters for other waiters on the listener.  A thread or
process waiting for EPOLLOUT while another one issues the request can
see no EPOLLOUT while the request is pending, and nothing wakes it when
the failure moves the notification back to SENT.  seccomp_notify_recv()
wakes EPOLLOUT on its transition to SENT, so the two addfd paths are the
odd ones out.

I don't know of a supervisor that waits for EPOLLOUT from a thread other
than the one replying, so the motivation is to report EPOLLOUT
consistently when a notification becomes SENT again, not to fix a
reported hang.  I'll revise the changelogs to make that distinction
clear, and drop the stable tags from patches 1 and 2.

Thanks,
  Andrea
