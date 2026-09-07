Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C40371D01
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758131; cv=none; b=JTzE0znsM9/DsEyBudIoH29UxJ1643uHzyBtDQUJkyQTyfgtQJnA8+EIdA1bFzp5N6sFw+gDP8VhtQEuH+mKqF0w3V7PHIch8bnT1PInneAn5CiM6q+G25ursCyy0vqfBnP/6UR1ayIoAf3f3be4uKEFq0ojtI4LGtf7vTNl2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758131; c=relaxed/simple;
	bh=j6uFuJZKJzAWiejWnQ85APCD4TPpXrmr/0kKPaibQ00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cF4vkvkm0d8cc6uxQtAXJRCni1lY3MATsxojNuX8EURnb2b6zGv5h1Fiz1omrH7Mqu7L3hazuqdDOdfj01lGhhH9m3yPDFwurrDAh+tfOnq0Uv349CnWsWpx8/n5nsVz71icThrykajYMWpqNGF5w2i+JGzjDtvps4kveiT/rjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=Mg4oi/YY; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="Mg4oi/YY"
Received: from fedora (unknown [23.142.132.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdZyd5zzxz2x9F;
	Mon, 07 Sep 2026 05:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788758122;
	bh=j6uFuJZKJzAWiejWnQ85APCD4TPpXrmr/0kKPaibQ00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mg4oi/YYn+UTj3n46M9VgCksFfKMQbitbVl145GxqvT+2YWtIDxwHWawJqQVIBLFK
	 0Jzxcug2q6VH0+DWJuOhTu0mINg3K/vw2aZ7f8M29sItyD9cupSx2C/1ncENtWPiOI
	 NXWadxz729on109rxI0/FQw0Q1q6SBnh95I3n5YDGvJf5hAaCk3Wo9kJ8dLSy8DX0d
	 lqSHkDeSFsUiroa1WZqY/ZIZzl6zy5Hw0fG67547qMoDLNmRmuZPMisWia6R3txfg6
	 scKwTlfpMv+YwEIgx+l1J1f+lTmhUbI4jhVZSnhzSNDsDZpJsPCK4Le2NYOeNoO+wQ
	 lm02/vS5L2Bdg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Check bpftool batch map dump contents
Date: Mon,  7 Sep 2026 13:15:11 +0800
Message-ID: <178875781913.42294.1366248358606228270.05-batch-test-helper@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <97cc13b58bb198fedee2dd3d6d68ba5222dac4021162dbdb17ab364b72d60ba8@mail.kernel.org>
References: <178874362960.1415955.8995787346446727387.batch-v2-2@tychen.cc> <97cc13b58bb198fedee2dd3d6d68ba5222dac4021162dbdb17ab364b72d60ba8@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Thanks. A helper could share the deterministic key/value derivation,
but these are two short, explicit calculations in a small selftest.
The one-byte key setup is also visible next to each use, and the test
already compares the inserted contents with the complete dump output.

I am leaving this unchanged: extracting the setup would be a readability
choice, rather than a correction to the test or its coverage.
