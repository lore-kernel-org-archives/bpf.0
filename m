Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC304B8DEC
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650071; cv=none; b=NRdMzwabty3RcSZ4ufO5xdZHjHU5nN5eqUTMhNLVyjYBRoGTwqUKhT2db58ZIcbEJOStk3ar9sSXyslNcVoR8u0glwOzCoLmQ04wJsQ8+/x6lZbVrn2PYZ/R6wwpKoaDosLw/7jgPagFU7uKHu6hBKc3cp1AjDRbgeVuDY6igbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650071; c=relaxed/simple;
	bh=o8BGdjq1Uu650RISG3GNTyGokpi2RqaLxlN7t9YSlPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN5enxfRswr/xQx1fLBS4n6GC8pxTbd919XU44Z7VBViD5OYOfqajTOMoVScOBTBQxMIm27poZ9OMMoUSL8Uer5ejAdNmjnNDeNGZ365JK2vItowQ9J136PuTQctFwjkhBrBVGt1NoNGgRDrI+9A6u8P1rOF7lCUpHEYp9e6F2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbJqsznC; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbJqsznC"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so1531430a91.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780650069; x=1781254869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8BGdjq1Uu650RISG3GNTyGokpi2RqaLxlN7t9YSlPM=;
        b=BbJqsznC1aDzjzu8k2S8098KtddGlkbGsT15vcLJKsH7bL8JynyPIh87IHA9PSVa1h
         n2jmCcu8WIg7JuH55M610vIAgx6zszdRKUZrUMNnI8UGknhJTh8MJrlXDVoYsU6vxJc6
         Fvsv3uN4NxpZHOIqioqHLDZrbSvBcwbhkmL1CkKDsqN5qmZ6/IzjWY+BAja1HpOWusG+
         pUyxuxnft3zCCGVXsMvHv6yTw7KIbcroyj85/Xu8siqQvdgLW5xQjBxjv4XehBIfjgUZ
         3ckCq284/m74Yf0wxJQ2BZk7PWuiAne+7GAqRePt4E99Gp9NHzzR5ICL8ScHB3eSqfbe
         1Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650069; x=1781254869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8BGdjq1Uu650RISG3GNTyGokpi2RqaLxlN7t9YSlPM=;
        b=cdF5IPONlcJM2UL4pV6Gnf5oRlc1UhzahH1m6pGAFI7rIGCUAsO9pDnP8G6kx5OG3v
         rgEjLBJ4ToxpqSj66BTnhv0lEa+/MNVSrLEo0dI0aWPekrOwUc6SkgxBZOFwPLMgSMvK
         1mFXWtWuO5r1hNU0rNZoUqTTUqTDiUIUCLcIDYTkFs/NssZvHhRBP8dZRIJYwc7hA0ZT
         SW0I6FNQmh8V4IVvktU6keElqHMGqd6Dx9G2nOOmm0cKezsYIY15A/GOr/HfL9HCK0VN
         4Peg7w9bkYz5dN3qWxeB/aUjGWNwY9e+5/KNNObwSK2Vylsq2nAyfij3ZvoeHgykXJc9
         7NGQ==
X-Gm-Message-State: AOJu0Yw9gdzG1jEAIkH8fwFYRKvnTDhDRFx8zAdldTxiep5JhLnsmvLJ
	OEXygf56CDZs0qX67FVAmAjFGQxHhA/ojadcM1cCue1Yr6sx+IMKSByj
X-Gm-Gg: Acq92OF1Lqfz9kk0dr8rHZoDEdAtfkWuxLKPGG90TeZKHsBe2r8DYMDvcg4j7WGKAv6
	84DesmkrWR6t/PN5myRII4C6A9YBxOyQQ3iRVy1JeUbqPWN3hZqRb0ewzzlNssnl0HbGmBsgAvk
	VgtN344fmRlX0P7euJ06py+rw1KNeEOESMl4dhnvtCNfZaXyvlw13hwxcAnbo45oX66hSLqTwPN
	4Ua0ASezc6BCwOelSrDSTu+5OlwjWhfTHGN1erWjmdX6a8TEV49+pwatjgUFZ5ets0PjA5vnrzy
	G37lRtWN+PlsfEZ4NTB1N+HP8O+EZhSZZ/6p5ekM4R2NG9se8PY+IMlR8hwqWj7oDKPOklAikn6
	QC6Uy4VoYiRBBuAWjm4QiveAkqDB7pJd6kVm7evGhuj5QaiXvCLAMlhIW+/QDtDIsCUwBspxd84
	mzP7DFp4PtZTwa5/kO5y2Xb+s=
X-Received: by 2002:a17:90b:3c8c:b0:369:74b3:a103 with SMTP id 98e67ed59e1d1-371316163cfmr1609773a91.8.1780650069088;
        Fri, 05 Jun 2026 02:01:09 -0700 (PDT)
Received: from laptop ([59.6.68.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a4e59sm7670920a12.16.2026.06.05.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:01:08 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Woojin Ji <random6.xyz@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add arena direct-value one-past-end reject test
Date: Fri,  5 Jun 2026 18:01:00 +0900
Message-ID: <20260605090105.511475-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DJ0DRM980L8V.3MR51HBLAVAEP@etsalapatis.com>
References: <20260603-arena-direct-value-v1-v1-1-7b31cc0a8cac@gmail.com> <DIZJ5P33U6YT.14OWBKG3T9LVD@etsalapatis.com> <20260604153712.199362-1-random6.xyz@gmail.com> <DJ0DRM980L8V.3MR51HBLAVAEP@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks, I dug into the inline assembly route more.=0D
=0D
A hand-encoded BPF_PSEUDO_MAP_VALUE ldimm64 in verifier_arena.c can produce=
=0D
the right instruction bytes only with __imm_addr(arena), but that emits=0D
R_BPF_64_NODYLD32. The selftests libbpf/bpftool link step rejects that=0D
relocation type.=0D
=0D
I also tried register, immediate, and memory constraints with raw bytes. Th=
ose=0D
either fail in the BPF backend address matching or NOP padding path, or low=
er=0D
to a normal R_BPF_64_64 load followed by an ALU add. The latter does not=0D
exercise arena_map_direct_value_addr() with off =3D=3D arena_size; it tests=
 a=0D
later ALU-add path instead.=0D
=0D
I also checked the legacy test_verifier route. It can express the raw insn=
=0D
directly, but it requires adding arena-specific map creation and mmap fixup=
=0D
plumbing to the legacy runner. That seems more intrusive and less aligned w=
ith=0D
new selftests than the small prog_tests raw-instruction test.=0D
=0D
So my current preference is still to keep the userspace raw-instruction tes=
t.=0D
If that sounds reasonable, I can send v3 with this rationale added to the=0D
commit message/changelog.=0D
