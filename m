Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008C4CEE7D
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771553; cv=none; b=f/Qdwzu9CCMBpxDMFRJ4UVfseNNLjVuyldUOcJ1c7gYhUGdncyGAGFo1A7uaBCoYhweMI3Iv1mw6tKPkdo1nTdSE20GSIj56fTvL/JMxB87+Wk21ITAlKtLQzvYs2KKpr9YJjjFslwE2r+hyhcFwiVJJLTIBN2fKO78IcMfNtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771553; c=relaxed/simple;
	bh=7TDGn3GQ4oPu/DFwxrnAvcBWcL2hfREuPElzA5bsAAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kNs1WawVpB8/h2+27000b1ERDVuKkFlqgnLz4t6tqHyhLosg8URyES+alrL5vR0hdNeXvdDE+gAPpeZsM2RCyGZePUMbggKt19DRy3kQ7m1oJzSDV/uFcFq4yrUemVLJzVijxdLXZ18E6KzVn6p5oSz/2f03pigvHMyalaPsf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu5bL0yZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu5bL0yZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817BA1F000FF;
	Wed, 30 Sep 2026 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790771551;
	bh=7TDGn3GQ4oPu/DFwxrnAvcBWcL2hfREuPElzA5bsAAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Lu5bL0yZ25wckbpSEVHcpUZSj0ozYcQrOJNZ3FWrVXcWwm4q2Iqzk8YEhtwARdOYE
	 xtVnIrpqr0tIfPuDx1kMcCygxBBQK5hCmjlN1ylGFh5CGFk9Pe3IRYCND1xjdTp4ZN
	 JUSZKWNzSva1PoBVPJpc+7K32en2sMXyrUNvvVQMMGFSaPTl30yM1W5tOsYvT7EnbR
	 cbK898k0OHudXoGWxZnK/3+0dwITqDaf3GcaXC4DG/5AohDCkB2L+8cl3p4PANPxEk
	 PzMTiIV1pWt101AHV4vVS5iHba9p6YbWkuhGRDCmwu1bAlcD6NdxaikqoVaDHBk4Ln
	 FshGgU22rHkIg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
 <xi.wang@gmail.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, Pu Lehui
 <pulehui@huawei.com>, Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf] MAINTAINERS: Add myself as co-maintainer of riscv bpf
In-Reply-To: <20260930104659.1919027-1-pulehui@huaweicloud.com>
References: <20260930104659.1919027-1-pulehui@huaweicloud.com>
Date: Wed, 30 Sep 2026 14:32:28 +0200
Message-ID: <87se2q3oo3.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Over the years, I have been actively involved in the development and
> have proactively taken on maintenance responsibilities for the RV64 JIT,
> covering the related bpf core, riscv architecture, and selftests/CI
> infrastructure. With the continuous growth of riscv bpf features and
> testing workload, adding a co-maintainer helps share the review burden
> and ensure timely patch handling.
>
> As for the RV32 JIT, there has been a lack of active maintainer response
> for several years, leaving incoming patches occasionally stalled. Active
> maintenance is needed to review incoming patches and ensure issues are
> addressed in a timely manner.
>
> Therefore, I would like to request taking on the co-maintainer role for
> both the RV64 and RV32 JITs. For me, being a maintainer is both an honor
> and a responsibility, and it also makes it easier for me to participate
> in riscv bpf work, where I look forward to dedicating more time and
> effort.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Lehui has been actively working on the rv32/64 BPF JIT side of things
since late 2022. Going from contributor to reviewer, and now stepping up
as a maintainer, is a natural step. Congrats, Lehui! Well deserved!

Now, finger's crossed for getting the BPF CI running on real rv64
hardware!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

