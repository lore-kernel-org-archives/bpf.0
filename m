Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B814A8B
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790299412; cv=none; b=U7hk4bFtOUWEK1TAPNccVUc+qlQ4RM+7K/7ZbuDLQOse73O39EwkbeXV52sWglQqrWVYfdMEcfQTEokdz5RU7Lz5hcruWSKUxwhJV5IocIczceGKWArWZmy5cRUish57nl8F6J6hoY/hvwa7uGamOg6VAEV5Lo1HsviSMi7msPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790299412; c=relaxed/simple;
	bh=vVYqJlOdmWApKywck7ezDv3BY5aOX5uDYGJD943b6wc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LLLKPUQsJoEtevEnb2JIItelvVKtx8CcfyDbqrupqzq0oIsjJb9ps321EaFFDwBw0TAQXSRehL/FQ2Om4OrbahhtFGMTVontFtIEjBJGkvbt8JHEz00T6ERIux8Np+YVEkm9Vo6gRJwrRAmykk9LIutNPFMb/y/X3Xwmt9KplMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3afLfAW; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3afLfAW"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6aafac56856so184776eaf.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790299409; x=1790904209; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vVYqJlOdmWApKywck7ezDv3BY5aOX5uDYGJD943b6wc=;
        b=d3afLfAWcYYklnba1n4BLZBnxvEpQuMa+L5GMrIzeVGYyJ9BSzgLZwfcFbRu00IR2s
         ISrtlZeseCjbb5/SPtjYp2iOK64la+93cx1bT5Ao6Rlvc/TNWPyBtSDWLW7lWSmgngS7
         hNwKEXIx5bGQi3xGwZkejZCIPbrVTuu77Gv81lorV4VOJg+hHp5ABsGtX7qG9nT99YlC
         2gwtMclXOakmzJZ4Q3p+2t5m4LWJO8aK5yXjW3lQaTsdtg3YpBED0T4Ecffyzsoy+AIQ
         ZxbIu3nRir+/Atnp8i9yVNzBBtuwi4CiQ+b2pCbXUWffbsFoMJ9KT0TZdKynMjplcmEY
         YD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790299409; x=1790904209;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVYqJlOdmWApKywck7ezDv3BY5aOX5uDYGJD943b6wc=;
        b=LUcGmpDlDd8R2WhZGYdWV4zBpHYJWE63Xs5S4dsUatYLB/VaY9hxrcG5E/kaJCVTo6
         kp2h2oP3vvFBQHT/FOBX3KQ6rrO0VCzeYnnfsYSkXju4VapRA6L49BeksuNeo0dA6urQ
         7nyYzrR5PLU/0tnAk3qiVSETXL4KC2DB6UwhY35E5iEQOiF70m0x0Y0fY/DY0niCm5ve
         mK+ED/OVbf7mjNNEHNKFwcD7CPoEN5KNvtYEKBfeBbGiJ2v1b3Gn4+suSfYUWpTsghXY
         TWf22c7yVBD9avcjGJSE75CIS5PxNVOOGAMn2NqyLf4dQzkCXauxrWuv1gIaIMjIy3OL
         diwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxc6vyJGgmvmL6ehXXHrVGuxG5h/tX2k6I7dFVMby4DLLcSizT7Ti+NChdvRHJwTrKTO3o=@vger.kernel.org
X-Gm-Message-State: AFuF++mwP4dy35NKR1VxorGH2KtZO5QU8lCjNn1jsxbuMLj1toHRAHes
	3WbjpPNrBDCyAbUOoO5+ncMuUxsi5a05xwe1WaVNqLyXI5wioJitOfDicGIT2PQ7DXs=
X-Gm-Gg: AYBFou2XREoG1rrGmeE8y1V9YVazlbrWT01CzYgig1kEf2Nk4+lWoG4cQx8BbYhsLxf
	2kFttWpU4IL2cDYwdEh5qPQks5UDfKsJWWm2SQuwQO9SK3N7iWQPRAmY6961pHEX/ey4x8uhs6s
	oogBIOPrwVTofPqdRXqL14Ij7/OMQelwfJTYAt9PC40NSBS9g2tRVyitM0wTvSjP8yhXDShjrvH
	IT8+RgeoxECikF42l1KkwDwDqAqGtl3ZVs+t9UuzFBV9/THBr3kPTi27u/OXjF/Mma4i3mwKvLG
	0FKd6G+OxEyzi61HYzFFJ/OCjmMoYB5r3m93TlYFX0RpbrqaYd+FXmyAoZfVHrdOJ7rwZfwho6J
	V1nwJHcD6n9D92Ib5vQfyra0WkL25mYUI4v8+Lw+Xq3Nyw5A6PPMoH46c1qWW64FogI/msoM6vq
	rns3c87+8yOkwTM6rSL1FYyOx/mv4afcKKjFEAkQTMLvuoPF67/9YmgqRhql4pnNnHPAYPTvf1i
	OxfRMkJrTKn7Vs8gS1PYRK8PYLz5SBgYv60iL9JARHs2ulUrfdI/pNmxTSX6LIP/2pS+nwhOkta
	qJvfAA==
X-Received: by 2002:a05:6820:4c85:b0:6b8:ce67:77d5 with SMTP id 006d021491bc7-6d43f2c4594mr4166546eaf.13.1790299409320;
        Thu, 24 Sep 2026 18:23:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e97ab6a7sm1149038a34.22.2026.09.24.18.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 18:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 03:23:27 +0200
Message-Id: <DLO069N8F55X.3AC0XSELJEC43@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 0/8] bpf: Fixes for may_goto, insn patching and
 iterator loops
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>

On Fri Sep 25, 2026 at 1:31 AM CEST, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Fixes for four bugs in may_goto, in patching of insns and in
> convergence of iterator loops, each followed by its tests.
>
> Patch 1: arch_bpf_timed_may_goto() on x86 computes the address of count
> and timestamp as rbp + offset. The prog with private stack keeps its
> stack in r9, so bpf_check_timed_may_goto() reads and writes the kernel
> stack, where r0-r5 have just been saved.
>
> Patch 3: [ST, ST, first insn] that inits may_goto count and
> [nospec, insn] move the insn down inside its own patch.
> bpf_adj_branches() doesn't look inside the patch, so a call, ld_imm64
> of a func or a jump that points backward lands short of its target
> by the number of insns in front of it.
>
> Patch 5: may_goto is expanded into a conditional jump with off + 5,
> off + 2 or off - 1 stored into 16 bits without a range check.
> may_goto +32763 jumps backward when it expires.
>
> Patch 7: states_equal() matches ids through idmap, so the loop is
> assumed to converge at bpf_iter_*_next() when the iterator was
> destroyed and created again since the old state. The prog that never
> ends is accepted.
>
> On x86-64 without the fixes may_goto_priv_stack, may_goto_far/32767,
> may_goto_far/-32768, both new tests of verifier_may_goto_1, "nospec in
> front of a call" (unpriv) and four "iter: remake ... jump to next"
> tests fail. With the fixes they pass.
>
> veristat on selftests, 5477 progs: no prog changes its verdict except
> the new "iter: remake" ones. Patch 7 adds insns to 16 progs that
> call bpf_iter_*_next() in a loop: 11010007 -> 11011495 insns in total,
> test_copy_from_user_dynptr 342 -> 470 is the largest in percent.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>

For the set:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
