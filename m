Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59203B3C08
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356784; cv=none; b=DMmoYrxqSUS0njsaal3932LHYB3CEqRAx6Ld9STSnSa0Oayk7EMvVC+ClwDJZ33O8JYvb5w0RaScorNsWLZFu2EAzbi/VS6vS1qMseo6kqWmw8uYTbKWNbPVAa6RYfoYBTYWVj/eURu51G/iWHQCgWLfhdL242TH+fa5OwMelvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356784; c=relaxed/simple;
	bh=wFzJ2l3WVG3KD/yTvLCKLRhCIkHI4qs7gShkKOnX0ZI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YJBGS+KPWIguDs91YAfIUzhc5WSV1E9arplHu6nxvgzc5tgFLjb6aReOOlFx60S0Un/sBt8Yh3JCZefGuCjzD9fVvGaIN27JiUYp+W9SIi7j9fBQIgpSKVTtZ/FMJYA4CXHMP9TNn5DxaiVKhosmJxh/GWtmbPzya/aoImWLy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y73tNmep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y73tNmep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDCC1F000E9;
	Mon, 10 Aug 2026 10:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786356782;
	bh=wFzJ2l3WVG3KD/yTvLCKLRhCIkHI4qs7gShkKOnX0ZI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y73tNmepUSrZHZ8IaP2kLTYiS8fOxRjjkO7dPRBSmaIG6LjN3KtCaoDvKT3OQd8PE
	 pdLL7OJQOfu3maxDLcH/rOuZtC/G4AhSj/NST3aqrZ5bs/SVKasI0GIVkw9THz9it8
	 kT7ig85F3WwDOiR94UzT7f+nZ+yMH6K/nrHUzMAkqsuTEVWPpbhAp1nvcmtEiajvr0
	 FuIhhMpVMgA8cQW8JI0n9xS/iLLIN2hFM8ZswIHxTIosDMlo0DWHqvlJCU/5Tuo3lL
	 Bkx7jhMWgpzMQL+8g1zDT02ffRBCnsB2FRo5TA/ffBIY1bdDBYPOeR4AFh1TY3zYYL
	 WBDV1UULF510g==
Content-Type: multipart/mixed; boundary="===============3656506242431868272=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2c97b95af37e54d73c37b7515930e2e439fc3974453af06728b6a5ea473d13d4@mail.kernel.org>
In-Reply-To: <20260810090459.2666243-3-chenyuan_fl@163.com>
References: <20260810090459.2666243-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpftool: fix spurious batch file read error
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 10:13:01 +0000 (UTC)

--===============3656506242431868272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: fix spurious batch file read error

This isn't a bug, but would 'bpftool: Fix spurious batch file read error'
match the capitalisation used by the other bpftool patches in this series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31373774115
--===============3656506242431868272==--
