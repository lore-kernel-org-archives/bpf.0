Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069527;
	b=g2WwF2LhToUvsEY3/M73L49u54VIRrgerU8hElkah8sKiOJ3J7ZZ42n5T5Ig0n/yR2bG
	 rlb4NELmwK/ogRvxYC7SLAqExKOr/RMcyiZP/GU84n17tMA1y3+WkmRVNvVDaXlXagWlp
	 kEw7A2KpKLrWaoPF2Im7We74+QA39Lyx2yOrCthlxMmwSsV/dyIXJ7pZ4yA/+QxSVprZk
	 3soYCpjmBvYVG1D7gccj1xTVfxXggddu30qHiigETrT4EEfEuXvTPB78CAUHdrJ+Widuu
	 JQVPi4TPRaGh3fCrOI5kitTpRm0mk4+fIzclqNibBbWJaOz+bxX8SKaoL6cwxrq91Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=3/jCbkLsS4OGDXUOa/6hUNYQQjlO6TzzhZNOu+cYzkc=;
	b=LHxrmgL2b4e5WAVpP7pW0KM/ggMttbJfa2r+fAJIfOmGDJoRgO3B2v2MBaoskSy8G+sE
	 yRL8nV1gOtix8d9IW9xLGFcqoMgAeiQIKuferSad57d5CdFlqDhPjQCTgZMrXjarKjBS4
	 Sd/zOcfXHKmRsKAA5Do9qJs/xPEvNuYrvi89OWlajv7fus5lvPiSk1UQ3p+et+N/v6CJI
	 6N/o73H2+486Vo96cy7+mP1CF3CqyFUgYskyUE2utm9OEs/5ZM2OZuNk5VyXraT0CtXJi
	 de2TTJax6Xs4wiNbeQMt4ZxHJ790ijUfHCCvltcQj8L0Yag5dkzS/0/xEGcNbep2Wgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DsrNb2t0;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E79606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E79606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DsrNb2t0
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ee184a2474so16113225ad.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795069527; x=1795674327; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/jCbkLsS4OGDXUOa/6hUNYQQjlO6TzzhZNOu+cYzkc=;
        b=DsrNb2t02IODLijhWdu7RKB6d0nUCCWQT9Ri1w3QwWzqQROAWLnzG8L5y5/0yzdkM3
         Hk6/6M6r6kVP0+k2iA4Z+P0zIm9OzzKb6yXYvCmNShBYqBxperO53Aclo76atEkc7HsL
         RsZaUAT9ZyRj8AD6GTuCQyTb9zEktyG3JuRBCOhX8/1rE7PHN3i5eQTHPxeOyr6hkpMa
         W5eOrPgZQ67LztrcdqYopVvXSqFBYNvSCnXwtqHgtwOKS3JXxqg9n2E1L9uxUST6ae77
         T74V8VZYgC6VjcZmGnLXFjHy0mpDGnts3QcH2fXZhSRxdfiEIn+daLA8kiM3b091lVyK
         E5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069527; x=1795674327;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3/jCbkLsS4OGDXUOa/6hUNYQQjlO6TzzhZNOu+cYzkc=;
        b=SUqgu57LWG24akAiexGTRgeZHG9iA7/8JJjYUW8deT6DzVQqCprRxeBwmiY5LYVY0k
         hQOQ68Eo0H6VqMSNg7ZgZQxwjtzQhN/CPO39yPNJWd57Wuawe5xHGvWjNm2xiwInjikL
         sVqDadYgl9fgF2arH6qHZ71fRSMQTBZ0Eb7Zg4ZMALEuwsvKTzUek79cMEi1y+KemEQA
         YNwPN5ru29WdkcefmIjW2thIwe5qF8hSrl1snect8VuddZeBucbn2PINqpkZ45H/C03Z
         pA0KF+g3DBWI4cH/9ynwnWIuMh+IpmklIiwnqgALOTEwu2e+Q6rQW8O8Qro972gMqcSd
         IVDA==
X-Forwarded-Encrypted: i=1; AL+hErHU6ujNAWYFEUvlsg8M4d7h9qjkb4lorsQw4N0LS+RQN4VFB8ldMXKpTlCHT1zgagdFhik=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WASTGHaCrtDKBbyLandojOHWIFgx7om3zF8JPbiOoifp5+0Vl
	q3Pjju+IpYpocwKY9+WmZTSgKFqyh3dyDgNOGJcYzQr1vm+CFdoli2nHT19hmROzdnP+moK4/ns
	+YMHDdQ==
X-Received: from plbkp8.prod.google.com ([2002:a17:903:2808:b0:2ef:f76f:c4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54e:b0:2ef:fcd8:df75
 with SMTP id d9443c01a7336-2effcd8e214mr45611785ad.36.1795069526782; Wed, 18
 Nov 2026 22:25:26 -0800 (PST)
Date: Thu, 19 Nov 2026 06:25:25 +0000
In-Reply-To: <20261118153541.172499-1-shlomojune6@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118153541.172499-1-shlomojune6@gmail.com>
Message-ID: <av6WPnah6aodSmuh@google.com>
Subject: Re: [PATCH v2] net: sock_reuseport: check program type on the
 migration path
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@kernel.org, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, 18 Nov 2026 23:35:41 +0800, Shihuang Liu wrote:
> A BPF_PROG_TYPE_SOCKET_FILTER program can be loaded with
> expected_attach_type set to BPF_SK_REUSEPORT_SELECT_OR_MIGRATE and
> attached to a SO_REUSEPORT TCP group.  Closing a listener that still
> has queued children then runs it with a struct sk_reuseport_kern
> context even though it was verified against struct sk_buff, which
> KASAN reports as a stack-out-of-bounds in ___bpf_prog_run().
> Reaching this without CAP_BPF requires
> kernel.unprivileged_bpf_disabled=0; with
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=y, the Kconfig default, the sysctl
> starts at 2.
> 
> reuseport_migrate_sock() decides from prog->expected_attach_type
> alone, a field user space sets that does not identify the program
> type.  Require BPF_PROG_TYPE_SK_REUSEPORT there and in
> reuseport_stop_listen_sock(); socket filters still work as
> selectors, so the selection path is unchanged.
> 
> Fixes: d5e4ddaeb6ab ("bpf: Support socket migration by eBPF.")
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks
