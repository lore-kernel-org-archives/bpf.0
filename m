Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9884369D5C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379344; cv=none; b=QQ8X01aC51YAXNinIqkJFQQBXJfb4XJa9rFdkslF5bqayNkeCHHfNOdqVkGS/ivc/XlCICMKGtxk9Yr9qVN0qPD2f5Q/NcuKQn36VNQmnhVYpn3uGSnsI+0J1lj6XMj5CWVPoQhif/ph+LdpSUWAdNcxOdKoANJEytbRa4VaI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379344; c=relaxed/simple;
	bh=Ncoxx/H8e0cZ1Z+w53G9pjcC5IWEwthkyrGWoy28ASs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZquaAcNhhcEHnO8n9MDTqznlTxUrHUCfgJerwk3KpM00kD23b1YK1OpURHLLptc44Rv3w66Qkmv/vOHID5Yxy4Byh4ow6HT9vEQqwVKJ6QSexl+tYsKB9bDWbPIoLrgx0F7VX1baoMvL3bj5xkrVNasOrYCt/8pMftYzKAEs8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=E9UVZq8J; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="E9UVZq8J"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc791f087e3so404980a12.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790379342; x=1790984142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ESpxV/d5/QrY42awP/ucTVQlxcWEMBqtQNksoja5WtU=;
        b=E9UVZq8JatmEl+HIpmEuIs4Y8E0pgUXycCb8J74MVMF1aANRpVYtumC9uBo6p/Ux8o
         jxoBfSzQMzCcmqW+qZ8cWpDB69GntlNE0jDQ6uJAMweOAGMW4DXD6dfVBE5TerLRXfOi
         S7Vu4pSnBCn+VEMp8uAPHh1Q40sjh1IQ1kjo00qfY1zdFfetnZXdHNxsaBExCqNol/Ro
         vkDXtUIXtUv4xaHQHA5COnx31ZXtNKGlqKcxX0dIkdE0XrU3moM7yJwt+mpELl094TQ/
         DW5AJPKOW7qiyD7lrotA1kPiooE28Mz7dRYpiWWVM/QXTOKFVkldsukd7/qZqGNWOBj4
         696g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379342; x=1790984142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESpxV/d5/QrY42awP/ucTVQlxcWEMBqtQNksoja5WtU=;
        b=ialsfR+LNbYD7YPOPwCrbtuWmWd4hPAFBSVLrBor7w/CrB3tgFF7VsWxmIDN3yezJp
         l75k5E54iLJ5jEUkXlrU1SBwhJlxcPSB5RosHnGvbfJTrt3pxwRLDdb0YfahpgfahgE8
         9Rsr5NiFYB24LAdTEOpMtvdha+B2hywIdM7cG7gb0IawbD+WOAomy2mAZfn+dDJJpALc
         LUqCN+BU3iBsBq5vJOWThFPBoBpVmz83n43OqK/sZUTH8G6WLAsSEj6flDKhh2ljotH7
         f+QhvYtzrqLQFanWh4DNfPte8qpQWfoqi3Jf0uTq5xlOTvUPft94fIo+rN1flSUu6KB5
         QEhA==
X-Gm-Message-State: AFuF++koUfBMYGnXlLBgn/ocaRqoKl6y+g31vIvrnW0uSIC9GTlpwvOa
	L7KjK89+sLZixGLfXml9pm2yNPtih0H77JHHXBG2i4Phd47PeWpCeglhsoSrS+HF6jAtVmOGeuf
	Fv4d9c3w=
X-Gm-Gg: AYBFou3+M9XL7i/+67995hvBaJZM24MwjOmuNMn4vuUi0w5lFAmyBrkY/S0HpFv5sFT
	CGt0Vckn/ijCTZ/Kq4/1OYoaYtWvfoaifVVBKYHMRQQ/MNdPC3y+W+rKM3ox2ltlZpdYIJSrEF8
	/AUqN724nIWmuRpVqKapipRTYKHgKyedvw21esVmEDn1Mp7hT6L4SNaGzP+Bwg9D6EvX72rq63b
	lQuau3Lpjc3dG7UkjFVKOjbqxpxt687etdYkkQCUhxgRoRs2mWDyfl2NsdRxm+hKHVd8/FPwXyx
	zMSUDc4nM5pWVJ0C+Sfmsctkt7W6N0dAClNf7C9TcOTEV4C1WubSmj7My3TdvMQXP3cB4JhJM+6
	gaZBdrXRSc9sGom7nWpBSmR8b4P6XVUIsG8NuzvWo6Nb5gVzJsIaTKju/6+ccTqWsjCmOea+Pc6
	1KzJEZljLESUgDphV78Sx4l9hiLcb4XeDBOROml4pah3ym3EWaHJOr7CnHgtET0TO3bR9bizBtR
	cFFYqU8rSJGCk5n3wcbaqnaOewsrFFz56ePy/1luQ==
X-Received: by 2002:a17:90b:37cf:b0:3a0:dbfd:1a1b with SMTP id 98e67ed59e1d1-3a0dbfd2680mr432761a91.27.1790379341923;
        Fri, 25 Sep 2026 16:35:41 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm5790436a91.15.2026.09.25.16.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:35:41 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v4 0/7] Make sleepable arena paths use sleepable alloc_pages
Date: Fri, 25 Sep 2026 23:35:31 +0000
Message-ID: <20260925233538.5708-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena_alloc_pages() call takes a sleepable argument based on whether
its caller is a sleepable BPF function. This flag, along with the context
the kfunc is called in, decides whether the call will try to fulfill the
allocation using the regular or the _nolock variant of the alloc_pages
API, by means of bpf_map_alloc_pages().

However, the arena_alloc_pages() call currently only makes allocations
inside an IRQ-disabled critical section. This forces all allocations to
use the _nolock() API, which may eagerly fail where the regular variant
would eventually succeed. There have been reports of this happening for
sched-ext schedulers.

Restructure arena_alloc_pages() to use the _nolock() page allocation API
only when necessary. This requires moving allocations outside of the 
spinlock critical section for sleepable calls, which in turn requires
slightly different logic in the allocation path. Replace the page list
allocation with logic that reuses pcp_llist to chain allocated pages
together, allowing us to merge the code paths for both sleepable and
nonsleepable arena allocations.

Also fix kfunc specialization to not unnecessarily force the nonsleepable version
of bpf_arena_alloc_pages() for call sites that do not need it. This requires
making specialization per-call site instead of overwriting the descriptor
during fixups. 

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20260824082530.47553-1-emil@etsalapatis.com/)

- Keep the sleepable and non-sleepable allocation paths within
  arena_alloc_pages (Alexei)
- Incorporate bot feedback on selftests (bot-ci)

v2 -> v3 (https://lore.kernel.org/bpf/20260923191125.5311-1-emil@etsalapatis.com/)

- Remove the intermediate page array allocation in bpf_arena_alloc_pages() and
  use the pcp_llist pointer instead (Alexei)
- Fix function specialization to only specialize to the nonsleepable version
  when necessary

v3 -> v4 (https://lore.kernel.org/bpf/20260925203939.4105-1-emil@etsalapatis.com/)

- Remove in-flight pages tracking (Alexei)
- Remove stale split sleepable/nonsleepable error handling (Alexei)


Emil Tsalapatis (7):
  bpf: Use an llist for page allocations
  bpf: Add sleepable argument to bpf_alloc_pages()
  bpf: Add sleepable arena page allocation path
  selftests/bpf: Test large allocations for both sleepable/nonsleepable
    arena users
  bpf: Support call-site kfunc specialization for near calls
  bpf: Support call-site kfunc specialization for far calls
  selftests/bpf: Test per-call site function specialization

 include/linux/bpf.h                           |  10 +-
 include/linux/bpf_verifier.h                  |  15 +-
 kernel/bpf/arena.c                            | 158 +++++++++---------
 kernel/bpf/fixups.c                           |  18 +-
 kernel/bpf/syscall.c                          |  43 +++--
 kernel/bpf/verifier.c                         |  82 ++++++++-
 .../selftests/bpf/prog_tests/file_reader.c    |  15 ++
 .../testing/selftests/bpf/progs/file_reader.c | 129 ++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  64 +++++--
 9 files changed, 405 insertions(+), 129 deletions(-)

-- 
2.52.0

