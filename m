Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E54616F288
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370298; cv=none; b=BIiVbPS9Zhdad2Jm1coH+seyvfBFeJjHvHj1N1Ap0olzRYqHFzPmrM04FxOfiPJ3rH0NDUTQf3AKPXQTCZ1O+NjA6KwhUvgbM6F6z6sDUkvOH+GSk9MPf8BC8JmTtLMyBeZw1e2I4fauigJEIDMlV+9+r/o8UUkKEx9B4v92Ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370298; c=relaxed/simple;
	bh=CFWJzPCQBhKYyh/ksisNTJCRQ2ryP6Wxj08cjGECjco=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JRpjKY6Nc27EBvT2bctdLHt3JfhwwucqbR8FMRuRDI8KVK3obTg1ZgrPoAc9i13ee5TxQUldkUCVFIszoEvbA224Z6WpxxqS8Xt/+OGTdVfo0cZYdA0+RnZQm4zb0Y1HzWvosUEfwnvdGjw/JRpS7PkHkjrdP3vKk/I4NkeLrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IbThocr2; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IbThocr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785370287; x=1785629487;
	bh=ev5K0c5doWRcjwgx9VMfXeb1bbVe4v5pJNBelZ30NbE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IbThocr21dYQTr49f3t8UJdP17YYJz/Mniy8j9UZZBhz28JEvSQeM7FTAS9wap2LE
	 fzMd46lq1CnDMgDxTgDH4G7sGtpxrTZZyCd4BoqjrkmV2prY8AfVmXZcvxJ13YHgwA
	 oUL1Gs1wxhDkwLBSK/EvnEiHvrEkd2aCG8pEZZSaqZrG/vkENQkZbluPwP4LhHPbog
	 x+0cwj01XbB8YeMm2h4/ZSslqmEE958b8Xv7S8sIrMrqED4aoPAL47SQUXti8PpxTV
	 gOu9L26BPQt/Z8alNya1in314VwVqwWyIuXY7ZtfqUK75EQ9J22drf3lsnwE04LliR
	 VhJMXJQkQLE3Q==
Date: Thu, 30 Jul 2026 00:11:22 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me
Subject: [PATCH bpf-next v3 0/3] Simplify min()/max(), contains() and normalize() cnum implementation
Message-ID: <20260730001145.381820-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 690e3197907f0a8df1c539c5a18dc834a5f4c9d5
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

v2 -> v3:

    - Change 'optimization' to 'simplification' in commit descriptions.
    - Fix typos in commit description.
    - Make commit messages about contains() and normalize()
      simplification more descriptive.
    - Make '/*' be on its own line in {u,s}range_overflow comments.

v1 -> v2:

    - Split the contains and normalize changes into 2 patches.
    - Added comments regarding the use of empty cnum's in
      {u,s}range_overflow().
    - Fixed typing mistake in cover letter (removed the `fix` word).

v2: https://lore.kernel.org/bpf/20260729194932.292368-1-vldsampaio@pm.me/
v1: https://lore.kernel.org/bpf/20260728015601.1567098-1-vldsampaio@pm.me/

Vinicius Sampaio (3):
  bpf: Simplify cnum contains() by removing redundant branches
  bpf: Simplify cnum normalize() by dropping unnecessary comparisons
  bpf: Avoid redundant min()/max() in cnum signed bounds

 kernel/bpf/cnum_defs.h | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

--=20
2.54.0


