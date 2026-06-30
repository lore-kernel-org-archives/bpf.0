Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED422424C;
	Tue, 30 Jun 2026 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829472; cv=none; b=AMHVvdE2vWydgrqxQFuv/kCxUkJU0AwrVJQEQsKGM4bFzXrsTk8z6rOFW+zOOHjl3LNHbWdhEeO59ysCFjooJomfY+mJSQt1QjTMrpYhNUjiAcSeg/9PNSL8qGcEsebvhFEQi1dCje6rQmg03q5fKokau01dMvPaQnU8zPYlZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829472; c=relaxed/simple;
	bh=QZy+W4+BNWiqF7AxQn8o27OELqmWr3Sc1evQOKfzb4s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=YFs/4GU5Bz8oIIiGIg8UDPNFDcWvd0PtnMWFo8Idgq/lRh6NQdvZHp8f2IRyAgK4oVjP2nKIvSfnfuqHYRIPp1TzozLzMyi1GCZbA0kojCHMXX686YGKS1DgBK3JpBmBct0Zp4idVK+UiN11IC6dJ7Trh9bTptTTWc31Byr7cXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ardKjAgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ardKjAgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7681F000E9;
	Tue, 30 Jun 2026 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829471;
	bh=QZy+W4+BNWiqF7AxQn8o27OELqmWr3Sc1evQOKfzb4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ardKjAgb2LAaKse4ZqJ6B0VCXoSfpkHgTTPPNsOIfAZ1wZuwk67jx/8oEnjRf0x8Y
	 QVMXSXu56wWgZ611R5a/M8Uh5PiT0AoHUN30dd6MXpYIiJLxB0le01Yfc/3Uc2a2Qj
	 T+JEtvZ67ew5HfS8tkbj3XoD3Kugj8mrnLT1ynb39cz5YB7nFamcIBtwtjPqoCQBGs
	 NdHlIEoNR6U003yKCATU7Hbgb2VJIsgk6lRhJQpgkGQy2BVo9DoPrBRJWZrp6HyOkc
	 JyLiHecgwRsg/kQAzXMHAgetObhBiKpQxC7+1dPs87wNo5NLALWMhXY6pacPSf1+F8
	 9m5fOGAvQHJlQ==
Date: Tue, 30 Jun 2026 04:24:30 -1000
Message-ID: <e35c50e9af7aa165ecc8da8293bf8a57@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] tools/sched_ext: use btf_vlen() helper in compat.h
In-Reply-To: <20260630081720.3081733-1-luoliang@kylinos.cn>
References: <20260630081720.3081733-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.3.

Thanks.
--
tejun
