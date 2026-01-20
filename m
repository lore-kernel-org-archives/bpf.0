Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401634EEEE;
	Tue, 20 Jan 2026 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938010; cv=none; b=ITZ6HpOrEoR02P/jr3piMEwT6HZ0SCudt7HqS0RwCf/TUTbqzPk8N5Q1yg5S4GSOBp2hYUgYJCEoGnvh4BpQYWBinnbOD1VSyksA+8doMR9IC2P0LT4C/yqX8aR60V45jzdHYgPVEAFLRtTvrotVu45lTynJn3U6pyvhrUeJmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938010; c=relaxed/simple;
	bh=WtaL0Xn5lyQXVQWFxizw2Z/z7YPMpfCyjvB5m9+GJcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJGNIqnAdoWukY/HG/XZRRkPslQ8WBOnToN9JEietV5/MGx/2Hs68UZ4e9NvJz8ogic4uQQXz4VcZD3LC0jskR8v+RDf9+PMLTKkC3L83jeHhRGJmH63DYADcP8CA+2eDh5AYwuvK7k1bRg/donrofyWHB87JykMaK2BCa33qwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT67epZ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT67epZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9AEC16AAE;
	Tue, 20 Jan 2026 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768938008;
	bh=WtaL0Xn5lyQXVQWFxizw2Z/z7YPMpfCyjvB5m9+GJcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FT67epZ9ldVmFLMzzf9/MM48/on5XEISFp5ITqZZ+ev5RymrzhS/5tBSat1jWJbIK
	 Lv0Q4i3kcV0f8qjzRHnrBEo2DYPSvJl+koMkNHpTIXWHwhCIjBGp4dhJqlSOco0EU+
	 C9EDRp/JQRD/94iLXGriJ15c3QzmAjGeoXoF62uq3DE8EfAZWUIZiS4WPsmzaKD6ae
	 uRj0K5z7LlV6OV9yjSY1HxCPI47QyifyJVcBSihwdpvLmnGZP/7OYzqmhQVg3WldyA
	 UgHWSKHtBO8Epnv/NbIMRnzhAc0ncl8sAFWT55wnbqvbi1I6L7oP+xLe+kXow0vJM/
	 pqiJs+2/BH0yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BDF3380820D;
	Tue, 20 Jan 2026 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Add perfbuf multi-producer benchmark
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176893800636.583014.14681617112813663191.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 19:40:06 +0000
References: <20260120090716.82927-1-gyutae.opensource@navercorp.com>
In-Reply-To: <20260120090716.82927-1-gyutae.opensource@navercorp.com>
To: Gyutae Bae <gyutae.opensource@navercorp.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, gyutae.bae@navercorp.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 20 Jan 2026 18:07:16 +0900 you wrote:
> From: Gyutae Bae <gyutae.bae@navercorp.com>
> 
> Add a multi-producer benchmark for perfbuf to complement the existing
> ringbuf multi-producer test. Unlike ringbuf which uses a shared buffer
> and experiences contention, perfbuf uses per-CPU buffers so the test
> measures scaling behavior rather than contention.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Add perfbuf multi-producer benchmark
    https://git.kernel.org/bpf/bpf-next/c/2e6690d4f7fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


