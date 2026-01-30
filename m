Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98130C34E
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803906; cv=pass; b=SsLvGV2KKGJf5jcpsexsjdRYnBidXW9AHZOsN4eUSW5NDYLh/IaF1/ZqSikqOcJ9VxCh2Ys9OAHrxfk1Sc9kCv71stUO9vmKHqTAMWukNiDnYBj4ujmatP+fui7sHGjMtxroIAAp0RPGhEBGLSh1mnUrRI9Dtx1D0h5Ka6h1nnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803906; c=relaxed/simple;
	bh=rQg2XAmvCjv6Pxt+pWb6hjO1zF2ufQcWZb17Q9FMzPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaRwt4Y1tx0JoFLxTjKqnq3HkskCk4HhlZhEdrhxDQ9iOtXcTd5vN2IUvRd+RgtY9HruRkY8FsemY7B/O+F8+nSRwVMc38ru5iVIF9Jaqsml7dqVLqhuqgG8Auw07JcK21Q+rMI3rZfjgl4+fkJ3JN1aS8tWHAn0/YPIQxJJor0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyE31yWN; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyE31yWN"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c47ee987401so1055976a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 12:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769803904; cv=none;
        d=google.com; s=arc-20240605;
        b=M0jmYjd59C3BJAMvKFvxo6Is8n0MxHwGIDFAcVcOwp3j01PzNWKvH+3GfOh3Tp1c6b
         F0gZcEOkwjgSOjDD91ODG6g9q5AmH2h9Tp8HHqsGVMfYKFxxlU0eubgIT4IwqsTBkvZV
         Cef9dMyWVC87tbnevzM1jM5RWWxJuA02ZNpuMyun5b+SPtdJmbbO9H8F/JE90iqJhvRc
         3FKgTV033WOT+yqDi/phEePpjtayuZYlXdaD0rYGsx/nMD/PyYs6pGtHGbeMrWGKTEW3
         TnlxIp4ZK6LL/KzajVE4vilbT1uOR4+jVikHDNpO3VGxJz8lELZ1nPaTHqQulxrmcCSM
         DaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KqTERH/+2h6DWpnL/jhYC24xZ6zypIXUC8x2yGcNW24=;
        fh=V4cegHm3wAd5NN0u0F1ib0p38vbp19KSvDK2AQplrfI=;
        b=aCY2+sPVP2gJKpOl3aBlyE3g/3RNy/F3n8z1OBwO6L9hV++7vLwggPjoixpGDsQ7pU
         gKcH1XigIGQXWdo+5WXD2FVgDw7tCcmqez84X9/5chDMhLcYnHye23slOf3kb1kkK7Ek
         XuNoQj7sG4ombR556L6c+GjJ/IaZzMGUNMugq8TGBPOYRloUYjISvlL7nbBvR0Z4PGC+
         nKMOnGyXoakUzaIqBmLxZ39vmGxr0siHvNEvsZO940iONKsdPPXIOCoV3xV1KihsOb5s
         ChogVlzAcMh3dhi7G6GwuwGxLp8DfnkqwgL0s6l/BoFXHOGyoJFButHDXjf26LuN1MH9
         zKgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769803904; x=1770408704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqTERH/+2h6DWpnL/jhYC24xZ6zypIXUC8x2yGcNW24=;
        b=ZyE31yWNSqzEjtKHvg3//CTFyIXR+qPm2f22n6bCJas3JQ8lwMlI8z7DUDGlv51Q7a
         Il4eLZpdm2j6G2DEGsngfTjuOJnUP//5HDi5ibQKxul/deEwowBgJvE240m9MgnsQr5N
         0cG+MnocgRWkgHUfnArhtditIY6yh0f1hn/iIMCpMBh66VN6tgSgOls46pzR8bEVtOpW
         Ablj1bVl7jLnsXT5A9L1TxkwwJcn7xxkDZdaIE0h72UpVDlVCPV1vHNkGNOx3XkU7o60
         TBFuXZbqowEdU7OEAH7GA37OQVl/ntSG+FI55vaSbbUJv9AHAHjYK+BHHpucmcbavb/O
         CN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769803904; x=1770408704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqTERH/+2h6DWpnL/jhYC24xZ6zypIXUC8x2yGcNW24=;
        b=bWGYDORVPQVJCFOogGzwzrhH+i9e26mOSz/fe/F847My9vjyf0LPNK7CHY/z5S18pX
         FIaJDTCnsiiJowGBwiof9/WpypbwCAUHqt1UsS45aeYsJ4oeWZBXh8ypiIx6r4NEDgns
         tXn3bDXjt4tHpY1ZcllzlmBwbBQfSPBqFQR08lvGZNqyHzNxqlSgy/PeOHIoL+GoeZi6
         bFYE2eKTU+iF882nx2q8e9iMzt+unh3J1w1kiBhRZq7tD8l/KUeCk85FMm39f89oF0Qu
         JttPtxH1hpMcJ3++TYtXiJcr7ms7Xss9CzteHF0fyKbmIykGts+bkAc9SlIh5nPuyCKO
         KMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZFFubqZWKgPBI/7o5Mlu30H1qfQI5LqChpD+kXTvPjPBb3TfOXJFSN6aMZAAOunpxaCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkTZRUhpzsC3mf8UMIWCcfShWeWG43qRzJ81pp2xDrcnw5hkHC
	Mo6l4gVnqHArjfZXsAVMQnGkUIYq9TIfHJpVxG7Gb5edOaE7O3/2Q6DncVmheyc40l1xZFdAJoj
	SjQHPlM6qbWKq3FtvtRINg3GrUBvrytw=
X-Gm-Gg: AZuq6aKS08WjlM6YGQNSj0OL0WXDf8YnuUhQfLoh3teAvk3c4LlNe6wozRmHOdYHCRM
	msisvg2cieaxvR9Dkk3osRnbqltjCMH7e5iX41lElXpzUQpwsicor7rVmIdu6NcV98U1Ow38fd1
	ONg3YXzXw0KAcxbUUa5OfJNUp1NLpVXWCJ3rYOzMXTfflJOb94obutotAH/Q9wC9j3aFY0tYmIW
	y0vWXqLR6FwbtY92mxp81RrdN6AIo36+3CcBb7zZbZFSX/AxBGde5ddFLMZnB/ITaCA+UsdTzkn
	wptYXYJXyk4=
X-Received: by 2002:a17:90a:d2c6:b0:34a:a16d:77c3 with SMTP id
 98e67ed59e1d1-3543c3a6c21mr3874104a91.2.1769803904268; Fri, 30 Jan 2026
 12:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org> <202601301121.zr5U6ixA-lkp@intel.com>
In-Reply-To: <202601301121.zr5U6ixA-lkp@intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 12:11:31 -0800
X-Gm-Features: AZwV_Qj7wDya2OBtNs7PUmH8JcxUTODcuVx2e0LmJSjVryNSnlC4sk5utSn3GV0
Message-ID: <CAEf4BzZthAONGByqvk3pHRT3GaA8=fNbz+d1V1CY1N8sHEcsjA@mail.gmail.com>
Subject: Re: [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
To: akpm@linux-foundation.org
Cc: kernel test robot <lkp@intel.com>, Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, 
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, surenb@google.com, shakeel.butt@linux.dev, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 7:55=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Andrii,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/net]
> [also build test WARNING on bpf-next/master bpf/master linus/master v6.19=
-rc7]
> [cannot apply to akpm-mm/mm-everything next-20260129]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/pr=
ocfs-avoid-fetching-build-ID-while-holding-VMA-lock/20260130-055639
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
net
> patch link:    https://lore.kernel.org/r/20260129215340.3742283-1-andrii%=
40kernel.org
> patch subject: [PATCH v2 mm-stable] procfs: avoid fetching build ID while=
 holding VMA lock
> config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/202601=
30/202601301121.zr5U6ixA-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 11.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260130/202601301121.zr5U6ixA-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601301121.zr5U6ixA-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> Warning: lib/buildid.c:348 This comment starts with '/**', but isn't a=
 kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>     * Parse build ID of ELF file

So AI tells me to be a proper kernel-doc comment this should have been:

* build_id_parse_file() - Parse build ID of ELF file

Andrew, should I send v3 or you can just patch it up in-place? Thanks!


>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
