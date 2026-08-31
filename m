Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3E4E8DEE;
	Mon, 31 Aug 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186782; cv=none; b=lquQuDJ6X6+8RdxQidv74WaBBcgtouxavwS9U/lIqtCVuJhz8lAGrOfYUCEqgia5HETb9yPjzNnXx0a6hzQ/8wYO9LxvKVA/ajVR2V1BRd0GTCKJKEcODaFljy5M1zsl2NIIqOiy1lrgdW73flveZpyBs4wX+v7V7bnKHHB6gjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186782; c=relaxed/simple;
	bh=L8RhlQFyPiBZ+TbEiSgbtHpc0i4DTh8+hs9quUtf2hM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XsZfCziXs3ATQSLfiGrzq5t7egQhnp4sxCqYkDOIqqcI+puMwz+0LZptYvIhA9q1wTAbOSmV65FjW5PfmJ0mOv4quB6fDv9cdjr6vAjJfIsFrx7Ao2mvPj/LaQtGL2RFsXCgIHFWeEXSTUTR8DCFrX63byby7UIVCUyY3Ix9Y4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3WraPmB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3WraPmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7331F000E9;
	Mon, 31 Aug 2026 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186781;
	bh=ioTcirFgjt11MJvXw07ZI60BuEgp2FCMyrIWw8Zn5pM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=E3WraPmBO2a7SYhC+/M9OesyUojyj79L0b/sc7Vr0uvR6MvxGm516Ky7WgLkU/vDA
	 FqI0oNe8nNkNqzxbrLvrzr4aVFEiJzFlCUHv57igvWaVejXLM34qi+QyMKTunNaJ3N
	 jri03h89AmR0WRWCFy3rmPnOyCKuAfjUW+N81HYCO8nPA5V/LihYXdwGLAZgqxO+Vx
	 enlFa2blAirUxjKE9q6uNd79RDbn30y0o0BECnWBz1wSxVcIJ0DFa4+aw90Ej8u7pr
	 dGFG8vGu77jy0MMP1XbpaYAh1yadcvOERZWAxYWqpfJYf+GJVYWYyztgbf2E3raxA5
	 YMVTUdMTVjBVA==
Content-Type: multipart/mixed; boundary="===============3553436697400353996=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0286b97409c113f28068c7d3866ddaa6a88852c7fd300786d1e62c8ac077b619@mail.kernel.org>
In-Reply-To: <20260831134537.1227914-1-sudipm.mukherjee@gmail.com>
References: <20260831134537.1227914-1-sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] libbpf: Fix debian kernel version information parsing
From: bot+bpf-ci@kernel.org
To: sudipm.mukherjee@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,sudipm.mukherjee@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 14:33:00 +0000 (UTC)

--===============3553436697400353996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Fix debian kernel version information parsing
>
> Currently get_debian_kernel_version() expects the version to be in the
> form of x.y.z but the Debian kernels uploaded to experimental are not
> always LTS kernels. Like the current Debian kernel in experimental
> is 7.2~rc7-1~exp1 and uname -v reported "Debian 7.2~rc7-1~exp1".
>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

This looks like a bug fix for get_debian_kernel_version() that was added
in an earlier commit. Should this include:

  Fixes: d1d7730ff875 ("libbpf: Correctly set the kernel code version in Debian kernel.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33399492426
--===============3553436697400353996==--
