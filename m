Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657326;
	b=sMxjY/8DO3fNAoGp5xxegscUuwxJUnsXqqr0usFPkCnTRM8FuO3RYsRwYxjSPq6wYhrP
	 6pgAUjZj/16XUQ8u4Eb/wnfOIEybQcWou0PZBkfy5MnArK65rv2ByQhWokrFGXOzEd0M+
	 1PbHsFJ2I+0gqj523pRhGtzVV6QW7b8j8PUUkAqutmNyPxjyIR9h4EKV62HMkVUopunOG
	 QNyLHl69KtnkJBEuZg2puo2+uxFgJa7ZN1C1AEQdpzrbACTCIQQcoK8Qn6UxvGUp4s40e
	 rz29GvNozyqrOcdt0LcR5/SpHmKCxYavRew4LQo1Ob1euBMVEta/9ol+iiUxXgbp7rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kQGcUVFR6ZICl2K1H8hjvGbuC04HgUjTsRDMDBEzoUw=;
	b=4KMArJ3aF2ha4RJKfoWCQTUxdijcsT7ZEsAi8VZ4t+WoiTAUK/rtxX6aEjKGzZOfaH7i
	 rNpyGeWSicRgxGvZPfK8BE3Ei1TNA7lSgWpwsPHSEJxQ8JEOwV6csTJdA7OIrNSH8/ubS
	 nlcyJkVO4aLFXu48ccp1hFZ9CGCSzMAq+3V3kO3adNbcP48Xp6TFTN9b44ygM4P8Q/7CJ
	 2s5Qt2/fqmwlwyI6dqu+lnHdzfoxTryexN3q0wDCGfCHCCT20xu4ZQTttoZYrtLGUnTBO
	 9s4rSb87/R5k/RvMNMWlyuWOdBt4quPZ7YoXJaVIoLuR9W3q8ZQry2AHjqVbjxpu/hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vlmPd/Rk";
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35659606A332
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35659606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vlmPd/Rk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso1164075a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 14:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793657325; x=1794262125; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kQGcUVFR6ZICl2K1H8hjvGbuC04HgUjTsRDMDBEzoUw=;
        b=vlmPd/RkycBiY4ukdmMVnlWoeM0oSXArS/RRregiuEzgOAjEethQMPZeA9tAt5elt6
         /cYb/duStX70uSKpDQNglifYisToIuqcdEZnufgRMvKelbPRxsr0rDDCHzaUFaIMMVkA
         BNoJCA/7W90F9+JS0Uh6sO4ORN0MHR0rzJ+2JqdG1g9Y+1fPvXozv1q0M95WGpn9MCNv
         Nq33XGZ9DS0EKoJoJy7goD2zonm5MUFekMx6YAI8VzC7Rn8YO0GHbczvJMkiNKINlpP5
         VW0KAT1pib8wscZnyOcJMlVpAb53CVzazt+nY2aBgLv90hEMgYCZfmfu4CEqfcGJZbRc
         4swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657325; x=1794262125;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kQGcUVFR6ZICl2K1H8hjvGbuC04HgUjTsRDMDBEzoUw=;
        b=1gKlAbVlpMRlSteP64GytZXJ8GU5cdcOqvJB9NA1D5toSL8yoUIBZ0TMvGf7pmV0k9
         OlarxIo7uuH3g7H694cUyVUwa1pjyiqmA6amPXHwtVpla1gaqATalQ812ijORipIlRo9
         KdcOdJxEij60/c+DirZAJsuv4ATRc9NOS8ZWAq2XPixlA73jGAiuedOW0u23ekoMX35J
         hL75gKXD3OYmocwQUbfJzPBZ42U+dhw3t97oYUu9NnY3URsCwWE9I+p+WE3nMotrvCSW
         tva/jNnNH7iq/btftmKggWJ00S0sDGs1H4GCheV7BZBppxwzdrp5EFuE8l7eAG+R9SbJ
         7gmw==
X-Gm-Message-State: APuU4Z+/Z38bA+FgQQs1FLjLoT10vt4iK2hNpnEULIdSiYkjFViXhcgm
	3UwVF0x7Nk3977hOiHMgd6lBWsToiECWjb+dHkKaYpVdJXte10A6rKhr
X-Gm-Gg: AYBFou1qv6qaulPuekh3fiqXMrM2YRkKUWeSB7zJLU9RpwQVxmaleBS0vpvi8tfVXck
	m4hx8rgWj7TYaYYkikxlwHjtSiFYPNitdWHA5d7ZrhYYHolM7FVvPlKu6el+uEtdIrIIHdamwDO
	i/MGuryW0PyHpwmPtFTO6CcqSnDz1IPmoN3/nFY6dqBmXHu4xxvjeplvxS2sNp++l8efFAvhECT
	rJ5kVKFWAyhSz5EJwIeHOo93IFvUKxnXLVYahbHYSaDTwjRq3baSLcG93gfR3IWKDesofNnZBzJ
	dXIkolocJakQUz1s5Sp2EmLLFIvipK+VujSkMX6yXC4vMEMI5yBRTa/fJYerXyuLctOzdY0u2+5
	91UI58NqGxJPwRHcCs13vj1KSq2IbCDkaG/2dIbC/hPFWh9kS9FNUJAnPeq/4Fcbwb71cuXt4jb
	8zUKeKIGj5++97KK+D2owBxaExUYbXSpiJ1DB58Rt4NrHD9P95c6BsJl1qtJGTolIIOVnRPGmBB
	xjDQeUtrSnS04pBHlMtecNOKuW5dI6UM3hBhau8kmUFy6bNuz87SycScmpBPBSM96C8NAl64XTP
	ADADD6otNTA8Kjp+z5RxQRQ+ju0IWIft5kB9dU/AoDorGm3WZhTtiTHzGrgsiNqTtR4dWLd+OJ2
	Nhnuyk0RyjeZncqvmiWYrKaE9hdJulVvgtA==
X-Received: by 2002:a17:90b:1d47:b0:3a0:c85a:ee02 with SMTP id 98e67ed59e1d1-3ae896f87c2mr10000259a91.17.1793657325415;
        Mon, 02 Nov 2026 14:08:45 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm986281a91.11.2026.11.02.14.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:08:45 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:08:44 +0000
Message-Id: <DML2GFI6LWXU.3ODKDXNQDBYYA@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] bpf: netns: require CAP_NET_ADMIN for link targets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?J=C3=A9r=C3=A9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <20261102202922.2515317-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261102202922.2515317-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 12:29 PM Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
> BPF tokens allow a process to load BPF programs using CAP_NET_ADMIN in
> a userns, however, netns_bpf_link_create() does not check for
> CAP_NET_ADMIN in the target netns. Consequently, a token can be used
> to attach a BPF program to a netns it does not control.

That's not a gap. The prog FD and the netns FD are the permission.

pw-bot: cr
