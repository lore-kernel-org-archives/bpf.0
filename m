Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540067;
	b=zgaLKS16Uln/+R+3w9ER/oJhw4QmAi6bXNpQoT0CRCfSH3zcMqnvCnXUrq7of+cyP1Dv
	 RuTUyZaTg5mE5dMWufAi1cjKyANOAVZidCImlPAh9ly5bUagBId1kme0RiPJ40Hq+qrfs
	 7ayEzuPo34D/oS4B7jpdV8RsAl58QBupjpOPN1HFZixkHC0aSY4kVjA3cSmd1mEUmglAt
	 YvWnDgR9DVrYlp4EbfU8vKi3hmFT46NwN/EtKOhtSHgddiuyQWgichuCB5/OSpb8EpGQh
	 Q/efyyv3JZB+L10wM7e8tMy8AtparX7irPgPFecF6FDfFFgJoG2rdVc2V+5zaP/y+kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540067;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=nBJkOQ2q2zXYUFL1OoXZyx/MF8UrYnWwNyMJqNuazjo=;
	b=JMbjqW6DCB+OTXi4xNk58VGx0yIhTuqz2f5CTLDJiS1kn4llTuqwpc6Xx43WRFpeAbEO
	 qWkC/29R0U4ltq9xP2fzOkpQhM8OVk+X2o1WRzmWFSbvDyj14KlqlgthEJICqq840dSF4
	 b55ukYblqlV9QPVBhc8poLSZNtlk2d2ooxg7iw06UKk4B3cEIC7nkKX6CkCZC8WoM3l2C
	 GG09SA9ngX0AB0udK/RCqMLWq/Dfb/i+sEjrURuQNVRJPoTvaVrBiUV3txsmDoE0a6oi7
	 ojcn55vLTwlsiUQyr9eosI9+juNX3yQQ/zY6S3kWmmSPVpG6S9sKNt9NlSyKhOGRyKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdHvpMVO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFC606A321;
	Fri, 13 Nov 2026 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdHvpMVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3FB1F000C4;
	Fri, 13 Nov 2026 03:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540067;
	bh=nBJkOQ2q2zXYUFL1OoXZyx/MF8UrYnWwNyMJqNuazjo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CdHvpMVOGwgKWscIuQ8A3utOk5wIvk9pNV3isIPQKIVvP7qZLeQ09PPM1jl4OCfW2
	 GnUpjRI1szJQFZaPeZ4oPKHZjBrS9FnBX2IOPHP4Ds5ua/kdAc3nbEJBMTCESILE/6
	 EKNPtRM+cn2/pwdfWkcTyAUB2a4PHTgFazJuX+2f+YdI+jSzMkluOoza4b7UIf2Em+
	 6f4fUNzWKC4IjewaQSSmLyvjaZUE8eCur7GUBd/ScTZPZo40bSv/0KAbSPBoPbC/fx
	 kVa86sjSwKHykASdtIzY1XVv4hjnOLJOg2EhiGyJfrtzJsmYEKscZY/ABX3CXLdAVt
	 XLyxF1OnKFCYQ==
Content-Type: multipart/mixed; boundary="===============5694792853191233504=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <964189cada1029ecd88ceace91964d377836638fc7796c40636426b1d2ccbe00@mail.kernel.org>
In-Reply-To: <20261113024447.922683-2-k.chen@smail.nju.edu.cn>
References: <20261113024447.922683-2-k.chen@smail.nju.edu.cn>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test that a drained dmabuf iterator keeps returning NULL
From: bot+bpf-ci@kernel.org
To: k.chen@smail.nju.edu.cn,yonghong.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,tjmercier@google.com,sumit.semwal@linaro.org,christian.koenig@amd.com,phasta@kernel.org,linux-media@vger.kernel.org,dri-devel@lists.freedesktop.org,linaro-mm-sig@lists.linaro.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 13 Nov 2026 03:21:05 +0000 (UTC)

--===============5694792853191233504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test that a drained dmabuf iterator keeps returning NULL

TL;DR: Commit message only: the test is credited to T.J. Mercier, but no
From:, Co-developed-by: or Signed-off-by: names him; the review asks whether
those tags should be added.

>     selftests/bpf: Test that a drained dmabuf iterator keeps returning NULL
>
>     The BPF iterator docs in bpf_iterators.rst specify that the next
>     function of an open-coded iterator should keep returning NULL after it
>     has been returned once.
>     Add a subtest that checks this for the dmabuf iterator.  It drains an
>     iterator, calls bpf_iter_dmabuf_next() once more and checks that the
>     result is NULL.  The dma-bufs the test creates keep the list from being
>     empty, so an iterator that starts over would return one of them.
>     The existing open_coded subtest uses bpf_for_each(), which stops at the
>     first NULL and never calls next() on a drained iterator.
>     The selftest was originally posted by T.J. Mercier in the v1 thread:
>     Link: https://lore.kernel.org/bpf/CABdmKX09vLG4U-7FwF-vm_iTy1AjGUPXka08KhWE+qJ0J=XGMA@mail.gmail.com/
>     Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

The changelog says the selftest was originally posted by T.J. Mercier, but
the only trailer is the submitter's Signed-off-by.  Nothing names the
original author: there is no From:, no Co-developed-by: with a matching
Signed-off-by:, and no Suggested-by:.

Documentation/process/submitting-patches.rst says Co-developed-by: is used
to give attribution to co-authors, and that every Co-developed-by: must be
immediately followed by a Signed-off-by: of the associated co-author.

Should this carry Co-developed-by: and Signed-off-by: tags from T.J.
Mercier (or have him as the From: author), depending on what he agreed to
in the v1 thread?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43356758506
--===============5694792853191233504==--
