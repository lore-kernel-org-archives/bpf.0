Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BA3E6DFA
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789899673; cv=none; b=QEKzn5uUQCc7CbAuaePAzSvR6f2wKm3rrD3uoejnCKtgZAJy938bs9Qzs+90ni8GeIwUZlLLC6FrWxL0mW9anRTCAmHN5iA8GNhSrviEFx/gxYuMO4ya1uiufvLoKqZ8c3SdEwHrAzpoyRI9SkCk/+GyMZUXrTHtG0fw3JGDE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789899673; c=relaxed/simple;
	bh=DXs70q+uj0fOTubAL/yj2nRY1q+Sd8JFHOY3sHHBGhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKQN4uR8Oc+WN5E1XTNGSN+nl5gjeVpVzEheNNRzEPghKGvtrkQa3IVinnljQZfYnzEkBU9gB4DHQsBp/n9tXjeVzEG/SV1bBFKqFHS290YAjlMkv0ezFSte7GDYQAnq9iQdqu48Ak8NpBFdIz7wSNgzdfv3mXJGP4B++pCSkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9m/wlJc; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9m/wlJc"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed9866so18959775ad.2
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 03:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789899671; x=1790504471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DXs70q+uj0fOTubAL/yj2nRY1q+Sd8JFHOY3sHHBGhE=;
        b=R9m/wlJcx2ZyuYnkIdwDaRDO8ThzohwKv7zrxAqJNj+JDAdHYoApbOWFMPXc0SvQMb
         z+A5maB1IKu6z94MXl+r0cO3h8Cpfz+1m7u6aMaoIcC384ffE8ZfJaw4f7Eq0NYDbbY3
         ARJKpWu1J+8CM9g5YhG0t05S4n0Q5Iu0e0QrR+6/1Hi50LZPjpPCQcNDQ4u1dm3wsrIy
         Euo3zuVgRV8KyvNlUJvLF60El9U0HYYIK38QR+9z3w7/3o1ZQYswleml0bs8KDxnZBTy
         +33mVF9dFIucWCD1UGhM3fnETViUvmXBTqIrKvt4ijx/NOtUrLyAAOINWOqg/CwqzOTk
         HlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789899671; x=1790504471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DXs70q+uj0fOTubAL/yj2nRY1q+Sd8JFHOY3sHHBGhE=;
        b=KovIdQHtkDcN+0V5oN5ej3YMZvnSjxiFvkLRTXdPMvYR1m5c/je0s4uoFSNWdSDIMx
         xeO7PrjzAVs4YNVKPJMiUt/17tq0zE/pHx92ZDxO0dXo/9Z/GwZUA/Dzh1MIO2bKcf8w
         R04mLfxtAs0mwshOVUQvXKFzSvcdU3KUUoUHnlxo3bSUVRKvbZEyQlNIHweC/RntHYwb
         M+MroOjx9AICisRW/6SSP/X3iz1cNa05LkYtyf/zpWjuA0aozW/lDTwcSTJs3FtrOIoG
         hgQb2lzMYJWQUHOfC/KnNuW3pXsFWYcujsTnD4363Zl44qZyiTxzsc2NbP+njwLX1e99
         XF5A==
X-Forwarded-Encrypted: i=1; AKwUvBwo6MXa2VNaEsQ7GIbIiiPN6qgm34ioyjhypSQAwiKcgwaw6DEEAtA7qGI/sXjdwRWZKiE=@vger.kernel.org
X-Gm-Message-State: AFuF++mJun3vFTp57HXmjAznCrEvmfhq0aVa7TqwGvqovecTGN1vEd1N
	9IktVV+o2QSwGG3lFVCwV0BTZjuihozQcSWcqyomtEqzi8V5eAxDZGE=
X-Gm-Gg: AYBFou0ewHu/N8pxlDBMJdBXdtr76q8jcA7kk9U+nzN/qRPNU4jaCf00EvnztZT8KPK
	1Axc85nqTGBRGHjU0sHRBDMANyXGPkp3moZmsUCY4Ykeo7sgzeY2RluOOJj9CJr9R5W+xlxizQz
	rSz9FjuwF8E0HT3uUcL4c2ly130xTYisWdSemT6F48Kvw5jdrFTdXUwy9VvgshXFgeFRAMrYl1H
	UtCOBgweQpbe6iepmUBbyS3lIrOwaPKj5TCgGakBVEoaHFGPZcPFHtTywoX4QtQwz2iqhlDXiXO
	mEcVaFhKy/BOPkwQzRGf6gTsVIY9C/bvHvtI/sspbeBDrk1B6yOCrtCGjqLGwqguQ4UAvmL6QRh
	RK4ffCTQLKXBz5ZFme7LEaz6LIoqu4ypTTfnklpvihw4WzMjphxMMIbdsf5oxKVEX+V0njBsEtT
	jj+GPb6AEDWin+/uU9SPWxAtH11oMIjSFhaOlLc85ATETT1M5j5iwSMdtEZgVPoce1a2WgzZBvV
	Ayi8zCW3SqmTFIEW5d/HohIw4g=
X-Received: by 2002:a17:90b:3a43:b0:39e:6c68:c778 with SMTP id 98e67ed59e1d1-39e6c68ca12mr6544339a91.46.1789899671224;
        Sun, 20 Sep 2026 03:21:11 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c37a88csm8550850a91.8.2026.09.20.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 03:21:10 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created element
Date: Sun, 20 Sep 2026 19:21:05 +0900
Message-ID: <20260920102105.445051-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920095859.635921F000FF@smtp.kernel.org>
References: <20260920093153.439743-1-donggeunyoo.kernel@gmail.com> <20260920093153.439743-3-donggeunyoo.kernel@gmail.com> <20260920095859.635921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 09:58:58 +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does this force a hard failure on uniprocessor systems instead of correctly
> skipping the test?
>
> Since UP is a valid hardware configuration for running selftests, if a test
> requires multiple CPUs, shouldn't it gracefully skip using test__skip()
> rather than asserting a failure?

Right, that is a bug in the test. With one possible CPU there is no second
CPU that could hold a stale value, so the case this subtest exists for
cannot occur; booted with -smp 1, all three of the new subtests fail rather
than skip. I will use test__skip() in v2.

> [Severity: Low]
> This isn't a bug, but the BPF subsystem strictly requires multi-line comments
> to have the opening /* on its own line. Could this be reformatted to match
> the required style?

It is not a requirement, but it is the documented preference, so I will
follow it. Commit 82b8000c28b5 ("net: drop special comment style") removed
the netdev comment rule, which leaves the general preference in
Documentation/process/coding-style.rst, and that is the form you describe.
checkpatch checks neither form. I will reformat the comment in v2.

Thanks,
Donggeun
