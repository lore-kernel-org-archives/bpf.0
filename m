Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDD386571
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791662548; cv=none; b=rWsDZDwrLSNd+3BX/ASLb5e2OeorZPdVlaZW6F/Ulq+yf/aBDDPHj365vSb1GGZTeiXK8NByu6KYHoYWg9ftKtxZLP0WIjgxNdeLBHx8b7uYc2o3kT4uG5AWpbE3lKYC+ArjkxVv97c9d66N7SQ1A792hTYwPUgfdOejmGatjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791662548; c=relaxed/simple;
	bh=gGCB0WPEet3hBv75jONs1IerdY9HGHiLxa1+0OFMkZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9mYQpOiXcMPtxYTeGmRaF7mu+TqiRSZcVFfb8wsBN+9jzTC9W/9LUGbO0U7XovcG0JGKKyA5B/GQ32tOsz0U901SYWyiPtscpBXjtbB4gyJlZA7U2GEx+DY9Yi7DSHUJRmPOz5G60LqAqCyvEnRTQaMmZ8RdKncVHmyzn8q9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx48OI8Y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx48OI8Y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-85377c8bc96so251724b3a.3
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791662545; x=1792267345; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gGCB0WPEet3hBv75jONs1IerdY9HGHiLxa1+0OFMkZY=;
        b=dx48OI8YHg2q8dG4GWGBKeF6WhzIdjDVh9J8C/q/7ngl/ut+g9xaA9pqwmC6r17fv1
         jihLhURWXUZE/kkU3++By0hghc+pliwgugSJhAM4reyCLQ28URAq9ubUB4z456EvRYUM
         PHxLuaTwso+KyN5e7lLvVsEjS6l2LtjYum8iOw7qGbBOv1+WOy6PMaCHMMry7ALbmKfr
         M1rjQE1dn1NSHceSJJ6MUcJzHjFl3mMWz2gYHHM10Glh4yQNzDNW8nTzuZyfzSeeIxvF
         H+ck1npT2GxVtOYvar+pv/wYLnC2Y6krJwC1YHq1NCNWaeM3vi97+GYnTzxINT7s9bON
         JZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791662545; x=1792267345;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGCB0WPEet3hBv75jONs1IerdY9HGHiLxa1+0OFMkZY=;
        b=yqnmRbKH4GwNeTB7o7TVt29oCH16efnRiW7cHnszqIVfP8zS/5e7trp5rg7KN6omAx
         23Nh85xcsM04vZhaJUUYjDQGh+1ihNu5+UMBVWCubE5hXtccchjTpHbuatbRWttQUl/p
         v2/jQnHRPHSnZsWCLKCa+iI/r1SEZ9m+ssbv83Bfwsvo5ClvSvtPlcbNmSUyWK6hESga
         yG6Rv2+KAI29JTkQfpKo44TjS/b/JVWgeBaEvCYrHmb6hYcOLLSUEF4lHNEAnDGv/8hl
         DPUvEW3kdVIvixNE+MS8qcpYi8G/CH1QM6E4kw/iCcklech0vCX0z465RurGC/mrf5Fx
         crSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpWHndVii1YlmA34ieAH5tFd5xhWvV+Ra1AtqiliktS6m5tG1FypiWw6m5NcKRmHD7Oe8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdp9rtmaJe6teJoII8CWkEXb4EIxhyUCYUNIARACg8kMaa0Z4U
	VteWbDyh2V5WetHDUHfUkG+E2Rm8htXaa1p5d40bGPn0Hs6UO3LktzZM
X-Gm-Gg: AYBFou3nl5bvnygJAk5mMR+ZLtrYfZkuPxwW5nDwqVx8esbzhsSJLZDMtqRikzj98as
	yNxdzNRvl11PWy9+Giqy/oGtEGXhrK7M74ENHt+aF4dM03g+AzKtlc75gULIr6+o4pC1u9skmUc
	IREjLBq96JsLSH3RQfT+dUdJnYF4tNiButRb7ZpvlC8T8YUEY1KauIDLCsqH90UI3W5EaU46YXW
	7Lx+JNKUKv+WTU+Fb3J1cbaKoomaDdumXEwlfB5octmB3cJkrWHm225TUB/XfEhkWj849GHovpc
	w/D9MwYTmdcEudDloy0+pZBHJxsRqfKkUopna4VtShn+CKO/YVM6kvRMvBCOW+IY357TwK61PPt
	lpq3geHzjyxUa3buQmXecmVe9Wlho04Nb7PDrKkRWLO6t3+aEXdWjtGj/2Dx6+hz7e753StgMg9
	yu0+S4RH07KYbgH6J1VLvTD9RwzCYObmWPqQ2adPpeCZ6aeh9Zif/hLDofc+XR38mMBZgf/q6qE
	JNiNyzdfrfV8t5LwKaEpHQbWg==
X-Received: by 2002:a17:90b:2d0b:b0:3ab:36c4:b4ff with SMTP id 98e67ed59e1d1-3ab3a747069mr4941491a91.24.1791662545218;
        Sat, 10 Oct 2026 13:02:25 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39238608sm9716284a91.17.2026.10.10.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 13:02:24 -0700 (PDT)
Message-ID: <4b4912cf5f30a3c6866a09511c9b5d3a427cb471.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 34/51] bpf: use SCEV to widen bounded loops
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel test robot
	 <lkp@intel.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, daniel@iogearbox.net, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Sat, 10 Oct 2026 13:02:23 -0700
In-Reply-To: <DM18UAZECYI9.1RYCRB2FYDW8S@gmail.com>
References: <20261009-scev-minimal-rebase-v3-34-bcba9bc53ac9@gmail.com>
	 <202610100928.qjEH6jQv-lkp@intel.com>
	 <DM18UAZECYI9.1RYCRB2FYDW8S@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-10-10 at 14:55 +0000, Alexei Starovoitov wrote:
> On Sat, Oct 10, 2026 at 09:25 AM kernel test robot <lkp@intel.com> wrote:
> > =C2=A0=C2=A0 ld: kernel/bpf/scev.o: in function `compute_max_iters':
> > > > kernel/bpf/scev.c:2062:(.text+0x1193): undefined reference to `__ud=
ivdi3'
> > > > ld: kernel/bpf/scev.c:2067:(.text+0x11b7): undefined reference to `=
__udivdi3'
>=20
> Eduard,
>=20
> the series is in bpf-next, so all 32-bit builds with BPF_SYSCALL=3Dy
> are broken there now. Pls send a follow up asap.
> Every u64 '/' and the '%' in compute_max_iters() need div64_u64()
> and div64_u64_rem().
> The rest looks fine. base/step are u16 and imod() uses div_s64_rem().

Working on a followup, will send it today.
