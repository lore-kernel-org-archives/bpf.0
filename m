Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440673;
	b=InoADl1y1F/wQy4nBNaO0jm4Z+xoo8KW30dFv/HEq5C3Mc0ZOpc2OZ1L20Wvr9HJAqoT
	 fRyPq1h1Ioy3uSh3zgMFXjsmBANYvQfIcHFj7+3XkFxQLE+RTFwR/zpv2pYV0hvkQcw1b
	 t0/kW7onnY3BwZUXKOp5u/FIzhSXv1S/BJdVtsJ2ffe4LfHXBVRVGfMAMg1nPBQKve2iQ
	 oKnMWewDH2DnNBKbTTvxiIcdk1YbpXb6jxeuQEuQwiWDexTQbreJ8xGRuYwx841Ba9X61
	 WsmdxC8xgsopHHWN9CkkyTNDertGG4qfQ/rEmaZCcXAjvDyu+UGgrBOwryoa3ZxNgNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gOK8sZ0DiOEL3CePk4GSHDXsosMeaQXN6LZjB328OjE=;
	b=rBwDjZZXhfDCLQIPOfZwGnfLEbHnq7WzZu7cLyyHVa6OtRp6U8e8pD5E8DJzqMVac/BB
	 xXh1Iwjo5Q+4sseZm9XyjALItibo8vD3rIV0tmS3FMBMK+KdUCKzmWhTxtT/NloMTqM+2
	 J2Pn74VZ6Jg+f9HnDzHAKfWp5CXL+zh8v2dFOrh7zWUwU4a/eLu29UKGpV3hjufiQrsYw
	 ErCI80W042z5d0G41ANKbfuEkOs6KWuxcbyla7oW/qm/q7ebwayD9c5UNXvEB933shZ+b
	 Vj+E4AOiBAg5P+3ENoQJ9xB9gL9IT27wWmtqMPqTB/+78fOyfcAiyPAWDDg/D1/W4kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SMgiEGak;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B3606A327
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 20:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 220B3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SMgiEGak
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e7e742a2c7so362085ad.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792440672; x=1793045472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gOK8sZ0DiOEL3CePk4GSHDXsosMeaQXN6LZjB328OjE=;
        b=SMgiEGakbvkjM6ZZFTbRmVaUvTon7wSCXYtqo8SsMx9ylrmM0EfFYoO6z1y8lHbzNH
         C6Yj7OHR00GL/oB04M62KHO+sYMZD48cmlp/Jnv+Qb/D9AxpLExaaoRLuL87p0lHpyu0
         BYIwpVm5xnWb7CikhpMf9NSGkkv8BLJOSKzTIUzKGmiAM1nqrEizaFqtGnXFp529CXBe
         fNnyApt2Hv2dhtgmMEy7nrDt7v5RVD9irstDxPrXTFYvEEJWifI1GdTcmfj6dKxeqpFs
         CW5Aw8p8nk9eZTlyBds6oC9P/UosFL+i0zmwgkZh3NMS3Z0U7SNfdDDc4GdKgIrvZXhE
         elhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440672; x=1793045472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gOK8sZ0DiOEL3CePk4GSHDXsosMeaQXN6LZjB328OjE=;
        b=ixZSn4ipQlagNfxSBpbhezqks/Ix3w+td8rhbTBhKw40LdL2ABptFxsILSI8J/99PL
         efu5i/P7MdeIAqYpWmAyRERREnLmQVE1n3V6ZxZfnCaRJ3vd6w8x7pQ2jg+bXd0w8u1F
         60AVSE3PyG1WG5Z7DpeOjKx/Yg4+r45TEvfmkLTnpbcBunuKIxQkkr1X4qghXhWxTMZt
         V5qshRdimqNsLyVxkVsw701CHBuHRCoqKj5TgT6t2pX5LEXt4Pto044Vve3La4yb9xMo
         CVPHPucdps6wlbgnM/ERFYW4AknTXbe2U8T753Gi6eNrWDQ0RilV/kXUN2HV15LU2R6/
         yQ5g==
X-Gm-Message-State: AFq9FYJPdVzpcbzljNAwbM9cdACSEuUdl42wZJg6CdrWQSwxeKZuZIlK
	+ulS1+ntX+GvWjLvM/pHuMjDs3fyD3VJF9bEMMoyF8t1qqVxYNv0VI9P2tuEqJm6TR4ggHNZ4tR
	shhqiQIg=
X-Gm-Gg: AYBFou2zHxDPHCL6cA1vtJWj5W/jvSQoRztX/Scy+Dq3iSrDVf1uqtcxfS2oHXgC2jn
	/l+LCBBYQLBEb5A0GmG2LlR1Kgaca6daK1gK/11PoBnqz8ZFhdpBCBajNS5Bj/UIpyCGJ0xDcmF
	BWElUqnqodjrlC/JEtQzvbrg2yvjoctKziuqh5ZJsYihYgDe6GLpRNXg5bvfjyMz/aQB/Fmo/yQ
	j0uCOQFLGQfuSUO7H7YeQDMCVHXK8uHL59a6Bjoef3bRQTd0vjPYuz/E4HOWUOKVge08+Oy/3NB
	Q2Yh+y1vKKzNMMJjLafrHMPj8ZuczhdYtYC0c/1wVj3xc5qBuq912+8jq4hFadVGGwZpnljce/n
	ZVrMiZTEU0MtIojlEGWGnwX46Ppy3sDo/409rKkJGfnE6usb9tn6IQM+Vd7B3oQWmxMYhaODURS
	90eAqkuP1IjuXdZzlXFR9NbsOBwDT9G1n3pLU1AfVzbZ8h2hGHtomPi6+RGJW5MQvRRgphx52If
	7/MUlr48y8iVeJKwqZGAY1Bs02BPkHsG7KYPRnsaDOE4mELw3RR9LnVLilXyb0jKjDTBCJ4wWHt
	pbQtmZcLc+xDZPnHtQ==
X-Received: by 2002:a17:902:7b89:b0:2e9:6333:fba8 with SMTP id d9443c01a7336-2ea1d7195e7mr849205ad.16.1792440672357;
        Mon, 19 Oct 2026 13:11:12 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151818f0sm5102585ad.65.2026.10.19.13.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:11:11 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 1/3] bpf: Revalidate faulted arena pages before installing user mappings
Date: Mon, 19 Oct 2026 20:11:06 +0000
Message-ID: <20261019201108.4552-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019201108.4552-1-emil@etsalapatis.com>
References: <20261019201108.4552-1-emil@etsalapatis.com>
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

A user fault on an arena pins the page that the kernel arena maps,
drops the arena spinlock and returns the page to the core fault code,
which then locks the folio and installs the user PTE. A concurrent
free can clear the kernel mapping in that window. The page reference
prevents a use-after-free, but the fault can still install a user PTE
for a page the arena has already released. User space and BPF programs
then see different memory at the same arena offset.

Close the window from the fault side. Lock the page, recheck that the
kernel mapping still points to it, and return it with VM_FAULT_LOCKED so
that it stays locked until the core fault code has installed the user
PTE. If a free removed the page, drop it and return VM_FAULT_NOPAGE so
that the fault starts over. Return VM_FAULT_HWPOISON for a poisoned
page.

This change alone does not close the race, because the free path does
not yet wait for the page lock. The following change makes frees wait
for in-flight faults before zapping user mappings.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0ff707707da0..5e0e0837980b 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -584,8 +584,22 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (new_page)
 		free_pages_nolock(new_page, 0);
-	vmf->page = page;
-	return 0;
+
+	/*
+	 * A free clears the kernel pte and then takes the page lock before it
+	 * zaps user vma-s. Either it waits for this fault and zaps its pte, or
+	 * the page is gone from here.
+	 */
+	lock_page(page);
+	if (vmalloc_to_page((void *)kaddr) == page && !PageHWPoison(page)) {
+		vmf->page = page;
+		return VM_FAULT_LOCKED;
+	}
+	/* The page was freed meanwhile. Let the fault start over. */
+	fault_ret = PageHWPoison(page) ? VM_FAULT_HWPOISON : VM_FAULT_NOPAGE;
+	unlock_page(page);
+	put_page(page);
+	return fault_ret;
 
 out_err_locked_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
-- 
2.52.0

