Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118561;
	b=pV3hdVT+0H8p/X6RKanFhIEM2oqV7MRXbn8LIga0IsMCDZsK4cC/dOSY7TyPi427aK9r
	 3TQcyEd/fptRxkBsW+SRxQZ38TAy8lfhewG13X9uBNZ+UYap2YH1LAJjulc+1rZ1Pm2Vq
	 wJKFIZcHzET6rfTZldJrHVjtW8Twmbe1sCdxC4c21cdmx8E6V1TJhaoPQaVLoxsHCQjbJ
	 4t7eG1xc5XJU2EwXtYzULz6TFFwFDEvDoX81TNTA94c0VOLtwFbGaBsfo+jdPZiepcyG5
	 qqSlgrct+cO3WCAqOq31Wu8i4A891t96OiDflExsFVOhqE4nffAe1A37MrkBckmmMuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=18ChG/V31CXeEj1n+M7EIroUGFwFAzaDZETfAkzGms4=;
	b=KfyU0YheCkezWEt2bEwmoUNKlddu5wcOu+LLbEXFjBEhxJsps8npg/kcBR5j2cow4aa4
	 csLYgaIhC/Jhml0dENMryMvYwINcqtsnUeZ+R3a/5A8GB4I18LGHznG+b4koxInsle8IZ
	 +m89yjMWH87RsUyur/QgNa9V/3JfmAX/6+dy3x9JB44rSgcmcddlEKrNuWHO5ketYi3CA
	 xd46dzikWegyya1stC69yluudpclELottu1AQ4QowxHHnL8wDrGqXZY3CDx/5CaCW4yi7
	 BfrrlOvEc9W8wVtBWHp8GsrrX7a7BkpmyMBe7A6uuweqHV1hGfmx1ZDRFPI8tfBTGCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=bXbH2M62;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA838606A334
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA838606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=bXbH2M62
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3aded3c6103so52493a91.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118560; x=1793723360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=18ChG/V31CXeEj1n+M7EIroUGFwFAzaDZETfAkzGms4=;
        b=bXbH2M62OXvuDE3bE2sKzDov0MswjaQuHTDcKakUCBpF+Ssxo0wJ7fQiwC4vauOlxe
         ATaHiKFMubUjGAuVd0AOeg9Asm28S8NHhImD8ff6UnQVPDTzuIwe2SHQ58ehEHQRHERN
         Cs5yGBa0l16AzXWQV14v3USmyyiV0chDihjsZFWa9jfrh8O7kf1u5zWpcSNKEubOOHar
         tdQVkXaL25oPkyggaOAEGqq6JH5Vfk5Ddz5j9flmDpq/c8vgUMBiKJXau/Q6awFIA2rC
         3kNIwpDRFXq+GddsUVPmPvJ4tTGkWx3i7e50D17QIaoUJKrGAXvHHS49IOhatnRpcW/g
         dmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118560; x=1793723360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18ChG/V31CXeEj1n+M7EIroUGFwFAzaDZETfAkzGms4=;
        b=ymL1mWOAKvcr6Suh05Hz4tgH8PfmjZgDNiBHFmXoCQe21M0wbSslKiDCtTetgbqOJZ
         rWKr6jZ4Twd+EjQ8LH9PvpuyNx4LhygKL0TpDLicBDCoIh1xQy6bJNCaVa4vTfnVEbQB
         UBCKd3mzGDEX2xciOIrEOcKeh+s0FhD0ZDjGX8ZL4ZBtoLCyi08z4qZvDvY3orjJqVeh
         ZpoRwWijPyxatLK2Xil7UmiEBIh72n5OHjP8tDtyTybc6trPNEaRZQyg29QjO0i97u4V
         mxEjJwjtFB00JeogIkgnLbfgRpXmkYHOY1n+9ZJ3TAjPRB/sWri95baPJCZkdWraqACd
         yRgA==
X-Gm-Message-State: AFq9FYJKLc4h1BUhvDkMiXvamKAdznvuaQ9jguynWkB2ME37ypzb/dyg
	ebKSCn0x0t/1N4eSnNR/UhFEu3l9ajCMWWKm/y0ecqt+oztElvEUBl1x5bCywmuebSbYRG0tEK1
	9B/z7BVY=
X-Gm-Gg: AYBFou148I2+k4DvK6OvG/rEzl5GEXY7AvK9vgXphjuoK2XQh8EWdgXGxmHIoATkNtH
	bXVfAQPMeMUs0UADKlcw8JJSQ65Q0IhuiEZUtfn0pmfESLARsBbYTI7097v+2x3yrbxBH+lLUVZ
	lP9fFci/5zAMATmnbFh9PbhcgElwC0yqTlT9NSUJreHK5YIvQ49AmPuIhGVoSPXFM6qi8S0NEo0
	1eqSWqgDcS5wKB5kgSiDIYtqdoBCvehbAhR8f495fyI1gkYkCX/kjh0itXieo5rSe7sF8SCPCeU
	vXvFrglu1cs3tA4NWN8NilSyyH73xO4rq4/+JX2tjLkCqu4kg9018QMy/uoqcZo6nYLeQVmSI47
	yIy+RlCYpiC0hQwydvz9QWN6Hi+XwR/G9saV5LcBoNIzF0/ZxswDIX02x2IwpTT2Sycql7Zr0jV
	SBiYO0bXHskLVMGzc9hg4d/BBj76/NBsOYmpjn89Vtuglduj+pf+Zo7MWCcOnD2FG7ddeYyxHOH
	OVbRhlXyvRlU01U12iLEHBekuaxn6LwJauhx+A9FYFzmcxud1VlRXwJY9K/4neJQnEYMLxpvrTL
	qD+EWToUarvS+Wp/1ctkqDfNcmjRfTAueG8N4JhMUtGK/oXA4hmifK+e669FUTb0hQE/7UIWphv
	7IUh1lHJTpnEH
X-Received: by 2002:a17:90b:2f4c:b0:3a8:6045:5a24 with SMTP id 98e67ed59e1d1-3adeb0fa979mr9093738a91.38.1793118560091;
        Tue, 27 Oct 2026 09:29:20 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm7288854a91.4.2026.10.27.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:29:19 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 0/4] selftests/bpf: libarena: compatibility fixups
Date: Tue, 27 Oct 2026 16:29:12 +0000
Message-ID: <20261027162916.10996-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes several issues found while integrating with large
BPF codebases.

Patch 1 fixes a mismatch between the in-code licenses for some files
that do not actually correspond to the licenses at the top of the file.
Remove the in-code license sections, since libarena is distributed only
as source code anyway.

Patches 2-3 add an explicit allocator growth call. Some allocator
users prefer to explicitly expand the arena instead of implicitly
letting the allocator do so when required to satisfy an alloc. The
change is non-functional for existing users.

Patch 4 changes the type of the volatile zero variable used for loop
convergence to __u32. This is available from <linux/types.h>, while u32
needs to be typedef'ed in for userspace programs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (4):
  libarena: remove in-code licenses
  selftests/bpf: libarena: make allocator growth on alloc failure
    optional
  selftests/bpf: libarena: add explicit buddy_grow() call
  selftests/bpf: libarena: Make zero variable type __u32 instead of u32

 .../bpf/libarena/include/libarena/buddy.h     |  2 +
 .../bpf/libarena/include/libarena/common.h    |  2 +-
 .../selftests/bpf/libarena/src/asan.bpf.c     |  2 -
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 48 +++++++++++++++++--
 .../selftests/bpf/libarena/src/common.bpf.c   |  4 +-
 5 files changed, 48 insertions(+), 10 deletions(-)

-- 
2.52.0

