Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329945;
	b=TIx2Z9tbjtUG21i5ovDcasDmJI8zk0AGEISTINZ0zEGvJwze27BmS2hldvsWNUjWiceH
	 rXwZlgDlUD0csuyDFxV/CvXxUIFoW9UhDAW3YQODTxOymTBu9xHhLyI/E5VQTl9thHe2h
	 iFwL5hBcCMl4PlxD4aUabdPs0eCVpOPl340HQqLYs6yDnEt353nziT6uDyWTHwU5PbToZ
	 FwnBimuGCxV8Wj/DTIeZz1hwG/+M7zysD82crn3GECnpyDZXFERJXuBOcsf9qFdTNx2Qx
	 m2CtjWc+36gKJGCdc0Cm6nmPrbNpLUXcLYDjJkPCaccpDONvQV6TraqhoRuSm8jfxCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=mC6WOtqnwx8jEPCcFiEw82b2ZhNEGFW+sggW/bnJUYI=;
	b=jvBdKZXW8oF6SfNHo/TXuhUHMn5t48f+PVcBM4ZiROBasz3I7TuYp4U38ajk6HJEr9+m
	 xqkHasl/ohs5JjYZP0WsJcC0kDN46iC/OAjwkFeqtpMYQ4w8gLkR1q8a32dqGSDN2YOMu
	 +ArZQh3yrpvN5sFiZVqZWDlppvRiHZ3sPHZ0e7vsM0zIduDVHOmWRzYESWPg3TwipOK9I
	 syPxTxPD9MxyQ4GAnNu97zMAsqIdWqCa7dSD8chcvu/brgbrxexGUVqGPx0nqlPy0nS2c
	 3MqTjccz3iYUygubut70opHYjbxx65fq2gZUEm+r/tym2BJrvPUw5/H7UWv4ohZ0fsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fgR5KDSs;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09A606A33C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A09A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fgR5KDSs
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so13248515e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329943; x=1794934743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mC6WOtqnwx8jEPCcFiEw82b2ZhNEGFW+sggW/bnJUYI=;
        b=fgR5KDSshM9EOkdknIvJh1UWxvLcgPCtkIAxiOXuYQlCXsp/Of1OkKVPKZsImloEik
         V9UmHm5RgXMXWzQ8lvcOZSAmmLQTu1ggyJHO5lHORvopbyzhlji5JmVMv7uMRn6ie+Xy
         jA4w6+AroAUdYjDGXIJu4oangQNbiKC/6gYK7R3kxo+hN5xkEw+eGQ2oml+qONyD7lgi
         WJ9Jub4zTg4/SWCWNSnKtKUzSwBhjwUaLAGsNJUxL3ozpfWCcHBDyV6n6tFTgLYFOSoP
         ruuefa/wlJj+FkfSNmA2lJDSASUW/RWaRNS6RFzUoDLcUMrZsV40/YLT6HqhZbDQN1kS
         OnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329943; x=1794934743;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mC6WOtqnwx8jEPCcFiEw82b2ZhNEGFW+sggW/bnJUYI=;
        b=R4lrX122J5cdLUeKrVDH9iw9R3e+SNBZnLo0mXW5zhfsyVJE9r8WzxV1GL57uq+RQ8
         jNsSgy4B/xJSiY0QrYb8P+Op9/MK5yQptr9QnCcDo1U60ehKIjNa5jRH6OJh+DyouK/k
         E6QhKppZrv3KvsUD8Fvxcac5BdIoMTCMHlrdviqfXE4mJS3APGISoLpul/sH7FGdzZhP
         TGCbVvW7oqTw3bYsQOPdFzc/gHNxurdqyXXhvhk11yaCjRDwO4ax8Jppow/QKmHC8ToE
         dEqrosBRm4/oYJ6mkLbJ+CMePWvBKy045iWdH+WdPqcmhK/HFCjK6Mx5aM3PlEFlNVf7
         DGsw==
X-Gm-Message-State: APuU4Z9aXsEAa2U9PsHsvibCykPiCRCJ4ChgRjn8udi3NV6HGVud6Yek
	eKiDKP98SXmr3UPOvlJPDjJoD0BF7mxtXvrOv3z1+89YWL7pSvSXBiNtLwpx6eu856w=
X-Gm-Gg: AYBFou3VYhVLQ+B9Dmp+fjhf9R8bYtZy9WLaeM5xdKT/5+hObfVgyYt9lJEG33izrf1
	QHGoBlQs5M5+18pRo75KveDNUdng7MMkC7pTOF6yAevgHlT0ImEHYz/ocA45tnKOJUML7SVoZZX
	q9NE26NZUovjB2+PjefbC9nes2K6MgaXoI0JXWu83Br6s8cMTn62+spDl9PcLD9s2aCSxxfhIBj
	yfAhcyMVf/MtUjQ5Sp87og3Pep+/Gcs8qbkQ0STns0eFh5vzxeEhiJZGxL72sgeoDz2pZXuYdT7
	SD/xNK9J2cG646hOmCsG6HxcIdVugsgG4WDe3s1TXeY8xJyxG8ZyziDr8DWB+0c4GVJ9f5gy+RO
	MUq0reuxEjzncWxtKIep0HUUoqVJhAs5Gv94iRqLMJMgOU7KBFloz6rcj7nsnLhrF9sO8nNMObB
	x9wvkgvipreXJugufjLJ/v2bja2xV7LQ/5KeU49YWeT3dlIsN57CUKeGlWfubNmYcTi4lYjE3Ya
	aHcyl1h06DcjtFcQD1TTnTbfFnxWEtFX2PjiJdMeCddoL8YPshRVNmD7ivH1SenSRjlxcfqAY3u
	tTtm4fLOst9LC8O6snZhqPkQ4Lv/c5rlBTdQGBdcPEj7HGDgSCJkRnbslNDCrpfkEw==
X-Received: by 2002:a05:600c:350f:b0:4b9:ff69:19ac with SMTP id 5b1f17b1804b1-4ba02336184mr58925985e9.11.1794329943116;
        Tue, 10 Nov 2026 08:59:03 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:c94a:3349:dab6:f761? ([2620:10d:c093:500::4:ccd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm82363815e9.5.2026.11.10.08.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:59:02 -0800 (PST)
Message-ID: <366a2e6b-36be-47d7-9cdc-9c043b314a79@gmail.com>
Date: Tue, 10 Nov 2026 16:59:01 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com,
 ihor Solodrai <ihor.solodrai@linux.dev>
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: BPF CI is down: patchwork.kernel.org blocked KPD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

BPF CI does not test new patches now. Since about 05:15 UTC on
10 November, patchwork.kernel.org refuses all requests from Kernel
Patches Daemon (KPD). KPD is the bot that copies BPF patch series from
Patchwork to GitHub and reports the CI results back to Patchwork.

Patchwork had server errors from about 21:00 UTC
on 9 November to 03:30 UTC on 10 November. When Patchwork recovered,
KPD sent a burst of requests at 2 to 3 times its usual rate. This load
affected Patchwork for all users, so the kernel.org admins blocked
KPD. We are sorry for the trouble.

What this means for you:

- BPF CI does not test the series that you send now. Patchwork shows
  no BPF CI checks for them, and KPD sends no CI emails.
- You do not need to send your series again. When KPD runs again, it
  tests the series from the last 7 days.
- Until then, please test your changes locally, for example with
  tools/testing/selftests/bpf/vmtest.sh.

We are working on mitigating the issue ASAP.
