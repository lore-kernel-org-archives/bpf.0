Received: from out-zbxj-a78.jellyfish.systems (out-zbxj-a78.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87A3806D7
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758108; cv=none; b=VRYwApf/4Tavy9DibxnQsF7uGAaB52sB7e+ocGgPU7gEkY64p+1FwAlWj9V1xJTlM3QelLykmvQ5xBseO6vB+e9J67yYlqd5EVjkQRzxkGd3rihcGbK6v380XhuplDTRxpRsvSNOOBMYGEwwckbfW5NbWDpvuMGX3JhsOo9VlxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758108; c=relaxed/simple;
	bh=+v/QffOfG3j24ZMk8D9/bqHsz3PwzAHjW3ZD+mZwmYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOqiigbb2NioJEQindZ7ajpfPA5XS7myxi7o31hvVxNiohDxx85jZEUoeEHmIPB1HHLIjADjY6sXcelrfEZdSjqCtnJhqs4x6e4WCXyGIKRBCcNvtzYHdyRkTJ+Iu92pqiZ0c6wPKNEnJQ3hRL+p9nc9/8oQz2N/FBSJ8XNysF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=CnHDhjfb; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="CnHDhjfb"
Received: from fedora (unknown [23.142.132.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdZyB52Svz8sXY;
	Mon, 07 Sep 2026 05:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788758099;
	bh=+v/QffOfG3j24ZMk8D9/bqHsz3PwzAHjW3ZD+mZwmYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnHDhjfbDXzsQh1WpD7VaMEiy2hbGu+4p9QqI/FqrcPc0lc3Zy+KGYQ57Bz2QJNpC
	 /BCHWZaFd6OcnYkJ8t0ebhIT5G+aZ0NS0sAVMWNmgXkauLfp69phabO//h8r/95lHt
	 Rt8ITms1jtWPGs4iYRRlE3ohryIqFnMVT2YL+kKRQ8oPPG2v+75MqBMkhEV1ugZOmO
	 F6vrzGJEZordYARhZTaxEUKX1kCBAskjR86fdhdgRzBO+n737dAGBW/huzRGivXebF
	 PI13lZwtpw6ITrhNhfO3xjk2bTnnI6vxlsdKoxxNDUYyelU5JDDwfxjSG8tTyH5F96
	 tYoMTFMM5rvJw==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Add recursive map dumping
Date: Mon,  7 Sep 2026 13:14:48 +0800
Message-ID: <178875781913.42294.4937235217487798044.03-recursive-design@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a0782d0099757c7e1db80424baf0e58fe5983cb08850a95a4df0bcc564edd7f6@mail.kernel.org>
References: <178874362960.1415955.17339804697296063298.recursive-v3-1@tychen.cc> <a0782d0099757c7e1db80424baf0e58fe5983cb08850a95a4df0bcc564edd7f6@mail.kernel.org>
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

I have expanded the local commit message to explain the FD tradeoff:

Holding every discovered inner-map FD open would make descriptor use
grow with the number of maps and could exhaust RLIMIT_NOFILE. Keeping
the selected map FDs open and queuing distinct inner IDs requires only
one additional map FD while traversing them. Deferred ID resolution
means a concurrently removed inner map can disappear before it is
opened; the dump is explicitly not atomic.

For hashmap__add() failure, I am keeping the specific negative errno.
It is already reported with strerror(-err), and the command still
returns failure. I agree that this differs from the nearby -1 paths,
but it does not turn allocation failure into success. I prefer to retain
the specific internal error unless a uniform command exit code is a
maintainer requirement. This is not a claim that a shell preserves the
negative errno: its exit status is limited to eight bits.

For the repeated info lookup, an IDs-only array would not replace the
second query: map_dump() needs the full bpf_map_info, including type,
key/value sizes and BTF information. Caching full records is possible,
but adds allocation and cleanup state. The extra query is once per
selected root, not for every discovered inner map. I am retaining the
simpler traversal state here; this can be optimized separately if that
cost is shown to matter.
