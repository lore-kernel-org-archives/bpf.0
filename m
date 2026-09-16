Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC983939C2
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549421; cv=none; b=Fm6u6FFCCmX14Z8nshECU1beU1cTU+INIdq+FzjVTHdv7lo27NcYfKXDyXJafI09mkfcyLkA5nolZ8krUbhJgNVdjDAmkxN1b5U/rZmdEUO1dN3cXpWGZv/VgYZBX8sJCf2sHVN0fR5Etjg/mxqWjSH3DWPGWGlHjk6gCCDiAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549421; c=relaxed/simple;
	bh=4shCVTwP10AwFJyxRP1R4QaJ+hWAnAQs0/uvFv/W41I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kdzpskLjwzFGRjTX5ELBxeuShmjxgXqYDQirCJHpitsGZG3TSB+VOtDnkjB0Ah3qlMwO4p8geMSH78a33qxDY227H3iLEHTJaGmBTAm8BQGb/RacZTyZH33+lqz9oC61Fv2L7MzNPba+RZpOfb/FIvlaaUccvW4ppq/oOFJzIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VizXUM6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VizXUM6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E661F00893;
	Wed, 16 Sep 2026 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549399;
	bh=ZUntD3rfIoOWJXEqLX4QVvX/zCwxf3QEG4AGg9Tacls=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VizXUM6XOffr0XbN5MBYYnLtSCY0j7In03i7GTJJsQF+7UzYyd7kAMVz7deYApNjy
	 6LC1NkzRTA/4GMSnu5L3al1wSDrzFAp2mwnx42wGXxtlT+5fxxJuMtg8f3XbGx2igN
	 M5tLvsqwpU8cqhia4onvzszvfPhPsO9/SsPwZsA4z5JxkRWyqmRfF9Pe2saV27Sdhm
	 NS6LOF2A1TJtoN7WDgBGIz6iefkD2qxR2kxdTml9Fkl/VthYgawRaa2RZ4BVJoTUMu
	 MTA6l2fs7wqehPXhM7/IzJoLiq35wQ0ZsUg5VbSjeuy4vfnTFVCbJp1Zy8gjmL6l16
	 UvcLSil6gF/Hg==
Content-Type: multipart/mixed; boundary="===============0950651048023247025=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6b8df5b34cc3f00f42a8be6778de84a8c615991345314d3c8d1e68bb3f1e284e@mail.kernel.org>
In-Reply-To: <20260916074118.1007116-10-alan.maguire@oracle.com>
References: <20260916074118.1007116-10-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,jolsa@kernel.org
Cc: daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 09:03:18 +0000 (UTC)

--===============0950651048023247025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> and LOCSEC shows function name associated with site:
>
>   [15] LOCSEC 'inline.text' vlen=1
>         name=foo func_type_id=5 loc_proto_type_id=14 offset=64

This isn't a bug, but the sample output doesn't match what the code emits.
tools/bpf/bpftool/btf.c:579 prints:

    printf("\n\tname='%s' func_type_id=%u loc_proto_type_id=%u offset=%u", ...);

so the real output is name='foo' with the name quoted. The changelog sample
drops the quotes.

Also, the LOC_PROTO sample in the same message is internally inconsistent with
the LOC_PARAM sample above it: types [12] and [13] are shown as values='0x2a'
and values='*(r10 + 0x20)', but the [14] LOC_PROTO sample renders the same ids
12 and 13 as 'r1' and '*(r2 + 0x10)'. Worth fixing the pasted output so a
reader can match it against a real dump?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35072175008
--===============0950651048023247025==--
