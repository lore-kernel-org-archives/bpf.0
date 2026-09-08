Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2F36F8E9
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788847719; cv=none; b=QDrEiH9908E6q9flRc8PacB1IxndXgQlUKC2BgSvLhA+AXKzbrq9+0SjQWIdWn6kL4pk52GutXfLS0o9s86+rVNxaevZlj9uGwIPgNU4rIbHUcIFphwpx3XmfWKGeSQWYRUxehZ4SnOZd1t1GCTr+bUV5g4W8Zv/wXlBTNVBQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788847719; c=relaxed/simple;
	bh=uCmsMBCDrsY2CSXZlcugqtfnFjXUOVptSDX6rZ54Kqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9kSxQUeeHkbJkmsM+lQlMYqkN2BWGEijk/IkYJPZ60tNf/CbVUN8CJS/OSxVA6lZWUgFxraFlaEgRm/PjYnH6e7D7kg4COKWclVpnO8/yFaQ2ULuJSP8HFffiwQsbxxe3gw/8e4Gs4UNkGa8Y+S8bY0moc4NgzNncrM/EBXyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJPcHTEB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJPcHTEB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso4604122a91.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 23:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788847718; x=1789452518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PazSmK9CIewfru0eTOp5da7ZxmX1DEtx5wd1EeqAqF8=;
        b=fJPcHTEB8SvlLcT1XcxoLogknt1QB+63j5RrVzAZ21dPjSd45y8DUKsNSbt6qLfrhF
         HPsOhFLh8rvJ0AtGNTHHkFHTkVorZSh8bWFQtOsxdCc7j8H/GN0juZdheGHZyFiOY675
         Rxua74SQl6tlldD0syTxw0o0h0wlwl45uyXEha77S2tDsfoWvzFzOsPpk5Xtr9/EBesm
         OrkaBOo581EbXDEFlJlddsvAINS20ix6z7MctwFNpuXI+bu8jIQ/gsRCeT7I8F4fHo9g
         El73brS044KPaNQqa2Ayx3Q/3Pcf45nDD+ZbD1hvNms6sZbH5Aykdq52gqVdGXDfw7Up
         9DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788847718; x=1789452518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PazSmK9CIewfru0eTOp5da7ZxmX1DEtx5wd1EeqAqF8=;
        b=UgsoVDK9oxTGyj7TgMkuMdkXlGNnBs+m5QboT2WuoQyy8cQ6GhCsukK261PKguB4uF
         KeuNnZbkW1kFaaIGcAfUYKHoecbwAXh96VDpNzpD1JP3Lv7a9cX79b0bNQwpozyZgfU2
         EGq3d/aKWTw6ruIeCL9p2XDsNMy4+TrNUjrBM3NNGa709CKUrVbSV3ihDnAGv132SZKT
         qQMlTxD0oO94t0iRbge/N4HTjF8W1b70xeOwF2cB00BfFVRsl4TbblLkpSazjA6oYXZ1
         4iehDEVsa6CXsrlZEkj79Qg2gNe6vsWmC6/RRJcvO+G4ecPtUiqbvDibOZo7ST2+cg9y
         N6/A==
X-Forwarded-Encrypted: i=1; AKwUvBzGg3PIwGE/9CygChw+uIFFUc/qgMCNIbZGThhQLc9iEm+AKyhwX+8vD+LUgRka8Wv7RlM=@vger.kernel.org
X-Gm-Message-State: AFuF++nSawOOB20UUV1vpYx2OrQlM1Uzcr8Jt5WTef8/WHf0JOjWVk9W
	mFBSIu6MkIJd4EuS+wyYT6ImX54y5ZPqPjMUT4as6/4XcD/tgLTGFuaP
X-Gm-Gg: AYBFou1u9FuKpaqbYFUcP69lUWAXRJFeVDe+yJFnM6XPaVgPrjgQOFmle+g9CTrjhuN
	M/vrdSYl2gqla6ACrNxi5mViLQZle07W/lFOfAIbv6KyTZUpH+EBdGmhB82yPizE8QENWo2+Cue
	BgY99BhNWvIFNvVPYvjYUsru2Ecb+mwAhhjbjJqKWnxRMeVm/OAsDmY9NPoQ7ysFZpYUbMIbaVN
	eH8BGUcjQp1LTXAyUqoZEIULBBY19vcqYSPbeP7nRj6hqkAANzhEVuXmJsKKEAp50F91JvZ3d92
	4B+HsIQDJSu+ljgA1OcKL9XU8Fl+Rg8/QCTIsketX43VmEzbRfVWDOogt9nSOLCzXbKRfrnI8Tr
	F2l4vQlPVD+RrR6q9UBwEeHLWtaxj2d72rAgckUZk8+pyQ+1KHCnoLTwiYDyitqmV33BkSnb8nE
	+IgMTI9eLlvczUzo/z21T9z0VonAhwTCT/ZPWzxqO/6RtEVIR5IcWxai/+v+qJGXuJFq/UcGS5W
	HEzov9eu5miBQ==
X-Received: by 2002:a17:90b:39ab:b0:398:9be8:ea68 with SMTP id 98e67ed59e1d1-39b261da75cmr41792101a91.21.1788847717793;
        Mon, 07 Sep 2026 23:08:37 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14344a86512sm8501320c88.10.2026.09.07.23.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:08:37 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: kernel-ci@meta.com
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/7] bpf: fix typos and repeated words in comments
Date: Tue,  8 Sep 2026 11:38:32 +0530
Message-ID: <20260908060832.32175-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <01b5453944b3f5259e123e7684a6b6acc60cab31bb258bc7dad31adc5e294984@mail.kernel.org>
References: <20260908054853.13820-1-hemanth.selam@gmail.com> <01b5453944b3f5259e123e7684a6b6acc60cab31bb258bc7dad31adc5e294984@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 08, 2026 at 05:53:53AM +0000, bot+bpf-ci@kernel.org wrote:
> CI has tested the following submission:
> Status:     CONFLICT
> Name:       [bpf-next,v4,0/7] bpf: fix typos and repeated words in comments
> PR:         https://github.com/kernel-patches/bpf/pull/13699
>
> Please rebase your submission onto the most recent upstream change and resubmit
> the patch to get it tested again.

I resent this as v4 rebased onto bpf-next in response to the same report
on v3, and it came back CONFLICT again, so I would rather ask than keep
resending the same content.

The series applies cleanly here on all three of:

  bpf-next master                          1b7415bf70be
  kernel-patches/bpf bpf-next_base
  kernel-patches/bpf bpf-next

with git am and no fuzz, all seven patches.

Looking at the pull requests the bot opened, the base branch does not
look like the bpf-next one:

  v2  PR 13680  base bpf_base       head series/1159292=>bpf
  v3  PR 13685  base bpf-net_base   head series/1159712=>bpf-net
  v4  PR 13699  base bpf-net_base   head series/1160154=>bpf-net

and all three report changed_files: 0, which suggests the series is not
being applied rather than that it conflicts with something.

The subject is tagged [PATCH bpf-next v4].  The series does touch
arch/{arm,powerpc,sparc}/net/bpf_jit*, so if the target tree is picked
up from the paths or from the "net:" in some of the patch subjects, that
might be what is sending it to the bpf/net branches.

Is there anything I should change on my side?  Happy to retitle the arch
patches or split them out if that helps the routing.  Otherwise the
content is unchanged from v3 and I would rather not post a v5 just to
retrigger CI.

Thanks,
Hemanth
