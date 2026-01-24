Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFC1D8E10
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769292397; cv=none; b=E0SojkbKHuqXKh/fyfLZYAAjxM7lxoQpPsPaAsevkHo4KqwFeuH8fR0UmJR3EbaA5ryw2075rHvlXQMszPPLjLI7Yr3fFa6LV+abR+AmRIqQPvRaLuzNiqfLSAAkAdDAxchQSOBqRcts78GYKZmAuWHy3NX4xZeQd44aD/ZUWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769292397; c=relaxed/simple;
	bh=vkpxmbmuaiTWvdXHvuAYpmCiErxqb8VPU01lWCjUVQI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nrhZM9BLt8vUvO1oG7XCpgZFUv2bkiInLKVd89LrTLGfBkiTZleJ27OaT7m2xo7lf6bdVbNLXckSQdN1hDKOzPus+0Wxots6ZE0+3VwtSVLmPAtcWGkP6QdQ0WQv0MLoLfOR7Ize9YXvG6kXR0mzNdywT0DluCa6TfrRU6JSluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foiHjP9o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foiHjP9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E3CC116D0;
	Sat, 24 Jan 2026 22:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769292397;
	bh=vkpxmbmuaiTWvdXHvuAYpmCiErxqb8VPU01lWCjUVQI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=foiHjP9ojD8ywXTlSLfcMxBlfGRJLnj9RXr9rlgWuHHwVGbhMQ9ko91s3OmFWC2nH
	 klpCIGLld/iDxTh+2hdJ/37UrWEHy4NYEEZUb+GPTD8210P07W7IFSbJ+i/EvtN4jQ
	 gesmuSl3DestAyhmV9eASQKSBUgeYoKWI/PBMDZfdEC7JJ1C2fODM1FW1S+AWv+QkM
	 wb91RYHpkBv+lQqgA2m3jvyR+q3zPv6+mMGN2v2w66NlwMyZJxZvJ/ykIeiSzo61Tl
	 rqT9b3U+LjrlXV+6oqA+SbBlTrvuBDFZdnPwRN498zMln+25nlvPgz8/Puh7CgpFzv
	 T5xGcg7fp2JNA==
Content-Type: multipart/mixed; boundary="===============1309223923921375145=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ed5de41435db72c9be60adc9238f612e3ce87e594bd5a3561a7524c3021dcfe9@mail.kernel.org>
In-Reply-To: <20260124214328.185113-1-ggonnet.linux@gmail.com>
References: <20260124214328.185113-1-ggonnet.linux@gmail.com>
Subject: Re: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD isn't given
From: bot+bpf-ci@kernel.org
To: ggonnet.linux@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,ggonnet.linux@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 24 Jan 2026 22:06:36 +0000 (UTC)

--===============1309223923921375145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit f4c6314e5e1b2eb9762846d92b6a8169e25de6d7
Author: Guillaume GONNET <ggonnet.linux@gmail.com>

bpf: fix TCX/netkit detach permissions when prog FD isn't given

This commit fixes a security issue where BPF_PROG_DETACH on TCX or netkit
devices could be executed by any user when no program FD was provided,
bypassing permission checks. The fix adds a capability check for
CAP_NET_ADMIN or CAP_SYS_ADMIN in this case.

> Since c8644cd0e, BPF permissions are indirectly checked by having a
> program FD or bpffs ACL. When using BPF_PROG_DETACH command on TCX or
> netkit device, it's not required to provide a program FD. Instead, the
> program can be specified using a relative specifier (eg., BPF_F_AFTER).
>
> In this case, there is no permission check as there is no FD involved,
> so any user can execute that detach command. This is problematic when
> BPF is used to filter out packets not intended to user as it can just
> remove the filter from the network interface.
>
> For this reason, require CAP_NET_ADMIN or CAP_SYS_ADMIN in detach (only
> when the BPF program FD isn't provided).
>
> Signed-off-by: Guillaume GONNET <ggonnet.linux@gmail.com>

The commit message references "c8644cd0e" as the commit that introduced the
behavior being fixed. Should this commit include a Fixes: tag pointing to
that commit? This would help with tracking the bug origin and determining
stable backport scope, particularly since this is a security fix.

Suggested addition:

    Fixes: c8644cd0e??? ("<subject of c8644cd0e>")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21322248996

--===============1309223923921375145==--
