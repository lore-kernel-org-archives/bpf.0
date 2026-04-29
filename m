Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D33F7A8C
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466154; cv=none; b=f92y8Np0Xpnj0wDVN/ozvHD9z68+ZzeD1tOfwGF7WTaZmDn/gbf5E814gcNJFG0wFge8E/VVTVlsHFzCVDoMbSqjAzNqqCBPqtmpD6dKXzkunRPmfE+WXrc6D4QmldQmfNLaQhyuJNtJ5qErFFommdv79iadi47a1dnuyFM35Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466154; c=relaxed/simple;
	bh=vqut0vK5KntPrajlpkM2HSqc9+hZY4ZQ0CEjyeDWeyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhoPE1vcM8KTI0FB/ekuN/Cn6TsQ12y8I9GBbp5X8ZId86h+oWe0H0Ai/idBDou7ajzLohynKwzWb1dOB68NxwEojdgAPfSWeDPHy8dgKoDM5RWfBYhgmiG/UNsgoFuNxq9/KZhYv7UfNS0aUVQFfR0+hYbylW5VZDnz9mDjXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzkVfNGW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzkVfNGW"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488d2079582so146359935e9.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466148; x=1778070948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZAFdTvgv7ZDBz5Q2Pc7VeLQwtxOy5o6AziVPA6ZPDE=;
        b=EzkVfNGWmv1lQp7qcqD1g2U85iBvrLpaZu5+Ic3JuufXrCd8ePU9Bzt2BI8K+YyY/q
         oW3CJP+VUD9kqquu5w7mYw7MHghCYy+ipYvzziCq0nfnBKYMKAYNM17BtxMJAsDvZXAk
         e/NuYfpToQXyI2zuqaU6TvFQCBJuSNahEQ7GI0yJF0Xhc99Rcz5VGp7Bt1H6/oMWIya2
         k0uuJR//duKK0uRwxWS2QNVXehkE5ab3u0KoUKqrkdRssClGwv3sD1f5xb99GSxnTXTw
         0Ns747bQ/VzzK7nmbKyG1d4aOQFK36RP2U3YKKUHt5WZmSeqtmo05AyzUAC/3iXV2Nry
         cwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466148; x=1778070948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZAFdTvgv7ZDBz5Q2Pc7VeLQwtxOy5o6AziVPA6ZPDE=;
        b=GuWkw1QmNPujPFWH98Cdici4FUa1W2xVv3xbCnJnk/tbcv3IdENKbHfxse4p9aAAY2
         CU7aGhI4Z3o2SDxFJ3HcSoIO/NQvsF/LzdOZZmFFyuxJiyeI2jshwVQDsfKNBYcjYasq
         /3ppMYfQ/1MV5Div7jfTtg5oaPAWT0BiacdQb/exkJiI+trDCmzA5ihO222bPkWxkOK8
         2O4opoywwuhFIwtCJ281uTjnvx2Htwc+LiiGu7k0liMoIoOe1ldvfiiUfW2CtslRs2F7
         r2h8xR0y5FvxBJi0Pn2BNpiap1LAxS5C+ITqyYpu4KV1gfVFwadsuhSLYR2OUtpHiwb6
         A6RQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5sADO0OsRAVc/6P6hBOyKOj9up7SLRL37knLC4Ku5ZlswQ3Tfv3MGaiTaJg9xhjF6GGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykN/VjQvRgQfWzy2JPu68iBKxcl45MtDbPwsJeLf6nV4LYLoUU
	eELDEk1nQ/eg4R9PUUrJntbfJz1teDOjLAe9WqtpYsaujQTuJnPjwwrk
X-Gm-Gg: AeBDiev+/s/UQ08sfw08BmJ/inyIe1E6/kGaWBxz8l5aP7YC7vYKOATCzwlT+duKin5
	UcIJCDQDVwsgxggbrylqle4tAka8pVzwFh5BoRTae+GCObojiNGWWVcRGd+uVksF0NsrVh3C5wy
	p8LoVZIes6/JTpCsmOEFAeUJMTPBjjTF+wNywmu5EIauSODn/Ez8eDpaSrmh/5w9tBh1lVeLzxM
	jC+M/+Sfz2YTL5gu2beyr7p7GZ0hLY/6D0LwmEc+FDcwIeub2H9HlteQ5l4IIrulgCUFik00Bbo
	LB1bX8eX6/TwQ7HENTM0eM+jnMNK4pYOylzftFqQlZ//JGkBXKe57GHQ9tGh75ekh7+7kgp3JjH
	gyFmPNLMutf6RBaPzlra2fvy2HRezbbzCmRpfDn08qs3QlnPkwytZdqpNFBbOFXKtG6Z8UU/AtO
	Qc7k6Sbf/Tix/XeYgZG2c/v77jS59LdAyQz91WOh5q9qPE1W94F6h/RHmKQBwcythN5GnvMWNUW
	bnX4w==
X-Received: by 2002:a05:600c:314d:b0:48a:58ae:992f with SMTP id 5b1f17b1804b1-48a7b531975mr56915905e9.16.1777466147586;
        Wed, 29 Apr 2026 05:35:47 -0700 (PDT)
Received: from localhost.localdomain ([2a05:6e02:1135:da10:ada7:48a3:13c3:5e89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc12bcbsm86942355e9.1.2026.04.29.05.35.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Apr 2026 05:35:47 -0700 (PDT)
From: Hasan Basbunar <basbunarhasan@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hasan Basbunar <basbunarhasan@gmail.com>
Subject: [PATCH v3] bpf: bpf_dbg: split pcap_next_pkt() validation/advance, fix off-by-one in cmd_select
Date: Wed, 29 Apr 2026 14:35:43 +0200
Message-ID: <20260429123543.61559-1-basbunarhasan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429084441.22089-1-basbunarhasan@gmail.com>
References: <20260429084441.22089-1-basbunarhasan@gmail.com>
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
packet 4, 'select 4' on packet 5, etc.

Simply changing the loop init to 'i = 1' (so it advances N-1 times)
fixes the user-visible symptom but leaves the final landed-on packet
unvalidated, and combined with pcap_next_pkt()'s '>=' boundary
checks, mis-handles the boundary cases on the last and just-past-the-
last packet. As pointed out by the Sashiko AI review on v1 and v2,
this surfaces in two ways:

  1. On a perfect pcap (no trailing bytes after the last packet),
     pcap_next_pkt()'s '>= pcap_map_size' rejects packets whose body
     ends exactly at the file boundary, so 'select N' on an N-packet
     file errors as "no packet #N available" even though the packet
     is fully in-bounds.

  2. On a truncated pcap (filehdr + a few stray bytes that happen to
     pass try_load_pcap()'s 'pcap_map_size > sizeof(filehdr)' guard
     but not enough to contain a full pkthdr), 'select 1' returns
     CMD_OK without ever validating the header, and a subsequent
     'step' or 'run' dereferences pcap_curr_pkt()->caplen past the
     mapped region.

Fix all three issues by splitting pcap_next_pkt() into a pure
validator (pcap_curr_pkt_valid()) and a validate-advance-validate
combinator. The boundary check now uses '>' instead of '>=', so a
packet whose body ends exactly at pcap_map_size is correctly accepted.
pcap_next_pkt() returns true only when both the current packet was
valid and, after advancing, the new cursor position is also valid.
This means the do-while in cmd_run() exits cleanly after the last
packet (no past-end dereference), and cmd_select() can call
pcap_curr_pkt_valid() after the loop to bounds-check the final
packet.

Reproduction (deterministic, no kernel needed): build bpf_dbg from
the unmodified tree, synthesize a pcap with N>=2 packets each with a
distinct payload byte, and drive 'select 1 / step 1 / quit'. Before
this fix, 'select 1' shows packet 2's payload. After this fix,
'select K' shows packet K for all K in 1..N, 'select N+1' correctly
errors with "no packet #N+1 available!", and 'select 1' on a pcap
truncated to filehdr + 1 byte also correctly errors.

Cloudflare's downstream mirror at github.com/cloudflare/bpftools
carries the same defect.

Fixes: fd981e3c321a ("filter: bpf_dbg: add minimal bpf debugger")
Signed-off-by: Hasan Basbunar <basbunarhasan@gmail.com>
---
Changes in v3:
 - Split pcap_next_pkt() into pcap_curr_pkt_valid() (pure validator)
   and pcap_next_pkt() (validate-current, advance, validate-new).
 - Boundary check now uses '>' instead of '>='; a packet whose body
   ends exactly at pcap_map_size is correctly accepted.
 - cmd_select() validates the final landed-on packet via
   pcap_curr_pkt_valid() instead of the dead
   `pcap_curr_pkt() == NULL` check.
 - Empirically verified in a clean Debian container (gcc -Wall -O0)
   against:
     * 5-packet pcap, select K for K in 1..6 (5 successes + 1 error
       on K=6, payload byte matches K per the file header docs);
     * 1-packet pcap, select 1 (succeeds), select 2 (errors);
     * truncated pcap (filehdr + 1 byte), select 1 errors cleanly
       without dereferencing past the mapped region;
     * `run` after `select 3` on a 5-packet pcap processes exactly
       3 packets and exits cleanly without past-end deref.
 - Addresses both review concerns raised by Sashiko AI on v1 and v2.
 - v1: https://lore.kernel.org/bpf/20260428100109.56572-1-basbunarhasan@gmail.com/
   v2: https://lore.kernel.org/bpf/20260429084441.22089-1-basbunarhasan@gmail.com/

 tools/bpf/bpf_dbg.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 4895602ab37d..db12d2f8fb73 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -918,21 +918,30 @@ static struct pcap_pkthdr *pcap_curr_pkt(void)
 	return (void *) pcap_ptr_va_curr;
 }
 
-static bool pcap_next_pkt(void)
+static bool pcap_curr_pkt_valid(void)
 {
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
+	return true;
+}
+
+static bool pcap_next_pkt(void)
+{
+	struct pcap_pkthdr *hdr;
 
+	if (!pcap_curr_pkt_valid())
+		return false;
+	hdr = pcap_curr_pkt();
 	pcap_ptr_va_curr += (sizeof(*hdr) + hdr->caplen);
-	return true;
+	return pcap_curr_pkt_valid();
 }
 
 static void pcap_reset_pkt(void)
@@ -1143,7 +1152,7 @@ static int cmd_select(char *num)
 
 	for (i = 1; i < which && (have_next = pcap_next_pkt()); i++)
 		/* noop */;
-	if (!have_next || pcap_curr_pkt() == NULL) {
+	if (!have_next || !pcap_curr_pkt_valid()) {
 		rl_printf("no packet #%u available!\n", which);
 		pcap_reset_pkt();
 		return CMD_ERR;
-- 
2.53.0

