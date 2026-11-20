Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137607;
	b=D8qrYfRxWiCB3UU7hIoPeKV8YbU0YPb/mNMVKM8HyneAwBJ/tkMpySq2ZmPqOljM8M3R
	 cuA8vhBhdju12gcwXkqnSbOYV9t7r7Y+m9jcIfPg0r0ejk8Yv9WXXBX1zrkPPZVZPd/yo
	 aNsLf9oi20dEa933jtkN5eTK6Q7H+zhvKweOsqjs1XYjh22m6s+AB6KIFGzE/6ZatWzeC
	 ZPZyQkCyIpzDCFE9Tn4jHtIF8qadgQg4JdFzeHFAO9Gnu8DpKuNwfyvKP+c6DqrukSESB
	 FUIm/btCb8uWjjvIWOWKZSXv4l6p8hCFPTvgIeFVUSFpBkM2qvkgrM73ag6WCEdMm+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9Z8wkPM3+HFDw2I3yamjNg4DZ0B3gV029Jy3Uj3/wCI=;
	b=vbtD9pxuk8E1EqhqsfX7N4UZi2tJ8YZ8KksYI4TaiEgjNxWT153rcG1s1cF+or4LOVP/
	 V3x0kjSk6qUNVE4RSrdKKrm2E0g07eup9tJZWp0yPoJ1H1XuAQJK/08Nal8Fsf/rpYi6Q
	 iZhzXSeqEcxAmq3U0Lqi14Zxw9wWnnUaPk9jn+aycHmaJMq6XSiunDV6nn4rNNIJr27f3
	 g9lIfbSsilHtx3ppGlYtjATw3fvPfS4YSZ2snTI0LLgTlvAGgFdewcx/T0U+nOUPF/LmU
	 crZCAlUZuLL7nSSuGe6DhFLjlImavi40o0IgqFuFZRir0zFQ9sZAR73JYu5FVRGT2Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHrfIiry;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C330606A325;
	Fri, 20 Nov 2026 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHrfIiry
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1121F000C4;
	Fri, 20 Nov 2026 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795137606;
	bh=9Z8wkPM3+HFDw2I3yamjNg4DZ0B3gV029Jy3Uj3/wCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bHrfIiryZ2AZx8e2fITqETMUy9uRp1FNd/wUhYwXcbW8RZhwp+AEtfkYTXQGs8n0U
	 mDhmXtJnSlXfWmI3kpufC/rwQl2SSf/Yz4WbNrGm+JMXULw2qg9H98XnsfOzpjl3FN
	 Wg+e/wBmf2TBAZdBNg/U94qJsI37N+ZVcQS8Q4I2fCimjis3+Bi8seM5h0daKd1S+9
	 9z4CEgw0HCc8N9dg9Qy5C0F43d9J61DD57en/ZdcObapOZ2zORx7lMVEHjZuyQ20zl
	 RXke1yGj0pHTQbOovPWjK2MAiRnoFexWbJMjtXNMl4kQDvhAP5WVSMcd/lvPTMJQL0
	 YfUUZT1xXarYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B46FB3808209;
	Fri, 20 Nov 2026 01:20:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Keep memcg test page cache off
 overlayfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179513760554.3964806.409960549276615449.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 01:20:05 +0000
References: <20261119183925.1482217-1-lylin1023@gmail.com>
In-Reply-To: <20261119183925.1482217-1-lylin1023@gmail.com>
To: Kurt Lin <lylin1023@gmail.com>
Cc: zhuhui@kylinos.cn, hui.zhu@linux.dev, memxor@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, ihor.solodrai@linux.dev,
 emil@etsalapatis.com, baohua@kernel.org, shuah@kernel.org,
 jiayuan.chen@linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Nov 2026 02:39:25 +0800 you wrote:
> memcg_proactive_reclaim and arena_memcg keep their page cache off tmpfs,
> because shmem cannot be reclaimed without swap. But statfs() only sees
> the top of a stacking filesystem: with /tmp on overlayfs over tmpfs, as
> in virtme-ng guests, the check passes and the data is still charged as
> shmem. memcg_proactive_reclaim then fails in a full test_progs run with:
> 
>   test_memcg_proactive_reclaim:FAIL:reclaimed unexpected reclaimed: actual 0 <= expected 0
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Keep memcg test page cache off overlayfs
    https://git.kernel.org/bpf/bpf-next/c/82cc2b4383e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


