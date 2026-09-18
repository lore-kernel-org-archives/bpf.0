Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2F347BA7
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735517; cv=none; b=UPZ5X8jRViy2zkSU2IMK1nQ/F9+Bbg7BLnuS5EZ/IwXnXAJGn4FauT9AzQTpVZFR86pM94FpPS28Y1z5tzDxDpqvqs39JsrzKZAhPsCAIThinI5rFRItv1Au1Y5TqVOO92DR/jn86ANQLsOuKZ0TXBoWffCIqn05dB5KBmtrkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735517; c=relaxed/simple;
	bh=yl6pFmV/xEg1vNv9xDvMEwbWpUcLiqdUahh2XN+OByI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu0mL5fXqLzTbGriTx1WOL6kaRl9tVgtomH2d4OQ/5fgNCpxeutVvlf/53WjJ9X6ppTg9cW5S2G26jZuwcCwqotVlvfgXXI5ecn3yszdrKw0HOJZtUh1PkmQV3KT3tpGFTZDAGusM7xyTQ8UXq/5CWWK2RF0VGgABqNoF7Hr60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRqtCLNd; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRqtCLNd"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so4553685e9.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789735512; x=1790340312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yl6pFmV/xEg1vNv9xDvMEwbWpUcLiqdUahh2XN+OByI=;
        b=JRqtCLNdKKfwEu/qGs0CTJRD2J7MDGcriunQWQxeiOircXzvT7sc5PWHdfg7f0+U8X
         jBjx8sfSBVVzUH3W8MOxQlBdzSc+NsKbOy63x4WcxlifRFZlyPa/opFgPaBTfL9dUqCq
         kQkUL0+xullZrta1m3SJNS7g7cmw5YrMOqUVqNSlz+Ah/NzIrJpU+2Sm+KmGCw2TdKZp
         kfu8Oph8gYbvp0orJ41Kfv6P6XweVVI0tmJX/gfFkkT4YjEJSZ9rFvSUmaWZrHSXE2Lh
         eQSRke/5VXqZWRmSXpzwdUdj5webejbAHk8I6xwbTdhhN6PquSXccb9lpBT5hJ4u8VIc
         1Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789735512; x=1790340312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yl6pFmV/xEg1vNv9xDvMEwbWpUcLiqdUahh2XN+OByI=;
        b=L6cXbNaeBwF2+zEX+wRbdtjkFtJNGfRQ8Gb5BRzkISx11Wf8sgh9tAkjNVwJZDODA0
         QFcBk5iplK0aTwEgtTveY/9LE7DSsfpAhPhdniHHcpFuUJlbJJOB9qWhfJN6AedDo26g
         rk094sHuEQKRvbCgGdrTomYgRz+ymB7hyYldzav48thMTFbyq8qxSIHYUmpW8Wk2OaEu
         zhDUr/xYnJBzFRqaue2fpBZ3NzM1puN8REn+6bCkBHVEaUHbd0FSuXztM1h6DcBL4+F8
         G01XScxUxWRtihvaZVWPUCP3lJScuqEI88fKEy5Bw2fOknro98lC9m6ezuk4y/7ainTh
         py3g==
X-Gm-Message-State: AFuF++k/19PbWeKXI8QtrRDDJazmgiXFgnRY+j77YyHLPzV6EI1aylT0
	Bf/iBttu9QoTNURHerUjq6V6Je1NjtX8OpFvTGw8BoiJspEy+iIMGEeZ
X-Gm-Gg: AYBFou2D1rWHXAwC6KKVMqwxEBapZrgy5Q1iJ2qwJPxUnJFktWzilTjkEn22qvAbajc
	sEZBeThB6iWpicKlgcIP+i2XZAXlEbmnW8ooppEgOQ96Gt4qy6oTvt2gLrT2j+huR2HOQowP0PH
	exY6/Jz31dBGM2ssim9Z3K2PYPHruFIdXvyY5WKWUq/GdXhxLCAjuzKqN9Zn4DTHLCeohYruG1l
	7GH6ym8vNEfQDfVAymOEefGNweXeoHCa075gyP44ffYCZwGLv1Xb4OLUFb3OFJDaE89TRL8iNum
	2YFsoi6hgdKEasDEi3txvzdun93w7Eb1Qf8Ngd9OAr7+8lT9mCrrkdojjIoHHQUiat76rDaGU2o
	pJKNyqymI8K5J7y2tWtEAXtEdDjf7EGGcVrIDJfGzuIMYgaZd/PLLGG3ZY057ux3I32EiOxGvxc
	HAsL0QtSkx9rhVQyhgv+bhm4mrgqHUqiz79YLKDVxnwlIPVbNsuA4mduu1djBWSlqqEsLGM3nqm
	A4EYjAd9vn0X08=
X-Received: by 2002:a05:600c:34c7:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49fc5726cfcmr73044225e9.11.1789735512203;
        Fri, 18 Sep 2026 05:45:12 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7d8cee0sm48825095e9.15.2026.09.18.05.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:45:11 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	tasos.papagiannnis@gmail.com
Subject: Re: [PATCH bpf-next v8 3/5] bpf: Add user memory access kfuncs for mm_struct
Date: Fri, 18 Sep 2026 15:44:46 +0300
Message-ID: <20260918124446.462781-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918093017.AFF821F00893@smtp.kernel.org>
References: <20260918093017.AFF821F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: High]
> Can this result in a Use-After-Free during concurrent task exit?

> When a task exits, mmput() drops mm_users to 0 and calls __mmput(), which
> invokes exit_mmap(). exit_mmap() releases the mmap_write_lock and then calls
> free_pgtables() without holding any locks.

> If a BPF program passes a trusted mm_struct like task->mm to this kfunc, it
> eventually calls access_remote_vm(mm) without validating or incrementing
> mm_users (for example, by using mmget_not_zero()).

> Since access_remote_vm() acquires mmap_read_lock(), if this occurs after
> exit_mmap() has dropped the write lock but before it destroys the VMA tree,
> vma_lookup() will succeed. This means __get_user_pages() will walk page
> tables that are being concurrently freed locklessly by free_pgtables(),
> resulting in a Use-After-Free.

> Does this need to acquire a reference to mm_users before proceeding?

I don't believe that this can happen in the case of lsm.s/bprm_check_security,
where bprm owns the mm throughout the lifetime of that hook.

I also cannot find a case where we can have a trusted pointer to mm_struct
where mm_users can be 0. A candidate could be security_vm_enough_memory_mm(),
but this is not in sleepable_lsm_hooks.

On the other hand, this can change in the future if anyone marks a relevant
pointer as trusted-or-null, similarly to what I did in this series.

I will update both kfuncs to use mmget_not_zero()/mmput() just to be on the
safe side for future uses of these kfuncs.
