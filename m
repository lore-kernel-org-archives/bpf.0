Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C73D090E
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805766; cv=none; b=Rd7iWC+Hjjo7RWMvTxEf4L/1//CSDIHmu0jWUfrL9lqAdXt/a75rxeTr8p2UJ8Jbl8SkXuC356IR/ECyuSF9jjsiGKJXD7CF7Pc8UvEBAoUpdWvl/SW+s6m7qPtsww/Z1fo3T4WkdkvG7ZcAdbTxZI5HAlkSQQ0qSRImrBI8IC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805766; c=relaxed/simple;
	bh=/Tx8lp5PYGsfalGBmpWCVtMyVUB5gh3Ex5MCeuTCDj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1QQRcJ6h6/ATm5x6qz2JVC0qoBk+bFDXDpqyf3bCElHXt+K00PBDz0M4JAzeY9IcIJnl1s07NVZQpoEcAsbMsHdmh9mTjaEhRsrYA55w25ciogTNC8KHzJ53lczBsfxG5rgQIki7dtRHfTW8AN+NrVM8ExpNDJ+CchWDXgQ3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISc3EYEH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISc3EYEH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2685957a91.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785805764; x=1786410564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Tx8lp5PYGsfalGBmpWCVtMyVUB5gh3Ex5MCeuTCDj4=;
        b=ISc3EYEHBVuayorlfyCgvO+42UK6E1U3Y6CtUjd0Q4Z46SkKSLFp8JJdUS6lI5qscM
         IC/7XDcTV6vNrn3Yx3/LR+WTsK5KpZYd6zm2V8/1ca+xhs8b2YFfgGlP3Wppz7v0R091
         CzF9CO+OlQoxrjge/KMY9HY7+VNuHY/eZlSEDp+qWUK4Gsmir2vPfrNxnMCgQLJQiD8Q
         wV4a7rhGbDcQtGZlMz0S6ZenCRdWobJEdPQu356BCbPrXMOpMZoTWOHjzdLEJOZar6pR
         A1DeVuItdNJ9DgGzo/HzGAjjZBtGDSPp+74AMCUNPNtw4B/GungBsd3ls0MbAd0StqT6
         2b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785805764; x=1786410564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Tx8lp5PYGsfalGBmpWCVtMyVUB5gh3Ex5MCeuTCDj4=;
        b=PaxLZ29UvuFvxGYPsjsaclRSvDBDlZeFMcgn/NPsA2q2x94Mhlj76tfsDkcdTNxqbl
         DgP6U/JEgSJlr90kEwSei+Xvwx7My5YFgwupy9PGO4+epi3zA4t4K3FFcb1qVtSudWJb
         0gVQkL6uXNRO9a5k7sDofbtQVV0hVnH1iC4uhomtwVDH4G7eaeK46QC8hbjNxZx1eKuq
         DUSS38xxyQnR+YCyyNXF1dHechirdbmAO1Rc219HgMQLTujPg95dzE/c5/Emo/yt1hL4
         dNpSRYVZX6FgCDX4pzaJyi0NT9q2IOPODydqRncrSwbz11FVrOJ2trxi5rHHpJ8CZEkd
         9CNA==
X-Forwarded-Encrypted: i=1; AHgh+RqA5vLCcMbxVm1BPftWdltVCjg9Rv8MSndP0bQSuohBhqMWE+OX9OnJb/EN0CNIfMXY+XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKm57Ap58ZsfdlEqqfLlaO6WUJZxIhx6a8dr2oMaqpieTqYHxe
	BDJf0PrG/egj0jy6oA69WZQmEaFz+WfswAnReYi/Rl2KI70Q9j2hJwHN
X-Gm-Gg: AR+sD10d+j37QCF28y0yT5TCM8MPqCRwU3ohi471Ljk0bjkDOoEGavLz4vG25xoEqgN
	C6d7KRP/NSdzFD2FMySEQAiFvTksrgGtSK09EnyK97oV8EEpQAr/27BfZCcqzU2+fAvEjRLCLC5
	LSuIHj7totWmq1Ui4AM1w1/xGLBQk+rV4NRnoxANm6nX5THUkHmwEq6rwV5IHymXDu5NIsHyq02
	Q1yKkRCNavYHYMu1XzHLllLh+d539YEseRR3uz1hE05jh3GGk2YcpOMJ0m4/h2i6EFp4DXIapem
	zUsm+yuHV5ohtvWh8IjIKQckMMN6b9vnmNRiPxKVLgUcVHQvcD3qwScBRysJ2RQvA0V5ImaoIVr
	8pv1s+ziZ3JVgxT3/CPbOsfvUbK3RsL5DSYBWP5a/eTvUoOcYlKLNz9eD46hc7fYksLvqEvCP8P
	q78I/98vt1Jwcy1Dmoqka/F4lqghwLV700nAvI2j3UEATPXHGsRvLnGBh5j7H3iej4H5RApZ0w2
	qxVsqUZjYwnRMHAopjuDwksxfKnt8YGTZbVck2VPeejJENAQXI4
X-Received: by 2002:a17:90b:2dca:b0:38e:6dd:a9ad with SMTP id 98e67ed59e1d1-38fbc0baf26mr11945449a91.0.1785805764489;
        Mon, 03 Aug 2026 18:09:24 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38feda51060sm438434a91.10.2026.08.03.18.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 18:09:24 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com,
	sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Fix mmap_lock leak in irq_work path
Date: Tue,  4 Aug 2026 10:08:21 +0900
Message-ID: <20260804010821.3756062-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAEf4BzZ703vZPOFobvSLskKA2DzQXpMcDd1jEaydGEwjx6O+sQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 3, 2026 at 5:44 PM UTC, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> I'm just not sure that re-queueing works if irq_work_is_busy() returns
> true, please double check. If that doesn't work, then we can miss the
> irq_work callback, which would be bad.

I see your point. I double-checked this, and re-queueing seems to work.

However, keeping the irq_work_is_busy() check only adds one flag read, so the
performance impact is quite negligible. I'll keep both checks in a conservative
manner.
