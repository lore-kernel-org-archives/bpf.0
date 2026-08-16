Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338C17D6
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786847457; cv=none; b=f49xdEBIglBj59MqmH4M9qvil+4K7poxsJP9bq9ah/LDajpAQpJmycfrao1NPrd3vAoOUbBhI8/fL46B+N5Jc6Zh6zgEPFZDBQOawdltQ2q/5FwjW/C7ow/4fqSAH++tseDGlhFFm72WGEqNGZmVNeA6CCXxEysrxHfyMxdCy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786847457; c=relaxed/simple;
	bh=xnGHBE6fgsu0FIdGMz0V/2S66B+5mPZ7lR5V51OJxZE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H9D8xLYF8av+cWQsPIOQRR2SZWoxdJDEK+oW/MpPb+xm5/UNIorKKfryPjbHM4Zh7HH9JoJ2YiPX2Lzup3XNxvhvhDxcGYRFtr8izD2s2fLcvuoxuzlcnUZXepdxQFPoyCOs2HsgHLouZm/6mn33iymrnaY8wpjFtZTQN2a4O+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6WgFNLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6WgFNLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D401F000E9;
	Sun, 16 Aug 2026 02:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786847456;
	bh=xnGHBE6fgsu0FIdGMz0V/2S66B+5mPZ7lR5V51OJxZE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b6WgFNLJPdLBgdICFIO5mVNz2u5iuYgMpdieaCWl/d1KLE6OVsp+XNLcxaxvZbAj1
	 4vysnC8Z+ebyF7WUQKC9HAyAqknJ3kZgt5rXYX+rPw+Pgle4xLw9PNfW1P3E6mBmid
	 iaHJS4RWUB2HwYu6SzBSdNI1TRwABnxwgDktXJnXMH5fmtY9Ge3SD7s1p1KkibExMC
	 3U9PkHWuZY/zZiKlxIp/jSt1eWz/t3YQ2jEJkNeUiAS2J+SuAHi5cU5d1uFFE+TYMe
	 IBCdYMRh5IClQHoi6HNysrn1QL/9R3Y3LEHOpyq3zjh9C2EZpMvPzSJRpAkFVt26kz
	 mwHdDU1tbagQw==
Content-Type: multipart/mixed; boundary="===============6462811390789355340=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <efa4d56d82320fdad512a4a2f01e26b9c578962cfe8f525c3887ef5b5e5f9625@mail.kernel.org>
In-Reply-To: <20260816015746.2632990-10-memxor@gmail.com>
References: <20260816015746.2632990-10-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/14] selftests/bpf: Test non-sleepable kfunc context
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 02:30:55 +0000 (UTC)

--===============6462811390789355340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test non-sleepable kfunc context
>
> Exercise a non-sleepable tracing program that enters an RCU read lock region
> before calling a sleepable kfunc. Assert both the legacy verifier message and
> the structured reason based on the program's sleepability.
>
> This distinguishes the program-level rejection from the later check for a
> sleepable program calling an operation inside an active critical section.

This isn't a bug, but since the previous patch folded both diagnostics into
one site in check_kfunc_call(), would it read more clearly to say this
distinguishes the program-level rejection from the in-critical-section
rejection, rather than from 'the later check'?

The wording reads as left over from the pre-unification code layout and may
send a reader looking for a second call site that no longer exists.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31921026518
--===============6462811390789355340==--
