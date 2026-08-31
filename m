Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29156356754
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142782; cv=none; b=s/aiLoQC2OQJWpAvEqCNvvQGmlN+m+WBht9V6+5c6VMhQTyT78AjlYpCtPnHYKoOh7jtvLSeSetcjfz6XZ86/F682urI9Jb174xB1wgQ8vkgN0f09AaK+/OnYC39mTA50F8cNVVtT2suJbdFYCiBFdM26SNdGFt+WX6CJqQSo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142782; c=relaxed/simple;
	bh=PKmDdjoSExMTA2FB/aqE86Yhv4zjpHd1fB/tpmI84qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rboSCyk0zvxbfOMDZMCoo9yi4cKysZUjWk/dO1zQTQhI8nqRuGeuoJ6TU2WoFKQ+/vWCW30k5QmagpMNprwdYKcsCTf0g5Qoyu3HSgpNweaQ1ZGlOG7EDcJSIG+cGYyI1F/sYFBHc3AYoGknOiuLtcmuQ+W0FrjNAMhiMr02G6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPlKjySe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPlKjySe"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso2502072b3a.1
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 19:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788142780; x=1788747580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKmDdjoSExMTA2FB/aqE86Yhv4zjpHd1fB/tpmI84qA=;
        b=YPlKjySenmiqHGA6mCHWN7bNtkY0S5XJtfroui13n/a/9rmxM+mGwo6EmveF7OE3Pu
         CJGr0NNe/EaMmm/yIlVt4mL7saAre4xvTBVhRq1LXyZ7UZrsy7vgk1NPaXHyMHdiy1iK
         Y94zTawtih2RZSMtlEri2ts/qV88dNtXSWnOPcmImAq8JlsAzNsIBIHgo69tbZzC2+88
         VXjH0Wb1cFloWges32k23ZThNO3IWj32E2gnAkP59CeokAxp2PhdirH1vUneWS4Mutcb
         QDb39STkpzdqXvb0RLpgnX3idKUjsORVPVlhfF8eJ5bGXAYKEaLaHJUrTdjyftHFTStM
         M+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788142780; x=1788747580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKmDdjoSExMTA2FB/aqE86Yhv4zjpHd1fB/tpmI84qA=;
        b=i8tnA2K2mFOi86S+XyfNLNI4n0YbXmkSCik8k0V0JwTBG8NI3+8hFZFRI6xVzQb3LK
         tmsyku87Xy4z7Lavv+7+88C5YKit9+IsVUB3cuiSC6YNhvYIxQVZTsEwxUEEsaxPA/ni
         fVoCuTDL9XhJm2gPbmKMxcOYV3DlwaWG6uP1DQLPfFZL5szZFfotz282qrwpN2s8qf+F
         VgHJrdh/R92Jt5io93dkg880mmGBFEz7iCF95lXFohGtuueZRBePJfe3hu/lyvGny7qU
         q5sRHzdfCyDF/y8B6RcyEnaRw1Q/KSvZF/APZfoubhl+gUianC2zGUeZW4dnrAPilNyV
         KtgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIjQt/yCkLC1Xb5j3R0+qmquAKJ1mVEW5qzrrjn5ZDn2tba1/MdulFrtEO95rePwkZNoM=@vger.kernel.org
X-Gm-Message-State: AFuF++mXjdzEVwKHgTVLCWSgs86lXJCgAOW9MhubO+m2NgOvm4TOMdnT
	JaCj7kSmkzqbG2KhouNygDkxa2O7/FOUzMCqjq5nj07kGg9BP4lDI8DV
X-Gm-Gg: AR+sD13hlf2PWx/ZL5a97unJe3j8tGu0sl3Lf0sg+PVgfRAPvvKd80laj6Vtv7ndt8F
	t68Y4Fvntia46yU+q422RUqm5aZEULwkXt8Tn5kIwZsxk39f+24RD8fv8zcEf/FRrW5OLjfnd7T
	gOarLyuiO4rAGTYVN7CgTc7YAVN34ZeUtUVxkL48ET3gAXpASniym1qEg97XvmqX9ktCq1IyCC6
	e0mhfM+ZLQ0FkZ4s6bnLCevr7P+EBEM/AZ9gXhPShDZrjnzjd8yKasHAZIbebllgK78Og6bQeA9
	1RnD3R/5P4jzNLOCSucKgkoO/B7y+4vD9O4t4xe3AMQW24C+4ZHvrmK+0xFzTVfp23JipZe7m5O
	FEVjo90hDO1GXyk3NnLzpt9pOnXf2a6GjXYlBa6HKCgneF8Bhcx7gHe/O1PQREIDbIfRtwvvXBM
	gxQiW3PvS84phlfxVSzWD1w4fqK+3Y4DNziFlKPTzPadjMVy0prlMWjteF/ka8RH+hUeyaDpnPZ
	IMIVwZZvl733Aj8D1uEU9WTkDynGrPY4Yr52cv5Z1V0RfdCMYZzTQ==
X-Received: by 2002:a05:6a00:ab0a:b0:84e:4d6:78fe with SMTP id d2e1a72fcca58-8562972fe25mr38688046b3a.3.1788142780409;
        Sun, 30 Aug 2026 19:19:40 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569fa7d8desm2941001b3a.13.2026.08.30.19.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 19:19:39 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pu Lehui <pulehui@huawei.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in cgroup link update
Date: Mon, 31 Aug 2026 11:19:09 +0900
Message-ID: <20260831021910.1835461-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <22d83e2e-e732-4549-9bfa-fee38f7c6143@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you Andrii and Leon for the reviews.

Let me introduce v4 addressing the comments soon.
