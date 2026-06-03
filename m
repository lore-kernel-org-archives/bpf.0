Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B439A4DF;
	Wed,  3 Jun 2026 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501079; cv=none; b=NQoz4bUKSoQI6VeknzvvUPp5aRMMHtGNgRnerkS93aBApfdarDGY5vZ/OnyrHGGif0Grde3hHCT4St2BOpWwMRjDSdpiZYMG2umHXF8qJMMLzWLlLoI9i94qaTWib57V1FqUGoqLNLAaTQ+aMgZsckH86Ah8r/e1EYitRTNQb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501079; c=relaxed/simple;
	bh=UYIHIKXIz0+ejeQhFA2lVGmco53VrDzyB+IejbdghWU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ev2CM3TucUpbAg0BB/Yq60nCbY+8qzg/XpsX1k/M+jrVomNLImCqM9+6WJKQqZE2jduYVjvN2N7FhzLzOEs8ARQKcw69RqJOOgbQcDW9DAM7U8wjT5iXzCb8Y55oUnBmJYYJ+iFUHkkfpYJG21ZPWZCzhBpZauMqLO2PwjKIjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE7kZh+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE7kZh+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA0A1F00893;
	Wed,  3 Jun 2026 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780501078;
	bh=ADPgBjwcLjmyPGPP0rHgYcfV7gHxRwIPU6raHkwl1h0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TE7kZh+vWq4hksrlWdrAzuDuWvIMzdpVcgxs98uIQ1xzd9zDhBHGYy+1HelR2fSCO
	 BuGGH5lY1bG3H3EZ3tkF3a5a7z6NqgyN02Aml6uEdia1NjJcd3EtTRF/0luiwseHQx
	 CrjqnXD0bx6ivcq9BHd0Et9v4AubgfURTWVyGOJa4xHAPL0ikvrGy0piNivA5BeAvS
	 2tV67hmOD8enPN0hwPOfv54cDSbm+6Z887ZGgnuI11rS2SqjRbWacaQH9lzyQkJVob
	 e3tQKcPvGWrbMNh/gKIJ4oBaf7FLl2OUPrwRPWgOhMQtMrOjaA3IpRiuZQRwGbcjiE
	 gLWpwNQsRJ2Bw==
Content-Type: multipart/mixed; boundary="===============7932078082801127775=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d4a64c5dffb0ebedc7460a21a52f2d94af931fda6c21d039bd71327a4cf79fce@mail.kernel.org>
In-Reply-To: <20260603144518.67065-3-leon.hwang@linux.dev>
References: <20260603144518.67065-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 2/3] bpf: Check tail zero of bpf_prog_info
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,yuyanghuang@google.com,leon.hwang@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Jun 2026 15:37:58 +0000 (UTC)

--===============7932078082801127775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fix it by changing sizeof(info) to
> offsetofend(struct bpf_prog_info, attach_btf_id).
>
> Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")

Is this the right commit for the Fixes: tag?

The change avoids the trailing padding that exists because struct
bpf_prog_info has 4 bytes of padding at its end, so sizeof(info) (232)
differs from offsetofend(struct bpf_prog_info, attach_btf_id) (228).

That trailing padding first appeared when __u32 verified_insns was
appended after the last __u64 member (recursion_misses).  Before that,
the struct ended on an 8-byte-aligned member and had no trailing
padding.

b79c9fc9551b only appended two further __u32 fields (attach_btf_obj_id,
attach_btf_id), while the 4-byte trailing padding already existed and
was unchanged.

Would this be more accurate?

  Fixes: aba64c7da983 ("bpf: Add verified_insns to bpf_prog_info and fdinfo")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26893539599
--===============7932078082801127775==--
