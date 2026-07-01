Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8B03A543A;
	Wed,  1 Jul 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911409; cv=none; b=UR2nqJoGpNSHolJe0viWy2GkUzQpOFGtTJ1orGtJf0BUuNmQDItyJej3Xn8xfSPsehZYjtsHjNZl3/J+5TTtQhfYhfWqtHUQMiGnBpzQe68aYtvE2abaZU9vMQ2zX9cmWL7unMf2wycQz0m1AbGbBF9wD80pauJdAS+ZSiHpuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911409; c=relaxed/simple;
	bh=YugiDHEUyF4dY8PnUcx94r6GFAeIqtAxzhwokmwR01U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oc1Vt8AzifdaoTrxpZdLQx7YZdXttCuQJXPvoqgRusXkzcH8FyN5n/wHo+Y0O4c/0T7S66pkwHmsEJj735Fi+rr2jTztN2EBlYqG+fx+YRigoOJRfFlBgohbkgiMUpGvp/nJvhjT+0WL4eNsWbO0OMeqRpuQO5WVgqU32V54+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCDQpZUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCDQpZUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593981F000E9;
	Wed,  1 Jul 2026 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782911408;
	bh=M89A7IW5HZvd2bR4xKkGEnXro5Ph9g7DCb1ydyDxs5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GCDQpZUUEcPPIMd6qHROT7exvi0gx4vl2ajbIqw1hhDGr7rxn54/lTipvLGdmjxOm
	 leSqPDB1fvqHGo5lMXs528RLFMfTRkB36LCsClM3w0nzkpR5UPXdnNWYziPWQYfy/d
	 oiI/nzqNIhaQUyA6wn6o6koFDbCbcW+a7fsa3Gl0dFcdKAQZpdKPr0ib0uH//Im0+/
	 MWd+LMR5HfoUIDZLhGN7HKZz0J/sLkx4BrV3Ndgmr/aFpDpJPOFUTcaUsGU3AWPXBX
	 v9L5d0PmHl10NmaR+xWYsypQy6i4D4pb6ZXU/ari5d5q9ak3+2C0FQSEk1LrEugoH0
	 hc4rfQc7hEdoA==
Message-ID: <35754af3-9f0b-4fb5-94fe-ca0a24c72547@kernel.org>
Date: Wed, 1 Jul 2026 14:10:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] tools/bpf/bpftool: Fix vmlinux BTF state cleanup
To: Yichong Chen <chenyichong@uniontech.com>, emil@etsalapatis.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, jiayuan.chen@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <12A35C14DA710D2E+20260624025055.1574875-1-chenyichong@uniontech.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <12A35C14DA710D2E+20260624025055.1574875-1-chenyichong@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-06-24 10:50 UTC+0800 ~ Yichong Chen <chenyichong@uniontech.com>
> This series fixes stale vmlinux BTF state in bpftool batch mode.
> 
> Patch 1 resets the map command cached vmlinux BTF pointer when the
> command releases it, and avoids freeing the cached object from the
> map lookup path.
> 
> Patch 2 resets the struct_ops command cached vmlinux BTF pointer and
> dependent cached map info state after each struct_ops command.
> 
> Changes in v4:
> - Add Emil's Reviewed-by tag to patch 1.
> - Inline the struct_ops cleanup instead of adding a helper.
> 
> Changes in v3:
> - Add Fixes tags to both patches.
> 
> Changes in v2:
> - Fold the map lookup path fix into patch 1.
> - Update patch 1 subject and commit message to cover map commands
>   rather than only map dump.
> 
> Yichong Chen (2):
>   tools/bpf/bpftool: Reset vmlinux BTF after map commands
>   tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
> 
>  tools/bpf/bpftool/map.c        | 12 +++++++++---
>  tools/bpf/bpftool/struct_ops.c |  4 ++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 

Both patches look good, thank you for following up with these fixes!

Reviewed-by: Quentin Monnet <qmo@kernel.org>
