Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F22E266C;
	Sat, 17 Oct 2026 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248804; cv=none; b=l2vMYIvcLRqhl7lOw4dCy0IlV9J7Ne3/c8R+PYF3qC/1XCjcsDjnYSpBzOqDN3UXnR1m8hlx5YX0at7bF3s5zqdpfaZnedwjSIf259AEPwTbg7ETVMBniM0Qi8DMUsNti2QwNHBCZ4Pnwm1GScIKu3rThBibH6j38IE47rWjWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248804; c=relaxed/simple;
	bh=fryIqE7Rw8splORyfR0h2iOyhHC2h719ALE5w8lFEVs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MKGv+/WMDY4SuVgMrIsTwdcHFM466xaA08UOXK1kmb4E0ReVXpyDcQ7dJCEWkvzlgDq0vIciwiXCwTMYcnf12bI14G2elZ25PJ3mb2/UfpTp3Yh8HrOCUDd1zfcuH8XRw3bqih03XjLuDsQ/dnC24He9aiwkLUS0RmXOAvpXiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGWhLXlu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGWhLXlu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FB91F000C4;
	Sat, 17 Oct 2026 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792248803;
	bh=nFEIPKzxh/STgeEaGPl4FKDwpruwwaBT7h5f2UfiKHA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FGWhLXluvJBDD1ZAIbTOsaHO/abUyld2KdAC3vUsipfeT+edjqEVGyYyNzPbpdk1E
	 lH7NG2tODMOiYAZvoyjF2YnTGhvWI6CpiWNvCluq21BwUYz+tLGqoMAGxBeCvkHw0y
	 rl1+F1kbD5Lp4ieAcRpgNf0WkbG85HrZ5zxezMkFHsikPyasx52CXeGtP6Z3+z8bTR
	 8Z9HRBPZM26BOu7jVq4Ie7tZY5bAfDWjbtyfGNPbzQqdhHl4EpPg3KUSV0qHiMmdOO
	 ZpOaq/n17Ftwx4DS/uI0+HiU0l3g/zcIsKmy9yZH3fo9TGQXZQlMOvk9h4GQghDxf5
	 B77KDpJ8jLpbw==
Content-Type: multipart/mixed; boundary="===============9111035185755451495=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eb32cc32c29af7d8ad5a342bbd9a0da19c8b53d31a71754b98953a5be62638f0@mail.kernel.org>
In-Reply-To: <20261017142649.51047-5-leon.hwang@linux.dev>
References: <20261017142649.51047-5-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 4/6] libbpf: Factor out __bpf_sys_fd helper
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,shuah@kernel.org,kuniyu@google.com,liuhangbin@gmail.com,mkarsten@uwaterloo.ca,masashi.honma@gmail.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 14:53:19 +0000 (UTC)

--===============9111035185755451495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Factor out __bpf_sys_fd helper

TL;DR: Commit message nit only: subject and body call the new helper
__bpf_sys_fd, but the code names it __sys_bpf_fd. Should the message match?

> libbpf: Factor out __bpf_sys_fd helper
>
> In the next patch, it also needs to use the extended BPF syscall to
> receive the reported log.
>
> So, factor out __bpf_sys_fd helper.
>
> No functional changes intended.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

This isn't a bug, but the subject and body name the helper __bpf_sys_fd,
while the function the patch adds is:

+static int __sys_bpf_fd(union bpf_attr *attr, const size_t attr_sz, enum bpf_cmd cmd,
+			struct bpf_log_opts *log_opts)

which follows the existing sys_bpf(), sys_bpf_fd() and sys_bpf_ext_fd()
naming.

Should the subject and body say __sys_bpf_fd instead, so that searching the
log for the real function name finds this commit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39042048581
--===============9111035185755451495==--
