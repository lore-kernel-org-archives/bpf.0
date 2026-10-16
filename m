Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF104ED181
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167288; cv=none; b=LFjsEehV4PI6/K2nfWtERPIRi72UZNPaGjzdtUhrtaELCDMYUUIQnU0WLX3Hi4L3f7dCtQPlHJ12+MwGSVNKDaGRmvnPY9BSROf2RgBvpWafwD4HouaHHzsv/2Qdr3HwWCXjhEMRY1rQWUwvPbvTJC67omlxo5iT+duR+0f+xlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167288; c=relaxed/simple;
	bh=gEHy834UvFZ5FTyNJPHtHywSI+FJzQgUIJqTNI8l25M=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=WBfw902T/AW36c9nxD2dC8IeQD7glpcDsXcPzMTJm4BkeaxRxJVkC6B2Q9pgaEocWJU7LXIHGJ4/0NHO9rhmfDi/6d0p3giv1B7M9qxnzmtAN0/I3+q2jBmqFs4LCLuFjGKWTUQjEN7kQ4AhxbsQR19iFx7Ssw8hqi/wWQgOqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e16BeeSE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e16BeeSE"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-88bda150550so68974b3a.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792167286; x=1792772086; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FqqjrcRtopgj4w6foGEIKIoT7EAlewpzNj52vuU1gDQ=;
        b=e16BeeSEENkDZ8Wksf7J6opYzhmeRVJV8//en8mNx2GX9lXubk1dezCIPwUI3w8fIx
         TRNwcIbE0SeBXwVAgV9A5KbS0WBnd7kWz1MHb6UraXJCsKexIe+Q0gmm9uA1nZ2sGLy+
         UYnD3o0rreEWO8Vjj0jGetR7RzQXNuTEPzAPmjudOPHzQ1+gI7/96/9FOefRkHA7F5Rh
         PV7bg7zW4p/hz8pmITtR+zE5VoDRxeqnxBSWHumAbH94gBC6/k9RAneReOXUrZnma9wC
         EZaSzt1EZj1cAL7ulMd9+8tBJdGnDCA/NBhTGoy2fJPU0ZAZNteKCFPyTN/2zioaxSyR
         ES5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792167286; x=1792772086;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FqqjrcRtopgj4w6foGEIKIoT7EAlewpzNj52vuU1gDQ=;
        b=iLaOKiryz1+/iYJVp1eCKfZ2fuELVSjLM/PTn2mSRAGdLpknF9NYZPnj6oO0hsntqO
         PUyb0n1iS+lc23ecmVxBlPZH6UkLvMbMWR4VozIL9b8SrGoe8QV4gV+W8kPRU+AdGLHe
         QscJoxkTgonxSa4BBbZesaIHcwpnN9CAJdWTbRqzqgEOoN2OnC4PRILLhzW2oY27migA
         TDBf06BvscuLgS3OGzK2WcAa5ZVanNHjpSkX+FzKvOI52bYvxixMJ/EFV+IffmFoXre4
         pOVfSI9LR7E8WuW5SPCa+i8Ja+zRyfhI5Dm/3A6fvgP88vFwKoRYWZB1nIN+rPMe/fDM
         VJEg==
X-Forwarded-Encrypted: i=1; AKwUvBzRp2TZiIqSc8YV9A4cqFQh9Vq9a6GLs+lWQz0sGzPHmqEclKqbvror73F7w6MXU4l7BZI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQfhElOgGV00jXec9zeSzv68ZP15Ze+MCbAuR4//vMTSZs+oNW
	7ZRYd/sY8K5bFrfka821sl4zeU930Culm9GofoX4N3Y7phgKls/Yq+Ur
X-Gm-Gg: AYBFou15sgn8uFkq6WO6YOe5vuz9+NmdFjfzO8FoxKerETZl62U7Y+nR7oIM6Cda3Pm
	5BCLdqyLArjxfyX1Y+x7YCr52nOeJfKVNZNLhqZyvD2YwdYZkhwv19P68AyzOq3X1ZcdfhXGtVX
	h7OS8MFZWgHB77q4paHj7vKaDCF2KO0F7rlMbmiOEHZJUiGVCO3pLBvXwPjwMlx50/wqso6xUw8
	nS178hybpDAZQF7p7k2m77L3wwlfmOJJVmyAaRiEkZRB1v1OWBwa985j34NST9F5E3fhGNM6sEn
	4OHoWx7N1UouTJ6ogwkTOu+Jmvw43ynqQV2G0FZokLC9SwuL+spXBVhDcCOEjVZfXt4ROeoDRFE
	TFHydYnAAAvrod+XUhv3EMJkMNfNOIWaGAxnrkDLQFXJp3c2vK+9iaUhqaFy5o8mdhGTjoQsXTj
	87njLoyNVLPvcviTebyxHLNnwu2LoT0Fy/lnIoRP5g9NLNasMA7A3Rzi/EDHTtUpY4pi21FiB/a
	rHrEUOjb7wnnMTwXcq5OhJAy60DO9ohFTE3UcEVnmLg87kH5yBgHe4LrQT1eLm/5++tGE6Zbnd0
	e2U=
X-Received: by 2002:a05:6a00:4215:b0:89d:a947:9d58 with SMTP id d2e1a72fcca58-8a04cb1942fmr34405b3a.25.1792167285668;
        Fri, 16 Oct 2026 09:14:45 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f54b3199dsm1415504b3a.3.2026.10.16.09.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 09:14:45 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 16:14:44 +0000
Message-Id: <DM6EA4NZEW6T.1QXD6YWB6J9JZ@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <memxor@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: Load ringbuf consumer_pos under the
 spinlock
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Igor Malovitsa" <igor.malovitsa@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261016003318.529860-2-igor.malovitsa@gmail.com>
References: <20261016003318.529860-1-igor.malovitsa@gmail.com> <20261016003318.529860-2-igor.malovitsa@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 12:33 AM Igor Malovitsa <igor.malovitsa@gmail.com> wrote:
> -	cons_pos = smp_load_acquire(&rb->consumer_pos);
> -
>  	if (raw_res_spin_lock_irqsave(&rb->spinlock, flags))
>  		return NULL;
>
> +	/* Under the lock, so at most one ring behind producer_pos. */
> +	cons_pos = smp_load_acquire(&rb->consumer_pos);
> +

libbpf writes consumer_pos after every record, so this load is
a cache miss most of the time.
Today it's done before the lock. With this patch all other producers
spin on the lock while this cpu waits for it. On 64-bit too.
So "Neither changes anything on 64-bit" in the cover letter is not correct.

imo it's not worth slowing down everyone for that.

pw-bot: cr
