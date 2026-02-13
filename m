Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46172D3727
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979008; cv=none; b=eE21PTHKLTjKo53LU+4jO5MAuMa1c5IKwQPn2n0DXVMY/6JMzTTvRXcj12M9XY+fl1GpOQ2Br+ZNdikdshyD/0Ze3+R139Hl/vywfaQEQfw8oxKJViQ00/Idt0Hx9s2PuOeA+E06ULVS8xKmSF2P137S5myL7PCLXMh0B+Hs0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979008; c=relaxed/simple;
	bh=gtFKar3JokpwbpwXY2DM893EmJhKPw2OCF87e0TS25Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=XslfTsMcw2+Ov9ofWL24/nB5xmZLjN+87L7zbMZotV75oAhs0GsaQ5U+EBHj7n/v81HZdxOn/sQ3aYGaCKdWeLzNNxGFQGFxiNwdoXiz7DyExRfZ1M4e1JJ6kHg7cwoySk00qG6Mh/t2VZYhFoABQZsm21PFg/W3SRCphHKB4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LQc31tmG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LQc31tmG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5B5331A0E9D;
	Fri, 13 Feb 2026 10:36:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F6EF606BE;
	Fri, 13 Feb 2026 10:36:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F35C10368E46;
	Fri, 13 Feb 2026 11:36:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770979003; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R+Gz77eSNs1pW6kJTPF09TLKAhyrAS3oNHmhLKWUZK8=;
	b=LQc31tmGQv3ahE975Hzj89CmZfGqxzNVDVQrcbVtBAyZ9aMYILQkTagkVmZZ6XWZMCJO34
	gkHJu9KyfZpn2HFvrRYhKi3r5kI6t2VTtziO+ILDV5HGHLdpyLrPJMbGQ/lMzMJH7bJLtn
	izzJfGCi9ZeM1mHDtDPs4W1/Fu3E9V8S1Emv8jlHuGhkbWk49h4iXTY05kyANgoI9hTn0g
	lytQtfxvUSE9SlEnhrbUzhB8DIgCgCcTlUYOTf+QLkii1hboEwJPkjBwD1CDJ28+ReZr9m
	YGE2nc5cOUWqeY4U0EFF6o74W0/eSRxRhKmioIC4YLoUEsRJvT6qwLRRO102/g==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 11:36:40 +0100
Message-Id: <DGDRNT32OY1Z.19IC8XK7DWJ0Y@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 14/14] selftests/bpf: Check BPFTOOL env var
 in detect_bpftool_path()
Cc: "Amery Hung" <ameryhung@gmail.com>, "Mykyta Yatsenko"
 <yatsenko@meta.com>, =?utf-8?q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-15-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-15-ihor.solodrai@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ihor,

On Thu Feb 12, 2026 at 2:13 AM CET, Ihor Solodrai wrote:
> The bpftool_maps_access and bpftool_metadata tests may fail on BPF CI
> with "command not found", depending on a workflow.
> This happens because detect_bpftool_path() only checks two hardcoded
> relative paths:
>   - ./tools/sbin/bpftool
>   - ../tools/sbin/bpftool
>
> Add support for a BPFTOOL environment variable that allows specifying
> the exact path to the bpftool binary.
>
> Also replace strncpy() with snprintf() for proper null-termination.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

LGTM, thanks for the improvement.

For the record, another issue that this path harcoding is aiming to
solve is that we definitely want a full bpftool binary (as those bpftool
helpers are used to find the binary under test), and not a _bootstrap_
version, which only exposes a few subcommands instead of the whole set.
So I'd say that it is not an issue yet, but it may be worth in the
future to enrich the checks in detect_bpftool_path to make sure that any
bpftool binary path provided by BPFTOOL env var is not pointing to a
bootstrap version.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

