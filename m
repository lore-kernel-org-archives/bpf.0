Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6663E3163;
	Tue, 15 Sep 2026 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516688; cv=none; b=gW0qfwFtJ+5EsBZv/Bn5mfZBMvXSHhS2XPWLrSfkdoKzzkC1nnDT2PtMTxdHe1HDVTfQGtt4N5sjxKLUcuGkHb67m1vllEvcDCv3b/vcr9p/gcFaf2KAmjfk9JKfD73AdG/AjG/IZta7EafXTlHRuaTbVpv09RYnI8+ZjJMuUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516688; c=relaxed/simple;
	bh=qu/y9XvM+ZjAQBfx3P1AnhLv6qgbd/eR2W4AaiIjn4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nV7qQE6FmZCgWvp9QjiP6qRHEKE3Nz1TsdwCjA9CSaFbsNib6DQM1fTl4NS978J5k/0EV198+3SXgb/g6fZC9n1Lb0yGUYgRJ569e2BuIAwr0CvcnYd2/7oWB4HnD7hjhYU8kYK2Pdol91nUubRX9iRLy2OJAZsvtY1FZXtEQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QY1QLraS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QY1QLraS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DE1F000FF;
	Tue, 15 Sep 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516686;
	bh=CWBTQ3UQWvg2ZugiEmC3xkFsPu51Oqut0wT78L+RKeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QY1QLraSPA13NMQa8xcRDmGkm2EFU7GYZeNQw64jM6TC8CjnCSrySgF8v5SRKTrzV
	 xIy9L116puM6Q11Zbk5H8iVjs1rIbKapNA1iV5pAcAmwqtuufqGqPbCW54WV+mNqCd
	 8et5bbXCthScqeolrgWWnnZmcz7Tn03XDj+ymSZO8dMy8onEG4M+vlgbHdQBdtivTh
	 cjpmxnCEKdAni9z1ee2GQAYB4b7zeJ7+SQbIZCVGB+SkoHoCzbQOxf/WnqKPMlTHb+
	 l+kiOTL1QfX8wblmjrSxBI8fYdjOWWMeUV8dIMaXYttjpvzNt9cL0V+8bKZfo8nxj4
	 t7UMu/bcuN4TA==
Date: Tue, 15 Sep 2026 16:58:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Irlanki Sandeep <irlanki.s@samsung.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, ncardwell@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
 linux-kernel@vger.kernel.org, lorenzo@google.com, maze@google.com,
 sporeba@google.com, motomuman@google.com, srihari.k@samsung.com,
 g.pokhra@samsung.com, r.kumawat@samsung.com, raj.kumars@samsung.com,
 ts413.lee@samsung.com
Subject: Re: [PATCH net-next v3] tcp: add TCP_ECN and TCP_ECN_OPTION socket
 options
Message-ID: <20260915165805.359302fe@kernel.org>
In-Reply-To: <20260911091148.456834-1-irlanki.s@samsung.com>
References: <CGME20260911091026epcas5p35873551b66ec0a50e20ada6e26d2b056@epcas5p3.samsung.com>
	<20260911091148.456834-1-irlanki.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 14:41:48 +0530 Irlanki Sandeep wrote:
> Currently, ECN and Accurate ECN (AccECN) configurations in the Linux
> kernel are controlled globally via the net.ipv4.tcp_ecn and
> net.ipv4.tcp_ecn_option sysctl variables. This global approach lacks the
> granularity required for modern multi-application runtimes.

CI (bpf-ci) reports a failure to build tools/testing/selftests/bpf on
all tested toolchains/architectures (x86-64 gcc-15, x86-64 llvm-21,
s390x gcc-15, aarch64 gcc-15) after this series. The build breaks in
progs/setget_sockopt.c:

    progs/setget_sockopt.c:67:11: error: use of undeclared identifier 'TCP_ECN'
            { .opt = TCP_ECN, .new = 3, .expected = 3, .restore = 255, },
    progs/setget_sockopt.c:68:11: error: use of undeclared identifier 'TCP_ECN_OPTION'
            { .opt = TCP_ECN_OPTION, .new = 2, .expected = 2, .restore = 255, },
