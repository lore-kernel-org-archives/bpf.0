Received: from mail.grapheneos.org (mail.grapheneos.org [91.246.30.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81223A257E
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.246.30.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946752; cv=none; b=ciQa26y+4Sewh8dmejumGWOmvVfAgyWj7TDtYisIIJBXgZTwZjgs57bb3On7vHdk0Z7vnbogTSSaNsBSjEbvnO/hoSjUdVTmywYphinY2Pa145Tn3y604IVNLGoW7R/QOyUPkTlguGeXfG+Yjt+Bnp/xnIZZ61MbiI1pzMdb9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946752; c=relaxed/simple;
	bh=1l+0kvBYoa60FPCPAOACKkcwYiwP5SOuaU1AVqhEu+A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zv61LV6CdoFTd6OmBupoZAsN38nwanGhvJmFUkcOLEsJmo1Re3+SFPYShVomHNjxpio3W5fECdAZ5X2kRJ+bQMOs+87eg9684dmvora4LYWI4Eu8j2BbZSMn+4+qQRsKremhIcdiUL/nJjqLRWaWmNRk8qd9tKp+1UrGXpeUjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grapheneos.org; spf=pass smtp.mailfrom=grapheneos.org; dkim=pass (2048-bit key) header.d=grapheneos.org header.i=@grapheneos.org header.b=Dkz+Ljkj; arc=none smtp.client-ip=91.246.30.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grapheneos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grapheneos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grapheneos.org header.i=@grapheneos.org header.b="Dkz+Ljkj"
Received: by mail.grapheneos.org (Postfix) id 856833C08DBB4
	for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 22:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grapheneos.org;
	s=default; t=1782946260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=1l+0kvBYoa60FPCPAOACKkcwYiwP5SOuaU1AVqhEu+A=;
	b=Dkz+LjkjwFwuuM8fj0QMMUV4e6PG58dRYYb7uNkcAvNA5624HfqDckuSh3wTlxLWwv/Qe9
	WDsJGzwJYLSn0jBzISl8mj8OuC7dx5C2A6Z/PZAFeBl52Z3xFGgpeYf/ax2trYBmDQRWPM
	dBW6qqyTcImMzMnGxFlf/rfcLKitrO7fyubzlTAvf/kiTkhPCF3Fz2udrWjMSggSdath4/
	eHYu+oTgbyEWMysydd+qzfCG1xDX+2Vdu21ELRy3WgLaAxOJ5mJ0sYPw+B8fKuwLsYG7XC
	CsXfnZg7ti3S61SbySWmDZU734pssRopcFQcQBoh87GYln2smb3I5oShP4d9Ug==
Date: Wed, 1 Jul 2026 18:50:59 -0400
From: Andrew Fenton <andrew.fenton@grapheneos.org>
To: bpf@vger.kernel.org
Subject: [QUESTION] BPF_F_NO_PREALLOC safety
Message-ID: <akWZ07aL4-Qclm_P@acomputer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On review of BPF_F_NO_PREALLOC, it has a history of causing crashes and bugs through deadlock and memory allocator corruption.

The git history shows that initially it was possible to shoot oneself in the foot with this flag, but then check_map_prog_compatibility() was updated to restrict using it in unsafe ways. Since bpf_mem_alloc was introduced, it appears these restrictions have been dropped.

Can I conclude that this flag is now safe to use in all contexts and that, aside from the obvious resource (memory, performance) costs, a preallocated and dynamically-allocated hash map are equivalent in terms of behavior and safety? If not, can I rely on the kernel to prevent me from using this flag in an unsafe way?

Thanks.
