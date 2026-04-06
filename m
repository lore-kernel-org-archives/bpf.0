Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B540DFCB;
	Mon,  6 Apr 2026 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775447264; cv=none; b=akIuHTWoP06Fo5eZyZ9o1QSlZhri9ky/vMTBR9M7pSRg/1m4HXBFsP0L0mdSCfQ0JoZZFAMfJIa8Wpou96mRkkmuGeh/ZkYp039Q3r4iv5lLeS5Gb2zBSFyQhyfwQlVwoiM4AMWIxFEYG2LLSvydLtw/tBbJr11r5iz2+CcY4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775447264; c=relaxed/simple;
	bh=9BXHBOTCWdya0L5PFYubQfX2LAdXHzUD5zA97PeNOrc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CLVDhJW+lhhmQM2T+ZCWWdqo115cSJd8IClPyG455aopVGVAcYJOPUVkyJLtMlWhcq8wKirstxPo8CCEqc3CaAViZnQsRxItDobVw9v8bWUa1IF6PawxvZuaO5AvNgoXJWbHt5sBt9Pu4q6Fc35KS2UVrbV1RqnqNEXVi1R9Y2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdKeFnTP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdKeFnTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3420C4CEF7;
	Mon,  6 Apr 2026 03:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775447264;
	bh=9BXHBOTCWdya0L5PFYubQfX2LAdXHzUD5zA97PeNOrc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mdKeFnTPqwDg8oZynH5Bsp/A8+T9rR8oExgKFXyorugo+FPs7P0jaq290hogvEkwh
	 ssidxYtaOiFQCOK06/6ktGPuRTGi2kBw/kMkento77iZg6yuMNWsJQFvIRUBiCJWYi
	 6MEBv2ImZjCq5sJKhopgGZLqunDjCbejC9le5kWCR5g7eMcV53XuO+xyGaODwr503E
	 FvCXEnhPpaMk0rvaKjyWo59Hg0aZ9VRoiotkXxoQMaV6AZqZA6l/xdP6pC7gL9BcAZ
	 o3j8/grlvbL+cOekq7JSLQ6ap2PAcFsuwNWqbzO6L7/RQn+DMY7TPc74YZ0t+804fW
	 ELJV25H30flzg==
Content-Type: multipart/mixed; boundary="===============2924377954232874562=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <913274772cd62d8d93e6cfb2c251c2388b73f24f90d05be3c9994207ac7048bf@mail.kernel.org>
In-Reply-To: <20260406031330.187630-1-jiayuan.chen@linux.dev>
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,2022090917019@std.uestc.edu.cn,dddddd@hust.edu.cn,M202472210@hust.edu.cn,dzm91@hust.edu.cn,emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Apr 2026 03:47:43 +0000 (UTC)

--===============2924377954232874562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when dst_reg = src_reg")

This Fixes: tag covers the SOCK_OPS_GET_SK() portion of the fix,
since 84f44df664e9 introduced that macro. However, the identical
bug in SOCK_OPS_GET_FIELD() was introduced by an earlier commit:

  fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")

That commit added the dst_reg == src_reg handling to
SOCK_OPS_GET_FIELD() with the same missing zeroing in the
!fullsock path. Should this also carry:

  Fixes: fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")

Without it, kernels that have fd09af010788 but not 84f44df664e9
would not receive the SOCK_OPS_GET_FIELD() fix via stable backport.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24017481706
--===============2924377954232874562==--
