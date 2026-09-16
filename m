Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E97346E58
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584409; cv=none; b=Bk0/cNySsUM4eV3ij4wbFCnuWhUc/flfslLqjE6rdrOxe0zlvjs54H2GklvEwaNBdi4KYHEF4aOFyZpEzp/K3QPWSho/7ThT/DsQFjvOCfwVEbFdSIcxsu1nM6dGG2XsJJIjJ2ANsGhTC7hKcwX5PA2IkGAaXMHfETVs8mMs0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584409; c=relaxed/simple;
	bh=9iI3yVCFfcrwEijmOypFnIfWBPd8LDSEXZaoZtjzES8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=INmkz2sdkFWCRLtza7ik8LjaGcyv7+QGa+G7n4+fikOi/F1DRQQ1KB2ZB0rxzg65k9EaF7v9r4THzTfHi8Xd1cWSrKt3kYKf7bA2U8u+3bYGU18VoPatG6dOU/Q5iAP5iDLZoEmmDXbLUsZ8BFrBoIwFmN7K0NRRbxMhzIY6hHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWhXb88+; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWhXb88+"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-486e3f86ef3so5454f8f.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789584391; x=1790189191; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QKsrECZCRP0zsQx7BfIGORKRpol9KPETYQHtfspd0p8=;
        b=FWhXb88+IL/ttNqnY7Xt/8NoApId9j27pspRm1asa7BkUHYNUMXvwuzK5h842OuS2P
         7XmE8RdaOmX7IDS2PlJ01LGjgHu4KyNh9ESQR8nIhTz4vrrC+9m+Kye/NihWPwaFTlK5
         UlC+B5BzYD7EfLnTINCNZ9ob/lxMMH5gr+DlPJBEtLvr9/2DJ3rYSGtTpQURVjWYi6m9
         dO8xebAXkd7tFbestXa3DLKd/y2BfFVt0rzEmQbL69tDdwCQtIyaZZLkx+qDj0ltehRC
         q8wJVbEmBA6gX23lKGXxphexA6jIXu1OAZrYFDl9E1SLeY2ekPthHT/U8sC4ay0N7ssP
         P23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789584391; x=1790189191;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKsrECZCRP0zsQx7BfIGORKRpol9KPETYQHtfspd0p8=;
        b=I5INkwELTOJ2v/SIoB6Vpkj9t/nE9XvT/QzPY+qsdFT5Pr9vhpKiOa4u6GgYNPvp2e
         6QuTQbUWtKdwHlXZVjbLwakdbZyiGGYNzvBx4dCWFjhzLiODq3IBOabMboH6LoU/iScN
         Ci2qXvrvxPvENGRD/avTke+akIrm0TWhKRULPHEnvkQYuku0e9H/vSiSLjg4lbl/FIOX
         jiuVnN+oY/+WkyFf+7YgDNXGotsvFby3W6JUQdVC/5k5WdPdFHcrqQOMvmnzLQfGRVdy
         RDLxzOsWqptJEBtuJ4oBvMw897ujRs9/AAAGSRO84uH/UJK45aw12kHYqux07Ilq04gM
         X4nA==
X-Forwarded-Encrypted: i=1; AKwUvBy5Y9vJlSRa5OAxQAMr+X8ganKMPClN9eK8XWunPlHaoFJIY+jeRwRVTFpCohtfh/Uh6Js=@vger.kernel.org
X-Gm-Message-State: AFuF++n+8qOH5n6bk4kAMRuJZi1tE6CdGUBaEHeCIAat9VVYxJNPWU3x
	4ifRskkthLIEFDZr2R7+cFAdUdukhOm0uQw7jDPknjLi2fVWJgRufugb
X-Gm-Gg: AYBFou00PJiDD9B7cmQb5IPAudV/FI5PIHBSl44EwXAajuh8TtaYPzgZ7gsBgCNeknQ
	eDDRwQHDsnrxZvGBebiAUBFwEaJfjZFFgQH0Tqm2f9JhZIq+HtHwvaaUzsBHoGCROmdd0ohlVRg
	FuWvRP5OnLdQvXQ1kqJrQkzUMO/kJcSiWWL758cy7g0FoAUoFLGqNiTm5dmeLrXPRXDq3a204PE
	YHWjLCxryFA9gS8YUun82sqV0uswNjUXcy7zNRhAB4YDQgz2m0LDIoohJ5x5IvaCF0TYsIoa14L
	TAIHkWpHE6a5tVspeMaBpz+ueAGVRF/ieI+6o8Vz4Azz4cPc8mNJDn6vEDBDYYP6jzSDSkx1XfO
	DoKVyX7QwhuOlmujzT2WjohZ9Zb2ilKlHAJlwGxX3wZqcUKOep62gmm4TkmLZHgHOckuJ43Yw4d
	ISktmphEplh9p0S0nL2nFli4cYP0NS2kudU0eVoPi0dsmUGotoUY72/i7dqWiCvHN6FYLdbccBy
	IA4iEDr50PKCmJRbkr9vfwHSvNJ09QK9IUyuuDm1oA0iI4Hw/Ztb4bROjRBaQriWr5Pyp+CAkLY
	aYqBKXHNiFqFx05b5+aDTJspyynuGFQ3EbPThg==
X-Received: by 2002:a05:600c:b99:b0:49d:2936:8ad1 with SMTP id 5b1f17b1804b1-49fbd1af400mr9345045e9.1.1789584391244;
        Wed, 16 Sep 2026 11:46:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd262912sm10560255e9.15.2026.09.16.11.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 11:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 20:46:30 +0200
Message-Id: <DLGYPZAL708V.3GFLANAPH2L8O@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Chris Mason" <mason@kernel.org>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <brauner@kernel.org>
Subject: Re: [PATCH RFC 1/2] bpf: fix UAF via trusted BTF walk after release
X-Mailer: aerc 0.21.0
References: <20260916183303.3504885-1-mason@kernel.org>
 <20260916183303.3504885-2-mason@kernel.org>
In-Reply-To: <20260916183303.3504885-2-mason@kernel.org>

On Wed Sep 16, 2026 at 8:33 PM CEST, Chris Mason wrote:
> A BPF program can keep dereferencing a trusted pointer that it loaded
> from a referenced object after it has released that reference. With a
> file from bpf_get_task_exe_file(), f->f_inode stays usable after
> bpf_put_file(), and loads through it read freed or reused inode memory.
>
> A pointer derived from a referenced object is only valid while the
> reference is held. release_reference() enforces that by invalidating
> every register whose id or parent_id matches the released id. However,
> check_ptr_to_btf_access() builds the loaded register with
> mark_btf_ld_reg(), which is not given the source register and zeroes
> both fields. The verifier state for the f_inode case:
>
>     file =3D bpf_get_task_exe_file(task)   file:  id=3DN, referenced
>     inode =3D file->f_inode                inode: trusted, id=3D0,
>                                                 parent_id=3D0
>     bpf_put_file(file)                   release_reference(N)
>                                            skips inode
>     inode->i_ino                         accepted, unprobed load
>
> Reproduced by reading inode->i_ino after bpf_put_file() once the task
> owning the file had exited and new fds were created.
>
> Fix this by recording the source's reference id in the parent_id of a
> trusted PTR_TO_BTF_ID load. A program that dereferences such a pointer
> after the release is now rejected with "invalid mem access 'scalar'".
>
> Assisted-by: kres
> Fixes: 57539b1c0ac2 ("bpf: Enable annotating trusted nested pointers")
> Signed-off-by: Chris Mason <mason@kernel.org>
> ---

Thanks for the report. I have a fix for this locally in the queue. The diag=
nosis
is correct, but there are more places that would require changes. For insta=
nce,
bpf_real_data_inode() should, but does not, propagate the lifetime of the i=
nput
argument to the returned inode. That would require some sort of annotation =
so
that we are aware of the lifetime relationship between the input and the
returned pointer.

I will send it out and will handle this case as well.
