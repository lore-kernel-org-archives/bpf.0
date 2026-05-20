Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B863D1CA0;
	Wed, 20 May 2026 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270698; cv=none; b=Ps8Fo0utC4ufc1QeAJ6DwMedqI5f1se6pRxMpBAjkgbX0fwOtP8v/6kPtMVYXwoXouPXT97DnD1mSkP+gZUClN56mhkM0Krb/6tjXgk0j8AZpNEMQabFHchl20BzoFDA3alEnlvpFDMjVRvgaDcvwrUBpcMIA8uXwt6LKZckxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270698; c=relaxed/simple;
	bh=dFgdqAwxbnhDbOI7KjqNJdPZAmNs24lIwQWDQjOwRpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulIySmK4XzKolA2zBL8ZzesUu3SNZM6ATmwB72pqT4RgNT3RCz4Agrsw/xxjFEguNVHMjYhWFUse+sgSFGwahcll25r3LApUqQH4E3z9BlcnU9ePvYUb7tD2y6f6+TbYCki27euUtB9PUCjBpxjJzJydEZGP/snUAg5Jn6HVvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKnTu9TF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKnTu9TF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4561F000E9;
	Wed, 20 May 2026 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779270697;
	bh=jRgkuNhlaz7GIPNQuD7Wf9Ln0AeCoLTOgcBuRnbyL/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AKnTu9TF/yW/PDy37BWj/zfZwcDBQ+8uZbyOqIjHzYFpiGl/urMHuecEPNR1oVrrN
	 3qzGTu95NQ2Uy+n1W64Zc+55cRjdUaiHO9SE5DKjEHgzqnedOwtNLQEBAZwgLiOAvE
	 AER3CMgB25FbDZa/r97zx0shuu22hIYe1ZeAtUbvaC9xyJyeDsSYfYvjvE6TiE7sYZ
	 1uFRYXzPUvVl46INAwHBp2r3n3Dd433//5g7gSz0n4iZWWUlkPrdaEcRzprq5U4ge4
	 NOIKrvlq2Ut1IIs1HMCxHp+GPrVC23sAWap3kADK4MY33hvwDx4G0A0Rzjcnv16amQ
	 PDxs6UffgR+uw==
Message-ID: <8fca97d7-cc1d-4f9c-a045-ab202aa03e43@kernel.org>
Date: Wed, 20 May 2026 10:51:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: fix typo in struct_ops map FD generation for
 light skeleton
To: Siddharth Nayyar <sidnayyar@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, gprocida@google.com,
 maennich@google.com
References: <20260520-struct_ops_gen_typo_fix-v1-1-4dee3771da46@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260520-struct_ops_gen_typo_fix-v1-1-4dee3771da46@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-05-20 09:40 UTC+0000 ~ Siddharth Nayyar <sidnayyar@google.com>
> When generating light skeletons for BPF programs containing struct_ops
> maps, bpftool incorrectly outputs a stray literal 't' instead of a tab
> character for the map file descriptor member in the links structure.
> This causes a compilation error when the generated light skeleton is
> used.
> 
> Correct the format string by replacing 't' with '\t'.
> 
> Fixes: 08ac454e258e ("libbpf: Auto-attach struct_ops BPF maps in BPF skeleton")
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!
