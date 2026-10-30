Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336071;
	b=0sWAJzPaeYhCy1TdR0wfcJne5gWMEYLmVza690PnXYJfZAfVd9xYPD5qh0TTMnmsIT8u
	 UpJzRCMwTx9PDoQIsAApZSeZ5LRQe1JO4MHaIJA7DOw51AHBst6Zo2+pss1+Eb29BKyUR
	 8dfil+YCP5cPJ3uQmQrTqHnJA6tpiPaAWpTlqr5GlMCOuqvSd+b/Iu5R1td7RM2X9BHdU
	 slhj2N80FIMKolnl8gnCN2YTdqOJMyACRdQstM3DP5FrX49secpDhh3D9BOzpUOqXLtCb
	 UTO4fqyfJlLbHdLJY3Eyt9Z5G5sZq0WUqmaOrXNQ6TSWxvhJts95Oagbpt0L4xfcYZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336071;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WbqbZO7bl7I/iUtGxD0fB1iITmMeRi4PtvXu0RcVEuM=;
	b=kbZAknSuQrPqZE/D2FawAnG0yBRjl3sclt3XpKttjznywh7tgWeVyT2VlPROrlHKkFdn
	 a9r2B/cx8AZEyOUb2r1nzMbzbsFywlrWqqVverATWeP8QJO5NWBPWBHTiQaB3k+bP3OPe
	 wxtCpegQrpYM7WjGljlPq/lVDAs8qoDPIS9PvBjSkIeOI5WTSdGOhV8eyMP6n27obrAXn
	 h4BR8f4bQ0XYAGf+MIx9yo8ceref/Ru2RmXG+gdUT5j7uzLsfl0nDCuCsQ2HsU3LHWe7+
	 KJJvuL4vevxjmZTC58VPX+hMskSYOhyeACucZuwPIBmOS1/ycqLp+HutwThY27ZAnhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQByAo5r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CA606A320
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQByAo5r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7081F00A02;
	Fri, 30 Oct 2026 04:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336071;
	bh=WbqbZO7bl7I/iUtGxD0fB1iITmMeRi4PtvXu0RcVEuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jQByAo5roZahl15zoHhZrAIXznT8KcwYHoZJFsq6XItkzfMkLN7e9/U82Q79BGVkj
	 AwWIhpUzdPy25CJvYcbfExGuUWLOHBj8p4CSxz593ifYPf5FlHhcXHeeEAqTQrQsbH
	 X8X4wUNwXv9DvunsGgSf7HCB8qIDxLplGrQr+kV8UQjypG+5xlt6uqaqP4fAfG3vcu
	 lpce2I0lD6e7QwQ5OcKC1E8jsIvtLzHEFNxOCRg5lsjDHjj++78IsEpkfLxZHBTtcb
	 JGLPUApw9IAe+ec/HXHSYUHSz2/Pn/Fkuiuh7vvlGTpDFGow7A55OoLDaZ/ECTwhl3
	 4tOib7cPUXojw==
Message-ID: <sashiko-outbox-190473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13 RFC net-next] net: ping: split IPv4 specific logic
 into ping_ipv4.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260712013941.4570-9-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-9-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:30 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message inaccurately states that error handling funct=
ions were moved to the new file, but `ping_err()` remains in `ping.c`.
--

--- Patch [8]: [PATCH 08/13 RFC net-next] net: ping: split IPv4 specific lo=
gic into ping_ipv4.c ---
commit 3efab348e36b9a0fdec89cd6eb3bf8beee163acf
Author: Fernando Fernandez Mancera <fmancera@suse.de>

net: ping: split IPv4 specific logic into ping_ipv4.c

This commit isolates IPv4-specific ping functions into a new file,
ping_ipv4.c, to allow compiling the INET subsystem without IPv4.
It moves packet transmission routines and modifies ping.c to use
CONFIG_IPV4 guards for the remaining shared logic.

> This patch creates ping_ipv4.c and move all the functions for packet
> transmission, error handling and the AF_INET ping_prot definition from
> ping.c to the new file.

[Severity: Medium]
Is this description accurate regarding the error handling functions?

Looking at the patch, the ICMP error handling function ping_err() was not
moved to ping_ipv4.c. Instead, it was left in net/ipv4/ping.c and modified
in-place with IS_ENABLED(CONFIG_IPV4) guards because it also serves as the
error entry point for IPv6.

Could the commit message be updated to clarify that ping_err() remains in
the generic ping.c file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712013941.4570=
-1-fmancera@suse.de?part=3D8
