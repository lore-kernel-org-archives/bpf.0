Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AA30B517
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530117; cv=none; b=A9+XFLOm5aSMll7+N0f3Fpy7zBHbh4f/KBCo2MJAiR/6zAx4tGslALgh9YG33j1MnlDiN4MlyDLLRn/yfMs/uXvIN0cLNaceX14wg3CoCVP8/2g8rfA3tRsM2Gy5jVIEnwWZ+JTQEFQpDo8b1iIN+l4ZBTvff7ofRmt+Ynt2lCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530117; c=relaxed/simple;
	bh=R1R1fQrIrSyavfFFKN8R4ZuBgs0ZJQl9FGfoSBPnZm0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jr1hOR5IHfUTmzF6QLFJsoywhu8To1RZIACWIXDbnFC2DJ/k47C5XcxW7+p1gVBd0ixRoafqCLEJ6pfp9Z27rHsDActE8BYJjRtxUadC6nFBKlgrmybGpT/KGOyfCRdKuaYC8hj4mNE70kfbIOV7HvelAikpeEQNrEqVIJxif/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAdP+e3n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAdP+e3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0322DC116C6;
	Tue,  3 Mar 2026 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772530117;
	bh=R1R1fQrIrSyavfFFKN8R4ZuBgs0ZJQl9FGfoSBPnZm0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nAdP+e3n0VacGX0ggvA2daOJEB5e+2bW95K4pdLFQ7c/S1vGKsRpCAszHoLeAEWw9
	 7+NcG4+Tpb/WXQVGv1WaPkA4xnGXjfMVs9RPPnw9+Z/ty4+nnoNar3FGbgbJcyt8rh
	 Dv1KGk86ZuRxk6snz4TALsqwCP3YwsqD0ZO9xcsWT0XhLViz8JyIXhsp02EH09RsgB
	 0/a9QehnNk3Yq/E6CGr+HIYMdNr7qrOCuWbat4i+hbgA3+cGyzLqTQ4imdFFs74qO7
	 5V/XlWyADueCmHUAXtjVTtF8NswzHzV+yG+y2sWPjnTcFJcmLOHjOl0Rhbc/UxMMk2
	 oIgTs/risX/MA==
Content-Type: multipart/mixed; boundary="===============0783967128459916217=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73e7c1b535284b3b65b44534db868fd5d8cee5530821278c07b8c64a46ce79dc@mail.kernel.org>
In-Reply-To: <851F26B7D9E91336+20260303083626.1107524-1-xulang@uniontech.com>
References: <851F26B7D9E91336+20260303083626.1107524-1-xulang@uniontech.com>
Subject: Re: [PATCH bpf v4] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
From: bot+bpf-ci@kernel.org
To: xulang@uniontech.com,martin.lau@linux.dev
Cc: andrii@kernel.org,ast@kernel.org,bot+bpf-ci@kernel.org,bpf@vger.kernel.org,clm@meta.com,daniel@iogearbox.net,dddddd@hust.edu.cn,dzm91@hust.edu.cn,eddyz87@gmail.com,hust-os-kernel-patches@googlegroups.com,ihor.solodrai@linux.dev,kaiyanm@hust.edu.cn,martin.lau@kernel.org,sdf@fomichev.me,xulang@uniontech.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Mar 2026 09:28:37 +0000 (UTC)

--===============0783967128459916217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim

The subject references bpf_trampoline_unlink_cgroup_shim, but the
change is in bpf_trampoline_link_cgroup_shim. The commit body
correctly identifies the fix location:

> To fix this:
>    Add an atomic non-zero check in `bpf_trampoline_link_cgroup_shim`.

Should the subject say bpf_trampoline_link_cgroup_shim instead?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22615516146
--===============0783967128459916217==--
