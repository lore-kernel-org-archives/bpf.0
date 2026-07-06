Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60A1BC08F;
	Mon,  6 Jul 2026 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374422; cv=none; b=ifEkqVoayAnKRIaHs92aIIBZ+l+/ezfJ25ohJPvctXVpZiTGLqTjH7AmZegUnIMKZkYZPTwccT4A6TSf3RjxFHB/aFhAGg2OI8CpU5S/U3V8Lq8/oGEe4cj08f2RWPBwsfN5Oa+oQxB+4VBAtStqX+sgcMkwdCQ/dhXwAopfKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374422; c=relaxed/simple;
	bh=+I/I+hNzx9p1c+LisYe00lY2ixxkTMCuRmmQSwfCvFE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dDkZpcFRUOxv3OtVT8X041TpF0w8wtczpTt82p2P1ksw+rwUbto0UthvaaASlG3NpE8yVq4p956oRUftx396ZZFnpL68pI51FFPcaz9LfoLpcOoh4mG98GfiideHZ6W8Nb20UsDrnZAf+92WgGV6hKfJIh7zdGZWsZ31OldDjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnT+kkvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnT+kkvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDF81F000E9;
	Mon,  6 Jul 2026 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783374421;
	bh=+I/I+hNzx9p1c+LisYe00lY2ixxkTMCuRmmQSwfCvFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mnT+kkvdzUEvXTzFdrXM8dhd2yb/bjMVdGBip8S1mTYioVUz5zJyBATEmO24rgDne
	 A7U/M0Ptq4NRfiPhH4yDoV6zCvp886GnBzHIPgwJ2hz4LNsHiqPdBC6d/hqAftdfGa
	 eaxJArYhgKePVKYEZY+QMRS8oJ7yxBeoPQFq0MfWqzqvQ/WIzvTRi1QzYWic+a4SpG
	 WBIwUSlOYd9NLDTgZcuBS3FfOCfieiHDuWvUsloPNERFEsQ3+qLZvMg7yAqrpoVxJy
	 GVtJ8gG6Z0rJJfaImbnMRCJYDYmPb7QngPtMC4FeHCQkYk4DNUlG4YVNrBpvHefe0N
	 WW92ph6FTpPvg==
Date: Mon, 06 Jul 2026 11:47:00 -1000
Message-ID: <a1c67d2ea1af003ae656c9bcb482a657@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] workqueue: annotate racy sum_exec_runtime reads for CPU-intensive detection
In-Reply-To: <20260703-wq-sum-exec-runtime-v1-1-a26062e6de8b@debian.org>
References: <20260703-wq-sum-exec-runtime-v1-1-a26062e6de8b@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to wq/for-7.3.

Thanks.
