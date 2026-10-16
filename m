Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956923C516
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113526; cv=none; b=ZASS7BQP2Ra1jIfte9vdHelGBiDkSqrRhVQ6Pt1NkkVtw8fE/UZDj53yXqx7gy0RFqNPpk/9DB//Uxl3nR3rpySLHglli8KK9h/bz+/9CsmdiUc6JugGsIMcGT/jR83+XCO5EBqou9/hx6J6hbFLZGDkbfxuCjdNna1hBaKGOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113526; c=relaxed/simple;
	bh=cD9bFPKRz50a/h1mDMb+Pj4a24yOftOkt1oVhT4DepQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=W5KIxYz40izvVdw8dvoQzRpCKNkvfSxI0VRcWS0VKsj3f2SXZgdCbyc8T6zGXhWwiIWZvGA5BhBS1/7tJHa0YIVfxpIYLUcWUq2lwxfKdS/F+Ef+A0IAHeVaG0B+bvkRaPkDSZMs/HGWoLvG0E8N7hZFx6vMgivG7hBGcIn87Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oO/ppbu1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO/ppbu1"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-878b44611ffso4053643b3a.3
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113525; x=1792718325; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cD9bFPKRz50a/h1mDMb+Pj4a24yOftOkt1oVhT4DepQ=;
        b=oO/ppbu1DYEOjgGb6TBAM1LqUgqmJFXbSC+sx9BoGChwvoCYji6ufun8SlN1SLA5qq
         wOfwjXWSmaEmUlE8TTYHGUIK4S0I6c6ISb8n/1QhksVqn03qnP0pvRIPFqpWBkpTdaxa
         0TmYRVjnoYW7MOff3Ln1D5cUoGbJO5ehawQNVwfQygqRPirCnpQHfL3cQr2303zkUKv+
         CL7C3sBQiwmgBRNMPrRPZvLkL5Y4tGwC84ES7mjQnsMXtS6FOT9wWY0vyrMPCCRl/d6h
         4warun7tUfGfa7TSiSgDw37MbDTPuKcrF0RIWgDj3yJtJpBbDeY00WRoVKmWLowyYTx7
         ZxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113525; x=1792718325;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cD9bFPKRz50a/h1mDMb+Pj4a24yOftOkt1oVhT4DepQ=;
        b=CNY9KHuDqlKwUauq2u0y+uQZHN6I0OngIPKco8XoqWvHz67bJCzQTYRmSZMYtaTiTu
         KGWKivDNzTHjh+igwj1wvPO/5BLuN/2AteUryl7deD+Avtfn2BJpJknXzm653rnY2ug+
         wttLvOfZiXOr5+ngUNKEiyid61hzrMCJmko35s0aB1d8MRlx0w1B0HOctQWBLMcrRW10
         lkVCqL8Z7BQBCGGe3jElVYpU1NMfsc+cJdWTSmVqqnLQYP1kgGS80vsER4nlDxbwnx5c
         BghvFi22CzEa4VezJPncjLpKgOpuU4ecG6qcY4x+47TGx5i27jiccjNA253A8NUtH9yc
         +Gbg==
X-Gm-Message-State: AFq9FYI1KVMRoYzHPrazX203VXYtgDNjS56coS+W1+Xn3RcM3meDzOov
	OvDYhBbqRzD0v753f3NwKNKe/fleTcDnDttU36WnRIJ5P0e8vcpbTNxm
X-Gm-Gg: AYBFou1gy9XR05Bsrg5BOTRA5WBOU4Dd/UMdEhXx67bdr3r4hKi7g3jnMmfOYdJdmSb
	E/iNFZ1w4khwzJE2Z0fkogfzwdoLrulVsWAO2cPXudQclJzcBGjWdleATI3/Aw2++DBQTjryLpq
	EVrS2XGrB/GCxGvjSm8uDiWr8b08l5/B6ks5maWkuZegBbDNkYL4TfbYInHleQ1FQ4u8C2tS3p7
	aP6VQSW4r3JKs1VCHxAGit/oXUPYHcP0kjPtGlNxueQjgVRrISprqIflD50EkX5zjNX0AhKWj5P
	kh/dKJ73KHRaikRg/oUncDHmUDED7mHco59aanV3s8gWKM7IWvNcSSj25za5Zopl/8kmWilcwvG
	6ydTyOzmC1NNKN2yBMWLDZxDW/wtYzG0/OkwRnOfMEkLCKsjoii2VYvXOonvWjBJt7KDmaVoDPI
	a6xPW75wK/H9/x2kLQpp6UsUp/07R6IDIyIG/1UgXpepmJODpGaGnj+M29YV4SMkn7aMmMQ8EBn
	1m0DaJsPWjKPqN42d+8xFcb+h+jWAbEYG3pHdTuMS2dGLE/kHwIog+jxss5zxyZmVf3kFOS8H5w
	3xg=
X-Received: by 2002:a05:6a20:3d06:b0:3e0:b9ec:7c64 with SMTP id adf61e73a8af0-3e16bd85989mr21112970637.18.1792113525097;
        Thu, 15 Oct 2026 18:18:45 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735dc64sm334219b3a.25.2026.10.15.18.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 18:18:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 01:18:44 +0000
Message-Id: <DM5V83GMXC13.B0KDKO805LCG@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Cupertino Miranda" <cupertino.miranda@oracle.com>, "David Faust"
 <david.faust@oracle.com>, "Ian Rogers" <irogers@google.com>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, "Vineet Gupta"
 <vineet.gupta@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v1 1/8] bpftool: Dump C from a detached BTF
 copy
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Quentin Monnet" <qmo@kernel.org>
In-Reply-To: <20261016000012.2232059-2-ihor.solodrai@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev> <20261016000012.2232059-2-ihor.solodrai@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 15, 2026 at 05:00 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> Modifying the parsed BTF fails for some valid input: libbpf refuses to
> modify BTF whose header carries unknown nonzero extension bytes, so
> such a dump would stop with -EOPNOTSUPP.
>
> Dump from a flat copy built with btf__add_type(), which only requires
> the destination to be modifiable.

can we do btf__new_empty_split(btf) and add decl attrs there
instead of copying all types ?
It fails on such BTF only because btf__add_str() does
btf__find_str(base) and that calls btf_ensure_modifiable(base).
The lookup shouldn't need it.
