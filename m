Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7597C5237B4
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583601; cv=none; b=r0oYxgMfo0r1zOtwNLVDXagWL9kG1czgvSnDlnDz1Z8zEZ68TBamRqYMGkPf0EOYPtwDWKNmGxyTNA/bAJdNM1trKOj3vfBWAYFyxAEHxZGRIAq6j9uSJM9xBEZA1FM5JM7kAtSZ4KJ+qG/RaUaQKP81+ZkChUZt7krF5Nzq29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583601; c=relaxed/simple;
	bh=5XckXx+QdjGgTe6cQqnZVz1aDMUzxMF+YYtumBaVpVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQ/8MJNmyY2v4qvupXjw4JrIzx/zTGU6sOXIYSokgKiUVzburT+GlAaNzoJvLPYufnvZwdo2PCDWFlFuUBr5xpLimYURG7GBu0ErFxkqWUfRhmxHVpTeKE8DFdtYgWsEZoVCJ7trBChMnoeBEHd7VnmooDOWLNQ6SrZC3Rl5NT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh+nUCjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh+nUCjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858CC1F00898;
	Wed, 16 Sep 2026 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583585;
	bh=YGv+Yj8Pwe4KR2V0i1kA410iOL5kCb8MytqYA5moSrg=;
	h=From:To:Cc:Subject:Date;
	b=Nh+nUCjUrrXr5pMmrfsSw4QJdUEETfmcU4adnozEqmlzHVM3kznk0enBSsyATazC+
	 zI0RE4kZwDakCSElHwa0B61qj2BCnMJ8KNi6dF/BipRR8/UkPDFJ6l1qmaEZm4WIL4
	 +AqfFsNnDE5+AD6yfzpbPunu/hHl1UtHqbEHOOkav/HJIKtsE0A+F+IWW7k6sYW8jj
	 8p88T9ykkbZ0+O9rgoIfqNEV0S0r+OZPh4kl5woNjsLylERwl6KFC3T2Rof4AlEaYw
	 ag16YtFIGLwCp3+KTzRnnJtSIV7DVtGis1I8gAlm+miN3x/RwRySj+fPi1eaEunyTd
	 3FfURMW6CC2Fw==
From: Chris Mason <mason@kernel.org>
To: mason@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	brauner@kernel.org
Subject: [PATCH RFC 0/2] Fix use-after-free related to binfmt-misc-bpf.c
Date: Wed, 16 Sep 2026 18:33:01 +0000
Message-ID: <20260916183303.3504885-1-mason@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

Christian asked me to run the recent binfmt_misc_bpf.c changes through
reviews and this bug popped out.  The bug is reproduced, but I'm not at
all confident in the fix.

-chris

Chris Mason (2):
  bpf: fix UAF via trusted BTF walk after release
  selftests/bpf: test f_inode walk around bpf_put_file()

 kernel/bpf/verifier.c                         | 16 +++++++++++
 .../selftests/bpf/progs/verifier_vfs_accept.c | 26 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 27 +++++++++++++++++++
 3 files changed, 69 insertions(+)

-- 
2.54.0

