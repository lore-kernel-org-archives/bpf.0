Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337AD18871F;
	Mon, 20 Jul 2026 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784520249; cv=none; b=YX56WErWz7Sc8mF6oNYtE4yHNSn5F9seC5gOjP9zhrtcU1BuEVGYpm1Zdk6Evh1BwtxQwLH/NP9BA0wDzYsIsjLCuA8B/nP6on7d2ymEHYP/PeGwqe/AA1M4WYS2aeQj1u4NDyoakLcDLw6ZW0bkh4CJ/NZ+jz9zlGAVxmboOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784520249; c=relaxed/simple;
	bh=oP3WewlBdDSfW+EQDfLF6ChmotNQb5KbxJEpptVq/ew=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Qi7g7wOQErzJbaKgJDRyZpTJ0ZOo81KAqqrn664wiYk3+27jRGaFWWrsXR/kAQzRg4RMG5LIjOTPf4WHjjATt7ZC0SvT7AwCtDUbhkhq941nCyY0oGJG4jPxPX7u6VOF5P8WEh6ag4Q8pftORmXnVqrd80vyKMZa4jyp1Jp4xPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlX9cIMQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlX9cIMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06611F000E9;
	Mon, 20 Jul 2026 04:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784520248;
	bh=nccPk4YJNFT8X3BEc8Ul9c7tvodmKm9bzqmxPfk6ydE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VlX9cIMQKD8BVF2J6v5PWiYRCEg1fwTdvB2mWG5xOrQp5s1iB9IlND+vpB345sc1j
	 5rwXe5+RpuRUaI0w1rpn7B9at6Mff6l6lm3FJETXEWq5X8SdT5y0bM0zv15ko729WL
	 xnrVhDBWRpIBPZyogiB/FLerlJbWWbx48QXl8Fcwi6gM9MMG5/EuHlw889tRlnWOIB
	 ZFuDGwBDLB3RNvq/uS7Bbnc61EI+2bDyDwhm1zWtdKYDmBjH/lPMYYYFz7ciclnGQF
	 QzzzWCxN8kNI7UWz8zRlnEnIQZw75B75soH3sjcntgJfSluhiLvJB97dpPXhilzl+u
	 HsSZp1wk4u8AQ==
Content-Type: multipart/mixed; boundary="===============5378695787097462599=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <27e047ceba0b38f4f51e932d9d256d280a4370fb66beca03ed7a3148b6600b19@mail.kernel.org>
In-Reply-To: <20260720033055.1215477-2-pulehui@huaweicloud.com>
References: <20260720033055.1215477-2-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf v3 1/3] bpf: Fix potential UAF when reading bpf link info
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 20 Jul 2026 04:04:07 +0000 (UTC)

--===============5378695787097462599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
> accessed without holding any locks. If the prog is concurrently replaced
> via bpf_link_update, the old prog can be freed, leading to a potential
> UAF issue.
>
> Fix this by holding both normal RCU and tasks trace RCU read locks
> before dereferencing the prog, as BPF_LINK_TYPE_ITER support both
> non-sleepable and sleepable progs.
>
> Fixes: f9d041271cf4 ("bpf: Refactor bpf_link update handling")

Is the Fixes: tag pointing at the right commit?

f9d041271cf4 ("bpf: Refactor bpf_link update handling") only refactored
the existing update path into the bpf_link_ops->update_prog method.  It
does not look like it introduced the ability to concurrently replace and
free link->prog.

The unlocked reader in bpf_link_show_fdinfo() already existed by then,
and the racing replacement path (the BPF_LINK_UPDATE command with
xchg(&link->prog, new_prog) followed by bpf_prog_put(old_prog)) seems to
have first appeared in:

  0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")

Should the tag instead be:

  Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29715011327
--===============5378695787097462599==--
