Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B30273D8D;
	Thu, 26 Feb 2026 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082506; cv=none; b=pU/dwAOZn0h1oCrzfUsrypvq1q6iK0i2X4EX6R28K9/PQj30HrxHCfVDsnpKBUGE45EM1bvK8Ak415BQDgYDQ7BuvbkpMk9rPCmU0NhB/6Zd3us6LhTlNR6NR8a/6NeCCNQf4bNYpMI2a0GbvddvtKH9WJvlmGe0TmzTlp05AAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082506; c=relaxed/simple;
	bh=/j3BZl7c7GyfA5aQlzy1bvqBaCsLFdMoXUAJeZUZabs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FOJj+83g/JZBYP1YpMHKpMpgz6pvOXPmrY0toVpK02FAAhZ35BnHsuccUWvLUvmN2HLed8zTvioA6Eh3UpvOhsXXAKpgo4ClxCwc1eFCkgI1rBGh5Fs/3lvFtqkBC/ZTvyTTd/0E8oqZ8TZoSNVzvKl9FuYbE6UeLP9cktbyXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvycmGlu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvycmGlu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA13BC19422;
	Thu, 26 Feb 2026 05:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772082505;
	bh=/j3BZl7c7GyfA5aQlzy1bvqBaCsLFdMoXUAJeZUZabs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dvycmGluKINZ1jze5SDOxOmkPGxpDsukpdW6Cr0P0aMmW69R88CZ1d3lZj5Jj3r7/
	 3JQwk4GGf6x2RMModBI8u4xOqFgU8uq3Fozc4tIrmD6A8yRQY3hTtpZ4Y21uuvGnCL
	 523nftcy6vcuCcJi0mnzOg0o3qU6v1x+62N7o6VygDU9hRfd71Z7mZZObvxucheHbq
	 dkOQ6OofmcMSwZHVPuI0mT1ql8VXQ6sc51ZrhIuSKn8SJKb+gcdhmUY9zWfQu703Lt
	 yaPEIqLH8+cKJdFth7URd8p9NYxkefQNRMFd7XhnuTrdocwJ0mV5Eji1g/DxCxshyl
	 N2hGVnjZxiELw==
Content-Type: multipart/mixed; boundary="===============5889854532792470401=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d1ad7b6514a3d5819c6ea1cf3d7b30a0916ba04ba741fc4de2d3136b8375c0dd@mail.kernel.org>
In-Reply-To: <2697993e938a2f87084cfe92a4117525d700ac9b.1772079741.git.sun.jian.kdev@gmail.com>
References: <2697993e938a2f87084cfe92a4117525d700ac9b.1772079741.git.sun.jian.kdev@gmail.com>
Subject: Re: [PATCH 1/2] selftests/bpf: probe_user: filter by pid to avoid cross-test interference
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,andrii@kernel.org,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,sun.jian.kdev@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Feb 2026 05:08:24 +0000 (UTC)

--===============5889854532792470401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Also remove the TODO comment that tracked this issue.

The TODO comment is still present after this commit:

tools/testing/selftests/bpf/prog_tests/probe_user.c:
    /* TODO: corrupts other tests uses connect() */
    void serial_test_probe_user(void)

It looks like the removal was moved to patch 2/2
("selftests/bpf: probe_user: drop serial restriction",
849a4da3ab25) but this commit message wasn't updated
to match. Should this sentence be dropped from the
commit message?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22428129620

AI-authorship-score: medium
AI-authorship-explanation: Template-like PID filtering pattern, well-structured commit message, and the mismatch between claimed and actual changes suggest possible AI assistance, though the pattern is also common in hand-written kernel patches.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Commit message inaccurately claims TODO comment removal that was actually done in the next patch in the series.

--===============5889854532792470401==--
