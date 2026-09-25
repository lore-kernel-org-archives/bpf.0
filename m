Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662944973AE
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332604; cv=none; b=Euk0sh5xDzUbu8/vIhW5bCweHjFf/+bPnerCgsZKECiQgUK0HVlZ623fpj5ixdFLCTNAilS/hF4rfBUxgUUTkZEPDvAuW2b8yuWsaAtZeSrZYJNfmg6m8lmwQYHcV8N96fT4XgkyWb80TnBT9PVQi/q8GQi6+X5k10fxeYrJcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332604; c=relaxed/simple;
	bh=Pn0xWaz25+t1anqebFXz2Q/U9OwSxC9n9aEPeYXqQh8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UbFQEuhTgs+mIQwvow82jUBfcJUq1Idw8K9zaZ/IIUCeby6bHFKxUnZ7F3pbrZvAcxUmXWMnvzP2z0w7emwaNBZO8uifqGOY2bKHc39opQJHaum1PI5TvHLDIoK4/E4ItMs3k6taUuYZVjZUXFqn3b53SG+YABlsTeE4su913tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLl8JisH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLl8JisH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C021F000FF;
	Fri, 25 Sep 2026 10:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790332603;
	bh=Cyb6kQg687TVOAEb9uD6qgyi9mO2diDTdDXt4qiRQ3c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VLl8JisHogPYw0myMui8BeH8ammGcdFwsSF7YulDLfjtWBy8bIqBEL4Oujq0KdvRZ
	 ohePw7T88t97dYaGQ3PudNYQbDjzE2578NJyv2jx+oJ35MOBOtjeu1DVz9WL9Gc0Qr
	 kH3f+vwJ0bTAg510UV7nxpR/wdo0ZgbAqiVkUtkdJfVh0aIrK8MQBqiIwhbptViqS5
	 a7EvF1ayW/iec7mENp7iexZO2c9zgNcMzV6PmjbhfJyc/MGxfdhzLRFIr60L5ngaJy
	 QxEX41PMySXdPuKCT8Z0+2yG36jEmk1jIAi50fOnX+DBg9kdqhRCrKp/6zS2YNbyON
	 Nk864ErPdPChQ==
Content-Type: multipart/mixed; boundary="===============8433217400515123095=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7747f3de1b5fb93ddbdc56ca7df182f19fe109b22d64ed0924d7cdabb99b9a0b@mail.kernel.org>
In-Reply-To: <20260925095231.879708-4-alan.maguire@oracle.com>
References: <20260925095231.879708-4-alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Fix up bpftool btf dump test for signatures
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,qmo@kernel.org
Cc: jolsa@kernel.org,daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 10:36:40 +0000 (UTC)

--===============8433217400515123095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Fix up bpftool btf dump test for signatures
>
> Now we show a function signature, fix up the test to expect it.
> Also fix the fact that we did not add the right number of parameters
> to the FUNC_PROTO, and ensure consts/addresses are prefixed
> appropriately.
>
> Fixes: 321562c34d5b ("bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Does the Fixes: tag point to the right commit? The commit message
references 321562c34d5b ("bpftool: Add ability to dump LOC_PARAM,
LOC_PROTO and LOCSEC"), but that commit only added the bpftool feature
and did not include the test file being fixed here.

The bug being fixed (incorrect FUNC_PROTO vlen=5 when it should be
vlen=6 to match the 6 LOC_PARAMs) was actually introduced in commit
3429e01578b6 ("selftests/bpf: Test bpftool dump of BTF location info"),
which added the test with only 5 function parameters (arg1-arg5) but
6 LOC_PARAM entries.

Should the Fixes: tag be:

  Fixes: 3429e01578b6 ("selftests/bpf: Test bpftool dump of BTF location info")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36122090541
--===============8433217400515123095==--
