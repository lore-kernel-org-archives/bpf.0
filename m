Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515936EAB2
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001162; cv=none; b=aA3pPKf4yLqrrjV17D7gzTsWLIAPnJq1nnejarSRHzzgsYwa9a5WuMVMqdotAYIPed2GScGLiyGAmorUj2x7FQNSKdhqzQ7il+ZjELN/OY75BZnq9mW/LR15yWhc5GMRYdIm6O/eNfCqIJQDqCfONQyc1Fp7OinCBssA3vWTyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001162; c=relaxed/simple;
	bh=n8coBd0qFk/5HD90gDT1b5U8fuLs0OdWFovNvhKc2qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0JOn5tyShj01pEl1aNSYLzS890bOnSmuPQ63FdmlOInT8mwNU5xcS0etTMjRHp9NfMuTbJkjbTZRU3VX4HHkB9urwhtrYHBStiFyRNGN5I+Z1/FRE0ouE5lvJf7unpoa2a+FWMpGUbi29AOmlLVK1PqDoFnm2JoBS0mKgkM5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLDP4Kn9; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLDP4Kn9"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0a921ee46so13623537b3.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792001160; x=1792605960; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R1wX49LH9/OPwz/Ck51/J48YxCF6spEHSaUgKmwKcp8=;
        b=pLDP4Kn9oUQTotEkfvKXe/RkoozjtkBOATQo+CF4EaoZnGdyvS9b/6KcemlzpjjsxF
         FrO46XTCEB66bmQNig3M8bS/qyEaDtZb1SKVLifA2ySHWJYNUbwHvw3TO74qtJd+ARV4
         YW4QYOG+LVBnHsWRHEOYnZAUKvw4jto1tbYs6Pz6k5yh64yMp+gdmejATpstLFYVqGks
         b4d4u+oNKX97n3E90sy4dBGFRJOmP8CxTNFAIMA1j+BHZ9egVdax9vw+arhis+jpZYxj
         e3cEXW74daRDr4Osz1qJaooKWJwdPrMxcEeWxJg9B0z1zGci30jDHGYJPp3kbWHkQOyT
         qwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001160; x=1792605960;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R1wX49LH9/OPwz/Ck51/J48YxCF6spEHSaUgKmwKcp8=;
        b=1YfNHasWVUJtb1SQ6L9GRG9/xP4NYwKMJC7sxOdZF3uptYgJakeBWLOAOCZU6fQt1U
         +kZXNkYOYrgJbIXWgxKrdcms7OAKdmAxQMHh7pcn5fbGZjAB97FfaQKpEiTHueUBqNVp
         ZeU6mDUAevJOLCJlGKhl/Mg5a8daBWRIsPnK1uUYdjqo9gY87PUYkiYxT9kO1RJh/kUz
         AblYHtwWwqxEAtKBdHFrFTl5EM6OQy1iwO9Iq8Rs9RTQls4VaTPmULx8YpfoRDYUZDe0
         qZFJPL1AmGyx36B7NeKHpuAyxqTN6oTV2pckumsgqRKjaoTmttA63bUiSM/+HIyHeoCK
         CDLQ==
X-Gm-Message-State: AFq9FYI1NDSlWWzEJtNwTUXvPjr46KqVEqAnwKdmR8+NqZugIy1IYpK4
	Gq0OCtyVzJ838Xj7vt/FUTQC47pvLW9LD9fHy1SKWYGvye4916rZvThUPrqHCg==
X-Gm-Gg: AYBFou18lIFjdwiiSCGBapLzOK3jdepDIhX/7NhbbH5ytM4kxKGDTjNYPz933mY6uac
	XXYJ+MB87x6X8nPUBqi+bxEjmRY5dXyTnsnWvwNF/1D06es7Zn1l+yNKeUNbNnG2k8M6520XqHg
	eDcavtO2eDG+cJLzWkI6Hbuoy45jy/BkFzEROsl2IttZ4wy/3IKDTPxHUtCvxVinaMPQ+nS+yt9
	N1iElT9jvlMIW88HxvM7IpAAc9saN8qSsowL5TRqJ74Zc8dNPVE/Y0QFJJe211ii2TXeEx7Rrzy
	bNmH+deJV78B4g1INh3tDay/VZmquRKyZcaiMDpUtH5QrA8HOPjbQehaDnWJXO4UQRIm0TpO5dI
	fYiaKkjmryUj++ttYch5mjWf3uPh+f9KZqUFuCFIUMoflq01g0EK4OANmgzz4ROoCrMErxiPDjO
	QcFO2f6dPDbXiLyWskppZOHslsFelwv4e92pcyQs5ZmdrTPRgoqaV4J+AlR8pHaeTgqbbAyHIer
	1rsMUhzlC8=
X-Received: by 2002:a05:690c:6e83:b0:8b0:76e5:ed0c with SMTP id 00721157ae682-8b07ed3e710mr53824157b3.39.1792001159604;
        Wed, 14 Oct 2026 11:05:59 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8784:7d62:1705:ef5f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1eadf2sm59335347b3.21.2026.10.14.11.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:05:59 -0700 (PDT)
Date: Wed, 14 Oct 2026 14:05:58 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 2/4] selftests/bpf: Test MEM_RCU carry-over
 for trusted fields
Message-ID: <as_C5zWq0rdltW8C@zenbox>
References: <20261014173039.3666415-1-utilityemal77@gmail.com>
 <20261014173039.3666415-3-utilityemal77@gmail.com>
 <sashiko-outbox-171590@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-171590@kernel.org>

On Wed, Oct 14, 2026 at 05:43:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: unhandled NULL deref of f_inode due to SLAB_TYPESAFE_BY_RCU
> --
> 
> commit 3b6fbe50569bfdf0fb6b88ab1c38f2e6056c0f68
> Author: Justin Suess <utilityemal77@gmail.com>
> 
> selftests/bpf: Test MEM_RCU carry-over for trusted fields
> 
> This commit adds selftests to verify the behavior of the BPF verifier when
> accessing fields from RCU-protected pointers. It includes an accept test
> for dereferencing an inode within an RCU critical section, and a reject test
> for using it after the critical section ends.
> 
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
> > index 55398c04290a8..f519ba5f4ea20 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
> [ ... ]
> > +SEC("lsm.s/bprm_committed_creds")
> > +__success
> > +int BPF_PROG(trusted_field_used_in_rcu_cs, struct linux_binprm *bprm)
> > +{
> > +	struct mm_struct *mm = bprm->mm;
> > +	struct inode *inode;
> > +	struct file *file;
> > +	ino_t ino = 0;
> > +
> > +	if (!mm)
> > +		return 0;
> > +
> > +	bpf_rcu_read_lock();
> > +	file = mm->exe_file;
> > +	if (file) {
> > +		inode = file->f_inode;
> > +		ino = inode->i_ino;
> 
> [Severity: High]
> Can this result in an unhandled NULL pointer dereference leading to a
> kernel Oops?
>
No because this test never executes. It's a verifier load selftest.

Justin
> Because struct file is allocated with SLAB_TYPESAFE_BY_RCU in files_init() 
> in fs/file_table.c, the file object can be concurrently freed and reallocated
> while an RCU reader holds a pointer to it. During this reallocation process,
> alloc_empty_file() calls init_file(), which zeroes out f_inode.
> 
> In check_ptr_to_btf_access() in the verifier, the PTR_MAYBE_NULL flag is omitted
> for trusted fields read from MEM_RCU pointers. This prevents the verifier from
> enforcing a NULL check on the resulting inode pointer. Additionally, the
> dereference bypasses the exception table rewrite that would normally handle
> memory faults for untrusted pointers.
> 
> If a file is closed and reallocated concurrently while the BPF program runs,
> could inode be NULL when inode->i_ino is accessed? Is it safe to codify this
> pattern as an accept test without requiring a NULL check for f_inode?
>
> > +	}
> > +	bpf_rcu_read_unlock();
> > +	__sink(ino);
> > +	return 0;
> > +}
> > +
> >  char _license[] SEC("license") = "GPL";
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261014173039.3666415-1-utilityemal77@gmail.com?part=2
