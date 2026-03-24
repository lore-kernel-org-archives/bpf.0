Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9045040628C;
	Tue, 24 Mar 2026 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366116; cv=none; b=jzmOmsDWtanScrUFSXloYkNmApJvzPls/j7G+tb/8JD6klTR8wkYXuv7S+T+ytLzg9D11/p1aviyLTk2R1C0aqnqA719zBkbV63lCl4P1Kaz4CB/to47FxincYIfEuoByT70+dMivL918uXUy4KolEO9q+zB+k2kOGjKI0CsqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366116; c=relaxed/simple;
	bh=AFY1t3dzpLhOlBGSBGqfYpTg+GWsxbB/cGrQYVqi6pY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ElHb5uknapO81PI/8PpOvPBm7/hYD0IaAqRjhh7jA3JXoRli09WPLPHaedunyH/EXOWg2KUQF2Z/2cvtxvC36BaUc5Y3myob5LHDSNI25+NIcp+vKUrqUEze9K1WTHr9QvEk1taYFt1PjzuhzufRLNjT3Hd3QKGjoGktL2KXMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGdCu5F1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGdCu5F1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215F8C19424;
	Tue, 24 Mar 2026 15:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774366116;
	bh=AFY1t3dzpLhOlBGSBGqfYpTg+GWsxbB/cGrQYVqi6pY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sGdCu5F1rf0XWBuOICgzXfM6J80k5apLUCFmap0jPCj5+cN73SW1MkHGEo4dQxCxl
	 u/CmZkArZ5rnDGV+DLMB3OoLqnPXUcN4HOoPScbzovRr9/aF7kSpT2W0Qk452HJ383
	 k149QgyJBJV8LkHJsBsTx1FWjH6kLHg7M+ZhvWlxYTdy5wLMk/S5+1NgRiIWlmlUO/
	 AI9VZEVrvRgSDpUEOXyn44Bbnm3z5Pv9LNa6Ts/7ea8pd5mVNas4klQSpqQUza8uzB
	 gehjjOHsYnh5YuCeTiLzcASQ+xfi8rOsCTWjzbyJdgQzG+QTCBd33h4SIZJ+XGa7yX
	 VhVoqyx/Z80BA==
Date: Tue, 24 Mar 2026 08:28:35 -0700
From: Kees Cook <kees@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_libbpf=3A_Replace_strncpy=28=29_wit?=
 =?US-ASCII?Q?h_strnlen=28=29+memcpy=28=29_in_skel=5Fmap=5Fcreate=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook> <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
Message-ID: <D53376BA-4772-486B-A18A-6858C1732723@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 24, 2026 7:42:04 AM PDT, Alexei Starovoitov <alexei=2Estarovoitov=
@gmail=2Ecom> wrote:
>On Mon, Mar 23, 2026 at 10:25=E2=80=AFPM Kees Cook <kees@kernel=2Eorg> wr=
ote:
>>
>> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
>> > While the original strncpy() would have copied a full 16 bytes from a=
n
>> > overlong name (producing an unterminated field that the syscall rejec=
ts),
>> > but this wasn't a reachable state=2E This replacement will instead al=
ways
>> > truncate to 15 bytes and keeps the NUL terminator, which should have =
no
>> > behavioral changes with the present code and avoids potential issues
>> > with future over-long string literals=2E
>>
>> Hm, I got a failure report, but it *seems* unrelated? But nothing else
>> fails that way recently, so I will try a v2 with the "unterminated at 1=
6
>> bytes" behavior restored and see if it passes=2E=2E=2E
>>
>> test_progs_no_alu32-x86_64-llvm-21:
>> https://github=2Ecom/kernel-patches/bpf/actions/runs/23472955268/job/68=
300440546
>
>Don't fix what is not broken=2E

strncpy is broken=2E ;) This is one of the 6 remaining uses of strncpy in =
the kernel=2E But it needs a v3=2E I'll add explicit rejection of over-long=
 strings and validate that the bpf test was a flake, as suggested in the ot=
her reply=2E

-Kees

--=20
Kees Cook
