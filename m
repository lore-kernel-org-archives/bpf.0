Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE4230569F;
	Fri,  2 Oct 2026 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901777; cv=none; b=FcfIN5a+D/Ex9xCEI2u1C3TsRTFhXbrOrN3diSNiyC/kSi/FbLKs6dLxopHivFoFnKbB4x8XitSsFDjiS7c9HQsgrAkL7jsPtxFgaQ8LdTn+pxoQm8qWP0avNEa/SWNtnZG38N60snlnibCiUHscIl7R7SFtvke9UnlRLiespu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901777; c=relaxed/simple;
	bh=pRK4ka8jK0ZeIgSu7PdcXOQi3EZncukWKf668LpA+mI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kcO3l/F9vWBWYIToNkk6oLZpTtcQxK+Tio9iW48X8miunnq8Qolx4jIfPZ9b72zG4BxZLBLjP5V2Ni98tKkbCcqK5ly6IirHmIF7KZ3LU1u0utfS1pkpnZQuDrXLhM2XulVHo+WOeObO2eLRL6hx7ACL308+0gvI9Rgvd0NYKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvmFl9rm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvmFl9rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A94B1F00893;
	Fri,  2 Oct 2026 00:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901776;
	bh=PFWv9Mb/M9WWb3sCkCNeBms6CokPBW/TIPVRLNq30AI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hvmFl9rmNLFRUPK5WP2Wf6ncUbp9hvp03fJLblEPjutW2IjOJ/V+MZO18Kc3vyQtg
	 6zv1996EAp5VCS6KOYiMDijkmbYp9lKrQKWSnwLBJ97ckMLrVTmL8ymP9V2aUI5+Ly
	 ooBFF0TQynkYD0+NEntbKQtN+uldPIf8uzYa/H+lYPDZEL7Fwc4lOHnoQIzsvjK0D+
	 rIZvcI3y59QBrSPOnp1er7FbOr2oZqPuAU6yE/Ka/lJYBMOSWcU8PneRZ0tUwjmm9i
	 QTUAb7PXjgOOTUvF/Yujp88b/jYIxEdXA3dLubycqwoM12sNG0avnEVrLa0NgALEvk
	 QDyWPfQFW5O2g==
Content-Type: multipart/mixed; boundary="===============6980895201773502507=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c0a78023cdd98e1d96f0b46d71dc69d3a6d63dab8dc1581ab568e756e8066227@mail.kernel.org>
In-Reply-To: <20261001152042.124445-3-gmonaco@redhat.com>
References: <20261001152042.124445-3-gmonaco@redhat.com>
Subject: Re: [PATCH v2 02/15] tools/rv: Skip empty pid error in selftest if command failed
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,gmonaco@redhat.com
Cc: alexei.starovoitov@gmail.com,namcao@linutronix.de,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:42:55 +0000 (UTC)

--===============6980895201773502507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/rv: Skip empty pid error in selftest if command failed

TL;DR: Commit message only: the parenthetical "(exit code not what was
expected)" looks inverted relative to the code, which reports the empty pid
only when the exit code matches the expected one. No code bug.

>     tools/rv: Skip empty pid error in selftest if command failed
>
>     Some rv userspace selftests rely on the pid of the rv process to match
>     with the output and fail prematurely in case the pid was not found.
>     If the rv process failed, however, it's likely it will terminate before
>     catching the pid, and the test reports empty pid ignoring the error that
>     caused the process to fail.
>
>     Report empty pid only when the rv process succeeds (exit code not what
>     was expected) and continue showing exit code and output otherwise.
>
>     Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

This isn't a bug in the code, but the parenthetical in the commit message
looks inverted.  Is "(exit code not what was expected)" meant to read
"(exit code is what was expected)"?

The patch adds this condition to the empty-pid check in _check():

    if [ -z "$pid" ] && grep -q "\$pid" <<< "$patterns" \
            && [ $exitcode -eq "$expected_exitcode" ]; then
            result=''
            failure "# Empty pid for $command"
            return 1
    fi

so "# Empty pid for $command" is reported only when the exit code equals the
expected exit code.  When the exit code differs, the check is skipped and the
"# Expected exit code" failure is still recorded along with the output.

As written, the message describes the pre-patch behaviour that the change
removes.  Something like this would match the code:

    Report empty pid only when the rv process succeeds (exit code is what
    was expected) and continue showing exit code and output otherwise.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============6980895201773502507==--
