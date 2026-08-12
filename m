Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDB346774;
	Wed, 12 Aug 2026 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555540; cv=none; b=UDbzVAiEHN9EVQoD7zSbD/kQFuXKiSZPe0vIjgP+KNS2yTmB0d4ATagHaI8iHkh/621LTh8WWX3JJWcH7EzbXKMnrJvvmNll4NK5lAu02Bz1GH/Jg/rdBfEaXJfsf9xz2CNNPqEkbiR6G54K/e2tTa4oKOX5v8dOKrt2r6EQEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555540; c=relaxed/simple;
	bh=yOnvIPe10doLWES1oaQnU4BPxdkFLU0K0C0WDS9HS10=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YCqkgrFfRkMqmyTgKlstilbArKolOlIsWdFYV+HYozU+NoJRJs720hrvB5ORdGyuraSSItXrrHzBPfJarOovgn5cCe0qbNH8xM59JOyXnZBd0HVgc3SqISMKm+db7vMBfcYGARlmAXYSntYknc51gg5nIwgPCgYRMu4JwC498dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+JfI+Eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+JfI+Eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A431F000E9;
	Wed, 12 Aug 2026 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555539;
	bh=yOnvIPe10doLWES1oaQnU4BPxdkFLU0K0C0WDS9HS10=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=O+JfI+Eu4of0HwMc6N/fh6tKx1s5W6Ul3Me3Li2B3+E3cpg1xvbWaeOESh7W7A/7w
	 7QwNbPEBMdUGMQmOzjN4DlwfIKrOxET1VdgRmQozIgclmG2ouCkBY7W6ADkO0PO1An
	 go+qqd53Z/vF/rajHP8pOz3+pH7kG308Dwl57e+kYv9TM1nTBOM0Weup0vB6Aa+IML
	 Oy4qW2pOVPim+qeb0IABRUgp6knM5AcMPweVQ3jD0qWoWeh+fMoEayUNGUHQVzGh0J
	 V1bkZqsOjm3RQZrHFVBXNNCbUXbp1trwQsiyP5z1yX4p/N8NRi6Hy2XfvbesVmZ4TI
	 91ZKqir3WHL1A==
Content-Type: multipart/mixed; boundary="===============7674152404169399792=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4a025fcdd177da13b51aa8042d59fa5d8e3a7c022bde50d5cf79c92ed3ad516a@mail.kernel.org>
In-Reply-To: <20260812154328.72834-2-mahe.tardy@gmail.com>
References: <20260812154328.72834-2-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/5] net: Add connect_socket() helper
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,mahe.tardy@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 17:25:37 +0000 (UTC)

--===============7674152404169399792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a helper that connects an existing socket while invoking the LSM
> hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> logic. Other socket operations have equivalent helpers that trigger the
> appropriate LSM hooks that can be reused, this one was the only one
> missing.

This isn't a bug, but could the changelog note which follow-up user needs
connect_socket() to be global (rather than static in net/socket.c), so the
new header declaration is justified within this patch?

The changelog motivates the helper only by the in-file reuse, but on its own
that would not require a new global symbol: connect_socket() is declared in
include/linux/socket.h while its single caller is 26 lines below it in
net/socket.c. The actual consumer is the bpf_ksock_connect() kfunc added later
in the series, which the message does not mention, so a reader of this patch
alone cannot tell why the helper is not static.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886
--===============7674152404169399792==--
