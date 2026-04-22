Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BA175A92
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776835341; cv=none; b=tFG+b6DfY6teEvA0Yw7i7SA7HzsnrEXQmAnlCm2iqjpm4a9c1toHuGtABiO2AyLpZAPmFTKDU9KJ3F/rT8I1Kg3pi0XFAzk5M1w+6qirRdv4kU8stZmb4omnjHWV9fot79ZSIfcgEgzd4MrkaVoSFYLHdngtg+VAqDbmap+gQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776835341; c=relaxed/simple;
	bh=tfpQlkn0UEAWl0gFqmtFg4wPmDbuGZoFQQk+E1SuWKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6cmKxkKVrL9Zp1B3gu1ff8e20xZtgJrlZYEUygSTfx8jx2u3sUE28oEbki1eBiolB5rbbiKvFOpL3CkllnK0odLEoL9r4JZl9O6Ijp9uol691JxNU9fcYSX8VoQZuodQu+myCbyt0fq+WbXPFGfwXLYtjRgj3z4KySDkmw9BZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCoSng4U; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCoSng4U"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776835336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfpQlkn0UEAWl0gFqmtFg4wPmDbuGZoFQQk+E1SuWKY=;
	b=iCoSng4UdiPN4Mi+xvqi8seG7Y9q682bkMbL7hGvobKQoS1DRXzZhKMIVIvT2MugdtYWLL
	Fx9uAEVWUJd5YwL5h6vjlMRO7JwlfIuBeLXnocoWh1B/iyne5vBTnxXcqy4JIZzBjW4A+v
	OU8+g5yaBZt0Q4pPEUzRfs8+RAu5ER0=
From: Leon Hwang <leon.hwang@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>,
	bot+bpf-ci@kernel.org,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Eduard <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	kernel-patches-bot@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Chris Mason <clm@meta.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
Date: Wed, 22 Apr 2026 13:22:00 +0800
Message-ID: <20260422052202.340620-1-leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJRL=18585U9Mk13dJJqnxEDPD5-8nB++Add=+kpjUThg@mail.gmail.com>
References: <20260414132421.63409-3-leon.hwang@linux.dev>  <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>  <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev>  <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>  <3556a456-70d3-45e7-affa-355107bac30e@linux.dev>  <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev>  <CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com>  <20260420052459.85772-1-leon.hwang@linux.dev>  <DHY2JXM90466.13PVYC6ITVFKS@gmail.com>  <20260421014255.210566-1-leon.hwang@linux.dev>  <CAADnVQKEkMjmARsWMvs6SP76nEdCzBYSffSFSNE-Do=MaXMv3A@mail.gmail.com>  <20260421141326.38597-1-leon.hwang@linux.dev>  <CAADnVQJRL=18585U9Mk13dJJqnxEDPD5-8nB++Add=+kpjUThg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, 21 Apr 2026 07:35:56 -0700, Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:=0D
> On Tue, Apr 21, 2026 at 7:24=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:=0D
[...]=0D
>> XLATED:=0D
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
>> 0: r1 =3D map[id:7][0]+9=0D
>=0D
> what is 9 ? was it there in the incoming insn?=0D
>=0D
=0D
Right, the literal 9 is a mystery here.=0D
=0D
> The whole point that xlated needs to translate it back.=0D
> Start from scratch and think what map_direct_value_meta()=0D
> suppose to do.=0D
=0D
Thanks for pointing this out.=0D
=0D
map_direct_value_addr() encodes the offset as part of the ldimm64=0D
immediate (imm =3D base + off), and map_direct_value_meta() is=0D
supposed to recover the same off from it.=0D
=0D
So, the test should verify that the off of xlated ldimm64 insn matches=0D
the off encoded in the ELF ldimm64 insn.=0D
=0D
Thanks,=0D
Leon=0D
