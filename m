Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502413;
	b=LWoeoNxhzy8qnYsSs6bNk0oAhJ8MTONhHHpE9u2Z5gttY2jqY94UARzNrdF4lYdDbtOw
	 A28ybNbL1lJlH3yvO3nhCJmL8SkzEuOMj21lKf1F8zhfxwyV7AZHaQlefT9MVyTgpP7YT
	 C7zvlybHu3hyA+ILVvvXtnH8LtvajwqJPlKjD5cjZ1nxC0OSjGae8Qows/rZqLEamE3+S
	 O22h5wWvBHyQu9yxhJhSpVFriYwI8jBXdWdfH5WTjNhfgMHcnPH8gLK/aH1jQVghP6D+5
	 FMdls+6TdyO6zd3kmd2n5kxZ2Mtbiw6A4TCRUZNeXWkrjfwCcP37ZVzS2iSEBG8dVEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=2WUIR8mDUdv7rihz7n76hpVnog9aJI7Q7U4gmI4uFK0=;
	b=SzUMCYdtOCfnrfnj2nXHlnRIMwDgg/Y9X2yYmhNtLvu6wa3/lqcz+PKt6YwoKPIreFwq
	 r86/rmYoCcrYiVqyFX//uvROGXPRnc7n3WZDtxprfQ1l2ZoGwUtG4UxIrmdtXZotWiqc1
	 D3BaJ/BykX/ZyjLl4ueUf+QLsikHHfrIstinIvFSuc3IHIqeor5PkZ86I4ulguMqLybQT
	 /x9vjsnBCyR4kALZ18vNu+aw0SQjDHYO27P238tWu+27Slwx+KHr43fAUBiiXsfQT+n0I
	 PN+5b8HquWjH2pOWe63b8pjKntPYPz7Vs/DwZFzAhA7UT3dL4o8wZPVFWD7vDo2yXHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EBJSS2w4;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710B8606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 710B8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EBJSS2w4
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f052ae3c86so21258625ad.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795502412; x=1796107212; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2WUIR8mDUdv7rihz7n76hpVnog9aJI7Q7U4gmI4uFK0=;
        b=EBJSS2w4yfcuHRmCPOEgAR+uK+x9eUQoToH/AdNgtgcczU+b3i/ApSfgwH3L52VGrT
         0k8Jn6MfaxfAGZnYQtwKsjz7Q7hLmXbMktxwsIRYpD8DkXiL50Qhj4zBgOr7ON4E22AM
         BF7ElyvdaK+276LZy4G2nMWIqjc/FJc7Uvk5Lg8tD0CZdg/dxrgs8QbVQzERCFSG1e28
         XdC1fKDaFM0KLB2Unohr9UVjqHWu2ZPKJ0vGFp1+k27Eow+cuUWIdCeGIuAllAcqNNMp
         LyOQJ9QtmzFLCbj4h4rJ02TgD4eK68JoDWXvsWl3M9Z9U5535c27XZ4UFl/m9r++YCu6
         hb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795502412; x=1796107212;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WUIR8mDUdv7rihz7n76hpVnog9aJI7Q7U4gmI4uFK0=;
        b=rQzcEpLatxYCmwCLYbk5q+sBTZ2hUxvdhIW0X16vWdGWLiWkvTsu/rrUil5Dq83Qtu
         5dSyHhJO7drzdDsB1hfbK4ARCB4UBeTWTHP1vCS1GN94xyjVro8Sg+R6cg7NZLumGAYJ
         8VkQMJVCUjIRXaP64TDTDFSYhTG7kWXREwduZOHeNDuYKlWn2ywiQIV99CvdLpVAk5V/
         BAih24/05j2PVWd2RuSQgghW8LNzcL/2XDgj9g+6RhAxuSiukVW04PFX104jZV4G/zCx
         9CD8PoAcL3k3OMBfZpzG197Bp4LcrvYk8wNPhvtgB2FMxyItybL8en7BChHAYTMTgc3a
         UHSA==
X-Forwarded-Encrypted: i=1; AL+hErGgVxEvGJioj+CGZkLldoL9Y9Aa9aagPiCi0dJN2XQRrspsrOTxOfW29wItVrJ8nXKM42g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+boCHoxjZ0r8WD2htTKh6YgWvy9G3pQ4BG/ODtHExmzgnRUy3M
	yP8DPwYpFf5jYAyVthPl0SfTdezawgDNjZwlbIXbUBbs4RLQmUDZk1Ig
X-Gm-Gg: AZFdTZd8e7FCfnCqfa/VacNuG0HdpPr078eK77PZGHbKVpUeseThzudRz6fO6X7rbxd
	mjv54J2tvIC37ihpQleqc+esvdFvxn5YjDJRilwksvrgWysMbEy9hMkYFK8npO3y+uMmKJh2gwd
	rD/uGNVV0IIUIOFCYiJcSI1eUPFfbi1CP3wmggIyWOMAGFuXC5Eds3zByqsN27LX9+JGIXJcAT+
	QxN/86Af5dc3vqDe8sHRTnQgIv29op14DZRFnRvgggoR3dEXqdvtT6UGzBb0AdrGfBlNxViBx4F
	zpjDQ2XSGzne3CrRmRybXCD18XNLXoj/R1gkGTe5rd2RlsFAvDzZfwW9Tvvu7+ChH5CwzaCkVyc
	8C/XKpeWsvANtxoUYb4gBNyPHWew/r0RoRTviNOVD3EC7BsiibXBf4TFojk1x0r8Dkcu9xaHsYe
	LzwxqFQK0cfqAa62WMM01C1kPwoszoa+tKDbhBNLH57/i3q+XcsbbztYCTiuErV2VS2iWIplih7
	tR2oWYZw7rP1AzOWhcySn3RRFfsJnTnSWYEzjDLq7Tr1GZwJQ8DxBsladZ2ZDzHrBWRrw5IaFgq
	F3CDeXMn2LWZpcqxXuEjofE7/9QVkxrOxx83UezrRBWmKHETZLHTq0Rn0c/kfxhPoWd/koIIcj1
	XoIstheD3pPey/IZToi9UTNk0o8ATcNO6kg==
X-Received: by 2002:a17:903:2f07:b0:2f0:a027:7226 with SMTP id d9443c01a7336-2f0a027731fmr45270745ad.57.1795502412418;
        Mon, 23 Nov 2026 22:40:12 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dc0ebsm62184785ad.33.2026.11.23.22.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 22:40:12 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 06:40:11 +0000
Message-Id: <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261124060357.11700-2-emil@etsalapatis.com>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 10:03 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> +	/* Only try the spinning allocation when preemption disables are tracked. */
> +	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && can_spin_in_alloc() &&
> +	    size <= KMALLOC_MAX_CACHE_SIZE && !(flags & ~nolock_flags))
> +		ptr = kmalloc(size, flags | GFP_NOWAIT | __GFP_NOMEMALLOC);

It works, but I after a bit of brainstorming the following
might be a better fix, since it will address the root cause:
Pls run it by Vlastimil, Harry, Sebastian.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2fef409..4368ab5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2536,6 +2536,24 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 	return NULL;
 }
 
+static DEFINE_WAIT_OVERRIDE_MAP(zone_nolock_map, LD_WAIT_CONFIG);
+
+/*
+ * zone->lock is always held with IRQs disabled. A caller that runs with IRQs
+ * enabled is not nested inside of it, so it can wait for the owner.
+ */
+static bool zone_lock_nolock(struct zone *zone, unsigned long *flags)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) || irqs_disabled() || in_nmi())
+		return spin_trylock_irqsave(&zone->lock, *flags);
+
+	/* The caller may hold a raw_spinlock_t. */
+	lock_map_acquire_try(&zone_nolock_map);
+	spin_lock_irqsave(&zone->lock, *flags);
+	lock_map_release(&zone_nolock_map);
+	return true;
+}
+
 /*
  * Obtain a specified number of elements from the buddy allocator, all under
  * a single hold of the lock, for efficiency.  Add them to the supplied list.
@@ -2550,7 +2568,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	int i;
 
 	if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
-		if (!spin_trylock_irqsave(&zone->lock, flags))
+		if (!zone_lock_nolock(zone, &flags))
 			return 0;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
@@ -3237,7 +3255,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 	do {
 		page = NULL;
 		if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
-			if (!spin_trylock_irqsave(&zone->lock, flags))
+			if (!zone_lock_nolock(zone, &flags))
 				return NULL;
 		} else {
 			spin_lock_irqsave(&zone->lock, flags);

pw-bot: cr
