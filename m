Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792811450;
	b=N8hKhOvvbTHorak2PuAJVE3fMhruLams1SBfgJy86543/pzcTEy3F4h7ujA4EyH3gKvz
	 YoP2rYfmrSJ/mDhfGqTJYli0zhFuPjrADEFK2nMjpQAJV+FKMS7XCsktHjbvcoEqSzl8U
	 kgbhB2aaeOelEZX8KvbjnBWUqo0hcKnPhdE2sZAY1sjz76aQTPAt9dkAMXd/BsaSFgySg
	 uUgwPKZ8OSHmeJzupsps9iVvWrKdkWv6UElHGtYeJk7c7jigkKhoraOqerZB4iKI40r9/
	 B7RVu9BMq2QcQKJFmWgBsOOmmqddMa8Otjir8z52ezsyG/ExArsF8J4s1PVnz8Gq6MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792811450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vQ5V0JdVK/DourOvShwq0GjzUxcMzKpKOWRqkoWmqEE=;
	b=YVhIJsxe2YLbXOm0DFR3GoPXsC8wFSNqGoHgL36OiVMuCa3E6F85Q9RzcKpqI8hxd0fL
	 yOago/gHMExJfhPaoboWBvI8d18YOfd6zPXDuWQ2aFXPfYlQwkmi/RHrZ2Jms02+bbYUh
	 aUNyRelTI3RSwywYAXgZ7SqPk7hHJ+FzPRI/mcXgbEBvoMPo5D/mY8chdhRxUjKjekM+z
	 uwet3ErLke9pmHfWb+huf9nHSy+swx3KFKbSNNk0SeeqRfphzT544/o39WrX+FVqUyj/Q
	 4Uq4oVCaDuPZAQLly+9eYIPyM6ddPqhKnvCHIEByo0DkFyh3ok0G1DrUeSUJ9KnhBTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i3q2h7Ks;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5A606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 03:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EC5A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i3q2h7Ks
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso862399a91.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792811450; x=1793416250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vQ5V0JdVK/DourOvShwq0GjzUxcMzKpKOWRqkoWmqEE=;
        b=i3q2h7KsXMgjqiuWR6nfLazSNTs8SSCi9UlLgrcwcXy9nYxMVkAEjF7UmFl3Ka4fop
         ZTHqGXNFqP9qjKNdbPpZmTeiIBqtHMU/PtJ2nOC6lpdWdKJhl8vhVfyOwwIlGm0wDsvM
         iNqbuzY4OVimr8gVUpGOCaldFfxJ4IU/Wa0jWyHz7FC3i1K+RYWXxdFDlz6Vwlmg134z
         blhe0nrTih4UnsXvu62vgu7pGGXs2vBZbC2UV+/+fARPQ2nG6Qf0X5//i+MX/RVGSiX4
         aT2tYo5sl3JvANVlrcFwqPMcdFuMCXD5zRgN/oGcypmlftjXGX+tHWUzjJcEULGNHcay
         2LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792811450; x=1793416250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQ5V0JdVK/DourOvShwq0GjzUxcMzKpKOWRqkoWmqEE=;
        b=fck8OSZrq8ceb4JpAetBuU5h5dYBwgrgPfL4x478HjuriK1FPmbeqVzsZWDPNNSn0J
         jMktMx4rYwz9qo88v0/NUMyboel9xzOe58XUpLviV3tyV2C7zjRfUUM/0t9COphgDrqY
         JpkfiHmhxb2eJcl/8x80GZ+Fvpv2Bmmx7NEmBVGN9D03Zz31zwpfSvzP5ajpB4A0vXUn
         mLbXdd4EmBmovCIMkVrpQxTMmI1035kMdgYrrMGbOIu3F3NtxN9bZZFVUtFDrFvyHI4a
         gG53++r+T67RaPURtOlXYqMto8rpDWSHNMcpOs2qoZfRdCxGgi6xuLpUQU0WEzYztJv0
         b3gQ==
X-Gm-Message-State: AFq9FYKNTb3Jh34UUQokgZBNr4il0c7fKUlRfumlMA9hhra7X/kjKzsq
	PEo64qO+ULvWC+98fmfraCoRmT1omr6i/uxAUh2+ym9eObKZN0tpw5Tbw2p1Zg==
X-Gm-Gg: AYBFou1CRi4b+vnu4YvU61Zac+/TuzX1bJklXkpET0B3v2eh8uZ0XwTshfX14Q30kY2
	QYzrCc5QXkGdMo0By5X9P6pqhRChkGTXs+36RtsA+P5ssHsUY/D/Ho/nNg6gS7gbfPEWCaSIo1X
	OJfFdq9bmhr/PlOXfh53RxhbPHVhGQ98g2wldHdR1FlL1VeW73tPtOAByrKSSXb6w4HKCNu5zPs
	ITSjUSnk/bMYpqD2xtjSEF8QoA/JwwJ5COGp6eA69kTKatQVE2OLOgeqgCqNmbUc5AzDvTjY4AN
	t3kms9C7UaLrX3KeIAuscdZudxOA3ncP/0cBNH+0OJzLcNlBtMw+N/cMHYb4PN9GuJHcx9dkuN9
	OvSZ7yQi04205lZ6AJPdWe2XB1aBFp2XtV0CKx3VkNS94bL72mEbE6gT55OWJMcI2hYdOj41H1F
	OkwqUkAQgHDXwTWX2KCGqzbU+7vnvo9I7FvqSRdC2RkbU1LrpgQDGzTiDGTxoOqniZzrykEulyM
	mtFaMT4NgBi/mMfFRLaYrfDqLdirheRhFMv6ZeXGpFEj9hEUISnRZVS+vgajTylWnPPSIurBDOM
	/rpLCpBsm6rmublXTFYTpn3dyPrEEnpZHvrSi7ltEhmpecGUXY/KJ7Mh/rmxuwqirX1DXEXA+qp
	ikqTxz+lk/x9cJGpX/TdjXavC
X-Received: by 2002:a17:90b:3d8e:b0:3ac:80dc:f40c with SMTP id 98e67ed59e1d1-3adea8985fdmr921983a91.14.1792811449591;
        Fri, 23 Oct 2026 20:10:49 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba38910sm781374a91.1.2026.10.23.20.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:10:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf] bpf: Don't hold pack_mutex over arm64 IPIs
Date: Sat, 24 Oct 2026 03:10:46 +0000
Message-ID: <20261024031046.625578-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

bpf_prog_pack_free() calls bpf_arch_text_invalidate() with pack_mutex
held. On arm64 it interrupts all other CPUs and waits for them:

  bpf_prog_free_deferred
    bpf_jit_free
      bpf_prog_pack_free
        bpf_arch_text_invalidate
          aarch64_insn_set
            flush_icache_range
              kick_all_cpus_sync

When many progs are freed at once, every prog load waits in
bpf_prog_pack_alloc() for all of these broadcasts. On arm64 hosts with
many CPUs we saw hung task reports with sk_attach_filter() blocked on
pack_mutex for minutes.

The bits of the range are still set in the bitmap during the
invalidation, so nobody can allocate it and the pack cannot be freed.
Drop pack_mutex around bpf_arch_text_invalidate() and take it again to
clear the bits.

Do it on arm64 only. x86, riscv, powerpc and loongarch take text_mutex in
bpf_arch_text_invalidate(). The frees would wait there instead, and the
load would wait for them in bpf_arch_text_copy().

Tested in arm64 KVM guests with 16 and 96 cpus on a 96 cpu host. cpus/2
processes attach a cBPF filter to 256 sockets and close them in a loop
for 20 sec. One more process attaches a filter every msec. Median of
5 runs.

The loops get more done. Sockets attached and closed in 20 sec, in
millions (higher is better):

             before  after
  16 cpus       1.6    4.7
  96 cpus      0.38    4.2

setsockopt(SO_ATTACH_FILTER) of the process that attaches every msec
takes less time, in msec (lower is better):

                16 cpus          96 cpus
             before  after    before  after
  avg          0.97   0.18        11   0.54
  p99            20    2.8       421    4.0
  max           204     90      1738    255

Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3030beb531d9..0fef87cfa152 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1069,8 +1069,17 @@ void bpf_prog_pack_free(void *ptr, u32 size)
 	nbits = BPF_PROG_SIZE_TO_NBITS(size);
 	pos = ((unsigned long)ptr - (unsigned long)pack->ptr) >> BPF_PROG_CHUNK_SHIFT;
 
+	/*
+	 * arm64 sends IPI to all CPUs in bpf_arch_text_invalidate().
+	 * Don't hold pack_mutex across it. The bits are still set,
+	 * so the range cannot be reused and the pack cannot be freed.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64))
+		mutex_unlock(&pack_mutex);
 	WARN_ONCE(bpf_arch_text_invalidate(ptr, size),
 		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
+	if (IS_ENABLED(CONFIG_ARM64))
+		mutex_lock(&pack_mutex);
 
 	bitmap_clear(pack->bitmap, pos, nbits);
 

base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
-- 
2.55.0

