Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABF265623;
	Fri, 14 Aug 2026 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746676; cv=none; b=REdNOzFB6WUGK82E3/LhwTA2RYRV1ZjE/M5858SzDrVNfrzAEYpZMlIn42WkO8HX8+4yTuv0Y7AQUFY6Bnnc2Al9tDYYPelJxR5bt6xSjmoGK7fWDUTD77ziQQQNq08/nJzRkbQ5aP1l9wmDvUqCAZdUfJuPgoxa4CG1GBPVD1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746676; c=relaxed/simple;
	bh=s7LG9Aj+LxxDp4RAHkW5hBOMhi8foJ97j5AvJpYUhlI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SRfFrSNcPIsNIuXcDBv/51UAO74UFKXDurlFzL55BSaG2RJTWiPaWXm6EJrkVYC9M1uKF3lIthI9Vtzg0JMWd8se7uLJ8e9d5AvuKTWQi5CdYd788bTr2uitwxYFxA3rE7O1CauDR1ug5gxzE0lgEPveE7+FwzFZb+FEioYdbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQYvkQTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQYvkQTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266F71F000E9;
	Fri, 14 Aug 2026 22:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786746675;
	bh=pCQW0R8UcJh0fkVGU3e3u81hlddrhxklG5qasXSfEC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SQYvkQTM98nbDiMKDmeFKQ75exaoLf07HdBV6wNgz0PaBdhVTrQPUJKIkxVavdFv/
	 WuoTH7y9uF9puT7TrB0XSOAMdTXuU/cCb/U6B6/crz6gtC1l4wB2340Gyvs2QJFa5L
	 6SODG8v4ewG00UFfojEgj72O6C9hR0VtCo6J8oimnazIMDuS+ZgpAFjC1FfeXQox5K
	 /eNJnsa9VCf2fIQyilQlcs3ZPx+tg2THVQLd65enPxTQT8dshLA55RaUrt+dK/KJtl
	 NOgoHz93NWze52rYBGFXoI5McfCt0RpRCPNONfuCPbGtUi1j5BIG6tPTeAqlKASWt1
	 0+HuvxeFc2irQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B3D392445D;
	Fri, 14 Aug 2026 22:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 0/4] bpf: Fix ring buffer position wrap handling on
 32-bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178674662888.3982694.9316190652482491178.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 22:30:28 +0000
References: <20260814124843.22041-1-i.tellez@btesa.com>
In-Reply-To: <20260814124843.22041-1-i.tellez@btesa.com>
To: =?utf-8?b?SXNyYWVsIFTDqWxsZXogPGkudGVsbGV6QGJ0ZXNhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, billy@starlabs.sg, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 14 Aug 2026 14:48:39 +0200 you wrote:
> Patch 1 is v1 with the (long) cast dropped, as requested: pending_pos never
> runs ahead of producer_pos, so the unsigned difference is the real distance.
> 
> While looking for other places where these positions are compared as values
> rather than as distances, three more turned up; patches 2-4 fix those. All
> four are the same class of bug: the positions are unsigned long, they wrap at
> 2^32 on 32-bit architectures, Documentation/bpf/ringbuf.rst says that wrap is
> expected, and therefore every comparison between them has to be written as a
> difference.
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/4] bpf: Fix pending_pos walk on 32-bit ring position wrap
    https://git.kernel.org/bpf/bpf-next/c/6ff5b56a50c5
  - [v2,bpf,2/4] bpf: Fix available-data accounting on 32-bit wrap in overwrite mode
    https://git.kernel.org/bpf/bpf-next/c/3f611e9b820e
  - [v2,bpf,3/4] bpf: Read producer_pos before overwrite_pos in ringbuf_avail_data_sz()
    (no matching commit)
  - [v2,bpf,4/4] libbpf: Fix ring buffer consumer loop on 32-bit position wrap
    https://git.kernel.org/bpf/bpf-next/c/fdd4fad0bbbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


