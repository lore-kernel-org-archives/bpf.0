Received: from out-zbxj-a67.jellyfish.systems (out-zbxj-a67.jellyfish.systems [198.54.127.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655B19CC0F
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709063; cv=none; b=Cm3KRwWwdddrs2YhA67sYEbz+6zAqE7PCN6i0sf3pAgLtSI2t/c0s4l0MBF2ctQjqWCttflSL8h1XgRGWPOKIGxI+baslUc4ljt16qvA0A6XjPmHzUlHM2pY3e/5O9w5eebj5sYvj8h+7Qc5HnNP+Wd/OAwEdo5eDgvI0V5wnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709063; c=relaxed/simple;
	bh=EPwb4lvpzFORzEvulaUWm0I8S6c4Cqls7fGBF6osNFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i3KcDFEEsEADtXk6WVyAegcG6nl8Cqee8ziYb6MCe9TpHQFzT9I2A6k9ZyQ0328Dzg2lVHfxqgIAaKwiOZ5rT6Pi+n0ohyUYiP3v1md4vCEZgkMLpy1N5SOO4pArWT2THzt8AoLInA0XwrdbmzgT4bE8Y+H2P2qp1OjTDOUpxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=AN/xif6q; arc=none smtp.client-ip=198.54.127.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="AN/xif6q"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdDq35c0jz8sWg;
	Sun, 06 Sep 2026 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788709061;
	bh=EPwb4lvpzFORzEvulaUWm0I8S6c4Cqls7fGBF6osNFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AN/xif6qk3+FbLRxItH+jMlY1oaHj9aMYatkf4OosDFDwqhKvx9W5QkjsRn3HWag7
	 G+UHui6kuWakzn25CZE7J/kg4ssHdXQbh6vh5E+zpyKFoj2+wgvNSL7Wl3focSH995
	 cX+q12hF20/b4PAhGkVMeEptPqjb89tG+Uww29Lqxkvu7eT2cvezVhlqjQj6RfdCFJ
	 dk0/tCYUvx9sKPHJZmRqoC4NalmjH6bDW8EWyYrBCDGgneErLi7WCaHVuvDF7wFWh4
	 dNFuAi2W/AzmAIKYLjjWp9wGlgt4wyZY7rJ062S/aKu9wvnL9upOqqgNlY0IQSLgJe
	 39mhCtLWX9zdQ==
From: Tianyi Chen <hi@tychen.cc>
To: bot+bpf-ci@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yonghong.song@linux.dev,
	brianvv@google.com,
	martin.lau@kernel.org,
	mason@kernel.org,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf] selftests/bpf: Check returned keys in map batch validators
Date: Sun,  6 Sep 2026 23:37:25 +0800
Message-ID: <178870889324.880246.1788108850056515683.reply-bpf-ci@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <d1b61b90e780040376c607497d15cdeb9367bd49ad76635c7bbfac24531064a6@mail.kernel.org>
References: <20260906143918.848536-1-hi@tychen.cc> <d1b61b90e780040376c607497d15cdeb9367bd49ad76635c7bbfac24531064a6@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Thanks for pointing out the third validator.

I have included the LPM trie case in v2. The struct key is not a reason
to leave it out: the updated check validates the /32 prefix and complete
192.168.1.x address, then checks the host octet against the inserted key
range before using it to index visited.

I also moved the validation notes below the --- separator, leaving the
commit message focused on the problem and the fix.

The revised full test_maps suite passes with no skips on the matching
kernel, including array, per-CPU array, hash, per-CPU hash and LPM batch
tests. The revised patch is here:

https://lore.kernel.org/bpf/178870889323.880246.16480713814270899611.bpf-batch-v2@tychen.cc/

Thanks,
Tianyi
