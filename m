Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793136731;
	b=ucHWViQlaOYEDVKtupyqdDwXf358DVk7B18OWkqG4/wC9PxDd4CDjz/Pu3b8+cgG0IuZ
	 ksjCdLqKKUFSOzOqkx+oQKix81CyofW3VDNYhoeDpXDIkC30Phe6jfHWPNoaXP1czuoGO
	 gLcKWxW+hCu2X9/ZHSvYE12NQauEs6RE2205T9mCNi3NJn6VVCnZLgqaP4+oRVuc81m+9
	 YI0jWTq3GFLRCaft3jsHCPPdhPWss4ROZ8KeSJz1rAExcZd4of837LacCOna1tVKkuL8k
	 Uej8ArGQ1higrtSvzPkdkK4CB205LnWOoZOlt2H4BaGGbTEsXu+E90Pc7Xg/oO3dRSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QuhHDIMVu5WYcDA1LFoQtTkJOtLD/1lu0y5o2UH4ICo=;
	b=KFPi0UeuKaG533UYAw4QyLldKUxptma7RqiVJZZwcRirhLUD+E2CptR6YIuGXEa0IOcQ
	 HVMlBGyTm9qWCa3hJTvH1vVX1a8f5w0x9Im3ncfnMqWJc3M2Vmw7NPi6Vg0hP+6gEJ7a5
	 TE+ardPnZPt/xT3zMtzOhb2BNAPYfq0doClHdThipi9P4cfiEzuEcb4V9nwun84gcXGIJ
	 42mu4nKUyhkuoapWEudihoZ6ru0LcBKtZXTKWaVLgVdIJXNFBRDQtGIkQcR+6HPjqcUv7
	 txMPQWaEWfeJP3SGqP4AhJHWuyi3G08AVttJVqLtnn1cUXgS6WGNYTK20jl8n0SK3TQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S4q8x2rQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E97606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E97606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S4q8x2rQ
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so604027a12.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793136730; cv=none;
        d=google.com; s=arc-20260327;
        b=V1lmNmQv6bztZEfaM0r1LZPZdla18Qe+qfZsQeNFw1DoIh6q+6wj3hg4wLf2eOsqzZ
         lJg0F/82CahpV+53AFXrNX9ApAT7apZ+R+YvZgE1TfYgLdIk6KF9W7bsOuhEk2nwG9sB
         ly4x+6ud+vNNV56ddoeex/z+RcKO3WeRnXiZg51a1CPweD4s6b195IrrPsjVsHwZ+x+w
         rEbA645ZldkiSs6lSCB70uW0hKrhFRW7O6yweIgF1EN51q23CM9nLRkHeCbeY3f3RrgZ
         gopPgC9OZdmacOgLgTOi+v0gT9tO+hBV3jqmU+ho0vFQzqlkTdIV7K5Gf3veCHDbLjuw
         oj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QuhHDIMVu5WYcDA1LFoQtTkJOtLD/1lu0y5o2UH4ICo=;
        fh=RP3AiUqIU1jvMkFkAgX4aZ9UyJRHb72j7xVVpgSY3cc=;
        b=VFhmu1USPnETvfkonh40V/3tR/w/C0qE7wm9vLRkSF3fHbOIkkYr/ST4ikLX01/ljk
         JXZ1EW9XNhDpkcw3qXhkeMP03MKBamYvETyKO34BB9cWjdsRizsyTKpeC5L1EXNdqCP/
         7sNkEsAaE8QTpNypkaW6WLQYAhkVx7y86nBL7apbxNNFvEkm2bhDjzf9dYrm5Nnvyr7d
         Y3PU1KUapHcd5xpUHTL82PP6A/72nNJrJAuzukIva0MupzlrjZaj0RhxsEC6xFohUld/
         lXPYHALz9miickLWFQOni403HWtFZ+yK5ksv3fYpaw0DS2m6D2OVIPz+fAZMqFA9KD4J
         W5Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793136730; x=1793741530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QuhHDIMVu5WYcDA1LFoQtTkJOtLD/1lu0y5o2UH4ICo=;
        b=S4q8x2rQcUgbgnB2taH0pkeX7W824XEztlulInCkstTN98gFWl50fOUHsLcMogIWem
         +SWWuuIF9ShMS36X+rzUjPd7KU7unYZs0GbPKlZZc+H50ZsfMxB5kFt9pJF7G8rQPafS
         Yj/Qmgt7zp+vc5tnLKCYLsenY72iRxUoBzH1XWuLuKRRylx2sc/th56B7WwrxdvuqIlj
         tisiwgUTXoSytzPTLshRseVU8MV/f68st3yxUw4yxkUyz/mWdH6jW87vSpFl3DClcaci
         WvuRRwXmAgU+OVFLKqPNuTNITzE4a/9IGHAuQqBbyFGnX3jJ2y/T3HqHGFlomaAJHMvR
         E4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136730; x=1793741530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuhHDIMVu5WYcDA1LFoQtTkJOtLD/1lu0y5o2UH4ICo=;
        b=QQFOWJPlAzTN0fzRZdEEiE3eYDSHwos+FHjEkWBocsrV5mpc5n/prOL7qq520HPfP9
         uO1vZ5TDxhtAzsKwJhD7tJTUBlJcIPNDuME0lpUjs2h3x9Fr8wPuw47rfn3LFNGuhc8/
         owbz8WuB8EK7DuBq7kwpT83TF+3kD4a69Mr1ySnNKVuK04Yd6qOu9+4iKdB0QoPzTjnl
         EutbfPq3XxPHOUTWWQjfUc+Ab3Fc4gzxeGiCyTzaajlPnM9W6ZrnvPppv8KGOjASI3JB
         rasQu6ptY4ndFj+xNrRDRaBszUbnOCOpAxXLilMk8ISpxdcCW6GSfUDQDSNCOPP8aAkN
         P1VQ==
X-Forwarded-Encrypted: i=1; AKwUvBzL8kf4wCMH5ex1XMQXovwkCQo9/nnvtrDsw3KcgjH2iChb9+FSrCAKpu5saBd8Tmiuk6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkrnesVIaOwr9ZLKb0Nc5wlW8HavrAiudszYO3n/w6Mj5LXNDI
	EvwNzJRqh92k+9XpT3kC1jAcL9YdsyjlIM5mTPlv6m3GidTuhlaC2FOpRsM4jLLXiTuNUVrax+Y
	U9HjKVuynAQRbKsr+sqXX9i+BkP2OnaDuSQQk2uAW
X-Gm-Gg: AYBFou0v0+N0HkIwtwWBZ5lJtyGDsZHa5KgLHAbR21dAOddI7kbUYCPINDTdL23wdq8
	cL7WXFpHsVUjhd/BFDBNN2W3EVKOHnDmGuRCja99IJESsdr4qWPFad7jV3cC7Nars5hV5N8th4R
	/xmukR1x1mftFiw5n+TJYM9dwT3ZGDdgp/DMckuS7HBBsfg410TGofBX3DNS8JItMZZoFd7+qxa
	8Z2fCyTA1WzUsotC/KLxXyiF/58SLse6jrvbIyVPUv8/P8kj7qGM+0V7dusihj7thFmRq8xmr9E
	ThyAGoMrimc4kq8/XbQX7iWCxAKXROHm2a8VioeGppsrQt6i6DS8HnMbKq3MrJpBDzbK0grUdWM
	CUYl3mpwZRd+f2+cAPcovWTao6mPtGg5xkP1fOvuU4OdQfaoDceZRXA4rk/fVWgxW4tHZ+cyg62
	5Al3GE3Yc88zQk
X-Received: by 2002:a17:907:868c:b0:c46:bbde:734b with SMTP id
 a640c23a62f3a-c49bdf39dc0mr39237466b.32.1793136729307; Tue, 27 Oct 2026
 14:32:09 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-9-wusamuel@google.com> <a925a7a8362e8e9aa0270c2b252aedcc10694857db29c31f66d6f7c5ba89ac08@mail.kernel.org>
In-Reply-To: <a925a7a8362e8e9aa0270c2b252aedcc10694857db29c31f66d6f7c5ba89ac08@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 27 Oct 2026 14:31:57 -0700
X-Gm-Features: AclHuK_3f2GFNzZ4NDx25anrHi3Bvdsj3Ks-ELoCN4hDAJz29yzPop2fh0fcApc
Message-ID: <CAG2Kctryf8+44WKQzUOzyMmtL4biW3Pbg3Pntzkn3Ot49RhFow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: bot+bpf-ci@kernel.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, andrii@kernel.org, 
	eddyz87@gmail.com, ihor.solodrai@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> [ ... ]
>
> Should the BY_ADDR path return -ENOENT when kallsyms_lookup() resolves to=
 a
> BPF address (for example, is_bpf_text_address(addr) is true and the addre=
ss
> is not in vmlinux or a module) unless bpf_jit_kallsyms_enabled() is true?
>

Thanks for the catch. In v3, I'll update BY_ADDR to gate on
bpf_jit_kallsyms_enabled() so hidden BPF JIT symbols return -ENOENT.
