Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467F3DF000
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277623; cv=none; b=NMqub4MvRwUGMxOv+YcEskyVehYX5nts9jJX7Srlx0Nw8XW45MELcahG2nDzgWRKzxlho9ON+NyRYK+lnzn/XP8yiG0NiBvhP8+YXWC48RfKpLuJjyBzqLu9rO9UEadHcxRYYNOphV0zlCn6gUSpFLN4Eh20N8Xd6mEM+BGMs7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277623; c=relaxed/simple;
	bh=SujIPjokdXDiNF7iEM351TKsQW6gCVrs+hRReWJEk0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYiJ440kk9P43e3RQVvnCdLAKNtBpApEISQHhbCl+e0oP36xrrVQaYxs7mkhed39j4iyE+7l8Dl7qmEvUx7fnaJlm8Qxm+ecrdairbMv9DHdQh54lxK+mW3ZWZKFe8fdTdia+E4TZTGBFLHIIVgw8wll0nIUzLskM4jU/ESRvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYh6RgKH; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYh6RgKH"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49a10ee5aso704671fa.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790277618; x=1790882418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SujIPjokdXDiNF7iEM351TKsQW6gCVrs+hRReWJEk0k=;
        b=FYh6RgKHRCP15zfoZVa0b7SiyhDeFpcHRB1iNsuivruZnzUCyZQbqMtC0O5ID4ftjr
         1CF5jHsEVhRwzLeRA63r7BExT654RY6/xXVmAIdWbVXPur1+8rJcm/pkldyfSIDOsopt
         f+gR8LccoXNrr1bm3Oa+d+7E/su4bStFiyRvJR7ZKee4oyZRqE02a74WKKPBQkmm3E+H
         4kPq+16gfEoCOpbN+4huDO7/Xu0AkNqsQD4zf8UCjDrzUDFwQZLEjcwv17Sc48ggLKVZ
         qyGJUIM3piWFQFh3US8CV2XEGZDUF+M2feKh045GHlAsppc2nrhEigZGPoykSySN189D
         XP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277618; x=1790882418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SujIPjokdXDiNF7iEM351TKsQW6gCVrs+hRReWJEk0k=;
        b=OUNIZYvPL9h1G1UwW7JCYNO2+HrJEgJVRFnUGFSARZuFnAMyyPXyIfhGFl3dWjRV6K
         KMgy9aZpTCTg/abmnZZjn699ET/Dp1Z33c5HZrwfzOd1ouKEOMDrhGlucGETYyYLO35C
         0cO7T72RB9/hd1Fn4AeOGTJOdq1azmnrzMvaHlByPQMDxyH4hj61O3UliI5diaRgl04W
         w1VnXFrr/1XSTMgOf4o4KH2iyVG6EHGpAgJLBCKbOfgec9T9RWVfVbWEJTMwOFhjFak7
         1CN7Eba3CYZuX06HqmCirN/RAinHk3bV2poahlLKhBv/Jga9NeA09nacO4ISGR09KcCP
         aElA==
X-Gm-Message-State: AFuF++mASPw1yZ8UHiXiggDZVn/w6A6DIGVec6UdUsELUM1tA3oYqQpm
	cVpk/mTzChO3JH3iyJi0d9wdqXe6DGN0uDGMoDFvSGuxnirlojuJ9GnC4+FcgkoW1LQ=
X-Gm-Gg: AYBFou2batBYttEWfDBNbux5NjWi/Zn0lLXggxKfrw2XGxs2uujVGF8oFBZdONPzVo4
	t1I5ZLbZRnns8aHtaqoMSx/csRqu3s5SueIMxr9Fo796Ew4MqGouTlhNEyW8awySoQnyiKAnzhJ
	YndQYJuavntRH+KVIzyi958763Y5OgSx80H3ojkeD0s6Q+36/ArOLEc3+zy3nWPzWW3/5RNGLqd
	cpXmfdH37WOSkvKroLyYOhkCzYDm5fYHTRHsnSKMFigyEJAwflTbtsBtGpQhwgbudcxyAeWEvRl
	tWZHNFwHjD7Iffysow8QsSKMd5KBDe05pAEuNMcU74+JULqjOG6wpznn45C/nKop/ICvksY5+eh
	ImKKBkmP37imviBctQ7e+mLFmY4vI9xpTpWm+CiPiErHqKxAbjnvFi0GPtPAo+tJhIpCiTw/INS
	dkoNY3YY3Px6o+GEARcw9xCteYwm3ljMU828fj+Z9akhQoNAnY63Bh84S2tlIKVM5fPfI3DlNBp
	uc226i1SvYWtwW0
X-Received: by 2002:a05:651c:198d:b0:3a3:37fb:27b0 with SMTP id 38308e7fff4ca-3a64c36f2d0mr15401fa.0.1790277617579;
        Thu, 24 Sep 2026 12:20:17 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.131])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e68e5433sm14426e87.55.2026.09.24.12.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:20:17 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: Maxim Skokov <skokovmaksimevg@gmail.com>,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpftool: Don't report an empty map when key iteration fails
Date: Thu, 24 Sep 2026 22:19:55 +0300
Message-ID: <20260924192007.548470-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e6dac20d7badce84d1b4601f9551fca3235417ab3026173d4e9bd9e3348d42ed@mail.kernel.org>
References: <20260924160732.485650-1-skokovmaksimevg@gmail.com> <20260924160732.485650-2-skokovmaksimevg@gmail.com> <e6dac20d7badce84d1b4601f9551fca3235417ab3026173d4e9bd9e3348d42ed@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the points from Alexei's review, answered here:
https://lore.kernel.org/bpf/20260924163536.507053-1-skokovmaksimevg@gmail.com/

All four are addressed in v2, which goes out once 24 hours have passed
since v1.
