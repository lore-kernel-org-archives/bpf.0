Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380721;
	b=vjkVT7+H/CWJlypkFZu9Ey9j9dqxLDAupktaIJlBKmgU8ljbWZahtvG1jUtFr1dHI5hR
	 50Xh9CMDEoUC+n2BB1UVtImX8MtDo9gNZsy2Amd9m3G1ODJMYAc/3IUMwDRgjKLmJ6UqJ
	 hDL1zLnQAm274uBhNebCoLffUvn0i7WNHBet42JbWvb26sisbIU5ikmAqUJNroyNhZe6K
	 JHyZxjI40Aq9AQ39w9dRcfqGTFlx3EA2XWlx6B8ILW6iO3mWxWfp12DJ7qkUvz4JwhDd0
	 Y4dJ4ypExXQp2kftxqWzbeP0jMtlUY7WRCGfHH/9Oew4vjnfqBOcojyc2XttgqClNvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=P1uqo7C/JrGtMIVNU/yYgKX0OwbZ0XFibLQffeq3In8=;
	b=oWcWrlzJjZajTNDyoF+LVtMart6sHHvXDnpyuY5TGBXQN8DLaa2EqrQRxYt8rmhhv4si
	 zsDsbr5Gc2VUMTydWM3/VRiSVC1GvPTyvUlPAtXznnqH/HqFADsWIFK0T4qlKlYTTojpx
	 akSh8kKGj+rlrPYzAel+rlPaqPm7wfpGUDEuzy4i/MX9YzIi6/0dtQJ+eVAPg1HLjHomw
	 94HqMxgFXbxYojVH4vfgT2OzIPtfcpJhCWjKsUdRTSFyIr8I6wew6/T/c1n4eQyvgkF2D
	 OdfQW74Pe05gBmnnV3zStJVRDW5H3phXX+S+S1HZVpAaRpB6ycrmkrh+jbGfEMX2pvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ij27kj3r;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC5D606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 17:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EC5D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ij27kj3r
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so1200225a12.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380719; x=1793985519; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P1uqo7C/JrGtMIVNU/yYgKX0OwbZ0XFibLQffeq3In8=;
        b=Ij27kj3rh7jDkNne4YmRr09xPVJSWqvJL4NGnEalvehb71QAzoX8wEXHxvuo9/2xm7
         aqoT7d+vLeunRxOxYniOCOGso1HtJXGiMMujjJ+cmW6jUHQbtdKVMdlqCLiAwCaRxAls
         QZDGC9c/wj6FnYWGdmPh2iHTsb4cgWqiTZ8PYHenUiO4O/CL0WQCeuZD+STR5xFmAUcC
         9+armJyqi7yQL1EUxe0onoGIYAoMCXp+A+onBxpxnBaR4zM+OAoeQ0tw1wsNeyts7HQT
         LLFFfg0uoxFW7/DM3Kr9BqgsP1mTCu8gSztVxps+LmpVJwCTobgBHWPHmaEfxSB3P4Jx
         ZEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380719; x=1793985519;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1uqo7C/JrGtMIVNU/yYgKX0OwbZ0XFibLQffeq3In8=;
        b=QiETUE8hB3NwG0bePcA4c1l8++w0xVSzB/+6xAcYHDRJrCZrqIrMiJCm8IE8yvOofg
         yUDahvJgRHrWEGuv6CM2EI5+Pk1BqSvTPboYVx37lBOx2rRwx6dUmOmMc1ZlodACbIu5
         HaCNXAZFX4YNSHiwgHaebXgX6mOTqGwg6lQP71ocIIRqd+l/FZ0LgaxSvHShY/fJkS+w
         jgo/dFnASUCDIv6CZHR/sl7BF3fZC95adb+UUDgFB/thd+jw6flXSq1NoAV4WqdoBzpg
         cjjMVs2OAfipfp7RLMkZqGDOYu8XorPE7hz34zCkqVmJ5nc7cZmf7cByiDNpO26+cL15
         fgzQ==
X-Gm-Message-State: AFq9FYI+Vms1N0fvFjIB7WQfDQe1NkvDfeJ9fq12RetD5IjUmSY++ctW
	v5tb5ie3QXdERABXQiaFp56vX4Fnttca7oGJy6uKkwnJfBTl8WpXKWFs
X-Gm-Gg: AYBFou1FXN4wpFLAsEw7qni55b6G/j9c9K8rCZOz49nXkwy7QuRygZ8WBTI/YV2LbXP
	JYVV5ay9yLuPua76Z+FbECvIWOdxVTnUSIc8B/WPvBUOlTGWxbYBQBA8ilgfGOI/RdC9eEKfKUy
	OKwtFleaoaUPd8Ex9k4KE9ddRHqEPb99GjN2a4++sFgKthPZVEQbitQj1xCLix4G1BugVY8VFKF
	3CmhH1ZhNdfZKJapLPGWIucR7IzOHYY0c0F1QGYh5Q5hdE7WK+Bldhwmz/gCxGxBCBjq91GXBep
	w/+jXFUYO0SC44orqRlL430Pe4Ko56XJEAFiBbwEy2fxRcHS5V8jUi38bJfX4OxxVppuUhGAtyE
	jlF19U6f3KBd1Wna/WGG+2XUtePYgObTk2eAfz4RLF5XNc7R+xMaGsUW+vGtxky0K+0Pgmwd7Ra
	vgA0AfZoEtat1DJ0Ctm1kG6dc+3moURu2J69iSkqUTlaxB/bWvQx1Meypr0xZwXnJbjTK/1pKIl
	IkPPR5HMyKM0V4ivU4RN3B5wV/D3zmHPVVWUo9a1vqkyJlgNETwv24JvvlwvuhcEU6kwTMK0/uQ
	jtR8ihxDtc2bTMBySjLgK3o5Juu5Fbgq388r8G/2gHsUKTmmA4SHaDi5TDHjLPh1Qg==
X-Received: by 2002:a05:6402:1654:b0:6b4:7c1:ce3c with SMTP id 4fb4d7f45d1cf-6b4d44803c7mr1595508a12.8.1793380719230;
        Fri, 30 Oct 2026 10:18:39 -0700 (PDT)
Received: from localhost ([2603:5004:a0:200::3516])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca214fdsm177695a12.36.2026.10.30.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:18:38 -0700 (PDT)
Date: Fri, 30 Oct 2026 18:18:36 +0100
From: Jerome Tollet <jerome.tollet@gmail.com>
To: Marcin Knap <marcin.knap@vecima.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject:
 Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is full
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
Message-ID: <179338069669.22800.12175576942287801197@gmail.com>
Content-Type: text/plain; charset="utf-8"
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

Hi Marcin,

I tested this patch on a ConnectX-5 (firmware 16.26.1040) with
AF_XDP zero-copy. Both test kernels include my earlier mlx5e fixes,
e01620844c5c and 63811edf5125. The only source difference between
them is this v2 patch.

The receiver deliberately stopped consuming the RX ring for two
seconds while continuing to supply FQ buffers. Each run recorded
roughly 1.8–2.6 million RX-ring-full events.

With striding RQ enabled, the kernel without this patch reported
225 RX frame ownership errors immediately after consumption resumed.
I reproduced this with need_wakeup both enabled and disabled. With
this patch, both runs completed 15 seconds and received over
15 million packets without an ownership error.

With cyclic RQ, neither kernel reported an ownership error under
the same test. This is consistent with my earlier cyclic reproducer,
which was fixed by the mlx5e change alone.

So this test shows a remaining striding-RQ failure despite both mlx5e
fixes, and confirms that this patch resolves it on my CX5.

Thanks,
Jerome
