Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B63BADBE;
	Fri, 20 Mar 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012948; cv=none; b=sygwzKSXb6Gh7i9lo2KFpjrIrDj2Iui0unLU/uUFl18uWeV2hs8J6VI98AJIrrqXuVACJRkTiqzP37eYr0CXn54e4NWTZGZO3yLbwq7lX/7JC72vMJX6HNAYs0Kthdz9F/UGoH1VmW/Tl3xhOBgOEj3IO1DWB4rP8CPDjLpTbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012948; c=relaxed/simple;
	bh=qTc311DjmGcOekCOU6caIIa3S3BScRaQVDhm5mEFQ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1gvI/TmgcukQzD7i+Qv7NRQvDKhEPaBHsUG++7ulOeRR5M3rjrgQFTQmC47gt8JzsZfTRxSGgcN44+mJCIcxaRFeWQV2qscwrcF5wbF6b3pqfW+h5F10e6SsaBZ9VtKpQKksv0VyCumqgY81YXiDIV5Pl8f+Emd5DuK0dPhIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNWI+Ny2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNWI+Ny2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8212EC4CEF7;
	Fri, 20 Mar 2026 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774012947;
	bh=qTc311DjmGcOekCOU6caIIa3S3BScRaQVDhm5mEFQ7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNWI+Ny2QEuaIOAdy0s0lGGELX2Qla+UqNiHtHasBMfjKwfqEv6KecMHpFiVlX+3u
	 SGUQBIUBOSb+IJ/da9Hs1jwdDqWyshrjgNtGkCLxBivW6Tc+3BlAilQBjnkjE5V5ZB
	 Sf4Evl3YeNnZUMOJRzecfR3jQXiP9f7SMgKez65N9i1lvXvHbdhnwwBHOqOrfj88Td
	 fJxQVnim76Y6tu+LOdGHR59wYrC3rANUI1qI3gcC1eRRkF7VwvKNSeHso1FQUxXKK3
	 8phvE4Wgo8ZKWx0SPFBMtfpZDykXqszIZLtMggli9cGWx668WYot2dFiBPuw2H/+HG
	 5XILkaF0pvbMw==
From: Christian Brauner <brauner@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] coredump: add tracepoint for coredump events
Date: Fri, 20 Mar 2026 14:21:48 +0100
Message-ID: <20260320-habilitation-umworben-edeb157af1a3@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320-coredump_tracepoint-v1-1-34864746cbb3@debian.org>
References: <20260320-coredump_tracepoint-v1-1-34864746cbb3@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=brauner@kernel.org; h=from:subject:message-id; bh=qTc311DjmGcOekCOU6caIIa3S3BScRaQVDhm5mEFQ7M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTu9eIV++DeprGt/HdOb7dCgKZS1ollsloSojIfbWSUz 159byrbUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHZ5Qz/TJbtf7hv8fl9Bx6W 9y9WT6h+qBGfduHFZXXmfwvCZEXzLBgZfiVH9m9cpP4vXylJpW2Gj81V6aRdf9qbDNPW/ppRxR/ NCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 20 Mar 2026 05:33:34 -0700, Breno Leitao wrote:
> Coredump is a generally useful and interesting event in the lifetime
> of a process. Add a tracepoint so it can be monitored through the
> standard kernel tracing infrastructure.
> 
> BPF-based crash monitoring is an advanced approach that
> allows real-time crash interception: by attaching a BPF program at
> this point, tools can use bpf_get_stack() with BPF_F_USER_STACK to
> capture the user-space stack trace at the exact moment of the crash,
> before the process is fully terminated, without waiting for a
> coredump file to be written and parsed.
> 
> [...]

"stable" with a grain of salt. We make no such guarantees that it won't be
moved around if needed.

---

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/1] coredump: add tracepoint for coredump events
      https://git.kernel.org/vfs/vfs/c/8e69edaf49bc
