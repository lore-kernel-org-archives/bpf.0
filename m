Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8273B19D5
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452289; cv=none; b=Z3rBdLilUw4eAnxkoHswgjv+ZbI5MQBU/y7OAcR7MtTIRkvsRe9ubSWDBBqstVCtqjE9pj/+V9VdR9mngfVKoHpDhg9FJqSWa/Up/M9k3tqvsmZSyC4VizRHX+lPL/4iVy61ElAwhxxy2hdrUK5ucBYlglgHplmcqqATuzicQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452289; c=relaxed/simple;
	bh=vQw+J2n9l7JWwR4OLVZHYMsIy+4U//bbbR02TWAcAfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dglxQRXLmGOmPbPcitjzOHq9UU6eihMcqkDU6MuIGar2Kb4pmip0bWYqvq+okxuEeB1btiMoUX6p7jIG9KesT1zigBpY5tkVMDSoakgHDKV8AfOf159jp9nx/7PNkXCxUMNjXc+tBPHGin/44pvcEgu7A8j+hUodB/XdUWv4OfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T12NpqaN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T12NpqaN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so105472575e9.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777452286; x=1778057086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCydmE9F5QyshyzuRLKQXRbIggXPpAhdvWsPxiJRJes=;
        b=T12NpqaNrvkyXDLyR0M2Ho/Obq1BFxTRaEwX+4EafNZl7wXD49ZOZMWKuu/l1v4Fuy
         GEWldN5XY2z34CO0COH4zvz8KU0qv7OV9JltqGs1AWPdrLkTYoa3vvqxHl0oVO5nAzdr
         OizGsaIVXSWaS1cfbezL/sDgKBjh1Fi8ldAB23fZmNuuA7S7O0Giz93RGIgu20k0qTuB
         e/ID+nCX5dPCOHFpYaqlIs3h8YVepulewOYA1wWIrw8ErHOOci2gNtcVqrp9RPnoRW7/
         RPf/dCh0ECFthDGVd9P7WMbLob+PkcVavpdInW6giIyPaiXqmdgrF2iQCAbwiZcnbkMY
         Lmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777452286; x=1778057086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cCydmE9F5QyshyzuRLKQXRbIggXPpAhdvWsPxiJRJes=;
        b=Fw3mJiNRRgLyupTwGcMYZ4Yz0/e7+MoV9+WB3/vX5izIY3g9m57crBhfNxqw8GeK9Y
         aUO8g9tVl2+DKFiGhCg5COSMqgX2aOIkq/RIN0FCq95/RCFu1aeue2OQFsW/r+ozJAH2
         5G3aenxavf/Y0M5W21H5o72hPL8R5JBxa90mT9sIsaGG+9wNhfTzYdQvzJan8/YWcG2w
         tdoUDlS10pmW9DWxiIDNWEW8X576lk/0MXyVMvvrJ4r0mFIwiGA9u+AdeV9tZfIW/sl6
         uXwPHaSpOfja+nJY0te1LrLjtnbcYKZ9hrNcDD3sBu4ZjPXKkzda32AWYQHpVcPQyEaL
         CWmg==
X-Forwarded-Encrypted: i=1; AFNElJ8bHHImAyxlSEex0jDCD8E4C59iK+FA9h8reJPVNQUaHjH76S4iAuv0npRAdd3r8d1WSDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdoppl6y2xOeNVsoppgLK/8N8vYpbz/DhrMzCkAm0z5HKAM3RS
	mgipfIbha4ej6PehbAwt+WktMT+tRLK+OZqIZ2uZFeiTwgc38li/pH19
X-Gm-Gg: AeBDietX65vwN39L0vCHxa+ymcwRELyCK2pYslTT/teLjpz2TP5cw8x93sT3kzmx7Q8
	xJC/VWJFAqCi1SSTF8325aGTtealiBs9vJ+AXSwDAK0AjxbpuWA8Ub2EBOtE1spQHI2DM0Q3Okq
	obuR7LwgdqJKV5br7rwPhCawTr5/TlLKA9iVp2zT+gALY6g/4bi3hj4rm5BeEdJ1lnPp2Nsy7BP
	nucTSiV82XmS9FLuy4n1vXdqb4jhDkk4fhxGPHHCyG5n0fTvYtjlnj4OvZ/M2Q+Mz8F3hX+Sjbb
	JQ+hW5g0hEjtBb4RWfIlnvRfYlKtgCMJclwkD6y+8dgmCorPN4G4DbOMBvbpxpzlmBgNYLEjK+C
	DJtBctfRk32oY2b8oSevX5+18111Xw0xoWGGF5Op28y6pI5MP/qlOack5dpRT4UqsIfbAVE2nZk
	BhuBu/rnWnKg1f1eGOWNcxTIph4SPa/kQc9jixi9564OAeICcBV4jQX3hsRoMraydP+7OeuqRAC
	KR1v0AmrlxDK/Cx
X-Received: by 2002:a05:600c:4e47:b0:48a:5574:3a5d with SMTP id 5b1f17b1804b1-48a7b51afc3mr50781275e9.7.1777452285818;
        Wed, 29 Apr 2026 01:44:45 -0700 (PDT)
Received: from localhost.localdomain ([2a05:6e02:1135:da10:ada7:48a3:13c3:5e89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc1cbf3sm43925335e9.5.2026.04.29.01.44.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Apr 2026 01:44:45 -0700 (PDT)
From: Hasan Basbunar <basbunarhasan@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hasan Basbunar <basbunarhasan@gmail.com>
Subject: [PATCH v2] bpf: bpf_dbg: fix off-by-one in cmd_select
Date: Wed, 29 Apr 2026 10:44:41 +0200
Message-ID: <20260429084441.22089-1-basbunarhasan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428100109.56572-1-basbunarhasan@gmail.com>
References: <20260428100109.56572-1-basbunarhasan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_dbg's interactive 'select <N>' command, documented in the file
header ("select 3 (run etc will start from the 3rd packet in the
pcap)") to use 1-based packet indexing, advances the pcap cursor one
packet too many. The loop in cmd_select():

	pcap_reset_pkt();         /* cursor on packet 1 */
	for (i = 0; i < which && (have_next = pcap_next_pkt()); i++)
		/* noop */;

calls pcap_next_pkt() N times to reach packet N, but pcap_next_pkt()
validates the packet at the cursor and then advances past it. After
N calls the cursor is on packet N+1, so 'select 3' positions on
packet 4, 'select 4' on packet 5, etc. To land on packet N the loop
must advance the cursor only N-1 times.

Reproduction (deterministic, no kernel needed): build bpf_dbg from
the unmodified tree, synthesize a pcap with N>=2 packets each with
a distinct payload byte, and drive 'select 1 / step 1 / quit'.
Before this fix, 'select 1' shows packet 2's payload. After this
fix, 'select K' shows packet K for all K in 1..N, and 'select N+1'
correctly errors with "no packet #N+1 available!".

Cloudflare's downstream mirror at github.com/cloudflare/bpftools
carries the same defect.

Fixes: fd981e3c321a ("filter: bpf_dbg: add minimal bpf debugger")
Signed-off-by: Hasan Basbunar <basbunarhasan@gmail.com>
---
Changes in v2:
 - Drop the pcap_next_pkt() boundary change (>= -> >). As correctly
   pointed out by Sashiko AI on the v1 thread, that change was wrong:
   when the last packet body ends exactly at the mmap boundary (the
   common case for pcap files with no trailer), the relaxed check let
   pcap_next_pkt() advance the cursor to pcap_ptr_va_start +
   pcap_map_size and return true. The cmd_run() do/while loop then
   re-entered its body, called pcap_curr_pkt() at end-of-mmap, and
   bpf_run_all() dereferenced hdr->caplen / hdr->len out of bounds.
   The original >= comparison is correct: when the body ends at the
   boundary it returns false without advancing, and the loop exits
   cleanly. The cmd_select() 1-based fix below is sufficient and
   self-contained; pcap_next_pkt() is left untouched.
 - v1: https://lore.kernel.org/bpf/20260428100109.56572-1-basbunarhasan@gmail.com/

 tools/bpf/bpf_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 00e560a17baf..4895602ab37d 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -1141,7 +1141,7 @@ static int cmd_select(char *num)
 	pcap_reset_pkt();
 	bpf_reset();
 
-	for (i = 0; i < which && (have_next = pcap_next_pkt()); i++)
+	for (i = 1; i < which && (have_next = pcap_next_pkt()); i++)
 		/* noop */;
 	if (!have_next || pcap_curr_pkt() == NULL) {
 		rl_printf("no packet #%u available!\n", which);
-- 
2.53.0

