Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A781A254E
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603819; cv=none; b=L6p1cbC6+eXQ2wviMbHtKH+BlMavTbgks6NNskTvdFY94VCr9adRAR00DEN78ZTjwWE+BfU4PDHA7K9If+T2CI09JXP31bgVPSYuA+sOszeZ6K8u1wdweMbgZO9sV/dPHe/GQMpjsVeiw8YbRcHkKK5vPustyT+hPjTKSV4dGlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603819; c=relaxed/simple;
	bh=pHV/JwzikKCTCfGbUjzTHahE5KarpQKI46IQVg5CKeY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=guF5EMGs5n7FSQB+TYzfHHZImqKxUO32Iv9v85kgGYsAAcUZTt4/83QXM2ejadQMKvwmfO8vDEcb0kadCT90PRnOsW+0I5/Pk7YtwmteqtYrkvvcKSVOq8HZYanZM2L1RA1bxUET8FNJyu3+mwLxhucN/Au/+JjBAP3fAUqY0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TfkkwhVM; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TfkkwhVM"
Message-ID: <de152bf4-a168-4017-98bc-d5f64b0a01e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771603815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XjvLQCQHLFHPLihQOzUSlp9JMtzmLhKPEyiGNZwv8uc=;
	b=TfkkwhVMnqFSmznYIUXJFatgNEGAk/Wj2bTs6+ijQ2mGwJmE6ShMeiA+EWV37uByIdLNtE
	TTWjU0Ljwx3iH6oev2GCq5Cz56eiYZfU4Ou7yIzDDdUzDSZQVtYwGT55mJPmP/rzyW+HTk
	qHOZzhcmSkiCmnP3Mn+NT00IDY56rCc=
Date: Fri, 20 Feb 2026 08:10:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>
Cc: Kernel Team <kernel-team@fb.com>, Alan Maguire <alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
Subject: [LSF/MM/BPF TOPIC] Recover true signatures in pahole
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

People often trace kernel functions in order to get some insight in kernel
from corresponding bpf progs. But if the kernel function signature
has changed due to compiler optimization, users may be confused about
why their prog won't work.

In LPC2025, Alan Maguire and myself presented some ideas about how to 
get true
signature from llvm and gcc perspective ([1]). From llvm side, llvm can get
functions true signatures and those updated functions will emit into dwarf
with a special format. Unfortunately, upstream llvm and dwarf community
does not like this format ([2]). So we decided to recover true signatures
in pahole through parsing dwarf locations.

Alan did some initial work from gcc side in pahole ([3]). In gcc,
func signature change will trigger func name change (e.g., from
<foo> to <foo>.constprop.<n>). Alan's work is able to identify
functions with dead arguments and these functions can be added to
vmlinux BTF if the feature is enabled.

I did some initial hacking. The case for functions with dead arguments
can be relatively easily handled in llvm side as well.

Currently, dwarf cannot know whether function return value
is changed or not. Dwarf 6 standard seems solving this problem ([4]).

There are more complicated cases beyond simple dead arguments.
For those cases, parsing dwarf location(s) is necessary. But dwarf location
is really for debugger, so sometimes those locations could be really
complicated. So we will try the following:
   - Analyze locations to recover true signatures.
   - In some cases, compiler may not generate dwarf locations if the
     argument transformation is too complicated. Or the location
     list is unnecessarily complex (gcc vs. clang). Such information
     can feed back to compiler folks and hopefully compiler can fix
     these issues.
   - There are some dwarf differences between clang and gcc which impacts
     implementation. We will elaborate more.
   - Need some mechanisms to relate the new argument with original argument
     so developers know what semantics changed for the argument.
     Maybe declaration tags?

Similar to recovering true signatures with location parsing, location
parsing is also needed for those inlined functions ([5]). Furthermore,
for llvm thinLTO mode, it is possible that inlined functions may have
changed signature as well ([1]), although the chance is very low.
For these inlined functions, we need a way to alert users about the
potential signature change.

References:
[1] https://lpc.events/event/19/contributions/2169/
[2] 
https://lists.dwarfstd.org/pipermail/dwarf-discuss/2026-January/thread.html
[3] 
https://lore.kernel.org/bpf/20260127172041.1558244-1-alan.maguire@oracle.com/
[4] https://dwarfstd.org/issues/221105.1.html
[5] 
https://lore.kernel.org/bpf/20251024073328.370457-1-alan.maguire@oracle.com/ 

