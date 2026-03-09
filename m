Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DC3CC9E9;
	Mon,  9 Mar 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074698; cv=none; b=LF8pYch/opDOJWUZKhImm+6yZyMdGBeRIu3zVOXOfZWIuDtI3HUBlu8/4smIGQAthydRy8PqooRzRi1oQuwqNKInTbzj18/v7wFXzYspcLFhtpzbxD4N+e3CbIwPDN/EdquyJ6DC7wdJW21p5EBo9KKD1MvVJQCzdvZt1jbQIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074698; c=relaxed/simple;
	bh=RrWSWkbnyaPLrtYTEafjeh+wWEqYTVgF7BWWWC+jaaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9F29MGQDfeCotup15UJg5YkBqSsJjkY3x8j2ASr753+5P/htuIj66eAavsH1NNQT1vICk582NdWqc7UiUWrR4P4hGGw/ofWCcRdfXesZey9bLYKydiwcUIYyzH6aZ1qFcPyxHcCyNuWrV6+3dY/0fQ4yemqDCalRcKGOr+gYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoPEIp1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoPEIp1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2DDC4CEF7;
	Mon,  9 Mar 2026 16:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773074697;
	bh=RrWSWkbnyaPLrtYTEafjeh+wWEqYTVgF7BWWWC+jaaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YoPEIp1C4VBYQxiVV9rtX/3ex3Pbrnv95wdeQM2FUTvc2MTTKza9A4OMPTurKiKxX
	 LntyPoy0kAUSPG6Ait6PLbQdZEMFH3I65RUVJCXdiDOkFNRZOLnBkXAEO8SnSnA8A1
	 ORWm53h5sbzeCsDOysc3d1WTucGVv0Qu5GVkQLzu2TN50nyI+Qy5u5ibQoa2Eman/J
	 3SxeBVfFxJSskRtVjQu7NtkuTUhXiMMQYLK6HTjA0tb3kW36NN/biQiXGRlJ2jgyZN
	 Hv1CRVWoVoSZPI63Se8g7vluP+ZcFgyXBMC1AMj39y2+JTu6vPrpVZ4NCxsjmD2EOL
	 vAktRTgDiYhJg==
Date: Mon, 9 Mar 2026 06:44:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Zhao Mengmeng <zhaomzhao@126.com>, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, zhaomengmeng@kylinos.cn
Subject: Re: [PATCH v2 2/2] tools/sched_ext: scx_sdt: Fix BPF verifier
 rejection on older LLVMs
Message-ID: <aa75CBAMNtK-L-ew@slm.duckdns.org>
References: <20260309022847.106150-1-zhaomzhao@126.com>
 <20260309022847.106150-3-zhaomzhao@126.com>
 <DGYECIPVC266.25320R7256YJT@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGYECIPVC266.25320R7256YJT@etsalapatis.com>

On Mon, Mar 09, 2026 at 12:36:40PM -0400, Emil Tsalapatis wrote:
> On the other hand, maybe the extra compatibility is worth re-adding 
> cast_kern/cast_user to the code. I am slightly in favor of keeping it
> as-is to avoid churn, but can easily see why we'd go the other way.
> 
> @htejun WDYT?

Let's leave it as-is. The main purpose is to serve as an example for future
arena users. The benefit of keeping it simple trumps over supporting older
compilers.

thanks.

-- 
tejun
