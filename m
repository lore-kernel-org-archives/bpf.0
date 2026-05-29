Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751153CE49E;
	Fri, 29 May 2026 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054991; cv=none; b=R91DrYfBEAxEIdwE6u6z5hFmxZhbPWfSIlyBm7OZ35t0rcMNufXxH4dru55eqH8mkVW2mpE2xFRvAFW7YxnopMCXrM1c80kc6r4KktV70hp9jxetzWYeCqeQlFiaqyn86qk23wBVJYzQkAAZs6Z71fL7iUh/bke9sF25lkYtNVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054991; c=relaxed/simple;
	bh=HqntRulfDkB9lBfarMevJrdDNDH2T/4VZCs+f9kMUYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RWgun4rRVAhI/eorBf4ivAEO6LlukD5A6oYdit/22vSuUTod0YUfjev1Iwlos/HC49PZtkc0A4JxZTW3UAUYN6jgJibNTOoL6G6izyjuLcnZbMmf/k7qkIoY2W42wY/6ceOYr3t0IRLRuELTfJaRzGl6Y81nwCAM2aWSyxXuYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=FhMTH2ib; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="FhMTH2ib"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4055cc19b;
	Fri, 29 May 2026 19:37:52 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: jiayuan.chen@linux.dev
Cc: emil@etsalapatis.com,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v2 0/3] bpf: cgroup: fix sysctl new-value handling in __cgroup_bpf_run_filter_sysctl
Date: Fri, 29 May 2026 19:37:52 +0800
Message-Id: <20260529113752.2863465-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0f50af7f-03c5-46d5-9d68-553dc6995df0@linux.dev>
References: <0f50af7f-03c5-46d5-9d68-553dc6995df0@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e7386c53d03a2kunmed7060e8bcc45
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDH0oaVkpNGRhOQ04eGBpITFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=FhMTH2ib4DDHyxC6hrq4kbMP4uWe0Yh4Vn1AyhGGCMsFhhJfiqZtErWbOcgWplTTrQSLQhTCMBdxB62q/OetrhM3Q/NBu72yXqIVrp9bkYpR9KQLf6gk5MFfTE1a8XKTplqINoLRTP8wyJWefhC2ubVLcI4Ss1oa3mGkd7PgW5E=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=actQUhFOnELrLDgapotCvt+xe42q9RDDP4m8sKTf2jY=;
	h=date:mime-version:subject:message-id:from;

On Fri, May 29, 2026 at 12:44 PM, Jiayuan Chen wrote:
>I think patch 1 and patch 3 should be adjacent in the series.
>
>Why is patch 2 placed between them?

Hi Jiayuan,

Thanks for the review.

Patch 1 and Patch 2 are actually parallel to each other. They both address
pre-existing issues that would be exposed and triggered once the changes
in Patch 3 are applied.

In a previous iteration, a test bot and another maintainer pointed out
that activating the code path without fixing the underlying issues first
could trigger a kernel panic.

I placed both prerequisite fixes (Patch 1 and Patch 2) before Patch 3.
This ensures that the fixes are already in place before the code path is
activated.

If you prefer a different order, please let me know and I will be happy to
adjust it.

> Change is fine but fixes tag is wrong like the bot said.

Noted. I will correct the Fixes tag in v3.

> I saw a reviewed-by tag given by Emil in previous thread. Pls carry it 
> when sending new verson.

Thanks for catching this. I will make sure to collect and carry Emil's
Reviewed-by tag in the upcoming v3.

Best regards,
Dawei
