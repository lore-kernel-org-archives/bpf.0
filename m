Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AE362133;
	Sun,  8 Feb 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565030; cv=none; b=oG65sbBJx6mQk3Mws9R3RG7ySwfkCYgYgmF/0RrlKZHlfwel8P0osajAsfrj7KUjilF2h8Ud9YWazOiyM8UcCXqQP5ApRubWnf5hK8MtkfzxwzHSYStJwqNF7v+aydlQsms5HoKIOskeDIje5gX79wenbVnm5HQAjuksMScIk08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565030; c=relaxed/simple;
	bh=H6T+yw9nuHYFDfwVmih/IIEzXjIlorgEknR2HqStg00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRMFQ/Vg75MhsGV2hOlBnLf/oXTgFK2g+MdEI73UX4pBKTOPOAH/G7fBNmSmTOkJLyYBkUwivfTql8qBYxlyVyX6THF6FXsBFonxLKEv2d99J2ikOknXT4blrb2e8dNr7rH79F5eLqTJUnMo7NpMQZ1OMSZx1Sk6Zxh8ulNWz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 258421B2DDE;
	Sun,  8 Feb 2026 15:27:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id F3ABD20011;
	Sun,  8 Feb 2026 15:27:43 +0000 (UTC)
Date: Sun, 8 Feb 2026 10:27:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Donglin Peng <pengdonglin@xiaomi.com>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
Message-ID: <20260208102742.2169de7a@robin>
In-Reply-To: <CAErzpmsajhJ45TkPx_TPwAPwN1fxO0cNYFTKFgLaosiPMo9wew@mail.gmail.com>
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
	<20260202111548.3555306-3-dolinux.peng@gmail.com>
	<20260202111249.649ac338@gandalf.local.home>
	<CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
	<CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
	<20260203101707.52965eb0@gandalf.local.home>
	<CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
	<CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
	<20260205130459.0ff532f3@robin>
	<CAErzpmsajhJ45TkPx_TPwAPwN1fxO0cNYFTKFgLaosiPMo9wew@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1kcjutcino7bzjpja7argwi13nat4k9q
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: F3ABD20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+cdBoPKrEnF+nRmAWrTSt/pvKF3PQVI20=
X-HE-Tag: 1770564463-573014
X-HE-Meta: U2FsdGVkX18hqHilYyrKnUR9c5fZeU+TrALNDMOlqZRXa13UmFFSDjFEQmXXF6+WHHRXvAtbtZ7prnY19KUebk6ScEfV1PGJSWPjpyEz5woMFsGB2YzkO7ExlMyzWqx/sb+AIzakFd5MJI75AyOEz14GpfT2QQUoEgHmEkUtU7mtBdYgJd6Z+rv2ACOOhYy6XQtDnoVmg6QdAWz/cLA9fGYvW2AKx/Gp+VBXQG2fk0C7Li1fses/QCXfob2aEM8DgzwBvA8ijFd4etQMsofOdUSAn9QP/U7RjDCHRG5B4ttlFuktbxSoDl+TP2yfH+6y9P2LJR6yScXmp+xoiWLXkJJw5Yw4jR2pjfNWnhw4X8U+j7uAg502zMhu/Vh0yCRAOs0z2L5otAk=

On Sun, 8 Feb 2026 21:07:37 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:
> Hi Steve,
> 
> I noticed that trace-cmd 3.4 introduced a new feature:
> 
> - Add support for showing parent functions in function graph
> 
>   If the "funcgraph-retaddr" option is set during function graph tracing,
>   the parent functions will now be displayed:
> 
>   preempt_count_add(val=65536); /* <-irq_enter_rcu */ (ret=0x10001)
> 
> However, it currently only prints the caller's entry point. I suggest
> enhancing this to include the **offset within the caller** as well. This
> would allow tools like `faddr2line` to locate the exact call site accurately.

Yeah, it makes sense to always show the offset of where it was called.
We can add that for 3.4.1.

> 
> I implemented a tool named FuncGraph[1] to convert function_graph
> ftrace output into an interactive HTML file. It leverages fastfaddr2line
> to map return addresses (e.g., __sys_bpf+0x51/0x500) to their
> corresponding call sites, such as: __sys_bpfat kernel/bpf/syscall.c:6115.
> 
> What do you think?

Sounds cool. Is this the vibe coding thing you talked about on Linked-In?

-- Steve

> 
> Thanks,
> Donglin
> 
> [1] https://github.com/pengdonglin137/FuncGraph
> 
> >
> > -- Steve
> >
> >
> >
> > [1] https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tag/?h=trace-cmd-v3.4  

