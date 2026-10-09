Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5754E4C3A;
	Fri,  9 Oct 2026 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547328; cv=none; b=uRUhu8LBkPdAa35R8mXHhaXW9BiQgjqXMaIaIz2Rjd58+ymQJLUZB7z/Q7DH7BwhfxK1U2FGYzFgxHvrZnOVdG0rBNkgxN2eYIVxhCRqfOrnyvFJjVQizYqJwsbrkZisjsnCEcdWouCRJhGTj2vTjYo/6YwZ0RFx7/QaHvZQuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547328; c=relaxed/simple;
	bh=6FtDSrgaYV7Ds/Zpv/sUmavtdmBH9gBDnWD2EBM7p4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKRzlpLRFWWRsAZbBToV5E25eTz/EcSc0poBougQrNPQ6Q2iSlp81Rn/nUwzAOvrSJv1z/+/YQVXKAWpUKqzmLVfqrEQl3WWzfdriVcp7rvneOQy3+yHlURS23hvDC5vWBlG1SzJ6X/fLikUMCcAjN6uBHAyZxOfROwZKh4mhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVCj0Khw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVCj0Khw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFE81F000FF;
	Fri,  9 Oct 2026 12:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547324;
	bh=27Qg1735PHB2T//K3jELbiSjWjSG0HONYGKp7KFkKws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VVCj0KhwADjBnN6aDcwom6Pn3NloGWC1xCdoP6R7RQX/2P3s8lAgDCXW15ePoT8nl
	 BhJkEHi3/Mu9SnYUqgSr5z1W6dXyo+dWDNGsCboVr7vf4nKMQyYSYXlbU1UInBz9oB
	 IuVn0vkGj4Ad3LJqxBwe+UaiUjP6xkcUUvg07DGjlKADa8I1S24n0FPdgbQX4To+LF
	 uX6qXnQv/ernYpArUhinbXl/h+CkDyagXb5mCUdNf/K5yZ7aCT/v9Z5DP4zaOuw9Cq
	 ckBwJRNlbH9rAAILX4GYt7IjFvz2MP/Sx49VDZy+kqa79JOpHAMDzAlrYeiAxWzXxg
	 vR8tbXsHuClFA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com
Subject: Re: [PATCH v2 net-next 00/14] selftests: net: migrate AF_XDP test
 suite over to net
In-Reply-To: <20261008143013.55b0f462@kernel.org>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008143013.55b0f462@kernel.org>
Date: Fri, 09 Oct 2026 14:02:01 +0200
Message-ID: <87cxtjqdza.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu,  8 Oct 2026 13:48:55 +0200 Maciej Fijalkowski wrote:
>> Heads-up for ice: to reserve a queue, xsk.py updates only the RSS
>> indirection table over ethtool netlink. On ice this also turns on
>> symmetric Toeplitz hashing, and restoring the table afterwards fails.
>> The fix, "ice: keep the RSS hash function on indirection-only updates",
>> goes to iwl-net separately [0]. Without it, the first case that takes a
>> queue out of RSS fails in its cleanup, and the table stays modified.
>
> Good news it that it applied, bad news is that the non-HW test_xsk.sh
> crashes the host:
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/857863/166=
-test-xsk-sh/stderr

That's also good! A bug has been surfaced by the test! XD

AFAIU this is a know veth issue [1] (right, Maciej?).

Disable until a fix a landed?


Bj=C3=B6rn


[1] https://lore.kernel.org/netdev/20260509084858.773921-1-maciej.fijalkows=
ki@intel.com/
