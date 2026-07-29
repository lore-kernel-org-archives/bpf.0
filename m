Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D86389473
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354607; cv=none; b=jSVdXVszlVC2tgNSVIsGUa3VHI1d3WP1NIFO633Dt3bJ7i/vGDuDwPrtg/VhiAA8RFN8CouAwSIRpr71sCUWprTVSTIYTQBSmEwyX8jyTb6TS5U5aUYrMeUgQqto0Ix9HrduenltxgLWbIoa1DD8Hu4TQwQYjJnnMj3TWeUCl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354607; c=relaxed/simple;
	bh=QITqQ8CIaNriECjCd9xj+Sy5nGED59x/kWNYH+b/rr8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BjO6/96xg1S5DidT1JtU1XtIqQ8lpRnz/Azr3U1rixLFojSSMSrVHIFIVOw7D1sV3YQLaisNARmlIeextTL7xNHFgskRJ70Q2JyOay+l5jHhc+TKjiIBGND0ITa1ZmGFYAPJIgTnmaHQK+O1wI6TwRWg4M4HJCWtuAVJfkYlwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=N33/KG05; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="N33/KG05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785354594; x=1785613794;
	bh=X1Ya7TIB2mJQy/Eb8E0S/+WsU4zOSNsudAyvfGdbMQ8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=N33/KG05gX9R6X62RGMuFDERBfAWx4aJJmFu4eyd6YDKnkNKms/V4Vh4zN9qb4+u+
	 EhROMa5IzWLxjjpL8v7LrMcbEBzaU9Gqg85JX2SglE6hKgNVy4HJk/OyYvTqCQojbz
	 U/G58zvfogmwpSu0qiv04yB96dBqQz1UR3S520Ohj29jWHN5pNJORgBleq8ltu5sdA
	 wPUo9t7eC/kRQVmiZCVOR0SqdbgxGZ+0wVLN2eT/+SDI1D6KXBY/lkyIIH7YIC8sOM
	 opZhqt3KKLT0zW80S6LlK7UEgKAUvlA9jUqAqNqxga6pj5fQkKLFQExRakte2OTlQx
	 8lEemjDw+Gu8w==
Date: Wed, 29 Jul 2026 19:49:49 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me
Subject: [PATCH bpf-next v2 0/3] Simplify min()/max(), contains() and normalize() cnum implementation
Message-ID: <20260729194932.292368-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 8f8f94dbfbab70aaa5275abe88b3388761cf4909
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patches simplifies some functions of the cnum implementation:

- smin()/smax()
- contains()
- normalize()

---

v1 -> v2:

    - Split the contains and normalize changes into 2 patches.
    - Added comments regarding the use of empty cnum's in
      {u,s}range_overflow().
    - Fixed typing mistake in cover letter (removed the `fix` word).

v1: https://lore.kernel.org/bpf/20260728015601.1567098-1-vldsampaio@pm.me/

Vinicius Sampaio (3):
  bpf: Simplify cnum contains() implementation
  bpf: Simplify cnum normalize() implementation
  bpf: Avoid redundant min()/max() in cnum signed bounds

 kernel/bpf/cnum_defs.h | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

--=20
2.54.0


