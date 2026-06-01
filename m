Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FE3D79FB
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326173; cv=none; b=SqzxgOzJYSzLpc2oX1G6ldaRvVy4eqJanbVzBLCwNCEnxcjLcbJd8OtTktxveH8sB0doeiOWkglwLnytqZbiNaZVb3hvodpNSIIjSV6QBfsAxBKdCpxquLvMCsEx54d4oNtLTR7g/7IcjhKfKf8/dBAB6PQEY7oVOr9NjW+N32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326173; c=relaxed/simple;
	bh=W6henyM4j+9UOI0xTaWstVhKK5BCXjWERrAlFcUQydI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/wpgQhG36kggMtGfIl3Wb3iF9Ny6dWovZJDltRJwyW8WcIG9fhZs4oTeJO0rSjXpgh89wFD7kJlWhXgcjHubM6yA4+0P+PB/8XJEUkBBdQAP5Xr2oNPm+DbMt3Mf7cyKXuS4H2XBLhSXAA7NK82dlUgKrAUOax5s/7RDcKcbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=drQIckHY; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="drQIckHY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=cuO5M1wrH+SpcLBh59G9uCq+PoflrKwo5o26UmOD1w8=; b=drQIckHYShpPA+lDMh72UftNb2
	RTymJcGNt5ES/32XblqN+kpt92QzNK6DVhkwpv751zmLNjRaRyQWic/LBnILdfgOf8r3qGxpQTSpO
	fO0aoGdRzVgJqQ4by/CoxVSxVoK7PfVw5vm3ymhZX3P5qXWIMHkamRowHX0Fu9Jn5I9JBTj9ncy/6
	N36FiR9Wmapz4KkW1rYnQiRqEn9PA5kY5+ynXyTn/XpJ82CSnw6SmSvAJbawA2JuZikSZp1Qdm2qw
	Cqy2M1dMbu15D07ct5XoDJiy2xvH4jLn9T2GSbpF9IF+4swpFuy0seisez7NDeFfC+s/Jyz+byy7O
	GDlMM6sw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wU4AD-000GW5-0L;
	Mon, 01 Jun 2026 17:02:49 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next v2 0/7] More gen_loader fixes
Date: Mon,  1 Jun 2026 17:02:41 +0200
Message-ID: <20260601150248.394863-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28018/Mon Jun  1 08:31:13 2026)

Follow-up fixes for the signed loader, includes also the recent
sashiko findings.

v1->v2:
  - Fixed up verifier_map_ptr selftest
  - Added patch 1/2/6/7 with a new map-in-map fix and a
    redundant hash_buf memcpy cleanup as well as selftests

Daniel Borkmann (5):
  bpf: Reject exclusive maps as inner maps in map-in-map
  bpf: Drop redundant hash_buf from map_get_hash operation
  libbpf: Skip initial_value override on signed loaders
  libbpf: Skip max_entries override on signed loaders
  selftests/bpf: Test that exclusive maps are rejected in map-in-map

KP Singh (2):
  libbpf: Reject non-exclusive metadata maps in the signed loader
  selftests/bpf: Adjust verifier_map_ptr for the map's excl field

 include/linux/bpf.h                           |  3 +-
 kernel/bpf/arraymap.c                         |  6 +-
 kernel/bpf/map_in_map.c                       |  5 +-
 kernel/bpf/syscall.c                          | 15 ++--
 tools/lib/bpf/gen_loader.c                    | 69 ++++++++++++++-----
 .../selftests/bpf/prog_tests/map_excl.c       | 46 +++++++++++++
 .../selftests/bpf/progs/verifier_map_ptr.c    |  8 ++-
 7 files changed, 121 insertions(+), 31 deletions(-)

-- 
2.43.0

