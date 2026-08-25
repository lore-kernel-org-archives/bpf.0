Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608C3F5BE3
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653343; cv=none; b=HxHMOnxoEkPMQIC2mS2AfOKzFSYWFsLa7x2oIi2RUrfx6J/tVleG7PrMfn2MB/2t00ClyYoeUEPde7VTCwFhjfO0bivO5NW7woJMwzeLJyzIqClVlwdV8L0XhbJmf/DJ8dp/uvnL3+iq9GBak79JJGMsO5EgvkSja/L9iWb1SnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653343; c=relaxed/simple;
	bh=bpyMKPh7/3WNSBuz427KUcFcISOpmmmELcZwiaD6o4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4/HoaRuiKcOGf4IOLgqRdqdq8DVrnhQbYMwb1KnuwFajXoBDtR8ngX4n3RHvcFEbStSkgP/e1RulWaxqVudOHo8jfTOAGUpYob3OVsQd9HXLX4J7FW+sYpmm1b39V37VvgNPgleGdq7rHnHYgMzunhla1MQgO40hsE5pVWyMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+hxX91T; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+hxX91T"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedf6a6fe8so3686275a12.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653342; x=1788258142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/gUh7XFtmJKxfjCV7HF7ELVXykDcyipXT3K2LjOMcIo=;
        b=i+hxX91TYZx3Nb/yOb3+WXaNQuO0jEqB2dJLhyHmRLvOjk5sqFLTeI8I8+1zlxp5lT
         61DU7P61Y98rEgnrNk21TqEdO7Re9Pyn0/fdPE2YyjOVpfovouIdsMsomxvBIJWdSjmZ
         6tOjtMgEU40ZyoGG5wcDdBCw445woXQMQ0ErZABRw8Tv+voB/SLEovFJl6zaLO6/WZcr
         zMzMk03keCLQ0L3XNx7IZIVp1SI70PuhbqoCOGkOI9QmjspunFyOtXAghvOJyoi1WT+w
         DO3uviYd7u+g94xL0zZH2Jd3UD7qgjcpZBbtW/sCuTnoIei49vUe3qXEXtfvBp4tj93h
         GVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653342; x=1788258142;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gUh7XFtmJKxfjCV7HF7ELVXykDcyipXT3K2LjOMcIo=;
        b=g6wzndpMc/7l+sDbQ2w56xC4j4QEKHtTFvWwwOdXzNkUuUv/rXb9HNfb4efmyEHdT5
         AegUQPxE3f2nOLLwhh8xdeMAAzg+a36+7ub2+SQbha6q3ZFOzX/IBQ9RI/mJXuBPy/Nm
         zu2sMrraH3q41BmJ8dbyw4xBUvmmVk34xuPSwqALMAL+du6sPAKEp3vx2zER7qIO1R8l
         GZt1705FOUY73IJhEWVzO6lcpUuBuBRv99Z3sBmu0pjVvAU+WM7TJ4OKuobf0T844YJr
         A9ogkUBmjl6odcEtYBf2gmPS9e/qziL1jd1t4knfve9UYebv5sVTn+AXDuU4QOmjr7NN
         ojDg==
X-Gm-Message-State: AFuF++mdQAJAQIKJ94bmtEGHIpFmOHbnyQZgr/NSotNwwCiL6UQ99tlB
	I+/MySHKrdJw9KlIVYKktFAnUO/T/+nDQO2hGCymPN+7Wjf+nGh7aUWfwa0p7Q==
X-Gm-Gg: AR+sD12f98mcoBeujMKVMPHBdcc/4fHETICrFIu3dg3+buzNan4H7L3hvyr+niGAhK2
	tgYpyP9pIhzhuu2rio/ZPsBOceQI7k3ahOhWdECVRZ/TU+fgWX+EN6GC9aJ1wqteS13z8Z66gv0
	7u554DMjWTws3kgVyIf1lr9tYiCYJZGz0ZS0oJpJta+y1E4h3JvTV5dij/FDxxHC38RQfJM/gHJ
	3C1Xbp9XYUYrZK2AMpJ4gwnB1wMZFGt9yrn89VsurDgf4233fVrKNN8T2TLnImGtz8zCa+vj0wV
	NC4AGKFHxBQmV7SSbLE0ov/fMvKbmFZiMX66IhjLX9bU+KfKYrM7dBVDjbZKMIbSaaW3IxzPdQt
	2v+ed4HKLdlUL7EPNNGFsMzDo6PAtkBU7QszrOWuokS1zcb/+UXXJ26k2c2PbcS+iD53cP2tRSd
	7m/fFhBkUxcjo4Mve8nNPW9elaINcrIrQCBngj5ZihTf1qHiGx+YfC4nxLcIKyxRJljSQkzy4RE
	pxOA1XmN773KKY5NK3f+0LN
X-Received: by 2002:a17:90a:d605:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-395df5e8fefmr48118718a91.16.1787653341676;
        Tue, 25 Aug 2026 03:22:21 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f923615asm35567646eec.29.2026.08.25.03.22.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 03:22:21 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org,
	jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Add a sleepable page allocator for map memory
Date: Tue, 25 Aug 2026 15:52:15 +0530
Message-ID: <20260825102215.83662-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825094955.83240-2-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-2-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the careful review. After tracing the call path in full,
this finding is a false positive. Here is the evidence:

alloc_pages_nolock() is implemented as alloc_frozen_pages_nolock_noprof()
in mm/page_alloc.c. Regardless of which gfp_flags the caller passes, the
implementation unconditionally ORs in __GFP_ZERO before calling
get_page_from_freelist():

  /* mm/page_alloc.c, alloc_frozen_pages_nolock_noprof() */
  gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC | __GFP_COMP
                  | gfp_flags;

The comment at that exact site makes the intent explicit:

  "Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() below
   is safe in any context. Also zeroing the page is mandatory for
   BPF use cases."

So even though __bpf_alloc_page() passes only __GFP_ACCOUNT to
alloc_pages_nolock(), the allocator enforces __GFP_ZERO unconditionally.
The returned page is always zeroed before being handed to the caller.
There is no path through which uninitialized kernel memory can be mapped
into a BPF arena.

The API documentation in include/linux/gfp.h also states that
__GFP_ACCOUNT is the only caller-supplied flag alloc_pages_nolock()
accepts, precisely because the implementation controls all others itself.

No code change is needed.

Khawar Ahemad <ahemadkhawar123@gmail.com>
