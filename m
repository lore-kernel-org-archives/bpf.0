Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571F3EBF32;
	Sun,  8 Feb 2026 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770569282; cv=none; b=kNauJhpGMXtjhxBEspe2LhxZY/BIib43tKaniIBEl/g6dyS4F3zjjBE9FZGDVaiqQt2IaoGFprmJa3bPXF9r1kn3lwu2CepUxqDMhNSoVDleviAyN9JvtxYWCaSMylqX+AIUUyxnm36zMS84Kyc3YFzOvpfVvE8A3QU6nt17Dl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770569282; c=relaxed/simple;
	bh=5fZDnXAhqgFgLgOg1C+BfizqfIlxnPB1NyQPk1dsyEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W47apnXGzPHCK3HWngToAAG9j4yAw6u3YzJ+5plIZxcA/S78VUI4Rj/vQvavyf8BO2cqgaiHth9R68JEApH33qcBsR6KOg+d0D5flLeCatkQldqFexkyXMdQN+iM/JTvltRhGQ9mV4d2S7Ocllt6FybO6oh+SbynHQaihch+QGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 4B49FBA29D;
	Sun,  8 Feb 2026 16:48:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 0E84D20024;
	Sun,  8 Feb 2026 16:47:57 +0000 (UTC)
Date: Sun, 8 Feb 2026 11:47:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Donglin Peng <pengdonglin@xiaomi.com>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
Message-ID: <20260208114756.2122e3af@robin>
In-Reply-To: <CAErzpmu3XGE=LKQjGgb_538BV=hytkv4rsE_M2r6ADEkB_Ckkw@mail.gmail.com>
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
	<20260208102742.2169de7a@robin>
	<CAErzpmu3XGE=LKQjGgb_538BV=hytkv4rsE_M2r6ADEkB_Ckkw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6eomch8mqjtoes87jnb7qepha5wzw7tr
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 0E84D20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18fJ6YgntJgJCDG5U7fLIGYZR4FofZfJh8=
X-HE-Tag: 1770569277-685700
X-HE-Meta: U2FsdGVkX1+gUPgFUbFaotaMe/FRo8JSKEPYqrjUwzTCuA80bIBEHxg5nXdQCuDSivCdtCBm4VIcGhDIo2gwUeYOQg0fGNt6rOMPVsvqSLADc2gYCIBrzjFdxWSY1x8GCDwuZITMlJ9dcgdjWYmwC7Wzav1JxRKs29A2XFeCXeZd4yjSPsLArB1oZdfZaO7m5+HH3JPr/k4CxmuhjnWIMmsvw7hDhQKIFjZokazcP2yt0G7Za1kPWU9tuGQr0fHR67rrdFBt89kpWibFcGRbuiDpfcISNypSsSPxecsAg18OwnnBnSUX7inOModBSvNnpm8q7fcj+cBg02uI0757LkhmzWMH4djh

On Sun, 8 Feb 2026 23:42:50 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> I hope future versions of `trace-cmd` or `Kernelshark` could incorporate
> similar features to enhance trace analysis workflows.

Hey, they are both open source projects. Patches welcomed ;-)

Note, trace-cmd is mostly a side project for me. I mostly work on it in
my spare time (or in the plane while I travel). Which explains why it
doesn't get the loving it deserves.

KernelShark is now maintained by Yordan Karadzhov, which I believe he's
in the same predicament as I am. He too is open for patches.

-- Steve
