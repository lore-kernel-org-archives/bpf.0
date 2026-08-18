Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B3383C84;
	Tue, 18 Aug 2026 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017867; cv=none; b=HRHBEl+miLf9RxW5ZrjtycRTBWvX0N6mlU0p7cBaJ4tUaxEAbCl6msS4B7cti5VmcppLT4JQcDwy439iiBLxZWI+/mE29fYGL4KM5PqocVSHkkn2he/KNyuhV4WUKMecEWC178m4VPYhGpTBBAPN8ZvXkfwSyYG8ZybCxMIbF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017867; c=relaxed/simple;
	bh=igRArZ2i4roiNmdwhvEFLwQmYqiwPYGoBOgIe3jV8gA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qv3aPCN6s2Peg+tkFNF8UsueJ2y/XbKBV2wvYdi1Mx9/+i1K0QnSnef4RIF/RayG6Gh1atkOGqxaezx3ttc8oh1nQrRKieurCpzqYDgc0VQ80eWqUoxoz2o9D2Qow5T52a3V4/GolL2CwwZqNZMfjDmDA5tSH5GV+JQJXwvYo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6BX7rZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6BX7rZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF51F000E9;
	Tue, 18 Aug 2026 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017857;
	bh=Fvbrn1aXo30j9jxx4MuVF8QgK0PXNr0H+kIxjzXnfQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W6BX7rZrCB/HEEAkLCf3OSrXpBM56JEQx8YJtQX5pRF5XDXxHp1py0id//bgZro0T
	 lK0hK0cnO/4blXGCIAlR8/5kkeObAiAr7ZZGaP2eKuOHHOLrnYvhhMYV95zTBCLTet
	 HE90x4dRWj7C8/O6drItMluGc/heL3ZH0JtcqV9tg+iWRbDMUX32bbIEt4WT51v+OX
	 foDJlley0neLpNx9k93voGRNKG0LI/PVdFvchAt8CaUKICQ/TIlAoOy8JMl17pDxe/
	 wgc53UlUx2Qe6kPdAUpHd8fRrKWmM2MiQZgzQMCBMwHKgBwMGUefnyj2LXSMrnleZo
	 Qzs435eGq0zWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197643926279;
	Tue, 18 Aug 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/15] gve: AdminQ mode related refactors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701780989.1825555.7271508314306523307.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 01:50:09 +0000
References: <20260814021406.3044324-1-hramamurthy@google.com>
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, nktgrg@google.com, maolson@google.com,
 thostet@google.com, jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Aug 2026 02:13:50 +0000 you wrote:
> This series is preparing the driver for the addition of a new control
> plane mode(MailboxQ) by commonizing and reusing as much code as possible.
> MailboxQ is a new control plane infrastructure which uses mailbox queues.
> This is a new control plane to communicate with the device when the driver
> is running on bare-metal instances as well as newer versions of the device.
> 
> This series contains 2 main changes to the gve driver's existing control
> plane(AdminQ):
> 1) refactor some initialization/teardown path methods to make it work for
>    both control planes.
> 2) add gve_ctrl_ops structure to the driver for various control plane
>    operations
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/15] gve: don't pass in unused parameter to gve_adminq_free
    https://git.kernel.org/netdev/net-next/c/063aeece6053
  - [net-next,v4,02/15] gve: refactor initialization with helper functions
    https://git.kernel.org/netdev/net-next/c/94afe5cebcd2
  - [net-next,v4,03/15] gve: add a few helper functions to set device properties
    https://git.kernel.org/netdev/net-next/c/69886e8085ab
  - [net-next,v4,04/15] gve: add struct gve_device_info to hold device properties
    (no matching commit)
  - [net-next,v4,05/15] gve: introduce control plane operations structure
    (no matching commit)
  - [net-next,v4,06/15] gve: introduce ctrl ops to set vectors and Qs
    (no matching commit)
  - [net-next,v4,07/15] gve: introduce gve_adminq_get_device_properties()
    (no matching commit)
  - [net-next,v4,08/15] gve: refactor gve_init_priv for reset path
    (no matching commit)
  - [net-next,v4,09/15] gve: simplify reset logic
    (no matching commit)
  - [net-next,v4,10/15] gve: add gve_ctrl_ops for gve initialization/teardown sequences
    (no matching commit)
  - [net-next,v4,11/15] gve: split up notify block allocation and setup paths
    (no matching commit)
  - [net-next,v4,12/15] gve: introduce new methods to handle IRQ doorbells
    (no matching commit)
  - [net-next,v4,13/15] gve: setup and teardown management interrupts
    (no matching commit)
  - [net-next,v4,14/15] gve: add ctrl ops to for queue operations
    (no matching commit)
  - [net-next,v4,15/15] gve: add link status/speed ctrl ops
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


