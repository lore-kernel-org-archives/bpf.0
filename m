Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365702;
	b=G1rFTJ3Got4NJkp8fMOZad3WqscVFXkrp/vMIue7/X931vG7WT3cywYkNwrG405zlAO7
	 zb98eHx6FGP5fIS6v4EIY2edlX9tghsatHmsJklTV8seFVrRo1gaRDf2mS+5YfRyLDyWN
	 LNfNbeGa5SbwmEy5tkzjOwiU+8FhJtrxxp0LjOYhKHAoSMZv+kbogok0OpYnFovRypN3H
	 5J+NTL0JW0nv3lGwq9/cbjqKgOXIGSDrKNMkpYMAjTiyFYDxJKC8zmAc6DWzjcXzKGYb9
	 LTCydn070trGAmvoGcDypDtuYGrpAj+6UNNtOiWkWpjvag7xTRlEq93uuiAYxC4p1Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e5G7E6riYr6Xp10O1BH1B3f0Y79ijgGFd9hQYIn0tKA=;
	b=Bm56mMNY9WBIcUdooXOQynj17BAoE1XgDyMttfW1iGISK059DSBxuGM5UIj8AU7PSsVR
	 Wvyv7GR2mChxe9r4aF8KzeKJ/h9pssHJQ1Qe2UfO824tvj4fBuMcN65MwJmlIXf0O+kX0
	 LiFxOHUu4a1gcZXJeEEtw/xRMsv2Hv4q6SNk2jSjHPoznbhAOchORbJZ7/59A1GQPf3Gr
	 WYAC57WI0EmfbMBkF/3PQ956sFvfB+zpU8CbCUprsAbE+culfASGTdwr+Un0Y8dNH/N2F
	 ERT053iVWzq/5tEuWd0G/3ezSn1FX508nQPAhLLt3Fx854+NhiLrGcMkcoVSAi7WqxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D0Evakyj;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2687606A325
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 13:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2687606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D0Evakyj
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso4498365e9.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793365700; x=1793970500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5G7E6riYr6Xp10O1BH1B3f0Y79ijgGFd9hQYIn0tKA=;
        b=D0EvakyjYxZJy7DnSrfTXKClrpR61g+XXqKTOVauoXc2o2tn8FBacQp5vK2T2wWq6+
         eZfHoz/AOOuVZjGlATG35xRWk4pWcvdlnq9pKCJvvfp4VVqHpUQ/4lK90oEcphGAb5p3
         wMMT1gm9Fi0vLu0RRrRT08HUQxifehXP2wyMMAoqx52KGWUWoFFjsw3ngQGKQZ8flEGC
         dDlOAAYsL7xttcov3qdEe6111W9HBkEHOVl3ejXBxmHthFl9Ytzyhhon4wGEEQBszQ4B
         7hIy6dNYM4axAktCRfs1bfSauiOOstMqu7xy0dZrUSg7SBEl2f9t2BtpkZuQihzr0Tgr
         wwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365700; x=1793970500;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5G7E6riYr6Xp10O1BH1B3f0Y79ijgGFd9hQYIn0tKA=;
        b=h2p0i5KFIgfPuK4F4qGa16ZdJNnF9YQUsCBVzhYNGNtEeMbKA+Z3sR3ed3QRcMW4NH
         dHVrRXK0DXyslUMik8LZ0/6Evvfi0/slDLKVlVrYA2Zs6mAC3925V1VpN4URIemJYciX
         3MvAAcX1PycoEfcGuwadnO2n5RfR2+HvGT6xpdQpmO6U3mbIqs4vAjX9obCYXhp5Zxqd
         b2ePjuDC7gHRfvelVnVHSm0dKNri+FAq+o3lcJew2PoR9gErUJVOcN+Vcwg8L0KBHVS2
         tKixUNmg7jzxF9sg2OOhOty7iQk5SvvPsKiFhVJHXRENRStsfbhPkB9zTHfFxkpmKYRW
         52Xg==
X-Forwarded-Encrypted: i=1; AKwUvBz9lpoYefCnBSLQmtdIkw7kDJsuDO8Uc8rMgub2vG29qsihr5maAcXFXBX/45RBpmT11xE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3UxNkioXfgP9kQgSs0Ua8VA8Z2/Cgh498xx2cDhAKYqxfgnZ2
	JTmcBbRWMueWSvSCHsVZQAV8xe7PImgNKzGEZqsci7MqYBPplhqZnRhPJtGWjA==
X-Gm-Gg: AYBFou3V4FKjOLNIhYZ8c/PUCMugQVCSyiq/FHqmdkgX+4uS0vu8197Q8sm2Qii58r1
	RImmWrRgTrhO5I0v8x5Thkia9lJMdB9G+y9FYnK3JwdAWYtucxn0Lm7YZgd6dQgF/ZJIiiggIXF
	/Ry3to+DTfRt+uD08ng9mKChfZZ4zqpes0WCZRqG+GUM3jpmXoPUifGR8iU/swiDv2w3jHD0TOY
	xkZVeT0FftSHCzSb5mrOiGVGzLSe2KwpXzkEO4iFOSf8DrKPnIcytmnPdV8ep4+IpGPmJXJ4jUT
	20GrPMq3nnwaa67IArGrEA726B22aLuH1asIzsYJSRwFLNf+obmbfvKASYRzj/QHFI0/CqUmxyy
	+Qgu85iTaGHC5PxkJ0gPPrtN1Y3ex8i9eANErO4pQwwbXWmx3c92LGf12x2n4rko+DB/hJ2ytT9
	tbqKnvCDGBoE/1ueJg40gvIG0ftrizbMqmIDVKkuLuXKAJ5D92cbT1dYYrJwyd10SBedn7EXHUX
	XttXS7YOjrDYoiTgnaY3IWROk6iSWalzEFwAnR8+UGFT91+o6Pek3MX7Kmbjxcs7ot94R95TyLW
	6w==
X-Received: by 2002:a05:600c:6215:b0:4aa:1527:659 with SMTP id 5b1f17b1804b1-4ac17a366c0mr47584675e9.17.1793365700051;
        Fri, 30 Oct 2026 06:08:20 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm155545595e9.5.2026.10.30.06.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:08:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Oct 2026 14:08:16 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-mm@kvack.org, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, ljs@kernel.org, john.fastabend@gmail.com,
	nierro92@gmail.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/8] bpf: Add user memory kfuncs
Message-ID: <auSWwHhZwhUbSVf1@krava>
References: <20261029212551.56964-3-jolsa@kernel.org>
 <571f32a410a85199bc9bcecfe07a9a9b6ef425b2052643e64031dd246c13691e@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571f32a410a85199bc9bcecfe07a9a9b6ef425b2052643e64031dd246c13691e@mail.kernel.org>

On Thu, Oct 29, 2026 at 10:12:12PM +0000, bot+bpf-ci@kernel.org wrote:

SNIP

> > +__bpf_kfunc unsigned long bpf_user_mmap(unsigned long len, unsigned long prot)
> > +{
> > +	if (!bpf_user_mm_ok())
> > +		return -EPERM;
> > +	return vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
> > +}
> 
> Can this vm_mmap() call fail for ia32 tasks, and for 64-bit tasks when
> CONFIG_X86_X32_ABI=y, because it is not made from a syscall?
> 
> On x86_64 the address picked by vm_mmap() depends on the bitness of the
> current syscall:
> 
> vm_mmap()
>   do_mmap()
>     __get_unmapped_area()
>       arch_get_unmapped_area_topdown()
>           info.high_limit = get_mmap_base(0);
> 
> arch/x86/mm/mmap.c:get_mmap_base() {
>     if (in_32bit_syscall()) {
>         return is_legacy ? mm->mmap_compat_legacy_base
>                          : mm->mmap_compat_base;
>     }
>     return is_legacy ? mm->mmap_legacy_base : mm->mmap_base;
> }
> 
> The sleepable kprobe programs that can call this kfunc run either from
> uprobe_notify_resume() -> handle_swbp() -> handler_chain() (or
> uprobe_prog_run()) on the int3 return-to-user path, or from bpf_task_work
> callbacks run by task_work_run().  TS_COMPAT is set only in
> syscall_32_enter() and is cleared on every return to user mode, so it is
> clear in all of these paths.
> 
> For an ia32 task (TIF_ADDR32) on a kernel without CONFIG_X86_X32_ABI, the
> top-down search therefore runs below the 64-bit mm->mmap_base.  Everything
> above 4GB is free in such a task, so the search returns an address above 4GB
> and __get_unmapped_area() rejects it:
> 
>     if (addr > TASK_SIZE - len)
>         return -ENOMEM;
> 
> The bottom-up legacy layout fails the same way, because find_start_end() also
> starts from get_mmap_base(1).  So the kfunc always returns -ENOMEM for ia32
> processes.
> 
> With CONFIG_X86_X32_ABI=y the result is the opposite.  Exception entry
> stores orig_ax = -1, so in_x32_syscall() is true in the uprobe handler and
> 64-bit processes get the compat (below 4GB) layout.  A large len then fails
> with -ENOMEM in the bottom-up fallback (end = task_size_32bit()) even though
> 64-bit address space is free.
> 
> The kernel documents this dependency in __set_personality_x32(): "The x86
> mmap() code relies on the syscall bitness so set x32 syscall bit right here
> to make in_32bit_syscall() work during exec()".  The uprobes XOL area avoids
> the problem by passing an explicit TASK_SIZE - PAGE_SIZE hint.
> 
> Neither the kernel-doc ("into the current process") nor the commit message
> mentions this limitation, and the selftests later in the series only exercise
> 64-bit binaries.  Should this limitation be handled or documented?

that might be a problem..  we could use similar workaround that's
used in arch_uprobe_get_xol_area and set TS_COMPAT before we call
vm_mmap and restore after (like below)

or we can always bail out for compat apps

jirka


---
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4ca2ac8d372d..c9dbd38ca125 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -32,6 +32,9 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/limits.h>
+#ifdef CONFIG_X86_64
+#include <asm/thread_info.h>
+#endif
 
 #include "../../lib/kstrtox.h"
 
@@ -3781,6 +3784,27 @@ static bool bpf_user_mm_ok(void)
 	return current->mm && !(current->flags & (PF_KTHREAD | PF_EXITING));
 }
 
+#ifdef CONFIG_X86_64
+static unsigned long bpf_user_vm_mmap(unsigned long len, unsigned long prot)
+{
+	struct thread_info *ti = current_thread_info();
+	bool compat = test_thread_flag(TIF_ADDR32);
+	unsigned long addr;
+
+	if (compat)
+		ti->status |= TS_COMPAT;
+	addr = vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
+	if (compat)
+		ti->status &= ~TS_COMPAT;
+	return addr;
+}
+#else
+static unsigned long bpf_user_vm_mmap(unsigned long len, unsigned long prot)
+{
+	return vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
+}
+#endif
+
 /**
  * bpf_user_mmap() - Map private anonymous memory into the current process
  * @len:  Length of the mapping
@@ -3797,7 +3821,7 @@ __bpf_kfunc unsigned long bpf_user_mmap(unsigned long len, unsigned long prot)
 {
 	if (!bpf_user_mm_ok())
 		return -EPERM;
-	return vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
+	return bpf_user_vm_mmap(len, prot);
 }
 
 /**
