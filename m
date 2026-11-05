Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900138;
	b=mEZ2tacw9AtA1PW1dDL/KbhQxnA1iFvdyQNahT1qxws4+oYutPvRwa3jNAuN7a+h5xW1
	 +gLZhHx2+9Hqovxt8y/r5KCyK4t3Bm1CASf7kivnuKEcn1uVf+BV2TmnSexDhEqQykelt
	 mzhUeMiBXP8bk+hAMJY3bWw1JgSgGZzEjVAL4FFb/KV2vf20MTh0lFYIO+DDcZRTtyxR6
	 9340+dZPkX+EI7qoo6cE1ognZTDXl6htn0W1uPMnJh7+7BMX8cc13Yk/pbDRcRzWZe6X1
	 SjFwPvIx7OHuURAC6342rSsT3lRYAvIjK7u066hot2dc1MiXZ8ICG86YvXx/I5pvboQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jbBB2AggVWN99JYUC8jE6NqBElHdygyw3qN7Wg/49mI=;
	b=4ALRCT3XpxH4wX4Ht+N8YRMDXc1rkSXhwNcRh/5/PYxytvlKI5Oj9a5/2SyRrOazob0N
	 R0Kg4VNtAbtYWn7F3QwrIu6kj3KWyNKTpCL76rzy6g6btxFNFEKoEglaeBr/cKhJHMnsB
	 KGJyr/sHWVG2jc6WjbwKqlHxI3/aozoZk5tr3aVHlOIsYpwacDY9M49A8tvvW945v8vIq
	 F6oduYVz953X2kALoZ0uW/luAXoyNZ8iXuG6MahhQrAMuza9NQDxbhhYQaw2shICJq4Hy
	 tDsd4eA2VxvQL/GR21qzIcnX/4/7DTy73NFIcacdnSQNvqLbufeKPwZT+zxyleZQbSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n5nnzc4H;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB85606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AB85606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n5nnzc4H
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4919a880834so536746f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 09:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793900137; x=1794504937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbBB2AggVWN99JYUC8jE6NqBElHdygyw3qN7Wg/49mI=;
        b=n5nnzc4HTVp02Yi1ph9LI3YnM5HgC8uVW2GeiUQadCxo9704l1ZItXkY2QP8kGf6zA
         RqFyfyJy1E18YMDvobl4Go0N7g+M584NANE5uRPqDy6ZHSuCIgGVuoWB0KpsRZ653T8n
         a5C5EESnUWETubsdG+44Hlt/6S9KfppEo7u6nYwCk4l9Ji1EjAInZcWrXJ5y0f08zeut
         HzKxEEqdje8USHdD4N69MdSZoZnK4VlcMWlx344bfnaRvsYQ5EGHMr8xXmClNsHYF2ED
         ILAnNX4cyeheq3XoraKYYPoDJ3nNCNfmf9kCZ6X87IXyjdgOoq4dIErCr23Ok/1ngK5Z
         57vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793900137; x=1794504937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbBB2AggVWN99JYUC8jE6NqBElHdygyw3qN7Wg/49mI=;
        b=RmFImlZZFxCRy3lw8CyJrv25xGvsUraowxsqpDIP5kcJfMexaFLueSk8ZJ/SvAAwip
         aisCZL0nkZu99fwhMgsxN7pN1uovco71+edYIr4Ke5cyAdKx+TdvfqlaCA4tdeMx7VtZ
         42zX/zLAK6KLG6/+TnJ44WuMfqsMlSVglADYxyZK14xOpdxWQb/OOp9l9+307V+pAokR
         K0Sb5yWtlIStKENDp/28MIsFg4WDPFMYgaEs9pJ0In4wwA7dJzpaTA6L8Wf1onslW1ZU
         Ipz1A4zmYlui4dwb3+FIOAmEDZ6zcDWJsRzisO/tbwpTEwqrlh325A92EL/JY82XDZw/
         PQ+g==
X-Forwarded-Encrypted: i=1; AKwUvBy2tQKfYPmUZpqtFEA7dcQltcLamMRnsSIx8btIy98f2bzbJjBEKkS6NV5IywMKZzKcTvE=@vger.kernel.org
X-Gm-Message-State: APuU4Z//Q86X9yDCHq9PFC+Vu6WIFfPdPIEZgM8LGxvOE6SAbzVnlpi6
	Kxyr+U8HQLrSefRfZyLOkrTseCzcf6DCoKF0HICZUf/wa1zbE3q/j+Ow
X-Gm-Gg: AYBFou1N5XLzhO0npWlL2jrB1sJ6Y4IxZBq1QmG95xFfTYkn1ioboR1dE6uTNigOlGL
	qGNhlrEMSY7rFci0S+jw/LO4cPhl3nEc5wlkBuX9aAq3LxjzKB8NDt5H+Ft5lb+b4oosHRsrDup
	U1oP+aEzHcAnoSi/uWGTnN+JrObr4QNSJCvw9dAyqDWkyQl19r7pk5AWg7kWwadOBRykk653HIN
	M6zn/GZwQptK+ZedkbqBloe+NaCMSlWSlWxA6z6jwCK6QAyNgZLQAyDhfzxAdud0XBE0qMfNyCA
	YEXx/nxtTVxL/47xP+cpw6yeRoVL9zmo16tie42CGWl+841MPmyksKZVHznYPm42C9iArub9275
	8w6urU+cRy8IHZXPAhtONofIo2v38SvTurDiTeS0tgcazV6W319on3r3wdOtPDBOyBb9cXns1Qp
	nAmO9oLqcfrks6X8p/a+yupC2q1mRCOzYCZHrvZ8mU4hvVJ/39lQtedsTcrOktuy2cXnEafxZq0
	+gjGBpDkr6p1zJb8UrpdxM6yVDAJHpMOOzPzbw4ACDnm+nPxbNrSP4YPKvF1k97JR5Xvusy2BL8
	vKh+/+BHpBViicAdzMeGlv9nBZIsYdr1r3MCjHeLZOk9jl/fVaOND/FIwmxeYd16IclcIDWcoV6
	bHmjkLt1eo4yu+KegJHLGX4IaexMo
X-Received: by 2002:a05:6000:2484:b0:491:4ab7:fe9f with SMTP id ffacd0b85a97d-49276f3801cmr659303f8f.57.1793900136939;
        Thu, 05 Nov 2026 09:35:36 -0800 (PST)
Received: from andreayoga.localdomain ([151.43.242.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed552aaesm11722895f8f.40.2026.11.05.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:35:36 -0800 (PST)
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
Date: Thu,  5 Nov 2026 18:35:28 +0100
Message-ID: <20261105173530.39081-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auysN9YTg8Ih8QLZ@tycho.pizza>
References: <20261104103736.71956-1-parri.andrea@gmail.com> <20261104103736.71956-2-parri.andrea@gmail.com> <autZ5kL0S5MkX_8l@tycho.pizza> <20261105153735.5368-1-parri.andrea@gmail.com> <auysN9YTg8Ih8QLZ@tycho.pizza>
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

On Thu, Nov 05, 2026 at 09:25:17AM -0700, Tycho Andersen wrote:
> Seems like a solution in search of a problem to me.
>
> Is there a sane action a supervisor can take on failure here besides
> killing the thread that made the syscall? If so, perhaps it's
> worthwhile. Or maybe it's worth it "for completeness" and I'm just
> being grumpy :)

There is: seccomp_handle_addfd() puts the notification back in SENT on
failure, so the supervisor can still reply.

For example, if injecting a descriptor for an emulated open() fails with
EMFILE, the supervisor can reply with error = -EMFILE, and the target
sees an ordinary syscall failure.  After an interrupted request, it can
simply retry.

But the issuing thread does that from the ioctl result, without an
additional poll wakeup, so patches 1-3 would only add completeness.

I'll drop them and send v2 with just the RECV fix (patch 4 here), unless
Kees would rather keep them.

Thanks,
  Andrea
