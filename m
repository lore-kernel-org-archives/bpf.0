Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9B40875;
	Tue,  6 Aug 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976434; cv=none; b=C/riAQx2hQaI5hT6RQT90LBIz4AMSU1crF5rQG0rLcCJsZyYYM0zomohECxb7BzWm1VJEluVf8Y2X9Jy65gEOksCB91Xmo/Dy60PEyBh4vniRjnQoxd3Duo0QOeEZ3d2gjktG639UxmJuZ733xE948q4nKnegQEpxzHSResRlFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976434; c=relaxed/simple;
	bh=46R6UDwxGzh0Sz/0gGwd9zaNYnREfwT2qttK7CRc0RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+iP3q7NZpfJ8nIoJyBKzbsibAKKPMRchSX4QxYF35erGs3M2AKRvQSG1jdxyZQ+yBsi74kBG+oTDu6bTfRLWEfuUqKeQpqT7GchPsyM0beChn9NZonGfsEKMakiHRrJw5/fNVnP9KyT1iw8fkULQ5BdtY79hNfPasvns8ZbwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJAYgN2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJAYgN2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9E3C32786;
	Tue,  6 Aug 2024 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976433;
	bh=46R6UDwxGzh0Sz/0gGwd9zaNYnREfwT2qttK7CRc0RQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LJAYgN2TXOfSiDfA/amSbmV8cMivPjS2fEMfIwoWzUpl8cR7A/bLPIIT0GA6S6ucf
	 UlyBWHN7QnZ8cuUdvv4+KdZ/xFUt+KNGr2lvbpedAHyFXS5+J2KOHrkhCxPYXx/OOT
	 Vd1HVLjeqSfiVIs1cs+P1knbV/1ylTNCLvNMPpVac3AsWZBVTzDRXLGwRFrPkOEULd
	 kwP6Irf5bNal1suPMiUiWJrJ5kKAl76PjebQ6Ue/U6OCFRMDvu8N/gbyXREQq7YyKy
	 eaOFL5Kw39sJqLhSpWPiiR8NMAunHMwlDA0s1uVTlVaapoV+uW0dXTk0raC0u1q3T4
	 GgoJrY53cqxZA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	liamwisehart@meta.com,
	lltang@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 0/3] Add bpf_get_dentry_xattr
Date: Tue,  6 Aug 2024 13:33:37 -0700
Message-ID: <20240806203340.3503805-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kfunc to read xattr from dentry. Also add selftest for the new
kfunc.

Changes v2 => v3:
1. Move the kfuncs to fs/bpf_fs_kfuncs.c.
2. Fix selftests build error on s390. (Alexei)

v2: https://lore.kernel.org/bpf/20240730230805.42205-1-song@kernel.org/T/#u

Changes v1 => v2:
1. Remove 3 kfuncs that are ready yet.

v1: https://lore.kernel.org/linux-fsdevel/20240725234706.655613-1-song@kernel.org/T/#u

Song Liu (3):
  bpf: Move bpf_get_file_xattr to fs/bpf_fs_kfuncs.c
  bpf: Add kfunc bpf_get_dentry_xattr() to read xattr from dentry
  selftests/bpf: Add tests for bpf_get_dentry_xattr

 fs/bpf_fs_kfuncs.c                            | 62 +++++++++++++++++
 kernel/trace/bpf_trace.c                      | 68 -------------------
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      |  9 ++-
 .../selftests/bpf/progs/test_get_xattr.c      | 37 ++++++++--
 5 files changed, 110 insertions(+), 74 deletions(-)

--
2.43.5
