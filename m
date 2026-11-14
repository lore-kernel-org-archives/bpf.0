Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682213;
	b=cryMNy+eJte5NlMDafnRjOonFbTEWRyC6rHrW/UtFHP94hROPuFYs0yUoVwCQ2QZClM7
	 ghbAZ9laZh1zUJFWG0FH9ca1Obp5p1BtUKgxB25MedmSqCX0xBJWNU+xNZJKRFjrVK+oE
	 b6X8OKfVRU3pmV76fxDZVLlMn3czddgWcFuwJ+Hx0mtw/sGQNQ7vZ/DVrEh/5mIHrOnqx
	 pn5sZ2VBDNWJIMbj8pIH68yzsQR8Q+vREaFjTl4Amxc1fmEtiUi+MhZ+sVfSMSQZ5HtF3
	 6o0herEC5hTtkiREa4VmHDuCMThPfD48HsfRw0oArYE/ukm2+jhb1n8cFeXRGIPC5/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6xQJHpQerxueZgSogacTE7b0iwConrmYrNibhXyywJM=;
	b=lk3Se8t/z8HbnACbSJsoXrWexdjm/r0aRlQzD+OFsAm3hF60IzHmnAkoJ+L3fj81OpyF
	 biDQ1DSfBMIWskAXojWqaZN6RajP1WLbwTXFkQwicc60EAABhKfQTUvX7X4WLvhjv3q9E
	 17H1OraNlJdkrgyptqqDYOTACAmNcODaPZFK095iIF/GwALf1/FcRJlAz6b06mX5Ec8m4
	 7/FT1ZSgBjfJXChgx0whp8JJi+0coQfh09NyaSkxPDkMj1E8brVXbpNv7fJZoO1WE3yoe
	 DJ+av7kddWX8WTC99NQoJbv4nS5YraGWusEe6s9QsO+ASzsFh8lSy18kTyKSSs3G6ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1dFKZqc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537D606A33D;
	Sat, 14 Nov 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1dFKZqc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DCA1F000C4;
	Sat, 14 Nov 2026 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682213;
	bh=6xQJHpQerxueZgSogacTE7b0iwConrmYrNibhXyywJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e1dFKZqc6ctn8XmWc09XtrE5CdY6nmzuEi0RowNAYezXqQEv7SCtMeDhNaz1B6jze
	 GNS5PaOFyZ7VvTp7njEuRje7wKqwZHD4zQZtIyLiPwwqz9inZs8Ogf8c3ME5OGkYo6
	 swIOF/4YKrQ5hKlCbcijA4ZEJY0qk+nxqmM6wy0A3yhsce+mOSj2XbPPVyl0LwwPnV
	 z3E36fn1+KdXtymESnzlTXyWkcuNhhIzx79G5yX4mp2wM50AhGXcc3wfjcproqp6AR
	 +6fFS0e+M7TzA7I4lohPGnxVqTDlByTXL75CuW6sxp8s2xxFJV9zda1CfZk4q7ALC4
	 g17rOBs1N1g0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A37E380821F;
	Sat, 14 Nov 2026 18:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 cgroup: Don't lose errors in effective BPF_LSM_CGROUP queries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179468221178.2337414.12793151681977264587.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 18:50:11 +0000
References: <20261112183804.1171535-1-shakeel.butt@linux.dev>
In-Reply-To: <20261112183804.1171535-1-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, sdf@fomichev.me,
 sashiko-bot@kernel.org, kernel-team@meta.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Nov 2026 10:38:03 -0800 you wrote:
> An effective BPF_LSM_CGROUP query walks one attach type per LSM hook.
> __cgroup_bpf_query() sets ret to -ENOSPC before the loop when prog_cnt
> is too small, but the effective branch then overwrites ret with each
> type's copy result:
> 
> - If the buffer runs out exactly at the end of a type, the last copy
>   returns 0 and the query returns 0 instead of -ENOSPC.
> - If one type's copy faults and a later one succeeds, the query returns
>   0 instead of -EFAULT.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, cgroup: Don't lose errors in effective BPF_LSM_CGROUP queries
    https://git.kernel.org/bpf/bpf/c/e6cd32b8dbea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


