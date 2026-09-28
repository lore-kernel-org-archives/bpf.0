Received: from out-zbxj-a67.jellyfish.systems (out-zbxj-a67.jellyfish.systems [198.54.127.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF604EF12F
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616061; cv=none; b=kSh5mJZ8WO7qn8KBCt9Pw73en2miv7HdBy+Q0/g/4BHFLpIOQ9HmKZ2cOhsuQtWvXcSQnP4l7nUTAovBsqW08P5dgsbMcfNx6i9MaV8H1kODJ0seQUQoe2GhdzBrpdujGpUW28KxJjsz8VzI4cLa/ybY2iDK86JfR0mYAlRrq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616061; c=relaxed/simple;
	bh=ORcxSyRaNnJVD8bh6I82E326igKpAU0fT7W0tS41VX8=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K21lNLUBvYKNrYJzTa0roGLEL1bPmRsT1PxCsq6vQLiddAGkfVpq6UJ56rkDynJBpTmI3jUcnn6zFsrGkosPMTikaIKX90tG261f4m6RSF1WN9nSDGFXZ4gty0DtBXJUt1pWjAFoaEBvJLrTNo/0prdKCL4PE7sZ9ytdMIfJPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=Lg1xRPiw; arc=none smtp.client-ip=198.54.127.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="Lg1xRPiw"
Received: from [172.20.10.14] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4htp3c42K5z6tkK;
	Mon, 28 Sep 2026 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790616031;
	bh=ORcxSyRaNnJVD8bh6I82E326igKpAU0fT7W0tS41VX8=;
	h=From:To:Cc:Date:Subject:In-Reply-To:References:From;
	b=Lg1xRPiwxwZVxexO5qo4qRQqcdBll2N4mBK5oJLPCYkfJXGqwFkmG38TuHr8syd7M
	 R/BuDC8thxylsMh/nyFPP1IlspedrItVEaPjJjyNSerxi2/SlwPWq603CastsKaKeE
	 DWYyBlQFk6Jd5qwr1sQDs64b/WTeN3yVWWGSr6ivuMEetls1mjgUSrsAGVpUh88mdb
	 cFmxBmg7pA3m3XTulrt0XhaNzV55m0qOyc1a+l3AF0plZ18gvoIePqqcKlbl9+SAgV
	 jw0Ze47vLKllOm5+z7TbTRMF5JZWflGTIFIcMgLBrQQ8feIA9Stkc0j87GsueeONCb
	 qmCzApohYg7TQ==
From: Tianyi Chen <hi@tychen.cc>
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, skokovmaksimevg@gmail.com
Date: Tue, 29 Sep 2026 02:19:36 +0900
Subject: Re: [PATCH bpf-next v9 1/2] bpftool: Add recursive map dumping
Message-ID: <179061597606.1293644.6733910074393293547@tychen.cc>
In-Reply-To: <3acbe829-06f0-4df4-b57c-a8c7b802ec96@kernel.org>
References: <20260926014208.24773-2-hi@tychen.cc>
 <3acbe829-06f0-4df4-b57c-a8c7b802ec96@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Envelope-From: hi@tychen.cc

Hi Quentin,

> We'll need to fix these, but this should be a
> different patch or series. You're welcome to go at it if you want, I'll
> send a patch otherwise, just let me know.

I've taken care of this in a separate two-patch series:
https://lore.kernel.org/r/cover.1790615923.git.hi@tychen.cc

It clears info and resets len before each query in do_show(),
do_show_subset(), maps_have_btf(), and the existing do_dump() loop.
The four regression subtests fail before the fix and pass after it.

> I would maybe move this
> memset() (the hunk above) to that dedicated patch.

Done. The resets in the two new recursive-only loops stay with the
recursive implementation.

> You still have a conflict with Maxim's series on patch 2 though, both of
> you picked the same test file name. Maybe use
> bpftool_map_dump_recursive.c instead?

Done locally, including renaming the test entry point. I tested against
Maxim's complete v4 series, keeping his tests intact: all 21 focused
subtests pass in an x86-64 VM.

Thanks for the Ack. I'll carry it forward and wait for the prerequisites
to land before rebasing and resending the recursive series.

Thanks,
Tianyi
