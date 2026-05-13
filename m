Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907AF481AA3;
	Wed, 13 May 2026 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685219; cv=none; b=BDnQw0H1k5qUFIQLdekmfz02gmERp4N10lJWAQhR//7Kmw4WZ2EwBlqA1v3R0YcDmPh8m70zgVrPzbb2Wse0X+X/Fhwaytr/NzuGXCxIPFbymR5rcyc/MxepCqJ7FeOKwasWEHl3iW4cgIbf+YPboRfbCGs/mv7JDGoiIBL/YQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685219; c=relaxed/simple;
	bh=UndeeBAudNcgPiHmWG9NCNOwnjQQo6sIys/fSPjKAPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6Xty1h9zPve4i7WvgGP7xlkaB2oYNhSJcprmATcf2WmSj6w0/5Ii0UleQWQKaJcfMaeNqUD4Hksshiio+zlIwnjWO47jzRBtCOQ9M/Kdm41EmJ16QPIMzpNxaXzFXIshXsg/cZof5Zwn+bG9TwDKPdeK5qsW6vzgLrktxNTerE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E10DB1401C6;
	Wed, 13 May 2026 15:13:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 5BE272000E;
	Wed, 13 May 2026 15:13:28 +0000 (UTC)
Date: Wed, 13 May 2026 11:13:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski
 <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap
 <rdunlap@infradead.org>, neelx@suse.com, sean@ashe.io, chjohnst@gmail.com,
 steve@abita.co, mproche@gmail.com, nick.lange@gmail.com, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
Message-ID: <20260513111331.7bede512@gandalf.local.home>
In-Reply-To: <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
References: <20260503164700.548164-1-atomlin@atomlin.com>
	<CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 18geb9x55ru3chwt6uafjionag3oe1yt
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5BE272000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+7R7zxbXBV6rlQFQ0Ye5/tl281iYTF8WE=
X-HE-Tag: 1778685208-537794
X-HE-Meta: U2FsdGVkX1+x7ra4uXHhLxM0a25M9aCoPDW3ZqIlq9S7q9SyTpMscF+XaALiXSKTKjK1qSM1kG4P3XpZr8H4FvLc54S2rZuV7N1O6V0ZE0ZbNsHPIpDzkkRsm1nml/Kq1e+4eoF9XM7lAI4b/ftkikplSw/Wr18s5nUlvMA+GofiF/4Cb67OMC14P6ChPMM0ULN7I/YHU4w1ujDAv/TFSo3WdGlpF3BIz6USQ981Ff+FiT9Z/pNq1BONSXhstcCK72Q6TfXDqCuOaC/udV30tqSjEaBES4PnYCvud839jgU+Yig5WrieniekGkTWX9NmRneIS+uPG6xvy0iQo8NWWJL+Lr+PIXk0

On Sun, 3 May 2026 21:51:49 +0200
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Nack.
> 
> Please stop this spam.
> We're not doing it. These helpers have been around for a long time.
> There was no need to taint then. There is no need to taint now.

Hi Alexei,

I'm wondering if there's a way to see what modifications BPF programs are
doing to the kernel? I try to make it easy to see what modifications ftrace
has done (like the enabled_functions file), because I like to know how my
kernel is modified since boot up.

Thus, it would be nice to know if BPF is modifying anything in user space
or just what BPF programs are loaded.

Note, I'm agnostic to this change, it just brought up a previous concern of
mine when I read it.

Thanks,

-- Steve
