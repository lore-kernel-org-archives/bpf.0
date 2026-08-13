Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307340B6D4
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601793; cv=none; b=tUURO0DuxDI6YwFLrk2QAqJ7PIp9JdwT/IH4fUGTjaLoO62z+Qv9QgpQSP24EcYK6Tia9x2GMkNItxypsdJE48tJloGpOr0uh6zrljLIWvfMmTxZjD9+CpZyEY+mt90kL4OMhXAhxj1MEGDHi8Dp57ueEYZPApcDISFBFiCYvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601793; c=relaxed/simple;
	bh=C5r6FUXnK85JITcdf5+hrKsZ0/zeo/xBEREjhDG91f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TigAR6Es2W6vFMmiba1sEYewcH9vkZodJaquToZ9EmisIeo+SQYl93TNRyNj1QgbMyTkOStPXQGiyxsMH3ZpyB2Bhf4MgiNm795pIfw3/kskD8A5QkcsKC5jexEYy9kie5XCNaBnkdiZsbuZ45RKOkm65KBkFMzzOY2ISSS6CzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbDhaq7J; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbDhaq7J"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caf228a910so3252125ad.2
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786601791; x=1787206591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5r6FUXnK85JITcdf5+hrKsZ0/zeo/xBEREjhDG91f8=;
        b=JbDhaq7JDTzwS2vChkEXGloCUmZHjkilJFgOa9EpIqwyGWpN7higB725+oXByt7wLu
         UD6E5vRVotgadjh1fJmsf5QG3hIunBpvgVwqhouMpqAuMfenQ3Aoplz+s+8dnTlx1xAi
         GdOHpyaTdJfdDF323qcNoUB2h5t4ty87x4z/mZ5q0/mu9XxlP8haFaU76yDYEtthKjJ+
         ykQhQI+7lnZ77pg3Vup5qp1JuRgj22FIeHglSDxmLygJ2UFYmnzENsWAIegeJnz4o8x2
         0MoDvQipj3xOWr6JWmYE2SCTfpb3iTIjN7XWkYExFJM4NCKvKNzbYTVv4UoL3EIta6CC
         gzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786601791; x=1787206591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5r6FUXnK85JITcdf5+hrKsZ0/zeo/xBEREjhDG91f8=;
        b=JgJb777aHaOwq7HJgFebkyaSKIOEBsRUSTrnJwwyAjwQ7FMySt3v3jCmuS2zq+Klnu
         tRAnz0XZ/xdSfdvFT/zJGxHIRrPgQ8XM88Bnl0ZakvR+3Naw2sMcAbssKt4c2uBOIdA7
         L8VoffLpKQbYYLv4+28RTNVT2W8RnN1fA+L9LulflnSpscmfCxJD3TWIiJQVJC4qIqgH
         5pNZpA1+105x72Ipftza+/0Tmn4N/MbwCKnfTCTWYsAeulTbJKptwdgNtuDzEHtfmnqW
         1gIOu5Sit+gYJgIo0Z/qaTx7A3WKQ6e7Otgc0JnP+4CuYKMd4Rx7DlG7EgY11OnoMoBA
         SjDw==
X-Forwarded-Encrypted: i=1; AHgh+RpDhTVR/EIM37u2q3ttEBOfn5X/stO9ySRxGHTzm4pX7yvdxePAqSYXwgsq8zCK9ht5cEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGRrdP/YudJqK4auBvQYRpb6qhClFLB+KXBaSfQzvXa1AlRxp
	MgkDK+wSOQdeN7o3TcFKkBBPZs2fK5nrqRceLIf1wy2CaXqG2hM0PCjW
X-Gm-Gg: AR+sD108wunTiEL4w8QUCAu9HOdTTYuL47JNAPpWbNRVOcxbP4jz99qQClMWdKQdftq
	x2rbvXt+00tCkhtzrceT7K/BfwMxjYISoqAdbFTuJhEiahFM/pqxHa+fUt0q6eyk4LiLKh6BQDH
	oLlJH36Y3pVwGFf1jqM3QQw5ELOxqwyqGpJL+EBHEBwteEGvWbj5auGpIOlcsnKKqP/93L/E92z
	NLAeITAqjTaoIChWlxypnvQb1sBtzm/f9KHMnnOFz2Ygl4FDJ++zTp9eVg5Uob2hD6DVudFn+O0
	Bdi5HaXibwtFn0qnUffGuQJ9BZ5es07S0bPRrheyE/KuBs0PB+HI0ZDivDPHXREnNMQOgiR4Pgr
	gbYgVnODfj4JuE/hMXWoN+ZoIYY1e01gApyqWXy+h1RUjmS7+ZExDmM5IFYB1MaG4QFcWdpWhDV
	sRoq6RZlfix4peMoUtJZLccpEntRfmu49wJ+mE2T8nMt+6Rv25xhFGhAB6nclyMQFCGX/4LLlpL
	/aaUt3V+/pwKfb7/BfHGd1XC08zpKqtadZltXA8Rw0h81Q/5VWw
X-Received: by 2002:a17:902:cece:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d37d695848mr29190495ad.9.1786601791006;
        Wed, 12 Aug 2026 23:16:31 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c41403asm4648715ad.46.2026.08.12.23.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 23:16:30 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix stack out-of-bounds write in cgroup link update
Date: Thu, 13 Aug 2026 15:15:58 +0900
Message-ID: <20260813061558.2577010-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <916b5920-a2f4-4b05-b86e-6a29e599ffad@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Lehui,

Thank you for the review.

> not only BPF_PROG_TYPE_CGROUP_SOCK_ADDR, but also
> BPF_PROG_TYPE_CGROUP_SKB, BPF_PROG_TYPE_CGROUP_SOCK, etc. I think we can
> make it general.

Yes, it seems we should cover the other cgroup programs too.

> use link->link.prog->expected_attach_type

AFAIK, for CGROUP_SKB, the current program's expected_attach_type is not always
the link's actual attach type. Non-enforcing ingress and egress programs are
intentionally interchangeable for backward compatibility (ref: commit
5cf1e9145630).

I think we should validate the new program against link->attach_type while
preserving the existing compatibility rules. Let me send a v2 with a new
approach.
