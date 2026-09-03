Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169381ACD;
	Thu,  3 Sep 2026 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788395473; cv=none; b=P+It1BST6LiByjh/mrhzr2xnPXOiBcgzIXDTfNN2ILwcoI+cuPwlYOevcDG1FoJGoVxamISVOYszKnkdg0XILExZdsVEU0JBlORSFBypcaVPK1Qv7ZyE3dD6sus5K470KMxEyWLAWKTL6Lzi8UzuO+o9q0gyd9kViA0O0MQvb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788395473; c=relaxed/simple;
	bh=uZ09Jbcs8wnH62nwDud5OVx7ACQ8C5gq1ZMivWN+xQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=phsdKDBw5imbyWLIKB7L1bc1SE2+55XojY++Z8tixwVdCal1xRUoR7QS39q0YgxO5b2tE4pqgq3NNNslRMUa9fBceBaPmUzMvtgGQCzq7g9gsZOzPAIO6Jz0vqWpymyWoMWjlXu4ibE1O4vq37eBcyp6j9egMz4mdxovfemAK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exRXPO0w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exRXPO0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302431F000E9;
	Thu,  3 Sep 2026 00:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788395472;
	bh=Z6Pua45J1wh+s4EtixcbcITnPEpe9So/qf+RqBOOd/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=exRXPO0weXFx+va+hkXBdiQbp+ch0IvDXCE79qopys10Oz/BNqQZr3qcWRyjVHXjT
	 v1OlVIjL9RkmYD5Wc1nVYVJ13nM9mMfCI1CFEHQxlt2iYJ5TvuMBpWGHZ4sxIDvVhj
	 P+TU674XQSrJD6M+iiHVuSorQIdxLDKIF0TqCImDwEUguScbpsnnnkqTrFD3kSGr1+
	 uoHQGruhAm1ktsJuh4c5jY97sukGhVKHIH5POv47WHGLbrl7Mux+bwSAqfBQJNXKII
	 G/s6pQ+OouIdGRaixZFeCvThnYLQH9fRuL261LLaI2oIDJxP28q3mF7vBR979CnTm4
	 glGWUaclOJ2Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19E0B3927054;
	Thu,  3 Sep 2026 00:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Fix debian kernel version information parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839541365.3016145.3676674062355526441.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 00:30:13 +0000
References: <20260831134537.1227914-1-sudipm.mukherjee@gmail.com>
In-Reply-To: <20260831134537.1227914-1-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 31 Aug 2026 14:45:37 +0100 you wrote:
> Currently get_debian_kernel_version() expects the version to be in the
> form of x.y.z but the Debian kernels uploaded to experimental are not
> always LTS kernels. Like the current Debian kernel in experimental
> is 7.2~rc7-1~exp1 and uname -v reported "Debian 7.2~rc7-1~exp1".
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> [...]

Here is the summary with links:
  - libbpf: Fix debian kernel version information parsing
    https://git.kernel.org/bpf/bpf-next/c/7bf591f26545

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


