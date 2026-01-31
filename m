Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3B320A33;
	Sat, 31 Jan 2026 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769837607; cv=none; b=BrkEu87KU53zqk7A32+a3t6MblgRzdOPOXTplXKC6fIWH+tWUU5krNEdCuegKFUX7RIJh+J0FYCPu08FFGzIxDdFYuqxd67TLfB2vW79MAYWa9e1nXjrFVwyX9aUG43fKdggBHnMPnLuMAbLChO5jLeNb02DaeT+iDWX5l3ytOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769837607; c=relaxed/simple;
	bh=pE93mOE3ROvKWsUdTGhrdMaZIaCMbNOjj+VOr4ezq0M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=APtpa1BGCKeQNrfMm5p4hP2zhYUjtp2FlStV60mV1feBs02bc5jzJO7qim1Lo3gKSCIvCtRjaQhTfTacxFHJyzrhz/JR43e4zHlxO2pLUaeAtZe/Jqx/cBJ1Miyubcf3YrB2f97TKfbe/vIIyiXQi7N8L1ugf7H3hXO8aDphB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8iTAydk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8iTAydk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F01C4CEF1;
	Sat, 31 Jan 2026 05:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769837606;
	bh=pE93mOE3ROvKWsUdTGhrdMaZIaCMbNOjj+VOr4ezq0M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=X8iTAydk/RqiszQ1x0d4KdYBNZCj5rjAK1XCr8eGjvgyk/2yE2lLRSWfxkBo1FOCD
	 BG6W2pjUeuAT+GFaKF7kUVXeTWxkGDQut3OZhR/9j3fbo0g830Wx0309ZqBMh2MgNa
	 xvnn7BWZQXar+Av/Rj1Is6888AsRXomgjTBbDUa8bKsHEyeYEh7mwoxty4QymLzriR
	 Kb8VKlfWYnstwVObDcAFCwLOXuW1z+18Pl71o11dYVrDltCA3NQ7RL0p7PleWUpEg3
	 guz/n7j4Yfi/a6zkddLoDjWjw1h8fkdbI64o+/SRkaZ/IjWQm0gNDJx7BAJzsNC6jT
	 uyjhxBY2PMIxg==
Content-Type: multipart/mixed; boundary="===============0051958228225853625=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bc860132eed39c90ac3599a9db86e80c781cce157f7edf455826d46260905a7f@mail.kernel.org>
In-Reply-To: <20260131050920.2574084-15-ameryhung@gmail.com>
References: <20260131050920.2574084-15-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 14/16] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 31 Jan 2026 05:33:26 +0000 (UTC)

--===============0051958228225853625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit d58597062a783f7c4b2997c007bb7178b268dd14
Author: Amery Hung <ameryhung@gmail.com>

selftests/bpf: Update task_local_storage/task_storage_nodeadlock test

This commit updates the task_storage_nodeadlock test to check for the new
error codes (-EDEADLK or -ETIMEDOUT) that bpf_task_storage_delete() returns
after the rqspinlock conversion, replacing the previous -EBUSY check.

> Adjsut the error code we are checking against as bpf_task_storage_get()
  ^^^^^^

There's a typo here: "Adjsut" should be "Adjust".

> Adjsut the error code we are checking against as bpf_task_storage_get()
>                                                  ^^^^^^^^^^^^^^^^^^^^^^
> now returns -EDEADLK or -ETIMEDOUT when deadlock happens.

Should this say bpf_task_storage_delete() instead of bpf_task_storage_get()?

The test code checks the return value of bpf_task_storage_delete():

    ret = bpf_task_storage_delete(&task_storage,
                                  bpf_get_current_task_btf());
    if (ret == -EDEADLK || ret == -ETIMEDOUT)

Looking at the kernel implementation, bpf_task_storage_get() returns NULL on
failure (not error codes), while bpf_task_storage_delete() propagates integer
error codes from bpf_selem_unlink() which can return -EDEADLK or -ETIMEDOUT
from the rqspinlock.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21539340647

AI-authorship-score: low
AI-authorship-explanation: The typo 'Adjsut' and incorrect function name reference suggest human error rather than AI generation, which typically produces more precise but sometimes generic content.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Both issues are commit message errors (typo and wrong function name) that do not affect functionality of the selftest code.

--===============0051958228225853625==--
