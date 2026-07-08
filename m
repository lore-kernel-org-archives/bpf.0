Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5E3EEAD8
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494850; cv=none; b=jW9kfFPoB5w3EMp3Cf68qLWCOkpbZlXZtOCF/Sxjehb91gWfCgxtPtsLowYO12meYW3HUHP54Ti81asdKR6Ech0Jh0xem16U/MewkLFRbfWC6EH/kjQNHQyhA8OZXzfHEi/1FxqmwgEXcI6O7w7q8xOO0NvWQ2siIzRsOOoAsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494850; c=relaxed/simple;
	bh=mTXUqEFXqx/DtdaVX9XFAwuqXbhhFd+0ZjJA7s52zY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP2miLQNG61sin5JxGlUbTP5sb2n1WIhaGng2UHoRmQvh0PGEKiL2693Q+VKUDwOaoV/bo3CTmDvS/+slZoY1GG5Eqs2CgxLgU7NkJlUqt82LncAmkJ1jGo784NcsRs/9ObWZmMIFqRdzVA19fCPo1sRw1imrcGCc5TQgfh7gBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dhdu05VS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhdu05VS"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38759bcd877so328843a91.2
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 00:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783494828; x=1784099628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VSJxNCtWN9a/WrGE7manyRQhegC7spkJ7xC1jUatew=;
        b=Dhdu05VSWknEBb7ZvaDw1Kb8+8e+KAuqWf9OImuuMwfHyXe41qAdFJd+3mpA2xGe5G
         Hioig6yWN7WgEKLntZx4iZ4Vez/ixuxMz+dtMGfY+a8BTAgoNtXPTLCGCn+h+5QTMg4B
         +9opPesyT5RUbP8yL9XDpTqQgZ1kdHBxKftpwM3oB+BQKZHvA1bpSlAH9dL0LVVToNfD
         oXgRFAOVHB6Y92q4D9w6qzNsZyujg4FBpBhZuxHzGFdio1xV7C37n+2koi+KnQL/lriT
         C/DzfdpHeUjyVTgnRPM0v+PfJ8YA7brcyuBBJR0uPfrPxFRjG6U1ttU4VC9XxQuSoOVp
         0AXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783494828; x=1784099628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2VSJxNCtWN9a/WrGE7manyRQhegC7spkJ7xC1jUatew=;
        b=aT0B8DMWqUpF+gKK7Fy9CEpaYJbOnhTyUMo3LxULph5Af4GanzGzDuTV5xD9/s7FVg
         FrT7ElSGEUKisuRWnzmgXt5LO6Xfj5Ri1FiXoFXIUd1rVOIwcEecs1xYfE0o6PGk/Q87
         3NITuqAADPx3AJZ+/F8Lkwa3cmGis23u+3d7VrL0XOsqZjrCnZxzFD1K0XXwz50ubuEl
         rCOxOzBXAcMIuN5V6pgAWb9pDnmezqdffqt2QUbUJnMzUM/WkPIuVRRBuEPkPw1q3LY4
         5Vege1JsjloavKGEbZ4ZIAqCyJJbMLxRP0gwbPgdvjSvMIry4IqpiPf7VM9xxK8XKmc4
         rasg==
X-Forwarded-Encrypted: i=1; AHgh+RoPi/cWLu8jzDV+Jd3Fp8ez2+6z7yzuaclq3NpH9vA4SFSFhUtq4rzvFM+2eMszRZ1aZ/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCp4sbLJPotDPly6JkUXohMtxldRWWDdCOabwAtzZZnafEQxsa
	mI3eTkWhUvEdl2agMsAj4HHlgCB0bIA351aYf4lSy0y6t+9/fjU5zzuf
X-Gm-Gg: AfdE7cnHm7tgXidAKLJkYxmV53qaATaavqvQIkjfnPT5gPSmec/awupDaL6xqBRfsG5
	XSY/NqqvA4X55Ejz9P9ZVwLErHSu77ONj04mv7aD3itvG4Z2TT1VXG2mTwExrEZU4NlFGItUauB
	ZzojEWNNcjn5o45GhGaoAF8LM4TAShcE3xLOiy8a2pTFKItO7HG9e2oskBkyiUgzFNrFi8XC7pb
	nbinBH2UnaR0jpr6xUvtEC8xuaOP449SRnWQCyLEjG4hRkm3Bwji+BUeK8bEgpQ2liEG8LP9bG9
	ZFeCf4gJ/RelsaFAvURzWAK/FND75VROEtfX5a651kML+DMzQ5kI+JWo46HPZ2VCK9bajAUgRzK
	kUvr9vs+3QYBpt5cYHOaZ8eVRFFKtnfXnZRLDkBhHqqDjsrmZGxFgtFs2YCYeVRqOcF83lexBkH
	41K6PhQgw5/262PLnustEsoBn6xPzgeX9aGi1LPnLGvDsr0eayL89o3w4u4a7IOSVOpJZ5ZPMYt
	3XOO95hUBzBKuw=
X-Received: by 2002:a17:90b:1d44:b0:37f:d9dc:557 with SMTP id 98e67ed59e1d1-38940638b51mr1603290a91.16.1783494827572;
        Wed, 08 Jul 2026 00:13:47 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf7858sm23562715ad.23.2026.07.08.00.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:13:47 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Date: Wed,  8 Jul 2026 16:13:19 +0900
Message-ID: <20260708071319.191465-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <DJSY4OV8B4K3.EAC42NYKYZTL@gmail.com>
References: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com> <CAEf4Bzby1M8OPRomzEq-xvciK-Zq2zoL0AoSn=iSR02t=wdNOg@mail.gmail.com> <CANk7y0g+tk_C9jF6c0420NDEyeM7LYgYyoCkKxy1utB46GnDUw@mail.gmail.com> <4d09e590-9b03-4025-b334-ea2351770b57@iogearbox.net> <CAOrxSK6mjYcCOAXqhxXw6MyfurcjZqkOjYn5ofhAFX+n8e2aNA@mail.gmail.com> <DJSY4OV8B4K3.EAC42NYKYZTL@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 08, 2026 at 07:38:44AM +0200, Kumar Kartikeya Dwivedi wrote:
> Please avoid top-posting.

Sorry about that.

> We had to drop this from the tree because of build-time warnings [0], since
> mmput_needed will not be used in case CONFIG_MMU is unset. It should be easy
> to address by adding __maybe_unused to the mmput_needed's declaration. Could
> you make that fix and respin?
>
>   [0]: https://lore.kernel.org/bpf/202607080951.rMUtVX8X-lkp@intel.com

I will send v7 shortly with mmput_needed marked __maybe_unused.
