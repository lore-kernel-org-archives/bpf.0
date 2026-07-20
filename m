Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341653B636B;
	Mon, 20 Jul 2026 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560237; cv=none; b=XpuqDbTbrwI6U7F8H8uWxOVPyHwJMkzlgi7WgU/Pry/qbP0aDgwANPL8/nWqQtwflFk84jvubH7Pi85sDFBHP2IIPnxwkFRfg6fVklSyKqHBLTVObUZ8Pm3NGwUx79AbtHvcYl3mnIqgHKe0HsmLg9mkoOM6jdhGGf41CDhIMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560237; c=relaxed/simple;
	bh=T1OfJu47RvqR9G0BvyBgMeYpNg1LmM7i+Tee13siJGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ftli3Ety0is2eGsuMz78MDKi/XRVqlj/xxwbMttfaOOUika+16bdC2n7dy4RekBMnPTHc1mLu4Xy0jgeKW5FwpQM/d1SfmxjsacBlNfh9zDgdjggLPBLOfEQuMKacojpywFMTqz1WWhDskZRrO3NcVQVSMPH99vVOaZzIuhU3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvYtZAbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvYtZAbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA29F1F000E9;
	Mon, 20 Jul 2026 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560235;
	bh=IOX+2A3v8clOWOGmTmZ70ydIzWqFq0wF0rKiaOBrTts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RvYtZAbLREUqpB2pdFvP4kFA0O6RFvHUQbExov3SGeriMYlUYIUnCqgHAdzUDyCUK
	 T8y54HF/RkD41tCLBNWtALqxo4EgC0MYunb54VXe5Al98yM2abPC0Q//kJ7lajDyQt
	 lkCKx/HhOGPgIWWDQLw1s4ZZr+DVlYD22ing4l+4ZMwpVRiNGK2uXgUyBHbzsI+IR9
	 3C1m2+BJ26jlu6G+rPvgS4NLyXXHl3GktA5jfUkObB25EH4OG9RCwiMK455ORwXuRO
	 Lj+vVKNoHq/0KfUOeSYy34K+jOo+vGmI0HbORZq0stjjOSaSZdWplKgDQWeZvDQFck
	 4iAGHoP37+QLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A5A392446E;
	Mon, 20 Jul 2026 15:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpftool: Skip prog/map that disappears while
 looking it up by name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178456020615.3589622.11318801874968451734.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 15:10:06 +0000
References: <20260720071520.396363-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260720071520.396363-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: qmo@kernel.org, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 20 Jul 2026 15:15:18 +0800 you wrote:
> Looking up a prog or map by name walks the whole id space. There is a
> window between bpf_prog_get_next_id()/bpf_map_get_next_id() and getting
> an fd for that id in which an unrelated object can be freed, and the
> lookup then fails with ENOENT and aborts the whole command.
> 
> Skip such ids and keep walking, the same way do_show() already does.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpftool: Skip prog/map that disappears while looking it up by name
    https://git.kernel.org/bpf/bpf-next/c/cfce77b63375

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


