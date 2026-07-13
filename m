Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9900357CF8;
	Mon, 13 Jul 2026 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971517; cv=none; b=jTQDUYeYiviDsyTLXIEiTBYa2q8kojNtPklOjoAnAnjSn7juFhCoB2UxL2bRdc+aKX72rjJf8G/YQSbz9t5sL0qkjtNaZN18KM6SgIYacVOAyiKcBLHisBV9yhLrGkr5B9dT2l+fVuCRY5zFAeqfdmkKytQgx5lZHbAuv9yEQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971517; c=relaxed/simple;
	bh=nRGnWL2Mt/tUTUZWws119yvJQ/gHv1a10i5PqXd0xpE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gW34JXLEzAvsENxxIl8OTkdH9327q+GEA/qgyFw0wxgRfPmZRRglBxRzJGJ0gyUoS1Y/tvcIcYxQy5vbG9Z3VpQ8+oG4gJPtpFNHOVumQh00MST/oTed3cMIN073ejmtVsbudOT+QaKVEQAx7N6fxN2+GQDuNHue7/onCGHwvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QasFmgY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QasFmgY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594DB1F00A3A;
	Mon, 13 Jul 2026 19:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971516;
	bh=nRGnWL2Mt/tUTUZWws119yvJQ/gHv1a10i5PqXd0xpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QasFmgY6EyLyovIr1M4pOH/RdU+TZu+ZdjLQmCMCHCByRFAnOPVvZWA+e3puy+sW+
	 T3usbkcB5xTbS+7T5whJSsqbSs+0k/AB81xutVd4hFRCg30PS2e9AYMZg+WsF74Sgs
	 wJqDbFFf2/yhD/oy4vWY7LOWfgrWdUaeQIUR5YsZH7emWzEf8dQGaZDuwGSpIkB6Nq
	 vFlhsYHNLoC5uLET8U+2f8UGW40DX4p+2aIoHFUjvmr+eIu2FHA2K6Ge+Zf5SFpIRw
	 cir/L3FziAZxF8SULISlsOJIqsqPD8uNTBzKNwAU/1LFFCe8h1E4kcnnEQc8eECh/s
	 +o0HonrhTmQ1Q==
Date: Mon, 13 Jul 2026 09:38:35 -1000
Message-ID: <226e7be305e68d72f0c9b6f27663d400@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, emil@etsalapatis.com, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, bpf@vger.kernel.org, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET SLOP RFC 4/6] selftests/bpf: Add struct_ops __arena argument tests
In-Reply-To: <20260713025537.510321F000E9@smtp.kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org> <20260713024414.3759854-5-tj@kernel.org> <20260713025537.510321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On the comment style note:

v2 reflows the flagged comments (opening /* on its own line) and adds a
reproducer for the patch 3 tail-call rejection: a callback with an
__arena argument that tail calls, confirmed rejected.

Thanks.
