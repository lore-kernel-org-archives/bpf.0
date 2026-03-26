Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A154035C1;
	Thu, 26 Mar 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541363; cv=none; b=f5YfFBp63tDNJMkSVNU2XBc8fw9fZduFHGWVagmzRwUOiWKq1kOUrtGgkxp621Fe2LGm27b2CulmPliZer/ChSlQuNyz2gvd4HskRmJ9+IKPfwbtYR2ZxCmmjTrYPKXD4MbW8rAHK11/XO0Y5xQ++iapCUsXqvNkOL8ZkguKkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541363; c=relaxed/simple;
	bh=i6O1zJoZfN8ZZ3jy/tm+/8+mLa33DvFPItUOXqaTx5M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h7N8o5yU89enWcfRXmeB7kMwHlLk1lbAbtkloLilwMU8MNs/zcuZE9iUl1le2vtFTQBKrvsow9Z4u0ep3bt9efaq9odiq7vPX7PJ2OCv4pPXlloqSxGqqvTCSxuqjKzM+IsZqSOd9b5ju+CWj37IVte/Guh9pWtY6RY0pAtCYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiBjlj74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiBjlj74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434C8C116C6;
	Thu, 26 Mar 2026 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774541362;
	bh=i6O1zJoZfN8ZZ3jy/tm+/8+mLa33DvFPItUOXqaTx5M=;
	h=From:Subject:Date:To:Cc:From;
	b=JiBjlj74x0cYc009A4NvmXIFImMM4CbIb/DXEZMk+f38efFSdQtjsibXigKC2sDMy
	 5wQqyrkvsVomlLE+bI/8RQ7y8InL3SHSOs20gA8FY8GzZTc1kb6mvZsf9wS9KKSyDI
	 NBzd5599yu55fOdvSdCVlMIgM6+w41H5/gZXaLHNGYKmvY9j7OEvhCAZPxumG4wkos
	 9fPgybBu+O42wMxEpSikWVcGbXaMC8vP9thj+FhRY9ie7SD+VTB63RcLMAI+kk0kcv
	 tel+530Wq+YQkFv77S1lqAlpt2hH+1/LeODtnAq5VAWDVvDbsWcwSqwGksxYA33hUN
	 Z7grS4pX5go+g==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RESEND v2 0/2] bpf: classify block device hooks and add
 selftests
Date: Thu, 26 Mar 2026 17:09:13 +0100
Message-Id: <20260326-work-bpf-bdev-v2-0-5e3c58963987@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAClaxWkC/3WOMQ+CMBSE/wp5s9XyADVODrI66GgYaHlAxbSkR
 cQQ/rsU4+h2d7n7ciM4soocHIIRLPXKKaNng6sAZJ3ripgqZg/IccsROXsZ2zDRlkwU1LOyRLn
 HMI4KnsC8aS2Valh4N7ik1/R8guybu6e4k+w8zDdF7ogJm2tZ+8gTNQ3d5id8p1auM/a9nOvDh
 fnnRx8yzmQS0T5BGe84Hhuymh5rYyvIpmn6AA+HECHpAAAA
X-Change-ID: 20260220-work-bpf-bdev-ff2c82143d05
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, linux-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=brauner@kernel.org;
 h=from:subject:message-id; bh=i6O1zJoZfN8ZZ3jy/tm+/8+mLa33DvFPItUOXqaTx5M=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGnFWi+iouKptngv6f3x3LuTtsatjmiU4WcQnJlzI4NJh/Hoo
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmnFWi8ACgkQkcYbwGV43KL58wEAyelW
 iZ8IAdNWzcNBNuciM0qt8bBEghIn6xQkTyJ1gOQBAMnN9mr19Ix8+fiuTgRBqVd3MvnxzcySE/p
 x6w48kWsI
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A bunch of new hooks for managing block devices were added a while ago
but they weren't appropriately classified. Classify them and add a test
program so we catch regressions.

Note that for whatever reason building the bpf selftests locally seems
to fail for all kinds of arcane reasons for me. That might just be my
fault. I added a pr against the ci to have the selftests run but to test
this meaningfully it needs veritysetup and dmverity support. I'm not
sure if that's available already.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- No changes.
- Link to v1: https://patch.msgid.link/20260220-work-bpf-bdev-v1-0-c53e852c4702@kernel.org

---
Christian Brauner (2):
      bpf: classify block device hooks appropriately
      selftests/bpf: add block device management selftests

 kernel/bpf/bpf_lsm.c                              |   4 +
 tools/testing/selftests/bpf/prog_tests/lsm_bdev.c | 221 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm_bdev.c      |  96 ++++++++++
 3 files changed, 321 insertions(+)
---
base-commit: 400ff899c336c24bf4d34479f98cef2fd2d3482a
change-id: 20260220-work-bpf-bdev-ff2c82143d05

