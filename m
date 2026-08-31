Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731736B043;
	Mon, 31 Aug 2026 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213548; cv=none; b=cykPuM68Wfx+39DfQaXcV+hZvhco69/zn3+mpVyhA1QUcD0pNXssGmGzUYig3Ehjo78dGHPZyYBX8+CmYDXCRxw1aeMUTPP8tyxcf3jFs5b1YiYcFSisFrZCoa1nPG5uLv3pHHX/IS5yFkIFtAPXaNfODy78PT5Flq42tCG3SUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213548; c=relaxed/simple;
	bh=u1Xr8XXmD9QYZfm2jP23MUC6Mzsx0aYo3kuk1yBTEEg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Ko0sh3XEB5Kxntrbn4dsWJZCzuFvaL1rv/7QT8EW1lF7iQaar2wYrfy1iBJz2uxlkm9N2t1l9E3h55dyPeo8e0Ap5CJj6WsWXtU8MVQTNlKKWc3qdoIkCO8wWf37aQ3g4xi1E5yHTJk83H6liHBR7qOL3iPgtEaC2x4vBCEDWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8JolSOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8JolSOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D804F1F000E9;
	Mon, 31 Aug 2026 21:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213547;
	bh=tmOVROBds7p6wS45qXTJ3heh+frHtp6qeEv8lFC6zoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M8JolSOuot0g6sNsYeqZ1Ghy44UIdZ18RKSfcJupx0T8P5SewiX2B9DaDUe1kCTn1
	 PkCYDRk8OkLVGDTQPLl+IHtsyAJdBRNleqiFu9+pV9cNm6Hx8bGETxXsfbvSDfVPGq
	 UqoMrxY0euLdsh3iQDQzEGIzck6HoDIGwxMlbuqvdyIZVoxy+wdQ5Kg8EsLfHX0a3Y
	 WkAB7EhqMrdF3JaTncSscRBeHoF9SP/gFAMZSL2+Q/mm/WFvvRD0x35PbkwXHbFQT0
	 U3+WfJ5alEo4v56u+aUicLD0MDMyQFyJwSGnAL6zy7FxEnda3TOraitA4VsgoH9yX5
	 578vufn+0JPAA==
Date: Mon, 31 Aug 2026 11:59:06 -1000
Message-ID: <32bb40e15ac938fc380e4a65eebf3f9a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cuitao@kylinos.cn
Subject: Re: [PATCH v3 0/2] sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
In-Reply-To: <20260825023557.27881-1-cui.tao@linux.dev>
References: <20260825023557.27881-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> Tao Cui (2):
>   sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
>   sched_ext: rename tg->scx.idle to tg->scx.sched_idle

Applied 1 to sched_ext/for-7.3-fixes and 2 to sched_ext/for-7.4, with
Andrea's Reviewed-by from the cover added to 2 and the subjects
capitalized.

Thanks.

--
tejun
