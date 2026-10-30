Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373020;
	b=cv/bwdCjdb0mWPgBqa6rl1r8wqkOkf1XSiX4Iayh3dBzCobo+gp9/cBdS77dtWfO/QXz
	 pX3o6htwzGPFgrzTxUUJqGXpCbKGc4qdIXRwofmEl5mt0+dkvc0OfnZsdoBSlcRWyzeyF
	 wo/bQsPBYaOPwaBIIMmgPZmw+E8mW4Am+PRsKaNYxh4rmZExLlc8x7rAPgjnIBLh3v7iF
	 CEBwXpTJfVW3Yj+Xq2i/kbFX4evrVLD/m5UI7/Nm62SnlxQ+dHlE2z2Yg5YN4+WOepL4w
	 lJ1Uyvvb5L1yaqhJCp6PaxKa2V6j2OLQYuM3kT8GRJMjfGDtOLNPHJtMcBIpPOwmiiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373020;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=hzDvyFL7gN3zXscWLWZE3FRgfn52vpq2GWlamrx1ydc=;
	b=LWhF7URsgFWNlZhrAi1lRAPdzo9pRZVzD6Wz1Or3SPUK3uHsWbK1XdGwEH/4oiopnL6g
	 5AjgDqSb5XsCslNt1MnyhcRLt0ERman/GsRZ1gUznjWbyvjUITMr/rccIw5nlW2Lf1+Eq
	 Dppv88yEoWO+pT+LznUDl83lWAU0+/NUzpS83AOWqOMmpxQDPeD7pYa98OxnoTifuIokT
	 0kPEHEZTlz6IUfdUghHcLZ/TctHZJIEFntSkwhyT9mW5UP1lWMpNNKMFjFyNPWbRUbjY1
	 oUk15Sj8wtCNORT9iq2uyVNvRTm80DcB66VaEE9DU42/5coch2V5JqGCGSm8MAlXWAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSxliBwO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511B606A31A;
	Fri, 30 Oct 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSxliBwO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFA11F000C1;
	Fri, 30 Oct 2026 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373020;
	bh=hzDvyFL7gN3zXscWLWZE3FRgfn52vpq2GWlamrx1ydc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZSxliBwOJHDMKvdPR0psU8994p2F4i53l1ekOCX8rOiH3VIv45slXk3nmITOIGKer
	 JrGVtLAqVPWTM2rVb20e7LTFjT0cr2J6amdPUCDwrfk/SQbyvZmCbiRCMVsU6IgfyB
	 xHz5BnhcRIpC6JjJsIcmT9SZ6gMXVwOIRuCDwDY01CuqZg5Eaa00v/kEOKQvU/Sxrf
	 moW1VBMmYc/4Mra8dGvGg6nMhY6VubTFzcouwgV1cavLFeabmfK//xmVFKixKKRwPG
	 GnK2atVu39RCAzhUd6kh80Z7lWIIJ96hmooFRjUhFBVPHRNiU+e404PxovTrSVKgtH
	 de+BGNcKOdVgw==
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Jiri Olsa <jolsa@kernel.org>, 
 Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <20261021201400.5409-1-ihor.solodrai@linux.dev>
References: <20261021201400.5409-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH vfs v3] bpf: Allow bpf_d_path() from filp_close_sync()
Message-Id: <20261030-probt-schule-pechschwarz-e91fad0852b8@brauner>
Date: Fri, 30 Oct 2026 16:10:15 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Wed, 21 Oct 2026 13:13:59 -0700, Ihor Solodrai wrote:
> The d_path selftest closes its descriptors with close_range() so that
> its fentry program on filp_close() runs.
> 
> Commit 056069eb2b66 ("fs: make close_range() synchronous") switched
> close_range() to filp_close_sync(), so the program still attaches but
> is never called:
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] bpf: Allow bpf_d_path() from filp_close_sync()
      https://git.kernel.org/vfs/vfs/c/3a00ecc89069

