Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F5314D05;
	Tue, 22 Sep 2026 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046980; cv=none; b=hVmhbF7tFUnxLxagbHTH7566Td0EdGjr9iTV/MoNXoE2xS9K4qU0bX5tb9LhWMsIK++Hg0SUpTL//qnbkks8gvIrcdR8J1WkWIw14iXg0P2h1P+s1lukfaPAVaPIDF0bBJ+sZZ+h2+WyHLNsDzeIQEF25ATs5JHPWZm7GlwS0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046980; c=relaxed/simple;
	bh=5uQ+8p3PM2qLrd5BKrJFE5PB13djnVE5F7PfGTl1R8U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFQnZHklpWrcHtbw68veYz/520SI4JyiY8ltB0FRalKd/t+VramJ1RpcLRQC8WkcHx3sXuKGPe2b2fx7GgIo0autRxeR2wbCZRsiY1xjiX3/KI9mafgkfxZo6/kC5m9qUJWf2i4u89HxeV38kPsvTXPM4PLXajau4FuKVUjSfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nieMWeJT; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nieMWeJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:Message-ID:From:To:Subject:MIME-Version:
	Content-Type; bh=5uQ+8p3PM2qLrd5BKrJFE5PB13djnVE5F7PfGTl1R8U=;
	b=nieMWeJTDnETVz7o6VrsbtIfQeH2LJayjxLpalK6rePsZZULyZDurtsNnOh9WS
	Z8xYw0zr1bfhxORdHaYuKS2eUv3syfhwmJVxWNyQwQfKOF3oOeR4ekzH+BP++M/0
	aafU46GW3Lq/GLihVaEHzWoKejh9r/saxufIhmHLjzGTA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n53H8rFqcm8aAA--.12894S2;
	Tue, 22 Sep 2026 11:15:20 +0800 (CST)
Date: Tue, 22 Sep 2026 12:15:19 +0900
Message-ID: <df65573062819d671499dcb3bf3b8b92.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: qmo@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org
Subject: Re: [PATCH bpf v2 2/2] bpftool: Fix sparse CPU IDs in prog profile
In-Reply-To: <CAEf4BzaxH2geQUUOOGw8S0fhm3c9Z0H5r75QPo9_ziiqU6MF2g@mail.gmail.com>
References: <20260918102052.1247819-1-sh_def@163.com>
	<20260918102052.1247819-3-sh_def@163.com>
	<CAEf4BzaxH2geQUUOOGw8S0fhm3c9Z0H5r75QPo9_ziiqU6MF2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n53H8rFqcm8aAA--.12894S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU58nYDUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwgj1VWqx8shIVwAA3U

> I don't think these fixes should go into bpf tree, please rebase them
> onto bpf-next/master and resend. As is they don't apply cleanly.

Thanks, I'll rebase the series onto bpf-next/master and resend it.

Hui

