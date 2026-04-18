Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A83491D0;
	Sat, 18 Apr 2026 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492651; cv=none; b=Xk5QuN9ZbLSpkWFu7UpCUbqMX/GUIaZx6FByoAzzBc4MW4wN37DeFM+x6ELE3KIuGCS3XZnB0OwDG1gG0vK8BYgsN3jdVVboU9unwgTsn3bbC/npmC/URfckkvQkU4DEPFRpHP4ayMr7OlU7JF/9RL+CfSs7pRTQ45UbckfMoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492651; c=relaxed/simple;
	bh=gVUy37L2XROh39IwraEoN+Vl1GEFdcPB3g8OiEXqNDc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FBIuLiTCFJ5MR57A2DgdDkrbvMlmJx3k1yzNT2q5ih1sJahDaQ7Alp+uXUwhyYpV0VO2MxlEQZ04/0PnvO17i3uZpuFE+UP/CQf58BwZU2j648SOG0btG6Y1RQ3Y95jNXSXfAkOcoq/nTjWZGE9O3UMEULdhCyD6YgdyHJkkxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cag0YEuA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cag0YEuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DABC19424;
	Sat, 18 Apr 2026 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776492651;
	bh=gVUy37L2XROh39IwraEoN+Vl1GEFdcPB3g8OiEXqNDc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Cag0YEuApb3Kkv+YD648GvN5a8MqqGQBeakOpjWheXlZndiCU5vSOP7gfmA99Ab2r
	 0Z0n422GaNsaZ8alCvWFjgiw8qfSajm8fjEIzaAXCb3rv9WuLG8oMq8ABK9XsUaRIC
	 fAAIkucHMmsEmdDSEI117tF4nTx/B04LziNprRth8kXJR4GW8gJ9uvvWJy6cZNhHRj
	 zbEkhtsgGi+izpAknI+UVryeosA5petHhthJgT+LoWTGfPCo42rDNDcxvksHqeXd68
	 iTEuM20oZTEui+KqAsS8iOdQ9xETqN8aZkrnVk8YKayTYic8Ocak73UQIhYYCARpDw
	 uDiU+rMnHNjsQ==
Content-Type: multipart/mixed; boundary="===============9047190102100080760=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <477612ee1f50f8ca6e18d8f1b76690fb9f8612711abc98d6d9963212463297aa@mail.kernel.org>
In-Reply-To: <20260417192502.194548-7-jolsa@kernel.org>
References: <20260417192502.194548-7-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 06/28] bpf: Move trampoline image setup into bpf_trampoline_ops callbacks
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 06:10:50 +0000 (UTC)

--===============9047190102100080760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 405d6ece5a34824f3bc154895a3415605c07b216
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Move trampoline image setup into bpf_trampoline_ops callbacks

Moving trampoline image setup into bpf_trampoline_ops callbacks,
so we can have different image handling for multi attachment which
is coming in following changes.

There's slight functional change for the unregister path, where we
currently free the image unconditionally even if the detach fails.
The new code keeps the image in place, possibly preventing the crash.

The commit message mentions a functional change where "we currently free
the image unconditionally even if the detach fails." This appears to fix
a bug introduced in commit e21aa341785c ("bpf: Fix fexit trampoline.").
Should this include a Fixes tag?

The suggested tag would be:

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")

This was also noted by bot+bpf-ci@kernel.org during the v5 review:
https://lore.kernel.org/bpf/8a315de2e20505875006c4e32af33c0838000a79484f7a2e44b1081187a01379@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============9047190102100080760==--
