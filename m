Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241971;
	b=0mB2YNrvsqDVbAx12wklFE7PkmANQQdo+rEuzoWKr1H3UNMysJHU0yJne4j6/l98fobp
	 k60dbpPrI7DJm+QyUNBP/9YV7IFra4m4IE9Ll/QYLiimu8UWubWCSTpygNpeNmA0zXr3Z
	 w5u5CKdiTz0ID4/ZkVVBcIybgD1J6/ggwi1OGb+sDu4eRGPged2bwYsFQG1UFcbbuKKHF
	 azfccZGD0fU276KqswnG9B/1Sidd4NpUmxT3bCmAxfkmMV/4uTcCJcumIE0eYTYjeU/NC
	 bMCp+IslUfhQxDhjdfqMWKI3f5b0hG7Ah2qJfhjfAJnR9tJSBF12KaaiK8iGwRJb/lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241971;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tmdAlQQMYM/h8Vrm9jwFISuK3h8nzxM7Mp+G3BiwLoE=;
	b=qxMTfFAMuDQ1lRyxPjG9SOMK598xR1dWIPSFTQSehf7KEjpHvQgh3Yo56Y1thzqFENd1
	 3Kv2bpIzOXE/izwH229oCK+Our9p49RFtB/TXhAKeqbL3HgvUleXZRgESMsQE8047vNbL
	 LqxWgJgFZouf9gdlTDquU/G/XAwDNPpDAqxsgWkPzj8m8FLOmdiG3Eke7eC8xZaiwGCD4
	 dr0E9XEXFIOtf+nOLg0nCoAGTHjGBRwWhaxmywrEQ5zYW3ku1fXYGhM5lVip9P71D38G3
	 YVorTDem6VzpWUE5OxwP5uJd4n9Y0JSLoL87uoSiOy71mnhN6sH7Zgpnj2T6mr3OZ/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWOTL8P4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD6606A321;
	Mon,  9 Nov 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWOTL8P4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3641F0089F;
	Mon,  9 Nov 2026 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241970;
	bh=tmdAlQQMYM/h8Vrm9jwFISuK3h8nzxM7Mp+G3BiwLoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XWOTL8P4bldmn4ibZNQqrIGEufQ3ysjJA/SfZLC/QbZjrp93/Te1fC1F7nR9bEzmO
	 CTJZqBt0k7ebvKB/lW3wdhl4e3UhqicBlbdWWRDIfpPaj393HuKSmyMZRIKzd63YMI
	 5h0yTl2uEIq9s4cZ41P814Te712tesIu8kFgeef7I3lKg6t4yTCEbf0/4pu0ZgvFoZ
	 dpcUkzGO0rJWFiwyNrTgIG75a3/d0aS2BEbfdsynkpD5aKSiMtFzshhHQiVa4RtX7d
	 MThS4oM8CAbHUgMF7NjlTXZEkx+nCzdoUhk59fKxFVVQ2xlenbq/g6t2LNoFsAUqqx
	 Rm2p/g4+gjUcQ==
Message-ID: <sashiko-outbox-205236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.5] selftests/sched_ext: Fix enable_cmask
 load failure on older clangs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20261109162623.674441-1-tj@kernel.org>
References: <6af1e5f2.a438010f.130489.ab94@mx.google.com>
 <20261109162623.674441-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 16:32:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/sched_ext: missing Fixes: trailer for
  enable_cmask_enable() fix
--

commit 948cafa51d1e3328d46bf77feab57f93ed6e21e0
Author: Tejun Heo <tj@kernel.org>

> selftests/sched_ext: Fix enable_cmask load failure on older clangs
>
> enable_cmask casts the u64 arena address of the task's cmask to an __arena
> pointer without cast_kern(). Older clangs without
> __BPF_FEATURE_ADDR_SPACE_CAST need the explicit cast, so the test fails to
> load there. Add it.
>
> Reported-by: Zhijian Han <hanzhijian1991@gmail.com>
> Closes: https://lore.kernel.org/all/6af1e5f2.a438010f.130489.ab94@mx.goog=
le.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>

[Severity: Low]
Should this commit include a Fixes: tag for the commit that added the test?

  Fixes: d781d1b78acf ("selftests/sched_ext: Check the cmask cid-form ops.e=
nable() receives")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109162623.6744=
41-1-tj@kernel.org?part=3D1
