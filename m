Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F43D7D69
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460015; cv=none; b=jHz2jKFPj8j5isRDVRpIDO8yXLPb1hYpddOwkI9iDXDpNAS9MCmk7p2pZpjzc8Rm/ozOm7qjCdcKiw8vtAng4j+J2862Iy/2PR6GYZ4MuikUzFhHLNWF8uaQuMbkFIfYf3Y/f2bu1gQk1fZiKqnriHryjaD+hiR+QDykNVNSY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460015; c=relaxed/simple;
	bh=jiiyXOZojpsENCUnGFE76LMjg/PvEFnumM2R/jc4XRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sioDrJeKX6ca8Tnu9h3M1kwUOrUMAXYI5oUa1Gk45qZwBRjAyXLJbpulb7/jYNN8OLPhuHESVTCF/s/KFhbxDzLm7i+rWDi/wvOBfG8cl2IAFCBd0ilCGOcej8P8FfmBqsmz40upO6irgjT10WvYyH8Z+AKH7jPAe63jc/VIFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6uYjRin; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6uYjRin"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso2058964a12.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789460013; x=1790064813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jiiyXOZojpsENCUnGFE76LMjg/PvEFnumM2R/jc4XRM=;
        b=G6uYjRinJoNx6dg1TflCMLfa9/ljrnDgRD3QKHQb39O7TujgMUo+pF02nSqFVh0Gek
         qmYpR2DchQi9NgwiWJ95+6YvTRBdqWCeXMqElkBAx4jtfV6cfKDWIMKYQ9v9lSFchXPr
         fEjqUfgzHEb3VK1Ovv+YIy61kv4XvBJOj/gc6BkPBPmZJIIhVdCDPuMDilKjmWiDjQLO
         wsG4wo6VvzThIC6tEJpceKCFejoB6aeOrpHLX2gLl2rKZv+uQAeIx6KjnK6Y7QcfDl2g
         Bz0OMaR1TjgdYUo8/8PE0AclfoC5pFPCudrm/Z8y7+r2DwlEKyWAJUXn7pGerchTzVnF
         c1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789460013; x=1790064813;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiiyXOZojpsENCUnGFE76LMjg/PvEFnumM2R/jc4XRM=;
        b=jkcuUf/f9zVbYQXcTo6t+AY0upwZHXG7AemX4m0YGlTvEYlOzXfVmkigllyt44c3j9
         N+u0crIVh9jpojJOGUglSjrQNwopB05owqo/nACkSNpxphQi6TETFw1PP0/JfzmpST6Y
         EsL3eKN5FBU6dgP5S7uIKSlQlogu9Uslkotle9qsaTKMuEyiimfjsXUe2YuM2z5ICMwy
         yh665AVFS83olDw1UVrfLHD5g7FRIhuLcU1+8jI3wA/xwd+ZzbATfBfzE2Ee9Igg0mlm
         QZw1i/fCDaMWl+q7ZEr0VxNyxnMhDX39rVHYzsGDezTYDFRvHwpE39ZGU+pGKRMjRAFz
         oUtw==
X-Gm-Message-State: AFuF++ka34XB59qZSvLfL78j8HN+fjXKkR1x3LR6gworK7dlk9TwrkH4
	TWrFERhoWPCuTu169mdPUxskDKJvOTc4c0loUZE0aJuqx+Gi3GPdy3i6
X-Gm-Gg: AYBFou0evTd+7sQmHwaOTh3S1oWoWoVRo24EdNZdrcnZwYJkVM/BKBHnM7DqlNg3h4i
	/1tsPk6YOoUqKxBAXuGfwNAhK4c0B49gfSdY1jtnKBlmJS79TZS5zPNHLmz7PZ4k7lSTqmX0wwx
	mGS6cc7/FBHz6U6+f282KJZpRNfqU1ByfiM0q7N4FpHRkfvBx9SFo4FRb614KkpwyfT3KUUSgxA
	C19HNy+Y5S9VpH28O8sserDRbU58R9gro8W5xlaQvCNY/Qk0/wtpmAwSjWscm4NKZSGw/s2mCdQ
	yle+kuBq79+0mOJa5mFmMfaiGAtlwhYqXSa0EpwIW4zrZljx4lpWE7CkGVce/+9D+jljFJFmZUU
	9pBavVG3GTowOIiXaeySN2rueaDBMyqRR0wSy/zySxpKYYdwRWIiqcuF9zIvmT/lGOJwmuoCgt8
	UaA2uRhJ0wKnpR9MwMYD8yFFOpmeSlylXDDI7i8kv3SVI1Wm1TJFCcrdB1zH4aWssnTnBhEb5sH
	Ps6P725A8xIQy+D+fWouYbVyMMMx7w=
X-Received: by 2002:a05:6a21:4cc6:b0:3da:bd6d:bef4 with SMTP id adf61e73a8af0-3db40622a50mr12913747637.13.1789460012618;
        Tue, 15 Sep 2026 01:13:32 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba729dsm49686987c88.14.2026.09.15.01.13.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Sep 2026 01:13:31 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: maciej.fijalkowski@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] ipvlan: unregister upper devices outside pnodes_lock
Date: Tue, 15 Sep 2026 13:43:22 +0530
Message-ID: <20260915081322.7551-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
References: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maciej,

Thank you for letting me know, and for the fix — fixing it on the ipvlan
side by releasing pnodes_lock before unregister_netdevice_many() is a
cleaner solution since it removes the problematic lock ordering edge
without touching the AF_XDP paths at all.

Please consider my v6 patch withdrawn. I will not send further revisions.

I am sorry for the noise caused by the multiple revisions during this
process, and I appreciate both the feedback and the patience from you and
the team.

Thanks again,
Khawar
