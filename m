Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D63806AB;
	Wed,  8 Jul 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518121; cv=none; b=WfLCJ2yvUyhDOatukeO0UvWZQ9knw4OR1dXwZqjK7JDXfX7yoMKLUaHWDVvgRabf2qCq/8jTBxwuN8Hzs+2si8GKHD4f/JdKosqBOr9byy7wiTqompbi8Ualf3K1txqMQBkjKPAusUVV06hTShTGkJKqa/lQ1o9jFARY9rhdjt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518121; c=relaxed/simple;
	bh=766ztwFBIetWgxKoZZgeUKJCGrbo58G2Y/FPIvlaf+s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZPTZpGu1SWn9JURJYrQQNs2pbHVQbrtDgUzsi1D4uoRkpsjAOy7wIlfc7k7xopht3O4v4CSvoDiFzDYNaciFtYD6IuuM0YX7wnNCpgCOmg4oZxMbb5rmoQ8fDYv7bcXOZQNAiMC7INwD4qngyKHwoTpspWK2P03Gihjx0HeoEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRrlWPPc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRrlWPPc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7C48C2BCB9;
	Wed,  8 Jul 2026 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783518120;
	bh=766ztwFBIetWgxKoZZgeUKJCGrbo58G2Y/FPIvlaf+s=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kRrlWPPcZZtpyUjdL3CySjh8lCjWXipygSEsZ9LjMlShETC4Khky5kOLtbk3ZBUUb
	 E6bHxtaTPQHt9X/Opec1ok2Haq7vavnY1vm7h6keBJsz7C0gtBLyS3/Oaq7YLATggr
	 72zXWC0mgfJnBXrntyd9APG6vYWi17So9ArM49oFpMkCmIFLV6ApbDparBCGS5j5LV
	 eke4Q48cgM6zOM1BJo+h0mdwiPX85VwA5B09p+4ahR/cPGwTsvfN0l7+s8rD42qEvV
	 tTtHoxzJX4zJmb0MtxqIKobA/dNNf5py8mpGkc1B4hwIo8/MwvdCj/EtJ1mU/xuLWF
	 gqVobP1xK9uvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49D4C43458;
	Wed,  8 Jul 2026 13:42:00 +0000 (UTC)
From: Mattia Meleleo via B4 Relay <devnull+mattia.meleleo.coralogix.com@kernel.org>
Subject: [PATCH bpf v2 0/2] bpf, sockmap: Fix FIONREAD for sockets without
 a verdict program
Date: Wed, 08 Jul 2026 15:40:55 +0200
Message-Id: <20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2RqoSK0n/8NwKMsW1iglLTYYw
 r9b8O7xTd7MLBDIMwW4Zgt4ihzYDQnkIQPszdCR4DYxyFxWucqVsEnwZFoxOBHJt4yTMKW9VFo
 Z1FZDao6eLM/76h2a0UL9C8O7eRBO296m9Rwm5z/7dyx2+e9NLEQhkHRplDydFeENnTdP1/F8R
 PeCel3XL83dMgDRAAAA
X-Change-ID: 20260707-fionread-no-verdict-a4f8697ac9f9
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Mattia Meleleo <mattia.meleleo@coralogix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783518119; l=1123;
 i=mattia.meleleo@coralogix.com; s=20260707; h=from:subject:message-id;
 bh=766ztwFBIetWgxKoZZgeUKJCGrbo58G2Y/FPIvlaf+s=;
 b=c3Ik8Gu7yKFePrD+Vyi7Z+EJBxqPu6omkq95Cp/7RvNogFSQ5dAN95OUuetKY0TVtRVbewzYh
 qcaj/FQApKVBQBD31jI0Ze8WXaG8ER1TBCDAuXmN/Ivqg1GD5E8WSHf
X-Developer-Key: i=mattia.meleleo@coralogix.com; a=ed25519;
 pk=cs1zLoe3YDm4bJ7bfbPaZH0lHnd871JyJLiSh2eEzLs=
X-Endpoint-Received: by B4 Relay for mattia.meleleo@coralogix.com/20260707
 with auth_id=857
X-Original-From: Mattia Meleleo <mattia.meleleo@coralogix.com>
Reply-To: mattia.meleleo@coralogix.com

Sockets added to a sockmap/sockhash with no stream/skb verdict program
attached answer FIONREAD with 0 even when unread data is pending in
sk_receive_queue. Fix tcp_bpf_ioctl() to account for the receive queue
in that case, and add a selftest.

Changes in v2:
- Split the fix and the selftest into separate patches
- Use READ_ONCE() to read the verdict program pointers
- Link to v1: https://patch.msgid.link/20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com

Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
---
Mattia Meleleo (2):
      bpf, sockmap: Account for receive queue in FIONREAD without a verdict program
      selftests/bpf: Test FIONREAD on a sockmap socket without a verdict program

 net/ipv4/tcp_bpf.c                                 | 17 +++++++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
---
base-commit: d2c9a99135da931377240942d44f3dea104cedb8
change-id: 20260707-fionread-no-verdict-a4f8697ac9f9

Best regards,
--  
Mattia Meleleo <mattia.meleleo@coralogix.com>


