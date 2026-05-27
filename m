Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5A3B19DB;
	Wed, 27 May 2026 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911365; cv=none; b=Ow1xmaZkgD8oS1Hnqe8k0aF9Xah43jMSyXkhb//LK08jqZxCyIoqBFfHwJp4urv2XqVwEI94Il96ATj/hubFFEJcp4IKDgqesedPca/YDL6V9HYNnRlQVDscKKenal0T1i/SIcCXH5C4fMDwC2HEaVfRJcqlx4nqetzv2kIilbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911365; c=relaxed/simple;
	bh=Jb5QGemEzr2Ow1OIBgpTeZj0Wu1VSG29ghYR1AhhT1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRdpxby32kj0G1sU1mPNhR2smJjH6HkXjFhbtviZc1dNCw4tsEav6JaKX+TMWjQ+puvTGGvCqRmuPkqgS/Q3hPYIBorg1KN7soEyIs5OefuSdhsuiO4ICCyCFZmDay2SXqzNfPSiE0sfaoxVy6l2w9i4tsGaKLHPSs8O7EohPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzeo38co; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzeo38co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4661F00ACF;
	Wed, 27 May 2026 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911363;
	bh=Jb5QGemEzr2Ow1OIBgpTeZj0Wu1VSG29ghYR1AhhT1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mzeo38cohRcK7fyckwGGR2eKTLeVuZOhfsYenQX832D3pQhjRz2Pai4Af2GAPGRYS
	 8KmSnp57fZ1Ohqr3r+I+A7SkbdlCubw9Ja/dwXR0m4m3m8tKA8pvxbe4Pg9TA/fLcG
	 LL+pQxFIneGiRNuu2piqmX5yxr+8AKt0nsuWhfVtq7mPoM0uSb+bLKcxRdzYXbvhrV
	 zGWnCJn9gUxYc6d6PrmlLoeZ9n9YhVKkgEnSB38NtDjmAZCZltQV0KGllbKEV/s7H0
	 dCV8Rg3ezHMaYyutbbegHc9WG+j4ZGVg2lN20WfuKnriFqmfH7oTap+awPz+rHYftZ
	 dOK/6eMt1YhHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	yangfeng@kylinos.cn,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	jolsa@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64
Date: Wed, 27 May 2026 15:49:01 -0400
Message-ID: <20260527-agent5-item009-tracing@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192012.76223-1-gyokhan@amazon.de>
References: <20260526192012.76223-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit fd2f74f8f3d3c1a524637caf5bead9757fae4332 upstream.
>
> When using bpf_program__attach_kprobe_multi_opts on ARM64 to hook a BPF program
> that contains the bpf_get_stackid function, the BPF program fails
> to obtain the stack trace and returns -EFAULT.

Queued for 6.12.y, thanks.

--
Thanks,
Sasha
