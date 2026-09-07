Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150F371D01
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758129; cv=none; b=R3owXzbj19XIa/YNt+KH5PXzp8Ctjw7nWGiLjPB3wAJuyDdgxM7Wam7BHdiEOnLS8oxc45U/U7HQGXdn4JD/5G6Wq4e1UEQQ5It2RaLis17tXOOyD/eHaSHf9Frjq9W3P4lPjEXiMM/N4CnOuTpl9HdMZ1TO14gnIAYpb5pp+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758129; c=relaxed/simple;
	bh=YEB0T5GbUvJrPv8cxSa4tT5wPIvdZxIZu51yaqT6nsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDsG1s2pei+kw57vhr5CnzVSsk3kPtwfG2zLAK5ftOcSB/z0BPSkWOyjavpWL28PqT8YFuWxLwJRBw80nuh0mUuRIoEaAlsr1nqnj0WS6VK9cBmMUqp7DytuT7a22VmvvlKh3+/eRbWiCGG9t312dX1D4LcEvvHbGuW5KEZ21NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=EUFIKw+Q; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="EUFIKw+Q"
Received: from fedora (unknown [23.142.132.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdZyQ1lxdz2x9H;
	Mon, 07 Sep 2026 05:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788758111;
	bh=YEB0T5GbUvJrPv8cxSa4tT5wPIvdZxIZu51yaqT6nsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUFIKw+QnUf4wq9kAAuGzfB1D2FX6yMveJ3jcpIPsZlWfbMDKrrfPI3NFvzSRTM4m
	 iicSjEOuIhqiuzUEYY5tw8AEFsyI7dhiK6j28iuB1ZaDubGQcJX93qxOD14ZbR1dcy
	 I5hVwpWyqD57DD8DF7+DOZyipsc5XQ7CK0B08WZ4HaSp+Dcmc05FGyxnX47g9U67e7
	 WrksFzhL/EMpiTrMI7oufmD2Ymn9CWusVTnBQzBv/rOg7svuGgG+7F9qccpHvoYOHx
	 zxj9fQy4MFm5V3A8J/x4uS2VGX/gG65V2t4ECUIqJ1a4s3TdS/igrTjSBD8nwgy9lj
	 2cluIndaLP7Og==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Read ring buffer maps with event_pipe
Date: Mon,  7 Sep 2026 13:15:00 +0800
Message-ID: <178875781913.42294.11132018537579464182.04-ringbuf-review@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <7a2ed42e006620d35c7112f2828f37e97b13f77e71d242c121c2641e88ffa3d8@mail.kernel.org>
References: <178874362960.1415955.4802953891665661440.ringbuf-v2-1@tychen.cc> <7a2ed42e006620d35c7112f2828f37e97b13f77e71d242c121c2641e88ffa3d8@mail.kernel.org>
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

I have rewritten the local commit message around the missing capability:
map event_pipe currently accepts only perf event arrays, leaving no
built-in way to inspect records produced through the BPF ring buffer
API. It now explains the callback's -EINTR return as well: a producer
can keep ring_buffer__poll() busy after a stop signal, so checking only
the outer loop is insufficient. These message changes are ready for
the next full revision.

In the manual, "raw bytes" describes the payload without schema/BTF
decoding; hexadecimal is the stated plain-text representation of those
bytes. It is not intended to mean binary stdout. Likewise, the shared
consumer position explains why using this command affects another
consumer, while the passive-view warning states the user-visible risk.
The wording could be shorter, but I do not see a semantic contradiction
and am retaining the explicit consumption warning for now.

For completion, exact matching is intentional: a bare ringbuf pattern
would also match user_ringbuf, which event_pipe rejects. The current
expression matches the complete JSON type field and avoids that problem.
Moving exact matching into both common helpers is a reasonable cleanup,
but changes all their callers; using two calls also lists the maps twice.
I am keeping this feature's localized, single-listing change rather than
expanding it into a shared-helper refactor.

I agree that using sig_atomic_t and removing fprintf() from the handler
also harden the existing perf path, and could form a preparatory patch.
The current combined patch keeps the shared handler safe while retaining
the stopping diagnostic in normal control flow. I am keeping that
organization for now; I can split it if the maintainer prefers separate
review/backport handling. There is no remaining unsafe fprintf() in the
handler in the submitted patch.
