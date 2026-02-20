Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5635957;
	Fri, 20 Feb 2026 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609758; cv=none; b=AkD4UrCy/erjjZOBq4SPRjgIagVehwjwb+607PGsNvtD7D0q0osxtsLy3QGon+7YSGIFliweNylevyHrpCAwjNRHaWkiHDhG0FgzXgdjimTC5VqY9W3r//lfnBUO+uSw/TBElkykW/faZfLwnJbhJ492R55fMrq5nAg0qOSKhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609758; c=relaxed/simple;
	bh=Ip4u2qvG2p2CXlK2H/4/opXEVW7eYhtsUuwBJMlKo0k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CHVDVdqzHsT9+nxMpYGzWrgnp16jNW/II3yuSZABvDrk/c1zYeUUkG45rgHQ32qJeRwQW6G7aQ/3FMWRO7l4IhgKq9XBrYS8hVept/vhKXKwUBV5aqrkkmtzwLltdztUIg9FYFL/pYH3vN4QttUYiqjXHJJEgiD3/kjmMvtKxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvWToalO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvWToalO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47183C116C6;
	Fri, 20 Feb 2026 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771609758;
	bh=Ip4u2qvG2p2CXlK2H/4/opXEVW7eYhtsUuwBJMlKo0k=;
	h=From:Subject:Date:To:Cc:From;
	b=PvWToalObae6T3YKUlgUhFX81ppu3sf5k5FWWn8xg4bk6tCo6XHYxpiCpqoC//O1f
	 X2kU90aG1hYwp4CZun2ccaDd6/xFFWCShfuCqSqblFrNq0JJkeJZg34i+aO1e6+7Pl
	 eGtmZeid//58Ih+a/ibYqbZ55vfMgSctUB/6yjZmaCaFoNmU+JcIxxQ9m9iAgQI8so
	 AP4ZoIgunAg380JF/26fEKS9qS15vPtq1EpZrxujQqGkdV8gxuvz6zQLUjMJ3z+cpX
	 ILQKYQ7U8TB7bsRgudMrptFga56PCQgu9jNe+GWVQS55Lom5aE7LLBms5egpRhdFg2
	 lZ6NP5tWQPcGg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] bpf: classify block device hooks and add selftests
Date: Fri, 20 Feb 2026 18:48:47 +0100
Message-Id: <20260220-work-bpf-bdev-v1-0-c53e852c4702@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICemGkC/yXM3QrCMAyG4VsZOTaly1TEWxEP+pO6Knal0TkYu
 3dbPXxDvmcF4RJZ4NytUHiOEqdUo9914EaTbozR1wbSdNREGj9TeaDNAa3nGUMgd6J+P3h9gLr
 JhUNcft7l+m952zu7V0PahzXCaItJbmynlqqZqpoqmSdLNo5h275JrR0NmwAAAA==
X-Change-ID: 20260220-work-bpf-bdev-ff2c82143d05
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, linux-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ip4u2qvG2p2CXlK2H/4/opXEVW7eYhtsUuwBJMlKo0k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOmDe7NOlU7+dAEdsnzK1r3zDdOtje6O2/aMaVJKbDj
 MKJuzb87ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/RxGhl7dqxPCvXjLvx+4
 ZRE4+bhFS6OQq2NJ+Y2vzALzjb9deMjw32tzT8/OiaXbbX6fZqz3+HjN1bzGrP9ucNaHNBtpHWM
 fVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A bunch of new hooks for managing block devices were added a while ago
but they weren't appropriately classified. Classify them and add a test
program so we catch regressions.

Note that for whatever reason building the bpf selftests locally seems
to fail for all kinds of arcane reasons for me. That might just be my
fault. I added a pr against the ci to have the selftests run but to test
this meaningfully it needs veritysetup and dmverity support. I'm not
sure if that's available already.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      bpf: classify block device hooks appropriately
      selftests/bpf: add block device management selftests

 kernel/bpf/bpf_lsm.c                              |   4 +
 tools/testing/selftests/bpf/prog_tests/lsm_bdev.c | 221 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm_bdev.c      |  96 ++++++++++
 3 files changed, 321 insertions(+)
---
base-commit: 42042907fd759c36922defd1befd318c7467fa1d
change-id: 20260220-work-bpf-bdev-ff2c82143d05

