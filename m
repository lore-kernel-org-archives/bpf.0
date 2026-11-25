Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577507;
	b=blKKkE3oBKxZBZHsUMwyb2t1qNYDTNqF417kgNCF3rAlWQ7/4vWsz0JBDn0VUtGK4luH
	 jmdrJbV66+ndpzgrL5EsKLAQ+U2DJDcpTrBeLX5ZEwRhjUpBPATx4kb9dh23+9/YLVU6Z
	 CGvA8QsewsFNqTfX+3sC/ydC7FVtABSbjus0nHRp3lwPKm6mcgbMwBRURY17G+MyEJ7sY
	 CwL1peDFqdYGh5cAAo30lOsYxrvLHVBT6DXW+07jDzg3y7O/1DPgIa61NMuDnvLu2RuWs
	 LXuBgXkiHoHRN6kteZW9kiBELf2orXMbOUBfQGRGArqKgPT3EUsNSUSk5RejRBQVVwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l8qI1jXwsN4AXhqRf4PiSROzIloaFxaGaMLEBk0fB6g=;
	b=MW2JBTgYSAaW62A9Gp+90C89sYarfmN9fCKxPdY7WLgkk27/vpRWKInEWk0l0A+8niza
	 4628K0XK5MVJm/4qWJd7ygz/FK8d/DNFVgKuKJxVzY3rZZeTP2wRGQyOStUcnWK4VBBd/
	 2HVo2gWKVIHEYi4UXXZ+fT13dJkVh5WLYpGJXbLxPESg596LlPdgd/FRE7XIZ1TeOet9h
	 FgWMdAe+vGKeLXn5/qNA012+rEjoj2Tj7KogKK/qHSnpKAqSpbVJnuiILZSRA8H9KRKzP
	 vY4XzRQ4IEHqEkgT6oFDYZhyDJpNxEFuJz84qRZRcGdJhHQSOowxUkEEupFIjpEwK9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PF+OOlkL;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB01606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB01606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PF+OOlkL
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cddac941ed1so2255870a12.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577506; x=1796182306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l8qI1jXwsN4AXhqRf4PiSROzIloaFxaGaMLEBk0fB6g=;
        b=PF+OOlkLNjW4ntJO1oUI5QexMQfeOkcI7dMdJ97/ne4kDJFuODVOkEG8/+u3mDFnsa
         qU/i3lpsm9wn5cgNMoTg7AJ5SiqX4gB1kV3+0ohwPMVsEcXt4EwzTaoA53xXsQCGGdqK
         WSwBMIJMY+Nt5EhtwMUFPMelyX/3J0m3THBG4SeonMhZtwkatCb7Oa2wsEzxixhNC20c
         LKc8bVJTCVrh8ZMgBhiVgJ7DKjYi476LBBxf1Myk7G8wqemWjsRsSB4N6eYrgkTUS7PJ
         KD3Q+zXiPzjCueI2BmlOpi286kQ5r/FcgHihTTI5ngyqj9G0GfK6qjQFtDH5qtVx2EIk
         GRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577506; x=1796182306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l8qI1jXwsN4AXhqRf4PiSROzIloaFxaGaMLEBk0fB6g=;
        b=i7u6YW2vM5N2yiIDAcqQYweKc2fs/CNYJhdWnOzYsPysJQSfdHGSauFilL4F/nRbVZ
         F7KfwAcMpTaAb7dWZh0S2lnwSvs8ucpTCt52aY6QFNE+8Ytr463Cu694cGY+/+YEt+7W
         Uj8FHscL20Kt5FAQv4i/9NJiPBBi7iOJFaYeMBhw6ujLnEpo31D8SOo4Df91OsYO0NbH
         gO6nsXsenrhi20jMlOov6q0rdocawvdOx0Ryi4bWreb7ZViUcFGhRJdRfhRtxFBpelhV
         +Npu5EiPdOi1rTRaOZkbYmPLoqFB2ZE1ONAlfTb7BZK0ulp1G25zPBwrEXqIQsZyPKPf
         4DzQ==
X-Gm-Message-State: APuU4Z8SSftPo3YwBmAYmAxpSUTHU2wqR/Q2HoMQW62FxVgQ/OJtM0eh
	NDMvsbNE/yUE96dKd7H59eb+uUX/doUojiYJo5/KrTs34tscY5gVyJffYGXL7beO
X-Gm-Gg: AZFdTZed1PDt8KB3e7SyNX5+4vvFduz4pG8VW//eHkL90icQGMTjxeo9h3Ua3IwlvdK
	efMAvTPKeR12PvI20RquLAtnAxsLVD3tJTqVjpU7cJPW/FusoD6GNOHt+i7zttzFvCeP9xPvuvL
	ePEQnlc0U68mogoq4Q4bUmPn/bukHXsObS5HiC1/ymv7z/Ovwov2y6LOxtYs3xC66TiF8jTgG2j
	XV1xCtB5Euy8hUB7XoQP54t1yj7leuBD+ZZTPX5ol3eMHZKgCFQTnIMNYkgyPJvMnxnxVD2qCkK
	A9pdGSrmX265o+r48mHDdR2s/jx5fR8oEucxsWIv+NPtASDU4+Mm8lZAjZvqSULBUuubLrrbr/i
	v/1njd4kltnivnC9xw9wWbuOHxZ+Y2IKeZsIIFWkzF7Z7LQfhesaEzfubbqq2DXXc3kaHuZWyGs
	BOK46aIHu9Rrpt4Uvmde5uIrN9zqhCEHGFByzb1nqF7GyLCORop5KJjy2jEmPb6HGfmnVmWuuz0
	OLYhtEogkZffbGPnbXEhyM2id7vQEANIvA+EVEWyKcEFpR6bfGIvTYGcvyds2AIOxU6AgWzN6Zk
	firxifYnGco03YevzniQWmw9gKZNvQ2p2JIsSIPPdHbh8ZC6/4pjBgFDEzkxxy7KAmPZmK56gq5
	ohoWEcBpjqe0hncGf8bfYrKkVZ/rzDHfHfSkHwJHOlIN2glHdbo1RsNafbD9XVhV1O6WvznxATw
	==
X-Received: by 2002:a17:90b:4d10:b0:3b1:b66a:c05 with SMTP id 98e67ed59e1d1-3b41c8e0c5dmr14023226a91.14.1795577505792;
        Tue, 24 Nov 2026 19:31:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b2156c2sm10896461a91.0.2026.11.24.19.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:45 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 21/47] bpf: Refuse mmap() of a part of an arena
Date: Wed, 25 Nov 2026 03:29:12 +0000
Message-ID: <20261125032938.670542-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

The first mmap() sets the addresses of an arena that has no map_extra.
It can be shorter than max_entries, but all pages stay in the range
tree. An allocation without an address gets pages behind the end of the
mapping. They can be mapped behind the vmalloc area of the arena.

Require the length of the whole arena, as for an arena with map_extra.
libbpf and cilium/ebpf map all pages.

Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index ec2bda1a6ebf..2c6ddec747de 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -637,16 +637,13 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 		return -EINVAL;
 	if (len > (u64)map->max_entries * PAGE_SIZE)
 		return -E2BIG;
+	/* each page in the range tree needs an address */
+	if (len < (u64)map->max_entries * PAGE_SIZE)
+		return -EINVAL;
 
 	/* if user_vm_start was specified at arena creation time */
-	if (arena->user_vm_start) {
-		if (len > arena->user_vm_end - arena->user_vm_start)
-			return -E2BIG;
-		if (len != arena->user_vm_end - arena->user_vm_start)
-			return -EINVAL;
-		if (addr != arena->user_vm_start)
-			return -EINVAL;
-	}
+	if (arena->user_vm_start && addr != arena->user_vm_start)
+		return -EINVAL;
 
 	/*
 	 * Without MAP_FIXED the mm finds a free range. Ask for twice the
-- 
2.55.0

