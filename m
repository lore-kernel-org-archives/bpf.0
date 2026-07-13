Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7458357D0C;
	Mon, 13 Jul 2026 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971519; cv=none; b=LU11TNcOkcyXFKQPtwW12eeYpDgJP4z23FnKlIqQ8OcG/WynRAU0zc4EFfNPCEtSP6H+jue3haistvNZ3m8vNxUCpYUE+rmaTSq5FcMsRglFrDjs4cOowN18iGSgCH89UbCzjNernHoh2zy9JYH1w83I+S/FmoukO4TUsHi87vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971519; c=relaxed/simple;
	bh=qW2Hb+gU+F8FqJ3dVJ8r9XlxYg3csqYe4FH25bVThBQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=f9xYv49xSuVS8rbDFr21swiaXbCNXnpIHAJoFFsVjspVXkqryTL+/KPrz/XSRS3MS30vNS/GQG00twpRqMjC15WnhjbLOPFw18ZgNZMBMNtqIufB0NmNTba0t4tGSq4IQpcks4/DohQ2vSuCT93xpptmp813paUPZYcLYc+cpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtQriQYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtQriQYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7FF1F000E9;
	Mon, 13 Jul 2026 19:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971517;
	bh=qW2Hb+gU+F8FqJ3dVJ8r9XlxYg3csqYe4FH25bVThBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RtQriQYRQtUs+miLQtEIQTNANc1ri/p5JLNb0uy+rPNyvBVLBNMEZi4pws3qJ0NzH
	 IdzuCUjhvlNWu/6n4czUIw5Dw9bmi2asnlK6OjMV5v6MmMgkWxMlxqK7gTNyRscJ8c
	 JqzgZ1EJKRb3jW6kaEJrj5PJcDzrBfHNRoLpdbXzlBhWIZyAvIqrhORGT25VD5RmX7
	 7gRqEnXFwolGSAV098TqoaJb20egRydaNnKLxaTwPlYaZfceUWvXexC55nUAjhm8kE
	 F5PipV/DbYvDnSZUuXVOmN+RSDMB0zdssRdbysy8PoYJzJlWOUNnA+mcAYWsV4S/MA
	 wv8z24I3QJzkg==
Date: Mon, 13 Jul 2026 09:38:36 -1000
Message-ID: <053a03ca896099034d6d583e8d566cc2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, emil@etsalapatis.com, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, bpf@vger.kernel.org, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET SLOP RFC 6/6] sched_ext: Convert scx_bpf_cid_override() to take an arena pointer
In-Reply-To: <20260713025916.68A941F000E9@smtp.kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org> <20260713024414.3759854-7-tj@kernel.org> <20260713025916.68A941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On the pre-existing READ_ONCE() note:

Agreed as hardening for concurrently-writable arena memory (in practice c
is a register-held local, so the reload doesn't happen, but READ_ONCE()
is the more robust idiom). This is a NOT_SIGNED_OFF demo; I'll add it in
the sched_ext rework after bpf-next is pulled in, not in this RFC patch.

Thanks.
