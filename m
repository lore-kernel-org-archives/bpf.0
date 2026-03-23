Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BE36E48E;
	Mon, 23 Mar 2026 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268189; cv=none; b=hvwA7q39Tk/+5PzQtv199VdzomhNxc1DWKHbON1FWjk556aAbbU1yEUGKRwLG6N35SOucPnfvQOuqe44BCAS5d00kcVg5mWzMy7b6szja9tEa4Pn9Z60Zl3z0qjyPGJu05G1AhYw7CdIXLAxSgEbwj91wBGVuA6JKK0RxwwWDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268189; c=relaxed/simple;
	bh=l6YKKTvE+0HDQgg2kNS/cbXFbgNZUW8vt3hb7Nlybwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsDsvCZfSvkEP4qdmQlDRcdSD6XgZ1tLLgAWM9WWhRMVOWOdSztGbcxdOHn1Mvwg4MT0LZrolmgO9W9vPhe1T7KEk0eqo+35z/qbd6nx1Ab9kK/eWwcOHRBjV0VGiO2MW9nXw/a8BKSXVzVrh77e2Rlx5xn5OYi5w1yKPpTi0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsPh/cIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsPh/cIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBD8C4CEF7;
	Mon, 23 Mar 2026 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774268188;
	bh=l6YKKTvE+0HDQgg2kNS/cbXFbgNZUW8vt3hb7Nlybwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsPh/cIfbREWFdj+dQv07qgUnsqcrgTy0/lxb3mlBjdgLBZ/atlx9frBlYoqicPUT
	 QLk7bcvu5Wp2epUmLE0FccYZDIR+xc9Oxqg+Y8iIzcpuwrhXCDpTstIX7kxtaFf90/
	 geJ56gAIbRjSiPvTH4GwiUghWXunlaHG8Rjx7PDTS+xE2WmhHbYjf35lMS/SOc5J4L
	 fkHA5uvW94DbBwjaAcEfg6iusrx673336OXukN3ewm1Hfisi4Gd0z753JGmeBy6EOC
	 pSscCtgBXj0v9BkynspUZWsNujZ5tvVN0QsLjxKOvyvfAQhK1bBQSDyuXz9XzCBFqw
	 WIuRItSPDUpAg==
From: Christian Brauner <brauner@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	song@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] coredump: add tracepoint for coredump events
Date: Mon, 23 Mar 2026 13:16:12 +0100
Message-ID: <20260323-unbrauchbar-bandbreite-7122cb48ecd9@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323-coredump_tracepoint-v2-1-afced083b38d@debian.org>
References: <20260323-coredump_tracepoint-v2-1-afced083b38d@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=brauner@kernel.org; h=from:subject:message-id; bh=l6YKKTvE+0HDQgg2kNS/cbXFbgNZUW8vt3hb7Nlybwg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQe1Bfz6U5emy5jvLLx+7zmao7QK42l9v90kpuD39mZd B5cmWzQUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHfQYwM6zNfeW2sVd0W/zgy 9op9w2KOuOlah0One02cwKHxu9buOMNf+ZkljWxZS1MLw9fuv3a26sUf+2kRS8Pm3Zt0L/jqzpS jvAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 04:46:27 -0700, Breno Leitao wrote:
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
      https://git.kernel.org/vfs/vfs/c/f30186b0c782
