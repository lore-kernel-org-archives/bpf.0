Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE243F4101
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502186; cv=none; b=H5AF8ebeUABivPQvX6lYINsbSXcKjhCeKI2MXa+y12nqOADkM9MzRx3Pk0ojSVOjtlxOdreIkvbPmV53xHWThKphRn8E5DxDvHtMm0UdASiDoFapyKQxoCm95cSHigS2l8tTL7vwv2Nc8IokHgKMnLFG27whgGXJv8ZS7UyxVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502186; c=relaxed/simple;
	bh=JMCMr08O5kgiqFdIk8SOlm7t/y2o4z/NkuLwGZryd90=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=shqgkaaCYTJ30O99nZDB9Q74CS5O/GBCK3EhwAeu97I7UdYZS5tqEcTHrJ3W6uD+6bzgWUq4CVw9E1w90KbatHj+tRONbEnErv2cYQLTk+5QJH5zRNDfEeeX5wlslHw9p4h53h4bhjyOOGLTEjXdMnIYWLgoYe8SOSAoLA3j+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFEkXBNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFEkXBNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCA41F00A3D;
	Fri,  4 Sep 2026 06:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502185;
	bh=vvmTN6K+RCsxFGkRbC3po2Ao8vi4jSZhqALrJ4fLiSA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IFEkXBNcr3CyqJe8a8ssbjLY+uWvlNX7lkIfYNQw8MYQ6c3awr9mZanWmpTUAHwjJ
	 TX9Q8pvq++xzNnoz4HGOmrvd7A/OKKRZwOahTImhwIM23OA08fbS4rxLxHPWfNO1H5
	 tO3GIVJZgWIJmE5U/cfZ/ciJHA69v7Bvvisp3f1xGilXvkyjrpVpgu5YLyeIhPXfZU
	 UWAde5NdyPJrZh63qDoGU9/Iab6uErg32ykyaw4eOvKj4wN5fK+rl3coq6G8Dt9uR3
	 M7XUWovr0FidsEoFzMG4OjOx6AQDEfMs6QCiI+f0SAp89gFn/qM6dk6iu7ziF/DPJc
	 yQBsUIBJRLNPQ==
Content-Type: multipart/mixed; boundary="===============2881264667356630391=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <675f27ab87b96eefc817fc14ad5e696c8cb75fb2ca315a39a52e8fc04f523fea@mail.kernel.org>
In-Reply-To: <20260904051018.3978585-1-yonghong.song@linux.dev>
References: <20260904051018.3978585-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 04/12] bpf: Support __int128 as a by-value function argument
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 06:09:44 +0000 (UTC)

--===============2881264667356630391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Support __int128 as a by-value function argument
>
> A 128-bit integer follows the same calling convention as a 16-byte
> by-value struct: LLVM emits it as a 16-byte BTF_KIND_INT and passes it in
> two consecutive argument registers. So a __int128 gets its two slots.
>
> The test added at the start of the series, which recorded the wrong
> register map as an R4 !read_ok rejection, now passes and is flipped to
> __success.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for the multi-slot struct argument support added
in an earlier commit. Should this include:

  Fixes: c9bf7bb8555b ("bpf: Support by-value struct arguments up to 16 bytes")

The earlier commit added multi-slot support for struct arguments but
incorrectly treated all BTF_KIND_INT types (including __int128) as
single-slot arguments. A 16-byte __int128 should consume two argument
slots like a 16-byte struct, which is what this patch corrects.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551
--===============2881264667356630391==--
