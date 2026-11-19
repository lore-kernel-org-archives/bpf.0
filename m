Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059786;
	b=RWNz3Ij0dgAyCEW6xT6X7H9zO+abBABoBS91oYmEUr5ijoigagHB4x0uRTbgFoZvEf9D
	 rahHtBGYSrtUoyFjc79l8oL18TCS/9hlIlZ3KCuXE+PbTictYe3F3VPrarSYcPOpynBoR
	 sxlTrSJECNWYbC9KjFR8M31yiw/5sbq82GASK4tLrT/7cv1BtMCFSsVn/t1iObrdhexnr
	 xIHAuVwOQpICcpdqkiiHEFHVGnhOWpWWztUBQM5aS/kShvfIKSAfpAAoOeQqTugymjnDg
	 BRy92RZ0M3i5phuPsb7nvNxnFeuBkFlfP0Ceyb2BLHSP8HMkhSR2htIZEiOtWKI5Gww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FYedBz3QmxA+ahAtpKqLbz05VXo08BCPFUCdyls/+Q4=;
	b=j2+FO+TQaZIEnVvvFOovrQW5Jv6a5kZXrbJC2lDZR+/juwGEom/Pz0tR/NMBloO0OJH0
	 EFmEgFlU4nRGp16DuypB9JWyNmG/IfizSgDxI03isnvpz2lQgAlN3QHsSkCDIApnt0Jme
	 9a6zZyuDcWtsrFFE5lk5zbFWUG0K3vYtqtbiV/mLW5/LGaJXw6RHgwT5N8T1+L/S1NKOW
	 ipKKJsV+PwgS+gHpvwUdDpT0TXOhb2ct/F7gpci9zJ4+5dbfwhBYV0x3Nriq66MT3DOnS
	 o7bQ1NPLEObjfSMwUYu9rBNHBZZfdyZ/0wM1VtrdeC9MeWKheOX6eJq+X0609JeAXqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aOM/5wNR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E1B606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOM/5wNR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6A31F000C6;
	Thu, 19 Nov 2026 03:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795059786;
	bh=FYedBz3QmxA+ahAtpKqLbz05VXo08BCPFUCdyls/+Q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOM/5wNRqafH9TXFWRhN2FWDqKGpHiaM/upZmr09PdRgBILz+hFXsuUy+fQpJH088
	 19+b1yR1HDilWiRWoWla2vI/zDTgDMGyq+YzDZEzceSnP9Lt6Lty4xUHpfPBQaYloJ
	 jjTcN4A2JifkeGIjZQ/SEW0v4TTvZYnr2q7TVkjQqwrKQ8Pl52f3c+lMb+kBsgxOYo
	 ip2P39Gj8p7mEcej7uJ87hCnwXgJAhcYzzWUdTzgrbXpqurYYioF9m510XmfiIJbqG
	 f5pwGFjZ9zAT7tJdY95Hc0XzTyv9UGKWTi6cRfOhgo/QkVFVRVax33hSzGtSPyCHRO
	 WGrq1bkoWYxcQ==
Message-ID: <sashiko-outbox-222403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: Test wq callback setup
 after deletion and user release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261119033051.196177-7-luyun_611@163.com>
References: <20261119033051.196177-1-luyun_611@163.com>
 <20261119033051.196177-7-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 03:43:05 +0000
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
- [Low] selftests/bpf: multi-line comment style in
  test_wq_usercnt_reuse()
--

commit c499c2c6b9f5e1ec7aa72bc0571ecd4ff2c11fb1
Author: Yun Lu <luyun@kylinos.cn>

selftests/bpf: Test wq callback setup after deletion and user release

This commit adds BPF selftests covering bpf_wq_set_callback() on deleted
hash map elements and on reused elements after the last map user reference
is dropped.

> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/=
selftests/bpf/prog_tests/wq.c
> index a4f71bc34fa6c..f783a91417e00 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -1,11 +1,109 @@

[ ... ]

> +/* Check callback setup after reusing an idle object with no map uref. */
> +static void test_wq_usercnt_reuse(void)
> +{

[ ... ]

> +		/* Drop all target-map user FDs; the retained program FD keeps
> +		 * the map alive through used_maps, but usercnt becomes zero.
> +		 */
> +		wq__destroy(skel);

[Severity: Low]
This isn't a bug, but BPF multi-line comment style puts the opening /* on
its own line with the comment text starting on the next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119033051.1961=
77-1-luyun_611@163.com?part=3D6
