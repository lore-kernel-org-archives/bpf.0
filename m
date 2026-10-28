Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153723;
	b=Mu6pMZ09iY0dqfJIWq+QGsCBGted0o+f0e6Hm+wOCm0soPLKmQ/u2+rA8NsutOD6MDCR
	 VOpYf2JihtRZW8ZgXOSqJzI3rWqzfWQ/oYYVoH1T4/jeEzFuWrNVDmDa3ElXiLmCbkVUE
	 3pAfX9L49ENHYccNzxfHvlEGop0ge0fEkapN3Jgfj/fM2yTlFDgQ9FLa9qRiZhrzdYDa6
	 pPL6B7zPY4rIGaSEzAa3dPiG1NzMHG+CNDmN+MoCC5Q6RKeBHIa9/rUGMnCV+RaSx6V6T
	 +ym83mnkFCIlpocDl8lIiGt2Jl29GitwZKM8FdFnpvlYZGjbMz/buCHsPEk8mugpTiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=b1DHWHbFGx8smOppMf6/EZAqo9MqOnk5uaGOHEEVhzA=;
	b=VE2GHtEOL+MUnDludgvz7Ldd8bRegrctxrOkMZBz6zdsx4fJK9CTeW/jT1AwJhUcCNks
	 6tVX2jX0hzGHhCLvbAbMaNGqBChjaiHjLbHB7Ad8e+5GNnJ3q6p75N71ZoYAAbSFUuu9r
	 wfPmGYpfW0mdPjU14BIVyAVeGlfBHsqvVvDo8BKasadzPmr68azPdkgV5UTYYJ483WX5g
	 q8HGg0L1tQUnJzlCzLkRrkI3lFUIqpL6FshjkomNtdbazCi19PpjDT01u8Sp31x2eBYX1
	 8s07QeeaE9maJJqLjOuDX2G+KMJ+oEFIyLzH5JqE0zgnYHojWg7+dIeZwQNkV9eVSRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzYDmsb6;
	arc=none smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87823606A322
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87823606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzYDmsb6
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-4a35e178418so2087105e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153722; x=1793758522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b1DHWHbFGx8smOppMf6/EZAqo9MqOnk5uaGOHEEVhzA=;
        b=hzYDmsb6k9U5O03hzqx96BfIC5yGuYVS6lswnTxqs7OndlruMnQiarfPj/yUT1QuVg
         m0nQfSgHVdl6D7lOTxSweMhZVYKYjZlbPP2DvIJIjeIeOW6oLgsrPnQH9UeYS8vFo+PS
         HQvkuo60mP4wf202fx+uymat8GiNeIJyDGP8js6vWk2TLg5bNl2BhsU91xcqfnqIp0C+
         4M92XqfqidZQq2gEXSgB2sf6Zw1TOs2FWSvjXb/5QVNxowF3gtXxas+ajnbLHA57CyGt
         RZ5GceAkjQXBsjrfkWXlzLjtOQ33P3Y60KU3g8YlKtBSPlPvnKiXZyMDx1AEvHqV+r4D
         cJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153722; x=1793758522;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1DHWHbFGx8smOppMf6/EZAqo9MqOnk5uaGOHEEVhzA=;
        b=ugFveqavpEZWx0ysn/C2tiMrkc3bW6KVH6YM/Pb1I+OsPZ5inJg/9qnNCcjONb+XyB
         23KBmrupxQGw0BvBRGT6yEnEKaULI+5XmKu3hre0zkm9riSxKiMaXQDwaJ5GKb712t3N
         suG4jgGYwbPg5cT6LCGegq3xiJinxLfN6Ya2+yExY7+TGNVndk89oSQgvGxqPAfuB3xm
         jsjQsp4p1ror0dz4xPCWpGCxC9cLOEwOzaGjYxIfQvSqjqKzKoi5/QJoqMopqbNmbiyz
         DtRwOOy6r/58/ZGysowKOmMbod6fzANtx6ny8t23HUqkFpwTNtzr5zSDjvCihI3Sxxzl
         qlsw==
X-Gm-Message-State: AFq9FYKgsxO2obwb1VWG9HmrAffjLqI7vJkq+TrVd26PKyGegp/gWIFR
	wzmmLP0SsyoEzHCBYB9S9cRDhxefwvZW7fuGGq1hFh8UsYm3rQROZpfa
X-Gm-Gg: AYBFou0efJnlcQ/U27uqG4amUNn0Zn/ufWpr0T4Pv6ClNg2SOM1cQ9qVUZYq0KbFWpn
	bhCFVa/USPRmpb43WAeMUQuCDLmEw3RUW42MQVdlpb2NWjInqevZdP7MkwD10AH/uzlkCK6pwCy
	x385G/7DAs/NRo/PKN+1FIygGarOXdrR9jWsLahhC0mMheuNjU3PfqApn55AGKYPA6r6OmWQyT7
	nuS6oxR5i4leHKNoYDrsAvRbQVoX58Haom0hj/3ycDcao5x5IZ+UpOLbUiQLIKyAB9ZsD7FhDAZ
	QgTl2xXqSoeXoBTvOOHalZG36xqAKlVVn9Gy/fMjU+gg0gayzoHOIUW+k3Ym0jf8Ib0hgp+oPlm
	k+ecbE3PmVYMojHGH7PawqViAfrGKphPO4HpZYeMEqjdV7Y+5dDE7EXd/w9cVvY3JUip88RajHU
	ykYs1JXrKVPuiyG44MpUrHLpkwd3d+xhvWCNnQSmYrk3XFZizCozq6qBaOe2xEdVz7UNKM/vYVu
	rjrxhAtn3djyhesFXy73jh9zVGUcy1I6evjQ6bsKAMTowJ/dKyvrLlbhc5QcVDP5ptNsF2t7neu
	95upApapDl1o/JcwwQjMWqraHqL44SUnANGnWbSJH8LFEkKHaFJnqdAow/lkSFTq+ojNbVJKrjC
	9LXSeOksT826yAIR1wKYdnrC5MLFpYob3gVWv4OuS/uHrhANUZ9Hmy8RWXeXlrKdGqNAl5TIb3E
	mSoT7HR148VGTddw==
X-Received: by 2002:a05:600c:4f89:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4a966c4110fmr16665885e9.16.1793153721881;
        Tue, 27 Oct 2026 19:15:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a977edc0fdsm10886565e9.5.2026.10.27.19.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kkd@meta.com,
	kernel-team@meta.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	mason@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 03/11] bpf: Let a callback unwind into the pad of its helper
Date: Wed, 28 Oct 2026 03:15:20 +0100
Message-ID: <20261028021520.1203900-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <64d65cba8dd38be485a909c5b03c403ba78bfb67caf179deab641e22208908a8@mail.kernel.org>
References: <cc848a0c0e4839fe34514b89561884c082650881.1793147364.git.memxor@gmail.com> <64d65cba8dd38be485a909c5b03c403ba78bfb67caf179deab641e22208908a8@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed Oct 28, 2026 at 2:39 AM CET, bot+bpf-ci wrote:
> [...]
> TL;DR:
> - Tracing (ftrace, kretprobe, fexit) may redirect a pad helper's return
>   address, so unwind could fall through, possibly causing use-after-free or
>   bad r0; not yet reachable

Right. Every function with a pad is notrace and no kprobe target in the
next version, as the verifier lets only fentry attach to a subprog that
unwinds, with a test that fexit on bpf_loop() is refused.

> - Stale comment in backtrack.c (nit)

Fixed in the next version.

> [...]
