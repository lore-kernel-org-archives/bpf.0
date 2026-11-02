Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601022;
	b=FV7uZNCEsSEk9K2/Li/OFKlRBh1jKiSkBjZ23qSi2eQV+p6VuMMm9+cUo2r70Qu84vKA
	 GjkPOsna8FFZsqn6TsiD+/okxX3VccGv38i8FsceViz2Hg/FznY45GnjvUASHj8hoL4W0
	 FprRxmw1VqVjAdKi/U3L04KcsA2BA+ASrG7coRQcEHMGK0L+pjbHwuQVMoWKoyEuIhRus
	 lU0OtfnGt9TCD/5zMIUc5JQPU2g0CxoGZ67g9yOGR5v8kZ55McmOVsh+tbncRz4quHAtv
	 JzLY/nzusworebQX888kLzU7LdncyrZinqPijW0E/ELxf6yovN+Dp/DwFHLAWmK/ySA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=STRnokDyjyJklBkiN53/AF1VqBxhvGhrRQx2b7R49oY=;
	b=JGgCmFTFzkdU0uxmAMcJ146FWRJWo8Qvv7lYIyBmJi9Eew5HM6WKjNGchFUTEZVX7w3v
	 qgkCPcb8x3i2jSoetgqiumDTidiTl752bu3DUmzJo+p6dbmuTEn9uLuBrClvowz7SFCpg
	 3fyvhnlYYHrRxrwLoW0JIlgPdw9uPyGoM+0pXRq10WLxyvNJSSOcgxeB3+zcBkjkrwKvT
	 jJ/Xi+1EJgi8b8wpAfTTwl+13XOn5YAb0t5xcnAEgugLpQZ9HN4GTsANm8C6iLxII5aur
	 o1zJSDtAo47+nTzi+QKjwGC3rTiGsr2TZbNv2EfoaJd2Xb6005zEMctZif6WTE8irlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xyMNZnt5;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6996606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6996606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xyMNZnt5
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15dd124bbe7so3177483c88.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 22:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793601021; x=1794205821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=STRnokDyjyJklBkiN53/AF1VqBxhvGhrRQx2b7R49oY=;
        b=xyMNZnt5u0YytRQlnzaKTjiCr/09K50dt9hOgktZW+9ojfGr6coR1cX+ENtOpCcjV+
         vhTvCLPvO43BtOEVmlAeuQMJd76QBU6HhnuG7z6fkXF0OHa+ieCeMY8jsYN3SjyDWnHO
         6yl8JseUIWsEE2ziPTlyR1m+3/DD/pNp3roTLPEuueGWgJ59RUqiLyLSeFbd9tuaVHSB
         +285jTKrp2WnBGL4hKeU4i02r6MVWdw5DJgZqP2UMjM3bb5DD8UMu9SdVDWwOnA/IF17
         o1pSO3EHfGo/8dDJMxeCX3ygEsAb4okENz8sjqRTU470/nG63rvqhaLEo4Aaug3dJ8qO
         1opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793601021; x=1794205821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=STRnokDyjyJklBkiN53/AF1VqBxhvGhrRQx2b7R49oY=;
        b=JKG8UwmMmqFlxiplKtZH1VLYY0g3WyRf4E7d42n581CFxlx5K5pyZsuFbZp/i1gbKD
         BJvexHjMKAtzvXMFmMjesamwB/LviJpvEcFTphikh6AvPzPx30EJmSCaEiMEdnc8ltbi
         h/AK4Ki7zc4eXi0W92dXqANzYcG5KR+j/+mpblQmilU8Csh3evmCTaNDI4Z2TJVGKE1O
         8MKTQGScXJ1Pv2NiPTNXf2B3pzZKsJ3FM0w3R5r0zlP3XzFkw+PYxspc31z4btfMZbGS
         t4ozXBRSrkrXT9IPjmxXQ/AAWXNNZ+t5CiS93JtmsGgp2NJxE6Ag8OOqJO0uiaQc2dkW
         CF7A==
X-Gm-Message-State: AFq9FYJeUW+8eHRHUuz+SxciPr/z3GupJfNklsSTPtPjchWmCRQ5+prP
	eS9+H218A6279YgIm9ep3cwP0uuGCUOOg7VDEjLqub/Hm4VS8YzxAwTD
X-Gm-Gg: AYBFou2fFYgXzU8YaTnJ6bEmoyO2WIPMHhucRuwMIoFvTQXLF5PNE4TLdO8FeJ4nxep
	ZUz2znnZ5r6IyciqyJF8YgCoN5clyIfBxdlZ2m23U81ccAKKZHCzhCo0tKkc7PofU7dhpfSw+/+
	R+fxy9slU1oxXyHEUojXhP1pEsRYQeOLQ23L/KoJjs1WHs77A14bj/kpJUtUysXpt54kok2qDkd
	73bQ9bMG+BLfBzOFPPu+jknCjOAu+psYelHw2gxzU2pnnYm1YUdoZIo76rsBI9vV4KPBWps4DRC
	DG7UCjcDIu09N7gh0mcq+ZgROq+5jJjQKCz8V+krpj8CT/yc53uirBQe73JVMvNd/LzywS91Euk
	E5irg75IYuIvYyNcurSkd+pVdtbWyKie9GGEzQsq6QQVXPcNMxPXKPhDHHgd7K0osExxNN59a5S
	fcwiQECZb5I5lCT1IOPk3WQW2xohvJyEpTUUaiLqs86s9ZESmde+bwP+eH+KwmMC5PLb7II1B9w
	t3Z6ZriwmciC2BhASUy1IOR5HltY2brtSDZMPY4rJW4QUCymI2a1Pu3V2oIpz9tWeld7qQGcFCs
	lxwyfbTPyNAkw9NYXO9O
X-Received: by 2002:a05:701b:47ac:b0:151:d6e5:596b with SMTP id a92af1059eb24-1ac59dd35a2mr16118104c88.9.1793601020501;
        Sun, 01 Nov 2026 22:30:20 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm31314190c88.21.2026.11.01.22.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:30:20 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next v3 00/13] bpf: Replace bpf_patch_insn_data() with a list of deferred patches
Date: Mon,  2 Nov 2026 01:30:16 -0500
Message-ID: <20261102063016.652958-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com>
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com> <DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com>
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

On Mon, Nov 02, 2026 at 06:06 AM Alexei Starovoitov wrote:
> Heh. CI is as green as it gets.

Thanks a lot for picking the series up and for the thorough review.
It has been a pleasure working on this with you.

> 1. Patches 12, 13: the tests need net.core.bpf_jit_harden != 2 at the
>    start.
[...]
> 5. Patch 6: no test has a second patch with a jump in it.

By the way, I was almost done with my own v3 this morning when yours
arrived, so I held mine back to avoid two v3s on the list. To avoid
the same with v4: would you like me to send a v4 on top of your v3
that fixes 1-5, or will you send it yourself? Either works for me.

> In the tree today.
> Pre-existing bugs... pick me. pick me.

I'll take 10-12 and send the fixes as separate patches once the series
lands.

Thanks,
Qiliang
