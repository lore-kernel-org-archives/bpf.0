Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891C3A5E8C
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651085; cv=none; b=L3rhnqMHozxeItH6eJ3N8Z2ET/MU8VTDB86xSJfeHsTGK6MOy1TbaQPjEcp9rSLdyINtLzALxb+eG8qzI1bEUmWtU5CBxbsyiycRnYwVLanmBbNQIH8DZY8e2oeZX0eDQ1m4nJE9BFR9cpPfYDX2cu7aDLK+EHufA+33KBtciRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651085; c=relaxed/simple;
	bh=B26UV4b6lTAI6cuwzTaxWlMN2utbEV6ereD5wywRjs8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pgigTZwxgQi85BBpdDvHUvNDLUILeYbm5PD5IvuY1+KvCVDbpIrJuI8HfShjKs0CB6i8FwjswIqfek4YUyCcNuUNeAVXyXGdQh/3Ab5myxM2FOHmDybiBvNI0U3q22+Yl3QVFxqQWSg4SeZBtX5sXDWmcRBIDG69DdQSyCnNp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMVDJCGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMVDJCGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B398CC2BCB7;
	Wed, 13 May 2026 05:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778651085;
	bh=B26UV4b6lTAI6cuwzTaxWlMN2utbEV6ereD5wywRjs8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lMVDJCGnoj/HersTfjRH6/sF8M6VvUj+v5t7VatZbvE+Bmy1Mta76tah2w5kXKWFE
	 WrvNPGJj/drFTJ5eoU7Q/CftAzAAZjcTMKijfLtFTgfQylmmzHmXzcdrOPY9jav1rV
	 1K8XSr34totGXUCpH1zb8hpPHpvIi776ESTOaQCkUZAQqBZbP2vwAs/mLPZw5a/+Om
	 XD3yFtdXMUwhovCCxvRF3QixkkMErNiBdBodXZCyz9KOOj8Bco+ycO7t/1aLtuh9pr
	 G0FceA1fa1Nlvcv1qd+Lvr3DJdpWVGZ1RC2XpzVHWs8gHPelIBWX7y1mg+JwosuZTa
	 gg9X7TGSq94fQ==
Content-Type: multipart/mixed; boundary="===============0749804477377072817=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <490fcdc3f72ef4c0d47a97f0fdec1d878f8ec61fa80c65e1a7bb12ccd98392fc@mail.kernel.org>
In-Reply-To: <20260513045025.2387526-1-yonghong.song@linux.dev>
References: <20260513045025.2387526-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 07/25] bpf: Add precision marking and backtracking for stack argument slots
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 05:44:44 +0000 (UTC)

--===============0749804477377072817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 8578e3b9e780699b52da3c2fdeeac2cfbc51f3fe
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Tue May 12 21:50:25 2026 -0700
>
>     bpf: Add precision marking and backtracking for stack argument slots
>
>     Extend the precision marking and backtracking infrastructure to
>     support stack argument slots (r11-based accesses). Without this,
>     precision demands for scalar values passed through stack arguments
>     are silently dropped, which could allow the verifier to incorrectly
>     prune states with different constant values in stack arg slots.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for stack argument support. Should this include:

  Fixes: cc06010ca1b8 ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25779371388
--===============0749804477377072817==--
