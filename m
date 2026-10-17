Received: from mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106630AAD8
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198655; cv=none; b=PzuSTYbcHlogtJGmf6yVjfIYCK6VTlqJQWH5Rxa/y1VM1+h/kLegVZKx6acWNxuPYjGYQwf0yXT/LGCi7I7J7gc2x+nv8EZ4pkKGEzrBpPw3KX6QyGnsu8gw8Fw0JT2d3xQRPfTONJryqGhA8LLe9FlEHEWGvqUQjRNrVYGkUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198655; c=relaxed/simple;
	bh=3idAyDLJOjUgEJcU8QmESUe5xKhFdAjPCrsFdl/wDUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIlsqJCSgmnbC+jQbM2rgKXxEskZjd4IKDuioKh7srmY7tKFWOX5s0QCx/b4caTKkfFb2ks6ZulkkMUgB0NCXI8MHkYXoiEvoY2KjiOoaRKDlRcso191ITsjx50XWvg1/9nSqhnl4MjoTmrBG2prlr02flvbv84kpBsdwaYv/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tHE9dwjo; arc=none smtp.client-ip=95.215.58.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tHE9dwjo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3idAyDLJOjUgEJcU8QmESUe5xKhFdAjPCrsFdl/wDUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792198650; v=1; x=1792803450;
 b=tHE9dwjoO+J/OGjkWJiT6aNklN/s36LhhLfOVdP7bZEZkp83IEe82Ll2zpsJokdqedSQbc2t
 E4tBlRze6lFaX/d2n6D5udMzVO0zISfGolZ/e/Azpag2PWXwrSv7MceJCS+zguPn08TDgg2F++L
 BKPDLkJIldb9mltEIXcgAQS4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3ffa47a96ebe855e;
	Sat, 17 Oct 2026 00:57:30 +0000
X-Mizu-Trace-ID: 3ffa47a96ebe855e
X-Migadu-Flow: FLOW_OUT
Message-ID: <f77fd2b8bce1a029ac295b4482402a8c2203db57.camel@linux.dev>
Subject: Re: [PATCH bpf-next v2 0/7] selftests/bpf: Fix selftests failures
 with LLVM 23
From: KaFai Wan <kafai.wan@linux.dev>
To: patchwork-bot+netdevbpf@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com,  ihor.solodrai@linux.dev,
 shuah@kernel.org, nathan@kernel.org,  ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com,  donggeunyoo.kernel@gmail.com,
 leon.hwang@linux.dev, menglong8.dong@gmail.com,  yatsenko@meta.com,
 jiangfeng@kylinos.cn, bjorn@kernel.org, puranjay@kernel.org, 
 vineet.gupta@linux.dev, mykolal@fb.com, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev
Date: Sat, 17 Oct 2026 08:57:18 +0800
In-Reply-To: <179211120751.4176565.4973025143783418812.git-patchwork-notify@kernel.org>
References: <20261014113043.640435-1-kafai.wan@linux.dev>
	 <179211120751.4176565.4973025143783418812.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-16 at 00:40 +0000, patchwork-bot+netdevbpf@kernel.org wrote=
:
> Hello:
>=20
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
>=20
> On Wed, 14 Oct 2026 19:30:36 +0800 you wrote:
> > Building with clang/LLVM 23 breaks several selftests. Patches #1 to #4 =
fix
> > those failures.
> >=20
> > The following self-tests also fail under specific invocations of
> > test_progs:
> >=20
> > - ./test_progs -t prog_tests_framework/test_fail -v
> > =C2=A0test_prog_tests_framework:FAIL:skip_cnt_check
> > =C2=A0unexpected skip_cnt_check: actual 0 !=3D expected 2
> >=20
> > [...]
>=20
> Here is the summary with links:
> =C2=A0 - [bpf-next,v2,1/7] bpf: Determine freplace staticness from BTF li=
nkage
> =C2=A0=C2=A0=C2=A0 (no matching commit)
> =C2=A0 - [bpf-next,v2,2/7] selftests/bpf: Fix stack_arg precision backtra=
cking log expectation
> =C2=A0=C2=A0=C2=A0 (no matching commit)
> =C2=A0 - [bpf-next,v2,3/7] selftests/bpf: Fix stack arg pruning test JOIN=
 log expectation
> =C2=A0=C2=A0=C2=A0 (no matching commit)
> =C2=A0 - [bpf-next,v2,4/7] selftests/bpf: Use _exit() in uprobe_multi_tes=
t clone-ed child
> =C2=A0=C2=A0=C2=A0 (no matching commit)
> =C2=A0 - [bpf-next,v2,5/7] selftests/bpf: Fix prog_tests framework subtes=
t count checks
> =C2=A0=C2=A0=C2=A0 https://git.kernel.org/bpf/bpf-next/c/c87652656a55
> =C2=A0 - [bpf-next,v2,6/7] selftests/bpf: Skip expected_msgs subtests whe=
n stdout is not saved
> =C2=A0=C2=A0=C2=A0 https://git.kernel.org/bpf/bpf-next/c/cc4b1c161d92
> =C2=A0 - [bpf-next,v2,7/7] selftests/bpf: Skip compare_text subtest when =
stdout is not saved
> =C2=A0=C2=A0=C2=A0 https://git.kernel.org/bpf/bpf-next/c/7ebf808caa76
>=20
> You are awesome, thank you!

Hi Alexei,

I resent the last 3 patches in v2 and changed the subject, expecting v2 to =
be reviewed first so we
could skip v1. Sorry, it didn=E2=80=99t work. The bot closed this thread wh=
ile applying the 3 patches from
v1. Should I resend the first 4 patches?

Sorry for the inconvenience.
--=20
Thanks,
KaFai
