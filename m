Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BCB30FF1D;
	Mon, 31 Aug 2026 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172247; cv=none; b=Z1QO6DEw+giLVfE7IQe1R5dIEjxsVsAy0kFfBx0Ex23t8WOGd04/dvEOWb0GkAoiG55It6Uz8ttKAQrrWBomQeCuLEn4OwQyvK/SlO43ZYdh/bYBP380sDicHqqCZCfHbnyyzVdGDuyfJJ+KWLuHf+ZTpTTXLcd2RGN/TQUYESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172247; c=relaxed/simple;
	bh=iFnYzcxPCUETXVhNBv+KM8e+EYfMN+vUAWIUun1HXzo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WIm8U4X8SPTCgaV2e40ss+T4P96bA6H55E9ejO1vt0erkye0Ym93QzLRwmAdFh9BuIjBbmr/d99TSuPiOWj0cYx95AopylgU+R8M3J1l6F2sUyaV52tKEch2v3E15A918Smk4ryrVoHmo7uHwwGwEboCTE5R7LzQ3n2xoO11F9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUKxJxVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUKxJxVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9181F000E9;
	Mon, 31 Aug 2026 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788172246;
	bh=sMjEOiR4aoFiJu+sj3qn4Q9Lswnv2I+gPsZQbwsoA1s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hUKxJxVYNSHxP6iBrkoe0/NqtQ9zDEnnrIPIoGw2JbqBCLTbGpFzvl1WG7nO6avAP
	 LSQ5fmE8Wf/YBWTZ0mNSKoZp9ylCxmJLbRgvaDN3tb82RwkunKwnS4t/qlLb1ubWGm
	 Waq0ODq0fAFJzLni2dVt44/oZPkpmU0QOt3d/HFbzBSlqoPLp4PNRQkrywj2WLrPEX
	 WGrkP65uxzBQZb8g7HqzdSEO0avlczOtKeYBKS0Pw4k27DdRwPGFDv4bvL4QWxKWQa
	 AI/iXuWIZ3eg34J9CF+WGYNQNGBi0rO9tG08PasoubNFUtRRYSn2vYZOA/mmASfj6P
	 hnZQvg1beBKgQ==
Content-Type: multipart/mixed; boundary="===============5908284071656517942=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <27ef653d703dedfccac377609bf32e8bc15ef63260463f19adc8e05e332a555a@mail.kernel.org>
In-Reply-To: <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] exec: Clear bprm->mm before dropping its reference
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,utilityemal77@gmail.com,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 10:30:44 +0000 (UTC)

--===============5908284071656517942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit d3633d366b08f6123fe20f3fd64fd2a8c5f6a5af
> Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> Date:   Mon Aug 31 12:23:01 2026 +0300
>
>     exec: Clear bprm->mm before dropping its reference
>
>     Once mmput() drops the final reference to bprm->mm, the pointer must no
>     longer remain accessible through struct linux_binprm.
>
>     The successful exec path and the bprm initialization error path already
>     clear bprm->mm when ownership is transferred or released. Do the same in
>     free_bprm() before calling mmput().
>
>     This is required for eBPF kfuncs where bprm->mm is either NULL or points
>     to a live mm_struct to ensure safe access.
>
>     Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

This looks like a bug fix. Should this include a Fixes: tag?

The dangling pointer bug was introduced when eBPF kfuncs were added that
access bprm->mm. At that point, bprm->mm needed to be either NULL or
point to valid memory, but free_bprm() wasn't updated to clear bprm->mm
before calling mmput().

Suggested:

  Fixes: ef5769fc8b1e ("bpf: Add user memory access kfuncs for mm_struct")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33379004067
--===============5908284071656517942==--
