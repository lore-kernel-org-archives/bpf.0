Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73E3E51E4
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984673; cv=none; b=ILHyxH6yTBhqkd35asPE21ug7ZRZnpN36hm/t1aGY9gbZmNdMU2MEc4Rxspxc5GdNLrtdxJ/BHnn0qA0VIWPVSfs1V8GcY8IZccd2uVy5hB475FHGh9smg88SZ1hRWWWElB/hNsQY2j85m3VhqPJrxQ269aZGJXRQXGu1IOX4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984673; c=relaxed/simple;
	bh=vdCVltj0A3eVF+yChMwUN7F8jYlR7UHxsgQGWemLZA8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5RwY8ZkOljJnNmEWiaqOK1ilFct3+lB36PUqpwqQfE8begnzcbZtjYP7AAZ+g/VQSnlMffRD7G8Z3aINgZiAjiamhpip+pgKXJFRs+Shz0oL8z9NCgr6+qt8W9fDJrSfWuy00bWbU2VHLqUSU9PJdf51Fo7ZU7yrGl+2ud/D1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMND5InV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMND5InV"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so48415275ad.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788984667; x=1789589467; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/nqOuwsqgg0fRM3HpI/iUpxVRO339G5Gp0/QcOudjtY=;
        b=DMND5InVN3qowho55ONxe2kN3j+hRgF4I66yrrLyHsKfBOqSUG3fMbUyLZLi3qQoaV
         r3/WGLzOugaCzdJguI9TdEuLOD+sFButvyEeCaG8kpodj7fmiVj2De5i05yaK1/Hoba6
         e9FpI0AspZvmr/OK/E9xjIXHbvDVab/CnQeSag7+LAzZhRhl2RVVuIciHZk1BnYExMmU
         F5f2wU1lopr2mT/83zIzUMWrBue9fzL9u1UvljbKuMJyeCaMPRvkamZsfJvvEr9RhOi6
         yjR2FXoflP09RVj5bSxVMiSbDy15/EP+khTqWGaPlE04QJJPicxftL9nkGKmqYUvkHrH
         P6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788984667; x=1789589467;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/nqOuwsqgg0fRM3HpI/iUpxVRO339G5Gp0/QcOudjtY=;
        b=ZBQPeyN0qsFfYaWAjbxG32jzjVd+ZV3EmfIqSuVrD9o9n/qEsADERZFWIGYGyqZfjT
         rlzMqeCyMT33fkOknIifss+/dkPayXRrYo+JLl4bum98c0QBSnHg6p9gRNKNEELhT0Rx
         f85MVFL2SkNxQacD9zlCfqJf/+qRlHp9UosFNbPUPk7I+BqXm4np0R/dPCBTn8Vemvl/
         fioBUmPBdOPBSdkZQO1Eg66/LEOWfLK+7IH3j+xywDrm7p5LmHPkg2dPkQdwkhwWgpfa
         rNOTSIthhF5uoyaQ+7/IvzSfjWTpPInljqSGVR+FabTBB+0iBPJVplpSvpxpA1UcFNlf
         5mrg==
X-Forwarded-Encrypted: i=1; AKwUvByCLGwVHSQxnCryDE9QjOaBnevwPysal2tGpOFYUHaX/KxLJE2xQ2tuvF1DWCEgSHJdsv4=@vger.kernel.org
X-Gm-Message-State: AFuF++kRVbv15nHhQLof28rhmtHPryC9l775VeCLH1TKGwynHLyi82IG
	vcbMuQmBykv86Jg9vyr33i/goivkcmBxLmOvUIsIs1d3Tbn8lbXgFo5R
X-Gm-Gg: AYBFou3f/sZi7PxI2rAfQZEXfUXBm2h1LcC7XEd2DMgRcpk0YdtsazOTnSTKgpcIAvi
	R3EKEzuSWYX60eZjFWRiHkPrOQnfy91fyrEcc+hkzWTFYTcWp5Y36P9ZXDyQhFm6oGx8Sx4kzJ9
	IirXqk9VzA2hjHsquA1oX5bTfbJRmS+/YrDAAhyuf38HaPfkl+M7VQAoAGOA9ajWxkdjE7Nq5Nn
	a8WYBZ2Pm4LCgapRuP5rYhYMscqLd6nHM/52vyJVficbV0e3/Ob8wFqTwX9Dm4tnaP0OImJEq/2
	hfygOr79C/SRYmGk0stUCMlEHC33JNtu/YhYW3oM2vyUHWrEQBXiVQAVdrBnkWtFzKy8/z4TDVK
	rJNT01iUZAHu+OtYGNpR6uFtxTk/+LxG96wSfxOqu8OoIIalHhlReyMUPk1E6hLpFLdtvUIW8oh
	NIQnDi6N5wCccEKpkgQwc+tof93nwmFcPnyIBWcl9/jB1bQYYwMazKkGXYiqe0+6to7XFQ8vI7e
	ywvYN3Lom5RPLcyFOCBt4j0lyConlk6aH8RkAVkx5gZVT7hdOljxwmq
X-Received: by 2002:a17:902:ef44:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2db1259d1f8mr510415315ad.14.1788984667252;
        Wed, 09 Sep 2026 13:11:07 -0700 (PDT)
Received: from mars.local.gmail.com ([153.246.84.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db63c00837sm41962775ad.40.2026.09.09.13.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:11:06 -0700 (PDT)
Date: Thu, 10 Sep 2026 05:11:03 +0900
Message-ID: <m2cxum423s.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: akpm@linux-foundation.org
Cc: tasos.papagiannnis@gmail.com,
	linux-mm@kvack.org,
	liam@infradead.org,
	ljs@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/nommu: Reject wrapping ranges in access_remote_vm()
In-Reply-To: <20260909001341.6a7c3556259f7cf9a79c1da7@linux-foundation.org>
References: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>
	<20260909001341.6a7c3556259f7cf9a79c1da7@linux-foundation.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello,

On Wed, 09 Sep 2026 16:13:41 +0900,
Andrew Morton wrote:
> 
> On Wed,  9 Sep 2026 09:42:31 +0300 Anastasios Papagiannis <tasos.papagiannnis@gmail.com> wrote:
> 
> > The NOMMU implementation of access_process_vm() rejects address ranges
> > whose end wraps around, but access_remote_vm() bypasses this check even
> > though both functions delegate to __access_remote_vm().
> > 
> > Move the wraparound check into __access_remote_vm() so it applies to
> > both entry points.
> 
> lgtm, thanks.
> 
> > This is originally reported in [1].
> > 
> > [1] https://lore.kernel.org/bpf/4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org/
> 
> Ah, bpfbot scored one.
> 
> Sashiko might have found more issues in there:
> 	https://sashiko.dev/#/patchset/20260909064231.18693-1-tasos.papagiannnis@gmail.com
> 
> I'll optimistically cc Hajime Tazaki, who has been doing some NOMMU
> work recently.

I got a similar review (from Sashiko) that current use of
!vma->vm_file isn't appropriate and should use vma_set_anonymous().  IIUC
that case happens only (I may miss something) with /dev/zero (via
mmap_zero_prepare()).

I also had a patch but am currently waiting for Lorenzo's input for
his work on /dev/zero, which mentioned in his reply.

https://lore.kernel.org/linux-mm/an8BlTgk7sc5vFJ1@lucifer/

Thus 3 comments of Sashiko (all about vma->vm_file) can be addressed
in future, and are not needed an immediate fix.

I wish to ask this to Lorenzo too.

-- Hajime
