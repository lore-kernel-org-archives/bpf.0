Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496826;
	b=rCcpooX+Z1zB1I9vZkOoxYt5kmQHMgbp1pLb1DXCmikFP/glfq/JgprSdNvYkswwxw+2
	 VtSWtopBsALqddQpGrpDNKw1NgaBHF8+IZN/TDJcxRxpTsNDnSzx0O/szQNhChoacUhY2
	 skxkgC2/djXmVh19qJT4Pta4gtTEqw5oYTdfw5d/GKTgjP5IMy6MMlgg9804fHL+gmusF
	 DLD8MbxL7F5paXSPXKcaQ/5UxzKt/1y/iyCR7jg8nyYYVbJ81fwwWctsWCYDXFyj99LJC
	 moT6bXg4yfbm6fHus2XWh6hyXPQIFMmseZM1TX64C5e+2+6KtrpYf+ul4Y8vlzpIIYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=9qmswLH21yWexoxlEZCEupc56x/5bBhiTvUoCvyFlBQ=;
	b=AQqNekGfB/H9367oF23DWolfHdy8Hn3ZCiruTcr1U7uJzR+rEH1vsgxR6JMzG1MWiT8y
	 EIHTsf8oABFZpUAnjH6jMlJLTiwAGGBh/XJ/Csc92/oWSjiuO6u+mQGlknDay3HLsW3II
	 xuWQzmzjDsHS5Qbio0Qu9InLzmVlKz2MsFGHmpgVXHZ6gdA1Sn+7DCfZVo25YGamnFuXi
	 nXuIx7ZAY94JxPYoCL14ulNuIc4LvSt/AzGZvXE9rcn0UNKf+bpKjLiB1f/XuUI9/Jgl3
	 Gf8FEfwewdd1tuc90qYLtuaVMJr/t9EYurcUEYSewo0FjFw9TZal7SBIAqeqJt7AcSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b7JindIJ;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CF606A31A
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 01:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 245CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b7JindIJ
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1254327a12.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 18:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793496825; x=1794101625; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9qmswLH21yWexoxlEZCEupc56x/5bBhiTvUoCvyFlBQ=;
        b=b7JindIJMrq8AsKTSd20D7mzxt9d4W4iEoP6rJb6KsKokrp3zrFoglujvfJJ0wKEHc
         ZnLvTiez60x1xEVGVNkIiCmYaW+e6Y649RbBPsQpsZ4GwfoTPF+QzjPDY1Uypr9aoNLS
         170JyA+83ftXV7nvtatMYP4H+0g0IXBBP+RNwQUix1NSnGH7fG2Cy1ZFRy+6/fy7UmjB
         4p1SAKlfiG1QPB/eBd2z4NSKVODVeJC+uPT6Ocf+o5uxQaX5b0dZk5fTRKNxHHB1OxDA
         BR0Ot7mYxy0LWiLxVYfHGMc4rYPjvzr7z5BEYbrf1QXGNmSntEantTl3nxIzYj1ro3hS
         t7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793496825; x=1794101625;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qmswLH21yWexoxlEZCEupc56x/5bBhiTvUoCvyFlBQ=;
        b=exdhw++wrajxngzmxYY4GIWeNEHbn5nXAkBQNVdxR1LEZK6HnLEVST4vX72tEQLPvT
         JL7gV/ofUgqOY6oEXikEd6U5LUx8/IX2xAQtyFIF2EV7HTtZ+N4qslxQcRXj/6VAMMNU
         e8e6xxH5wF74o/P8nVNqEnIQ45B6N6qIqVHM5jdyqwKxwwS9Px3oYKG6qKcjvQRSjAZ5
         jRaMLu/DP6zEP2/MzgfGGMKRb2t08k+h84k4XrfS7g7UWFeh6712DE9CSkyi2D9Iz8k2
         jmU1pC7AprjHnIvL1nahRBSU5Cu8mCNVgnx0dnvlugH1i6DyfqBC7G5HDIIAtcQFjYdf
         E/5w==
X-Gm-Message-State: APuU4Z80fJVZqLQE94qu4XGpEaLmtSF3QR2UX8xjMicVZHZ8jyDFLub+
	2NGtr6K2Vons5pItuzR4KZo+chcJQNcVp5kzYMxfBBje/NQoHdcLZx+rH8jHTg==
X-Gm-Gg: AYBFou0huthSWM02EfWqtEh1jSQU558IcvY2+1bRhFcU2JeO/q9h321CMUSGDiUa6PJ
	w/DWCpG7xRV75Q1rJdvnetSJgYD09V4xp37YIJswRm8AIVFiEPuz52iI60UF+wk/E4FA/7H0lLv
	aMHlhoXMlOwXMKnc7W1u1mdxaYi1xVKfvwJhrQ0eRejAX7OraGwdQ+/BmgUt9Min39b9p2WQhZ2
	HqfPVrSpeoBRCm/ihwggaiOfXF2MhCFcYtg8NFdsnQAAOD+LezuncKzT6V3LN07z4rF0QZL1kmr
	rjjD/OhmOoX336zL7qnVao7Lehoum3BdseZoRb8hSo3y/T1qvlZ1YgDpYNUTd03jxX8g//w9ldK
	AG2wDoDKYrj+IxrUcMgCpU9ivjbVEG1AQofNL0/9F0nXRsrRnbsfTBF2ZUR5BMnTQ8NqILjvwdH
	iOE4EjJOeK/L4Ef8eSCBgjKY/98NuI28AGUDf71cXJtIUBcIX1eG7K5WUt6A7sdnghFUzv+e12q
	I7+PGScGR1/RiNPYFwTCXv6o+4c1R+gXKKuAP1KlBBp60Ujr27ELb62yQgcVXOsaYG3RENRplTy
	zSD+mOGx+2ImT9U6/CClgWOlQ3EQNHCS5za/AnIE95Xuzw+fWlC9YSOJhzrmjhDA9TFLkK+4Yfm
	ztIEO3rKCwKBiAjUZHCU9P24AxcYGIznd3A==
X-Received: by 2002:a17:90b:184c:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3ae89778667mr3393102a91.29.1793496825428;
        Sat, 31 Oct 2026 18:33:45 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm13866214a91.1.2026.10.31.18.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 18:33:44 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 01:33:43 +0000
Message-Id: <DMJHKAHV1KRA.OV1LITSNYP3D@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard" <eddyz87@gmail.com>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>, "Greg KH" <gregkh@linuxfoundation.org>
Subject: Re: gotox/INSN_ARRAY cross-subprog fixes: request vuln-fix
 designation and stable tags
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "James Burton" <jamesburton@meta.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <CAJgm7qNx6NBzfxQbwF0ZoMLoULquNpsnrYSL1F3EFf2tztES7Q@mail.gmail.com> <2026103022-epilogue-coeditor-0029@gregkh> <CAJgm7qMWGF3zWOR=5qO8RWmufGud6fcNBQQxTsVgx=CgvRz3Qg@mail.gmail.com> <CAADnVQ+spWODbcC25SwVFXUv+ksPNuVkQgxtq4PwLHdDDsSZCA@mail.gmail.com> <CAJgm7qMEz-O1+L2MJz+qqH6-pz_ELaQNG0QQkgMbHOoDi69R4Q@mail.gmail.com>
In-Reply-To: <CAJgm7qMEz-O1+L2MJz+qqH6-pz_ELaQNG0QQkgMbHOoDi69R4Q@mail.gmail.com>

On Sat Oct 31, 2026 at 11:07 PM UTC, James Burton wrote:
> Daniel, Alexei,
>
> Fair enough on searching lore first. I did, and that's actually what
> prompted the question.
>
> The same gotox/insn_array feature already has three fixes that only
> needed CAP_BPF and still got CVEs and stable backports:
>
> - CVE-2026-43321, mark live registers for indirect jumps, in 6.19.6 and 7=
.0
> - CVE-2026-93043, interpreter fallback BUG_ON for gotox, in 7.2.6 and 7.3
> - CVE-2026-45967, wrong address for insn array offsets, in 6.19.4 and 7.0
>
> The two I reported, 19581372dd81 and c48a91c049fd, look like the same
> kind of bug on that feature and sit behind the same CAP_BPF gate, but
> they're mainline only, so 6.19 through 7.3 still carry them. The first
> one has a deterministic reproducer that goes from CAP_BPF to root.

Are you after cve scorecard or you want to truly improve kernel security?
If later then please skip all bugs that need cap_*.
