Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075E413D99
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604082; cv=none; b=uj1Q9m7DJ2XLKDu93f3HP5Fhv5mrHMFuoPp8CPHsIg9KQQnelQlD6oGY6PO0XAEAiT8zAG1xsrFV2LkP7l9faM+fg88zzaMvQNb3zF9vXrZrZNVjlXvJQlH++RFkkkfasTXaW7TSNhUYX7nUNwnqyO3ViuqRZJU6nLUue3/ogBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604082; c=relaxed/simple;
	bh=/bl9MwV74yHiZiDkzSFn014W8ikCntS6TGGQGI1p5Es=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzM6Oou4w1PE2IvihpWQiRoEu88s6OdQqV+/HJby4zyxEwpO/a0x7sPW84tqIxvFFSYm9isSpkm246eVQ4TWqykhrQMS/uaPw7KweM4PyXxofCbr6ynTs1mmKvYnHBmA3cCkMyr/7zCoo78xQ1AC/hquXYs0PaIZgKlREP+pido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+yJQvmU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+yJQvmU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so28152535e9.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 03:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781604080; x=1782208880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tDAanR4THSch7TdfZDJ6qVDxcTgxRPw562Ge1ODgHF0=;
        b=C+yJQvmU04AMnznu53twV60cpUjfL0/iTiO7XHnsl3cvk3PXiq4WeATAcrwe1C3nzd
         ouesZa6JdYCGSR/gd1FI4cvkPzyv6bd4lLKqFPzA7rFO3RZaCydro8UCImqrEforUNch
         ton3DsAo6Ri1uExnU0MTJ/H53YhqgXiwAQKFeE0QOy1sfkMfZUHtJbKyCMzpzYOZPJXW
         snwAWFXcylVPaE5UgolO0fLV3mi4+0Rso7kqR+jJ1M6Op62EXBlbDtijugYDQ918TCzw
         0oZ4Tn2xUsUSQyg9cljKWnsgerct1SVEQEWzFcIPx7dKwDgA/VpMvSgJ/qpdtx1TdR1X
         ewdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604080; x=1782208880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDAanR4THSch7TdfZDJ6qVDxcTgxRPw562Ge1ODgHF0=;
        b=EExmS1JaLpXExdre2sC2/3oLi1siDOcvu2SwfIRg3/UBtg5c1pKD4USYbMAbf943M7
         xD5WNf1BWjgkpgapfuremHijwQ3KfKk/Z7l7wOKpUeCTykxLW3/3r58vynX/8LBcJv9c
         yB7G8SQISfIxdjvlvoWUXLHzCvOnLMxEpglggcIlpLNQDPVRz3CfMFO3WGVaQmrym2aP
         6e5dNdkgL5exM88vhugDNAQ7iw8LCwL7TE8bwmxZlTTtyDDWZOZPivdVhtoouaSJrbiW
         2sH+7zQdzQLHCE9IztlM8QD4hBRvb0phivWiIyHRTpjI+KhJs7PAMejrfHWYJxb+xTlg
         e9mg==
X-Gm-Message-State: AOJu0YxCmLRrdDDHx/RiJimAa5AfU7a5sBWNmZTJchCEY3E4wmcz5Sc/
	w/mMiPR/b+JcPqDHvHaLHMKtQ2MT3gKiwLF4d/iiXqwdRuQJ5Pu8M9GX
X-Gm-Gg: Acq92OEFenVkkuLLkVfrIg39ZDmxEJzEIsgA7DV7R/yZU0xpSEow3RKJtDzVawVOqfm
	s6fKugh1MK5pqA6boo8XvcMJuGiGoGR6oB8IUIErvVsBXP9aFRM1uu11xdtQh2oKRvRDbX6YV1l
	B6c563IS2Sy5+ZVt4UxbGo/Ce7xARbTpqTYFqtbltGignr2TGRngSU9GhgN5WL/s2GEqaZ1+lhU
	z9VdlZRlJLLgh27z9XCaFrUo9TG6/Ru2oC1l0ZrXJ5ygX1pr8SD3Zi19cCn19ZuTpzHPD3u0Hf0
	sVD09DI3CQ2NEMa6ARIxjywhpbvJuG5+mCKhOBU3PRK8lgjdr7Zr8nbOc035lFMEhJh6VZBtz4P
	SuH3GWRI/uwguH4LdIlvVtRQElBuTaoxt14mWEgPvbZuBj2b8HWncuTxpDw6qrMjokadANW3rYc
	jZjswMAUUFCd3iyl0=
X-Received: by 2002:a7b:c017:0:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-49220093459mr142231565e9.15.1781604079435;
        Tue, 16 Jun 2026 03:01:19 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47ce3sm74505005e9.6.2026.06.16.03.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:01:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Jun 2026 12:01:17 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Add missing access_ok call to copy_user_syms
Message-ID: <ajEe7Zx8sLqaiPIR@krava>
References: <20260616083056.405652-1-jolsa@kernel.org>
 <20260616084204.01FD21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616084204.01FD21F000E9@smtp.kernel.org>

On Tue, Jun 16, 2026 at 08:42:03AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing `access_ok()` checks for user pointers `uoffsets`, `uref_ctr_offsets`, and `ucookies` before using `__get_user()` in `bpf_uprobe_multi_link_attach`.
> --

it's fixed in separate post in here:
  https://lore.kernel.org/bpf/20260611114230.950379-2-jolsa@kernel.org/

jirka

> 
> commit cd20e04dceb618df71198c96a9e801e033dcb0a0
> Author: Jiri Olsa <jolsa@kernel.org>
> bpf: Add missing access_ok call to copy_user_syms
> 
> The patch adds a missing access_ok() check for the user pointer array usyms
> in copy_user_syms() before accessing it via __get_user(). It also cleans
> up the error path by returning -ENOMEM directly upon memory allocation failure
> instead of using a goto.
> 
> Link: https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kernel.org/
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a02bd258677ee..c274109d020f3 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2331,9 +2331,12 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
> >  	int err = -ENOMEM;
> >  	unsigned int i;
> >  
> > +	if (!access_ok(usyms, cnt * sizeof(*usyms)))
> > +		return -EFAULT;
> > +
> >  	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
> >  	if (!syms)
> > -		goto error;
> > +		return -ENOMEM;
> >  
> >  	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
> >  	if (!buf)
> > @@ -2358,10 +2361,8 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
> >  	return 0;
> >  
> >  error:
> > -	if (err) {
> > -		kvfree(syms);
> > -		kvfree(buf);
> > -	}
> > +	kvfree(syms);
> > +	kvfree(buf);
> >  	return err;
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but while reviewing this patch I noticed a
> similar pattern in bpf_uprobe_multi_link_attach() within the same file.
> 
> kernel/trace/bpf_trace.c:bpf_uprobe_multi_link_attach() {
>     ...
> 	for (i = 0; i < cnt; i++) {
> 		if (__get_user(uprobes[i].offset, uoffsets + i)) {
> 			err = -EFAULT;
> 			goto error_free;
> 		}
> 		if (uprobes[i].offset < 0) {
> 			err = -EINVAL;
> 			goto error_free;
> 		}
> 		if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_offset, uref_ctr_offsets + i)) {
> 			err = -EFAULT;
> 			goto error_free;
> 		}
> 		if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
> 			err = -EFAULT;
> 			goto error_free;
> 		}
>     ...
> }
> 
> Are the user-provided array pointers uoffsets, uref_ctr_offsets, and ucookies
> missing overarching access_ok() validations before being accessed in this loop?
> 
> Since __get_user() explicitly bypasses the access_ok() validation performed by
> get_user(), reading these pointers without a prior check could potentially allow
> an attacker to pass arbitrary kernel memory addresses and trigger unauthorized
> reads or crashes.
> 
> Does this function need the same fix as copy_user_syms()?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260616083056.405652-1-jolsa@kernel.org?part=1
