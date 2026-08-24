Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD74388E43;
	Mon, 24 Aug 2026 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601915; cv=none; b=M5IA1zZZM9bHl8Sax+hdCZTUMwBv+VAZmX+CMQhLbJd+zfzZrSqxLXeVhROXWLrrPCfAmrO8L456a++P7XDurjPnr/lwQwYLqw63Po0BtzFUW/Q7mxAX9gmAXxp+BK4b9csRq5mqGwKdg3h3jPKF/dWc0dYvhFlOaB/+N6j3tEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601915; c=relaxed/simple;
	bh=m4JMXg9fRMNaVDyDYO/LRWhBUw8Dp1uML2O+nocItvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhh55Ej0CAzsZLfLrAWInIDWosLMItGhc0wqKuMEMnUlWuKWYaSUjnBu3XtjRnuKr/J6YS03PCSr/hKV6AgWOM9uYCVuXCz+L7plv11rqAHCuL0nCl0iKPbuGxSdbs5Cp5QEEV7voja+dOAVy1QE+rJ28JHlI2LKgI6t+cFmkS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiKEFqm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiKEFqm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9741F000E9;
	Mon, 24 Aug 2026 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787601913;
	bh=jQBs2uPNnK7rx9Pux62bsIJrMgBaahbJtmT/+3VvJzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HiKEFqm4QwGpNqbuzcTwW/LBQ7O4I7kdEA1SiDMyXJOjvUZvTcYSN9urKtyvXN465
	 wKQGJJwvEMY8Qjf0kRWl56Ut4xMKb6wCqW3gtaf6nh7xJKct5glRP2R6Jj9XDYnvPw
	 a6aCgGBQ6Lv45aJmk07xsEkwPRKFYUglP4WjEm1ifBx2QR62kSQoIWNHVkHF6tUR9M
	 xiEvj5PAW66yAjrVnkZ04hA2t3eFm9iDkrxkmK6LaLtUfYMSJFyHhdfvxC3GgqDFju
	 aIVjDGsGzTmp5bVWV2mQZgGvvCi9GrXnT9kI8ZRqyIy5Rw8Ff/aJYwmQFiAudxH+wy
	 EwBNGvaH1p2xg==
Date: Mon, 24 Aug 2026 13:05:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, horms@kernel.org,
 dsahern@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, donald.hunter@gmail.com, kuniyu@google.com,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com,
 Mike_Rudolph@comcast.com, Jeff_Howe@comcast.com, srichard@netapp.com
Subject: Re: [PATCH v8 net-next 0/2] Explicit TSO segment count
Message-ID: <20260824130511.2955f30d@kernel.org>
In-Reply-To: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Aug 2026 18:31:37 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>=20
> Hello,
>=20
> This series replaces the existing min_tso_segs() congestion control
> callback with a new tso_segs() callback that allows congestion control
> algorithms to provide an explicit TSO segment count for each data burst.
> =C2=A0
> To support BPF congestion controls, the series also exposes
> tcp_tso_autosize() as a BPF kfunc, allowing BPF implementations to
> reuse the kernel TSO autosizing logic while implementing custom
> tso_segs() callbacks.

AI CI says:

The bpf-ci build jobs are failing for this patch on all tested
architectures/toolchains (x86-64 gcc-15, x86-64 llvm-21, aarch64 gcc-15,
s390x gcc-15), all with the same link-time error:

  net/ipv4/tcp_bbr.o: in function `__BTF_ID__set8__tcp_bbr_check_kfunc_ids':
  tcp_bbr.c:(.BTF_ids+0x...): undefined reference to `KF_DEPRECATED'

This comes from the change to net/ipv4/tcp_bbr.c that marks the retained
bbr_min_tso_segs() kfunc entry with the KF_DEPRECATED flag:

  BTF_ID_FLAGS(func, bbr_min_tso_segs, KF_DEPRECATED)
  BTF_ID_FLAGS(func, bbr_tso_segs)

KF_DEPRECATED does not resolve to a usable symbol/flag in this tree, so
the BTF id set for tcp_bbr fails to link into vmlinux on every
architecture and toolchain -- it's a straight undefined-reference error,
not a per-arch/per-config issue.

Could you drop the KF_DEPRECATED flag (or use a flag that this kfunc
infrastructure actually defines) on bbr_min_tso_segs, and re-verify that
the kernel links cleanly? A local `make net/ipv4/tcp_bbr.o vmlinux`
build (or the bpf-ci selftest build job) should reproduce this quickly.

Full build log for reference:

  ld.lld-21: error: undefined symbol: KF_DEPRECATED
  >>> referenced by usercopy_64.c
  >>>               vmlinux.o:(__BTF_ID__set8__tcp_bbr_check_kfunc_ids) =20
