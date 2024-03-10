Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83B36AE7
	for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710108347; cv=none; b=N/V9BtCOke1HbWdbMwmjD7RRVfSW1PDyh8CO/85mEXDZ0CIiUYGpIiS4cp1UlBhTGcu+HJckhbgPRZUsouzyRGCOZnAATvXotMiRSCu/ShMGfAu2tDwIAqdwUv0wN7BM8KR17y7n+LYp2dh1k3xJ41Ih6Z3/ZYzatUGBGFXZ02c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710108347; c=relaxed/simple;
	bh=5S9PZOOk2il3/6M/A9UXAwRg89wDWJJLeRc5FRTxJ0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwExhIG+mSQsERlMadx/vDIfsAWLkbxQUxy97PVdf6Orb6YiUBxkES3+5xfB0vBAlb1yQvpqpr5dqPLYYNtLfqdnCJ3ON3t1GdRDTT9Rr5XveayVxCnMKz/v0gRsLYJdi2L8nRX4Oh0j7xhWtYJ9N6nCeZp/yZHJ3edhvsMlgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TULfextF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TULfextF"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512f892500cso2399609e87.3
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710108344; x=1710713144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aKGf+Y72PoKg2C/OND4nMHDn6ZUZpF7AdOgDfeZSLA=;
        b=TULfextFw1ocTgt1gp7xdz0pTcoxgfY72ax+vVazRS8l+qNa8oAYP1MMTziUUrmJYE
         gQBhUC7SoBQpbRMsbLDSkQwoY8kssQM2qsv4jsxC4UBeO0A31rx9LF/hYRZ++GAuE/jn
         BgYxxtD4s3aqkjZyKI1lbuDrN6hs4FFs/BWglQIAMwGpHL4Lx7xSKDEhxGF1/EFScGWV
         VZ9LVM0vkH4mCVmEZkGG0poug5Cu1Wiz8K90gW7v/QxZ+hQ7XphpKSyCxWKY8OV3aTaO
         7fuxffJs+eE+1Wyc+x38nY7+d2jId68u17CyjxYndGJe04pyZMzoVH7DO2Wee9rogtJC
         6mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710108344; x=1710713144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aKGf+Y72PoKg2C/OND4nMHDn6ZUZpF7AdOgDfeZSLA=;
        b=Fms65FABxZ4nvtrD2ndx2lbmEjf6CYmh4lfl95Gx71phnrrB6S7BnSgs8Jo0prTvCV
         Es0+3Yfi3MOHFxz43MFSMewZN773M6STXvuWSvDzE6bSPWFpSb3BEN7sH3B2f2gLNPnC
         u/m7ETbzkysXqI7PaFPOBddePO41GphLhDBw4rEq83FSpA6Gk66YrLaDMuKa9dY02kF9
         hObB/Qypw3KM0UEn2V/x7rAu5LIG8ZpR6yVCOWP4czT4+PX0Y/M/KdKxY/4XkEfvcTKV
         x+kO15UxXtF4UNsyjXv5XqhaH5jVvlfIUqZb0khZSr7CK3gwKoiFW/zqz3F3px5JTdBi
         QKOA==
X-Forwarded-Encrypted: i=1; AJvYcCVUYwdTPC4gOw+3FwK6ktDsGpZtlVFtLX4dTs1fn1xnnx+wKqZhxKIipGsVkhko3qX042PmZMz63/4egPXHDr9sR/FQ
X-Gm-Message-State: AOJu0YxPTSDlqwwestD9kBXwmLwohc6mEaS9lJrV4aVMzIqgDMjL/KBI
	v4q/HWna1J9mdEItsg88Pi4K9GeVzguQmLcJbflOGrMGLz0ru6R7E7rwwEqLg4My/KTIOMUL3G0
	woZVdivN4rrspmzva0nREqlfSrBM=
X-Google-Smtp-Source: AGHT+IEW7I4Pb2aAtwXlkZzTHs3JgkwFiUuKUg9Ay+ldRaCkiM6NS9dBvo22SveC5/sBNZtGGBKKCi4ggGs50AcCxMk=
X-Received: by 2002:a19:c509:0:b0:513:3d4b:af9b with SMTP id
 w9-20020a19c509000000b005133d4baf9bmr3210128lfe.30.1710108343533; Sun, 10 Mar
 2024 15:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403092219.dhgcuz2G-lkp@intel.com> <CAADnVQJ+6mFs56fu+KEvumQ5uqM-oLpYx0hGxLJfE9XUCtEWEA@mail.gmail.com>
In-Reply-To: <CAADnVQJ+6mFs56fu+KEvumQ5uqM-oLpYx0hGxLJfE9XUCtEWEA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Sun, 10 Mar 2024 23:05:32 +0100
Message-ID: <CANk7y0gT8bvKuhJvxG1yLTxdRycMKNEBtgEv_PsCA56Nv74cDg@mail.gmail.com>
Subject: Re: [bpf-next:master 5/7] kernel/bpf/core.c:900:5: warning:
 '__pte_index_size' is not defined, evaluates to 0
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>, Song Liu <song@kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, oe-kbuild-all@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Sat, Mar 9, 2024 at 5:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Puranjay,
>
> Looks like I have to drop this patch for now,
> since PMD_SIZE is not a constant on all archs
> that can be evaluated by a preprocessor.
>
> We need to find a different way.
>

How about we define it like:
-#define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
+/*
+ * PMD_SIZE is really big for some archs. It doesn't make sense to
+ * reserve too much memory in one allocation. Cap BPF_PROG_PACK_SIZE to
+ * 2MiB * num_possible_nodes().
+ */
+#define BPF_PROG_PACK_SIZE ((PMD_SIZE <=3D (1 << 21)) ? (PMD_SIZE *
num_possible_nodes())  \
+
                             : ((1 << 21) * num_possible_nodes()))

So, it will be computed at runtime. This adds more performance
overhead but this is called very infrequently
so shouldn't matter.

Or we can hardcode it as `2MB * num_possible_nodes()` because
PMD size in most architectures will be 2MB or larger but never smaller.

Thanks,
Puranjay
