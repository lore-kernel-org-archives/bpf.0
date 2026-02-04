Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA831B812
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196469; cv=none; b=I7Id/+1TzGeZ+7PGmrS+3cpKYWH2S+kHqC9vhRz19xPPGPMZxpP/v7QStEXFTvl6E5fDhvLlamon0Upc3tqWhnOWGKn0PaOTg1HHQ7tPntesyfOxvyT/1OwIsDbO377QGhw3SUHCl7vai1PWCsuVBJgWC06iShUZj7OK7yEMAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196469; c=relaxed/simple;
	bh=sc27DwzzgfFQTFrQpnFL01JAH1HWFmGBXG321GfI0hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWfh1yeL0Qe2SLFUuj1LJQJPHpdJJweLQtl1JgFckvNYzmqxIiHACnWtY5zGsvRbODFxubVPftoojsni6RkQAtXglmGuQJWtmojTQPSdpRTujkSAr261N+SNkXJVA+fQEfJr64hH5RIqOgCtNyyMIGYZ6tBIlPLA95ARoXnrCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3JvLS9p; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3JvLS9p"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c634bb5bd8eso1465838a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 01:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770196468; x=1770801268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uygNsZst5G+GJw8qWQt/teS7lcnQtwFewRjz4BVhmDU=;
        b=T3JvLS9pLVDYgvxvWKRNcV1GY4Oo/3v8w5vpkRTM2if7WMdoPZg2Um/rzhhwrEKZB5
         T/zcONGV4/Ptck+kS2bPqQslHhQmJfwZg3DFHptlFQKOvN3nH/9wxDw0MRiu7ay0dQW4
         jKcrYqzdJgcvZEbOeF7ik0S8pqOJrqYIdC1jRy05OTNOOZ03FS+rJMIyiINQg88q2iYF
         hLmhnu/nTIelcdMGdqkaJFgoeW2aRWdFauOzFLeTvZvVILe40xLdpK3F3RsINJllFZVJ
         klJPcivZIs2rEsdF2ayu6qaZccQu0qSrD3/XSuFjfznGozDFP4STSPLYR31QESAZ2b57
         Qxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196468; x=1770801268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uygNsZst5G+GJw8qWQt/teS7lcnQtwFewRjz4BVhmDU=;
        b=xPQ2ho1sQR1kEMUiHIF1conmyzslnijGI7DIu+aQIavc4wARcIs3/mf2uTqNFgXpLP
         jSCwmNH25WLrn3QenpLJAZft6eSybk4J6rngr/gLBrgGzBrSipkoBkvmMl4J1EBwl5DD
         GOZPUowYw/G0vtJTga/pFMnM68yHLDXG+AXFBhIgDvNS2ZTRZvm8jWPy98KV8oBXTouc
         8sX23rU8g2DJQJ2W5wTLFHs2YX6LqmrjKbwYuO38ywfdS9mM+2mdbIQ1Ntx2+GLluzan
         yi5dq9tzqbaBVMUyPLGFg+TparO0B7enhUzncTn/kP5iCOMDIvjIRufJXvZYaa4+IzC8
         7aZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRYHVDPgpindQXtoyAkS52zoabiKZECZmo8iA6kXwjgNU047Mw8nvsYlQLqs0niXqFxU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf37LErwpZ40zssrEMs47SorcqKM723+ZZDhDyo9TGQtXQ8KSp
	iKyv2RpMme4a/Or9p2HpHsHzkxsG71l+SJTDX2OfcAgFkh0mQFneRG83
X-Gm-Gg: AZuq6aLJ/j6SDD16ZeLRn/TjkIQYssrF9PH6CVdWB6nKDgIt++BWDSabw+lGJI8CU/n
	uoiVEaZkrIAGNLzHnGhZ86h9TRA7T8j0mufySPc+s9WFS6IPiGWNdwBEE5SLaZUXK9e76087dhD
	tOU36ko5VgInvB8KH1S6pORUNeEgoHmt09IyumIF/BCpjUZU0N3tO30LOmz6msoNQDSArz4gLza
	wWMCZPxxenSqI9H1v1l3wSQ12Xf3E7Ntl2feeXJ1noVGizpmTqVXOfaaooYKbBVj6WKeO6blv08
	VusRarECp8xHp8tYTJW1tDP8VBd5sN4YGDblcXdeyXVbqpbS3ifNVofsxn7vT4ydHjc1YH8+76Y
	FggdcEGfn92jFmk5yKuYoaKymNrFK4omlWr7SvlPAr/3ofZDzSXKVhnIifHM+kJ6fPtbEEjhddz
	PPX8covyn2ke470FK9siZFp5HIlp6pAvuUiOZllw==
X-Received: by 2002:a17:90b:548c:b0:343:684c:f8a0 with SMTP id 98e67ed59e1d1-354871a955cmr2463472a91.23.1770196468414;
        Wed, 04 Feb 2026 01:14:28 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3548630ed2fsm1996984a91.16.2026.02.04.01.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:14:27 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: acme@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	martin.lau@linux.dev,
	peterz@infradead.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com,
	wangqing7171@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf/perf: Fix suspicious RCU usage in get_callchain_entry()
Date: Wed,  4 Feb 2026 17:14:19 +0800
Message-Id: <20260204091419.887114-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAEf4BzYN33yQhO-tsF8pUWDMZoiLAXkV+Z1oP6fJkByocYcjpw@mail.gmail.com>
References: <CAEf4BzYN33yQhO-tsF8pUWDMZoiLAXkV+Z1oP6fJkByocYcjpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 04 Feb 2026 at 08:04, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> rcu_read_lock/unlock is not called when may_fault == false because in
> that case BPF program is already running within rcu_read_lock/unlock
> region. So I'm not sure this patch fixes anything really. And even
> with trace_in, if we cann rcu_read_lock/unlock one extra time it
> shouldn't be a problem, no?

Thanks for your review, I agree with you. My patch is incorrect and there was a patch series [0]
to fix it.

    [0] https://lore.kernel.org/bpf/fb745675-e25c-4dcc-be4b-4a4411056755@linux.dev/T/#mc0fc5e0fec2e6456f72f402308fd4e397ba19d09

Let's forget my patch.

Thanks,
Qing.
