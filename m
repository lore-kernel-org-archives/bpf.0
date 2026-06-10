Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEDD3368B6
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065441; cv=none; b=rfjizGqXa4Cxq6KwUMief3JFHkpFL2/7Nuh6wbq4vVi5vNvnifM08T4xBrkBPHzHNgKf7YaXArhLqeNgcO2otV6SCsc4TWZX4fznVG2jo5va+KRWYl2BBG46XW1YxDjA7LSAgnd+NDGFIEYrKwtklwZya3X+KBTuM5FcX/UNwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065441; c=relaxed/simple;
	bh=5ntPEoJ9Ahof1wdW8iyMYagQKQf/6XdvTtFTm1Yg5PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU1j5WrPUXdIG3UZefm+sJmUGsD95brB1aPfemX/aomFtztbCzNLLsE2gjSwtYK6RZ4Hf8dFrdUAR5XqOT6xK4CUhnxvCkasQQ9u39sUyeHaEIv/yu3CAktFn4il9tTXnQfwYl7leWllOVEIqpLrb4o7yoczYMAVrpjMUT4J3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObxD3hAL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObxD3hAL"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8422f148dfcso3636559b3a.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 21:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781065439; x=1781670239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ntPEoJ9Ahof1wdW8iyMYagQKQf/6XdvTtFTm1Yg5PA=;
        b=ObxD3hALDyC7b4Upfsgt/qgJbF3ttPsm9BrFpLi393Wm3erxvmEgSHDSGUgiAHtON9
         acdaKXQUddLrvQakKaFzsBQw3o2F4lngsMvySpMHbEjq3znR5NVjURVeLrcwpwMdAcce
         H11ieRQqSFLX03uK1JUm5fDZT4WBAB0TcGmMIksduWsYywc70GX4bSSxGPwPLW5FlRz1
         8CM7iTUT7ictWvOgGlzs4dES9Jo1lyU6wAiiojKHoelZAxp4fje6tatTCeXdq6Gcrh1e
         H5Jz8oh+60T5iFhkXG2itupF8415V/OucOYUaQGu2yCPq0qYz2SD2MXdv7HeBlNGiciT
         6VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781065439; x=1781670239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ntPEoJ9Ahof1wdW8iyMYagQKQf/6XdvTtFTm1Yg5PA=;
        b=RldieSX58qGsDYT1T0a4HMBk0x8MMjQ+NPXKdY91/6VubX8juStfVeKWxzwWBvy1Zb
         xmJY3EL0FIV+l9fxVbDy8jD/ZW0JFYCiocGIXGDwVVeGuo37RqPvIIhIvYCemr0KEJxV
         OSPqCGQ2/KD32Yeo1zXVuC/yqcMYAI4OOWoBQGWoW4iCTaWtjj3AFOYLkX1FVwz4HXrS
         Bnm11gdPNkPa4Rw55JWOVKX8Dz6ujMyKZDCdHSsTu/s8XkKDyWdhq9Sky/NEYEeFruuv
         Jju9qmDn/N//Yvp7QbROMxtlLPGnDrXMiI21EYn+457pkLbKg52Jnt0BvxL5cwgZ3Aoy
         XbZw==
X-Forwarded-Encrypted: i=1; AFNElJ+o9hbNZvZJfLPJQ5SrEiCLrYGp6GNisLV2dji4qs6ecoOew9gLi7VCDqsIwDmLZS49Qvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjZKUPYFFR2Y+KSfy28hZdHlVwiQEcbCo+bkV/+39eQumB9Ie
	tpd1cESBHeMVIqVJGh/vJNz3+OCJQSvPuFsD1MoYAnOwUgQIC3lOhO8A
X-Gm-Gg: Acq92OHB/7B6tE5yy3KBO9Het6Y2CCFXP91JIRhKkiZ2M+qqqUzrvlva95yoyhllklB
	PNqL33NUG81peULz1XtKsjiyNFDFyU7khh8qHHbO8CGWkWYwbA+QYyPJpeZ/cUvkVqbQxX3QY/H
	0ayOJMWlVs2xLHFuIicXE5AX5KV2k4EbTVVCHy8V2b7kXib9LAOP3qSRFmbnLfYI0zMBYMPxccx
	fmk7KHqTP8EVKJoKTEQTxDLIET72vyAPtHpsLAF+vAiv6PYcBiYULzUYVg3KW4SnjvpeydzbB6Z
	OS6y9xSQldyxuVRStTrfC9IWoFtOSEKz7XG/fpbbfBuTSvbTQ2zHgyqdSjOg1aYk6qmQal1tpQZ
	glWZHBvN60KR5gQgllh/hz7vu6K52Irr4nF8AlabtBHL8p0t3gG+uAyJyd6hXviap7D6mXAGwKj
	+iTp84Y6mwkXSR2fm72wf1G2pk7JnVT0B7XlYPCIrmnYEyWBk2X3PMEYYeqaKhZuoqunxAm4fJX
	516ISTH/EDkuRIHyGml2q5OLQ==
X-Received: by 2002:a05:6a00:3d0d:b0:836:5c3c:2054 with SMTP id d2e1a72fcca58-842b0fbb621mr21608436b3a.37.1781065439326;
        Tue, 09 Jun 2026 21:23:59 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828cf783sm23562656b3a.40.2026.06.09.21.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:23:58 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: bot+bpf-ci@kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Date: Wed, 10 Jun 2026 13:23:00 +0900
Message-ID: <20260610042301.442045-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <c66036b0e1528d69dc15e19faca58b8aa3453cac9d2554984b3130e96321b357@mail.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This looks like a separate pre-existing issue. This patch only fixes the
mm_struct lifetime/UAF bug by pinning the foreign task's mm before using it.

I can look into check_stable_address_space(mm) as a separate follow-up if
maintainers think it is needed here.

Thanks,
Sanghyun
