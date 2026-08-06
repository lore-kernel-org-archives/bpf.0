Received: from mail-24429.protonmail.ch (mail-24429.protonmail.ch [109.224.244.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B6346FB5
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990431; cv=none; b=IMz7vK52SnTw5ma1yspxYNW3atLf53pbxx3VeupJYV8Aj+bH65gOQmDhg6gRwskZ8imJKqiV8HZmleg+d6iUrfAm+5YniJDEgiX1vWN4VyYh0n53JuQ189P1rdMS1/QIZMz8htCYqwDvjU+7IAij+8bKAHU5R/MPilzYU7yzLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990431; c=relaxed/simple;
	bh=jFRvPBEEffqKE8w6gOIwRIA20uqFF3wOpNsGpGlAE4w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuHGm7GABfLhuSKrKWha+L9Ow0l5kD/G8Tzym7/DvkFjXYd40gUamcrKeCqbRRKiIbXLSTzybuUOijY9kkuttZ8SFiYu22rGtbH+gbcl/MTbDpWKwlkxdLRhtF1ucgzvBmFhNVbSG/hA10Qd3EH7IxQ6xAdHWOmBt0ksLihyFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YE5KLZT/; arc=none smtp.client-ip=109.224.244.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YE5KLZT/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1785990423; x=1786249623;
	bh=ohwSW8qsPRtbPjZwvKouZx5YOEapTwS/HTecdhR8dFE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YE5KLZT/Ujh/wCVs2578hyIePWtq1WhS2Y/TMfZUFkqSTLUzIuuIfl156XjGuPh8d
	 tAREIXs8ClwTEne/VAsFApveZVY2ITDh2LXIA4nHaln7Ho0wfINSV8QSFyJVV67vKy
	 ckV0cuiobt0Ew/x3frlpqh8roflB9jqIf8WHl9sILJKa/85KTm3DyDyU9+z7YnAIdh
	 8CA21h/J35fOcDwP21cWCL/dDPCNdz0C49CMrXcA8ifX1tLv2BztYrWIFXFUSKKQSO
	 kjvltzrMBS/xaz99EEKc92p7m1qsFn6Swl+q7ZW1Ub52caiEp7lxeoLytG8pblzJeh
	 fNslVFXTlBf5g==
Date: Thu, 06 Aug 2026 04:26:55 +0000
To: NeilBrown <neil@brown.name>
From: quanyeyang <quanyeyang@proton.me>
Cc: Quanye Yang <quanyemostima@gmail.com>, Justin Suess <utilityemal77@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
Subject: =?utf-8?Q?Re:_=E5=9B=9E=E5=A4=8D=EF=BC=9A_Re:_[PATCH]_bpf:_disable_lockdep_while_running_BPF_on_lock=5Frelease?=
Message-ID: <EIbqlFfOtIoQjwWMjF_wfOLoXINOeoNtFxL8C-kwq2ynyLK1gqMXt-4qEaZr2mcNIyK6xkxNJOyn0BXgmZvlNmd01Y-om7FfnP85flTwFBk=@proton.me>
In-Reply-To: <178596983056.3252194.16986843925963956795@noble.neil.brown.name>
References: <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com> <anEuaSqiCVsQ6I4P@zenbox> <178583246611.3252194.4318729338489544399@noble.neil.brown.name> <CABcBDJuznu=BgDhevsD6PybX8+6fcaO1xyTcuGuv8F_+MfeZoQ@mail.gmail.com> <178588373680.3252194.4414470901360919775@noble.neil.brown.name> <46Fu_iB0xOxZXb0l5G6pslLArj7TrP_AOICffhfZKoviSn7zVUVVVSMfWaVBYNqt9RiCWWHhSAvlMc3RaJvRFSnvbV2EcBz9VUBQzb2wSkw=@proton.me> <178592062568.3252194.6464683099845305898@noble.neil.brown.name> <178596983056.3252194.16986843925963956795@noble.neil.brown.name>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 8597740ae3517b5f6005a6544ef05cbdc5ada27b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, August 6th, 2026 at AM 6:44, NeilBrown <neilb@ownmail.net> wro=
te:

> So I thought about this some more and came up with this approach which
> might be a good compromise.  I builds but I haven't tested it.
> What do you thing?
>=20
> NeilBrown

Tested it now (PROVE_LOCKING + the syzbot reproducer at the Closes:
link). It fixes the false positive cleanly:

  before: "WARNING: possible recursive locking" on rhashtable_bucket,
          5 instances during the reproducer's run;
  after:  no warning; new lockdep complaints.

The subclass layout reads right, and rhashtable.c has the single
mutex_lock(&ht->mutex) (rht_deferred_worker, which you moved to
_nested(1)), so nothing else is left at the old subclass.

One nit: the new field line in your mail shows a stray leading "o"

  o      struct lock_class_key           *lockdep_key;

probably a paste artifact; the actual field is fine.

Thanks for working this through -- reusing the existing per-init-site
key with subclasses is much cleaner than my params suggestion.

quanyeyang

