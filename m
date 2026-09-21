Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379F374A11
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024697; cv=none; b=fe8PjtzfbyLNieEHhfF6vf7kIGS3CAEERBiHI2vgiPfvMjXQhj7ekzfjPHxjOJlx2tGKzRblQ+6V4A4pf+mYwlsQbS+eRoBO9hbm7sej+R6ILvwpeXoZD13czQo0hKMRXCBTBJ7maH28LAltd6oWBiT0/URtEicZxnbTzmm2434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024697; c=relaxed/simple;
	bh=TCU5uKqftm6pV8ySX7thVj6H867cmVD/gp11mWSo7sQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U3wcDNGRrfp9mEu6T9ZBXI/5eoIT2RTpT/0mI+S8EScAxF/WFKqhV+IZxuux80pIJLh84iFbM+4VwjYjlVho8uf1sAiCQmEpACv8EzIZRnbr1WUUkttBKjhiXk77YD8nQL7Jkz0V8/IuLOVeIGPDrS4+UGQh0enbMGj5Y43BHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iknVkfMn; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iknVkfMn"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso396172a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024695; x=1790629495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TCU5uKqftm6pV8ySX7thVj6H867cmVD/gp11mWSo7sQ=;
        b=iknVkfMnxUBLQ3gdy8HebjX+bt4CiPsD77qBlM2Tvsnod1RNAsi0kvF+gyF1UPMK4S
         MEAo5Cm6y53FCrH7cX1cyT1u8XQUcrO5FsjTsiVl/+QatfZyTMZ+d/m8mfhf3MdjbnkE
         0AyMvaRr66EtvaGe+pSMLWq9oseUzDfjI8o8q84Bvkgrb3nReTq6WuUbTDjA2xE2CJOA
         IeqDFuCJJRfKq7eUKgf27X7oH+fLUWbXaWqgF1s9t7cW2qlTmQe1wTQS4pqlUShh0wxH
         u8IatgVEyIAMxlgD8Nw0Lw29bwmklOgHaDG0bfz6wTOK65Pg6E0qhV7UFCeiXrkIh/a3
         /fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024695; x=1790629495;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCU5uKqftm6pV8ySX7thVj6H867cmVD/gp11mWSo7sQ=;
        b=oE5zAX5jmeI+erYGoH+vUnOOZk63AAhIxLiUUu3NXu9qkgZeGeDB8y2LTQbzSuLJiE
         kNjqnp7erFp4VLbsgFNudn+3NQ86NSR/xiS0M8+iiiX22D9GSYS2rqBuORG0TcgEpdxd
         urroCETYlr9RDeDSdBZEPgQFxu8VBa+SY1ndwlnGSLppxFuHPlqZ+lAlLwlV8yxTjste
         yL/t6ulEz8Y94D0ppSNFS0+UlNmwtpjvhmv+0K3gh1UDk/BLqPyvELSdvvJZMxUEQT74
         NzKL80++TBfWuKYfjHjX2hVbtvxp/HJMJVqRTNAWFgilUCB+nVde1o3qOlcE9qT26dPf
         ZdwA==
X-Gm-Message-State: AFuF++k40OSL8g5TLnqTFsLZE6yRzyXy1vykVBkYu0YbZX1F2aOvR7s/
	Y0ZK8GbDG8AfGnkl2sLgScYMKkLWQ5GZQByz9PlkiJ7SAmYzWOcf4mkF
X-Gm-Gg: AYBFou3H4ThYAGc+rjJIEDRkIEAvvX5GLkOeJLofQ/pI/v3Rmqt8iYCsm1NetJzP9Bg
	RwrNtOOaNXZLpOWPap+0tPQqRfx70VTN1rrd1MvnBn7yiETiwlm5zpdW5/pYvXs1xrRDrOKnb74
	TouHA3EZqgj+FkHnq0u8L2DbsxDpDe3cw2w6nLRr3PxWimMN9Kq/VODkkpwBRVvKozli+71jVYn
	NhwdlTZy7iXcEkFo0zQIB6aTd8MwQDw6TiBiWXDI4FgDelZi9P7HGA+yUoGEezhnsAtmTMmjJix
	fXWaSScf2nJUsdisz+s55eammp73oQeqISW2VeWZz+UMQaqSevqWe4EmCdp8raUCuAmRGCGUoNn
	JvbUd6qDrjuQ+vCp34ho/GFMRke6AkVk++QonGaV0WIzRIfN2POF85zB1fS+luqdbtGEeKKtjTp
	lEbPGY8cOUEw+ke4Z7dyy5uLTKT86wsula5o+aSdpukur+keUepW+kVXPBjmkRiUvDjYayVtBki
	rT0pI6dOEaV4YI2I8GfCDag1xrljBkC8vQKIc21x8CPHPXtdg+Pbb6K8w==
X-Received: by 2002:a17:90b:5585:b0:3a0:4146:2955 with SMTP id 98e67ed59e1d1-3a041462df3mr5954509a91.61.1790024695006;
        Mon, 21 Sep 2026 14:04:55 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9de9:26b9:a969:69d7? ([2620:10d:c090:500::5:f95e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ebc659dsm649340eec.11.2026.09.21.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:04:54 -0700 (PDT)
Message-ID: <d3a251acf5131bea732e23bbd135a5fdebec9ad6.camel@gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: Fixes for out-of-tree builds
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Nico Pache (Red Hat)" <nico.pache@linux.dev>, "Ricardo B."
 =?ISO-8859-1?Q?Marli=E8re?= "(SUSE)"	 <ricardo@marliere.net>,
 ihor.solodrai@linux.dev, nickolay.lysenko@gmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, Emil Tsalapatis
	 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Yonghong Song
	 <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Andrii Nakryiko
	 <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
	 <martin.lau@linux.dev>
Date: Mon, 21 Sep 2026 14:04:52 -0700
In-Reply-To: <6f95ec90-194a-4304-9673-c7bb50065223@linux.dev>
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
	 <6f95ec90-194a-4304-9673-c7bb50065223@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 14:40 -0600, Nico Pache (Red Hat) wrote:

...

> Given your series was defferred, and there is a "rewrite" coming, what wo=
uld
> be the best approach to working together (between us three) to get these
> fixes in that series too.=20

The, "rewrite", as you call it, had landed today.
So the series in question can be re-spun.
Regarding your patch on top of it, it appears you can just post is separate=
ly.
However, I am inclined to be confrontational towards changes like this one.
The purpose of the selftests makefile is to run selftests as appropriate
for current tip of the kernel tree using a very specific kernel configurati=
on.
Main users of this makefile are BPF developers and BPF CI.
Support for distros customizing the makefile is a non-goal.
The "PERMISSIVE" change done enough damage already.

...
