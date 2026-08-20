Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8A3DAC02
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262043; cv=none; b=OKeKj1Fmvn0E7HKFJZC0x/DPftIZMLagfRRs76jR2JNQ0LBsIpyDmqIioiLNBGowGsU/FcrK3/jFCwgbS6rD0VlSpKcEKDnJtiHp9HGNcCQ685MggmFyd2zhjxZAJtsoZKUbOCpQ2ls8bFA5DRAXMKsoTAMdL3CPAeQbZWrlkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262043; c=relaxed/simple;
	bh=o3Vr8uy4kqiUubFs+Nc4lPSWy98es7N1DJPNEXNGVk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E5BgFken+vqVtQPwCHG5mPtD3ZqBgFOtcgTBq2W1zkzgQdQJijg4LQSEZzwoLR8bT8AWm8dkaeQARqNKSYFABSrnI9uGPygkm54rO7gCx+8SOR0bUzGXVDBcH9txPTdpMl78jtwnwHIBia8qoQ82OVrPwYwjdR3rYu8R+Xvmvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTKDvI4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTKDvI4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19601F000E9;
	Thu, 20 Aug 2026 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787262042;
	bh=qJ+FPVvs/AacLpMi+el1zukCNiWXkRhWB0bAiCWfGPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTKDvI4qYj7N3pXPE9VRaAqWi2IcW7h5q3Vhr2NrF56rfnlYg0SiKI60Odp9vqO7u
	 Sx+MFFYjXgPLGZdObrlsZDwjXHssyH93RjL2qsdRQPQ9n1TMebBEF762ds9SDA805y
	 8EZ3j7vAMyKDr6hbG/D1z8CKvB9i5T4VWubjHAs0D+LqKo1vHzkXFwJvUXUQOFBVxQ
	 kaXbBaZhPsQuhonbfDvTMXIrTd8qCxwTNz5JcPpTCMmxZHXXwlmcl/k0Q7Pcn7OCDu
	 rbaaJ3Nzfs0w2Mchpgb3OmBVgVyOrHH+bgwqHOq9x2Gexn4nBByblK7lLuuMW2orv2
	 bd+dCjAtUm6iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] block: add BPF kfuncs to read blkcg io.stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, tj@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260820211758.3393984-4-ziyang.meme@gmail.com>
References: <20260820211758.3393984-1-ziyang.meme@gmail.com>
 <20260820211758.3393984-4-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:40:41 +0000
Message-Id: <20260820214041.C19601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling bpf_css_release() from NMI context can trigger a deadlock.
--

--- Patch [3]: [PATCH v3 3/4] block: add BPF kfuncs to read blkcg io.stat -=
--
commit d71e52907eeb75ca126ab0da4391bc18134b90e2
Author: Ziyang Men <ziyang.meme@gmail.com>

block: add BPF kfuncs to read blkcg io.stat

This commit adds BPF kfuncs to acquire and release a controller's css from a
cgroup. It also adds a kfunc to cast an io controller css to its block
cgroup, along with an open-coded iterator for the per-device blkgs.

> diff --git a/kernel/cgroup/bpf_cgroup.c b/kernel/cgroup/bpf_cgroup.c
> index cd28c838dc7b6..e253633e82782 100644
> --- a/kernel/cgroup/bpf_cgroup.c
> +++ b/kernel/cgroup/bpf_cgroup.c
[ ... ]
> +/**
> + * bpf_css_release - Release a css reference
> + * @css: css to release
> + */
> +__bpf_kfunc void bpf_css_release(struct cgroup_subsys_state *css)
> +{
> +	css_put(css);
> +}

[Severity: High]
Can this trigger a deadlock if called from NMI context?

Since these kfuncs are registered under BPF_PROG_TYPE_UNSPEC, they can be
called by NMI-context BPF programs such as perf events.=20

If a BPF program drops the last reference to the css here, css_put() will
invoke the percpu_ref release callback, css_release(), directly in the NMI
context.=20

css_release() unconditionally calls queue_work(), which internally acquires
the workqueue pool's raw spinlock. If the NMI interrupted a context that
already held this lock, would this instantly deadlock the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820211758.3393=
984-1-ziyang.meme@gmail.com?part=3D3
