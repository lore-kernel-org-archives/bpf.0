Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804023643F
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782091227; cv=none; b=bb4wKgDStiAdKZVoZ7hQyq/uI5et3wnD9RGCTQc+BKb7utdcyVg8VXefRR/iIecTRoQE52+EtksxyKSsNWpP7x5Q34Wtph2OqnDTARxNL/MMkSDVp+GruEMxAzN5kWmCH1/NbrtrgZvCbr4tW3YXMQTkmxgSof0oxLEHQ9M+eJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782091227; c=relaxed/simple;
	bh=El5knFlLWFMkEL3LzuJu+Pdbz1zKoe4HzYlvYYLdVCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GmffeRqGADGS2EzEOwExwpjMD7eAz3Cdgy/gCVGvJ0FS6Ihwg12+yZ2Z+k4MLVVEh5jW7ZdUAzl+wsj8O8mFj3QAjLvFjNPRVTWK+ohB7hHUoY3nalc0agTMqZB1/fA7Oimzjlg9xMXw+8XJxBpt1IUM9t8dXTGfW/cjcBO69Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1XiVTH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1XiVTH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1801F000E9;
	Mon, 22 Jun 2026 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782091226;
	bh=WWMuUM1gqdoXPA64UHlmr7N5X8ukPgYDfUTkH7UnL9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X1XiVTH6YnXmJYIaKbpJTdqrnH3bondVilifeHBwGz0BdKfRE4ta61/YpzzZq6u7H
	 kk1YmoccCm+IGkJ1Oz/Asvp+pUDwEQEwVUPFqvnsixVFcpTexrLFj9AWXV9etc7Jdf
	 41kMRqbNzNXO0HbsRFab4/9bHWdooVbGwnllWs9X4Hii5qTnwlGvfM3uVMen1owLyW
	 CWUTtH7C0qd2zRMnqH0vEIMWowi8A+VIU89y9Spp6D4klrJefpR9GZ9kLSLi3MlGeo
	 W2oAwgjr5bLfOoK61+LOP4EV/8Xq5AIWERwKNE93kT/ZvZEB9aXxh/9uRM+JIM7n5X
	 CL+nY7I5/D+wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E93AAA6EF;
	Mon, 22 Jun 2026 01:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix BPF_PROG_ASSOC_STRUCT_OPS last field check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209121702.561199.16045263806045910621.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:20:17 +0000
References: <20260618040934.4113938-1-tweek@google.com>
In-Reply-To: <20260618040934.4113938-1-tweek@google.com>
To: =?utf-8?q?Thi=C3=A9baud_Weksteen_=3Ctweek=40google=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jun 2026 14:09:33 +1000 you wrote:
> When struct prog_assoc_struct_ops was added,
> BPF_PROG_ASSOC_STRUCT_OPS_LAST_FIELD referenced prog_fd instead of the
> actual last field, flags.
> 
> Fixes: b5709f6d26d6 ("bpf: Support associating BPF program with struct_ops")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> 
> [...]

Here is the summary with links:
  - bpf: Fix BPF_PROG_ASSOC_STRUCT_OPS last field check
    https://git.kernel.org/bpf/bpf/c/8405c4626460

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


