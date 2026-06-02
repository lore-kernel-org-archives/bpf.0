Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868A357D1D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407062; cv=none; b=GJ5sLZ5QUixHcX0bCg6Fn3M7Kj6SQAMsGJcqINFhbzvS45iqk20G0aPfMZsjx9xqS6UkAuycdFfhUcbhI1Cj4n3aSzuUfJlFAvXUID9abmvRDxZYRRhpcbSf913HFgrEFYyB6G5rjRiA383HUhOUarNlpfjm53r3tCzhUoCyf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407062; c=relaxed/simple;
	bh=06l2CdEWYF9WWyscf71pGO5VG5Y5M1iJPOo0PdNgEqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ig8bXcFaFXHUR/dFI5nF838dNEPQvXNIAw/3TBvXT6EFZlJNBGq01ozAKynsP7CdpXdvXpJMicGFepzqdn176FsplwEURclhyLTA5BGkNSfGYWaVvwzTbUq6p5SSR99hoIsTV7jn6JvVMoAGYeeudIVB8EG3+8lVdib1eH1Pptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bzRAkB4j; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bzRAkB4j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=TuLLmxNnlmR18qmk6V4pdyzmc4cZ030x5UR1me00sNY=; b=bzRAkB4jNitYpXgUQSFGHfkcBJ
	FD8bFLGTG8ONFSd5W89fobrUfM8a71b4R3BBrU84Bz12TEiA/AuYWr270DCdpQaCG7SKGGiudrXF5
	D0hyU2M7CSBy1sLsJPhdM4v1NNw0JD+0eUEPZIvJruIgPu2OYpvf4aiW7WTK4/Ux10C9mA6F/WTcE
	Jgu8jOp++IyN6sfOr1lw7T3pm+o8Uk8tn0Pmg4LnFCNYuqBJtHY2eTXFVyd8YFzWGVnElZD31I5W8
	ahPnddqkx5GstYtfQbO6tXy1XXOBuLBt1QkkvpHMJIPZusU90KxwSHIyTUSWWnmz9VN92+zv/aZ3i
	IeU6gscA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUPCm-0007IP-2I;
	Tue, 02 Jun 2026 15:30:52 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next 0/4] More gen_loader fixes #2
Date: Tue,  2 Jun 2026 15:30:48 +0200
Message-ID: <20260602133052.423725-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28019/Tue Jun  2 08:33:27 2026)

Another small follow-up from the sashiko findings about signed loaders.
In particular, closing the gap to reject exclusive maps in iterators.

Daniel Borkmann (4):
  bpf: Reject exclusive maps for bpf_map_elem iterators
  libbpf: Guard add_data() against size overflow
  selftests/bpf: Keep verifier_map_ptr exercising ops pointer access
  selftests/bpf: Test that exclusive maps are rejected as iter targets

 kernel/bpf/map_iter.c                         |  4 ++
 tools/lib/bpf/gen_loader.c                    |  8 +++-
 .../selftests/bpf/prog_tests/map_excl.c       | 39 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_map_ptr.c    | 34 ++++++++++++++--
 4 files changed, 80 insertions(+), 5 deletions(-)

-- 
2.43.0

