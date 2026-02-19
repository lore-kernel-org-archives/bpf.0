Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934634A32
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535735; cv=none; b=ukbe+gZ/O21fSNGOuFW2FMkx9zoH7eykq2VUcG2sxA8mtCuOnGfHjK0Y1t+7fv9gvwv7CUugATL7tYkqbqTOhUqD3jfgn03Wzj/WTBPS38XHy4gJN4YL2kmzDIp15GpLJfLAvf0+1GlRo/yLmnef7Myj4C4TV/u9aQu1cZZjx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535735; c=relaxed/simple;
	bh=aQR87JmPUwmmEU3f4PRcuW+EBUF0PmDwUrbDFJOsGJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mlGlPQVE91EhCPAXTwIAvNi+8vhrCuznMZjV7y7k5pyJtst0dnZ3absO5g/tz1HfPC7Y2T+uC6rjP6dMYHKALY3kNIWsYYQVeWm7qKWp9rINdeJdJypvKnw6FdB5yaxyobpVsChT3co9PHnz248TbRdajmWiLltokpfZH9iw+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNhwBAzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNhwBAzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32523C4CEF7;
	Thu, 19 Feb 2026 21:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771535735;
	bh=aQR87JmPUwmmEU3f4PRcuW+EBUF0PmDwUrbDFJOsGJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aNhwBAzBE9tBl8GhpbhKbxBgpn/m6aufEyGLgbVKOVgSvub+7ViIXhrvIr3bijdE2
	 VGa53FhDmX9UIIbMEPJeZSerZxemXrAtZ3F44tXibIMoe33CDeoYP4+k0gLbNiwyPm
	 2KoOEPffBU6x+r1voL5VwKluY+eKUcU4m9pvcgR4XUSCYVkKg/dj+9CP6d4dQYlMjq
	 EXSaRL3dYOMr1DwlJUKcuYPd1hEbImqOcQlB/iu1NW2iEBfnIUnLYVex7Clzaxtm2U
	 5BWJ5b7+N+0h/4mZfK2wNod9N2psWT/Lxk9A7/WxwACbII2aJF4obm4+4Mq3u/n2cE
	 7B5eiEVEOw4jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D543809A86;
	Thu, 19 Feb 2026 21:15:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: fix flaky build_id test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177153574378.67400.13045669900937971712.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 21:15:43 +0000
References: <cover.1771338492.git.grbell@redhat.com>
In-Reply-To: <cover.1771338492.git.grbell@redhat.com>
To: Gregory Bell <grbell@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 17 Feb 2026 09:32:35 -0500 you wrote:
> The build_id selftest intermittently fails with the following error:
> 
> 	./test_progs -t build_id/nofault-paged-out
> 	serial_test_build_id:PASS:parse_build_id 0 nsec
> 	subtest_nofault:PASS:skel_open 0 nsec
> 	subtest_nofault:PASS:link 0 nsec
> 	subtest_nofault:PASS:trigger_uprobe 0 nsec
> 	subtest_nofault:PASS:res 0 nsec
> 	subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1 != expected 2
> 	46/1    build_id/nofault-paged-out:FAIL
> 	46      build_id:FAIL
> 	397     stacktrace_build_id:OK
> 	398     stacktrace_build_id_nmi:OK
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: fix flaky build_id test
    https://git.kernel.org/bpf/bpf-next/c/d820fa311482
  - [bpf-next,v2,2/2] selftests/bpf: align build_id test mapping to 64K page size
    https://git.kernel.org/bpf/bpf-next/c/18a1d365e825

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


