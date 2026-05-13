Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280447DD52;
	Wed, 13 May 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685801; cv=none; b=dEL0BiFr1l3OmosmzYV3TLWoM3UeTbfM+3VflP8GBEQHY38mvZGRHERf5jPTfxVtEuiROM2OVMk70flwf9cEJMh7GVc3Z0GBBgRZbTX63FKwoF/i8tLN1t/dQ4QkekvUIjYviYBycmNffELjzS5c63S/bA4AJDgLxSZU6bn/WGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685801; c=relaxed/simple;
	bh=05aaMT3Hm3rwOElmTABJV7PesXTkVYUnQpk8I3sen8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPoFOZgB+xpBTO9SC3IRWHMs+ClC/BMA5MVUG6Ha6+NfLlT/KqXksst9pY81wPTrcTkM0KA/T9qX1mMdH67z+XyU0mWhEwMQ4tN7QvaUifdWG1Bhno6g18oCVMaQQaKQ9iL8Z7o97qD4Yt6MycwXYRDDBlCMs97p7qBOc6kUGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D1DCF40145;
	Wed, 13 May 2026 15:23:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 1BCEA19;
	Wed, 13 May 2026 15:23:04 +0000 (UTC)
Date: Wed, 13 May 2026 11:23:07 -0400
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
Message-ID: <20260513112307.53e77312@gandalf.local.home>
In-Reply-To: <CAADnVQL_sWznA+JJLdzP_ZdUgQeO7p-AGnOtx9=fXjH+PnRJBA@mail.gmail.com>
References: <20260503164700.548164-1-atomlin@atomlin.com>
	<CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
	<20260513111331.7bede512@gandalf.local.home>
	<CAADnVQL_sWznA+JJLdzP_ZdUgQeO7p-AGnOtx9=fXjH+PnRJBA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 1BCEA19
X-Stat-Signature: qh9mfh7tfrdadr95zx8z8ppi93zqh4pq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/XgzzJPlAPn2tZpqgBKx+sYc6uCfM5Gnk=
X-HE-Tag: 1778685784-470807
X-HE-Meta: U2FsdGVkX1+cVeI8L1AFbkk0j+qm1cFrKvzwOHyqrAOW/gBvQTeSSNYab9HZWi9uMqkqP5BzhCc9jS6FXjY6xVsPWH+L3XLxAzWvel80R4BmCbXLsGZptIxhK7LQKY+qnkCdxRXThrfCb6UU46W2Ca2jPoXKTYHS8vtKD5rV8z+OWKjHS5zTBSkQxMEkKXNAsu9b4csAVRGhZTO6bTl2DqEVB9J5UFct4irk3qy33HkpQ692T4920a3WRnL1HeKb0AoJ9oMue87fBRQZNiWjgqonasIacTFymOqjRfVQkmqaaIhyc3UwDmlL9ixgSFAIOYpA/cshihmtbNK6xclFqa7KwtKhzY+H

On Wed, 13 May 2026 08:16:07 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> It's impossible to track all modifications.
> See what sched-ext is doing.
> What does it modify? Everything.

What about just having a list of what BPF programs are loaded, what they
may be attached to, and what kfuncs they are calling?

-- Steve
