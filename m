Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA241D90D9
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109610; cv=none; b=X6TO4WDVHAA4R0s1wdJKbs9eqTD7hTsMs5XjO/ccqRy8wGXkfDq0IcXfmUZTpCbczq3mmHKuez8qSC2ya9XsMsWBFAeurE29f1sCas07Z17rwBgxsrlOH9br3g8RN+tHJQ+Uqe6EkOFQHV1wfHpl0sQ1LJAOOcJ2mV13iy4mleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109610; c=relaxed/simple;
	bh=e8peeLEvpgcRQV3HZskILQOmaecBp1+KLiuSiQ+sLHk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To; b=SCwAJzivPc5cFJrhX7QzAVHxlQMX8DfWVO/EqhjvCKYpDyd9NncQt17xDQ6k8xc3w1YNJG26Nkbw9j42tv+xUsp5Sp8lJADYTNccFtwQgFTEfFUywfsd3g6MwUFIpxaenpSAccPn3XgD0Wze5nDmfsxhQc95Yr3cL6SoZEp3lWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aCGMnvii; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aCGMnvii"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743109605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gjr3Tb/haZoiA5KnEfQpscClqY2gBFJFLP1ongj3rkg=;
	b=aCGMnviiiVCGmQy5FzlM3oODmhS+owQo/9tda/bMVg5Tnu5KRNGIlhOtARI+pVgsjTFkeL
	Pv6Ly/6gGwf04+ogqv/yMcVO0UJ4+8LxhU9j1bjcUuLRW7V5sPeZkj4GzNhAlgJf9QeY3H
	vlPTBoigr67oYIlv4+BxPx29vsN0Rq8=
Date: Thu, 27 Mar 2025 21:06:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <4b24ded924f3294dc9a9accf412b86295f9e4ed7@linux.dev>
TLS-Required: No
Subject: BPF CI update: traffic monitor logs
To: bpf@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Hi everyone.

Traffic monitor logs for selftests/bpf are now collected and uploaded
as artifacts on BPF CI. Currently only on x86_64.

You can download them from github job artifacts for a run that you're
interested in.

For example: https://github.com/kernel-patches/bpf/actions/runs/141159358=
17
Scroll down to the artifacts and there you can find archives with a
name pattern like this:

    tmon-logs-${ARCH}-${TOOLCHAIN}-${TEST_RUNNER}

For example:

    tmon-logs-x86_64-gcc-test_progs_no_alu32

These logs are also available if the test run fails.

Happy debugging!
