Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93B306489;
	Thu,  5 Feb 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314705; cv=none; b=qb0VDLUI59lIUnHz+AwUfq+2V0nr6rqCJ+oAZuCsVTeEeNUtsGmmIUSKWd2+wuQhI81w53Y8R8D8PBw21fTjfd5mncprv9aedqnDHCtcdqZ6MJ+938fl9jhZ4XVxgIaklN9SNN9yIQbwUV7mjqWBm6I5+ecnU6FRsCWtUDvoa8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314705; c=relaxed/simple;
	bh=qnXcG8TyhXVkhV0B4MDVo0OOIOG+RAs69AOE8siF3u4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mx7Xi8JpaJ9TEcIHowkSPL4NOU3DrxxbuEAcM8k1K09eu2sKllhOe6fGHlBoxNsoc0NhApmQnM6tGErqFmJigFkLbj/nx3qqsbR+TvbZNtCKlopHjF2SobnqWqKQvVLu1tzc4lIZAU8Q+BkyhH6gzhqmPp7d/5h5eYHNDc9uK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 25D508C17D;
	Thu,  5 Feb 2026 18:05:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id CDF5520033;
	Thu,  5 Feb 2026 18:05:00 +0000 (UTC)
Date: Thu, 5 Feb 2026 13:04:59 -0500
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
Message-ID: <20260205130459.0ff532f3@robin>
In-Reply-To: <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
	<20260202111548.3555306-3-dolinux.peng@gmail.com>
	<20260202111249.649ac338@gandalf.local.home>
	<CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
	<CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
	<20260203101707.52965eb0@gandalf.local.home>
	<CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
	<CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zjddx89rc1eyukuzz9d6uqsb1ekcmdgk
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CDF5520033
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX183W0R0rrhW3VpPbWKCoDKiif7gZxi29O4=
X-HE-Tag: 1770314700-352729
X-HE-Meta: U2FsdGVkX1/jUOdmqt5tBDITXjI2gF7AxRQr2LbTqTVpqe0SisXIMe0T/FJxY8GW+uYgM0jiBhXCFyqON+XnrV5bmr9Haw3WU2y1gYEcXhK+o9VURS8JwdabW7pRVW0o/zRsF37ZB25jW9ZeyZB5uZC0JumUWxKi1BdzFZ3WbJt1VhCXPhym1NV3KmErBsI3oF/2e5ou1J71JqmDskBVm6LEiFtPktsyQ92/S5gE4vDedUxKLxNTb0t8abZAgltbng22pcxp4i9h+HkWX9mZplwRcXX/ApX6ZobUesOK3478QhJ1KRjt8ZCQdSMt49VnDDQl9DdyKE0Mhk6lnFrbHCvHxHVhEwMnai7jwAv2nnTlfE/mU6XaxA==

On Wed, 4 Feb 2026 22:52:11 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> > > I have trace-cmd reading BTF now (just haven't officially released it) and
> > > doing an extract and reading the trace.dat file is much faster than reading
> > > the trace file with arguments. I'll need to implement the enum logic too in
> > > libtraceevent.  
> >
> > If you mean to do pretty printing of the trace in user space then +1 from me.
> >
> > I don't like sorting enums either in resolve_btfid, pahole or kernel.
> > Sorted BTF by name was ok, since it doesn't change original semantics.
> > While sorting enums by value gets us to the grey zone where
> > the sequence of enum names in vmlinux.h becomes different than in dwarf.  
> 
> Thanks, I agreed.

BTW, I just officially released trace-cmd v3.4 (where you can see whats
new in that release here[1]).

The biggest change is that it saves the BTF file in the trace.dat file
and parses it on the report (it requires libtraceevent v1.9):

 ~# trace-cmd record -p function_graph -O funcgraph-args -g do_sys_openat2
 [..]
 ~# trace-cmd report
       trace-cmd-50935 [002] ...1.  3490.518138: funcgraph_entry:                   |  do_sys_openat2(dfd=4294967196, filename=0x557bb9e3ee10, how=0xffff88815220fea8) {
       trace-cmd-50935 [002] ...1.  3490.518141: funcgraph_entry:                   |    getname_flags(filename=0x557bb9e3ee10, flags=0) {
       trace-cmd-50935 [002] ...1.  3490.518142: funcgraph_entry:                   |      getname_flags.part.0(filename=0x557bb9e3ee10, flags=0) {
       trace-cmd-50935 [002] ...1.  3490.518143: funcgraph_entry:                   |        kmem_cache_alloc_noprof(s=0xffff888106c7e000, gfpflags=0xcc0) {
       trace-cmd-50935 [002] ...1.  3490.518145: funcgraph_entry:                   |          stack_trace_save(store=0xffff88815220fac8, size=0x40, skipnr=0x0) {
       trace-cmd-50935 [002] ...1.  3490.518147: funcgraph_entry:                   |            arch_stack_walk(consume_entry=0xffffffff94d9dfe0, cookie=0xffff88815220fa58, task=0xffff88812d4c3580, regs=0x0) {
       trace-cmd-50935 [002] ...1.  3490.518148: funcgraph_entry:                   |              __unwind_start(state=0xffff88815220f988, task=0xffff88812d4c3580, regs=0x0, first_frame=0xffff88815220fa28) {
       trace-cmd-50935 [002] ...1.  3490.518149: funcgraph_entry:        1.518 us   |                get_stack_info(stack=0xffff88815220f938, task=0xffff88812d4c3580, info=0xffff88815220f988, visit_mask=0xffff88815220f9a8); (ret=0x0)
       trace-cmd-50935 [002] ...1.  3490.518152: funcgraph_entry:                   |                unwind_next_frame(state=0xffff88815220f988) {
       trace-cmd-50935 [002] ...1.  3490.518153: funcgraph_entry:        0.951 us   |                  __rcu_read_lock(); (ret=0xffff88812d4c3580)

-- Steve



[1] https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tag/?h=trace-cmd-v3.4
