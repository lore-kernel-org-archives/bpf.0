Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068D3F8C7
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559629; cv=none; b=HqAm8hZWgXz7xyMCdSe5WTNMNGNimS2ObcHdkGVAz+ncQIANO4pJDVE7gXtDBQWaWauOXSEKkBNh9tJg0FQ72mdZHzzTs1jeoMeunYwBSMWILTa5gT0XuWneeP/YiyJRi/iTN1+RRiV+Nf9Hc//PHgJqBY5cr3aJmuGW7hFYyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559629; c=relaxed/simple;
	bh=Y72X1dy5aYMt4YHoHavDKchDlX4U0nuU8oQpCtL+KW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pP9/l8LoHN4LYFjm6+GamP5Wth07NfUckrITPE4ACiTt09juyXuKe3YS9T7RQokO/iAruCmqX7nDdhEvBqKfCZgEnSETDDOyUGwNCmJMUh1DwXyiO43O6q/1GKY8nJJ2Zz8jE/5QUsSPMKRgp3CRAu25IpUAcl7vf6Gld1K5tj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixgsunOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixgsunOR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F091EC43399;
	Mon,  4 Mar 2024 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559629;
	bh=Y72X1dy5aYMt4YHoHavDKchDlX4U0nuU8oQpCtL+KW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ixgsunORxQZWjQDDKNo8BMY5mUsmL4QknS1ode2t0A9krAGpqU/qri33Egmrv/Chc
	 cbdfczpbBQoOoF9CNX0zS6/g59g4Ct8ZAyytWPqWW+8zujnKGbqcsj6A4zpqC1APmV
	 FhXkFTdr3NsOyIRNgFsHwy9Js2UCn3igFqIwyxMvzf9svT20lfAw4DvTt4YmlRR8uE
	 E0z2zDVV1HQf5lQ8XnLW5NWsgTEFxNsgu8P8nq0VfbUpZhlVbbJ8KIzoKh+L+wouyx
	 Ahj2KgH/3Ept7RqmrxsqWQ9IwpYY2/GhW58xdRMg4J9VLgezIWPNOdz+QXN1Mmum3u
	 3WF6UFJmfcuNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DADD2C595C4;
	Mon,  4 Mar 2024 13:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Correct debug message in btf__load_vmlinux_btf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170955962888.27716.16741438027811072469.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 13:40:28 +0000
References: <20240302062218.3587-1-peterchenshen@gmail.com>
In-Reply-To: <20240302062218.3587-1-peterchenshen@gmail.com>
To: Chen Shen <peterchenshen@gmail.com>
Cc: eddyz87@gmail.com, andrii@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat,  2 Mar 2024 14:22:18 +0800 you wrote:
> In the function btf__load_vmlinux_btf, the debug message incorrectly
> refers to 'path' instead of 'sysfs_btf_path'.
> 
> Signed-off-by: Chen Shen <peterchenshen@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - libbpf: Correct debug message in btf__load_vmlinux_btf
    https://git.kernel.org/bpf/bpf-next/c/25703adf45f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


