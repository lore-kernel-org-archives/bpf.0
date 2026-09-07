Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEE371D01
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758149; cv=none; b=j3fmqqci3bKq4q52/a9wtxG1x9OUKWVMIH28Iv4ooxcYaLsUO868s7zQTI1PPOccS2/TGhUrnkCGGorQbGfYxVpT5kChldUHnMAKWGpa9MYfeDE37HhGb7fIaNDEgxfFWwmk3NkMPxjnHq1PQO8NhDmISX/2l6GUPs6cCRJWvlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758149; c=relaxed/simple;
	bh=Bvpi4iRtkSD+OqO4XuK1CwoClYFx9JAi5z0Xdo8ve38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWGHOOd2HKYehMCqhl3nfkrwSQIe3rfnBEFGiNoniupY7Tx1pLpjJO5ttQTlSlWdtvm2MOo9FUTFlhJcsiqB4mcz5xxF+dx9QE9KudoMULVfwMs88EYCaX7LarASQxdG+eKzPIwOJh4ph7gD/k4RIeqpZsiQt2+W1t2WdErIngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=fzs2H/E+; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="fzs2H/E+"
Received: from fedora (unknown [23.142.132.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdZz56ZBsz6tl6;
	Mon, 07 Sep 2026 05:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788758146;
	bh=Bvpi4iRtkSD+OqO4XuK1CwoClYFx9JAi5z0Xdo8ve38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzs2H/E+iJzn19hfc98PE0IIYv4Hwf3d2Uh6t/bueYiDbOKYdryfdmY2DB3fVLonn
	 SfpLZwWvfsffDhMJv7HfiFzuD1uYpHERHWIAK/5t7lj1Og8djXPQYikYHxGcizyI93
	 5ZpPqMEdweXtj4hzCG6D/lhAAgCd3s4frxfqH7CgimzH6C64kUWDh69fAkrzuy1Ztp
	 1r5NV10NnJZrHL2F8YznDvn+R9ZvDPGJu9uinLkUIcMsolXGldVKKwggO7w5VqsU1V
	 NwyKI/muKKasFx2tGnbCMJ0YUsiWiryfzeeTT8Xxkm5y0ZpwZDH7grPVQZgxDNxcdD
	 Gjue7dBqHdXHg==
From: Tianyi Chen <hi@tychen.cc>
To: kernel-ci@meta.com
Cc: bpf@vger.kernel.org,
	hi@tychen.cc
Subject: Re: [bpf-next,v3,1/2] bpftool: Accept symbolic map creation flags
Date: Mon,  7 Sep 2026 13:15:35 +0800
Message-ID: <178875781913.42294.7695925924255845754.07-ci-empty-patch-report@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <88e01da6d4b68aae7b8df6c0956b78f082bcedab7eb588631405031f1425b146@mail.kernel.org>
References: <178874713816.1519295.11686841174785622807.flags-v3-2@tychen.cc> <88e01da6d4b68aae7b8df6c0956b78f082bcedab7eb588631405031f1425b146@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Hi Kernel CI team,

Several previously successful bpftool submissions are now receiving
repeated CONFLICT reports. I cannot reproduce a patch conflict against
current bpf-next; the available evidence points to a Patchwork mailbox
download/access failure being classified as a merge conflict.

The four current series are:
- 1159274: symbolic map flags v3 (PRs 13654 and 13669)
- 1159257: ring buffer event_pipe v2 (PRs 13651 and 13670)
- 1159258: recursive dump v3 (PRs 13649 and 13671)
- 1159259: batch dump v2 (PRs 13652 and 13672)

The application logs say "Patch is empty." rather than identifying
conflicting hunks. Two examples:
https://github.com/kernel-patches/bpf/pull/13654#issuecomment-5565136560
https://github.com/kernel-patches/bpf/pull/13669#issuecomment-5565265918

From my client, the series and individual-patch mbox URLs redirect to
/user/login/ and return HTTP 200 text/html containing the sign-in page,
not an mbox. For example:
https://patchwork.kernel.org/series/1159274/mbox/
The REST series metadata is still readable. Replacement PR 13669 contains
only a Dummy commit, so its new checks do not exercise the flags patches.

The daemon's get_blob() path appears to return the downloaded body
without verifying that it is a mailbox, and the git-am error handler
labels application failures as conflicts:
https://github.com/kernel-patches/kernel-patches-daemon/blob/main/kernel_patches_daemon/patchwork.py#L652
https://github.com/kernel-patches/kernel-patches-daemon/blob/main/kernel_patches_daemon/branch_worker.py#L1100

I fetched bpf-next/master and checked each of the four posted series
against 1b7415bf70be95b9a1e7e87d544867881065613f with git apply --cached
--check on a fresh index. All four apply cleanly. The earlier flags
build/selftest run also succeeded:
https://github.com/kernel-patches/bpf/actions/runs/34075962833

Could you check the worker's mailbox downloads/authentication, then
rerun the current series when access is restored? Rejecting login/HTML
responses as download errors would also avoid misleading rebase requests.
I cannot inspect the daemon's actual downloaded payload, so the endpoint
behavior above is supporting evidence rather than a server-side trace.

The obsolete v1 series are receiving the same repeated notifications;
they have already been superseded by the versions listed above. I am
not reposting those or rebasing solely on these empty-patch reports.

Thanks,
Tianyi
