Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D094756C4;
	Thu, 20 Aug 2026 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235697; cv=none; b=inXSoyGjWp+lzVjt4n2T3QY+EEVJK79yRAzxI2gVE90TYojuA6UUX2W1Kp8q3er8RhfSfuGQ7mjJuczUlUCZVwEdfX8lN7NRTK+ggr7nF6jQVRkSZg1LkajHdx+XPPCpI4B76zrSCK027kVMFI6V7jgNUaVyoCUkQ+NYjyHv+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235697; c=relaxed/simple;
	bh=5CxUmKEVi++wyAkDYX6+cqGMVDK0FLAe1j7nQJZ1V88=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PU+mJDY2oo/XfI8jW2LdrqQTAC8fF0fDSA6SRttdPZ+2aFFTdP9rD16CJ5LfNm1ie8SLrTDGtNmuNWcS0c3YRV6Pxn/UxMI0nlspyE2O6w7Pfip7yhc9Ol8yTfATWJUs/LxVnJCEc4gZvS3+eVICzdme5aahOhNiiI79rph4lq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWmvxwoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWmvxwoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650321F00A3A;
	Thu, 20 Aug 2026 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787235694;
	bh=5CxUmKEVi++wyAkDYX6+cqGMVDK0FLAe1j7nQJZ1V88=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QWmvxwoVRXwSH+ba8lNb2j+x+lByMTvoH33o9NUzb2tVdKrWD88b14RuMWVl7UBCt
	 Bg3R9xOkIFiVfJ1XfJIqN8fDxc47p5Zq24fGQGS54f2WsNmx9mSVzsVE5clsbuRMck
	 ezYXewED8TpwPhd/6idLkCvtz8MJe8QMuP2tcVoh5X3VyUvamaZR5jlVBepBevB4Tb
	 33w/9A6AkvlaBV9oNz+Yv+gzgcz4IFhYJTUjbhs9zyJg1eeiSyr7lw55xC8SzbYdf/
	 XY1fNXA+Y5YDPi6beqKKX78e1H5SpVPMQsotUG/0HgcfPb51MC72Z836y9F+ubDhDP
	 8MV5hzN6Qr8EQ==
Content-Type: multipart/mixed; boundary="===============2268151016755920420=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1355a0a05ef4ae8bf73f6f0392604df78e2d64995cb5e54cea3be01d2cd5e454@mail.kernel.org>
In-Reply-To: <20260820131801.68759-3-tasos.papagiannnis@gmail.com>
References: <20260820131801.68759-3-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Add user memory access kfuncs for linux_binprm
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,utilityemal77@gmail.com,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 14:21:34 +0000 (UTC)

--===============2268151016755920420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add user memory access kfuncs for linux_binprm
>
> When security_bprm_check runs, the arg and env strings for the exec have
> been copied into bprm->mm. The new address space has not been associated
> yet with a task_struct until exec_mmap(), so existing BPF user memory
> helpers can only read from the calling task's old address space.
>
> This patch adds bpf_copy_from_user_bprm() and
> bpf_copy_from_user_bprm_str() kfuncs. Both use the mm_struct provided by
> struct linux_binprm.

This isn't a bug, but could the opener be reworded to avoid "This patch
adds"? Documentation/process/submitting-patches.rst asks for imperative mood
("Add bpf_copy_from_user_bprm() ...").

> Register these kfuncs on both MMU and NOMMU systems. On NOMMU systems,
> exec arguments are staged in bprm->page[] rather than mapped in bprm->mm,
> so the kfuncs return -EOPNOTSUPP.
>
> bpf_copy_from_user_bprm() has similar semantics as
> bpf_copy_from_user_task(). bpf_copy_from_user_bprm_str() copies one
> NUL-terminated string and returns its size including the NUL terminator.
> It accepts BPF_F_PAD_ZEROS to clear unused destination bytes on success.
>
> This patch registers both kfuncs with KF_SLEEPABLE because accessing the
> remote address space can fault. This allows BPF LSM programs attached to
> security_bprm_check to read arguments beginning at bprm->p and reject an
> exec based on its command-line arguments.

Same for "This patch registers" here -- would "Register both kfuncs with
KF_SLEEPABLE ..." fit better?

> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32375104040
--===============2268151016755920420==--
