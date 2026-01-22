Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669DC27E045;
	Thu, 22 Jan 2026 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041210; cv=none; b=DyL1oDiki+IXSbzAQbRLt2/jcSJNRMi9votlC95fo1x1ebQg9oyiBkz9XE9SyZoqGnTOxlnta1I0tepGYTuNiOeLU2XBEzMJbA8LGd3Ip2t6MYrTo5W8ks5G75Iy73JAF2Xixud3eZU6IcI4MG9q5/9sUoIFIZp+Lfb4fSc8diw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041210; c=relaxed/simple;
	bh=37JO7v6XexLsOuoWsTIFj1F+dcEiucnAfFYKvSvaI7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RvOooGbsriCyznMU0X0dkdijjVVjnqbu80Z0sYkYjsMO6G1BqRiOcbjzI9MexquxiG+2/HB4jTa3QfMAbaP+5H5V4DML8dMsuVrqN5L5Gc3nX0hhnN71F2cZFzhh/sDOJeJSRhoL19+uKJAg7q5dnOMzn7Bs6ecPSs+w8zaemvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB2CqJQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB2CqJQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DDCC4CEF1;
	Thu, 22 Jan 2026 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769041207;
	bh=37JO7v6XexLsOuoWsTIFj1F+dcEiucnAfFYKvSvaI7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rB2CqJQI+U0ZIckmvZT5pQ71RD+PdLjKuu7u993IAKSTxMH1LPu9QNRMbiqXKLsRo
	 p7McU3kYR906k9VL20Igt85ERey3bEB6YU42VWk14+g33fkVycp0nX89tapCH/Et5P
	 ulykZ0gGWBoYvHDGttD9PfWqvxnjXqvuK/7XOl5CTUE2mozQBYkQGAcIpYgesyjv5D
	 N66TFPNlcZMnFPZ/2oGHiVUEV4RQvbKDbv/Z7+rDPMEVRgSkwpVma62dbh2dieeiH8
	 LdTrtm6ALXKpiS8BB3oxislGlvvcpnwROZ1s8n+5iZoLvbPgpF8tfZGJtaIxB0NRA0
	 9sOIqJBznv+sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CD83808200;
	Thu, 22 Jan 2026 00:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Fix resource leak in serial_test_wq on
 attach failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176904120461.1495222.4452791683329838483.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 00:20:04 +0000
References: <20260121094114.1801-3-qikeyu2017@gmail.com>
In-Reply-To: <20260121094114.1801-3-qikeyu2017@gmail.com>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, yatsenko@meta.com,
 bentiss@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 21 Jan 2026 17:41:16 +0800 you wrote:
> When wq__attach() fails, serial_test_wq() returns early without calling
> wq__destroy(), leaking the skeleton resources allocated by
> wq__open_and_load(). This causes ASAN leak reports in selftests runs.
> 
> Fix this by jumping to a common clean_up label that calls wq__destroy()
> on all exit paths after successful open_and_load.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Fix resource leak in serial_test_wq on attach failure
    https://git.kernel.org/bpf/bpf-next/c/a32ae2658471

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


