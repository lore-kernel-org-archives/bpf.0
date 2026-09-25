Received: from out-2z4y-a164.jellyfish.systems (out-2z4y-a164.jellyfish.systems [198.54.127.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB34CC281
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359120; cv=none; b=B7AVjcCRkyAcEiErBm52eI0+ZooC/kje4Ra1xx1IgMXfRfjRzD3hNmzt140VuH+cIl7fdEYwK25CSTDaORhtnQ39msoKecyj42gUuUBHmYgoMiFMBstjU3fRbmsd7c4T8pf/mSsN7zQzZWk/rq6KrEq+OlcIyeQbGGxt3ihAog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359120; c=relaxed/simple;
	bh=ymgShMe8JjE49tDt3/53i+PPVMEinp17pSyo2+BnjRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECOUmB3HObi53O5ezdCEqFffFJe4AaIKxD9bgPVwAWDh5eP+Yd5zdu0Yk9kcuVCc7ad7qC4a7X5MVB1rxa2iUrNBdbddjspvFGX3Xs7qEsS7PxzVMOnpISNpY/JDfsmmKoAarwE4j4f7Es3Dv0fDzpqanrYtyM7wdcdKGJO3t+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=E5qgvoZL; arc=none smtp.client-ip=198.54.127.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="E5qgvoZL"
Received: from 192.168.50.46 (unknown [114.92.81.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hrymT6X6Dz2xDd;
	Fri, 25 Sep 2026 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790358363;
	bh=ymgShMe8JjE49tDt3/53i+PPVMEinp17pSyo2+BnjRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5qgvoZLwc4ltJMaQGlmPRSfztoc4kWz2mAFMUczm0hdSzPFx4KqBrp3JusQZKGgJ
	 10Yjvg64tvjAzfueZvq4TpefqZSPfyIMJW/1a9pY4brPaIG6hcE73Np2H74dTKkrVx
	 MW3kprjVsRM2OfJK4ioriJsqjQDlhiPwNpYINFMn0fPPihlDGzpWreq3Um38nE8q7l
	 o2jEgZGjnHsX2XmE9JyySq3ohuzmO1mESIM9nKIIOWAisOyOrGz3w7k0JdiZw6Z2BO
	 mcDmfM9LJUFliFKrvS/5vaSEYzwYfjGKyvN7CWqW+uJLp3ufX4JHqq2rdgVJGrE2O0
	 Bt6FDcwacXxag==
From: Tianyi Chen <hi@tychen.cc>
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/2] bpftool: Add recursive map dumping
Date: Sat, 26 Sep 2026 02:46:00 +0900
Message-ID: <179035836017.2029588.7852183060719250433@tychen.cc>
In-Reply-To: <6ed88738-4e3b-407c-90c2-bf7717f3e653@kernel.org>
References: <20260924161434.95116-1-hi@tychen.cc>
 <20260924161434.95116-2-hi@tychen.cc>
 <6ed88738-4e3b-407c-90c2-bf7717f3e653@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Envelope-From: hi@tychen.cc

Hi Quentin,

> Can we align it with what most other subcommands in bpftool do, please?

Done in v8: REQ_ARGS() and map_parse_fds() now handle MAP first, followed
by a loop over the remaining keywords. Misplacing recursive now reports
the MAP parser's error, and repeated recursive keywords are accepted.
Trailing-argument errors go through exit_close to release the selected
map FDs before freeing the array.

All 13 subtests pass, including the revised argument checks. A syscall
trace also confirms that both FDs selected by name are closed on error.

v8 is a new thread:
https://lore.kernel.org/r/20260925174402.2028649-1-hi@tychen.cc

I also checked v7's CI failure: it is test_verifier's invalid call insn1
on s390x (expected R0 !read_ok, got JIT doesn't support callx). The
for-next_test run has the same failure, while all 13 recursive-dump
subtests passed on s390x:
https://github.com/kernel-patches/bpf/actions/runs/36028683139/job/1077369230=
87
https://github.com/kernel-patches/bpf/actions/runs/36029092386/job/1077370328=
90

Thanks,
Tianyi
