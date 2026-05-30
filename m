Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1E2EF64F;
	Sat, 30 May 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139498; cv=none; b=mn6ov1zlwfdUfQLHMKAAP76stZiE+OvtqxmHCVzyZHtIy9sfxjb6bxy3h8+qzonwZpKsadxsLas5+as1NP6mVVLk+JybCiEHeYuN7PRKXRKeebTlOFEdUHBJsXovGBOctMNsuUv7lgtfsI9ZZbCxEK5aQVQ9vMvMHAFg2yAyBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139498; c=relaxed/simple;
	bh=Vys2srw1oFInm5APZykGPvb0hCeNIhSRypm04Sq2DsA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EprezgU1sHaK99KCA5uOCan3pX0YFg3sGIrNwra3fBbVmO8eLlyKj1o/q7R5rSmq1RGezrQR/wSX4b2ititEZ0ClyLpSXgoYIPBFDN4K7EBU/CKzdj4fBHJXNOxuLpAs9KHqr2pkklUQsnYUFg0W2qCehFGHDVhN5E/U/oRym2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NryZrZqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NryZrZqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F5D1F00893;
	Sat, 30 May 2026 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780139496;
	bh=aUCqN97Z0WotB2chdux4sDOfE+nHhw+6/dwGZVRYDw4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NryZrZqqnJ5zXkCegisMXnjjKV0D+PvuTq34ac+KQgqYztCCHnpbZDTrN/pRQBUWg
	 Q4ExaZF2ZkaJXoe7zXYeiEzIX2kzqNa1e7SgrI6DI1C1VH2NuHq1RhEdwCy5Tw5+hR
	 CZ9S3ehB5TC0PzeRctphnP3t3Rc4e/ZiOai68R+bocrAOd75E9JPmQ+xsd8HAc6c32
	 awbzt2qfsujDHaagXRWHd4wvfw+igFb0TkeKyjSBjuHZsl2vQG8g84Ox7QPwdEShBg
	 N7Ss76MczMDfn0tb/3Al4J/5E4WKW+UgOTQx58/vdFyZiimzhpRnebjyK3QR+K5z1O
	 mZu7MiAeiNhzQ==
Content-Type: multipart/mixed; boundary="===============7405546643935907777=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <999f99d0095c80b00418de51572f1d17cc9408b067f86712a2ab77945f5225f6@mail.kernel.org>
In-Reply-To: <20260530101239.590395-3-xukuohai@huaweicloud.com>
References: <20260530101239.590395-3-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf v3 2/3] selftests/bpf: Fix cgroup bpf tests broken by bpf_set_retval validation
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,sdf@fomichev.me,zhuyifei@google.com,mattbobrowski@google.com,2022090917019@std.uestc.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 30 May 2026 11:11:36 +0000 (UTC)

--===============7405546643935907777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Fix cgroup bpf tests broken by bpf_set_retval validation
>
>     Add explicit return value checks for cgroup bpf progs rejected by the
>     bpf_set_retval validation.
>
>     Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

This looks like a fix for tests that were broken by the bpf_set_retval
argument validation.  Should this include a Fixes: tag pointing at the
commit that introduced that validation?

  Fixes: 6792560b9eaa ("bpf: Add validation for bpf_set_retval argument")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26681787206
--===============7405546643935907777==--
