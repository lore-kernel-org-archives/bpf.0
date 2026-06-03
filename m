Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB772874F5;
	Wed,  3 Jun 2026 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470499; cv=none; b=p31CYMUQX7P8aZ7CMMI9pIvV3TKd0S7X9W5YO/t8R1KzqfUB0tnshWE0Kb0gtcp8HPD0MN72dB+jQT44/vLFcUF55B2BzQxDK5KyVOeKSKedYCEVoHprQA9gu+ZTSqtrPat30Zmvvqb2Iq6yJa/ZtOn/N+waMY0GW+O0ntdPOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470499; c=relaxed/simple;
	bh=vkcC9vRJUuChaYrJ6DMkr2GuUb6XvuiF5iJBMCBQmwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1AdUJxap3FFCf5KpifaCTTSXAAkavr3u/t/fgd1Q6aUuKdd0YmZRa1llt6boyXV7SGXzX8BadKCz2/1VRdArr33xrIiuw1gXXikHS/oa3RuqfZ8q+IVME0E/byOodtEn3Csmn3kH1X3XbA1cP3YVatS78YIh4kS0ArqoSB9JAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACH8JzZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACH8JzZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72291F00898;
	Wed,  3 Jun 2026 07:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780470498;
	bh=bBGnyCj45mmA3dHmj04zoLAstEpprK0XeoS9GfBxm8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ACH8JzZ6rBo/l6zHrUEM11zty9kBfF1ccNN2zwG2z4UzGkdc1QWxYPT+8VYirJYBK
	 biSxKk732VPbaOn9v3dGZYLo4fxKOW1ca2lAFlpcBkhjzGzo3tk1mLp9zPjdTe2ifM
	 hYGl/c4PcIxFu/S86KYwAATDAirlogUB+DBlL0Sk4lU/+fGyATtcww/YjeGwVgfsb9
	 6qNFvLyQPg6w8l87JPG9EgXjr8aUSdF8WgDOtctcjaM5SqYuOiVENttbYB9WJHZgi9
	 CoPP11qFTJb4zgrYSRmKq8Xevo8MskkcK56f29atJzximIFSfUAlhNWO0w6kKLjMoM
	 FVqTQzp1N0lzw==
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Christian Brauner <brauner@kernel.org>,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH vfs/vfs-7.2.xattr v3] bpf: Add simple xattr support to bpffs
Date: Wed,  3 Jun 2026 09:07:55 +0200
Message-ID: <20260603-abwenden-plagiat-abtropfen-31bd59c3140b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602074012.416289-1-daniel@iogearbox.net>
References: <20260602074012.416289-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=brauner@kernel.org; h=from:subject:message-id; bh=vkcC9vRJUuChaYrJ6DMkr2GuUb6XvuiF5iJBMCBQmwA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJX7pxKDloy3ru5OMB27nMpdclb09/17nWkk3/IO+sX BGRrXemdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE/QHD/2jr14Ksawuat83m NK9qddhUfnPPctOPBzJ2JbFzSByeK8zwV2rF5PnT879Y8h5YsCz9V840tfeMH3/PK0qe+dZndcv vWTwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 02 Jun 2026 09:40:12 +0200, Daniel Borkmann wrote:
> Add support for extended attributes on bpffs inodes so that user space
> and BPF LSM programs can attach metadata, for example, a content hash
> or a security label - to a pinned object or directory. BPF LSM or user
> space tooling can then uniformly look at this (e.g. security.bpf.*) in
> similar way to other fs'es. The store is in-memory and non-persistent:
> it lives only for the lifetime of the mount, like everything else in
> bpffs. The modelling is similar to tmpfs.
> 
> [...]

Applied to the vfs-7.2.xattr branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.xattr branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.xattr

[1/1] bpf: Add simple xattr support to bpffs
      https://git.kernel.org/vfs/vfs/c/a146500e1144
