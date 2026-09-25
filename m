Received: from out-zbxj-a76.jellyfish.systems (out-zbxj-a76.jellyfish.systems [198.54.127.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0763EA942
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358386; cv=none; b=rquvaVA4DJN7tdDkfV5Ucb5h1CW36MMidKvxXXK+nE2SfIGLrEdonuuKtSSZnAsmUi1kKwcksZ2JzuE0cAv3YbWoyb9TRN3ezkod1LWBpnMlDiazUMTpGwzNnyE84cDt6vVSgyqCAGOzdGZvroHNjPZnFmgcK0Bzo8k28N9h/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358386; c=relaxed/simple;
	bh=DIYAPrJdN+Ph9zh8HJGh9ljVIdxBUC9f7wRYKJjFfPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CkuX70c0QFVc+lSSzAIabJiehT7mdo9KtzU+6+QHYAuro9Z8fTVKrrvPdvHs2fexgrCep8c94Ce0D5Xji/dU3QphPK1SNCy0W4hKCXEnv24DR1k1M4pQv8yM6d1/Dl2c6M/xHTpwQfQSPN7XFzcfz/3DEs1/XLxNh0akl7sHkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=dVFl/27/; arc=none smtp.client-ip=198.54.127.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="dVFl/27/"
Received: from 192.168.50.46 (unknown [114.92.81.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hrymW58KBz2xDW;
	Fri, 25 Sep 2026 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790358366;
	bh=DIYAPrJdN+Ph9zh8HJGh9ljVIdxBUC9f7wRYKJjFfPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVFl/27/lCjsK/dVHQ+rI9LrlVdHZjqSOsAvoDvnAzvIdlNbCB32JPeXTGFPWaSns
	 VNoZ19x0bDQWq7jRJufMQoZVXDbd5M3QlADflqOFaCKnQ8qdDeeQWy4vX9ZLJGYzqy
	 HiKvFrwwqvGyEFL19QTxab3dfNrZ9sLu+M9x9bz0OyRMd7r3e+GRk0wJSVya6+R5dj
	 R8LPPiVVIi21EdMzdkNhg26ZehP4TKn8rztb+Ohm4bIem6Hdd+nNuVnQK0y67bNnko
	 zKOHlG04msBWp3//05yGD6SN/n8qLWQtp/ECWqLwpM9zoWW6F84scvpiJOOuPI/yHF
	 UpVs8rKsMjvUQ==
From: Tianyi Chen <hi@tychen.cc>
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/2] bpftool: Use batch lookups for bounded
 hash map dumps
Date: Sat, 26 Sep 2026 02:46:00 +0900
Message-ID: <179035836036.2029588.186416039015053466@tychen.cc>
In-Reply-To: <d5a5b5e7-4063-4511-acdc-46b2407565a7@kernel.org>
References: <20260924163403.203491-1-hi@tychen.cc>
 <20260924163403.203491-2-hi@tychen.cc>
 <d5a5b5e7-4063-4511-acdc-46b2407565a7@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Envelope-From: hi@tychen.cc

Hi Quentin,

Thanks for the review.

> Why hash maps only?

This was an initial scope choice, not a lack of lookup-batch support for
LRU_HASH. It uses the same u32 bucket cursor and is a good candidate for
follow-up coverage, including eviction and concurrent updates. For now,
other map types retain the existing individual-lookup path.

> Can you add a comment about

Added a comment tying the u32 cursor to HASH bucket indices, independently
of the map's key size.

> eligibility would be worth its own function

Done: map_dump_can_batch() is a positive predicate checked by the caller.

> limit for the "buffer" resizing

Yes, the whole-map bound was stricter than necessary. In v6, 4 MiB caps
the combined key/value batch buffers, not the map's maximum capacity.
If ENOSPC persists at that cap, individual lookups continue from the last
emitted key rather than restarting from NULL. If no entries were emitted,
traversal starts at the beginning. This keeps the existing non-atomic
iteration semantics.

All 12 subtests pass, including a large sparse map. I also injected
ENOSPC before and after output, forcing growth to the 4 MiB cap: plain
and JSON output matched the baseline without missing or repeated entries.
Initial unsupported-operation fallback and fatal-error handling were
checked too. Fresh /dev/null timings and methodology are in patch 1.

v6 is a new thread:
https://lore.kernel.org/r/20260925174412.2028749-1-hi@tychen.cc

The v5 CI failure is the same s390x test_verifier callx diagnostic mismatch
seen on for-next_test, not a batch-dump failure. All 11 v5 batch subtests
passed on s390x:
https://github.com/kernel-patches/bpf/actions/runs/36028683139/job/1077369230=
87
https://github.com/kernel-patches/bpf/actions/runs/36040586092/job/1077772962=
89

Thanks,
Tianyi
