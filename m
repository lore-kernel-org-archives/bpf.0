Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BB3909BF;
	Sat, 13 Jun 2026 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345323; cv=none; b=rLpyo9f9l2HsR1NXE6BkZiCQ28FMQdD3wB3AAenI4QjBQ5TzPPqQwRREhVtyp0uziQUIvZ38RKrjmo/L+hrgwN2K5TM7ug5GDR1TSzDBxsoDugZv0WdN8EKIRT0cnqTRQ4gbsIBADaGQoQ4jA0PzX2t/zXE18lbQuyX/z+Z2Ro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345323; c=relaxed/simple;
	bh=Ef7HNdyDPLgfCtHo4DIt+8/moiePaugDe16TPlsY72I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f2MXm32jsvcrUHub8jj1awXuiKte5ZSXuNu6dYjasOBW75C4a5AbugHk6283ZCDogtOPlGZnBBI3A+V4xG9CKdE4z3ewJuxl2Uz+C/MuR8TNw8y/8vxqDt8WJnBe4dq0mcMKvR6ZQw9dcyczd8ZsMIAmEypW/c9Tie+miAdvX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osRuQIup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osRuQIup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACF91F000E9;
	Sat, 13 Jun 2026 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781345320;
	bh=KfcA7WfRFlSvgpvh1BSvxl9MDGfbCusTyhMTRDnX370=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=osRuQIupp3vQ3pQgZdUZrM3B7uXdK9KVsD40ZVR+hBcM7yLkKzROibo5KI4whWayR
	 wwEkEURZUQhZ0N1mBnHUdWt3WmJW6s5Rb8aG2k/xKn8q/lAz95jbeoi38jbdcD0m8Z
	 3FpzNOANtSSotSkdU7iUXTY6lIcAH8uDhx54RlSboKNrdy2AtQYItERFGHUMGN95Ox
	 R/UwYibnTJ+qYH4SycOduvCn5j5zVlTEZYZ76xCYao/HQh5OwAPJqM1M0ozVf+m4Ia
	 Jwb8kvhegmVpxAO5PlcSVFu2wwkZQpqYN4Xnd9ulJQQAc7BAJl6H5/p6xpCGpqxmQW
	 QwyxwIJbEl7Aw==
Content-Type: multipart/mixed; boundary="===============7171513845860102744=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f0385494341533e89742d110b6d3bc34e50a06de8a9f1c3c0d4e699836aea283@mail.kernel.org>
In-Reply-To: <20260613-f01-02-gotox-bpf-next-v2-send-v2-2-ff980bc5a329@mails.tsinghua.edu.cn>
References: <20260613-f01-02-gotox-bpf-next-v2-send-v2-2-ff980bc5a329@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add cross-subprog gotox target coverage
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,a.s.protopopov@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,gnq25@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 13 Jun 2026 10:08:39 +0000 (UTC)

--===============7171513845860102744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Add cross-subprog gotox target coverage
>
>     Add a gotox regression test with two one-entry INSN_ARRAY maps. CFG can
>     model a map whose target stays in the main subprog, while the verified path
>     can load a different map whose target is the first instruction of another
>     subprog.
>
>     That second target is outside the subprog that contains this gotox
>     instruction, so program load must be rejected with -EINVAL.
>
>     Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

This looks like a regression test for the cross-subprog gotox target
behaviour enforced by its series companion "bpf: Enforce gotox targets
against subprog bounds", which carries a Fixes: tag pointing at the commit
that introduced check_indirect_jump() and the gotox handling.

Should this test carry the same tag so it can be backported alongside the
fix?

  Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27463372471
--===============7171513845860102744==--
