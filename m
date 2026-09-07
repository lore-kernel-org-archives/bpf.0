Received: from out-utut-a193.jellyfish.systems (out-utut-a193.jellyfish.systems [198.177.127.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF12C026C
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744122; cv=none; b=TtPWiT9b4woO+N+xYqaQJ3GWd/kNPuUqv/UmNjIWA0YMH0h4Kgex/oa5jeshEQLZ7RIZwHSMoYlw+HV+5VdIh1UyU4YuGhE+X2FUHsrffWOd9dkXOVtKZw3sTJSqYxjgH4ULQvVn1iIRW7Pgpe/R4DgndoE75wkmwbsOQPhzAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744122; c=relaxed/simple;
	bh=oLwp5ePTAfsD9KQhwdmhsoOAAKdzYQt+/WiQBBIIupk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NX4NIxXmZ6IqFaGoEVt1fgdH+aFgl7Igfl5KRJ82yxaNW2vIhM36iI0nSp9Cl5j5uzisE3GcD2v3iOOrF0NGxT7IIGFtr67Sm8lgAexOD5GNVUQTJf+fhjCO7OBCpwFD2sKAB4VTrphhTpRYFNtdZZu4ZpJ3FdqPS61NEivMHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=g099Npv+; arc=none smtp.client-ip=198.177.127.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="g099Npv+"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdTn1420fz6tn0;
	Mon, 07 Sep 2026 01:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788744103;
	bh=oLwp5ePTAfsD9KQhwdmhsoOAAKdzYQt+/WiQBBIIupk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g099Npv+w1yoEQvrMlttIFXDzB2C1/h8mrbwn48qKN0zFWwgJ+1mPkJLvJBePwf9S
	 4wc+a+qsIANJObT9eoxnV5CxgCCoQkRPjq3DDoc/T+G6w+cB65BtbroCCCIGdmQGSy
	 QsorjDecgGf8s+EApfKQsm5ohrpAXP9ZTVCRDAXgwgcZX/kV9+59oezQbAjeKbjXPK
	 g8y+5ysDerrsIP23n5vuakXs7daLDBWGlAWBVo7iEZvYNtEPlQdwOe+OcGU1emk+Be
	 ob38qpAbVbHAqweJk58gqGVBx3hymKsl9qJCf8QakAox04QG7PxdqsbiTLAPIxMEda
	 5NKOpqZxfElRQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check bpftool batch map dump contents
Date: Mon,  7 Sep 2026 09:21:39 +0800
Message-ID: <178874362960.1415955.17828681051185974710.batch-review-reply@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <12b73f2a5fb57336f0238240607d7bbff24bb274df375cb4788556d7d6756bf5@mail.kernel.org>
References: <20260906170819.1212661-1-hi@tychen.cc> <20260906170819.1212661-3-hi@tychen.cc> <12b73f2a5fb57336f0238240607d7bbff24bb274df375cb4788556d7d6756bf5@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Thank you for the review. The batch implementation is patch 1 of the
same series:
https://lore.kernel.org/r/20260906170819.1212661-2-hi@tychen.cc

Its dump_map_batch() calls bpf_map_lookup_batch(), starts with up to 256
entries and grows the buffer on ENOSPC. Patch 2 tests that implementation.
The range described in the review appears to include the separate ring
buffer patch instead of this batch implementation.

The 255/256/257 cases therefore do straddle an implemented boundary.
Their assertions compare complete observable key/value output and do not
require a particular internal traversal order. I also built and tested
the v1 batch series independently and confirmed the batch syscalls.

The updated series is here:
https://lore.kernel.org/r/178874362960.1415955.9584865244247659247.batch-v2-0@tychen.cc

It also addresses the separate JSON error-reporting and comment-style
feedback. Fatal batch diagnostics now go to stderr. Fault injection
checked initial EFAULT/ENOMEM and post-progress EIO/EINVAL in compact and
pretty JSON, both with and without recursive dumping: documents remained
complete and contained only expected map entries, with a nonzero status.
Unsupported-command fallback and ENOSPC growth retained all 1,025 entries.

Thanks,
Tianyi
