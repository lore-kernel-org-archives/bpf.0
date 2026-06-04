Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41B3C060E;
	Thu,  4 Jun 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598726; cv=none; b=G4S+zC3mpj29LzyPZ/fAg3cELacV9RFeBa+jkNbh/Gbj95tGqeXhSYkXx/VwVL8S5s3NDqvkifhz6Wcl7hBc/3lUMI7Y/kM9gq9P29K+2QP43PgkIyMqOMzwiDlNCwURM7f2Am6fRuodz+NakjUp7r8Lawx6v0BvYBWr8S7TzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598726; c=relaxed/simple;
	bh=2ds79YEit2vUJCVmdQJzL81RQBBAOfGi+oe7wahfRP4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hGRD24w63OXRZ04nuQOZSfTH/Bugds4KwBa1JRH5wWBHWaWpGCG+cG0RYuZkYkZavAqGhpDthxWZwX9nbnK0dd9M+qBFIRnm2Mk6k3pvF37hDQJq4BxFEyCNhJ8t+CSSXI9+aQePcQlQRr+xwOV4L0U4MxkR1PjLHM2vIezxv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOF5ELDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOF5ELDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDED1F00893;
	Thu,  4 Jun 2026 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780598725;
	bh=s6UFE8zgUTto7o+HPCxPadggpF3obHhn/34Pfv8hwYA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fOF5ELDfEHeL3SnkkLmi54tRZDKMJqEA/fcO0yLjJUETLb3ioq4suOOGdebUwdBKv
	 OmXFw09q/Gq8XpJ3eEcGx57Y3SbQEkdeu7rre9Y6oeuRCJ1ppvCzb+5pIBhyGFWH4e
	 pwoL1c/JWVq3xZj1qRehpPUHajB/XKnBaYozlNWbFhxhhSFoQKoqkjEayB95jrtajo
	 sNU0niokDrJAWpAnkB3DugHXkMdpDb5E+xHUY0dUNuRB0ynZ+Jrp3cUI27ZPOxkuYX
	 lD634xf5l5RHGYOz+D3nGNts4VyI4XH2ycbtfqdIZMZl1/gLzMDVM646mo+4kHkvo1
	 i+L/TgR8nRlZQ==
Content-Type: multipart/mixed; boundary="===============5913587305999243382=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <135018da09cfb3917b44375504f8030257b0aa8aeb649f57c96ae2b8e81885db@mail.kernel.org>
In-Reply-To: <20260604180730.2518088-3-gnq25@mails.tsinghua.edu.cn>
References: <20260604180730.2518088-3-gnq25@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add tests for PTR_TO_FLOW_KEYS constant offset bounds
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: gnq25@mails.tsinghua.edu.cn,eddyz87@gmail.com,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,shenghaoyuan0928@163.com,tangyazhou518@outlook.com,mattbobrowski@google.com,emil@etsalapatis.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 18:45:24 +0000 (UTC)

--===============5913587305999243382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: add tests for PTR_TO_FLOW_KEYS constant offset bounds
>
>     Add verifier tests covering constant pointer arithmetic on a
>     PTR_TO_FLOW_KEYS register, which regressed with commit 022ac0750883
>     ("bpf: use reg->var_off instead of reg->off for pointers"): an
>     out-of-bounds offset introduced as flow_keys += K and then dereferenced
>     at insn->off 0 was accepted, while the equivalent flow_keys + K direct
>     offset was rejected.
>
>     The tests check that:
>      - in-bounds constant arithmetic on the keys pointer is still accepted,
>      - an out-of-bounds offset introduced via constant arithmetic is rejected
>        for both read and write, with the same diagnostic as the direct
>        insn->off form.
>
>     Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

The commit message names the commit that introduced the out-of-bounds
behaviour these tests reproduce, but there is no Fixes: tag.

Should this carry a Fixes: tag so it is backported alongside the
functional fix?

  Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")

The accompanying fix commit (89ea48e0ec4c) already carries the same tag.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26970818032
--===============5913587305999243382==--
