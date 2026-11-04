Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757771;
	b=D8A3vpNtSxjvXvNhcDhMp8vE9cvU7xEU87Pn5KJ+mCQSMdcSDzPS+kWRfaKE3bZXE4gS
	 B4XJHO0/sv1WLf+t31UwQHKVGNyGPyXh46JzrwYq3Od2ZxGlUA5p48/Q4RQ/RTz9zbud1
	 EaElm/GFBHeZqjEOBAjRnGyppAoCSpwVgpZljMoR1xQWOuSFqZMHsuMNx+D/8MFUu4RBM
	 /phxV9oUaGyV7c5zo+E4SOchXW2LMEVRcgGYBqdfYuGjV6qUq8gj50MjrBpwxZiBv5VJb
	 vb/BSLsXarRyg0hP2i3bE9ERcHGfXZyDyRTS//WJudQ3iwsblY+a3nKFsY+IYxKMBPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kFh0Z1KuZG/8Oqoz/diU9BAvZ1qwniasMufdEjvQJAk=;
	b=TXVpNHR/2wGYGwi0+6gn43U/nBA0cKJySoxvoW1yIlQZ3PbFHGrLYOUUySTnd3g6wUtd
	 kmPSeTJnabPb+5EQtksSLFc2GI114qJbYgvJjo3zuHtwJC3Wuz/7NYmTVybtnV0ZADqVM
	 qTz1n6JxlhccH+Wb8nM5xVpa2E36lBXdA+X00D+IgisiuVz6eFl3UW/VLA8sVodqLULpc
	 xJHIYq+A5SKWTC7P3LC3uHGpZQ9es6B+SySwaIsf+dqeICtFeGxMqGlVTTYM98JJ4j6k+
	 rnh1hPzdLPl6fRcL4u3SKS+KVBX7Eb7U/OTX6cS0V5l7iBXTVt21Dga+uFTzufkF3gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="R5HlZs/w";
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2177606A336
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2177606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R5HlZs/w
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdab938dc83so86409a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793757770; x=1794362570; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kFh0Z1KuZG/8Oqoz/diU9BAvZ1qwniasMufdEjvQJAk=;
        b=R5HlZs/w3uiPJTmqPPg+2+IA8kDRn4eRMsN4T9uv0eRyO4fNSDq8AdlcI9aB9GC4vU
         Qdk/0uh9aw8W/YYx3Yj35y+37UWwysTkpvTdt2/HfGT6J6zZJUI+ifIS7CoIBdoz88VY
         WK+x5wBP82+uXGN+xmHNFcLdQx2akiLSXIFl+whqE0DADx+MJ5kMzKtOCDl9NOcgOhsL
         bksY00MtFUp0M3riki77aWH1JZX6oxhFWiJy1IC8sCvdMNhsDM+ymvyuKx+Z8rwGKfnh
         zreAMvrXeUffN7YD1STTOuKsmquaEiXjDvsKd/RUfKDXhWzB6F7oEnySdO9tzTQGYK73
         O43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793757770; x=1794362570;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFh0Z1KuZG/8Oqoz/diU9BAvZ1qwniasMufdEjvQJAk=;
        b=DArmrPXEoNG4CH/qTTViLl2EMfmhE9Kimen4htVqKxJN/Z70PjSQrLLcj1JnaQDooq
         oCSIFEhNsJ5ezujSu9OpLxUTShQN2b4S6b3uuuNqKohxHVpHtg4BVxpJV923l+N6+vyq
         46KFoVoEihaLLzzao2HmWTF353M7Ug9o6vHzDrOKhclTPZf4HoSONzblDTiIWQXuB072
         t3/KLXHHVNGxGJ1TwjKBDYYO0ec3vdWlumIpwKxxMoB5Uk8UYagYeO0/9wieX0ldEIdH
         8UyhkKJgaON8sOeS+67pwFPwfKe0bNX/lUlt42b2PSMG7xgOjmU9pKSTElx5rngfVOQc
         vkyA==
X-Forwarded-Encrypted: i=1; AKwUvBwGbsvqjVfHYJZRi9Ec/vv402U+t3a9ECO29nOUjcvyhAP8VLyWgf9Y3xXztn9yLaNls/U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/stPA9wZvPiLFqKACiRssFeKvpZCbvnYhincYosYw4XDbJolRJ
	b5PEKmkwIsjcul79s59gwt/H3krXMxFywIwzuTzUpIq4WNlqztOP98sr
X-Gm-Gg: AYBFou1is7x2Esx1fdc3AV1HPuS8+YMaFoMsAQm/PODy76VKWzUJswPNUX4melOxkic
	fSvS/gYaldwy8PUQxxBVzoTeWvp7WmZdj9O9RkKwtTE1NmBJ5/rMYZ/hF/gmItEu2Q2jszWKDh8
	gVDm0H3X6qVKl/unWuYTUdAXke0eFmfYA9wEh+TPIdiNrtpg5Bio3831FLUp8Nvbo5bq5zjM+d8
	bKlzbSmjrjwMPOU03pPcYNfemwp4UtWy6+xuAhn+h6R+knx1HTTIwXhv4nGwJtb7XbXeuIho9SV
	aMYHj5+vC0Jkq9JSW1Yb7Ok4xkOUITXdLhkY+ytDE+Hztv0EN8Ff9civjlvABHWC1AIIzTZj0LV
	iGSpDnixLsy8wvRacDeumFNbWIvVmeU+Hag8nA8gyMCc0bwPyNBJdlmglTKFU/izfqDXShchmAO
	W/+rLM7gLxKz6FDaIcjwy1KarvlxwWInAiZzdlFoVHzVzInpiOyq0ySeJiD+huT9GxflgnAyaaW
	LMPmvl4xDgJ7SR1/K0PlcvyrBJyTs+SLgRcw5PMwVnthFqOexXdPoylJ9BNE74a7/hi2876yAHn
	Hx/Aeg42cJJj7oJHkQLedMT0AY9dbTVl7qGLSyljdqL+A9bWIKoNUUcsiELXr1fjeSl7jWgzZTz
	QRBMC3eIbTuaAcHQtHOEZAVDsvCN+dXmG7g==
X-Received: by 2002:a17:90b:2b47:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3ae897a5c58mr12241966a91.46.1793757769887;
        Tue, 03 Nov 2026 18:02:49 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b096b52911sm435986a91.3.2026.11.03.18.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:02:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:02:48 +0000
Message-Id: <DMM226XFK9P5.265MSTVAV5QPL@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/14] libbpf: Relocate pointers that are
 stored in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>,
 <roman.gushchin@linux.dev>
In-Reply-To: <sashiko-outbox-196376@kernel.org>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com> <20261104012401.1354861-7-alexei.starovoitov@gmail.com> <sashiko-outbox-196376@kernel.org>
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

On Tue, Nov 03, 2026 at 05:44 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +	ptrs = libbpf_reallocarray(NULL, nrels, sizeof(*ptrs));
>> +	if (!ptrs)
>> +		return -ENOMEM;
>> +	obj->arena_ptrs = ptrs;

[...]

> 1. If multiple SEC_RELO sections target arena_data_shndx, the second call
> overwrites obj->arena_ptrs (leaking the prior allocation) and allocates only
> nrels entries, while obj->arena_ptr_cnt holds the sum across both calls. When
> bpf_object__create_maps() -> relocate_arena_ptrs() later runs:

Not a bug. Only a hand-made ELF has two SHT_REL sections for one section.
clang emits one for .addr_space.1, and the static linker merges them by
name in linker_append_elf_relos().

> 2. If an empty .rel.addr_space.1 section has sh_size == 0 (nrels == 0),
> libbpf_reallocarray(NULL, 0, sizeof(*ptrs)) calls realloc(NULL, 0), which may
> return NULL and cause bpf_object__collect_arena_relos() to return -ENOMEM.

No. Nothing emits an empty SHT_REL section.
glibc returns a pointer for realloc(NULL, 0). Where it's NULL the open of
such a file fails, and that's fine.

I'm replying to a bot hoping that Roman will teach it to learn from maintainers
and stop reporting such bugs in libbpf where input is trusted.

