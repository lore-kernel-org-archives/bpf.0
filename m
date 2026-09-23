Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FBA324716;
	Wed, 23 Sep 2026 00:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124985; cv=none; b=EqLe3h/2p7zUUpGh4jkH+QgY4nQFEPqvWxsaQNwfxqTeRKPxt7VmzPn6lY4PfjJ4hmUzMt2ZV9d/jentTW9po/Lk4grhfAVpMW2q5uoTMpVUypT9Sd0vHUp4LHYnAC3KTRgd1rkgphDzhQlpY8+9R7dufBje1TQuHXPmJYYXdlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124985; c=relaxed/simple;
	bh=KYNHXfY5BtHTM51WjFGh/UNhiK/RvcFAW72daT54pSo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QmyfOAHwKmgW1f6G0zCQMprgQq47jkXFAZUMzhpQM4PDnNyzVVu7ncIwYgVaqUf4ZFDkno/TG34o/KM8pmglT5SKvEgYuVods/UI4/rIoMQy/Z0q8oEhG4vDIHfYFkKuL1vhVYPyPBPMn+jklp/HPcoNlsqI6aGG5N65KiIdnq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIdmhvtG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIdmhvtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527621F00893;
	Wed, 23 Sep 2026 00:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790124984;
	bh=desWYYq2a015S2R7iHiJvf1IzuE6FLBtMN2F3OP+PCE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SIdmhvtG4x5KJfbVdIhrMg1GT7Tlch/0C6fzUuf342du6PtxHr3Rrb3KxUJAPoT4f
	 5hap6KpJVFtttB/YgYeKIhnRKxUEf5lgjhYBcaXuS+TovtNcSHSb/WJmiNlMBg0HNk
	 +2kk5EEUipuocggAGdbEh/XKpvjQH5lo8LQpibzryf714B3kTWrWtTwxXsahVnoYqI
	 M3CfDrjnA8XrJck9NJB78eE+L8N0KLaJCiYWxlSRlznNrzDvi94aEOjbcNDgCor6J3
	 YnFkOIkVClS/1PEzWxylIXwvBobdvAugiy69Yc/F86CtugXZ5ghNAHkTyKJ9TIR065
	 0mYEzqDBOJumA==
Content-Type: multipart/mixed; boundary="===============4492513471091339615=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f3525ba15027c3ab18ea5ad0b081dc086e758aaa9cf8854f8a61021f135fbb8@mail.kernel.org>
In-Reply-To: <20260923000801.1764758-2-donggeunyoo.kernel@gmail.com>
References: <20260923000801.1764758-2-donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
From: bot+bpf-ci@kernel.org
To: donggeunyoo.kernel@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,leon.hwang@linux.dev,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,donggeunyoo.kernel@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 00:56:22 +0000 (UTC)

--===============4492513471091339615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
>
> pcpu_init_value() initializes the per-cpu area of a newly created
> [lru_]percpu_hash element.  The area is recycled, so when the value
> comes from a BPF program (onallcpus == false) it writes the running
> CPU's slot and zeroes the rest.
>
> bpf_percpu_hash_update() passes onallcpus == true, which delegates to
> pcpu_copy_value().  Since BPF_F_CPU was added that writes only the CPU
> named in map_flags when the flag is set, so on the create path the other
> slots keep the recycled element's values:
>
>   update(k1, 0xdeadc0de, BPF_F_ALL_CPUS)  every CPU holds 0xdeadc0de
>   delete(k1)                              element back on the freelist
>   update(k2, 0xc0ffee, BPF_F_CPU | 0)     creates, writes CPU 0 only
>   lookup(k2)                              CPU 0 0xc0ffee, rest 0xdeadc0de
>
> Zero-fill the other CPUs on that arm too.
>
> Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

This isn't a bug, but could the sentence starting with "Since BPF_F_CPU
was added..." be split or re-flowed?  The construction mixes two
sentence frames ("Since ... was added that writes ... so on the create
path ..."), which makes it harder to parse on a first read.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35801690900
--===============4492513471091339615==--
