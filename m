Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0644654723
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201318; cv=none; b=rMJZNp/8teXyVCVS63BGbtW24OnnnOL6yg991mTe7RWXBFkausosUlj1JHKM6920uXx/2owuvwUStWNrf+dqiiqY6ycxOPDApGrXKK+Uw/zIOZOS7wxpJ2yH1QNXp9f/XC9Pxhn5oIrZWs4qOyqpsBIVzRR6pH2fAuD0IsefVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201318; c=relaxed/simple;
	bh=qn6kVVapdlTxdQCeyBZrq8aT0OPOVL88XZkgXGBXUMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FxNbTgPkjGxhOEAOelPPP+UI9iAYEhMIG8KFdOjw4MsIIrYghJ4kDVPswgr8UXkwdvzJzpAhXESw7MNcwMAOIypqGv4duOEzaoUs501EpNyAqF2xNuWIJudLnBn9oAUoF01nymRkvVoJReeCNCloqja1EW7agaPxQoTwp8yR4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlfZUDWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlfZUDWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC311C2BCAF;
	Sun, 26 Apr 2026 11:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777201317;
	bh=qn6kVVapdlTxdQCeyBZrq8aT0OPOVL88XZkgXGBXUMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dlfZUDWGbg1ITXuB/bNJA7akU63w269X2Yna9ITjrdgngtXidOjuPztsBMSWqYCwa
	 GJXNxDFVy/GrlR8DCj7Y7o13YLhARDAh3lSVMqTUvUH1BtZpIljvR2Qa9jzDN+iybo
	 7qELJmjhj22iuPU6DkqAaDeiKadOAaxmOipWYE6kbbRV0t3OvA0j+XQRiJepw44bYS
	 AbRUXV+uW30e7RQ3SOidolZs2Fl29zLrvESNxe7SgJZExZIRugBK7oftgOnPRSB7td
	 2L1DBA93Al03S5Mzz6Yhx4OncHu3LAzzbQ9Rd9HWnB5rUKZSOlp0YA2edI/ia2VQXI
	 sLZN1lvJ5iZfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] bpf, xdp: move offload check into
 dev_xdp_install()
Reply-To: sashiko@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260425105942.223757-3-jiayuan.chen@linux.dev>
References: <20260425105942.223757-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 11:01:55 +0000
Message-Id: <20260426110156.EC311C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] The patch moves the `bpf_prog_is_offloaded()` check to `dev_xd=
p_install()` to prevent bypasses during `BPF_LINK_UPDATE`, but fails to mov=
e two other critical validation checks for device-bound programs.
--

commit cdf088cb25c4b4a5606f82c9c927c40199abf2f8
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, xdp: move offload check into dev_xdp_install()

This commit moves the offload check from dev_xdp_attach() into
dev_xdp_install() so that both the attach path and link update path are
covered. This prevents users from replacing a regular program with an
offloaded program via BPF_LINK_UPDATE, which previously bypassed the check.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 7f95a7065dcfb..15b32b0db193c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -10463,10 +10468,6 @@ static int dev_xdp_attach(struct net_device *dev=
, struct netlink_ext_ack *extack
>  			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the=
 same time");
>  			return -EEXIST;
>  		}
> -		if (!offload && bpf_prog_is_offloaded(new_prog->aux)) {
> -			NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag =
is not supported");
> -			return -EINVAL;
> -		}
>  		if (bpf_prog_is_dev_bound(new_prog->aux) && !bpf_offload_dev_match(new=
_prog, dev)) {
>  			NL_SET_ERR_MSG(extack, "Program bound to different device");
>  			return -EINVAL;

Since bpf_xdp_link_update() directly calls dev_xdp_install() and bypasses
dev_xdp_attach(), are the two device-bound validation checks left behind in
dev_xdp_attach() also bypassed during a link update?

If a user creates a generic XDP link and updates it to swap in a
device-bound program, does the device-bound program run on the wrong device
or in SKB mode?

Could this lead to the hardware-specific metadata kfuncs, which are resolved
at load time to the target driver's implementation, miscasting the context
structure during execution?

Should the bpf_prog_is_dev_bound() checks also be moved to
dev_xdp_install() to prevent this regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425105942.2237=
57-1-jiayuan.chen@linux.dev?part=3D2
