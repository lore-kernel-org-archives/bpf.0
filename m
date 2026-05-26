Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87757379EDA;
	Tue, 26 May 2026 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832007; cv=none; b=p/fcC/8D82K2NRczMgHRx+ksJA3FSzRNo8h2TSLCLau/WO62omeBOrZV+qDMgt5TqlOcjJTPkO9Dp/QAwBIONVyt6YVrWxOzhW80Z+CJB8wRxlYz7HRhdaI7+OqUNp6B/ZlE+bNt+wiFzSMUtTErB9X0QA/rRzrP0IB22qb1qFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832007; c=relaxed/simple;
	bh=m7XXV6iNK8lZKvsGNaORC9RDbqkSZhjSyFbQEbEXCqo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qmQ07kZGCv15sPk+c9vxvUciuUAV73z065pc1Lz+pJkU1z4wHdnl9XNlSwhVwVgahC1I9T/3bmEPEcJJmvTPuiGi2WiZxtFsTNGcjCKuNG+NrfbHYWfo+ESaKdD4gbmuvJKRpSnTyd6ThKU4XG6+HTA976uJSKnXiiEQxP9DEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV1R2KfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV1R2KfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9821F00A3A;
	Tue, 26 May 2026 21:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832006;
	bh=JYYAtkENwdiLok9pkkSpS85X8Hy2wuGyqjJ4umdC1To=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YV1R2KfO7grFX45ye8a+B9lJydUQ7BdwN0lJLJwGHGpvml/PID21QbgBDt0aVzcI7
	 tP7GNB54JPtq+D719h5exV1GwJAF96lZbh3QENT83SFr+NAWaGSKo44d69+oOQ/nyH
	 EXgLoo6ryCz9WaFUNjm/ZczzH54xbmRuislFOYLxTvyhS17MLaj5q10fwecfApnct5
	 Nw8tc7GOIeVNB0K3wkLCphw8durqwNjyQpfgnj1z8Bj66Yf1MUx8NLxHKla1h3HXLF
	 3jI2jBYs2hFiB6pzzLXrL/lVYTWejVH/GLfOcQhiXcO4q5CUaIIndWP6WYBgYs4RFP
	 5BPcBHUzPX60w==
Content-Type: multipart/mixed; boundary="===============3247835363807345093=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ad5e4c3464fcecf951dfb7b351a9d6e53c42b5e808b9a1e8b56c2d700ee463f@mail.kernel.org>
In-Reply-To: <20260526205840.173790-8-jolsa@kernel.org>
References: <20260526205840.173790-8-jolsa@kernel.org>
Subject: Re: [PATCHv4 07/13] libbpf: Detect uprobe syscall with new error
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 21:46:45 +0000 (UTC)

--===============3247835363807345093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Detect uprobe syscall with new error
>
> In the previous optimized uprobe fix we changed the syscall
> error used for its detection from ENXIO to EPROTO.
>
> Changing related probe_uprobe_syscall detection check.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Fixes: 05738da0efa1 ("libbpf: Add uprobe syscall feature detection")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

The commit message states "In the previous optimized uprobe fix we
changed the syscall error used for its detection from ENXIO to EPROTO."

The Fixes tag points to commit 05738da0efa1 ("libbpf: Add uprobe syscall
feature detection"), but that commit originally added the ENXIO check
correctly. The bug was actually introduced by commit af734a7ddb4e
("uprobes/x86: Move optimized uprobe from nop5 to nop10"), which changed
the kernel to return EPROTO instead of ENXIO but did not update the
libbpf detection code to match.

Should the Fixes tag be:

  Fixes: af734a7ddb4e ("uprobes/x86: Move optimized uprobe from nop5 to nop10")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26475828601
--===============3247835363807345093==--
