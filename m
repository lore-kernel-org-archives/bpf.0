Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF69246762;
	Mon,  7 Sep 2026 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788751614; cv=none; b=C/NGf8PGFMwQUlRt4sW+UGQiq4qrmtJtffaHhP8QsYx5sCsW1iQui5C0gmtcZjwJPGW4vy5EdK5VxVGO4C5TyphAoLy8iP4Obr/OsUnvB+9cS/fHi/ljXZc8IOzHsgXHsYC0rcQHywJ57TRogNCnk3bgM8PzcY3MhxoCuIdkAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788751614; c=relaxed/simple;
	bh=jlOQ0n2PNhuPIh1KarKCVTN6XuHIkDQKRI5gKjnrtrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emSF9s6YNwVjaAhsmJj2BLNKm01UJYvS4AxTfV9oWc8WhJI1fmR8Xx63ANvCpNA2E/p7G26ooW3Rdju0fy7mOjzRXb6PTLnpLxKUqCo6ibpgDdaRwwlyoi9RTSIuB9NrpNw0tqa/pxtYS9h/dmEYGColhVnhHINPM8t4RpXdnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eQfA+2WK; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eQfA+2WK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788751609; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=jlOQ0n2PNhuPIh1KarKCVTN6XuHIkDQKRI5gKjnrtrk=;
	b=eQfA+2WKnt0jjYvooW61tRh/rXMxO1Gt3DXt3AYSWFLl7uKWgazdQ1Z988owe9r/yhIICNQYnotrxaUDeF5U60mkM4I7Nh52uVhFna4iLkzTdUnRe0F+dIZ5r+0U8KroRe/HShc9GTBWLq9i6yNY/ICyosdsMOAwM6B8kojrsyg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XAOUcAG_1788751605;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XAOUcAG_1788751605 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 11:26:49 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Pu Lehui <pulehui@huawei.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, riscv: Register extable entries at probe insn call sites
Date: Mon,  7 Sep 2026 11:26:32 +0800
Message-ID: <20260907023000.16104-1-reply-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7fbae9ac-44e4-4607-8aba-15db9779f80d@huawei.com>
References: <20260901120013.16104-1-cp0613@linux.alibaba.com> <7fbae9ac-44e4-4607-8aba-15db9779f80d@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> This patch looks fine, but I still tend not to introduce these changes.
> I think the function itself should handle its own defensive checks, and
> we should also avoid "shotgun surgery".

Indeed, you have a point. Thanks for the review.

Best regards,
Pei
