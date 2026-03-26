Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227130EF7B
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508790; cv=none; b=NicEw5f8Sd3ldpckBUsjyGTkTE4/VQta/ZlmMbB5eNUGtjxYF5awfKqSyNVuJ7widHwIOdlkc+ZwA+SusjR2Ut9FyvYAaA8bYhj7N15HzBdAh89vqMHdMtiZV3bnyNnbd1sZCceLon2RMSojimRUEqp01RUOoWJTy3uCEmF9cbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508790; c=relaxed/simple;
	bh=p35Ppid7WooocFth7UedYn45tcQgBZvP9jaMAc6zxjk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=faXQ/YBlBulBHCJeaYIT/ro5oLxdDPR+GgwVmgo17gTAeIuHEj6f8L0BbBDJbHn2XPIZZZqlUDl1KGvmXdiJ+MctyA04tsfOVhDoIkdVBI1PtuCgvUWuFatylM28MBXJ3BorXjJUp0Xas0ogelwkMc0MwgBLwcF2nhiWfDonmY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiXjEBnt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiXjEBnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ACEC19423;
	Thu, 26 Mar 2026 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774508790;
	bh=p35Ppid7WooocFth7UedYn45tcQgBZvP9jaMAc6zxjk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QiXjEBntqxq4mi880H85SAFF5BtcwdZ+SBrCqNAqqL1rWtfBtRODTY4oPxmijaV8F
	 WXR4tC7mAUcDeCSCAlJtJYYyDo2qwFgBXZH/ZWc374LXSzF6Y6X6ddB+HTAN3azOLb
	 SJ69UQNsJUVSp7zpjUczQpEE6EhPLA4GJCwN8Kt3GAOOqx+YauUeDYmXQsIkY5xvtP
	 kxQRB/psYVk2szI8io+5BSLp4Bt7R6PSB2xH4djItubzrph6OTThrVM3d2HldLnBT1
	 ciBMKY+jFMlq5+4kYrC9sT+GD1ODi8897iYlDYKy3nlJcK9lbnjio2KDSNQfnAlv6R
	 6UlRYiSi7zRDA==
Content-Type: multipart/mixed; boundary="===============0016585424754285156=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <59017ed5512ef222d3e1de906da03dc3484f32dab038ff2b4071075ede1d77f9@mail.kernel.org>
In-Reply-To: <20260326063329.10031-2-tangyazhou@zju.edu.cn>
References: <20260326063329.10031-2-tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf v4 1/3] bpf: Reject bpf-to-bpf call with large offset in interpreter
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Mar 2026 07:06:30 +0000 (UTC)

--===============0016585424754285156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit edad25b614a260b0d4eb28d8989f50afa8cbe64c
Author: Yazhou Tang <tangyazhou518@outlook.com>

bpf: Reject bpf-to-bpf call with large offset in interpreter

This commit adds a bounds check in bpf_patch_call_args() to reject
bpf-to-bpf calls whose 32-bit imm offset exceeds the s16 range,
preventing silent truncation that would result in incorrect call
targets when JIT is disabled.

This patch fixes a bug introduced by an earlier commit but is
missing a Fixes: tag. The silent s16 truncation in
bpf_patch_call_args() has existed since the function was first
introduced:

Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")

Would it make sense to add this tag so the fix can be picked up
for stable backports?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23581269665
--===============0016585424754285156==--
