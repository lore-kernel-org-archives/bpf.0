Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AD4418CC
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502615; cv=none; b=AYoFjVfOPNJHnIZ+brEe+RshD/s0zTyIuNbXP1eg1E3sbGsihaeGSNiZXBMSDv7rOFnKOMaOEnbturPNjJPGMvGLD8pGb7h7JVRqkXueLnEuT/l31pOucXDzhCNXxql+EAz6Dt0/zNx0iQSEN+JdSbhA5AmrcDeLxWRSexyRb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502615; c=relaxed/simple;
	bh=2eToFdtnQUnXSK+5RNtdL1Twe9WyGSaAZyOHqzpbKTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oU3ER6rEFUj9S3VA9sFw3XVbR2CLCXgpUw/tCwL0lxs8ctR1GOA1pK5TBB1YiYgbI1KyqtoOwgwWaXGGt+QzeBwO5c2HQ8iST/5hT8rRNDppmVpqFwkfcpy9VeT1KzmvIWOZioBQURey1kcgill5vR8HSoR+Lv3gH+Z5WRTS7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO8wayof; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO8wayof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741DEC19425;
	Wed, 29 Apr 2026 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777502614;
	bh=2eToFdtnQUnXSK+5RNtdL1Twe9WyGSaAZyOHqzpbKTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CO8wayof28bf15XZHooLYQNXeMPbxHm1wH2m8NgMg4aKDPq2Y2mNlVaP08lF1NAtd
	 Z4CN5phY76TVoh4kcWvvDPe5QexoyBH1cLrkLyVXXOYNTWfqG7QAKZmrw6ToTljYoB
	 h0NrTfxQ4S3VmjbbGygj4cWlbQS+l1xQ3GvuCu9U6fVHjeV4wntCjqlgmfZFadRY2f
	 BCbSm+NxnrgdWvhRJjuadh6vE2b4z2492M9xsYrxG5zlMn5AMwkcAxm6iYJSV0e46c
	 ER4nKyp+Xu0mRI1VbNbkXTXmwulsPXUsfCFyFpdV3xz/4rlLBflV+XWZbJzX4vkzpw
	 UDtp9k4rXrdDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 11/11] selftests: drv-net: add netkit devmem
 tests
Reply-To: sashiko@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-tcp-dm-netkit-v1-11-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-11-719280eba4d2@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 22:43:33 +0000
Message-Id: <20260429224334.741DEC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added executable test script `nk_devmem.py` is not add=
ed to `TEST_PROGS` in the subsystem Makefile.
--

commit 052df7b2cdca71035e04527f52dbd4dd5e53cf60
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: add netkit devmem tests

This commit adds a new python script with four tests for TCP devmem through
a netkit device. The tests duplicate the original devmem tests with adjusted
parameters and use a configuration environment to set up the BPF redirect
program on the primary netkit interface.

> diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/=
testing/selftests/drivers/net/hw/nk_devmem.py
> new file mode 100755
> index 000000000000..c069d525798b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py

Does the absence of a Makefile update introduce a regression during test
installation?

It appears this new executable test script is not being added to TEST_PROGS
in the subsystem Makefile. When tests are run from an installed location
after a build, omitting the script from the Makefile can lead to a missing
file error.

Could the new file be added to TEST_PROGS so it is properly tracked and
installed by the build system?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-tcp-dm-net=
kit-v1-0-719280eba4d2@meta.com?part=3D11
