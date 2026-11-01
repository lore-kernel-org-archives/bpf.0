Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561915;
	b=Y4czVzw9qHFI3bDMdX/aCDT2ISpOsspqyGHpFXEgiO30l4ktDR7LA+BATUnUMpzWGop2
	 hoBX/PnNnSKF0Es7xk1q0i4BUMvGaQHznOxcHndqJgMoi/JaWlHKuArfRGNOBC/ht7O+6
	 ZmxCOly66dguxqcyj/kZ5xxrrO5gKpBNQOGOtBDsv8uoQqd1DN3Y/Nc0EATzGWa+Z9Hxx
	 zxpvPLdRRUKd85jGUqmHjzH+gUND45oHlbPk+ez9uMavlOXi1g/mnNX2EB7J2a5//fwyS
	 Lxiu9P+IJ59szPnefRWSoQJrAVDDO0Y/XLK0xavOYnrqpclbvgNCEqCMzEwza4eWcXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561915;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=3RbSOoy5FH/veJnMAMYNkGnr6COx79E2WynqfTJCp9c=;
	b=1u7GKHg2crf5k8Ld0Ca61fphi3mXxbDKBzAqZOCu/LGgNnWH/W9alnlLjv7Dfnc/YKvk
	 2ycsJCUXo7qmrTjW5drO3McEWYLhm+9M6o1Dt7siCM+aLC9yMVgaTvYOT88mnpsm40cmU
	 LLsbQ0rEY12nHpyXBR934qwTxo9SukrRBnfofaroKASiBExdQjMzVey+q8OsWByaaybbO
	 H6W0Nla1uoqPmeHd8B8sJGWvCZQPp4UDcJinM4Z/rF8cxkXXJemP62eYT7fBvocEVr8qI
	 +q4ueDzb5EfRO6rF1aib//Xo0uWQ7Brl/CXZaI1rSkk5oqGW2+kkNkzUcG1LrrwhwEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESnc4Q+G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F6606A325
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESnc4Q+G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4019F1F00919;
	Sun,  1 Nov 2026 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561914;
	bh=3RbSOoy5FH/veJnMAMYNkGnr6COx79E2WynqfTJCp9c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ESnc4Q+GRG5AITvYFcPqXFIgol3bxSsA3Z7Kduz/Gj8DgBfsssJ4kcMIbJVXGvBtH
	 cbwDQNTHVPqrtnhtxONhu4hoYahL/HPKNFLwbag3uLkNcjFSIWS3ApK6NDQN6rnX45
	 2bsO/PthKdtJ5Z2rN8NB01XurvF+2PgEnCgVVWRj3OwF/UUG3BKkjonSKXalHr3lvi
	 BpTlYCrlPPKjQLg7+iw18MUNpGdT5ur9fQk2G0NvJ+2VwEf/xPzKTn2f+EBcQOBoq3
	 UJ4E7qnb/e4Sw2GV34+/eqmkxWcPlY16N6i1mEwZCSkjDB1i17mtBNRedvZ9P04khi
	 ZhiTK0GxilxYw==
Content-Type: multipart/mixed; boundary="===============8155492407224996161=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2f1f9e07591b012765b2ca2697e1aa4da38a03aef3e68122e86dc557beef0623@mail.kernel.org>
In-Reply-To: <20261101190535.1454146-18-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-18-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 17/27] bpf: Set a dst for test runs of lwt_in progs
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  1 Nov 2026 19:38:34 +0000 (UTC)

--===============8155492407224996161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Set a dst for test runs of lwt_in progs

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit;
cd3092c7f8db, which first let lwt_in progs call the helper in test runs, looks
more accurate. Backport scope is the same either way.

> bpf: Set a dst for test runs of lwt_in progs
>
> When an lwt prog runs on a route, the skb always has a dst. To push an SRH,
> bpf_lwt_push_encap() reads the device from this dst. But
> bpf_prog_test_run_skb() sets a dst for lwt_xmit progs only. Thus the helper
> dereferences a NULL dst in a test run of an lwt_in prog.
>
> Set the same dst, ip6_null_entry, for lwt_in progs. When IPv6 is disabled
> or not built, their test run now fails with -EOPNOTSUPP too. An lwt_out
> prog cannot call this helper.
>
> Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Does the Fixes: tag point at the commit that introduced this problem?

fe94cc290f53 added bpf_lwt_push_encap() and bpf_lwt_push_encap_proto, but no
get_func_proto callback returned that proto at that point.  The only
references to bpf_lwt_push_encap_proto in net/core/filter.c are its
definition, so no BPF program type could call the helper, and the NULL dst
was not reachable from a test run.

The immediate child, cd3092c7f8db ("bpf: Split lwt inout verifier
structures", same series, 2018-05-20), added lwt_in_func_proto() returning
&bpf_lwt_push_encap_proto and a separate lwt_in_prog_ops with
.test_run = bpf_prog_test_run_skb.  That is the commit that first let an
lwt_in prog call the helper under BPF_PROG_TEST_RUN, where
seg6_do_srh_encap() and seg6_do_srh_inline() dereference skb_dst(skb)->dev
with no dst set.

Should this be:

  Fixes: cd3092c7f8db ("bpf: Split lwt inout verifier structures")

The two commits are consecutive and ship in the same release, so the stable
backport scope is the same either way.  fe94cc290f53 is defensible as the
commit that added the dereferencing code.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41340841959
--===============8155492407224996161==--
