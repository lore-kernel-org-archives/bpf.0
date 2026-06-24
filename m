Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1CD39C00A;
	Wed, 24 Jun 2026 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295298; cv=none; b=KVQjDl0slBqii8aBfPabgOQ34NTmItjND6ZozWI93O2FHPe6dufPDT50Gr69nuUFgr9R2emJAv/GjKLICPIjzoBIIrTANcQiMLwaBUNJP4F49bl4EWPIRfUBm0caHTiK2rJPsxAt98rBYMqGu2oyL9rd5zOFsYSN/y9Vka/3CqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295298; c=relaxed/simple;
	bh=p5nX6wUcfv0bLpniNMX1Xti0A+mdnHioYdQs30tjulc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GVT9OYYNqzznuS/MFezXsLl6xIad9MQ9UR/oV6X1msDjTD4B8mlSpgUpEg7mkHbizFbWN6QEM2q/IU5geUKj5YlIgyEZw+gHazR1joHKRSYy0z8szGI/FmBOw/xQ1Ti/zZBMZy3M4AVj53eb6KoGgB1TmPZ+aFy/5VeN4dmxceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3rsHo08; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3rsHo08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B5B1F000E9;
	Wed, 24 Jun 2026 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782295297;
	bh=aqqXSKkXqH7+z45YaZAA4CHT7QY3OOWzEo26MpYF8kU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=V3rsHo08Xd5O3+dnURCfCrPExjXp32zAOCeCnxQKU1ACjYEF9/taFEHGW9ZmV3SxV
	 pGkICB3+QD0d6OTdlefvC63NH8kToDyuwWGXE+TabuDjKRaFD3mWIGWwQE4yL2X4uO
	 u1B9J9gBj70RTzxFKvfvdJ7yYqxhl3ugcccCao7FDNda9i5lAYoUIDY8hN0iz+gswU
	 I1PB+dr7/O+sTKFVycLqeiJEJHgyNgI4kSVCNOqmzTSRuRpjLRsYGHdjMcgshnqWdC
	 9Xpfx3eYSdssu2Erzh49kVynEawLtxmVwPYpuJlJ3K1xTX2L3cZ6VLpSXeVEBbOjmF
	 7Op2n38z8NQgQ==
Content-Type: multipart/mixed; boundary="===============4585104688103906616=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d5d9ebb3da239a8e792edeb98b45b7bd67876870520d71f26d402301c7c7fb5@mail.kernel.org>
In-Reply-To: <20260624-f01-12-fastcall-helper-stack-read-v1-2-e0a86085ef77@mails.tsinghua.edu.cn>
References: <20260624-f01-12-fastcall-helper-stack-read-v1-2-e0a86085ef77@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover fastcall helper stack reads
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,shuah@kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,gnq25@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 24 Jun 2026 10:01:36 +0000 (UTC)

--===============4585104688103906616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Cover fastcall helper stack reads
>
>     Add verifier_bpf_fastcall test where a spill/fill pair initializes a stack
>     slot. bpf_csum_diff() later reads it through ARG_PTR_TO_MEM | MEM_RDONLY.
>
>     The translated program must keep the spill and fill materialized. Otherwise
>     the helper reads stack bytes that no longer match the verifier model.
>
>     Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

This test covers a fastcall spill/fill removal bug that the bpf_fastcall
spill/fill removal mechanism introduced in commit 5b5f51bff1b66
("bpf: no_caller_saved_registers attribute for helper calls").

Should this commit carry a Fixes: tag pointing at that commit?

  Fixes: 5b5f51bff1b66 ("bpf: no_caller_saved_registers attribute for helper calls")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28089002726
--===============4585104688103906616==--
