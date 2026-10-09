Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E44ABBCF;
	Fri,  9 Oct 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545123; cv=none; b=r3UPLFLFQ7qTeNbdzbB9irzBnKQDoN05SPbKTpw9iqEujgdROcKZ/2RaB1DrOshccszWRenuZTsoOlw5ZraI9/a8oA9bTnpIJOujpO4zmqR2n04MEpWgVyPAenmrbHp56kuz4R9nK8jAfzlhrcIRSOoXkO0etHKRdVcJT5sKnd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545123; c=relaxed/simple;
	bh=KcUh4MZHrnR4a63nZHmMtJNNZuW4M3LW4ICa3IFGebM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvSnenacWPw0Kh1V7RUdwbZLvUdW2q0PVBqSOt6WFdOysjDj/1RmXNpPihXANKXU82Fqa+zYlQ5EJXysYEQepWxXIR6ew50gqiDaSA5jq9x95Cz9t5zvOTl1Sn0pOTvGFsIkL4BiSUlWbxyQcrhj4pfHKaBgrwestmfXBg+LHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwt+9Jdr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwt+9Jdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DCC1F00900;
	Fri,  9 Oct 2026 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791545112;
	bh=U4xMwr/21zOdESeEfZbI6IrEzozFKelIIS7HuFvLYLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Mwt+9JdrtTOlF0MG7e82+80luCEzOr14WKUw4gs6fwvAZO9j9m2J4rQuo8wFxOtT5
	 QsVqqT2zizDjJ7jB9kH7alH6rGY7zR4w2no7JzJh7c0Yd/aXSugs3KWksMovoP7MNS
	 yNY9Fek1Tcx5nX75iL3MlFFt8xY0QKpI++UCg/nHQdpC8f2oxfwFpjQLtX/45zLQpr
	 QMk9m6G+XwvNeFtlGs4n77xTAALOrYssxm6GE2Tf3HNNbjxF0agp+WDGcc0Zfq4ABc
	 D6EK/t7bYkvkwrLnN88Gc6/G5t4Zla/SG7S+VddcZi/ja6TWF0DHzdL8CPSsRFCZOj
	 dgmYJxPfj4mNQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net-next 08/14] selftests: xsk: run one test case per
 xskxceiver invocation
In-Reply-To: <20261008114909.734364-9-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-9-maciej.fijalkowski@intel.com>
Date: Fri, 09 Oct 2026 13:25:08 +0200
Message-ID: <87mrsnqfor.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Make test_xsk.sh own the mode x case matrix and run xskxceiver once per
> case, so that every case starts from a fresh process and a case that
> crashes fails only itself. A single case is also the unit that the next
> patch splits into separate RX and TX endpoint processes.
>
> xskxceiver now requires -m and -t and runs exactly that case. It
> reports one KTAP result and exits with its verdict. An unsupported mode
> skips the case instead of exiting with XFAIL.
>
> test_xsk.sh runs every case in the skb and drv modes, or in the one
> given with -m, in both the softirq and the busy-poll pass, and prints a
> summary of the passed, skipped and failed cases. -t also accepts a test
> name, which is resolved through xskxceiver -l. Only skb and drv modes
> are accepted, as veth has no zero-copy support, and the script skips
> when xskxceiver was not built. As ARGS is now rebuilt for every case,
> exec_xskxceiver() adds -b to a local copy of it.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  .../selftests/net/lib/xsk/xskxceiver.c        |  52 ++++-----
>  tools/testing/selftests/net/test_xsk.sh       | 102 ++++++++++++++----
>  tools/testing/selftests/net/xsk_prereqs.sh    |   6 +-
>  3 files changed, 103 insertions(+), 57 deletions(-)

Again, Python please. Maybe carry the bash side over in the first
commit, and here introduce a new, shiny Python test driver?


Bj=C3=B6rn
