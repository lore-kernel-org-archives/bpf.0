Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B2483BC0
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786647; cv=none; b=PCjPN0MZhtIyYuIjbaAGvTajA5ocSjuqTqr+qFKPL4JQqHQ88Y/v5wQ2q07htoIErt+99WVlTPJ0DLXVVmEQxOG/8OCpzeul0/ngmULBlWKUuSlfOQefMs1JR9sjoBjYU6Es+OeniVO+iiLPoVXUBI69gmgZhmMptjA1XaS9Aoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786647; c=relaxed/simple;
	bh=YG61/C7iDhzLNyVfEFLjtC9ISDCVwnukOEROhaZnVdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXG81AoogiJ3+43aRkmdZ1XEiMtlVfSNUIMr23rIw3gCQ9P709h+BHvucF1SRqIg0kik0nGJ1XZRMMhS/oL8laydSvKnzaLhCJjI3ZCH1oRDIt7PXeoRwgtmhJsOK/YQZO3I/0goFj+D8HiHj3AHMhlRHxe18/szdxAgRo8Yj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVc3/MTH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVc3/MTH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so36941035ad.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786641; x=1789391441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oSPDVYy4Q8iv02NTcCgkGj7VmrXxwUyQwqSFODFlyrI=;
        b=DVc3/MTH7TQA4/ytZjpLIJ8JKRuQ5J4xY3b0UQxvLQPXkKyum7fbO8uzxp5LPFCaJV
         Cc2iYYQHlw3hBtCg+qaWAQ/trv0m1Z50xPJak6ERG2ZgSD7xwbL9EYkOLp9e47eAGOHq
         pceU+ZKaWi1IKa8fqOugKy7QgjZfu/KBpfu2kE8uMFcy/MrAd8ztgHsZPXxwSbmDqpWk
         mOazr733i/ssL9QcDEPf7wA3dODS1ovGtSnWdx78ZQ7LTNMxfFV+jkgQ0mhl/i+zHpjS
         IcpRxHHYEkL5l6FgaEhjobCXr/i4LoBgaZ23Lw2xpOuaO4SZglSbo28GNm9in90znWZB
         z2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786641; x=1789391441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oSPDVYy4Q8iv02NTcCgkGj7VmrXxwUyQwqSFODFlyrI=;
        b=WMqRN0pxDh+gudV8CFjFRcKcxOgnMDV8KzAN4wQBxv8qYhIRgek+Zk/gNGiM1zh149
         jd0J+UEQVMiKyFgvfUpXhKc3fgTX7WA4N5vL4C4W8KBsanB4nN9xjdxVEFEM+v1rvMJy
         mPuOHZpWR1LVlu23lcQcbMpO8Yzr13YMxkLkucpe919PXU3XR9TUHOYRXgq9lg/SLs4F
         AI528Bi+LB5qupjLfDAjdB62oGKaS5MVoZXBThQZlY++OwfAZ9V4+G9ZZO3BXBJxtn0F
         UKMZ80HT7mHt+ZZXpYEpB8G8qh1SOIzAAwBSGm54QqVK59HHstkfYvz+L5Rf72MC06wU
         ZMgQ==
X-Gm-Message-State: AFuF++kVTGUPmATHo2pi96YH1prRxF8ZGE3S6UIchkv4aQXtNgeI6RPi
	bMyUtrVZUBB2G60YvkYIp2t8/g7ls2PPHAEJuyFmAfD6Q2f+CaAarLgRIXFdLXzzcN/gvg==
X-Gm-Gg: AYBFou0tCDbgK/PCz9fdkLBgVepF95ZsItLDYsMPuQF6l7DN2zhaFY5t/EuA98Xu2oP
	lw/soC+LAn5idS0ypJoliF40RbWZ4rCV6T1yOsRkJQgTQ7DZidV3fyvvdrjv0T3YicZssPu6esp
	jd87vla9BW3wVtMlWWq8bIbs2yXHIb1Z3HEzLszqsrH5N4NkuUI2/pt8/veLO/y4hMH4cPr7OAv
	khQOPLOd0fELqmaC+yzAh+I9iqm7q/esCfNjka4X+vJecaZNSDJNA/EE+uTD5iQUSpInQXNvr7+
	B2GeYGPv4sxefZiT3dskoHgMh3iNP4jbTIQBLN/urt2UAOOHAVBN7klJGPl1vW8VwclhNzY40gx
	3b2e31PSDoukiZ6HG42ThvxXV7WY1Sz/8Vs0gBbtWFnTWxI3bM/+c0xDiq0Jbdk0HExVTe6ZNFy
	Fw7DwvNjgFSDk/h7XhENbO8LKIm+isQe01IyMwpishU/vMN/EMdjkmP3+24cA4D7D9Y48MANPsb
	2Mf2me8sJplDyQALBLEjQ1Z4Qg=
X-Received: by 2002:a17:90b:3c48:b0:398:e436:384 with SMTP id 98e67ed59e1d1-39b260d335dmr35524339a91.1.1788786641030;
        Mon, 07 Sep 2026 06:10:41 -0700 (PDT)
Received: from HKG-A3-RJYWAR2VC4M5B7A1.. ([140.245.43.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm27853445eec.12.2026.09.07.06.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:10:40 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf 0/2] libbpf: Fix array comparison in BTF dedup
Date: Mon,  7 Sep 2026 13:10:19 +0000
Message-ID: <20260907131021.34343-1-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com>
References: <CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow up on "[BUG] libbpf: BTF dedup merges arrays with different element
types" with a fix and selftest as two patches.

Report: https://lore.kernel.org/bpf/CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com/

Validation with a focused runner using the existing selftest sources and
assertions:
- All 52 selected existing BTF cases passed before and after the fix.
- The new negative case failed before the fix and passed afterwards.
- The new positive case passed before and after the fix.
- One module test was skipped because bpf_testmod was unavailable.

The full test_progs suite was not run.

Mingpei CAO (2):
  libbpf: Fix array comparison in BTF dedup
  selftests/bpf: Test array element comparison in BTF dedup

 tools/lib/bpf/btf.c                           |  2 +-
 .../selftests/bpf/prog_tests/btf_dedup.c      | 68 +++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_dedup.c


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.43.0
