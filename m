Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F151DFE22;
	Tue, 27 Jan 2026 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483327; cv=none; b=O1rZx1q3yZAjb4xtze6qoUI11DtPprKMXk1PYUzcA/E0KTPawBdnZvSh3mblI6hLHsffasq7BLm8YxI6wLs+Wt9O+brD5f4dQulJPATz0b0gXiDs+ddiDuZR53lHCuUCp/M/9unPwAMHREolL+RMbIMJknGPAy3Q85w22HoZ5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483327; c=relaxed/simple;
	bh=r2VRHW3WxWnawAiIF9XP8PHtMz4QMDWUBEXOXvY8H2U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ogFJfaa0Ti7AyQFrBT1vB+RDaAAliWuKONquygyQilyUyk7f2xRfuiXBXv4gO4LLwuvZC+wK5EloirKNt2MD6g10DPpnme5lDo+Bhs6i2+d1Dt5lWtR1eNVYZVadtlbFcCnoFdopwpaEDvs97EuMfmWOX9p7Sf2x6hw3mwfl+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWYFjNUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWYFjNUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B66FC116C6;
	Tue, 27 Jan 2026 03:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769483326;
	bh=r2VRHW3WxWnawAiIF9XP8PHtMz4QMDWUBEXOXvY8H2U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EWYFjNUg75mYuAauRKChhRpUjAEjA+2PP0uoHx+vXt9zaOPOzFiGq7Dv2dntKzOn5
	 AqKQnuKIa0oj6WLjNNHdhfmSptSHipYNrlTLhbMZOhBvYynMdlYOa/QHukZJv0l1iy
	 mtdAJ96k6bZ8QvNEwJVhfAlOOgG99x3aWbS6ztRUaeIsHlzb2WGskT27+p4welYoKB
	 VZZPS0mMvmehf8Q3Wwjdv6tARtahUqmREThO3MaR2Haybg7Sb6+dmiUQEKRN2yxH6z
	 oByMCB6gH9W9DYUuiw+WP1OMLhJB0rhPeSslPGmKe6Emm3G4eb61YhoTBzHPrmIqVy
	 m+cjo2vtu1pYQ==
Content-Type: multipart/mixed; boundary="===============1477226859959415716=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11e47e72d311eb7a7a69fd74e1701c3563ac2f9d7e4fd4f7a94d49e83885ff22@mail.kernel.org>
In-Reply-To: <20260127024421.494929-12-roman.gushchin@linux.dev>
References: <20260127024421.494929-12-roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next v3 11/17] bpf: selftests: introduce read_cgroup_file() helper
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,bpf@vger.kernel.org
Cc: mhocko@suse.com,ast@kernel.org,mattbobrowski@google.com,shakeel.butt@linux.dev,inwardvessel@gmail.com,linux-kernel@vger.kernel.org,linux-mm@kvack.org,surenb@google.com,hannes@cmpxchg.org,akpm@linux-foundation.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 03:08:46 +0000 (UTC)

--===============1477226859959415716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
> index 20cede4db3ce..fc5f22409ce5 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c

[ ... ]

> +/**
> + * read_cgroup_file() - Read from a cgroup file
> + * @relative_path: The cgroup path, relative to the workdir
> + * @file: The name of the file in cgroupfs to read from
> + * @buf: Buffer to read from the file
          ^^^^^^^^^^^^^^^^^^^^^^^^

This isn't a bug, but should this say "Buffer to store data read from the
file" or "Buffer to read into"? The current wording suggests data is read
from the buffer, but the code reads from the file into the buffer. Compare
with write_cgroup_file() which says "Buffer to write to the file" - that
phrasing works for writes but the inverse doesn't quite work for reads.

> + * @size: Size of the buffer
> + *
> + * Read from a file in the given cgroup's directory.
> + *
> + * If successful, the number of read bytes is returned.
> + */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21382620878

AI-authorship-score: low
AI-authorship-explanation: The code closely follows existing patterns in the file with a minor documentation error typical of copy-paste adaptation, suggesting human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor documentation error in test code where @buf description says the opposite of what the code does.

--===============1477226859959415716==--
