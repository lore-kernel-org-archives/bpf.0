Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277452343D2;
	Mon, 23 Mar 2026 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275765; cv=none; b=DYqakZUlKlrmWu7UUKBT7LpCuRq/XCpOOCiRZZ3ZdDF0xbs6Kj8u3WTSqPcLS4EDH26j7kCSaazdgNzua+pfU2CxL4kpF05eNJvKt8nKlpwBdakgNctgMyQdBdN0YR7I4aAUp2lnjlUnQwPyiHhrE/uUcDUCSpozYfyuBuh95PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275765; c=relaxed/simple;
	bh=fCDOW8YVfLwwhSZHZXlc9n5HMGfkY4xAYzc8V7haNUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGVGIKbqdYgpjyZk61kAIv0EYAS9vGIK8AQtrVRGfN+wEF/yWs3MAFU7HKOCplaK6wwTiXkqlqgLbEvJwBK1KH3S+RVjLxPc1eL1xJz0IiH8INpDhyuzyz34fIp8Mgt/p1GH8DW9lRnBcbYheuPyFXGXWFGeVeYz2ybZjwUDAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECZAMH0F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECZAMH0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3210AC2BC9E;
	Mon, 23 Mar 2026 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774275765;
	bh=fCDOW8YVfLwwhSZHZXlc9n5HMGfkY4xAYzc8V7haNUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECZAMH0FYaAGD9vEsyC/FeptRdATGQpu1Al+Saa4UddaBxY+IEeKZBL0EvVWSaQsI
	 XbcMD5AI/uCwVqe39F+/QGEV/3BNwgiYDo6Z0MkXfzgxKGRAyr+G22xiaZjmTKkHcq
	 YfQoWD69R/Mg0EC+Z3DnY90eD5V4VCWgCMTQ7Oa9rVRwoeQviu4oKYPdN8kYvXpU01
	 O+8+VgLYd2DJhUPK0TU0AUZIIdBEUcuvkvZb3eIPZaibRQon+VaCo9GjYGqTFZUDzi
	 2prbas5clq7jRnHjRCeE9v6wA8wnawAclq9mm2a4rkk4bSBAfteqeWwVdxDtfg63JJ
	 GQtTQjlwCgD9w==
Date: Mon, 23 Mar 2026 15:22:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] bpf: classify block device hooks and add selftests
Message-ID: <20260323-reinkommen-insbesondere-57a29466ec10@brauner>
References: <20260220-work-bpf-bdev-v1-0-c53e852c4702@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220-work-bpf-bdev-v1-0-c53e852c4702@kernel.org>

On Fri, Feb 20, 2026 at 06:48:47PM +0100, Christian Brauner wrote:
> A bunch of new hooks for managing block devices were added a while ago
> but they weren't appropriately classified. Classify them and add a test
> program so we catch regressions.
> 
> Note that for whatever reason building the bpf selftests locally seems
> to fail for all kinds of arcane reasons for me. That might just be my
> fault. I added a pr against the ci to have the selftests run but to test
> this meaningfully it needs veritysetup and dmverity support. I'm not
> sure if that's available already.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

Is there anything left to do for me here or is that good to do?
