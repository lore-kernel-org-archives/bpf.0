Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DB381AF0
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758139; cv=none; b=Fm9DsrOMIxzbn9VpdKu57vWX+PayMi0Xm3LfMC7ysSeMdgb+Fpe5E6u/zgzNI4NPk1KuMDbgwrXIhZMYMVk+YcptaiIain9ffIt1VU7mpShySnQOacS4qogPeKGVkLAa1Oc/D1VjTVtwZMEJsBEOuzG+4I4IZ0UK8DAMHO2XdPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758139; c=relaxed/simple;
	bh=HAm+0Sf9hBM/g7H0SLs63WBFimfDqqWZH2EgKD9A0ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqRMQJR/WziZjH3EaffI/nbwfRbjhu2HHaZxtBXdfhsCaZYsShL52g/EL7OY5sSGxfN67ONc1KbiLO21yGx20z6iQ6sg0v4cxNTwUWPw+PdDiREjurn/x6CVVoduSVsvlfg5AW0dZB76d0MVJ5qVQSjBNez95hFit6saRNGEiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=Bu7KtC4k; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="Bu7KtC4k"
Received: from fedora (unknown [23.142.132.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdZyt0yBDz8sWT;
	Mon, 07 Sep 2026 05:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788758135;
	bh=HAm+0Sf9hBM/g7H0SLs63WBFimfDqqWZH2EgKD9A0ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bu7KtC4k4rsCkIMzhEwv4wDvhO8Sy/kzrM7zKcTjir/c7/qAl4cBMUpfSYymOnA2c
	 XqaAKNNrMnmZvQfbPuiTbMaEK+b1ZY5e7dvUeXKFPCMY6Elbwy5ls8HB8Ow5I15KP5
	 yyRaHfSnGfnzyVsjrkR5teoi6K66YHjCcghAPk31rS1mP6uhWLpBU6PqwCO3k5Jegt
	 XBe0Gxgl/QBrxRYTlbVlJxeiKKNFeWaSiyBhn8U9BlhQwOrSk3xt92zUMjNpR8irwY
	 z659yGC2dKgGEf9ncjekck6spyzYVNr/OHdFCs0ZmAH8cBr8wqxqVMNwbJb6bu+4k/
	 LRFmtlozTb+2A==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Use batch lookups for bounded hash map dumps
Date: Mon,  7 Sep 2026 13:15:23 +0800
Message-ID: <178875781913.42294.7642044729023826445.06-batch-budget-and-performance@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <47ffafd7714d83ed25f2852752660f8e45f6ac45917db93cd33dfe7087870579@mail.kernel.org>
References: <178874362960.1415955.206253160275144439.batch-v2-1@tychen.cc> <47ffafd7714d83ed25f2852752660f8e45f6ac45917db93cd33dfe7087870579@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Thanks for the review.

I have added the existing measurement to the local commit message for
the next full revision. For a 100,000-entry hash map in an x86-64 KVM
guest, BPF syscall counts decreased from 200,004 to 395. The median of
five untraced runs decreased from 0.774013 s to 0.733844 s, about 5.2% in
this measurement. Syscalls were counted separately with strace. The v2
change affects error reporting, not this traversal algorithm or bound.

The 4 MiB eligibility check is intentional. Hash batch lookup must fit
an entire bucket; ENOSPC leaves that bucket at the current cursor so it
can be retried with a larger buffer. The bound guarantees that growth
can accommodate even a worst-case bucket within the memory budget.

Capping growth for otherwise unbounded maps leaves a problem when a
later bucket is too large, after some entries have already been printed.
The individual-lookup fallback starts from NULL and would print those
entries again. The opaque batch cursor is a bucket cursor, not a key
from which bpf_map_get_next_key() can resume. Returning an error instead
would newly fail a dump that individual lookups could have completed.

Thus the example with one million 4-byte keys and 4-byte values does
intentionally use individual lookups. I am keeping the conservative
bound to preserve the output behavior and memory limit. Broadening it
would need an explicit solution for the post-output oversized-bucket
case, beyond just capping the allocation.
