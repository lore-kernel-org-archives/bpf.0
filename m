Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4EA29992B;
	Thu,  3 Sep 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420307; cv=none; b=KcHDkT2+A3s4hP/GMnpCs1Vc7bMGZpfatefgmryfJFz0C6pJt6iMkEGLsBPMCN1jz/6TEaq463gIAelEGpT9o/n+lMbaDW77UTd7x0J+Kna8saVzs3jCxUe8DT9KFJ4pBRk4JozqVaPOgE1QZNkeNqPnpUySVONsmVOtl+0pz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420307; c=relaxed/simple;
	bh=JJSUo2r2r3NvI07vkjwgk4phkhRYmLbnSW2ji/Irias=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE+lEpVp8ai5Fkhuv2l3Junv33SQFU5Z0O42D+MWgkjqbi71gF3bGdYzzoUXkkWWuhlihnCv+4XjR/CjL9CnGG+Dl+UVsvRlI/UORw0oe4xB0/WFYpr85cJBvVgWo+0D+mgeC3i5yjisoknKCYz706iUPk/AztH9+sgQSnWIugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPeyMhQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPeyMhQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0171F000E9;
	Thu,  3 Sep 2026 07:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788420305;
	bh=wPucY5EIsuH+AW/lLxBJfKPFJjpHUnizOauIgQ1zZxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPeyMhQmuRqh1o2rpfydGq3APDtDy/93AvzUfWZQw/xAxJ3dgRQmyEfFHSvCg23ye
	 R97gIZnFomeTd4TekNQU+GJxsVr5AVFJddPE0ETN8VBw7eKgeOjgpEEEu1cOAZh6Ie
	 ktMNmSYDyATrXdZhSF/VC3LHqEiqWDkyjopi+xeJNTaTcBqW5O0Fw5aHTqMSVfGdcm
	 Uk5ZyqeM6IpTg3qU1LYyhDhvyQB3MYYiEaBt6HMZQrUB4A5JfRg9qzUKcmw+H9PoqN
	 go8AqgjDqkbK1rBOEYtqAZugW+hBr5qZHgqJ79quiWF3kA5CQNgoI65c3RS4pEE2ar
	 3MoaDG+zq2MAg==
From: Christian Brauner <brauner@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	tasos.papagiannnis@gmail.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next] exec: Drop bprm loader before closing bprm->file
Date: Thu,  3 Sep 2026 09:24:53 +0200
Message-ID: <20260903-normung-opfer-matten-d29bbd55cf46@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901114011.112375-1-sun.jian.kdev@gmail.com>
References: <20260901114011.112375-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=brauner@kernel.org; h=from:subject:message-id; bh=JJSUo2r2r3NvI07vkjwgk4phkhRYmLbnSW2ji/Irias=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNVDiT4h7JtqGdtbju2HO/U2cXH1dSbtg81Wh7eYnFD Ju011xCHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpPczI8KZr853KpVN4dCPt fnkbu/GsaLWr9Q9TMJRkfad3J2RxIMM/u6oNDZU9tx6u+R65I2H24XPWq/nlToY/6ZstfyJqSXc 2HwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 04:40:11 -0700, Sun Jian wrote:
> free_bprm() currently drops what may be the final reference to
> bprm->file before calling bprm_drop_loader(). Since
> bprm_drop_loader() is attachable via BPF fentry and bprm->file is
> exposed as a BTF_TYPE_SAFE_TRUSTED pointer, the file can be observed
> after its reference has been released.
> 
> Move bprm_drop_loader() before do_close_execat(bprm->file), keeping
> the file reference held while the hook runs. This preserves the
> existing trusted BTF contract without changing verifier behavior.
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

[1/1] exec: Drop bprm loader before closing bprm->file
      https://git.kernel.org/vfs/vfs/c/115bf3e51538
