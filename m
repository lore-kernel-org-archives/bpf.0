Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479606;
	b=URrKq9dMt5oVOapwxJ801CHzBULAs3A0Ja+QHHCWOpDUIdc7oCN24Y2FgUhLK/1yNO5B
	 +NFA5LhjdA5P8eLGQyUdBWSwyAun3WRZcQ2Q05IYS5omxBVI39PkBGLms0mIVVgfiRv9N
	 ce8QTVeFVgKa4QQ4X+YyHD/uduqDBnjfgQdRk1ZUIWPjMZ8rMXGk7ykCfz9DT2aKFMgCH
	 53i5f/daXn6PsNfi5PDhqqfbYqcUaNjT82yUfWqUsJOga/8fPwm/yWZ3iWNy2Cr2KZUkp
	 ClfAs6cF4zqsTL4qWK0GjLhgMDpgYm5s8ly3Dm1Jy8+rwn1mZeq1OpwUDTaUwTQynxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9M+FWrKrCik5QdJN3oxEDrPvgZn7PO5/dJQX+JCnUPQ=;
	b=bSPqVxO46Gl+ZoKTukcpys36QaJJXEXf+bHgN2eKoj6HeA5lCSt8gCXEDWnWkwEQq45t
	 XzwNIEl2/h/ubrnAjCxDjdV8TLO9BVGaCW46tnG1bQJpGRXx66CE230jS8AbJCOt6LjgT
	 mClPKkdEARhN8ktjXsEnxPfIZZwv5fS3UrihGV9O5OxAXacrXcpEKcHZcSkXj7BvS/YY3
	 XdyBL0OYr6K/mgZrY6rPP8ws9z++Z/Vhy2Umf5vTRA/oumBWYDioQ1XCOY+WJNXNJvSj3
	 +HKkvEo54sT48N5cvfBdva1YTbq3U/ifDsDW3C/3DiTSN/ru4mgEvEDmVKHn3mqVnEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcysiHOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335A606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcysiHOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0808E1F000C0;
	Tue, 24 Nov 2026 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479606;
	bh=9M+FWrKrCik5QdJN3oxEDrPvgZn7PO5/dJQX+JCnUPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZcysiHOIm+8JRXsp1PqKit1gvTBK4LAt/xmJYV/vldeZ/zVttLQ0bZDgQWZ70ykv7
	 z92PV01a9QT0wsz5HOOBFbEWU/XYTt1GRvhnPH/ZSljOvu3h3XgMs3phH25mchEVXU
	 hBXqNIfPL+CE4UlzpzQ7ExlealKVdqAFvFbF1aIZQDrC6W/11FgbtkcY1dLBRk0K6K
	 Va2gI1wz9oTJjFEmzd3RPrPFE68ec12ATd+3VquDLo2x4r4wiVeXMIN3GEf/RuDdjN
	 H2nyGqgB7i6V0nP4KVXqU75kon8K4nir7mHDPw97UtnULOri9lsHdl2gIv1FLgUbgq
	 mgyqY/6/m8s8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16023930236;
	Tue, 24 Nov 2026 00:20:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf v1] bpf: Let the bpf_fastcall boundary cover the
 longest
 pattern
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179547960478.3195197.4647491669129488878.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 00:20:04 +0000
References: 
 <adbe7671c30f744adf6682d6431b9d818039cefb.1795462417.git.memxor@gmail.com>
In-Reply-To: 
 <adbe7671c30f744adf6682d6431b9d818039cefb.1795462417.git.memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Nov 2026 20:45:42 +0100 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> A subprog can have bpf_fastcall patterns of different length:
> 
>   *(u64 *)(r10 - 8) = r2
>   *(u64 *)(r10 - 16) = r1
>   call bpf_get_smp_processor_id
>   r1 = *(u64 *)(r10 - 16)
>   r2 = *(u64 *)(r10 - 8)
>   *(u64 *)(r10 - 16) = r1
>   call bpf_get_smp_processor_id
>   r1 = *(u64 *)(r10 - 16)
>   r0 = *(u64 *)(r10 - 8)
> 
> [...]

Here is the summary with links:
  - [bpf,v1] bpf: Let the bpf_fastcall boundary cover the longest pattern
    https://git.kernel.org/bpf/bpf/c/95d366cb5775

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


