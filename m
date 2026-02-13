Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A66231842;
	Fri, 13 Feb 2026 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009939; cv=none; b=VErn1k6r/u+vd5ftAW5P4d3UPbs7VbUuN3e6wDibuDs1pTdn3dJPnlkAftC7tDKDijBRNLao6VGsngONxKHmSA2a+c2xDINhGj6L0ceIcWDVBBbdl8MrefLEATqsfhoOzbd68wfMKy3dCFadMvnnoleju8hlcvfwErEUJZWo5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009939; c=relaxed/simple;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iAnecHqvPyqd0yWN3GOV67GbwErAnaWwyT2Imx7le2Z60Gx8yPMH7GPD7G8oHMgxBtdLkONUNBP4gjxpTRNMPvwZ0vGHRoSPNqQpbFgNkt7JOi1o1a1cHFLcQdKRKuZX2WE+/AcIJnbPXhrCEvv7tP81GSc9iMf2aNAotLKT5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q16OCO5i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q16OCO5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883C5C19421;
	Fri, 13 Feb 2026 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771009938;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q16OCO5iWgvSlijzb6VnkARpSwfOxABhSMKcj9Vkr7AZ8BOeQmDqFNbcRsmxE1pp7
	 u1EGoNtoaphxjm0u58VenMpzLLEe8KAuKZbuUAAuYdGu9F/QIWK9VGLufS+rvANyhP
	 L4fpNpP1ROwDfQfwVDKWJNDw/iaxMxUPcuUU2Txf9UJY6krD53JZvL7h1iuvMX/bfV
	 ZQehy2bD/uU9GW264pI8AT4jbkdd3jlr45DvJfIvsDsgDBRHr7b33hPVgY16VjDS7I
	 NwYk6g0nZNq8Rw8QXmYZ6twf0s/nHsbuXM1K0wjhuMHlTCh5vqyButU2bSBk/ESyPw
	 Kkp5W6O0W8HRA==
Date: Fri, 13 Feb 2026 09:12:17 -1000
Message-ID: <035ac0bbf6db23d178518bb502da28ba@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 bpf@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v1] selftests/sched_ext: Fix rt_stall flaky failure
In-Reply-To: <20260213182136.1388270-1-ihor.solodrai@linux.dev>
References: <20260213182136.1388270-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.0-fixes.

Thanks.
--
tejun
