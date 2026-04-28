Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FEB3E1CE8
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370478; cv=none; b=Xz4e3G0tHNlJiDmftJhDRlc4zRTVYoh7zb+Z3s8zGjXW1feZcxfez3ulZFZTM9Ev0U/+xXagzYZZeuOGcU0B8z1af17gol4LjMLLxMGLrqT/MoCE6wbT1mAT+5sAtxYymkz8DEVPqeSY2KF0UmXEbPAnwHfyWdKo9D60c0bKIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370478; c=relaxed/simple;
	bh=i4hv0UeHtyM3DqopjiwGr9bnDPgnmIRVxPnkNr8GmIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GAkEYzBbp3mtYaXxwyvlbihFAFQl6RqsZbSqM3XByS7yALqQrH4UP3a5XjFbQntLbFZhiOFmlObYnzb/ENgACocPd5Gs9nbsr4c39VwXR4AqY1tBJTWOCjz6CVTYZazQ9U7wwb3QaH6zDjSzaAzlZGFvTMwcQiyYn+avaDDPf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjO5jUXI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjO5jUXI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso56532155e9.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777370476; x=1777975276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/50XZQ0iXHXF4hZ1uj3CWweX99HDYB10QdKh/6U0RUI=;
        b=GjO5jUXIg/Y7lxP9cXRfZyrBbDG74nZ/1XGZ3itjDNY2hwyGtIxPDhpSVlQV25U9aE
         MRJjaRxFzVx4wzY67wY6LobGHU4r0sg6WzO+oeIp7GjWopFLipLQBxw5qxCR5FfuMsYX
         xukpSGnIkqNKPd0+SvZdEk7qwvp3hKN2YrWGy2OmsYBWQccud9xKKK2EifcMYJby/QhH
         WalRfkFTLnKReicP233J11b+Otj8guCa8WP+18EQGy3TlWz+uPfOsjgF/sBG2sGS9REM
         VWg5Thz2hpvgbCt0pDavA+PpLRFUCTYkGvd5qVL9QbDIhqRapLg0ykxPlqoaaGra+w/2
         KdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777370476; x=1777975276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/50XZQ0iXHXF4hZ1uj3CWweX99HDYB10QdKh/6U0RUI=;
        b=XlbW9lIdn9vxFCJhIdaJBNh5rpE8BXnxBSVjg5i1z/zwRYHmNESVOR5xkJQc/MxuM7
         V3NcH6G8fxpDHZYj6vb4gsWizt7XMks0uJnhiMEwYu+4S4zcBgiBKu84tWTAvFE6EudB
         2M0AGBZnYvh+/HA19XOg1YKNSfYP9k8jKdqXM5B79wFWjUShwtPHcJkW024v4rG+erie
         TEEAzXRn17LCLVHG6CGxJMzb8KD+6tZp6RJQ7A+XWQ/eGjykWWsQO7/vrY6mmoo00eIr
         eoWm+SPL9hTT7u5jhu8oxhVxgXXbPMXZDqm8gVeChTZYir6D8jmmRdtIXQ5uMvRCz4da
         oMMg==
X-Forwarded-Encrypted: i=1; AFNElJ8oDpAYJV4xhsawgUoLa/Wm50rAawV2J1pFXz35C8yYOa2OKJdWmmf431ERpiWreW23hXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNtAEUxAqeHZGMylG/Ers702B+tQvthp1+LYTTH3pJIq2IP+Xq
	13w2Uhdi0hRwPk3LGX931CBCZL3wkydkXVCsgjf1yr9m1r09+YjfeWBx
X-Gm-Gg: AeBDieuvsqafsnyR9H7gi1lmCya37QL/zGIyc3r5q5cqgpybWwCrF8gee88LJ7ZNX3L
	YC++ZtwTtdVqnDNfFo4ZbxAdsiHN6HaTvov2yBC5hc7WKdb/MVD28ZAOD3JEVanmimErd2idqQd
	30vmSyotat0YNe130FYcq6GecrU3TQZaCsrpJNg9uU6TpneweEF8cAAFwCDNT8amzwViNcytmWN
	6lpZK67/pVabahUWVRcvn8nv5hXKyt8+SNvnoK9kw+ulbf8g4t1s3AHGyoJPPswfwrqOcvZVLnM
	08eCnO9se3xnz7txDYyIu6Lo27hDDrCCp+BIN+psD8kxv2EkSVjxm5QTisxa2knTd6MaDfj555x
	HvCl8M2sb/oXgZDMDlxkuv4hLwCvU18XfEa7e6Qwga0NlhdWmzl4nuWm27QOFGFGm2kJI7TuGR5
	Zz2DkkkpAvGRPYoXOS28upaSFvdowv3GAlqdOHKw4jzVzHEJz3CyrlPwN4t9vGeon4I46nXKkWz
	prB
X-Received: by 2002:a05:600c:a10a:b0:48a:5574:3a5d with SMTP id 5b1f17b1804b1-48a77aea542mr27777335e9.7.1777370475096;
        Tue, 28 Apr 2026 03:01:15 -0700 (PDT)
Received: from localhost.localdomain ([2a05:6e02:1135:da10:f045:eb7e:ea01:7d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773af544sm47395625e9.6.2026.04.28.03.01.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 03:01:14 -0700 (PDT)
From: Hasan Basbunar <basbunarhasan@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hasan Basbunar <basbunarhasan@gmail.com>
Subject: [PATCH] bpf: bpf_dbg: fix off-by-one in cmd_select and pcap_next_pkt
Date: Tue, 28 Apr 2026 12:01:09 +0200
Message-ID: <20260428100109.56572-1-basbunarhasan@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_dbg's interactive 'select <N>' command, documented in the file
header ("select 3 (run etc will start from the 3rd packet in the pcap)")
to use 1-based packet indexing, advances the pcap cursor one packet too
many. The loop in cmd_select():

	pcap_reset_pkt();         /* cursor on packet 1 */
	for (i = 0; i < which && (have_next = pcap_next_pkt()); i++)
		/* noop */;

calls pcap_next_pkt() N times to reach packet N, but pcap_next_pkt()
validates the packet at the cursor and then advances past it. After
N calls the cursor is on packet N+1, so 'select 3' positions on
packet 4, 'select 4' on packet 5, etc. To land on packet N the loop
must advance the cursor only N-1 times.

A second off-by-one in pcap_next_pkt() rejects the last packet of any
pcap whose mapped size equals the sum of its packets exactly (the
common case — pcap files have no trailer):

	if (pcap_ptr_va_curr + sizeof(*hdr) + hdr->caplen -
	    pcap_ptr_va_start >= pcap_map_size)
		return false;

When the current packet ends exactly at the mmap boundary, the
expression equals pcap_map_size and the >= check rejects a fully
in-bounds packet. The same off-by-one is present in the earlier
header-fits check on the same function. Both should compare with >.

Combined effect: 'select N' on a pcap of N packets always reports
"no packet #N available!". For a 1-packet pcap, 'select 1' reports
the only packet as unavailable.

Reproduction (deterministic, no kernel needed): build bpf_dbg from
the unmodified tree, synthesize a pcap with N>=1 packets each with a
distinct payload byte, and drive 'select K / step 1 / quit'. Before
this fix, 'select 1' shows packet 2's payload; 'select N' shows the
"no packet" error. After this fix, 'select K' shows packet K for
all K in 1..N, and 'select N+1' correctly errors.

Cloudflare's downstream mirror at github.com/cloudflare/bpftools
carries the same defect.

Fixes: fd981e3c321a ("filter: bpf_dbg: add minimal bpf debugger")
Signed-off-by: Hasan Basbunar <basbunarhasan@gmail.com>
---
 tools/bpf/bpf_dbg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 00e560a17baf..f21576dc2326 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -923,12 +923,12 @@ static bool pcap_next_pkt(void)
 	struct pcap_pkthdr *hdr = pcap_curr_pkt();
 
 	if (pcap_ptr_va_curr + sizeof(*hdr) -
-	    pcap_ptr_va_start >= pcap_map_size)
+	    pcap_ptr_va_start > pcap_map_size)
 		return false;
 	if (hdr->caplen == 0 || hdr->len == 0 || hdr->caplen > hdr->len)
 		return false;
 	if (pcap_ptr_va_curr + sizeof(*hdr) + hdr->caplen -
-	    pcap_ptr_va_start >= pcap_map_size)
+	    pcap_ptr_va_start > pcap_map_size)
 		return false;
 
 	pcap_ptr_va_curr += (sizeof(*hdr) + hdr->caplen);
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

