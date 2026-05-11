Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81A3BADAA
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491414; cv=none; b=Hdm98iovka36lieXxHPzRVKG86Imfb6z+ofJlYLlEzCe03impOuP+IsILRSIZB6a86HObgVcbBivnE+wEBNQfh6M6t4CJIOtl0d6/uJOwlAXBzMWKfMF1zd6FEdoUAqBfc8xfm/YbSzLe64LmGtk2+D7CtlmQNBlP5MPJCHqVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491414; c=relaxed/simple;
	bh=oF4xWteD18oSvLHkF9DNNOX9tlRtpwmGkZWvQDji0ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMHy/dIwKan5oIcpS6LH2IMPzyF+9Gso7USQ3hm5JFRxM8YTiFEjJhH3w/UJgKbs3sDGu3a8Z9n1UtxL+hesgCRvABkqOBemvVlEAByyMH1QO9DsttzG3Z0DVyhJyGY8tamTaONNvu+gsE3teXGpGS3gyMOZ0rop0VvEDY/9hE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZMHXIyZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZMHXIyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04B1C2BCC9;
	Mon, 11 May 2026 09:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778491414;
	bh=oF4xWteD18oSvLHkF9DNNOX9tlRtpwmGkZWvQDji0ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZMHXIyZBSIrWs4FFt/ZKbD2FciMLY2jteXOphO9UpMerDpFPeSngoijYCqBe9yrD
	 g1e9noqHHnKclRBaEObvNIAco82H+aLRaZCVhyr8cHh7G8krxEn9kaEg07HrTPtyJl
	 t2YQu9BxP40hw+tmFS+NSizIiwL9my6bfPRyovebrcZ0W8RCWcyBJ/9fv6rv4ccQir
	 /OdzDrM3lhOGRKcWRi+I7mRCojDVaDoMewwX8+EFbYc1APZVX3XCPs7hEDML67ROat
	 mg+itkOqg8n8HgRWvjRULOkLsW2WeQ1H7zPiS1DZSmzDvemPdCIWOgaiClCjSXDMKx
	 6MponkVkg7xYg==
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: fix crash in bpf_[set|remove]_dentry_xattr for negative dentries
Date: Mon, 11 May 2026 11:23:09 +0200
Message-ID: <20260511-anziehen-kringeln-26b280c04ce9@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430073836.2894001-1-mattbobrowski@google.com>
References: <20260430073836.2894001-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=brauner@kernel.org; h=from:subject:message-id; bh=oF4xWteD18oSvLHkF9DNNOX9tlRtpwmGkZWvQDji0ug=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxLuB7P5mh+oxH9OrORb9OP33dwre18q5lFOMW02yG+ w828ssndpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwktJPhn33bYeW7dxI85WrW T84REpIW4CtfKvFkq5botcnn6nfyxDMyvLBvSDv6PNh+17oHMYorFrOeOvYoeHrjFmGJu082FMx W4AcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 30 Apr 2026 07:38:36 +0000, Matt Bobrowski wrote:
> bpf_set_dentry_xattr and bpf_remove_dentry_xattr BPF kfuncs attempt to
> lock the inode of the supplied dentry without checking if it is
> NULL. If a negative dentry is passed (e.g. from
> security_inode_create), d_inode(dentry) returns NULL, and
> inode_lock(inode) will cause a NULL pointer dereference.
> 
> Trivially fix this by adding a NULL check for inode before attempting
> to lock it, returning -EINVAL if it is NULL.
> 
> [...]

Applied to the vfs-7.2.kfunc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.kfunc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.kfunc

[1/1] bpf: fix crash in bpf_[set|remove]_dentry_xattr for negative dentries
      https://git.kernel.org/vfs/vfs/c/07410646f6ff
