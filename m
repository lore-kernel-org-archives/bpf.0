Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E337DAD0
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885910; cv=none; b=mZB0gb9RDhuroM/159pGzGmwmOcvePtI97N2b8J1McwW0aRF+VSKpfra3q3E3nUigkpImfEjCquKWhSarMb9xS9rd2Xt7fpgHWdV8kT6+P8w2N91Q9y+Y6dXnHr3PK5kl7mzsdh1GJaRzt6s0Kf4FmOhQO2SIDVuQSNC2W8VPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885910; c=relaxed/simple;
	bh=z7FMxZ0GKpYrxLIT+LCx4bBotGtIKj2s2B47NKOIF8I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K2u44YmvXubwf8K1yPi0dOpSHi26Wysd5SxKCubLn0HaqNhrkJdvZoierMNmoMVmZ2Ql68/Cjr9phS8IqVeAB1awOzv/fCuvD3n9VeS3y8Vz/7d2AKjXCXo4VBGd0uXXjfeWCHEc50084jZhNJQPcIlIlgOcm38JR9WlAmqAroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWsF/S5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWsF/S5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E6F1F000FF;
	Sun, 20 Sep 2026 06:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789885909;
	bh=z7FMxZ0GKpYrxLIT+LCx4bBotGtIKj2s2B47NKOIF8I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FWsF/S5jrsWbwfpVZntGKbNxbpk1vBzmBIqJ1ZVvKmCm6uwOhyUNNSISatPTp8q+F
	 q5zOmp8kEHjcas/74DwhSMk8fdbu2jAcEBLDFix1N39mBd3zeA38LGGftOqlOUQjTi
	 zTWAUaQVYoxaCg6goaI2lBTlOgvFMz0lUUYdUu0rlo5pNgAJjD6YXRte1ZUWFqTpUT
	 3EiB/VcaDZtFIZFgQejZEUO93n+UiuP5lPNzD8lD1Z2ccM7FMNz2fbTQtrwVzFAiBZ
	 BA6ed7AOpclU4ze2XiW+Hi7VemowdGpGunrPjPFkshkok5o/UbRkj9UO2TIEJBSNzk
	 rV6JcjR4RMg6w==
Content-Type: multipart/mixed; boundary="===============4229336892632586680=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <16900372d8d1bf2968c1cc9d6d16790243368ac169064fb9cdd6e90264e63bf9@mail.kernel.org>
In-Reply-To: <20260920054337.871564-1-yonghong.song@linux.dev>
References: <20260920054337.871564-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 14/20] libbpf: Add cleanup_info to bpf_prog_load_opts
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 06:31:47 +0000 (UTC)

--===============4229336892632586680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Let a caller hand the kernel an exception cleanup table. Extend struct
> bpf_prog_load_opts with cleanup_info, cleanup_info_cnt and
> cleanup_info_rec_size, pass them through to BPF_PROG_LOAD, and grow the
> attr size bpf_prog_load() computes to cover the new fields.
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This isn't a bug, but would it help a future reader if the changelog
noted that cleanup_info_cnt is the last field of the BPF_PROG_LOAD attr
struct, so offsetofend() on it covers all three new fields, rather than
restating the three edits?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538
--===============4229336892632586680==--
