Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9C12D762
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555523; cv=none; b=mXdLlNXWmnxKYtJJgiKb4kIqrv7rBUzTCfDa9NoUmEjSTvRIxZ58gmlOHFKJpj+zFtU6ernDNe8xEyxJzWWC++lFfEWkH65IAj4bP3WYVuEH78JBIJWBRxVPXeLx1Ud4Y2x7JQ0Z/m9nTpf3lLCYWVWW1+HppoTbT692Xzqz3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555523; c=relaxed/simple;
	bh=EXr7t5ZyXFX9wXSbTzc9vLveFmblL3BI0CqEVyK8kVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6xaMJlwFcvrRC4SXznkAD4hbK8l424bRRxIGRyozoUSXHAH3KbZSSZxR4zUPmgaxhMbAmnggm9fJjraVBd4lzpBn2JnlyfD67F7CYylkvWSt86iWUHO5SsTlJt9QEbMtzxzFdhykBdyvnrG9kVSxI9ysDK82cwkMJYydYQtixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kj55+KDY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kj55+KDY"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e8f51d0bf0so11959b3a.3
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711555522; x=1712160322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwbw8Bfq5TVdPAVwgD2UahVCoOXtlyfhsdDWXgrrMaI=;
        b=kj55+KDYAdr/AEgfzPfnFh6UmQT/rKlyrwHbKWZ4X6VwcJIRS+hJV5AXAhl4N0mCne
         VpZveojmj0F1gKUuaVIAwjWXOeMeWLcU/7Uw3glu4EaUluKq0wskuKFZWQpuvsVRxwft
         2AltJBTF7rj2Fr8EG4f8xuwyNmhMvpTYB4Ey6Lge6Z7NpNi1/7IR632D36BiALXER0ku
         Cn2YZKqHdx/iAWjHvdEraAdAsDwVBRcCuaNMilVWCD/ftA1+/jzYmoiusSLuTStULuAu
         GqriH9sBOPgucTtm/kBs6ehYNfXLpUCn8e4/1WnqaGswaTGutMZ6KYlxlHdo+fme7CQ4
         xB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555522; x=1712160322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kwbw8Bfq5TVdPAVwgD2UahVCoOXtlyfhsdDWXgrrMaI=;
        b=uQWVjHXMuMo5GCjH34Q3XuIeIkhdDv6GgTQuSyHsxtU/hHWUDNUWPfna1PS+wQu5Ct
         aAKRUDzGdXE/QsxrREc6yme+ZXD+j+Vy7DmAyfr08fiqDdFYMR6K9nNjgtQkMHPnbmkI
         1sT2KOY6arC2PYfVl7oGWAlu9eJehLHTOi5eeQagvFKtzym+ja86so3D9wMmEpXroD5X
         xv0yQijE/o1DN5HEnTNJY3mJkc8+vxa/fabW68wSUnGIGnDXskFdfh3leStL2mElfotC
         buE7W6xPosCUD9eXY2pPoxavYzIIq5g/q6m//lvedb80n67MSl1Tk1X+X4WMCKHXYeGW
         zRMA==
X-Forwarded-Encrypted: i=1; AJvYcCUu0YOZ65MRubqTLjm9syr5YwiB1NcJMkVVBDqzNXR7/ZH2JPoCFkl0pJVq34Clxtn6hp3H3Z7+TbE5xjDnrj3NDZmY
X-Gm-Message-State: AOJu0YwaR05XpRuH8HW/J7hPadfl6bK2Cka7kFxPxORm/W+bhLysWM2t
	9AWV586t9l8i4xjPMUImSrx1BhYqZy+SMF8cZwC9VRQgKrexJZp+Bspbd8Y4dJo=
X-Google-Smtp-Source: AGHT+IHrHUQx8CTOsGUx7d9I0wuSaSBLdTL7D/z7DZEE6/9Njp7t/Ngzy8GHegWFTHCH7uUVnbidfQ==
X-Received: by 2002:a17:903:11c4:b0:1de:ff9f:aee9 with SMTP id q4-20020a17090311c400b001deff9faee9mr138103plh.11.1711555521786;
        Wed, 27 Mar 2024 09:05:21 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b001e14807f9cesm1718226plb.125.2024.03.27.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:05:21 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/7] riscv: Various text patching improvements
Date: Wed, 27 Mar 2024 09:04:39 -0700
Message-ID: <20240327160520.791322-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Here are a few changes to minimize calls to stop_machine() and
flush_icache_*() in the various text patching functions, as well as
to simplify the code.

This series is based on "[PATCH v3 0/2] riscv: fix patching with IPI"[1].

[1]: https://lore.kernel.org/linux-riscv/20240229121056.203419-1-alexghiti@rivosinc.com/

Changes in v2:
 - Remove unnecessary line wrapping
 - Further simplify patch_insn_set()/patch_insn_write() loop conditions
 - Use min() instead of min_t() since both sides are unsigned long

Samuel Holland (7):
  riscv: jump_label: Batch icache maintenance
  riscv: jump_label: Simplify assembly syntax
  riscv: kprobes: Use patch_text_nosync() for insn slots
  riscv: Simplify text patching loops
  riscv: Pass patch_text() the length in bytes
  riscv: Use offset_in_page() in text patching functions
  riscv: Remove extra variable in patch_text_nosync()

 arch/riscv/include/asm/jump_label.h |  4 +-
 arch/riscv/include/asm/patch.h      |  2 +-
 arch/riscv/kernel/jump_label.c      | 16 +++++--
 arch/riscv/kernel/patch.c           | 69 ++++++++++++++---------------
 arch/riscv/kernel/probes/kprobes.c  | 19 ++++----
 arch/riscv/net/bpf_jit_comp64.c     |  7 +--
 6 files changed, 63 insertions(+), 54 deletions(-)

-- 
2.43.1

