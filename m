Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949887;
	b=dPStAPcUORAyo4ddm2pgI32BJyXACpwu44kWeTyejFOFlBM4iHbUr5in4gY8B9I2+GR+
	 9MQIK5ieGbBv1V9zNJNxjNI9gKMmRcOeozmfEf2Y96cxzo6ZnWU9KV1p226e1R6WQiSgV
	 RelIx0Kre5DCKJyrcW0Fr1eFUYFic4AEj7I8plufR7Kfu/LH5n1VamQGmfigY0aZmmAFW
	 w+ruMmJPqSw04Xca29mQe7feW23z5qzTPWOWQqs5EKTz2UJXxNoZV3cvPvcDpNsT/PA6o
	 gEfuW4oyFLGTdQFcQIvSMg7WPiSBJHHopY6oPKv0vb0kcMhg47oU4i/t1BKsP+mGxJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=493dc2rI2R+pwcbHD8fYtGNS1C7+bjoXpNtwKmI69dA=;
	b=hy4sp+vtebp0A2nvexds58CPel3ni/NRx2+N1VOmE6OBIDpiz/86MhtS6mVYdMirEvUC
	 VT3rXN+ikGuGJCxmsKE4xKPIrvEcDdIDSyi9IBcxGzyRM7QgbKNILfyThfraw3+j66ooe
	 UnPnE8TPEZykc+mqDaQRVCZ8XJ3aPxO64dgo5fwLRSyOPKo29PrhIxdh+WZkWT3dqIGI4
	 gtG+bOel/bu4f6/qwCO4ynuohmwKE4w4R1vgHbUhZhQC3qqcpwOU5UPaCcDb8M4gvqIgU
	 zfysYqfcwWwZHFR1SH4o5YPluH2uVID9oUpvVbsLhm39gqp38hCp97+OlZdxo57OlCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mat+HX6j;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C625606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 17:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C625606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mat+HX6j
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso55433a91.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792949887; x=1793554687; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=493dc2rI2R+pwcbHD8fYtGNS1C7+bjoXpNtwKmI69dA=;
        b=mat+HX6jZsXh3G4UFpfWzoqjS8yxn2PPcM/6cGG9cXpBhq22w763X8tKpv/aabrz68
         OPRj+6ut+4aAqeDhFbe53N3JwvRMy8XJAVmeMD9txm1XtnBUusNhSP0qYXCs78UW6pBW
         4ie3dis5HJ595Kz8uDYoJb7z2k30RtMPaGnt2CzcnqgvPvYIXxeF2G98ZVUm4fga2f00
         xYi+1V7RhQqpcUtI0PycR2Qs6G5ESXe7n1atbarNMOyMxWqfLQF9XFRt7X8B8omymA3i
         vuGo6KVIgNEwSnRRWRR/DNLKeBiwytn0W2yTnff3w9G3OaTHgQwDfzmfM4CG9FFAA4cE
         VbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792949887; x=1793554687;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=493dc2rI2R+pwcbHD8fYtGNS1C7+bjoXpNtwKmI69dA=;
        b=gwNZ1Lb6/HJLCcJsAM7bCCYvkkZ/c9d1MDOhflv/6h+tx3cKMmo8lVeiimigM6XVew
         rvb61c19vl2EY4ipva7bWmms+Oip62J42gVumUO8tUPUAAbqR6ytFyLNKrjStzwCNrTK
         JbmGa8QNOOJE0DZ2nzoPhJ1Y0VtrbGmw3W9YosUsUbEEhBIDJmtMie29pXIOBGApBKWM
         I/a/7O7JCEq/y1U/5hgt0XiNbNUfkC+fS11yPn+CP7oo5/jr+V2MxYqoWfAgSEdM811k
         cecDfTyvtJ1ZH/iR0W2F4v36mqWRi+uwlBTkOc7bYbitZ3mm2StEs4ZbFgXccbi4+qXQ
         gatQ==
X-Gm-Message-State: AFq9FYIgAhaaIyDrFY/AEpy/GFgg23Ote4Ii6oCYT0H494tM+bYDgXjQ
	wVXA56iurcvdvEMuau8RLWtSXJu+vHnI5BPHzBuYrND+D4Fb7DrY21No
X-Gm-Gg: AYBFou33TiK46c/2U3gq5EJXM77o2cLmykUNKLibQrY+w7Zl6CntiwHNyXJV59npCt9
	MlP2StuKb3fucDUlvvgdzxjP3n/7gb2K2Rjgih9XQCVZtNff0slleWH/VSai3qFg00fiZJSSDMF
	QN7R5CDcfjYE+RVt43EQMZ1134rstd2yT6EeNwU7rZPnexhTxGa4Q9JHqc5WOV5mqEwxZBu2Vrc
	rwt3Q7hkErLLtYP1xOJjvRfb+vbrIojKq9xLkq76q79Buk9AVwNHhXAJUpTk07GQZlGvpbVcNEh
	d7KlklAkfMMIU/wU8WKZTYj+kejzI1Mry6AcQeGANDM15kX17ifgJbEkLTnr0RSFKlmdrIxuTJl
	be2nhh9xeDzneNS1UikOXNV19W+VgyAXMQesuQH51QLsucm3AgiXkIOzY4ekH2TE14mxNs3jXJG
	4lTbUyzjx9udiSALZ1RyVIpCl2/FmaXEIEiGYScldzpsMXOAu8zlnzS4CFoarniSdsnqP2JWhCn
	sjFukCdg62Ba8VG/k48xeGWy/2OZJulle/eyW3deo1T0EYhVgD+UUwSMD1+K9PYNnFFkxccdOLe
	7i5yoojMNUrxWlFmnyaJnxoVvZqan6U1rEUTr0irUMISEzcwKa04NaDyXiw9
X-Received: by 2002:a17:90b:4403:b0:3ab:884b:65ab with SMTP id 98e67ed59e1d1-3adeae86b0emr4460011a91.55.1792949886704;
        Sun, 25 Oct 2026 10:38:06 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb1e37esm4046063a91.4.2026.10.25.10.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 10:38:06 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 17:38:05 +0000
Message-Id: <DME3OUNAYUV6.2JD94UVU3DBNP@gmail.com>
Cc: <bpf@vger.kernel.org>, <andrii@kernel.org>, "Menglong Dong"
 <dongml2@chinatelecom.cn>, "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH bpf 1/2] x86/ftrace: Use jmp mode only where functions
 are aligned
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, "Jiri Olsa"
 <olsajiri@gmail.com>
In-Reply-To: <8c2784c0-2b13-4cc2-b770-51bbb8006f26@iogearbox.net>
References: <20261024073712.1074591-1-daniel@iogearbox.net> <DMDB1EESN4U0.KLEICFNC4NUP@gmail.com> <at4BvTcsjWwDuvbl@krava> <8c2784c0-2b13-4cc2-b770-51bbb8006f26@iogearbox.net>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Sun, Oct 25, 2026 at 08:27 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> I had the below first as well, but then saw that there were similar issues
> regarding function alignment in the past and they were solved on kconfig
> level, some picks:
>
> - b3f11af9b2ce ("arm64: ftrace: forbid CALL_OPS with CC_OPTIMIZE_FOR_SIZE")
> - a743f26d03a9 ("arm64: ftrace: Don't forbid CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang")
> - c41bf4326c7b ("riscv: ftrace: align patchable functions to 4 Byte boundary")
> - 9315e22b0c0a ("arm64: ftrace: allow DIRECT_CALLS without CALL_OPS")

I think those are different. They need the traced function to be aligned
by design. CALL_OPS keeps an 8 byte literal in front of it.
Here nothing needs C functions to be aligned. The callback is hit by
the bit 0 check only because it goes through ftrace_call_replace().

> But I can also spin a v2 with the code change instead if preferred.

I don't insist, but imo my approach is cleaner.
