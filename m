Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99A39E18F;
	Thu, 15 Oct 2026 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081179; cv=none; b=T5B5x6lmPfv20dpkliGb7gCyt/4Ogw8PqKvwR/BTbIsMLdlma8SER+dFB3yB1k25hdOX2ZWlwkP4eUExs8H6TyZJm+0QeAEnHhXfe0BxiLHE4ugf706TwHkdpDcEfwL8p0Iudm4PR2CvrnhYamFsiY3GRNITTQ4s6LWr0Drn1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081179; c=relaxed/simple;
	bh=uiZwL32INsf6gWCDDMVmM0dirvQNYaZ9w9sYmIrzE28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y/8B5hXROgSuVqq022FFCBYgYTkY8UpdFIx6b/9+2UTKKnd42sHsvyZlwSZB4evJo9rP3ikzJ59ABEPEkgNVog+7YXqEQHGgkD4YMdwZP6pqgVkf7iUvTPsuZavb2F3ip4GvtCfa1VlaaBV9QnaJi/jjRw010LzMZqNNn9PkJt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IusWLQXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IusWLQXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2D51F000C5;
	Thu, 15 Oct 2026 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792081167;
	bh=PIBFLItZ4V5cAmzj5Xcdj2gfvndzkJvcHnICXv18F7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IusWLQXaauc+8BtXqJ61en+ufethH6O9W4ytYQl05XQMjEAXiLInOFCIreQ0iH0Cf
	 RHbCW8+ZGEcIfbF1BqlBf7s97c0e4pubOQ5nbAudRRfY3hf9EZ9yRBmY8smeXMQBNf
	 bs01L0Sp9/imv7mhcQlntYfkG83ybNr4+kA0EvW+d+l9DIplS5ybMpyX927cdLTPXR
	 Ypk/DnzzssqynODPSIE4SyvwIgH5TE95Foq/CSczP6pAsewPnI37MAmGHfzwGbDWFq
	 mGKNoDYeRU+Rzo3VEMDVM83wlBnOOHl3q+CS7YpSgJCAcaalDYdXMJik6A608zGiX1
	 +ZGUI9D7GTFfw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Alexandre Ghiti
 <alex@ghiti.fr>, Mike Rapoport <rppt@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: Pre-allocate module page tables for execmem
In-Reply-To: <20261015033643.84972-1-kmehltretter@gmail.com>
References: <20261015033643.84972-1-kmehltretter@gmail.com>
Date: Thu, 15 Oct 2026 18:19:24 +0200
Message-ID: <87a4of5437.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Karl Mehltretter <kmehltretter@gmail.com> writes:

> RV64 pre-allocates page-table levels for late kernel mappings. The module
> range is guarded by CONFIG_MODULES, although execmem can use it without
> modules.
>
> With CONFIG_BPF_JIT=3Dy and CONFIG_MODULES=3Dn, execmem adds a mapping to
> init_mm while the current process retains an empty PGD entry. Initializing
> a BPF program pack then faults:
>
>   Unable to handle kernel paging request ...
>   [ffffffff78000000] pgd=3D0000000000000000
>   ...
>   bpf_jit_fill_hole_with_zero
>   bpf_prog_pack_alloc
>
> Use CONFIG_EXECMEM for the module-range pre-allocation, as powerpc does
> for its execmem page-table setup. Both CONFIG_MODULES and CONFIG_BPF_JIT
> select it.
>
> Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MOD=
ULES of")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

TY!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
