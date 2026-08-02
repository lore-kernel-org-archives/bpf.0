Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C035966
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785630931; cv=none; b=o19dJ14UKqGCq5CKcRMXk5pRJqKYMnFCw+ruCXJZB5Tq7sGPoHalCJ7DW4Foi4CzQgi/egN/mbIvGpAV7xK15LJBKJLUjczNVCK9j6NnvEE76Yp04/Dqp41HVOCNEZnFMayziYmULKZNRMpeKkM4uvIyamK+T11ariohsNwCIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785630931; c=relaxed/simple;
	bh=jBANdLZovRwxDpHB4Wsy/dBzDoJ7BCyAg5rcyYtuYZM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LXR8GbVOrRzE790yrmZIL7CmbfwwaTKoV5TZll5w4KqPGKXsY+NkNtIjhyAcqLAA5NQyqK7UDTzQSjC+5Jm6+xkTWbEVPr4lwNInMfgcwJv7zKdskyRIfVpCvRlgOVoxViwUgzn/a0jrkvzqNo2Y3wiLWP4f2ZMXCRbQBk1QssI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7c1JR8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7c1JR8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD9E1F00AC4;
	Sun,  2 Aug 2026 00:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785630929;
	bh=jBANdLZovRwxDpHB4Wsy/dBzDoJ7BCyAg5rcyYtuYZM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K7c1JR8GRIPd4dJXzR9hqICkR8Ikp3ekDab9PwnnwW8HpZriPur909A9jqBdkwp1t
	 etQJi/T6idqFl7hM+VJqHQdlRWsnDarPACGn1g7ySjEgSKpvXMd6pIu6nDiLj95WMD
	 xbi9iL3xG8i+keFP3bCYZeKV658gM/eMUH8jYnrc9BKSqGWVRMN8gWiywT6DOy3MBO
	 LNvmtWozJaVibDxqptYnO8hb0v4z9b1FtIx8ibOoj9vqdIGtDHvE9jDYVHgBpk49Te
	 jZcbK/A8NB5xKBdjpcRtfCsj/PBV/G/fmVTmzkQaO6g0LJxmHCc3qYHhP4Rj8FKWu5
	 RkLicONYu1RMg==
Content-Type: multipart/mixed; boundary="===============6590588458749993319=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7774125f64e5ed29193b1307ea349e8a5b9ea9b4f84d0549e00670c511630e0b@mail.kernel.org>
In-Reply-To: <20260801230400.850271-2-memxor@gmail.com>
References: <20260801230400.850271-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Show more useful info in stack depth stats
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  2 Aug 2026 00:35:29 +0000 (UTC)

--===============6590588458749993319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Show more useful info in stack depth stats
>
> Currently, the output of stack depth statistics is two crude, with a
> list of captured stack depths ordered by the subprog numbers. The actual
> subprog numbers are determined by libbpf, hence it is hard to associate
> the stack depth statistic back to the subprog by name.

This isn't a bug, but there's a typo here - "is two crude" should be
"is too crude".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30723212958
--===============6590588458749993319==--
