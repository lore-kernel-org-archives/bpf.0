Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439028;
	b=xnPPkC4d9b9+RBm/RHiaK5f18gpeoihslyYwHNVi3dJdfl1g1ehgaAWtin1N47A2E5AL
	 oxN/iaEuFr6RiMHWnZ9lZo7DlIy3VWqTxPHfIZ6L+S8u5MCDouc97GxXqQ8ASHeJ36wFF
	 a2fHHkmW7w1/FRhOeVsGyMPOynWEwt6/qHMRrWPHilC9zDwGLEyzBQBreT2MgmgLyVpRW
	 tu5EpHaTCP+QXrTmP/ZnkujMyQfATmmGliPh22wDEtNMsJTjqJc0scMr3VHtdZoiN5zoa
	 tADtmqnvaWhAdmfYTKtKOmYwePCccw60DoHpU+JSr32u4ISne/bHy5YwgFbga/N4FKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439028;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=+TLwaXUoFypgKqCxSI5029UeGIHv1KTyx47LLo41gQg=;
	b=UKNLPcaxOr1O3kazJmta1u24HmMKVETiOGibNMafhWHYhLTtElWzmR4gNoebYjc/90bh
	 QjOaCnbtb56XmBPDT047F8a5JHHpb0Fvbo/nUicxtNeIbZdpgn2fWH+D8CjpOzhMR5pRj
	 3aEApRgHLSafYHy5xe6jAq3+at502jHh+DdJfzUgNfP8EcDJAtgmZeiT4COuT5ck3JiDz
	 GiOPNRKENxcvC5E9rmbwtJjkbVvX2WXASvhXS1JUwCRtH1P1ncWVauCBCkHIB2o+Q/BtE
	 onhIBjsQf399xBy8l6WAsgGlPctS8MwZOEjN2lZ6X9xoYaMVR4KZ4kYzKMI5V7Y4RJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuaLLmFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4D606A335;
	Wed, 11 Nov 2026 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuaLLmFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53F01F00A06;
	Wed, 11 Nov 2026 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439027;
	bh=+TLwaXUoFypgKqCxSI5029UeGIHv1KTyx47LLo41gQg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CuaLLmFdlotIZ/MQZfwIJdPO1l8LhkY8K8p348uATuGNigv9peV62ilcZoT/cYjCD
	 TytY1OFXeVVrydyzL0RdCOALiOLm9Y092xnzr+zlNI+QxpqvYEOB3j/0cyB9RLyKg1
	 uQupBgMLvSaEkNC2dZq4q2ccIKY4Mk2d3c65z+bggUDiSIeXPEeidQsLkP1TMjDXgH
	 XuXHzjQmTzZySueQ3FTrI1evqrakgG2Qx4f+gWp+Kt09rRkDgRY6uP5U7AVOSaQNW9
	 novC88weh8eM5EgRypovbZ6/Hn0+X2zg1MIl2+so+FoOeHErcrSHrL9v0Xca/c2EQi
	 q+7WKO6L7Q28w==
Content-Type: multipart/mixed; boundary="===============0184974593136184740=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <54d7eddad4b50bbaa72bc31ea3219ce9a944548da1fef3eabbc1e7337d37e5f2@mail.kernel.org>
In-Reply-To: <20261111115911.1142000-7-david.laight.linux@gmail.com>
References: <20261111115911.1142000-7-david.laight.linux@gmail.com>
Subject: Re: [PATCH v3 next 06/13] kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output
From: bot+bpf-ci@kernel.org
To: david.laight.linux@gmail.com,pmladek@suse.com,kees@kernel.org,david.laight.linux@gmail.com,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,jim.cromie@gmail.com,ljs@kernel.org
Cc: mcgrof@kernel.org,andrey.grodzovsky@crowdstrike.com,rostedt@goodmis.org,andrii@kernel.org,wusamuel@google.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 23:17:06 +0000 (UTC)

--===============0184974593136184740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output

TL;DR: Commit message only: it says 4 functions get noinline_for_stack but the
patch marks 5, and it omits the compression-ratio output format fix; maybe
split that into a separate patch.

> kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output
>
> - Improve the test stability/reproducability by taking the faster of
>   two calls to kallsyms_lookup_name().
> - Check that kallsyms_lookup_name() returns the expected address
>   unless the symbol is duplicated.
> - Report the names of the min/max symbols.
> - Output an 8 line 64 entry histogram of the times taken.
> - This shows there is a reasonably normal distribution with a small
>   number of much slower outliers that don't really affect the average.
>
> Additionally:
> - Add a very long symbol to check the handling of two byte lengths.
> - Do the test_perf_kallsyms_lookup_name() last because it can take long
>   enough that the CPU frequency changes and the times reported by the
>   other tests can change.
> - Mark the 4 test functions noinline_for_stack since they all have a
>   quite large on-stack structure.
>
> Example output (after all these patches)
> kallsyms_on_each_symbol() traverse all: 7742950 ns
> kallsyms_on_each_match_symbol() traverse all: 951 ns
> kallsyms_lookup_name() looked up 123312 symbols, average 200 ns
>         fastest 60 ns (_rs.0)
>         slowest 662 ns (The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_sho)
>         Distribution, 20ns per column, 2916 counts per *:
>         |         **
>         |        ****
>         |        ****
>         |        ****
>         |       ******
>         |       *******
>         |      *********
>         |   ******************  **    * * *
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
>

The changelog says 4 test functions are marked noinline_for_stack "since they
all have a quite large on-stack structure", but the patch marks five:
test_kallsyms_compression_ratio(), test_perf_kallsyms_lookup_name(),
test_perf_kallsyms_on_each_symbol(), test_perf_kallsyms_on_each_match_symbol()
and test_kallsyms_basic_function().

test_kallsyms_compression_ratio() has only seven u32 locals and no large
on-stack structure, so the stated reason does not cover it.

The same function also changes its output format from "%2d.%-2d" to
"%2d.%02d", which fixes how the fractional part is printed (12.05 used to show
as "12.5 "). The changelog does not mention this.

Could the changelog give the right count and mention the format fix, or should
the compression-ratio changes go in a separate patch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43116767394
--===============0184974593136184740==--
