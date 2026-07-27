Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A083C8731
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785122756; cv=none; b=NCYYjiw4rVBxNsklm7d2uHTU9XJtUzLjq5rQICAVh5+UOumvy/inRKZftgf3qLqJw/xO0hL35zNuABmhOEh9dq6hQuz4DH3XkFd0aUTf0g03wIxnY1afQ+zaROVjb1/x9PXRCCMOV+iLZzy2bY1RH80fVD2CbKbxj36utR53Rb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785122756; c=relaxed/simple;
	bh=MPDUBHmrsK5CqLwJbtdTujDqRD70V/z80Xp8Cr3TNuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y70RzHD22Va9irJ6HixmFEmhLZ1/yHYF2u2tQ6gfBCAF/b2RijPhJoYokY4+biSMY/15D/8tPxxj7eQ77o8C8PWK34X5MurFEilAziBqrwk05+gS8vI+w8MeFXV4J6Tk6u5kBANhU+rff7V/YGMtoEvmOXv+1qfEEppVG47nWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ9bzUqh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ9bzUqh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1153380a91.3
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 20:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785122754; x=1785727554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=prhrkfHxUEFBjG3lwEyuk8IShrOIe6y6zVk8J7/Oc6g=;
        b=lJ9bzUqhRqh6OCpfzrphigIlQgKEnHD8iKY4W2VDDVZVxPQoSKJtYNmEyFD879iTEE
         QWfhi0eL9Qf7ybn6NtKUgljhTnbZ1hpmyMkPPjyZ8NpN9S0BjN0OlNk5ejmMmJVIZJ1d
         FQXA2JpV6DtXWzUBTm9lBjCc5y6fH+otg7VIyHQPPfxy8L7Px5i1FUDPT3/CJpKcVx58
         sUqWfyWFDS/7wIT60kYnQ+bq+fHzRqhRbh/70aAEPx2t8GmU3Q/peH4ZCytuFKOrytnV
         psSB/cKlE85rQLi7MO2UzCzhmYBsYMbTbAknj1tQisCl8w+XFjZmgWdiCCVkyllCDMfJ
         rkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785122754; x=1785727554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=prhrkfHxUEFBjG3lwEyuk8IShrOIe6y6zVk8J7/Oc6g=;
        b=jabWKXOSgsaD/xX80w/lwGpLIx086GVV2C86iIx8ax7CChmM3hLALvjGibJHSU55a7
         QODsjDpQ/P7Ti7FF+OKwwVVO69kYVPacKG+UBxuFrQqY41dCKwQhPaCpiQHHp+AP7BZY
         hTTISqgModHtzbnGBCDMPEB0ChtUHVJxpCZjMZoDRroCU8SjcrnY6bT+TVvCFyyQaIX0
         X2FJ7LI/J6l5ZebGPK3qXmYZH9CvF15nljWabxMDPVFRaSB5IJI3oqpkxWH6Y+U0mV6C
         2Vx7oTDkX6cV8MnOKMLPesjjCuODbnkM+02VGfKudZh2K2pkKQ5Kfy1P93nGF7C/i1oS
         tdAA==
X-Gm-Message-State: AOJu0YwUGufPEKgIykcLIGeWXUHMamUQtJhU110MBJzxAjboz1nb5tEF
	7DRYYBzP0DpPaMlHonMikFGnDNBA2y563hinrBIVBEW4PImg9Vh1rM4d
X-Gm-Gg: AR+sD13vZ9o3CRU0WontFNzzFLnn7kBmRhlqQoFn7ecmTv5rHRN7v7WMwRO6y1VTra1
	rQPIB7YkkageL7CRjJ8ooqlw0CPVzz9iQNKwrS2ZFa8cWi8qpee96Y8JeU8Ek5AlGTxt0iwSdzl
	4JMoRLI/nBKKa0NRgO3goGdE4who+sUI+4vqXYbffk96MUB0pIkpi5jBzZqj6Rg3HfM6j68draD
	I1u2Xpx/O0+hmhF8QgPVhuj2Y9xlZqnkF+0AHsxAUCrB4dl8h4rKa8UMNJIiUFHZuoidIIqhrmB
	+micx/2NHkyJ5RX0r+WyGoi45R/L5LKoeHzBWR9aeeR3qyWuxxb5q19itJOes3NDyaqrx3Gl8cd
	yM+TI+D77r76ZgY0maGIBbqYdqvgOg8xoTrr3BOuYjExST01MXPH5yr6iDJE+Fnwh7262tMwHbH
	Fv+1LlXXlCXjjlmYI3qpujL4Jvw1Ml2biul8RXSeXHdQF0QeGHY6xNHW2KDwDt8A==
X-Received: by 2002:a17:90b:57e3:b0:38e:9279:468c with SMTP id 98e67ed59e1d1-38f296091e5mr6394009a91.25.1785122754499;
        Sun, 26 Jul 2026 20:25:54 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2951f0afsm2381571a91.16.2026.07.26.20.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 20:25:54 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sun.jian.kdev@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	lorenzo@kernel.org,
	toke@redhat.com,
	maciej.fijalkowski@intel.com,
	matt@readmodwrite.com
Subject: [PATCH net 1/2] net: fix skb length accounting after generic XDP frag adjustment
Date: Sun, 26 Jul 2026 20:25:34 -0700
Message-ID: <20260727032535.13469-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
xdp_frags_size back to skb->data_len but leaves skb->len containing the
old fragment contribution.

After a fragment shrink, this makes skb_headlen() larger than the actual
linear area. In the reproduced UDP receive path, __skb_datagram_iter()
copied 1024 bytes past the actual linear tail to userspace, starting at
struct skb_shared_info. The copied bytes included the affected skb's
nr_frags, xdp_frags_size and a kernel pointer from
skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
amount and truncated at the end.

Subtract the old data_len before replacing it and add the new data_len
afterwards, keeping skb->len and skb->data_len synchronized.

A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
1024 bytes from its fragment area. Before the fix, all 10 runs produced
corrupted payloads. After the fix, all 10 runs matched the expected
payload exactly.

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.org
Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5dab09e..94204702cb02 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5517,12 +5517,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	}
 
 	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
-	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
+	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
 	 */
+	skb->len -= skb->data_len;
 	if (xdp_buff_has_frags(xdp))
 		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
 	else
 		skb->data_len = 0;
+	skb->len += skb->data_len;
 
 	/* check if XDP changed eth hdr such SKB needs update */
 	eth = (struct ethhdr *)xdp->data;
-- 
2.43.0

