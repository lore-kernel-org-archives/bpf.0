Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1139C63C;
	Mon,  6 Apr 2026 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506511; cv=none; b=O30dvFoZKS3Qoiz5KbHC2vcZ3Gsd4q3vFyUUsn+k9CqDgu2YKdPtcYzpXxvHLMYASSTzzIBKFiMoHdN4AQmmygXgxFAI8TgozlVj7b6AMAYOuh6cuzllsNXCLQMZ1miH4+jYHRLKlf8NZd36pI2Di0q4O+7N5dFUXtBTPEGbKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506511; c=relaxed/simple;
	bh=B1dXs7ROSHPB7EUdsOFlheNNtZOl8UUlRNXbFuSLjjc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YRbVFs2Swd+qKu0DXu3H5tH8t7F9ZCc6ZmYpTgHEmi3i+XwQqb4WDckixIwleZcQS4aKrUV9+fx7b1BmWFiaQrK9JNDxz7FXoeAWeIaQcCxuoLq6Okt3a9PxsRAD9Xiy+thAqkX04KrU0B99IZ2KO6AlV5neyh9LhF4LVy6A1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SG4+XkI1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG4+XkI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B3C4CEF7;
	Mon,  6 Apr 2026 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775506510;
	bh=B1dXs7ROSHPB7EUdsOFlheNNtZOl8UUlRNXbFuSLjjc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=SG4+XkI1h+QXHhQDSEIEYHIuF4pVlHjH7ISFqLIC7+USzu6Jz4PMXUGdMXgMmD4Q/
	 lXWHsv5C+TsYxFM583GqRfRof+m523NwFkrdosnniYreYaGyN4jMyUR+MQCDWmXWjV
	 GsLrn/kbjdAbw0C7mjtlm50PbV6zzJQQZukUhPPBA4P2VjeXx9zssjXIeCN37LW4GO
	 f4O67VN++F4OGbUiEX/mhZF1T5k+rbBaOm9RX5gd8bNrb+Oo9qTltKcR2225zG/2Rj
	 dO6zTA45L1/hmtyyvq1S3QpmeZjmqxA3+il1Rsh4CuvwB819wZqrvajjNFlZO0uKG6
	 nQmIycnNRjQQw==
Content-Type: multipart/mixed; boundary="===============3636165922822587918=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <669779524c357c9790196e8e9ce8da8b21a71756c96e828252fead311fdc44c3@mail.kernel.org>
In-Reply-To: <20260406193158.754498-2-andrey.grodzovsky@crowdstrike.com>
References: <20260406193158.754498-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next v5 1/2] tracing: Prefer vmlinux symbols over module symbols for unqualified kprobes
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,ihor.solodrai@linux.dev,emil@etsalapatis.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Apr 2026 20:15:10 +0000 (UTC)

--===============3636165922822587918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

This commit fixes a bug introduced when module symbol counting was
added to number_of_same_symbols(). Would it be worth adding a
Fixes: tag?

Suggested:
Fixes: 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looking at modules as well")

That commit added module_kallsyms_on_each_symbol() to
number_of_same_symbols(), which caused unqualified kprobe targets
matching both vmlinux and a module to return count > 1 and fail
with -EADDRNOTAVAIL.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24047967861
--===============3636165922822587918==--
