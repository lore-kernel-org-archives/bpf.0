Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704B51D52A;
	Fri,  4 Sep 2026 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546406; cv=none; b=JEI8SB9a8s1IuTC+dL+K2EwTMXb4SpsG7R/Lg89OsTjx7x/0t9pX0LD2Z49egF+J10dBC0bsuJtYkf0/Nlji7lE50CeDw0IyCOv6MtyqGR7nwoDTmkU276EaunrZx2tD8nlpZqzRbHqdBieM2at8xhoOhC95VetX4OanROld5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546406; c=relaxed/simple;
	bh=nRE6Ys7w3tx3idiVPsjrnrwE5Wxn5kexkVqsnLu0E9A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uy+Rd8/EgQAuSF4hbwJRPlktHaZ8G0E9GOEPXqCdDvGvvwPBMuGftftO6h9mQyR8cY4bRfI/89equ7YIUjoZtIj36ymN8QnsST3QMlaQn1jsvHeqL849Q+AwOe7hhXcNo0tXfaCq7gFmZDOIsIrTITaqPKCGHY5QEYQpj5DiJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IzZk9N13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IzZk9N13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663401F00A3D;
	Fri,  4 Sep 2026 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788546405;
	bh=oOHPyrxGo1MSBUwKK8LJZJGpSrjxqZrlHYw4onj99co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IzZk9N130M1AYqZLUIcnt1+xtyT9UazgRQmgcW1dCFY+Oy4NX97N/6boMXxgOTa5L
	 ykHX+tXGl/E0wn4BBf2ilsyKB/i71c0yWNjFngGN6ydwhULI5bMtfkIpsl3TmZmlFF
	 UI6bM3EgRe6+R9abWKirKpVpFRsJLH7io482Y8TE=
Date: Fri, 4 Sep 2026 11:26:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 david@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, kpsingh@kernel.org,
 matt@bobrowski.net, song@kernel.org, utilityemal77@gmail.com,
 sun.jian.kdev@gmail.com
Subject: Re: [PATCH bpf-next v4 0/7] bpf: Add user memory access kfuncs for
 mm_struct
Message-Id: <20260904112643.73448e55f788fb1cdcdd12ef@linux-foundation.org>
In-Reply-To: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
References: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 17:53:33 +0300 Anastasios Papagiannis <tasos.papagiannnis@gmail.com> wrote:

> On MMU systems, during exec, argument and environment strings are copied
> into the new address space held by struct linux_binprm before that address
> space is installed on the task_struct. Existing BPF user memory helpers
> operate on the current address space or one associated with a task_struct.
> Because no task_struct refers to the new address space at this point,
> programs cannot access these strings from the bprm_check_security LSM
> hook.
> 
> This series adds two sleepable BPF kfuncs for copying bytes or
> NUL-terminated strings from a trusted struct mm_struct. It also marks
> linux_binprm->mm as trusted-or-null, allowing BPF LSM programs to pass it
> to the kfuncs after a NULL check and inspect exec arguments before
> allowing the exec to continue.

Why didn't I get the usual bpfbot review emails for this series?  Is
this a sign that all was clear?

> Changing bprm->mm to trusted-or-null would otherwise reject existing BPF
> programs that read through it without a NULL check. Preserve that behavior
> by allowing fault-protected reads through trusted-or-null BTF pointers.
> Pointer arithmetic, writes, atomic RMW operations, BPF_LOAD_ACQ accesses,
> and passing the pointer to a kfunc that requires a non-NULL trusted
> argument continue to require an explicit NULL check.
> 
> On NOMMU systems, exec argument and environment strings remain in
> bprm->page[] until they are transferred to the new process stack. They
> cannot be accessed through bprm->mm at the bprm_check_security hook.
> The new kfuncs remain available on NOMMU for address ranges represented
> by a supplied struct mm_struct.

I'm surprised that bpf even attempts to support NOMMU.  I expect the
user/tester population is zero.  Perhaps just disallow this, if it
saves any effort.


