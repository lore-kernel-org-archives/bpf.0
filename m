Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879A3A544A
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785388730; cv=none; b=jcF0Jp0TDwou2LXXX3l1exnhewG5ijKUrisJiGhSoPZcaIGz/0OelEUwRiMKtaCPjw3mKkOtvo0kjjH2RuE05M4gy5PhuzQXYGrx0UU//gPtwXbzu9m76Lm3ujdolwEqm4Geif53G1CQureNria0DB2Or04TRhHVFRzV4CMIgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785388730; c=relaxed/simple;
	bh=LIfu4x7xfM+uBXxf2PUIKCTibRfoyj7vDPecqDmhgEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+DSlmxtbsq2hRjS2gSTojmNsQg7vtYReHhxJSa8qW2TKC52odT1ESPJuWd/uX4YbrJvT3lwF2SQrGg0mFcRuBRkOd197NPWGAMJl8Q5ls0ckxA4eDwSLQu47btL369WT34gPu7ggw6rHSR2xOVkXy53uHnr0epGZ+rY++nXByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEHd2+/C; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEHd2+/C"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so1933737b3a.2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 22:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785388729; x=1785993529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qg4+DcUhBAZn8bx3zqQaDnZY2M4pMardXDHCGdCxnPo=;
        b=OEHd2+/CSX3uJA4kCkC41WqPzXgygzlUsR2qCOP75qXDIgYzxc28ZyNc9MjC+j/xuX
         OwDz48iCfYSP/UK0p2V2ZTGEPw/O74ot5fTzLz1JzCZd5NLdTZJE6pvrpP8uKbwPTzRH
         W90rDA6U6oqGmykCBD29ue0ItQAgRliHsskAKJlvInxkHYcE9K9wRuZAEiIgysBvNl7w
         zZs+MiodGz75nSdfWB6fqye/F/gyfO5FvTNcPodCJYOFYMzvzgtheX1wehvkEBQytQph
         sI9EujFKfobg5yRKXzQte56TwwX1hUGxtqaZr/+kqOSzGfwsvc69CKK7eaQZvXrLu6cz
         sj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785388729; x=1785993529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qg4+DcUhBAZn8bx3zqQaDnZY2M4pMardXDHCGdCxnPo=;
        b=N26hQnFxjouqvDhVkLEVL0HBsxOLBgCVprdN9KSxFEMNLHK11JRgCHsWQEz4fIwp2Q
         E7pPZxaLX8D+IQ8962dDjrH5IDTk6349Y9h8AUi1rTsPCHEM7P/F4j+mxv2ZRx4lwQDO
         atWqkTVQcRDmu6/yswUffqTJsHiR1KMKb4Ix+Fsc61pUAnSeOpcfbFa+Ez+Ho74WaBlo
         o5WwleYHa+9/ouEqyVE+/GMIeSh6uQwAAt9ef4PjSzhkmvXRAdiGyIJucum0jpLvy8u2
         9/o4ftWrLsWuQ7jT/QqHNz4UlBKExGZ/EYbh7fblIjuHU7pP6ZvBblNmsQRDLTUpge5I
         EwQw==
X-Forwarded-Encrypted: i=1; AHgh+Rr315lWFOEDeXOUYQFuVj9VW/ZTY3SW9GSBNS62rW7VqOP20eT2zH9QYtjAubxxbl0Do2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwREU0Z3a4ocqrCioNluV3p1vRLlCqEHkUilVx+5C3PcKokay5E
	DVo7Rv2QnK+ydRBeNK9IZHN1dLHGEH+/ufjFZRQCYDOmuqzFtD2xPzsm
X-Gm-Gg: AR+sD10uBkBC3Fe43b1hMU1Ld+krdQxklnDAUAYz5P4dU+Zk+9nTbOmY0dfMHwHSIc2
	UIOFZiQI8mKexf3zUHNSYlWqVpszxJ7/GvBERbu2P4b2WOx8mzQiVIptRA20pmKxts9w6tGS/fP
	oRwBz+iRKjv34EUVjVup5Xy/WyfTLpSReqQadvNJilA1bJy8dFP38C4zoyVk00olqVBXABlBIBz
	tMXfhXCCg3G9ra+hBug0HnxSKPonEPtajoWQjInGNp9NiEqghxL+7XwiZ9rH55zQZr9PvG1CJlf
	o8rrIlc+JhFbI4nLaxNxXHOTt9qXFPjAdrzcv9hlZuIqxqcx4T9ny2D+sWGm87rEhgJZeXOJxp3
	jxZLX2UQ+FDKNDNf6/sNNKhPvZirMxZcVLDs0ByMMdwuabwCHiG5QVKfk2U/x6km7ey5Bo/zy4z
	auXd7RFsme89/XE64zpkajcPmK/aBIzFFjXfDS3jSS6BT9CFlMgh5QXBXQNVnWcoEwHKVVcs8sE
	F2eQbr/Vc0Q4xP3zsSSRmbLCzlCH8D5oubkb+lUBODaxUZdTvgQ
X-Received: by 2002:a05:6a00:39a3:b0:848:4256:d6ad with SMTP id d2e1a72fcca58-84ebc3e10c2mr1241466b3a.60.1785388728666;
        Wed, 29 Jul 2026 22:18:48 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03d0675sm2342543b3a.61.2026.07.29.22.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 22:18:48 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com,
	sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix mmap_lock leak in irq_work path
Date: Thu, 30 Jul 2026 14:17:54 +0900
Message-ID: <20260730051754.113857-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <33024de2-1121-4f08-a579-8a9ceeddf8bd@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ihor,

> So can irq_work_is_busy(&work->irq_work) be dropped here?

Thanks for pointing this out. 

You are right. The active guard is sufficient, so irq_work_is_busy() is
redundant.

I have dropped it and will send v2 soon.

Thanks!
