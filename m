Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754274;
	b=QdhCqZ9FXdsWkzvflnEsxhd/+iA60CjSEq+dJT0n3Q7WFI8pbjwkSZ/3Vu2/ekbtQkca
	 ao8XA1peOQ4DJM1Jr+jFhVWrUV/IflNKtREqLDzt0MxkcGTWUMw2mVaK5hvVRNddPDolE
	 cGV0tYnibA+eka/QAgX8xgEHnuu7reXodiv+tcHLw7tvCriMw9lQC06lT33M1yysl2AdY
	 OItldnVRHhiKU6aAuLh3ExgQ2+gN0u+n1YSVWtKKOCfpLvvDmICk0sU8raGjSJKeVGiGr
	 EcrdkvBhkxxPToJVx8Sw+EBfqttzogEzMJcbmWjP12sY9gpj28+lhbdBoE5y9vkzJYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=mJoFVVdGcUJ5uxtOofXlVsUeQummLev0QVFvQQSmjI4=;
	b=lGDeXPgjU7iejj/YbStLGkYRANLFJ1lTU4ZQZ7RXBdA8rjJy6vx0OjpqZFlaXLH3nUFe
	 PGqu3IWPs7L2W2jT0BeWxrQAaY1sjOtNODo7YLbMK38KlvPmYbgOm5o3qJDDzvFOJhLse
	 BZxm3ztY2HfOPAYSyOvlREUx4AbIvOB5+vFnaC5P5sUsyf9808LwouzUw2CS0BTgys0/d
	 PwUbJe3IfrouMnJ2Ob8jRo0PBJzncWNXw1qI3THJ7OF/aAR4mapW8YYFHw9ib18irX6L8
	 NbmqkM6b26zzx2oxA7rbVpAgghQyWthrC7tgZHghWBDqvLOv8pdixLjLRH/EV92oezQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CWa4bAYB;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859D606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B859D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CWa4bAYB
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e946155442so1162725ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793754273; x=1794359073; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mJoFVVdGcUJ5uxtOofXlVsUeQummLev0QVFvQQSmjI4=;
        b=CWa4bAYB4rb+RL3TezcKWJ6nBaI50em12AKY8pz5X+gApeTE65DgxhE9pPOATWCuvU
         4CbsiYr914OrnMO3xIdwMXkqXyNB8XC6x5IsTniyoQBqqIMGMxdZmJ+FZiZ6M1E1mf0b
         ogyj/4TCCwTj9RKCrxyP8fitiDOgNNl+bSvJlWnS6qwbwmdaYteQnWvHxHtJ+hRDnZmb
         HpV/exa4lS3KuDr609XwxnQ8UG0z9IPu3LLIqgGbJMf0dWdQGsDasaFMMPL8WZeTf+Jd
         7p6dGnqwND/eNi8XuPJbtI0hnZeXjbH0xXntz96aIWYm7ZIz7acCYZ02oG38C912Z/aD
         3tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754273; x=1794359073;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJoFVVdGcUJ5uxtOofXlVsUeQummLev0QVFvQQSmjI4=;
        b=md7T80XbRkadZxTXPUMybCW/DITylJu31+7Y7zIFQpqJUiQ3KmsNcCts7h072WvHrL
         YDsNdvacNbS/nYpxooQBJb8xP0S8Nthdm8tcBbPRp0NdZbtOzogZSfQGGRUJ8y6gMAVu
         C59ihnE15nQLSFp/gPos+vPBjMgv7cV9H34Zcqwpsq+2cVS2WUNE5vgamuLV2DPS1f1X
         UNvixzf2ecpRHdMtsJtcrRKUWOR0+1LCRse85ANkdAnf0Osu/ip4itlojwxzZbOUIOai
         9MUMq3WCXUO1mDxPhnGL3mcu6SsR3Qz1MkOhhkiEDUBEiMgTfb6C00b4NnMpU6ts9Y3M
         PBzA==
X-Forwarded-Encrypted: i=1; AKwUvBx0AXmDrutW+4irX3AISIh7omuiJahgBxdnjmvC4wrvIkDSXEv5VMYirouqwZeAn8EFf8M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ny5Mw1VN9IILSx8J9H+2VvARTWitK459Byzolse1I3CNEEQ8D
	5oZ2JHpjOMIu2AwrwRJLcDlUZzFEtnAjBOEeRmgccLNXyGbNeIj2izt8
X-Gm-Gg: AYBFou2wYVXjitqNp7gwVldt2LOo442i0QhNwzFVS3LUgnUvc/wiQB+idpXEqMYAolT
	w2lCDahGU85GRoQKHacmd12NeR2xCz/U6dfrtVkiXZZDe2L6Tyj7Y/gHFn8nu/FNA/0TBla1Qrl
	KSBSwVfP/xF8AjYOHOy3Czd7WMkCZvVg2y1nyYBIX+nrd5RQp5LfNt8vl8FsckHftCi+Cw/Kbvv
	J7EH0yDlDfGneXiCZf/35s3DR6eVhfgA0LTSomRsrc8zbSWQxyqUUBJ/kqBmSiDnjBJHBrtEM+s
	4X6sjZFQT/l6fS0PRhivLVHquenbQqLz6PmAZ21d4totTVz5V2J0BOdY3lOr+WDFaSvt2dp1A7D
	1XquhAUmrtGUScivxxdHOz7Tqk2dvAnXGULhStWX/PdFgp6otrlYkrRXkNCtD5q3bAfVNC0GxTf
	Xa5yNnx1HxQaW07HWToGkCInikEN+oKbmes7T8s6OFOmpFYBi8Eb+ZPjyNBVX27OxjEDnzj9EkM
	lGzVFyCskmiBtJH3Eggtb0jJIXJDRtkJDPrB0YK0uwHkG+GKHCaA79Sdjl4aBjTv7R2cDwNGSlz
	+CRAkVvqMTB6Qn/8OE01JXrpF59EMZsqHQ3pV7wMk2vfTOxE0ssTUkPWMgNgMf4WJv1ZS/Cph6H
	cYo3spd954RU39IJ4Qqq7OVojrldt0X4Pzxo=
X-Received: by 2002:a17:903:384d:b0:2dd:c100:a5df with SMTP id d9443c01a7336-2eb3651a2f8mr128837295ad.51.1793754272779;
        Tue, 03 Nov 2026 17:04:32 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed090724d1sm690935ad.35.2026.11.03.17.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 17:04:32 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 01:04:31 +0000
Message-Id: <DMM0TKJK5T9U.1B0VG859W7HXU@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 1/3] bpf: Force BPF_JIT_ALWAYS_ON on x86-64 and
 arm64
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <2e3b7163c71acdc345acd3eef28d5c4348e5b4734f5198b586f5fa88f55887af@mail.kernel.org>
References: <20261103231931.89739-2-alexei.starovoitov@gmail.com> <2e3b7163c71acdc345acd3eef28d5c4348e5b4734f5198b586f5fa88f55887af@mail.kernel.org>
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

On Tue, Nov 03, 2026 at 04:11 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> TL;DR:
> - Docs/Kconfig text says x86_64 and arm64 "always" enable JIT_ALWAYS_ON, but
>   it still depends on BPF_SYSCALL
> - Nit: new sentence in filter.rst breaks the "This is even the case" flow

Not worth a respin.
The commit log has the exact condition. A kernel with BPF_SYSCALL=n has
classic filters only. They have no BPF_PROBE_MEM loads, so patch 2
doesn't depend on it.
